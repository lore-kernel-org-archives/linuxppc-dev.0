Return-Path: <hong-jun.chen@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 10AF6B7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Sep 2009 10:57:58 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n8A0vZDd002309 for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 9 Sep 2009 17:57:44 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n8A0xCRE025083
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 9 Sep 2009 19:59:13 -0500 (CDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA31B1.AD29A8E1"
Subject: RE: Queries regarding I2C and GPIO driver for Freescale MPC5121e in
	Linux2.6.24 of BSP: MPC512xADS_20090603-ltib.iso
Date: Thu, 10 Sep 2009 08:57:30 +0800
Message-ID: <3A45394FD742FA419B760BB8D398F9ED64C6E6@zch01exm26.fsl.freescale.net>
In-Reply-To: <!&!AAAAAAAAAAAYAAAAAAAAACk7Zq0ADiBFlLw+tPrMt1bCgAAAEAAAAFtTs5+/RRJLtaFyAuWiLDoBAAAAAA==@implantaire.com>
References: <!&!AAAAAAAAAAAYAAAAAAAAACk7Zq0ADiBFlLw+tPrMt1bCgAAAEAAAAMhVxXG9wghAjqGQWiEYvY8BAAAAAA==@implantaire.com>
	<3A45394FD742FA419B760BB8D398F9ED64C5B2@zch01exm26.fsl.freescale.net>
	<!&!AAAAAAAAAAAYAAAAAAAAACk7Zq0ADiBFlLw+tPrMt1bCgAAAEAAAAFtTs5+/RRJLtaFyAuWiLDoBAAAAAA==@implantaire.com>
From: "Chen Hongjun-R66092" <hong-jun.chen@freescale.com>
To: "Uma Kanta Patro" <upatro@implantaire.com>, <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA31B1.AD29A8E1
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>From the following error message, I2C controller can't receive ACK from
I2C client, so please make sure that the pins of I2C have been
initialized properly, or you can measure the tx signal and rx signal on
the right pins.
=20
B.R,
Hongjun


________________________________

	From: Uma Kanta Patro [mailto:upatro@implantaire.com]=20
	Sent: Wednesday, September 09, 2009 9:13 PM
	To: Chen Hongjun-R66092; linuxppc-dev@lists.ozlabs.org
	Subject: RE: Queries regarding I2C and GPIO driver for Freescale
MPC5121e in Linux2.6.24 of BSP: MPC512xADS_20090603-ltib.iso
=09
=09

	Hi Chen Hongjun-R66092,

	=20

	Thanks for your response.

	Actually for the GPIO driver I am having some success and it is
in progress.

	But regarding the I2C chip(client) driver I am running witout
any progress.

	Actually I followed the existing driver
$(LINUX)\drivers\rtc\rtc-m41t80.c (for the RTC M41T62 existing on the
ADS5121Rev4.1 board).

	 I made a legacy style driver with attach_adapter and
detach_client functions defined.

	For testing purpose I geve the chip address as 0x68(address of
M41T62 existing on the board). But when I tried ot insert my driver I
get the error message as:

	=20

	[root@freescale chips]# insmod dis_fpc.ko

	[  177.808848] i2c 0-0068: uevent

	[  498.528032] In dis_fpc_init

	[  498.531851] i2c-core: driver [dis_fpc] registered

	[  498.532446] In dis_fpc_attach_adapter

	[  498.536827] i2c-adapter i2c-0: found normal entry for adapter
0, addr 0x55

	[  498.537730] i2c-adapter i2c-0: master_xfer[0] W, addr=3D0x55,
len=3D0

	[  498.538533] Doing write 0 bytes to 0x55 - 1 of 1 messages

	[  498.539770] I2C: No RXAK

	[  498.540970] In dis_fpc_attach_adapter

	[  498.554500] i2c-adapter i2c-1: found normal entry for adapter
1, addr 0x55

	[  498.555166] i2c-adapter i2c-1: master_xfer[0] W, addr=3D0x55,
len=3D0

	[  498.555872] Doing write 0 bytes to 0x55 - 1 of 1 messages

	[  498.556785] I2C: MAL

	[  498.557476] In dis_fpc_attach_adapter

	[  498.565733] i2c-adapter i2c-2: found normal entry for adapter
2, addr 0x55

	[  498.566377] i2c-adapter i2c-2: master_xfer[0] W, addr=3D0x55,
len=3D0

	[  498.567082] Doing write 0 bytes to 0x55 - 1 of 1 messages

	[  498.568240] I2C: No RXAK

	=20

	So can you tell me what other places do I need to change the
configurations( like i2c_platform_data definition, linking the chip to
the specific I2C module(0/1/2) with the adapter, configuring the speed
of I2C communication etc).

	=20

	I would like to get any suggestion on making the I2C chip driver
inpowerpc platform.

	=20

	Thanks & Regards,

	Uma

	=20

	From: Chen Hongjun-R66092 [mailto:hong-jun.chen@freescale.com]=20
	Sent: Wednesday, September 09, 2009 5:39 AM
	To: Uma Kanta Patro; linuxppc-dev@lists.ozlabs.org
	Subject: RE: Queries regarding I2C and GPIO driver for Freescale
MPC5121e in Linux2.6.24 of BSP: MPC512xADS_20090603-ltib.iso

	=20

	One I2C driver has been included in 0603 bsp, you can refer to
it.

	=20

	It has no specific driver for GPIO, but you can find some
initializing code for GPIO in arch/powerpc/platforms/512x/mpc5125_ads.c.
and mpc512x_pm_test.c.

		=20

	=09
________________________________


		From:
linuxppc-dev-bounces+hong-jun.chen=3Dfreescale.com@lists.ozlabs.org
[mailto:linuxppc-dev-bounces+hong-jun.chen=3Dfreescale.com@lists.ozlabs.o=
r
g] On Behalf Of Uma Kanta Patro
		Sent: Tuesday, September 08, 2009 6:56 PM
		To: linuxppc-dev@lists.ozlabs.org
		Subject: Queries regarding I2C and GPIO driver for
Freescale MPC5121e in Linux2.6.24 of BSP: MPC512xADS_20090603-ltib.iso

		Hi all,

		                I am a newbie to the powerpc linux
kernel, but I have worked on some drivers in arm architecture. I am
finding powerpc architecture to be fully different than that.

		I am working on Freescale MPC5121e with the BSP
MPC512xADS_20090603-ltib.iso running in it on the ADS512101 Rev4.1
development kit.

		Can anyone help me in finding some documentation for
understanding and working on the powerpc kernel. Any links to the
powerpc forums will also be appreciable.

		=20

		=20

		-> Currently I am going to develop an I2C client driver
for one slave microcontroller of our project.

		I have some knowledge in the I2C client driver
making(legacy style and new style).

		=20

		I made a basic I2C client driver to probe for the chip
address and for testing I gave it the chip address 0x68(I2C chip address
of the M4T162 RTC, present on the board).

		But while inserting my driver I am getting failure
message for the detection of my chip.

		=20

		So I would like to know what other formalities am I
lagging in my I2C chip driver.

		=20

		-> Also I am in a need for the GPIO driver for my
controller ot get interrupt on ht estate change. When I searched in the
kernel code I could not find any procedure to do that, also I could not
find out the procedure to access either any GPIO pin macros or any
register to remap with ioremap(). So please guide me in finding the
proper way to do the GPIO accessing and interrupt registration.

		Will the ioremap() work on powerpc arch? If yes where
can I find the memory mapping(register definitions) to use for my GPIO
driver making.

		=20

		Thanks for patience in reading my queries.

		Any help is appreciable.

		=20

		Thanks & Regards,

		Uma

		=20


------_=_NextPart_001_01CA31B1.AD29A8E1
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML xmlns=3D"http://www.w3.org/TR/REC-html40" xmlns:v =3D=20
"urn:schemas-microsoft-com:vml" xmlns:o =3D=20
"urn:schemas-microsoft-com:office:office" xmlns:w =3D=20
"urn:schemas-microsoft-com:office:word" xmlns:m =3D=20
"http://schemas.microsoft.com/office/2004/12/omml"><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3562" name=3DGENERATOR><!--[if !mso]>
<STYLE>v\:* {
	BEHAVIOR: url(#default#VML)
}
o\:* {
	BEHAVIOR: url(#default#VML)
}
w\:* {
	BEHAVIOR: url(#default#VML)
}
.shape {
	BEHAVIOR: url(#default#VML)
}
</STYLE>
<![endif]-->
<STYLE>@font-face {
	font-family: Batang;
}
@font-face {
	font-family: Batang;
}
@font-face {
	font-family: Calibri;
}
@font-face {
	font-family: Tahoma;
}
@font-face {
	font-family: @Batang;
}
@page Section1 {size: 8.5in 11.0in; margin: 1.0in 1.0in 1.0in 1.0in; }
P.MsoNormal {
	FONT-SIZE: 11pt; MARGIN: 0in 0in 0pt; FONT-FAMILY: =
"Calibri","sans-serif"
}
LI.MsoNormal {
	FONT-SIZE: 11pt; MARGIN: 0in 0in 0pt; FONT-FAMILY: =
"Calibri","sans-serif"
}
DIV.MsoNormal {
	FONT-SIZE: 11pt; MARGIN: 0in 0in 0pt; FONT-FAMILY: =
"Calibri","sans-serif"
}
A:link {
	COLOR: blue; TEXT-DECORATION: underline; mso-style-priority: 99
}
SPAN.MsoHyperlink {
	COLOR: blue; TEXT-DECORATION: underline; mso-style-priority: 99
}
A:visited {
	COLOR: purple; TEXT-DECORATION: underline; mso-style-priority: 99
}
SPAN.MsoHyperlinkFollowed {
	COLOR: purple; TEXT-DECORATION: underline; mso-style-priority: 99
}
SPAN.EmailStyle17 {
	COLOR: windowtext; FONT-FAMILY: "Calibri","sans-serif"; mso-style-type: =
personal
}
SPAN.EmailStyle18 {
	COLOR: #1f497d; FONT-FAMILY: "Calibri","sans-serif"; mso-style-type: =
personal-reply
}
.MsoChpDefault {
	FONT-SIZE: 10pt; mso-style-type: export-only
}
DIV.Section1 {
	page: Section1
}
</STYLE>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]--></HEAD>
<BODY lang=3DEN-US vLink=3Dpurple link=3Dblue>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D736185200-10092009><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>From the following error message, I2C =
controller can't=20
receive ACK from I2C client, so please make sure that the pins of I2C =
have been=20
initialized properly,&nbsp;or you can measure the tx signal and rx =
signal on the=20
right pins.</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D736185200-10092009><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D736185200-10092009><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>B.R,</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D736185200-10092009><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>Hongjun</FONT></SPAN></DIV><BR>
<BLOCKQUOTE dir=3Dltr=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px =
solid; MARGIN-RIGHT: 0px">
  <DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
  <HR tabIndex=3D-1>
  <FONT face=3DTahoma size=3D2><B>From:</B> Uma Kanta Patro=20
  [mailto:upatro@implantaire.com] <BR><B>Sent:</B> Wednesday, September =
09, 2009=20
  9:13 PM<BR><B>To:</B> Chen Hongjun-R66092;=20
  linuxppc-dev@lists.ozlabs.org<BR><B>Subject:</B> RE: Queries regarding =
I2C and=20
  GPIO driver for Freescale MPC5121e in Linux2.6.24 of BSP:=20
  MPC512xADS_20090603-ltib.iso<BR></FONT><BR></DIV>
  <DIV></DIV>
  <DIV class=3DSection1>
  <P class=3DMsoNormal><SPAN style=3D"COLOR: #1f497d">Hi Chen=20
  Hongjun-R66092,<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal><SPAN style=3D"COLOR: =
#1f497d"><o:p>&nbsp;</o:p></SPAN></P>
  <P class=3DMsoNormal><SPAN style=3D"COLOR: #1f497d">Thanks for your=20
  response.<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal><SPAN style=3D"COLOR: #1f497d">Actually for the =
GPIO driver I=20
  am having some success and it is in progress.<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal><SPAN style=3D"COLOR: #1f497d">But regarding the =
I2C=20
  chip(client) driver I am running witout any =
progress.<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal><SPAN style=3D"COLOR: #1f497d">Actually I =
followed the=20
  existing driver $(LINUX)\drivers\rtc\rtc-m41t80.c (for the RTC M41T62 =
existing=20
  on the ADS5121Rev4.1 board).<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal><SPAN style=3D"COLOR: #1f497d">&nbsp;I made a =
legacy style=20
  driver with attach_adapter and detach_client functions=20
  defined.<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal><SPAN style=3D"COLOR: #1f497d">For testing =
purpose I geve the=20
  chip address as 0x68(address of M41T62 existing on the board). But =
when I=20
  tried ot insert my driver I get the error message =
as:<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal><SPAN style=3D"COLOR: =
#1f497d"><o:p>&nbsp;</o:p></SPAN></P>
  <P class=3DMsoNormal><SPAN=20
  style=3D"FONT-SIZE: 10pt; COLOR: #1f497d">[root@freescale chips]# =
insmod=20
  dis_fpc.ko<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal><SPAN style=3D"FONT-SIZE: 10pt; COLOR: =
#1f497d">[&nbsp;=20
  177.808848] i2c 0-0068: uevent<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal><SPAN style=3D"FONT-SIZE: 10pt; COLOR: =
#1f497d">[&nbsp;=20
  498.528032] In dis_fpc_init<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal><SPAN style=3D"FONT-SIZE: 10pt; COLOR: =
#1f497d">[&nbsp;=20
  498.531851] i2c-core: driver [dis_fpc] =
registered<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal><SPAN style=3D"FONT-SIZE: 10pt; COLOR: =
#1f497d">[&nbsp;=20
  498.532446] In dis_fpc_attach_adapter<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal><SPAN style=3D"FONT-SIZE: 10pt; COLOR: =
#1f497d">[&nbsp;=20
  498.536827] i2c-adapter i2c-0: found normal entry for adapter 0, addr=20
  0x55<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal><SPAN style=3D"FONT-SIZE: 10pt; COLOR: =
#1f497d">[&nbsp;=20
  498.537730] i2c-adapter i2c-0: master_xfer[0] W, addr=3D0x55,=20
  len=3D0<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal><SPAN style=3D"FONT-SIZE: 10pt; COLOR: =
#1f497d">[&nbsp;=20
  498.538533] Doing write 0 bytes to 0x55 - 1 of 1=20
messages<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal><SPAN style=3D"FONT-SIZE: 10pt; COLOR: =
#1f497d">[&nbsp;=20
  498.539770] I2C: No RXAK<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal><SPAN style=3D"FONT-SIZE: 10pt; COLOR: =
#1f497d">[&nbsp;=20
  498.540970] In dis_fpc_attach_adapter<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal><SPAN style=3D"FONT-SIZE: 10pt; COLOR: =
#1f497d">[&nbsp;=20
  498.554500] i2c-adapter i2c-1: found normal entry for adapter 1, addr=20
  0x55<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal><SPAN style=3D"FONT-SIZE: 10pt; COLOR: =
#1f497d">[&nbsp;=20
  498.555166] i2c-adapter i2c-1: master_xfer[0] W, addr=3D0x55,=20
  len=3D0<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal><SPAN style=3D"FONT-SIZE: 10pt; COLOR: =
#1f497d">[&nbsp;=20
  498.555872] Doing write 0 bytes to 0x55 - 1 of 1=20
messages<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal><SPAN style=3D"FONT-SIZE: 10pt; COLOR: =
#1f497d">[&nbsp;=20
  498.556785] I2C: MAL<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal><SPAN style=3D"FONT-SIZE: 10pt; COLOR: =
#1f497d">[&nbsp;=20
  498.557476] In dis_fpc_attach_adapter<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal><SPAN style=3D"FONT-SIZE: 10pt; COLOR: =
#1f497d">[&nbsp;=20
  498.565733] i2c-adapter i2c-2: found normal entry for adapter 2, addr=20
  0x55<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal><SPAN style=3D"FONT-SIZE: 10pt; COLOR: =
#1f497d">[&nbsp;=20
  498.566377] i2c-adapter i2c-2: master_xfer[0] W, addr=3D0x55,=20
  len=3D0<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal><SPAN style=3D"FONT-SIZE: 10pt; COLOR: =
#1f497d">[&nbsp;=20
  498.567082] Doing write 0 bytes to 0x55 - 1 of 1=20
messages<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal><SPAN style=3D"FONT-SIZE: 10pt; COLOR: =
#1f497d">[&nbsp;=20
  498.568240] I2C: No RXAK<o:p></o:p></SPAN></P>
  <DIV>
  <P class=3DMsoNormal><SPAN=20
  style=3D"FONT-SIZE: 12pt; COLOR: #1f497d"><o:p>&nbsp;</o:p></SPAN></P>
  <P class=3DMsoNormal><SPAN style=3D"FONT-SIZE: 12pt; COLOR: =
#1f497d">So can you=20
  tell me what other places do I need to change the configurations( like =

  i2c_platform_data definition, linking the chip to the specific I2C=20
  module(0/1/2) with the adapter, configuring the speed of I2C =
communication=20
  etc).<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal><SPAN=20
  style=3D"FONT-SIZE: 12pt; COLOR: #1f497d"><o:p>&nbsp;</o:p></SPAN></P>
  <P class=3DMsoNormal><SPAN style=3D"FONT-SIZE: 12pt; COLOR: #1f497d">I =
would like=20
  to get any suggestion on making the I2C chip driver inpowerpc=20
  platform.<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal><SPAN=20
  style=3D"FONT-SIZE: 12pt; COLOR: #1f497d"><o:p>&nbsp;</o:p></SPAN></P>
  <P class=3DMsoNormal><SPAN style=3D"FONT-SIZE: 12pt; COLOR: =
#1f497d">Thanks &amp;=20
  Regards,<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal><SPAN=20
  style=3D"FONT-SIZE: 12pt; COLOR: #1f497d">Uma</SPAN><SPAN=20
  style=3D"FONT-SIZE: 12pt; COLOR: #1f497d"><o:p></o:p></SPAN></P></DIV>
  <P class=3DMsoNormal><SPAN style=3D"COLOR: =
#1f497d"><o:p>&nbsp;</o:p></SPAN></P>
  <DIV>
  <DIV=20
  style=3D"BORDER-RIGHT: medium none; PADDING-RIGHT: 0in; BORDER-TOP: =
#b5c4df 1pt solid; PADDING-LEFT: 0in; PADDING-BOTTOM: 0in; BORDER-LEFT: =
medium none; PADDING-TOP: 3pt; BORDER-BOTTOM: medium none">
  <P class=3DMsoNormal><B><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
'Tahoma','sans-serif'">From:</SPAN></B><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: 'Tahoma','sans-serif'"> Chen=20
  Hongjun-R66092 [mailto:hong-jun.chen@freescale.com] <BR><B>Sent:</B>=20
  Wednesday, September 09, 2009 5:39 AM<BR><B>To:</B> Uma Kanta Patro;=20
  linuxppc-dev@lists.ozlabs.org<BR><B>Subject:</B> RE: Queries regarding =
I2C and=20
  GPIO driver for Freescale MPC5121e in Linux2.6.24 of BSP:=20
  MPC512xADS_20090603-ltib.iso<o:p></o:p></SPAN></P></DIV></DIV>
  <P class=3DMsoNormal><o:p>&nbsp;</o:p></P>
  <P class=3DMsoNormal><SPAN=20
  style=3D"FONT-SIZE: 10pt; COLOR: blue; FONT-FAMILY: =
'Arial','sans-serif'">One=20
  I2C driver has been included in 0603 bsp, you can refer to =
it.</SPAN><SPAN=20
  style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Times New =
Roman','serif'"><o:p></o:p></SPAN></P>
  <P class=3DMsoNormal><SPAN=20
  style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Times New =
Roman','serif'">&nbsp;<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal><SPAN=20
  style=3D"FONT-SIZE: 10pt; COLOR: blue; FONT-FAMILY: =
'Arial','sans-serif'">It has=20
  no&nbsp;specific driver for GPIO, but you can find some =
initializing&nbsp;code=20
  for GPIO in arch/powerpc/platforms/512x/mpc5125_ads.c. and=20
  mpc512x_pm_test.c.</SPAN><SPAN=20
  style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Times New =
Roman','serif'"><o:p></o:p></SPAN></P>
  <BLOCKQUOTE=20
  style=3D"BORDER-RIGHT: medium none; PADDING-RIGHT: 0in; BORDER-TOP: =
medium none; PADDING-LEFT: 4pt; PADDING-BOTTOM: 0in; MARGIN: 5pt 0in 5pt =
3.75pt; BORDER-LEFT: blue 1.5pt solid; PADDING-TOP: 0in; BORDER-BOTTOM: =
medium none">
    <P class=3DMsoNormal><SPAN=20
    style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Times New =
Roman','serif'"><o:p>&nbsp;</o:p></SPAN></P>
    <DIV class=3DMsoNormal style=3D"TEXT-ALIGN: center" =
align=3Dcenter><SPAN=20
    style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Times New Roman','serif'">
    <HR align=3Dcenter width=3D"100%" SIZE=3D2>
    </SPAN></DIV>
    <P class=3DMsoNormal style=3D"MARGIN-BOTTOM: 12pt"><B><SPAN=20
    style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
'Tahoma','sans-serif'">From:</SPAN></B><SPAN=20
    style=3D"FONT-SIZE: 10pt; FONT-FAMILY: 'Tahoma','sans-serif'">=20
    linuxppc-dev-bounces+hong-jun.chen=3Dfreescale.com@lists.ozlabs.org=20
    =
[mailto:linuxppc-dev-bounces+hong-jun.chen=3Dfreescale.com@lists.ozlabs.o=
rg]=20
    <B>On Behalf Of </B>Uma Kanta Patro<BR><B>Sent:</B> Tuesday, =
September 08,=20
    2009 6:56 PM<BR><B>To:</B> =
linuxppc-dev@lists.ozlabs.org<BR><B>Subject:</B>=20
    Queries regarding I2C and GPIO driver for Freescale MPC5121e in =
Linux2.6.24=20
    of BSP: MPC512xADS_20090603-ltib.iso</SPAN><SPAN=20
    style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Times New =
Roman','serif'"><o:p></o:p></SPAN></P>
    <P class=3DMsoNormal>Hi all,<o:p></o:p></P>
    <P=20
    =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
    I am a newbie to the powerpc linux kernel, but I have worked on some =
drivers=20
    in arm architecture. I am finding powerpc architecture to be fully =
different=20
    than that.<o:p></o:p></P>
    <P class=3DMsoNormal>I am working on Freescale MPC5121e with the BSP =

    MPC512xADS_20090603-ltib.iso running in it on the ADS512101 Rev4.1=20
    development kit.<o:p></o:p></P>
    <P class=3DMsoNormal>Can anyone help me in finding some =
documentation for=20
    understanding and working on the powerpc kernel. Any links to the =
powerpc=20
    forums will also be appreciable.<o:p></o:p></P>
    <P class=3DMsoNormal><o:p>&nbsp;</o:p></P>
    <P class=3DMsoNormal><o:p>&nbsp;</o:p></P>
    <P class=3DMsoNormal>-&gt; Currently I am going to develop an I2C =
client=20
    driver for one slave microcontroller of our project.<o:p></o:p></P>
    <P class=3DMsoNormal>I have some knowledge in the I2C client driver=20
    making(legacy style and new style).<o:p></o:p></P>
    <P class=3DMsoNormal><o:p>&nbsp;</o:p></P>
    <P class=3DMsoNormal>I made a basic I2C client driver to probe for =
the chip=20
    address and for testing I gave it the chip address 0x68(I2C chip =
address of=20
    the M4T162 RTC, present on the board).<o:p></o:p></P>
    <P class=3DMsoNormal>But while inserting my driver I am getting =
failure=20
    message for the detection of my chip.<o:p></o:p></P>
    <P class=3DMsoNormal><o:p>&nbsp;</o:p></P>
    <P class=3DMsoNormal>So I would like to know what other formalities =
am I=20
    lagging in my I2C chip driver.<o:p></o:p></P>
    <P class=3DMsoNormal><o:p>&nbsp;</o:p></P>
    <P class=3DMsoNormal>-&gt; Also I am in a need for the GPIO driver =
for my=20
    controller ot get interrupt on ht estate change. When I searched in =
the=20
    kernel code I could not find any procedure to do that, also I could =
not find=20
    out the procedure to access either any GPIO pin macros or any =
register to=20
    remap with ioremap(). So please guide me in finding the proper way =
to do the=20
    GPIO accessing and interrupt registration.<o:p></o:p></P>
    <P class=3DMsoNormal>Will the ioremap() work on powerpc arch? If yes =
where can=20
    I find the memory mapping(register definitions) to use for my GPIO =
driver=20
    making.<o:p></o:p></P>
    <P class=3DMsoNormal><o:p>&nbsp;</o:p></P>
    <P class=3DMsoNormal>Thanks for patience in reading my =
queries.<o:p></o:p></P>
    <P class=3DMsoNormal>Any help is appreciable.<o:p></o:p></P>
    <P class=3DMsoNormal><o:p>&nbsp;</o:p></P>
    <P class=3DMsoNormal><SPAN style=3D"FONT-SIZE: 12pt">Thanks &amp;=20
    Regards,<o:p></o:p></SPAN></P>
    <P class=3DMsoNormal><SPAN style=3D"FONT-SIZE: =
12pt">Uma<o:p></o:p></SPAN></P>
    <P=20
class=3DMsoNormal><o:p>&nbsp;</o:p></P></BLOCKQUOTE></DIV></BLOCKQUOTE></=
BODY></HTML>

------_=_NextPart_001_01CA31B1.AD29A8E1--
