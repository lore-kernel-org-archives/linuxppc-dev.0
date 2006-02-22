Return-Path: <tlopez@aotek.es>
Received: from correo2.sarenet.es (correo2.sarenet.es [194.30.0.12])
	by ozlabs.org (Postfix) with ESMTP id 83F54679F5
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Feb 2006 19:14:46 +1100 (EST)
Received: from ntvir (unknown [212.81.206.17])
	by correo2.sarenet.es (Postfix) with ESMTP id 40B1335F8B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Feb 2006 08:53:52 +0100 (CET)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C63785.1E83F52F"
Subject: RE: boot failure on lite5200b board
Date: Wed, 22 Feb 2006 08:53:48 +0100
Message-ID: <918EB199DDDFFA42BEA2EB3A1C6021F3A91897@correo.fagorautomation.net>
From: "TXEMA LOPEZ" <tlopez@aotek.es>
To: "#LI JIANGGAN#" <lijianggan@pmail.ntu.edu.sg>
Cc: linuxppc-embedded@ozlabs.org
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

------_=_NextPart_001_01C63785.1E83F52F
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Li,
I'm working on a lite5200b too but with a 2.4.25 kernel. Anyway, I found =
some problems to launch the 2.4.25 kernel from the U-Boot version that =
comes with the board from Freescale. I fixed some bugs in this U-Boot =
version and sent a patch for the U-Boot 1.1.4 version to the U-Boot =
users mailing list. The patch is not yet accepted and added to the git =
repository but I suggest that you apply this patch and try it again.
Another suggestion is not to use a low address to copy the kernel image =
(in your case 0x100000, try 0x500000 by example). The kernel is =
decompressed at the 0 address and your kernel could be overlapped.
=20
Good luck,
Jose Maria Lopez.
=20
-----Mensaje original-----
De: linuxppc-embedded-bounces+tlopez=3Dfagorautomation.es@ozlabs.org =
[mailto:linuxppc-embedded-bounces+tlopez=3Dfagorautomation.es@ozlabs.org]=
En nombre de #LI JIANGGAN#
Enviado el: mi=E9rcoles, 22 de febrero de 2006 5:05
Para: linuxppc-embedded@ozlabs.org
Asunto: boot failure on lite5200b board
=20
Hello all,

For my end-of-study project, I am working on an embedded system with =
reference of freescale's lite5200b reference board. I was trying to boot =
Linux 2.6.15 on the board (with the fec and bestcomm corrected). however =
the booting was stuck at the following stage:
U-Boot 1.1.3 (Feb  6 2006 - 09:56:46)

## Booting image at 00100000 ...
   Image Name:   Linux-2.6.16-rc1
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    658050 Bytes =3D 642.6 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
id mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:setio
MMU:exit
setup_arch: enter
setup_arch: bootmem
arch: exit

I think it's probably the problem of kernel configuration prior to =
compilation. Has anybody got 2.6 kernel working probably lite5200b?

THE U-BOOT ENVIRONMENT SETTINGS:

=3D> printenv
baudrate=3D115200
autoload=3Dno
ethact=3DFEC ETHERNET
preboot=3Decho;echo Autostarting. Press any key to abort..;echo
bootdelay=3D5
hostname=3Dicecube
flshroot=3Droot=3D/dev/mtdblock2 rw
ethaddr=3D00:01:9F:00:27:2F
rootfs=3Droot=3D/dev/nfs rw nfsroot=3D10.190.3.103:/opt/eldk/rootfs
filesize=3Df2
fileaddr=3D100000
netmask=3D255.255.240.0
serverip=3D10.190.3.103
bootcmd=3Dtftp; bootm
bootfile=3DMPC5200/uImage
ipaddr=3D10.190.3.144
ip=3Dip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube::o=
ff
nfsroot=3Droot=3D/dev/nfs rw nfsroot=3D10.190.3.103:/opt/eldk/rootfs
bootargs=3Droot=3D/dev/nfs rw nfsroot=3D10.190.3.103:/opt/eldk/rootfs =
ip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube::off
stdin=3Dserial
stdout=3Dserial
stderr=3Dserial

Environment size: 704/65532 bytes
=3D>             =20

THE WHLOE BOOTING MESSAGE:

U-Boot 1.1.3 (Feb  6 2006 - 09:56:46)

CPU:   MPC5200 v2.2 at 462 MHz
       Bus 132 MHz, IPB 132 MHz, PCI 33 MHz
Board: Freescale MPC5200 (Lite5200B)
I2C:   85 kHz, ready
DRAM:  256 MB
FLASH: 32 MB
PCI:   Bus Dev VenId DevId Class Int
        00  1a  1057  5809  0680  00
In:    serial
Out:   serial
Err:   serial
Net:   FEC ETHERNET
IDE:   Bus 0: OK
  Device 0: not available
  Device 1: not available

Autostarting. Press any key to abort..

Hit any key to stop autoboot:  0
Using FEC ETHERNET device
TFTP from server 10.190.3.103; our IP address is 10.190.3.144
Filename 'MPC5200/uImage'.
Load address: 0x100000
Loading: =
#################################################################
         =
################################################################
done
Bytes transferred =3D 658114 (a0ac2 hex)
## Booting image at 00100000 ...
   Image Name:   Linux-2.6.16-rc1
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    658050 Bytes =3D 642.6 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
id mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:setio
MMU:exit
setup_arch: enter
setup_arch: bootmem
arch: exit

Thanks.

Jianggan LI

------_=_NextPart_001_01C63785.1E83F52F
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">


<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 9">
<meta name=3DOriginator content=3D"Microsoft Word 9">
<link rel=3DFile-List href=3D"cid:filelist.xml@01C6378D.7ECC6A40">
<title>boot failure on lite5200b board</title>
<!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:DoNotRelyOnCSS/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:Zoom>0</w:Zoom>
  <w:DocumentKind>DocumentEmail</w:DocumentKind>
  <w:HyphenationZone>21</w:HyphenationZone>
  <w:EnvelopeVis/>
  <w:Compatibility>
   <w:ForgetLastTabAlignment/>
   <w:DoNotUseHTMLParagraphAutoSpacing/>
  </w:Compatibility>
 </w:WordDocument>
</xml><![endif]-->
<style>
<!--
 /* Font Definitions */
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:1627421319 -2147483648 8 0 66047 0;}
 /* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0cm;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";}
p.MsoAutoSig, li.MsoAutoSig, div.MsoAutoSig
	{margin:0cm;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";}
p
	{margin-right:0cm;
	mso-margin-top-alt:auto;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";}
span.EstiloCorreo16
	{mso-style-type:personal-reply;
	mso-ansi-font-size:10.0pt;
	mso-ascii-font-family:Arial;
	mso-hansi-font-family:Arial;
	mso-bidi-font-family:Arial;
	color:navy;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:70.85pt 3.0cm 70.85pt 3.0cm;
	mso-header-margin:36.0pt;
	mso-footer-margin:36.0pt;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
-->
</style>
</head>

<body lang=3DES style=3D'tab-interval:35.4pt'>
<!-- Converted from text/plain format -->

<div class=3DSection1>

<p class=3DMsoNormal><span class=3DEstiloCorreo16><font size=3D2 =
color=3Dnavy
face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;mso-bidi-font-size:12.0pt;
font-family:Arial;mso-ansi-language:EN-GB'>Hi =
Li,<o:p></o:p></span></font></span></p>

<p class=3DMsoNormal><span class=3DEstiloCorreo16><font size=3D2 =
color=3Dnavy
face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;mso-bidi-font-size:12.0pt;
font-family:Arial;mso-ansi-language:EN-GB'>I&#8217;m working on a =
lite5200b too but with
a 2.4.25 kernel. Anyway, I found some problems to launch the 2.4.25 =
kernel from
the U-Boot version that comes with the board from Freescale. I fixed =
some bugs
in this U-Boot version and sent a patch for the U-Boot 1.1.4 version to =
the U-Boot
users mailing list. The patch is not yet accepted and added to the git
repository but I suggest that you apply this patch and try it =
again.</span></font></span><span
class=3DEstiloCorreo16><font size=3D2 color=3Dnavy face=3DArial><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;mso-bidi-font-size:12.0pt;font-family:Arial;col=
or:navy;
mso-color-alt:windowtext;mso-ansi-language:EN-GB'><o:p></o:p></span></fon=
t></span></p>

<p class=3DMsoNormal><span class=3DEstiloCorreo16><font size=3D2 =
color=3Dnavy
face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;mso-bidi-font-size:12.0pt;
font-family:Arial;mso-ansi-language:EN-GB'>Another suggestion is not to =
use a
low address to copy the kernel image (in your case 0x100000, try =
0x500000 by
example). The kernel is decompressed at the 0 address and your kernel =
could be
overlapped.</span></font></span><span class=3DEstiloCorreo16><font =
size=3D2
color=3Dnavy face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;mso-bidi-font-size:
12.0pt;font-family:Arial;color:navy;mso-color-alt:windowtext;mso-ansi-lan=
guage:
EN-GB'><o:p></o:p></span></font></span></p>

<p class=3DMsoNormal><span class=3DEstiloCorreo16><font size=3D2 =
color=3Dnavy
face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;mso-bidi-font-size:12.0pt;
font-family:Arial;mso-ansi-language:EN-GB'><![if =
!supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></font></span></p>

<p class=3DMsoNormal><span class=3DEstiloCorreo16><font size=3D2 =
color=3Dnavy
face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;mso-bidi-font-size:12.0pt;
font-family:Arial;mso-ansi-language:EN-GB'>Good =
luck,<o:p></o:p></span></font></span></p>

<p class=3DMsoNormal><span class=3DEstiloCorreo16><font size=3D2 =
color=3Dnavy
face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;mso-bidi-font-size:12.0pt;
font-family:Arial;mso-ansi-language:EN-GB'>Jose Maria =
Lopez.<o:p></o:p></span></font></span></p>

<p class=3DMsoNormal><span class=3DEstiloCorreo16><font size=3D2 =
color=3Dnavy
face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;mso-bidi-font-size:12.0pt;
font-family:Arial;mso-ansi-language:EN-GB'><![if =
!supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></font></span></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3DTahoma><span =
style=3D'font-size:
10.0pt;font-family:Tahoma;color:black'>-----Mensaje original-----<br>
<b><span style=3D'font-weight:bold'>De:</span></b>
linuxppc-embedded-bounces+tlopez=3Dfagorautomation.es@ozlabs.org
[mailto:linuxppc-embedded-bounces+tlopez=3Dfagorautomation.es@ozlabs.org]=
<b><span
style=3D'font-weight:bold'>En nombre de </span></b>#LI JIANGGAN#<br>
<b><span style=3D'font-weight:bold'>Enviado el:</span></b> mi=E9rcoles, =
22 de
febrero de 2006 5:05<br>
<b><span style=3D'font-weight:bold'>Para:</span></b> =
linuxppc-embedded@ozlabs.org<br>
<b><span style=3D'font-weight:bold'>Asunto:</span></b> boot failure on =
lite5200b
board</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><![if =
!supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></font></p>

<p style=3D'margin-bottom:12.0pt'><font size=3D2 color=3Dblack =
face=3D"Times New Roman"><span
lang=3DEN-GB =
style=3D'font-size:10.0pt;color:black;mso-ansi-language:EN-GB'>Hello
all,<br>
<br>
For my end-of-study project, I am working on an embedded system with =
reference
of freescale's lite5200b reference board. I was trying to boot Linux =
2.6.15 on
the board (with the fec and bestcomm corrected). however the booting was =
stuck
at the following stage:<br>
U-Boot 1.1.3 (Feb&nbsp; 6 2006 - 09:56:46)<br>
<br>
## Booting image at 00100000 ...<br>
&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-2.6.16-rc1<br>
&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip
compressed)<br>
&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 658050 Bytes =3D 642.6 kB<br>
&nbsp;&nbsp; Load Address: 00000000<br>
&nbsp;&nbsp; Entry Point:&nbsp; 00000000<br>
&nbsp;&nbsp; Verifying Checksum ... OK<br>
&nbsp;&nbsp; Uncompressing Kernel Image ... OK<br>
id mach(): done<br>
MMU:enter<br>
MMU:hw init<br>
MMU:mapin<br>
MMU:setio<br>
MMU:exit<br>
setup_arch: enter<br>
setup_arch: bootmem<br>
arch: exit<br>
<br>
I think it's probably the problem of kernel configuration prior to =
compilation.
Has anybody got 2.6 kernel working probably lite5200b?<br>
<br>
THE U-BOOT ENVIRONMENT SETTINGS:<br>
<br>
=3D&gt; printenv<br>
baudrate=3D115200<br>
autoload=3Dno<br>
ethact=3DFEC ETHERNET<br>
preboot=3Decho;echo Autostarting. Press any key to abort..;echo<br>
bootdelay=3D5<br>
hostname=3Dicecube<br>
flshroot=3Droot=3D/dev/mtdblock2 rw<br>
ethaddr=3D00:01:9F:00:27:2F<br>
rootfs=3Droot=3D/dev/nfs rw nfsroot=3D10.190.3.103:/opt/eldk/rootfs<br>
filesize=3Df2<br>
fileaddr=3D100000<br>
netmask=3D255.255.240.0<br>
serverip=3D10.190.3.103<br>
bootcmd=3Dtftp; bootm<br>
bootfile=3DMPC5200/uImage<br>
ipaddr=3D10.190.3.144<br>
ip=3Dip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube::o=
ff<br>
nfsroot=3Droot=3D/dev/nfs rw nfsroot=3D10.190.3.103:/opt/eldk/rootfs<br>
bootargs=3Droot=3D/dev/nfs rw nfsroot=3D10.190.3.103:/opt/eldk/rootfs
ip=3D10.190.3.144:10.190.3.103:10.190.3.103:255.255.240.0:icecube::off<br=
>
stdin=3Dserial<br>
stdout=3Dserial<br>
stderr=3Dserial<br>
<br>
Environment size: 704/65532 bytes<br>
=3D&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;<br>
<br>
THE WHLOE BOOTING MESSAGE:<br>
<br>
U-Boot 1.1.3 (Feb&nbsp; 6 2006 - 09:56:46)<br>
<br>
CPU:&nbsp;&nbsp; MPC5200 v2.2 at 462 MHz<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bus 132 MHz, IPB 132 MHz, PCI 33 =
MHz<br>
Board: Freescale MPC5200 (Lite5200B)<br>
I2C:&nbsp;&nbsp; 85 kHz, ready<br>
DRAM:&nbsp; 256 MB<br>
FLASH: 32 MB<br>
PCI:&nbsp;&nbsp; Bus Dev VenId DevId Class Int<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00&nbsp; 1a&nbsp; 1057&nbsp;
5809&nbsp; 0680&nbsp; 00<br>
In:&nbsp;&nbsp;&nbsp; serial<br>
Out:&nbsp;&nbsp; serial<br>
Err:&nbsp;&nbsp; serial<br>
Net:&nbsp;&nbsp; FEC ETHERNET<br>
IDE:&nbsp;&nbsp; Bus 0: OK<br>
&nbsp; Device 0: not available<br>
&nbsp; Device 1: not available<br>
<br>
Autostarting. Press any key to abort..<br>
<br>
Hit any key to stop autoboot:&nbsp; 0<br>
Using FEC ETHERNET device<br>
TFTP from server 10.190.3.103; our IP address is 10.190.3.144<br>
Filename 'MPC5200/uImage'.<br>
Load address: 0x100000<br>
Loading: =
#################################################################<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
################################################################<br>
done<br>
Bytes transferred =3D 658114 (a0ac2 hex)<br>
## Booting image at 00100000 ...<br>
&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-2.6.16-rc1<br>
&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip
compressed)<br>
&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 658050 Bytes =3D 642.6 kB<br>
&nbsp;&nbsp; Load Address: 00000000<br>
&nbsp;&nbsp; Entry Point:&nbsp; 00000000<br>
&nbsp;&nbsp; Verifying Checksum ... OK<br>
&nbsp;&nbsp; Uncompressing Kernel Image ... OK<br>
id mach(): done<br>
MMU:enter<br>
MMU:hw init<br>
MMU:mapin<br>
MMU:setio<br>
MMU:exit<br>
setup_arch: enter<br>
setup_arch: bootmem<br>
arch: exit<br>
<br>
Thanks.<br>
<br>
</span></font><font size=3D2 color=3Dblack><span =
style=3D'font-size:10.0pt;
color:black'>Jianggan LI</span></font><font color=3Dblack><span =
style=3D'color:
black;mso-color-alt:windowtext'><o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C63785.1E83F52F--
