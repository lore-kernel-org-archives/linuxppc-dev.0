Return-Path: <mike_timmons@trimble.com>
Received: from snvl-smtp1.trimble.com (snvl-smtp1.trimble.com [155.63.64.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "snvl-smtp1.trimble.com", Issuer "Trimble CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 7C975DE712
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 Jun 2008 02:21:02 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8C728.220488FF"
Subject: RE: Is the linux-2.6.25.4 compatible with freescale lite5200b?
Date: Thu, 5 Jun 2008 09:20:47 -0700
Message-ID: <161B3BAD77161449A144FF054231C3D6022A32FD@uss-am-xch-01.am.trimblecorp.net>
In-Reply-To: <70cc19fe0806031955v4478b886k94150ca9c9295a49@mail.gmail.com>
References: <70cc19fe0806031955v4478b886k94150ca9c9295a49@mail.gmail.com>
From: "Mike Timmons" <mike_timmons@trimble.com>
To: "Henry Chen" <ghenrychen@gmail.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8C728.220488FF
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Henry. I recently migrated to ARCH=3Dpowerpc on 2.6.24 from =
ARCH=3Dppc on
2.6.16 (having obtained a distribution from the ltib project).

=20

The ppc architecture is nearing end-of-life as far as development goes,
so I recommend jumping to powerpc now. In mey recent experience I
encountered better driver support, and I generally noticed that future
patching/development would support ARCH=3Dpowerpc. I think the old ppc
implied embedded (or non-mac) architectures, while the powerpc was
intended for mac desktops. I might be wrong, but it looks like the two
have merged.

=20

This architecture issue doesn't speak directly to your question, but if
you could get 2.6.25 working with ARCH=3Dpowerpc on your lite5200b then
you and I would be working with basically the same set-up and I could
help you better. For now, here are a few questions:

=20

1)      Have you successfully NFS mounted your rootfs and not woried
about the RAMdisk at this point?

2)      Maybe you are using ARCH=3Dpowerpc, but your comment in
/arch/ppc/configs/ has me confused. Did you mean in
/arch/powerpc/configs/ ?

=20

Please clarify if you are using ARCH=3Dpowerpc and I think I can be of
more assistance. For example, on my 2.6.24 kernel I needed to...

1)      Halve the memory sive specified in lite5200b.dts. It specified
twice as much memory as is actually on my lite5200b, causing a strange,
long delay at boot time as page initialization attempted to operate on a
bunch of non-existent memory, near as I can tell. The symptom was around
30-45 seconds of delay between U-boot boot and any console output.
Weird, but I figured it had something to do with RAM initialization only
after getting my BDI2000 JTAG debugger going and breaking to see that
the kernel appears stuck on something related to initializing the RAM.
This drove me to discover the size spec is wrong in the dts file.

2)      If you need edge-sensitive interrupts you'll need a set
interrupt type callback. Mpc52xx_pic.c is missing this callback. Check
another powerpc architecture for set_interrupt_type. I would upload a
patch but it turns out I am fine with level-sensitive only so I didn't
go through the trouble of formalizing a fix for this.

3)      SPI driver for SPI peripheral (not PSC): this is missing but
there is a patch for it. Tell me if you need it and I'll direct you).

4)      IN GENERAL, THE DEVICE TREE CONCEPT IS COOL, BUT IT HAS A
LEARNING CURVE. I can help you. For example, just requesting an external
IRQ requires creating a "device" node so that you can associate a
specific IRQ number with said device for easy access from your module
driver code at run time. Basically, ALL register access is done by
run-time parsing of the device tree information, NOT by simply direct
register access, given a bunch of defined address constants in some
header file.

=20

Sorry if none of this helps, but I just recently clawed my way up the
learning curve so some of the wounds are fresh. Hopefully I can provide
a bit of guidance on the easy concepts.

=20

-Mike

=20

=20

________________________________

From: linuxppc-embedded-bounces+mike_timmons=3Dtrimble.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+mike_timmons=3Dtrimble.com@ozlabs.org]
On Behalf Of Henry Chen
Sent: Tuesday, June 03, 2008 9:55 PM
To: linuxppc-embedded@ozlabs.org
Subject: Is the linux-2.6.25.4 compatible with freescale lite5200b?

=20

Hi, all expert!

=20

Thank you for your patience.

=20

I want to use Linux as the OS of freescale lite5200b develop board. Then
I have tried two version of kernel, 2.6.25.4 and 2.4.25.

We succeed in 2.4.25, failed in 2.6.25.4. We use the default config file
for the board, lite5200_defconfig, which would be found both in
/arch/ppc/configs/. And we use the same ramdisk. The following info is
about the error of 2.6.15.4.

=20

=3D> bootm fe000000 fe200000

## Booting image at fe000000 ...

   Image Name:   Linux-2.6.25

   Image Type:   PowerPC Linux Kernel Image (gzip compressed)

   Data Size:    802989 Bytes =3D 784.2 kB

   Load Address: 00000000

   Entry Point:  00000000

   Uncompressing Kernel Image ... OK

## Loading RAMDisk Image at fe200000 ...

   Image Name:   rootfs in flash

   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)

   Data Size:    5055519 Bytes =3D  4.8 MB

   Load Address: fe5a0000

   Entry Point:  fe5a0000

   Loading Ramdisk to 0fa7c000, end 0ff4e41f ... OK

id mach(): done

MMU:enter

MMU:hw init

MMU:mapin

MMU:setio

MMU:exit

setup_arch: enter

setup_arch: bootmem

arch: exit

=20

Would you please help us to solve it and explain the cause?

=20

Best regards!

=20

Sincerely yours,

Henry


------_=_NextPart_001_01C8C728.220488FF
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><o:SmartTagType
 namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags" =
name=3D"PersonName"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:monospace;
	panose-1:0 0 0 0 0 0 0 0 0 0;}
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
	{color:blue;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 @list l0
	{mso-list-id:447743645;
	mso-list-type:hybrid;
	mso-list-template-ids:-1180252762 67698705 67698713 67698715 67698703 =
67698713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-text:"%1\)";
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level2
	{mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level3
	{mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level4
	{mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level5
	{mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level6
	{mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level7
	{mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level8
	{mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level9
	{mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1
	{mso-list-id:493759590;
	mso-list-type:hybrid;
	mso-list-template-ids:-1231364828 67698705 67698713 67698715 67698703 =
67698713 67698715 67698703 67698713 67698715;}
@list l1:level1
	{mso-level-text:"%1\)";
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dblue>

<div class=3DSection1>

<div>

<p class=3DMsoNormal><font size=3D3 color=3Dnavy face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:navy'>Hi Henry. I recently migrated to
ARCH=3Dpowerpc on 2.6.24 from ARCH=3Dppc on 2.6.16 (having obtained a =
distribution
from the ltib project).<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dnavy face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:navy'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D3 color=3Dnavy face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:navy'>The ppc architecture is nearing =
end-of-life
as far as development goes, so I recommend jumping to powerpc now. In =
mey
recent experience I encountered better driver support, and I generally =
noticed
that future patching/development would support ARCH=3Dpowerpc. I think =
the old
ppc implied embedded (or non-mac) architectures, while the powerpc was =
intended
for mac desktops. I might be wrong, but it looks like the two have =
merged.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dnavy face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:navy'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D3 color=3Dnavy face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:navy'>This architecture issue =
doesn&#8217;t speak
directly to your question, but if you could get 2.6.25 working with
ARCH=3Dpowerpc on your lite5200b then you and I would be working with =
basically
the same set-up and I could help you better. For now, here are a few =
questions:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dnavy face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:navy'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoNormal =
style=3D'margin-left:.5in;text-indent:-.25in;mso-list:l0 level1 =
lfo1'><![if !supportLists]><font
size=3D3 color=3Dnavy face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;
color:navy'><span style=3D'mso-list:Ignore'>1)<font size=3D1 =
face=3D"Times New Roman"><span
style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></font></span></span></font><![endif]><font
color=3Dnavy><span style=3D'color:navy'>Have you successfully NFS =
mounted your
rootfs and not woried about the RAMdisk at this =
point?<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:.5in;text-indent:-.25in;mso-list:l0 level1 =
lfo1'><![if !supportLists]><font
size=3D3 face=3D"Times New Roman"><span style=3D'font-size:12.0pt'><span
style=3D'mso-list:Ignore'>2)<font size=3D1 face=3D"Times New =
Roman"><span
style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></font></span></span></font><![endif]><font
color=3Dnavy><span style=3D'color:navy'>Maybe you are using =
ARCH=3Dpowerpc, but your
comment </span></font>in /arch/ppc/configs/ has me confused. Did you =
mean in
/arch/powerpc/configs/ ?<o:p></o:p></p>

<p class=3DMsoNormal><font size=3D3 color=3Dnavy face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:navy'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D3 color=3Dnavy face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:navy'>Please clarify if you are using
ARCH=3Dpowerpc and I think I can be of more assistance. For example, on =
my 2.6.24
kernel I needed to&#8230;<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:.5in;text-indent:-.25in;mso-list:l1 level1 =
lfo2'><![if !supportLists]><font
size=3D3 color=3Dnavy face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;
color:navy'><span style=3D'mso-list:Ignore'>1)<font size=3D1 =
face=3D"Times New Roman"><span
style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></font></span></span></font><![endif]><font
color=3Dnavy><span style=3D'color:navy'>Halve the memory sive specified =
in
lite5200b.dts. It specified twice as much memory as is actually on my
lite5200b, causing a strange, long delay at boot time as page =
initialization
attempted to operate on a bunch of non-existent memory, near as I can =
tell. The
symptom was around 30-45 seconds of delay between U-boot boot and any =
console
output. Weird, but I figured it had something to do with RAM =
initialization
only after getting my BDI2000 JTAG debugger going and breaking to see =
that the
kernel appears stuck on something related to initializing the RAM. This =
drove
me to discover the size spec is wrong in the dts =
file.<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:.5in;text-indent:-.25in;mso-list:l1 level1 =
lfo2'><![if !supportLists]><font
size=3D3 face=3D"Times New Roman"><span style=3D'font-size:12.0pt'><span
style=3D'mso-list:Ignore'>2)<font size=3D1 face=3D"Times New =
Roman"><span
style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></font></span></span></font><![endif]><font
color=3Dnavy><span style=3D'color:navy'>If you need edge-sensitive =
interrupts you&#8217;ll
need a set interrupt type callback. Mpc52xx_pic.c is missing this =
callback.
Check another powerpc architecture for set_interrupt_type. I would =
upload a
patch but it turns out I am fine with level-sensitive only so I =
didn&#8217;t go
through the trouble of formalizing a fix for =
this.</span></font><o:p></o:p></p>

<p class=3DMsoNormal =
style=3D'margin-left:.5in;text-indent:-.25in;mso-list:l1 level1 =
lfo2'><![if !supportLists]><font
size=3D3 face=3D"Times New Roman"><span style=3D'font-size:12.0pt'><span
style=3D'mso-list:Ignore'>3)<font size=3D1 face=3D"Times New =
Roman"><span
style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></font></span></span></font><![endif]><font
color=3Dnavy><span style=3D'color:navy'>SPI driver for SPI peripheral =
(not PSC): this
is missing but there is a patch for it. Tell me if you need it and =
I&#8217;ll
direct you).</span></font><o:p></o:p></p>

<p class=3DMsoNormal =
style=3D'margin-left:.5in;text-indent:-.25in;mso-list:l1 level1 =
lfo2'><![if !supportLists]><font
size=3D3 face=3D"Times New Roman"><span style=3D'font-size:12.0pt'><span
style=3D'mso-list:Ignore'>4)<font size=3D1 face=3D"Times New =
Roman"><span
style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></font></span></span></font><![endif]><font
color=3Dnavy><span style=3D'color:navy'>IN GENERAL, THE DEVICE TREE =
CONCEPT IS
COOL, BUT IT HAS A LEARNING CURVE. I can help you. For example, just =
requesting
an external IRQ requires creating a &#8220;device&#8221; node so that =
you can
associate a specific IRQ number with said device for easy access from =
your
module driver code at run time. Basically, ALL register access is done =
by
run-time parsing of the device tree information, NOT by simply direct =
register
access, given a bunch of defined address constants in some header =
file.</span></font><o:p></o:p></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D3 =
color=3Dnavy
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;color:navy'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D3 =
color=3Dnavy
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;color:navy'>Sorry if none
of this helps, but I just recently clawed my way up the learning curve =
so some
of the wounds are fresh. Hopefully I can provide a bit of guidance on =
the easy
concepts.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D3 =
color=3Dnavy
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;color:navy'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D3 =
color=3Dnavy
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;color:navy'>-Mike</span></font><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><font =
size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>

<hr size=3D2 width=3D"100%" align=3Dcenter tabindex=3D-1>

</span></font></div>

<p class=3DMsoNormal><b><font size=3D2 face=3DTahoma><span =
style=3D'font-size:10.0pt;
font-family:Tahoma;font-weight:bold'>From:</span></font></b><font =
size=3D2
face=3DTahoma><span style=3D'font-size:10.0pt;font-family:Tahoma'>
linuxppc-embedded-bounces+mike_timmons=3Dtrimble.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+mike_timmons=3Dtrimble.com@ozlabs.org] =
<b><span
style=3D'font-weight:bold'>On Behalf Of </span></b>Henry Chen<br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Tuesday, June 03, =
2008 9:55
PM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> <st1:PersonName =
w:st=3D"on">linuxppc-embedded@ozlabs.org</st1:PersonName><br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> Is the =
linux-2.6.25.4
compatible with freescale lite5200b?</span></font><o:p></o:p></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Hi, all expert!<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Thank you for your&nbsp;patience.<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>I want to use Linux as the OS of freescale lite5200b develop =
board.
Then I have tried two version of kernel, <a =
href=3D"http://2.6.25.4">2.6.25.4</a>
and <a href=3D"http://2.4.25.">2.4.25.</a><o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>We succeed in 2.4.25, failed in <a =
href=3D"http://2.6.25.4">2.6.25.4</a>.&nbsp;We
use the default config file for the board, =
lite5200_defconfig,&nbsp;which would
be found both in /arch/ppc/configs/. And we use the same ramdisk. The =
following
info is about the error of <a =
href=3D"http://2.6.15.4">2.6.15.4</a>.<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><em><i><font size=3D3 face=3Dmonospace><span =
style=3D'font-size:
12.0pt;font-family:monospace'>=3D&gt; bootm fe000000 =
fe200000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font></i></em><i><font face=3Dmonospace><span =
style=3D'font-family:monospace;
font-style:italic'><br>
<em><i><font face=3Dmonospace><span style=3D'font-family:monospace'>## =
Booting image
at fe000000 =
...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font></i></em><br>
<em><i><font face=3Dmonospace><span =
style=3D'font-family:monospace'>&nbsp;&nbsp;
Image Name:&nbsp;&nbsp; =
Linux-2.6.25&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;
</span></font></i></em><br>
<em><i><font face=3Dmonospace><span =
style=3D'font-family:monospace'>&nbsp;&nbsp;
Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip =
compressed)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font></i></em><br>
<em><i><font face=3Dmonospace><span =
style=3D'font-family:monospace'>&nbsp;&nbsp;
Data Size:&nbsp;&nbsp;&nbsp; 802989 Bytes =3D 784.2 =
kB&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;
</span></font></i></em><br>
<em><i><font face=3Dmonospace><span =
style=3D'font-family:monospace'>&nbsp;&nbsp;
Load Address: =
00000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font></i></em><br>
<em><i><font face=3Dmonospace><span =
style=3D'font-family:monospace'>&nbsp;&nbsp;
Entry Point:&nbsp; =
00000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font></i></em><br>
<em><i><font face=3Dmonospace><span =
style=3D'font-family:monospace'>&nbsp;&nbsp;
Uncompressing Kernel Image ... =
OK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font></i></em><br>
<em><i><font face=3Dmonospace><span style=3D'font-family:monospace'>## =
Loading
RAMDisk Image at fe200000 =
...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;
</span></font></i></em><br>
<em><i><font face=3Dmonospace><span =
style=3D'font-family:monospace'>&nbsp;&nbsp;
Image Name:&nbsp;&nbsp; rootfs in =
flash&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font></i></em><br>
<em><i><font face=3Dmonospace><span =
style=3D'font-family:monospace'>&nbsp;&nbsp;
Image Type:&nbsp;&nbsp; PowerPC Linux RAMDisk Image (gzip =
compressed)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font></i></em><br>
<em><i><font face=3Dmonospace><span =
style=3D'font-family:monospace'>&nbsp;&nbsp;
Data Size:&nbsp;&nbsp;&nbsp; 5055519 Bytes =3D&nbsp; 4.8 =
MB&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;
</span></font></i></em><br>
<em><i><font face=3Dmonospace><span =
style=3D'font-family:monospace'>&nbsp;&nbsp;
Load Address: =
fe5a0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font></i></em><br>
<em><i><font face=3Dmonospace><span =
style=3D'font-family:monospace'>&nbsp;&nbsp;
Entry Point:&nbsp; =
fe5a0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font></i></em><br>
<em><i><font face=3Dmonospace><span =
style=3D'font-family:monospace'>&nbsp;&nbsp;
Loading Ramdisk to 0fa7c000, end 0ff4e41f ... =
OK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
</span></font></i></em><br>
<em><i><font face=3Dmonospace><span style=3D'font-family:monospace'>id =
mach(): =
done&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
</span></font></i></em><br>
<em><i><font face=3Dmonospace><span =
style=3D'font-family:monospace'>MMU:enter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
</span></font></i></em><br>
<em><i><font face=3Dmonospace><span =
style=3D'font-family:monospace'>MMU:hw =
init&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font></i></em><br>
<em><i><font face=3Dmonospace><span =
style=3D'font-family:monospace'>MMU:mapin&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
</span></font></i></em><br>
<em><i><font face=3Dmonospace><span =
style=3D'font-family:monospace'>MMU:setio&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font></i></em><br>
<em><i><font face=3Dmonospace><span =
style=3D'font-family:monospace'>MMU:exit&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font></i></em><br>
<em><i><font face=3Dmonospace><span =
style=3D'font-family:monospace'>setup_arch:
enter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
</span></font></i></em><br>
<em><i><font face=3Dmonospace><span =
style=3D'font-family:monospace'>setup_arch:
bootmem&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;
</span></font></i></em><br>
<em><i><font face=3Dmonospace><span =
style=3D'font-family:monospace'>arch: =
exit</span></font></i></em></span></font></i><o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Would you please help us to solve it and explain the =
cause?<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Best regards!<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Sincerely yours,<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Henry<o:p></o:p></span></font></p>

</div>

</div>

</body>

</html>

------_=_NextPart_001_01C8C728.220488FF--
