Return-Path: <upatro@implantaire.com>
Received: from smtp105.biz.mail.in2.yahoo.com (smtp105.biz.mail.in2.yahoo.com
	[203.104.19.14])
	by bilbo.ozlabs.org (Postfix) with SMTP id BAA1BB6F31
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Sep 2009 23:10:21 +1000 (EST)
From: "Uma Kanta Patro" <upatro@implantaire.com>
To: "'Chen Hongjun-R66092'" <hong-jun.chen@freescale.com>,
	<linuxppc-dev@lists.ozlabs.org>
References: <!&!AAAAAAAAAAAYAAAAAAAAACk7Zq0ADiBFlLw+tPrMt1bCgAAAEAAAAMhVxXG9wghAjqGQWiEYvY8BAAAAAA==@implantaire.com>
	<3A45394FD742FA419B760BB8D398F9ED64C5B2@zch01exm26.fsl.freescale.net>
In-Reply-To: <3A45394FD742FA419B760BB8D398F9ED64C5B2@zch01exm26.fsl.freescale.net>
Subject: RE: Queries regarding I2C and GPIO driver for Freescale MPC5121e in
	Linux2.6.24 of BSP: MPC512xADS_20090603-ltib.iso
Date: Wed, 9 Sep 2009 18:43:03 +0530
Message-ID: <!&!AAAAAAAAAAAYAAAAAAAAACk7Zq0ADiBFlLw+tPrMt1bCgAAAEAAAAFtTs5+/RRJLtaFyAuWiLDoBAAAAAA==@implantaire.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0000_01CA317D.5D6D7D10"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.

------=_NextPart_000_0000_01CA317D.5D6D7D10
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Chen Hongjun-R66092,

 

Thanks for your response.

Actually for the GPIO driver I am having some success and it is in progress.

But regarding the I2C chip(client) driver I am running witout any progress.

Actually I followed the existing driver $(LINUX)\drivers\rtc\rtc-m41t80.c
(for the RTC M41T62 existing on the ADS5121Rev4.1 board).

 I made a legacy style driver with attach_adapter and detach_client
functions defined.

For testing purpose I geve the chip address as 0x68(address of M41T62
existing on the board). But when I tried ot insert my driver I get the error
message as:

 

[root@freescale chips]# insmod dis_fpc.ko

[  177.808848] i2c 0-0068: uevent

[  498.528032] In dis_fpc_init

[  498.531851] i2c-core: driver [dis_fpc] registered

[  498.532446] In dis_fpc_attach_adapter

[  498.536827] i2c-adapter i2c-0: found normal entry for adapter 0, addr
0x55

[  498.537730] i2c-adapter i2c-0: master_xfer[0] W, addr=0x55, len=0

[  498.538533] Doing write 0 bytes to 0x55 - 1 of 1 messages

[  498.539770] I2C: No RXAK

[  498.540970] In dis_fpc_attach_adapter

[  498.554500] i2c-adapter i2c-1: found normal entry for adapter 1, addr
0x55

[  498.555166] i2c-adapter i2c-1: master_xfer[0] W, addr=0x55, len=0

[  498.555872] Doing write 0 bytes to 0x55 - 1 of 1 messages

[  498.556785] I2C: MAL

[  498.557476] In dis_fpc_attach_adapter

[  498.565733] i2c-adapter i2c-2: found normal entry for adapter 2, addr
0x55

[  498.566377] i2c-adapter i2c-2: master_xfer[0] W, addr=0x55, len=0

[  498.567082] Doing write 0 bytes to 0x55 - 1 of 1 messages

[  498.568240] I2C: No RXAK

 

So can you tell me what other places do I need to change the configurations(
like i2c_platform_data definition, linking the chip to the specific I2C
module(0/1/2) with the adapter, configuring the speed of I2C communication
etc).

 

I would like to get any suggestion on making the I2C chip driver inpowerpc
platform.

 

Thanks & Regards,

Uma

 

From: Chen Hongjun-R66092 [mailto:hong-jun.chen@freescale.com] 
Sent: Wednesday, September 09, 2009 5:39 AM
To: Uma Kanta Patro; linuxppc-dev@lists.ozlabs.org
Subject: RE: Queries regarding I2C and GPIO driver for Freescale MPC5121e in
Linux2.6.24 of BSP: MPC512xADS_20090603-ltib.iso

 

One I2C driver has been included in 0603 bsp, you can refer to it.

 

It has no specific driver for GPIO, but you can find some initializing code
for GPIO in arch/powerpc/platforms/512x/mpc5125_ads.c. and
mpc512x_pm_test.c.

 


  _____  


From: linuxppc-dev-bounces+hong-jun.chen=freescale.com@lists.ozlabs.org
[mailto:linuxppc-dev-bounces+hong-jun.chen=freescale.com@lists.ozlabs.org]
On Behalf Of Uma Kanta Patro
Sent: Tuesday, September 08, 2009 6:56 PM
To: linuxppc-dev@lists.ozlabs.org
Subject: Queries regarding I2C and GPIO driver for Freescale MPC5121e in
Linux2.6.24 of BSP: MPC512xADS_20090603-ltib.iso

Hi all,

                I am a newbie to the powerpc linux kernel, but I have worked
on some drivers in arm architecture. I am finding powerpc architecture to be
fully different than that.

I am working on Freescale MPC5121e with the BSP MPC512xADS_20090603-ltib.iso
running in it on the ADS512101 Rev4.1 development kit.

Can anyone help me in finding some documentation for understanding and
working on the powerpc kernel. Any links to the powerpc forums will also be
appreciable.

 

 

-> Currently I am going to develop an I2C client driver for one slave
microcontroller of our project.

I have some knowledge in the I2C client driver making(legacy style and new
style).

 

I made a basic I2C client driver to probe for the chip address and for
testing I gave it the chip address 0x68(I2C chip address of the M4T162 RTC,
present on the board).

But while inserting my driver I am getting failure message for the detection
of my chip.

 

So I would like to know what other formalities am I lagging in my I2C chip
driver.

 

-> Also I am in a need for the GPIO driver for my controller ot get
interrupt on ht estate change. When I searched in the kernel code I could
not find any procedure to do that, also I could not find out the procedure
to access either any GPIO pin macros or any register to remap with
ioremap(). So please guide me in finding the proper way to do the GPIO
accessing and interrupt registration.

Will the ioremap() work on powerpc arch? If yes where can I find the memory
mapping(register definitions) to use for my GPIO driver making.

 

Thanks for patience in reading my queries.

Any help is appreciable.

 

Thanks & Regards,

Uma

 


------=_NextPart_000_0000_01CA317D.5D6D7D10
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
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
	{font-family:Batang;
	panose-1:2 3 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:Batang;
	panose-1:2 3 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:"\@Batang";
	panose-1:2 3 6 0 0 1 1 1 1 1;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>Hi Chen =
Hongjun-R66092,<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>Thanks for your =
response.<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>Actually for the GPIO =
driver I am
having some success and it is in progress.<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>But regarding the I2C =
chip(client)
driver I am running witout any progress.<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>Actually I followed =
the existing
driver $(LINUX)\drivers\rtc\rtc-m41t80.c (for the RTC M41T62 existing on =
the
ADS5121Rev4.1 board).<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&nbsp;I made a legacy =
style driver
with attach_adapter and detach_client functions =
defined.<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>For testing purpose I =
geve the chip
address as 0x68(address of M41T62 existing on the board). But when I =
tried ot
insert my driver I get the error message as:<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;color:#1F497D'>[root@freescale
chips]# insmod dis_fpc.ko<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;color:#1F497D'>[&nbsp; 177.808848]
i2c 0-0068: uevent<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;color:#1F497D'>[&nbsp; 498.528032]
In dis_fpc_init<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;color:#1F497D'>[&nbsp; 498.531851]
i2c-core: driver [dis_fpc] registered<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;color:#1F497D'>[&nbsp; 498.532446]
In dis_fpc_attach_adapter<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;color:#1F497D'>[&nbsp; 498.536827]
i2c-adapter i2c-0: found normal entry for adapter 0, addr =
0x55<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;color:#1F497D'>[&nbsp; 498.537730]
i2c-adapter i2c-0: master_xfer[0] W, addr=3D0x55, =
len=3D0<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;color:#1F497D'>[&nbsp; 498.538533]
Doing write 0 bytes to 0x55 - 1 of 1 messages<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;color:#1F497D'>[&nbsp; 498.539770]
I2C: No RXAK<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;color:#1F497D'>[&nbsp; 498.540970]
In dis_fpc_attach_adapter<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;color:#1F497D'>[&nbsp; 498.554500]
i2c-adapter i2c-1: found normal entry for adapter 1, addr =
0x55<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;color:#1F497D'>[&nbsp; 498.555166]
i2c-adapter i2c-1: master_xfer[0] W, addr=3D0x55, =
len=3D0<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;color:#1F497D'>[&nbsp; 498.555872]
Doing write 0 bytes to 0x55 - 1 of 1 messages<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;color:#1F497D'>[&nbsp; 498.556785]
I2C: MAL<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;color:#1F497D'>[&nbsp; 498.557476]
In dis_fpc_attach_adapter<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;color:#1F497D'>[&nbsp; 498.565733]
i2c-adapter i2c-2: found normal entry for adapter 2, addr =
0x55<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;color:#1F497D'>[&nbsp; 498.566377]
i2c-adapter i2c-2: master_xfer[0] W, addr=3D0x55, =
len=3D0<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;color:#1F497D'>[&nbsp; 498.567082]
Doing write 0 bytes to 0x55 - 1 of 1 messages<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;color:#1F497D'>[&nbsp; 498.568240]
I2C: No RXAK<o:p></o:p></span></p>

<div>

<p class=3DMsoNormal><span =
style=3D'font-size:12.0pt;color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:12.0pt;color:#1F497D'>So =
can you tell
me what other places do I need to change the configurations( like
i2c_platform_data definition, linking the chip to the specific I2C =
module(0/1/2)
with the adapter, configuring the speed of I2C communication =
etc).<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:12.0pt;color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:12.0pt;color:#1F497D'>I =
would like to
get any suggestion on making the I2C chip driver inpowerpc =
platform.<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:12.0pt;color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:12.0pt;color:#1F497D'>Thanks &amp;
Regards,<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:12.0pt;color:#1F497D'>Uma</span><span
style=3D'font-size:12.0pt;color:#1F497D'><o:p></o:p></span></p>

</div>

<p class=3DMsoNormal><span =
style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<div>

<div style=3D'border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt =
0in 0in 0in'>

<p class=3DMsoNormal><b><span =
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'>From:</span>=
</b><span
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'> Chen =
Hongjun-R66092
[mailto:hong-jun.chen@freescale.com] <br>
<b>Sent:</b> Wednesday, September 09, 2009 5:39 AM<br>
<b>To:</b> Uma Kanta Patro; linuxppc-dev@lists.ozlabs.org<br>
<b>Subject:</b> RE: Queries regarding I2C and GPIO driver for Freescale
MPC5121e in Linux2.6.24 of BSP: =
MPC512xADS_20090603-ltib.iso<o:p></o:p></span></p>

</div>

</div>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Arial","sans-serif";
color:blue'>One I2C driver has been included in 0603 bsp, you can refer =
to it.</span><span
style=3D'font-size:12.0pt;font-family:"Times New =
Roman","serif"'><o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:12.0pt;font-family:"Times =
New Roman","serif"'>&nbsp;<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Arial","sans-serif";
color:blue'>It has no&nbsp;specific driver for GPIO, but you can find =
some
initializing&nbsp;code for GPIO in =
arch/powerpc/platforms/512x/mpc5125_ads.c.
and mpc512x_pm_test.c.</span><span =
style=3D'font-size:12.0pt;font-family:"Times New =
Roman","serif"'><o:p></o:p></span></p>

<blockquote style=3D'border:none;border-left:solid blue =
1.5pt;padding:0in 0in 0in 4.0pt;
margin-left:3.75pt;margin-top:5.0pt;margin-right:0in;margin-bottom:5.0pt'=
>

<p class=3DMsoNormal><span style=3D'font-size:12.0pt;font-family:"Times =
New Roman","serif"'><o:p>&nbsp;</o:p></span></p>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><span
style=3D'font-size:12.0pt;font-family:"Times New Roman","serif"'>

<hr size=3D2 width=3D"100%" align=3Dcenter>

</span></div>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><b><span =
style=3D'font-size:10.0pt;
font-family:"Tahoma","sans-serif"'>From:</span></b><span =
style=3D'font-size:10.0pt;
font-family:"Tahoma","sans-serif"'>
linuxppc-dev-bounces+hong-jun.chen=3Dfreescale.com@lists.ozlabs.org
[mailto:linuxppc-dev-bounces+hong-jun.chen=3Dfreescale.com@lists.ozlabs.o=
rg] <b>On
Behalf Of </b>Uma Kanta Patro<br>
<b>Sent:</b> Tuesday, September 08, 2009 6:56 PM<br>
<b>To:</b> linuxppc-dev@lists.ozlabs.org<br>
<b>Subject:</b> Queries regarding I2C and GPIO driver for Freescale =
MPC5121e in
Linux2.6.24 of BSP: MPC512xADS_20090603-ltib.iso</span><span =
style=3D'font-size:
12.0pt;font-family:"Times New Roman","serif"'><o:p></o:p></span></p>

<p class=3DMsoNormal>Hi all,<o:p></o:p></p>

<p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
I am a newbie to the powerpc linux kernel, but I have worked on some =
drivers in
arm architecture. I am finding powerpc architecture to be fully =
different than
that.<o:p></o:p></p>

<p class=3DMsoNormal>I am working on Freescale MPC5121e with the BSP
MPC512xADS_20090603-ltib.iso running in it on the ADS512101 Rev4.1 =
development
kit.<o:p></o:p></p>

<p class=3DMsoNormal>Can anyone help me in finding some documentation =
for
understanding and working on the powerpc kernel. Any links to the =
powerpc
forums will also be appreciable.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>-&gt; Currently I am going to develop an I2C client =
driver
for one slave microcontroller of our project.<o:p></o:p></p>

<p class=3DMsoNormal>I have some knowledge in the I2C client driver =
making(legacy
style and new style).<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I made a basic I2C client driver to probe for the =
chip
address and for testing I gave it the chip address 0x68(I2C chip address =
of the
M4T162 RTC, present on the board).<o:p></o:p></p>

<p class=3DMsoNormal>But while inserting my driver I am getting failure =
message
for the detection of my chip.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>So I would like to know what other formalities am I =
lagging
in my I2C chip driver.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>-&gt; Also I am in a need for the GPIO driver for =
my
controller ot get interrupt on ht estate change. When I searched in the =
kernel
code I could not find any procedure to do that, also I could not find =
out the
procedure to access either any GPIO pin macros or any register to remap =
with
ioremap(). So please guide me in finding the proper way to do the GPIO
accessing and interrupt registration.<o:p></o:p></p>

<p class=3DMsoNormal>Will the ioremap() work on powerpc arch? If yes =
where can I
find the memory mapping(register definitions) to use for my GPIO driver =
making.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Thanks for patience in reading my =
queries.<o:p></o:p></p>

<p class=3DMsoNormal>Any help is appreciable.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><span style=3D'font-size:12.0pt'>Thanks &amp; =
Regards,<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:12.0pt'>Uma<o:p></o:p></span></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</blockquote>

</div>

</body>

</html>

------=_NextPart_000_0000_01CA317D.5D6D7D10--
