Return-Path: <christophe.alayrac@cresitt.com>
Received: from smtp3-g19.free.fr (smtp3-g19.free.fr [212.27.42.29])
	by ozlabs.org (Postfix) with ESMTP id EA9E167D86
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 13 Nov 2006 18:47:32 +1100 (EST)
Received: from CRESITTLAB (sou45-1-82-229-118-71.fbx.proxad.net
	[82.229.118.71])
	by smtp3-g19.free.fr (Postfix) with ESMTP id C569444706
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 13 Nov 2006 08:47:29 +0100 (CET)
From: "alayrac" <christophe.alayrac@cresitt.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Modules Problem on ML403
Date: Mon, 13 Nov 2006 08:47:26 +0100
Message-ID: <006801c706f7$f671a440$c900a8c0@CRESITTLAB>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0069_01C70700.58360C40"
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

------=_NextPart_000_0069_01C70700.58360C40
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi all,
 
I succeed to port linux2-4.26 on ML403 board with Montavista RFS on CF
or NFS.
 
Problems arise when I try to use modules.
I have included gpio modules in the kernel and build follow
 
make ARCH=ppc CROSS_COMPILE=powerpc-405-linux-gnu- dep uImage
make ARCH=ppc CROSS_COMPILE=powerpc-405-linux-gnu- modules the
modules_install
 
The last make command fail during depmod process because it did not
supports cross compiling
 
I've then think to use the Klingauf scripts
(make_modules_install.sh,depmod.pl) but I was afraid that the command 
make modules_install copy modules in the host lib/modules directory.
 
So I manually proceed as follow from the kernel root :
make ARCH=ppc CROSS_COMPILE=powerpc-405-linux-gnu- modules_install
INSTALL_MOD_PATH=/home/alayrac/
 
and then 
./depmod.pl -k ./vmlinux -F ./System.map -b /home/alayrac/lib/modules -n
> /home/alayrac/lib/modules/2.4.26/modules.dep
 
Modules seems to be created properly but after board and linux start up
I receive the following error message:
 
$>insmod xilinx_gpio
Using /lib/modules/2.4.26/kernel/drivers/char/xilinx_gpio/xilinx_gpio.o
/lib/modules/2.4.26/kernel/drivers/char/xilinx_gpio/xilinx_gpio.o:
couldn't find the kernel version the module was compiled for
 
$>modprobe xilinx_gpio
/lib/modules/2.4.26/kernel/drivers/char/xilinx_gpio/xilinx_gpio.o:
couldn't find the kernel version the module was compiled
for/lib/modules/2.4.26/kernel/drivers/char/xilinx_gpio/xilinx_gpio.o:
insmod
/lib/modules/2.4.26/kernel/drivers/char/xilinx_gpid/lib/modules/2.4.26/k
ernel/drivers/char/xilinx_gpio.o: couldn't find the kernel version the
module was compiled for
/lib/modules/2.4.26/kernel/drivers/char/xilinx_gpio.o:
insmod /lib/modules/2.4.26/kernel/drivers/char/xilinx_gpio.o failed
/lib/modules/2.4.26/kernel/drivers/char/xilinx_gpio.o: insmod
xilinx_gpio failed
 
Further more the date of files in /lib/modules/2.4.26 are modified to
old date during the boot process (I think its because there is no real
time clock on ML403). Thus the modules.conf is declared as more recent
than modules.dep.
 
Any help would be appreciated .
 
Kinds regards
 
Chris
 
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
<https://ozlabs.org/mailman/listinfo/linuxppc-embedded>
https://ozlabs.org/mailman/listinfo/linuxppc-embedded

------=_NextPart_000_0069_01C70700.58360C40
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">


<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 10">
<meta name=3DOriginator content=3D"Microsoft Word 10">
<link rel=3DFile-List href=3D"cid:filelist.xml@01C70700.57C60C60">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PersonName"/>
<!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:DoNotRelyOnCSS/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:SpellingState>Clean</w:SpellingState>
  <w:GrammarState>Clean</w:GrammarState>
  <w:DocumentKind>DocumentEmail</w:DocumentKind>
  <w:HyphenationZone>21</w:HyphenationZone>
  <w:EnvelopeVis/>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
 </w:WordDocument>
</xml><![endif]--><!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0cm;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;
	text-underline:single;}
p.MsoAutoSig, li.MsoAutoSig, div.MsoAutoSig
	{margin:0cm;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";}
span.StyleCourrierlectronique17
	{mso-style-type:personal-compose;
	mso-style-noshow:yes;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Arial;
	mso-ascii-font-family:Arial;
	mso-hansi-font-family:Arial;
	mso-bidi-font-family:Arial;
	color:windowtext;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:70.85pt 70.85pt 70.85pt 70.85pt;
	mso-header-margin:35.4pt;
	mso-footer-margin:35.4pt;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 10]>
<style>
 /* Style Definitions */=20
 table.MsoNormalTable
	{mso-style-name:"Tableau Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-parent:"";
	mso-padding-alt:0cm 5.4pt 0cm 5.4pt;
	mso-para-margin:0cm;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman";}
</style>
<![endif]-->
</head>

<body lang=3DFR link=3Dblue vlink=3Dpurple =
style=3D'tab-interval:35.4pt'>

<div class=3DSection1>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'>Hi =
all,<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier =
New";mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'>I succeed to port linux2-4.26 on =
ML403
board with Montavista RFS on CF or NFS.<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier =
New";mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'>Problems arise when I try to use
modules.<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'>I have included gpio modules in =
the
kernel and build follow<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier =
New";mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'>make ARCH=3Dppc
CROSS_COMPILE=3Dpowerpc-405-linux-gnu- dep =
uImage<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'>make ARCH=3Dppc
CROSS_COMPILE=3Dpowerpc-405-linux-gnu- modules the =
modules_install<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier =
New";mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'>The last make command fail during =
depmod
process because it did not supports cross =
compiling<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier =
New";mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'>I've then think to use the =
Klingauf
scripts (make_modules_install.sh,depmod.pl) but I was afraid that the =
command <o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'>make modules_install copy modules =
in the
host lib/modules directory.<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier =
New";mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'>So I manually proceed as follow =
from the
kernel root :<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'>make ARCH=3Dppc
CROSS_COMPILE=3Dpowerpc-405-linux-gnu- modules_install =
INSTALL_MOD_PATH=3D/home/</span></font><st1:PersonName><font
 size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
 "Courier =
New";mso-ansi-language:EN-GB'>alayrac</span></font></st1:PersonName><font=

size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'>/<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier =
New";mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'>and then =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'>./depmod.pl -k ./vmlinux -F =
./System.map
-b /home/</span></font><st1:PersonName><font size=3D2 face=3D"Courier =
New"><span
 lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New";mso-ansi-language:
 EN-GB'>alayrac</span></font></st1:PersonName><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New";mso-ansi-language:
EN-GB'>/lib/modules &#8211;n &gt; =
/home/</span></font><st1:PersonName><font
 size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
 "Courier =
New";mso-ansi-language:EN-GB'>alayrac</span></font></st1:PersonName><font=

size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier =
New";mso-ansi-language:EN-GB'>/lib/modules/2.4.26/modules.dep<o:p></o:p><=
/span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier =
New";mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'>Modules seems to be created =
properly but
after board and linux start up I receive the following error =
message:<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier =
New";mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'>$&gt;insmod =
xilinx_gpio<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'>Using
/lib/modules/2.4.26/kernel/drivers/char/xilinx_gpio/xilinx_gpio.o<o:p></o=
:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier =
New";mso-ansi-language:EN-GB'>/lib/modules/2.4.26/kernel/drivers/char/xil=
inx_gpio/xilinx_gpio.o:<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'>couldn't find the kernel version =
the
module was compiled for<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier =
New";mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'>$&gt;modprobe =
xilinx_gpio<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier =
New";mso-ansi-language:EN-GB'>/lib/modules/2.4.26/kernel/drivers/char/xil=
inx_gpio/xilinx_gpio.o:<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'>couldn't find the kernel version =
the
module was compiled =
for/lib/modules/2.4.26/kernel/drivers/char/xilinx_gpio/xilinx_gpio.o:<o:p=
></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'>insmod
/lib/modules/2.4.26/kernel/drivers/char/xilinx_gpid/lib/modules/2.4.26/ke=
rnel/drivers/char/xilinx_gpio.o:
couldn't find the kernel version the module was compiled =
for<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier =
New";mso-ansi-language:EN-GB'>/lib/modules/2.4.26/kernel/drivers/char/xil=
inx_gpio.o:<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'>insmod =
/lib/modules/2.4.26/kernel/drivers/char/xilinx_gpio.o
failed<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier =
New";mso-ansi-language:EN-GB'>/lib/modules/2.4.26/kernel/drivers/char/xil=
inx_gpio.o:
insmod xilinx_gpio failed<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier =
New";mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'>Further more the date of files in
/lib/modules/2.4.26 are modified to old date during the boot process (I =
think
its because there is no real time clock on ML403). Thus the modules.conf =
is
declared as more recent than modules.dep.<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier =
New";mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'>Any help would be appreciated =
.<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier =
New";mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'>Kinds =
regards<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier =
New";mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier =
New";mso-ansi-language:EN-GB'>Chris<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier =
New";mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier =
New";mso-ansi-language:EN-GB'>___________________________________________=
____<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'>Linuxppc-embedded mailing =
list<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D3 face=3D"Times New Roman"><span lang=3DEN-GB =
style=3D'font-size:12.0pt;
mso-ansi-language:EN-GB'>Linuxppc-embedded@ozlabs.org </span><a
href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded"><span =
lang=3DEN-GB
style=3D'mso-ansi-language:EN-GB'>https://ozlabs.org/mailman/listinfo/lin=
uxppc-embedded</span></a></font><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'><o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0069_01C70700.58360C40--
