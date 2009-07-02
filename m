Return-Path: <eemingliu@hotmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 0B075B70FF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jul 2009 03:50:32 +1000 (EST)
Received: from col0-omc2-s3.col0.hotmail.com (col0-omc2-s3.col0.hotmail.com
	[65.55.34.77]) by ozlabs.org (Postfix) with ESMTP id 17230DDDA0
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Jul 2009 03:50:30 +1000 (EST)
Message-ID: <COL107-W5372858231522587839F1CB22F0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_d3bb6cf0-c3b6-46a3-aa8b-5b173721d486_"
From: LiuMing <eemingliu@hotmail.com>
To: <lada.podivin@gmail.com>
Subject: RE: ppc405ex + gigabit ethernet
Date: Thu, 2 Jul 2009 17:50:29 +0000
In-Reply-To: <e35801cc0907010424l66a7c4dem6f3f363c3b194ff4@mail.gmail.com>
References: <e35801cc0906300658q45d5ea00ub939ba73185efd72@mail.gmail.com>
	<COL107-W41E84129BE81739BC96295B22E0@phx.gbl>
	<e35801cc0907010424l66a7c4dem6f3f363c3b194ff4@mail.gmail.com>
MIME-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_d3bb6cf0-c3b6-46a3-aa8b-5b173721d486_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Yes. If you enable jumbo frames, the results will be definitely better. My result is with jumbo frame of 8982 enabled. 

 

If you say your CPU is 600 MHz, I guess there is still potential for you to improve the speed. In our case we had only 300 MHz and got a similar value of yours. Of course, there are many other issues which can be enabled to improve the performance, such as interrupt coaleasing, hardware checksum processing, etc.. Since we used Xilinx FPGA with embedded PowerPC and HW TEMAC, some work can be done with FPGA hardware resources. I don't know your case and it's hard to say how can you further improve. 

 

BR

Ming
 


Date: Wed, 1 Jul 2009 13:24:41 +0200
Subject: Re: ppc405ex + gigabit ethernet
From: lada.podivin@gmail.com
To: eemingliu@hotmail.com
CC: linuxppc-dev@ozlabs.org

Thank you for your reply!
Yes, I agree the CPU is the bottleneck. But I have performed more tests with the netperf tool and results seem strange to me. If I send 800 B of data, the resulting speed is aproximately 100 Kb/s. On the other hand, If I try to send 32KB chunk of data with jumbo frames turned on, resulting speed is about 600 Kb/s (300-400 without jumbo frames). My ppc405ex runs at 600 MHz.

So it seems that it is definetely better idea to call sendto() less frequently with bigger amounts of data, than to call it more often with smaler amounts. Is it because smaller data means more frequent user space/kernel space switching? Or is it network related issue?  

Thanks!

Best,
Lada


2009/7/1 LiuMing <eemingliu@hotmail.com>


Hi,
According to our experience on PPC405 + Gigabit Enet, your result is already very reasonable. For UDP transmission, it can be around 400 Kb/s because of the CPU bottleneck (in our case 300 MHz ppc405). If you want to further improve it, a faster CPU is needed to process the TCP/IP stack, or you may buy commercial TCP/IP stack rather than using the free Linux one. 
 
BR
Ming
 


Date: Tue, 30 Jun 2009 15:58:53 +0200
Subject: ppc405ex + gigabit ethernet
From: lada.podivin@gmail.com
To: linuxppc-dev@ozlabs.org




Hi,

I benchmarked performance of my network, which contains ppc405EX (Kilauea board, kernel 2.6.30 from Denx) connected with a linux desktop via gigabit ethernet. I used the netperf tool: 

netperf -t UDP_STREAM -H 192.168.1.1 -- -m 32768

So I was sending UDP packets to the desktop. The resulting speed was about 370 Kb/s. I tried to send the packets to several different computers - with the same result. So the ppc board is the bottleneck in this case.

Is there any possibility to improve the gigabit capabilities of the ppc405EX? Is there anyone who achieved a better performance with ppc4xx boards?

Thanks!

Best,
Lada Podivin





立刻下载 MSN 保护盾，保障 MSN 安全稳定！ 现在就下载！

_________________________________________________________________
Messenger安全保护中心，免费修复系统漏洞，保护Messenger安全！
http://im.live.cn/safe/
--_d3bb6cf0-c3b6-46a3-aa8b-5b173721d486_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style>
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 10pt;
font-family:Verdana
}
</style>
</head>
<body class='hmmessage'>
Yes. If you enable jumbo frames, the results will be definitely better. My result is with jumbo frame of 8982 enabled. <BR>
&nbsp;<BR>
If you say your CPU is 600 MHz, I guess there is still potential for you to improve the&nbsp;speed. In our case we had only 300 MHz and got a similar value of yours. Of course, there are many other issues which can be enabled to improve the performance, such as interrupt coaleasing,&nbsp;hardware checksum processing, etc.. Since we&nbsp;used Xilinx FPGA with embedded PowerPC and HW TEMAC, some work can be done with FPGA hardware resources. I don't know your case and it's hard to say how can you further improve. <BR>
&nbsp;<BR>
BR<BR>
Ming<BR>&nbsp;<BR>
<HR id=stopSpelling>
Date: Wed, 1 Jul 2009 13:24:41 +0200<BR>Subject: Re: ppc405ex + gigabit ethernet<BR>From: lada.podivin@gmail.com<BR>To: eemingliu@hotmail.com<BR>CC: linuxppc-dev@ozlabs.org<BR><BR>Thank you for your reply!<BR>Yes, I agree the CPU is the bottleneck. But I have performed more tests with the netperf tool and results seem strange to me. If I send 800 B of data, the resulting speed is aproximately 100 Kb/s. On the other hand, If I try to send 32KB chunk of data with jumbo frames turned on, resulting speed is about 600 Kb/s (300-400 without jumbo frames). My ppc405ex runs at 600 MHz.<BR><BR>So it seems that it is definetely better idea to call sendto() less frequently with bigger amounts of data, than to call it more often with smaler amounts. Is it because smaller data means more frequent user space/kernel space switching? Or is it network related issue?&nbsp; <BR><BR>Thanks!<BR><BR>Best,<BR>Lada<BR><BR>
<DIV class=EC_gmail_quote>2009/7/1 LiuMing <SPAN dir=ltr>&lt;<A href="mailto:eemingliu@hotmail.com">eemingliu@hotmail.com</A>&gt;</SPAN><BR>
<BLOCKQUOTE class=EC_gmail_quote style="PADDING-LEFT: 1ex">
<DIV>Hi,<BR>According to our experience on PPC405 + Gigabit Enet, your result is already very reasonable. For UDP transmission, it can be around 400 Kb/s because of the&nbsp;CPU bottleneck (in our case 300 MHz ppc405). If you want to&nbsp;further improve it, a faster CPU is needed to process the TCP/IP stack, or you may buy&nbsp;commercial TCP/IP stack&nbsp;rather than using the free Linux one. <BR>&nbsp;<BR>BR<BR>Ming<BR>&nbsp;<BR>
<HR>
Date: Tue, 30 Jun 2009 15:58:53 +0200<BR>Subject: ppc405ex + gigabit ethernet<BR>From: <A href="mailto:lada.podivin@gmail.com">lada.podivin@gmail.com</A><BR>To: <A href="mailto:linuxppc-dev@ozlabs.org">linuxppc-dev@ozlabs.org</A>
<DIV>
<DIV></DIV>
<DIV class=h5><BR><BR>Hi,<BR><BR>I benchmarked performance of my network, which contains ppc405EX (Kilauea board, kernel 2.6.30 from Denx) connected with a linux desktop via gigabit ethernet. I used the netperf tool: <BR><BR>netperf -t UDP_STREAM -H 192.168.1.1 -- -m 32768<BR><BR>So I was sending UDP packets to the desktop. The resulting speed was about 370 Kb/s. I tried to send the packets to several different computers - with the same result. So the ppc board is the bottleneck in this case.<BR><BR>Is there any possibility to improve the gigabit capabilities of the ppc405EX? Is there anyone who achieved a better performance with ppc4xx boards?<BR><BR>Thanks!<BR><BR>Best,<BR>Lada Podivin<BR><BR><BR></DIV></DIV>
<DIV class=EC_hm>
<HR>
立刻下载 MSN 保护盾，保障 MSN 安全稳定！ <A href="http://im.live.cn/safe/">现在就下载！</A></DIV></DIV></BLOCKQUOTE></DIV><BR><br /><hr />使用新一代 Windows Live Messenger 轻松交流和共享！ <a href='http://im.live.cn/messenger.aspx' target='_new'>立刻下载！</a></body>
</html>
--_d3bb6cf0-c3b6-46a3-aa8b-5b173721d486_--
