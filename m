Return-Path: <Rick.Moleres@xilinx.com>
Received: from mail15-dub-R.bigfish.com (mail-dub.bigfish.com [213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 91E41DDF0A
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Nov 2007 03:30:12 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C82224.9936303F"
Subject: RE: ML405 gigabit ethernet with kernel 2.6.23
Date: Thu, 8 Nov 2007 09:29:52 -0700
In-Reply-To: <BAY138-W3232BA0AE8C193E22B5011B28B0@phx.gbl>
References: <4732719A.20707@triumf.ca>
	<BAY138-W3232BA0AE8C193E22B5011B28B0@phx.gbl>
From: "Rick Moleres" <Rick.Moleres@xilinx.com>
To: "MingLiu" <eemingliu@hotmail.com>, "kentaro" <kentaro@triumf.ca>,
	<linuxppc-embedded@ozlabs.org>
Message-Id: <20071108162959.3AA52DD8066@mail15-dub.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C82224.9936303F
Content-Type: text/plain;
	charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit

Hi,

 

Yes, for 1500 MTU these aren’t too bad.  One thing to note, using the TCP_STREAM option does not take advantage of zero-copy and possibly checksum offload on the transmit side.  You should use the TCP_SENDFILE option for that.  We typically use options such as:

 

            netperf -c -C -H 192.168.1.1 -t TCP_STREAM -- -s131072 -S131072 -m65536

            netperf -c -C -H 192.168.1.1 -t UDP_STREAM -- -s131072 -S131072 -m8192 (if using jumbo frames of 8982)

 

-Rick

________________________________

From: linuxppc-embedded-bounces+moleres=xilinx.com@ozlabs.org [mailto:linuxppc-embedded-bounces+moleres=xilinx.com@ozlabs.org] On Behalf Of MingLiu
Sent: Thursday, November 08, 2007 2:32 AM
To: kentaro; linuxppc-embedded@ozlabs.org
Subject: RE: ML405 gigabit ethernet with kernel 2.6.23

 

Dear Kentaro,

> -------------------------------------------------------------
> "netperf -H 192.168.1.1 -t TCP_STREAM" 110 Mbps
> "netperf -H 192.168.1.1 -t UDP_STREAM" 210 Mbps
> -------------------------------------------------------------

Are these results the ones with or without Jumbo-frame enabled? If no, they are quite good I think. The results from Montavista probably are the ones with Jumbo-frame enabled. 
 
For anybody who has interest on this topic, I have recently an accepted paper which has part of the content on this. The link is http://web.it.kth.se/~mingliu/publications/co_design(icfpt07).pdf and in 6.2 section, I listed our measurement results. 300Mbps for TCP and 400Mbps for UDP, with Jumbo-frame enabled. Unfortunately I did not explain the details and detailed configurations on our case. So these results are only for your reference.
 
BR
Ming

________________________________

用 Windows Live Spaces 展示个性自我，与好友分享生活！ 了解更多信息！ <http://spaces.live.com/?page=HP> 


------_=_NextPart_001_01C82224.9936303F
Content-Type: text/html;
	charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit

<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-2022-jp">
<html xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:w="urn:schemas-microsoft-com:office:word" xmlns="http://www.w3.org/TR/REC-html40">

<head>

<meta name=Generator content="Microsoft Word 11 (filtered medium)">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:SimSun;}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:blue;
	text-decoration:underline;}
p
	{mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:SimSun;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=EN-US link=blue vlink=blue>

<div class=Section1>

<p class=MsoNormal><font size=2 color=navy face=Arial><span style='font-size:
10.0pt;font-family:Arial;color:navy'>Hi,<o:p></o:p></span></font></p>

<p class=MsoNormal><font size=2 color=navy face=Arial><span style='font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=MsoNormal><font size=2 color=navy face=Arial><span style='font-size:
10.0pt;font-family:Arial;color:navy'>Yes, for 1500 MTU these aren’t too
bad.&nbsp; One thing to note, using the TCP_STREAM option does not take
advantage of zero-copy and possibly checksum offload on the transmit
side.&nbsp; You should use the TCP_SENDFILE option for that.&nbsp; We typically
use options such as:<o:p></o:p></span></font></p>

<p class=MsoNormal><font size=2 color=navy face=Arial><span style='font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=MsoNormal><font size=2 color=navy face=Arial><span style='font-size:
10.0pt;font-family:Arial;color:navy'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; netperf
&#8211;c &#8211;C &#8211;H 192.168.1.1 &#8211;t TCP_STREAM -- -s131072 &#8211;S131072 &#8211;m65536<o:p></o:p></span></font></p>

<p class=MsoNormal><font size=2 color=navy face=Arial><span style='font-size:
10.0pt;font-family:Arial;color:navy'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; netperf
&#8211;c &#8211;C &#8211;H 192.168.1.1 &#8211;t UDP_STREAM -- -s131072 &#8211;S131072 &#8211;m8192 (if using jumbo
frames of 8982)<o:p></o:p></span></font></p>

<p class=MsoNormal><font size=2 color=navy face=Arial><span style='font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=MsoNormal><font size=2 color=navy face=Arial><span style='font-size:
10.0pt;font-family:Arial;color:navy'>-Rick<o:p></o:p></span></font></p>

<div>

<div class=MsoNormal align=center style='margin-left:.5in;text-align:center'><font
size=3 face=SimSun><span style='font-size:12.0pt'>

<hr size=2 width="100%" align=center tabindex=-1>

</span></font></div>

<p class=MsoNormal style='margin-left:.5in'><b><font size=2 face=Tahoma><span
style='font-size:10.0pt;font-family:Tahoma;font-weight:bold'>From:</span></font></b><font
size=2 face=Tahoma><span style='font-size:10.0pt;font-family:Tahoma'>
linuxppc-embedded-bounces+moleres=xilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+moleres=xilinx.com@ozlabs.org] <b><span
style='font-weight:bold'>On Behalf Of </span></b>MingLiu<br>
<b><span style='font-weight:bold'>Sent:</span></b> Thursday, November 08, 2007
2:32 AM<br>
<b><span style='font-weight:bold'>To:</span></b> kentaro;
linuxppc-embedded@ozlabs.org<br>
<b><span style='font-weight:bold'>Subject:</span></b> RE: ML405 gigabit
ethernet with kernel 2.6.23</span></font><o:p></o:p></p>

</div>

<p class=MsoNormal style='margin-left:.5in'><font size=3 face=SimSun><span
style='font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=MsoNormal style='mso-margin-top-alt:0in;margin-right:0in;margin-bottom:
12.0pt;margin-left:.5in'><font size=1 face=Tahoma><span style='font-size:9.0pt;
font-family:Tahoma'>Dear Kentaro,<br>
<br>
&gt; -------------------------------------------------------------<br>
&gt; &quot;netperf -H 192.168.1.1 -t TCP_STREAM&quot; 110 Mbps<br>
&gt; &quot;netperf -H 192.168.1.1 -t UDP_STREAM&quot; 210 Mbps<br>
&gt; -------------------------------------------------------------<br>
<br>
Are these results the ones with or without Jumbo-frame enabled? If no, they are
quite good I think. The results from Montavista probably are the ones with
Jumbo-frame enabled. <br>
&nbsp;<br>
For anybody who has interest on this topic, I have recently an accepted paper
which has part of the content on this. The link is <a
href="http://web.it.kth.se/~mingliu/publications/co_design(icfpt07).pdf">http://web.it.kth.se/~mingliu/publications/co_design(icfpt07).pdf</a>&nbsp;and
in 6.2 section, I listed our measurement results. 300Mbps for TCP and 400Mbps
for UDP, with Jumbo-frame enabled. Unfortunately I did not explain the details
and detailed configurations on our case. So these results are only for your
reference.<br>
&nbsp;<br>
BR<br>
Ming<o:p></o:p></span></font></p>

<div class=MsoNormal align=center style='margin-left:.5in;text-align:center'><font
size=1 face=Tahoma><span style='font-size:9.0pt;font-family:Tahoma'>

<hr size=2 width="100%" align=center>

</span></font></div>

<p class=MsoNormal style='margin-left:.5in'><font size=1 face=SimSun><span
lang=ZH-CN style='font-size:9.0pt'>用</span></font><font size=1 face=Tahoma><span
style='font-size:9.0pt;font-family:Tahoma'> Windows Live Spaces </span></font><font
size=1><span lang=ZH-CN style='font-size:9.0pt'>展示个性自我，与好友分享生活！</span></font><font
size=1 face=Tahoma><span lang=ZH-CN style='font-size:9.0pt;font-family:Tahoma'>
</span></font><font size=1 face=Tahoma><span style='font-size:9.0pt;font-family:
Tahoma'><a href="http://spaces.live.com/?page=HP" target="_new"><font
face=SimSun><span lang=ZH-CN style='font-family:SimSun'>了解更多信息！</span></font></a><o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C82224.9936303F--
