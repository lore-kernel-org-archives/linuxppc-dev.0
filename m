Return-Path: <mike_timmons@trimble.com>
Received: from snvl-smtp1.trimble.com (snvl-smtp1.trimble.com [155.63.64.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "snvl-smtp1.trimble.com", Issuer "Trimble CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 891E3DDFAE
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 Jun 2008 18:27:42 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8C7AF.2AD24085"
Subject: RE: Is the linux-2.6.25.4 compatible with freescale lite5200b?
Date: Fri, 6 Jun 2008 01:27:24 -0700
Message-ID: <161B3BAD77161449A144FF054231C3D6022A3550@uss-am-xch-01.am.trimblecorp.net>
In-Reply-To: <dc1bef900806052346k4a9134bo3a995c4bf3f7b3bc@mail.gmail.com>
References: <70cc19fe0806031955v4478b886k94150ca9c9295a49@mail.gmail.com>
	<161B3BAD77161449A144FF054231C3D6022A32FD@uss-am-xch-01.am.trimblecorp.net>
	<dc1bef900806052346k4a9134bo3a995c4bf3f7b3bc@mail.gmail.com>
From: "Mike Timmons" <mike_timmons@trimble.com>
To: "hong chen" <ghenrychen@gmail.com>,
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

------_=_NextPart_001_01C8C7AF.2AD24085
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Henry,

You are closer than you think with the ARCH=3Dpowerpc. You need to load
one more binary file into ram and specify one more address for bootm.
You need to load the device tree blob (DENX addresses this at
http://www.denx.de/wiki/view/DULG/LinuxFDTBlob). Thanks again DENX...

=20

Following your ARCH=3Dpowerpc build you should see a NEW file in your
build output: rootfs/boot/lite5200b.dtb

=20

Simply tftp that file to a RAM location on your target that WILL NOT
overlap the kernel image (for obvious reasons:-))

=20

Then, alter your bootm command with a SECOND address indicating where
this BLOB was placed when it was tftp'd into your RAM. In my case, I
unpack (tftp) my kernel to 0x200000 and I tftp my dtb file to 400000 so
my bootm command from the u-boot prompt looks like the following. Yes,
you need that little dash there (If your U-boot doesn't like this
command then you probably have an old U-boot version and you will need
to upgrade your U-boot. I'm using U-boot 1.3.1 and it works for me) =20

=20

-> bootm 200000 - 400000

=20

Rather than give you the dts file (it is the device tree that gets
"compiled" to create the dtb file when you build the kernel), let me
simply tell you one thing you need to change:

=20

1)       edit arch/powerpc/boot/dts/lite5200b.dts

a.       change line 45 to:        reg =3D <00000000 8000000>   // =
change
to 128M from 256M.

=20

Do these two things and I think you will happily boot your 2.6.25 kernel
as ARCH=3Dpowerpc.

=20

Once you are this far you will need to get familiar with the
lite5200b.dts "device tree" if you are porting this to a custom board
and/or adding HW or wanting to use external IRQs. Let's save for later.

=20

On the subject of your wireless card, you can look for driver or write
your own PCI driver. Now that you are running the latest kernel (2.6.25)
I recommend you study the following books:

=20

BOOK

Essential Linux Device Drivers <http://safari.oreilly.com/9780132396554>


By=20

Sreekrishnan Venkateswaran
<http://www.informit.com/authors/author_bio.aspx?ISBN=3D9780132396554>=20

=20

BOOK

Linux Device Drivers, 3rd Edition <http://safari.oreilly.com/0596005903>


By=20

Jonathan Corbet
<http://www.oreillynet.com/cs/catalog/view/au/592?x-t=3Dbook.view> ; =
Greg
Kroah-Hartman
<http://www.oreillynet.com/cs/catalog/view/au/2077?x-t=3Dbook.view> ;
Alessandro Rubini
<http://www.oreillynet.com/cs/catalog/view/au/461?x-t=3Dbook.view>=20

=20

A $20 per-month subscription to safari.oreilly.com will get you access
to these and MANY MORE titles (you might even be able to try it for
free).

=20

=20

-Mike

=20

________________________________

From: hong chen [mailto:ghenrychen@gmail.com]=20
Sent: Friday, June 06, 2008 1:46 AM
To: Mike Timmons
Subject: Re: Is the linux-2.6.25.4 compatible with freescale lite5200b?

=20

Hi, Mike. I greatly appreciate your guidance. I am a green hand at
embedded linux.

=20

I clarify that I used ARCH=3Dppc. And I indeed used the config file in
/arch/ppc/configs/. Furthermore, I ought to have successfully NFS
mounted my rootfs, considering that I succeeded in running the
linux-2.4.25 and NFS mounting my rootfs. (Does the different kernel
influence the NFS rootfs?)

=20

Today, I have tested ARCH=3Dpowerpc, just to obtaind the following =
result:

=20

=3D> bootm fe000000
## Booting image at fe000000 ...
   Image Name:   Linux-2.6.26-rc4-01178-g1f01800-
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1339544 Bytes =3D  1.3 MB
   Load Address: 00000000
   Entry Point:  00000000
   Uncompressing Kernel Image ... OK

<------The U-boot stopped here. I seems to be worse than ever.

=20

Then I have another question: how to set the $CROSS_COMPILE? ppc_6xx- or
powerpc-linux-?

I set CROSS_COMPILE=3D/opt/eldk/usr/bin/ppc_6xx- in the top Makefile. My
toolchain is ELDK 4.2.

=20

Mike, would you please send me lite5200b.dts and other patch about
lite5200b? I want to compare and do some patch. I think they are useful
for me. I want to make some wireless application based on this board
next. I have an 802.11n wireless card. And I want to plug it into PCI
port.

=20

-Henry

=20


------_=_NextPart_001_01C8C7AF.2AD24085
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
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
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
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
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
span.tenpxbold1
	{font-weight:bold;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 @list l0
	{mso-list-id:1136265033;
	mso-list-type:hybrid;
	mso-list-template-ids:796190076 67698705 67698713 67698715 67698703 =
67698713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-text:"%1\)";
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level2
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

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Henry,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>You are closer than you think with =
the
ARCH=3Dpowerpc. You need to load one more binary file into ram and =
specify one
more address for bootm. You need to load the device tree blob (DENX =
addresses
this at <a =
href=3D"http://www.denx.de/wiki/view/DULG/LinuxFDTBlob">http://www.denx.d=
e/wiki/view/DULG/LinuxFDTBlob</a>).
Thanks again DENX&#8230;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Following your ARCH=3Dpowerpc build =
you
should see a NEW file in your build output: =
rootfs/boot/lite5200b.dtb<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Simply tftp that file to a RAM =
location on
your target that WILL NOT overlap the kernel image (for obvious =
reasons</span></font><font
size=3D2 color=3Dnavy face=3DWingdings><span =
style=3D'font-size:10.0pt;font-family:
Wingdings;color:navy'>J</span></font><font size=3D2 color=3Dnavy =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>)<o:p></o:p></spa=
n></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Then, alter your bootm command with =
a SECOND
address indicating where this BLOB was placed when it was tftp&#8217;d =
into
your RAM. In my case, I unpack (tftp) my kernel to 0x200000 and I tftp =
my dtb
file to 400000 so my bootm command from the u-boot prompt looks like the
following. Yes, you need that little dash there (If your U-boot =
doesn&#8217;t
like this command then you probably have an old U-boot version and you =
will
need to upgrade your U-boot. I&#8217;m using U-boot 1.3.1 and it works =
for me) &nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>-&gt; </span></font><font size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'>bootm
200000 - 400000</span></font><font size=3D2 color=3Dnavy =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy'><o:p></o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Rather than give you the dts file =
(it is
the device tree that gets &#8220;compiled&#8221; to create the dtb file =
when
you build the kernel), let me simply tell you one thing you need to =
change:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:.5in;text-indent:-.25in;mso-list:l0 level1 =
lfo1'><![if !supportLists]><font
size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial;
color:navy'><span style=3D'mso-list:Ignore'>1)<font size=3D1 =
face=3D"Times New Roman"><span
style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></font></span></span></font><![endif]><font
size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial;
color:navy'>edit =
arch/powerpc/boot/dts/lite5200b.dts<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:1.0in;text-indent:-.25in;mso-list:l0 level2 =
lfo1'><![if !supportLists]><font
size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial;
color:navy'><span style=3D'mso-list:Ignore'>a.<font size=3D1 =
face=3D"Times New Roman"><span
style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></font></span></span></font><![endif]><font
size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial;
color:navy'>change line 45 to:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
reg =3D
&lt;00000000 8000000&gt;&nbsp;&nbsp; // change to 128M from =
256M.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Do these two things and I think you =
will
happily boot your 2.6.25 kernel as =
ARCH=3Dpowerpc.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Once you are this far you will need =
to get
familiar with the lite5200b.dts &#8220;device tree&#8221; if you are =
porting
this to a custom board and/or adding HW or wanting to use external IRQs. =
Let&#8217;s
save for later.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>On the subject of your wireless =
card, you
can look for driver or write your own PCI driver. Now that you are =
running the
latest kernel (2.6.25) I recommend you study the following =
books:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<table class=3DMsoNormalTable border=3D0 cellspacing=3D0 cellpadding=3D0 =
width=3D"100%"
 style=3D'width:100.0%'>
 <tr>
  <td valign=3Dtop style=3D'padding:0in 0in 0in 0in'>
  <p class=3DMsoNormal><span class=3Dtenpxbold1><b><font size=3D1 =
color=3Dblack
  face=3D"Times New Roman"><span =
style=3D'font-size:7.5pt;color:black'>BOOK</span></font></b></span><font
  size=3D1 color=3Dblack><span =
style=3D'font-size:8.5pt;color:black'><o:p></o:p></span></font></p>
  </td>
 </tr>
 <tr>
  <td valign=3Dtop style=3D'padding:0in 0in 0in 0in'>
  <p class=3DMsoNormal><font size=3D1 color=3Dblack face=3D"Times New =
Roman"><span
  style=3D'font-size:8.5pt;color:black'><a
  href=3D"http://safari.oreilly.com/9780132396554"
  title=3D"Essential Linux Device Drivers"><b><font size=3D1><span
  style=3D'font-size:7.5pt;font-weight:bold'>Essential Linux Device =
Drivers</span></font></b></a><o:p></o:p></span></font></p>
  </td>
 </tr>
 <tr>
  <td valign=3Dtop style=3D'padding:0in 0in 0in 0in'>
  <table class=3DMsoNormalTable border=3D0 cellspacing=3D0 =
cellpadding=3D0>
   <tr>
    <td valign=3Dtop style=3D'padding:0in 0in 0in 0in'>
    <p class=3DMsoNormal><font size=3D1 color=3Dblack face=3D"Times New =
Roman"><span
    =
style=3D'font-size:8.5pt;color:black'>By&nbsp;<o:p></o:p></span></font></=
p>
    </td>
    <td valign=3Dtop style=3D'padding:0in 0in 0in 0in'>
    <p class=3DMsoNormal><font size=3D1 color=3Dblack face=3D"Times New =
Roman"><span
    style=3D'font-size:8.5pt;color:black'><a
    =
href=3D"http://www.informit.com/authors/author_bio.aspx?ISBN=3D9780132396=
554">Sreekrishnan
    Venkateswaran</a><o:p></o:p></span></font></p>
    </td>
   </tr>
  </table>
  <p class=3DMsoNormal><font size=3D1 color=3Dblack face=3D"Times New =
Roman"><span
  style=3D'font-size:8.5pt;color:black'><o:p></o:p></span></font></p>
  </td>
 </tr>
</table>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<table class=3DMsoNormalTable border=3D0 cellspacing=3D0 cellpadding=3D0 =
width=3D"100%"
 style=3D'width:100.0%'>
 <tr>
  <td valign=3Dtop style=3D'padding:0in 0in 0in 0in'>
  <p class=3DMsoNormal><span class=3Dtenpxbold1><b><font size=3D1 =
color=3Dblack
  face=3D"Times New Roman"><span =
style=3D'font-size:7.5pt;color:black'>BOOK</span></font></b></span><font
  size=3D1 color=3Dblack><span =
style=3D'font-size:8.5pt;color:black'><o:p></o:p></span></font></p>
  </td>
 </tr>
 <tr>
  <td valign=3Dtop style=3D'padding:0in 0in 0in 0in'>
  <p class=3DMsoNormal><font size=3D1 color=3Dblack face=3D"Times New =
Roman"><span
  style=3D'font-size:8.5pt;color:black'><a
  href=3D"http://safari.oreilly.com/0596005903"
  title=3D"Linux Device Drivers, 3rd Edition"><b><font size=3D1><span
  style=3D'font-size:7.5pt;font-weight:bold'>Linux Device Drivers, 3rd =
Edition</span></font></b></a><o:p></o:p></span></font></p>
  </td>
 </tr>
 <tr>
  <td valign=3Dtop style=3D'padding:0in 0in 0in 0in'>
  <table class=3DMsoNormalTable border=3D0 cellspacing=3D0 =
cellpadding=3D0>
   <tr>
    <td valign=3Dtop style=3D'padding:0in 0in 0in 0in'>
    <p class=3DMsoNormal><font size=3D1 color=3Dblack face=3D"Times New =
Roman"><span
    =
style=3D'font-size:8.5pt;color:black'>By&nbsp;<o:p></o:p></span></font></=
p>
    </td>
    <td valign=3Dtop style=3D'padding:0in 0in 0in 0in'>
    <p class=3DMsoNormal><font size=3D1 color=3Dblack face=3D"Times New =
Roman"><span
    style=3D'font-size:8.5pt;color:black'><a
    =
href=3D"http://www.oreillynet.com/cs/catalog/view/au/592?x-t=3Dbook.view"=
>Jonathan
    Corbet</a>; <a
    =
href=3D"http://www.oreillynet.com/cs/catalog/view/au/2077?x-t=3Dbook.view=
">Greg
    Kroah-Hartman</a>; <a
    =
href=3D"http://www.oreillynet.com/cs/catalog/view/au/461?x-t=3Dbook.view"=
>Alessandro
    Rubini</a><o:p></o:p></span></font></p>
    </td>
   </tr>
  </table>
  <p class=3DMsoNormal><font size=3D1 color=3Dblack face=3D"Times New =
Roman"><span
  style=3D'font-size:8.5pt;color:black'><o:p></o:p></span></font></p>
  </td>
 </tr>
 <tr>
  <td valign=3Dtop style=3D'padding:0in 0in 0in 0in'>
  <p class=3DMsoNormal><font size=3D1 color=3Dblack face=3D"Times New =
Roman"><span
  =
style=3D'font-size:8.5pt;color:black'><o:p>&nbsp;</o:p></span></font></p>=

  </td>
 </tr>
</table>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>A $20 per-month subscription to =
safari.oreilly.com
will get you access to these and MANY MORE titles (you might even be =
able to
try it for free).<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>-Mike<o:p></o:p></span></font></p>

<div>

<p class=3DMsoNormal><font size=3D3 color=3Dnavy face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:navy'>&nbsp;</span></font><o:p></o:p></p>=


</div>

<div>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><font =
size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>

<hr size=3D2 width=3D"100%" align=3Dcenter tabindex=3D-1>

</span></font></div>

<p class=3DMsoNormal><b><font size=3D2 face=3DTahoma><span =
style=3D'font-size:10.0pt;
font-family:Tahoma;font-weight:bold'>From:</span></font></b><font =
size=3D2
face=3DTahoma><span style=3D'font-size:10.0pt;font-family:Tahoma'> hong =
chen
[mailto:ghenrychen@gmail.com] <br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Friday, June 06, =
2008 1:46
AM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> Mike Timmons<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> Re: Is the =
linux-2.6.25.4
compatible with freescale lite5200b?</span></font><o:p></o:p></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Hi, Mike. I greatly appreciate your guidance. I am a green hand =
at
embedded linux.<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>I clarify that I used ARCH=3Dppc. And I&nbsp;indeed&nbsp;used =
the config
file in /arch/ppc/configs/. Furthermore, I ought to have successfully =
NFS
mounted&nbsp;my rootfs, considering that
I&nbsp;succeeded&nbsp;in&nbsp;running&nbsp;the linux-2.4.25 and NFS =
mounting my
rootfs. (Does the different kernel influence the NFS =
rootfs?)<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Today, I have tested ARCH=3Dpowerpc, just to obtaind&nbsp;the
following&nbsp;result:<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>=3D&gt; bootm fe000000<br>
## Booting image at fe000000 ...<br>
&nbsp;&nbsp; Image Name:&nbsp;&nbsp; =
Linux-2.6.26-rc4-01178-g1f01800-<br>
&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip
compressed)<br>
&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 1339544 Bytes =3D&nbsp; 1.3 =
MB<br>
&nbsp;&nbsp; Load Address: 00000000<br>
&nbsp;&nbsp; Entry Point:&nbsp; 00000000<br>
&nbsp;&nbsp; Uncompressing Kernel Image ... =
OK<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&lt;------The U-boot stopped here. I seems to be worse than =
ever.<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Then I have another question: how to set the $CROSS_COMPILE? =
ppc_6xx-
or powerpc-linux-?<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>I set CROSS_COMPILE=3D/opt/eldk/usr/bin/ppc_6xx- in the top =
Makefile. My
toolchain is ELDK 4.2.<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Mike, would you please send me lite5200b.dts and other patch =
about
lite5200b? I want to compare and do some patch. I think they are useful =
for me.
I want to make some wireless application based on this board next. I =
have an
802.11n wireless card. And I&nbsp;want to plug it into PCI =
port.<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>-Henry<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

</div>

</body>

</html>

------_=_NextPart_001_01C8C7AF.2AD24085--
