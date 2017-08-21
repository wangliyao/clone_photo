require 'nokogiri'
require 'http'
require 'pry'


if ARGV[0] != nil
  binding.pry
  name = ARGV[0]
  body = HTTP.get(name).body
  ans = []
  while body != ''
    html = body.readpartial
    if html ==nil
      break;
    end
    doc = Nokogiri::HTML(html)
    doc.search('img').each do |i|
      ans << i.attr('src') if i.attr('src') != nil
    end
  end
#将相对路径改为绝对路径
# temp_ans = ans.map do  |url|
#    url.gsub('http://desk.fd.zol-img.com.cn','http://desk.fd.zol-img.com.cn/') if url != nil
# end
#透过wget 下载档案到当前文件夹
  ans.each do |full_url|
    #system "mkdir #{Dir.getwd}/photo "
    cmd = system "wget -r #{Dir.getwd}/ #{full_url}"
    puts '-' * 20
    p cmd
  end
  puts 'success'
else
  puts 'no success'
end

