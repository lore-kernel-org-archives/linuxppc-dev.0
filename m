Return-Path: <lfx@cypress.com>
Received: from ns1.cypress.com (ns1.cypress.com [157.95.67.4])
	by ozlabs.org (Postfix) with ESMTP id 92B13DDF31
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Feb 2008 03:40:41 +1100 (EST)
Received: from corpmail.cypress.com (corpmail [157.95.1.2])
	by ns1.cypress.com (8.12.10/8.12.10) with ESMTP id m1JGUHOJ004986
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Feb 2008 08:30:17 -0800 (PST)
Received: from mailhost.isd.cypress.com (mailhost.isd.cypress.com
	[172.19.2.11])
	by corpmail.cypress.com (8.12.10/8.12.10) with ESMTP id m1JGZ79p029544
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Feb 2008 08:35:07 -0800 (PST)
Received: from lfxvmxp (lfxvmxp.isd.cypress.com [172.19.2.243])
	by mailhost.isd.cypress.com (8.12.2/8.12.2) with ESMTP id
	m1JGYvvm001500 for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Feb 2008 09:34:58 -0700 (MST)
From: "Marc LeFevre" <lfx@cypress.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: RTC woes
Date: Tue, 19 Feb 2008 09:34:52 -0700
Message-ID: <06cb01c87315$5dad6010$f30213ac@isd.cypress.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_06CC_01C872DA.B14E8810"
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

------=_NextPart_000_06CC_01C872DA.B14E8810
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi:

I'm new to the list.  I have an e500-based embedded Linux system running a
2.6.22 kernel.  I have a PCF8563T i2c based RTC chip attached to the PPC i2c
bus.  In my kernel config file I have selected CONFIG_RTC_INTF_DEV=y and
CONFIG_RTC_DRV_PCF8563=y.  I do a mknod  for /dev/rtc as c 10 135 (standard
Linux) and link /dev/rtc0 to it.

 

When I boot, get the following message:

 

drivers/rtc/hctosys.c: unable to open rtc device (rtc0)

 

and, of course I cannot access /dev/rtc after booting.  I can, however, talk
to the rtc if I use /dev/i2c and a generic i2c read and write utility.

 

When I look in /proc/devices, I see that rtc has taken major number 254
which puzzles me. RTC should not need a dynamic major number, right?  I have
perused the drivers in linux/drivers/rtc and don't find any of them calling
register_chrdev() to get a dynamic major number.  So here are my questions:

 

1)       Shouldn't rtc automagically use major/minor 10/135?

2)       How can I find where in the source it asks for a dynamic major
number?

3)       Does the PPC have some quirks regarding i2c operation that are at
the root of this problem?

 

BYW, I tried making the rtc device file as c 254 0 to match what's in
/proc/devices and that gives me the same bejavior.

 

Thanks in advance for any help you can offer.

 

Marc

 


------=_NextPart_000_06CC_01C872DA.B14E8810
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 @list l0
	{mso-list-id:1875339321;
	mso-list-type:hybrid;
	mso-list-template-ids:1882371854 67698705 67698713 67698715 67698703 =
67698713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-text:"%1\)";
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hi:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I&#8217;m new to the list.&nbsp; I have an e500-based =
embedded
Linux system running a 2.6.22 kernel.&nbsp; I have a PCF8563T i2c based =
RTC chip
attached to the PPC i2c bus.&nbsp; In my kernel config file I have =
selected CONFIG_RTC_INTF_DEV=3Dy
and CONFIG_RTC_DRV_PCF8563=3Dy.&nbsp; I do a mknod&nbsp; for /dev/rtc as =
c 10 135 (standard
Linux) and link /dev/rtc0 to it.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>When I boot, get the following =
message:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>drivers/rtc/hctosys.c: unable to open rtc =
device
(rtc0)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>and, of course I cannot access /dev/rtc after =
booting. &nbsp;I
can, however, talk to the rtc if I use /dev/i2c and a generic i2c read =
and
write utility.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>When I look in /proc/devices, I see that rtc has =
taken major
number 254 which puzzles me. RTC should not need a dynamic major number, =
right?
&nbsp;I have perused the drivers in linux/drivers/rtc and don&#8217;t =
find any of
them calling register_chrdev() to get a dynamic major number.&nbsp; So =
here are my
questions:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:.5in;text-indent:-.25in;mso-list:l0 level1 =
lfo1'><![if !supportLists]><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><span
style=3D'mso-list:Ignore'>1)<font size=3D1 face=3D"Times New =
Roman"><span
style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></font></span></span></font><![endif]><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>Shouldn&#8217;t
rtc automagically use major/minor 10/135?<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:.5in;text-indent:-.25in;mso-list:l0 level1 =
lfo1'><![if !supportLists]><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><span
style=3D'mso-list:Ignore'>2)<font size=3D1 face=3D"Times New =
Roman"><span
style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></font></span></span></font><![endif]><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>How can I
find where in the source it asks for a dynamic major =
number?<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:.5in;text-indent:-.25in;mso-list:l0 level1 =
lfo1'><![if !supportLists]><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><span
style=3D'mso-list:Ignore'>3)<font size=3D1 face=3D"Times New =
Roman"><span
style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></font></span></span></font><![endif]><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>Does the PPC
have some quirks regarding i2c operation that are at the root of this =
problem?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>BYW, I tried making the rtc device file as c 254 0 to =
match what&#8217;s
in /proc/devices and that gives me the same =
bejavior.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks in advance for any help you can =
offer.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Marc<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_06CC_01C872DA.B14E8810--
