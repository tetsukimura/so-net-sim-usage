#!/usr/bin/env ruby

require 'rubygems'
require 'mechanize'
require 'nokogiri'

userid   = ENV['userid']
password = ENV['password']

if userid == nil || password == nil then
  puts "userid and password must be specified in environment variable"
  exit
end

login_url = "https://www.so-net.ne.jp/retail/u/login?realm=/retail/retail_userweb"


agent = Mechanize.new
login_page = agent.get(login_url)


form = login_page.forms[0]
form.IDToken1 = userid
form.IDToken2 = password
page1 = agent.submit(form)

form = page1.form_with(:name => "userUsageActionForm")
page2 = agent.submit(form)

e = Nokogiri::HTML(page2.body).xpath('//dl[@class="useConditionDisplay"]')

puts e.children[0].text.strip + ": " + e.children[2].text.strip.gsub(/[\r|\n|\t ]*/,"")
puts e.children[4].text.strip + ": " + e.children[6].text.strip.gsub(/[\r|\n|\t ]*/,"")
puts e.children[8].text.strip + ": " + e.children[10].text.strip.gsub(/[\r|\n|\t ]*/,"")
puts e.children[12].text.strip + ": " + e.children[14].text.strip.gsub(/[\r|\n|\t ]*/,"")

