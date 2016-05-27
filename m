Return-Path: <giu.lippolis@gmail.com>
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com
 [IPv6:2a00:1450:400c:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rGc7S1lpgzDqcZ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 May 2016 05:50:28 +1000 (AEST)
Received: by mail-wm0-x244.google.com with SMTP id q62so1424299wmg.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 12:50:28 -0700 (PDT)
Received: from Schopenhauer (x5ce0032d.dyn.telefonica.de. [92.224.3.45])
 by smtp.gmail.com with ESMTPSA id o203sm10094439wmg.22.2016.05.27.12.50.21
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 27 May 2016 12:50:22 -0700 (PDT)
From: "Giuseppe Lippolis" <giu.lippolis@gmail.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: problem with cuImage.mpc834x_mds image
Date: Fri, 27 May 2016 21:50:06 +0200
Message-ID: <003201d1b850$f8bbb280$ea331780$@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_NextPart_000_0033_01D1B861.BC4AC410"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.

------=_NextPart_000_0033_01D1B861.BC4AC410
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear All,

I'm trying with buildroot to build the linux-4.4.3 for an iomega 150d
machine mounting the mpc8347E sys.
Due the old U-Boot version is not possible to use the standard uImage, but
it is needed to set the cuImage target (the one embedding the device tree).
 
I start using the default configuration
arch/powerpc/configs/mpc83xx_defconfig,
and the default device tree mpc834x_mds.
 
In order to enable the console  output during the first linux boot stage I
added the following line at the end of the device tree file:
 
        chosen {
                linux,stdout-path = "/soc8349/
<http://lists.busybox.net/mailman/listinfo/buildroot> serial at 4500";
        };
 
The kernel is compiled and I get the cuImage.mpc834x_mds image.
 
Then I load it on the machine and execute:
 
tftp 0x10000000 cuImage.mpc834x_mds
Speed: 1000, full duplex
Using Freescale TSEC0 device
TFTP from server 192.168.178.36; our IP address is 192.168.178.10
Filename 'cuImage.mpc834x_mds'.
Load address: 0x10000000
Loading: #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         ################################
done
Bytes transferred = 2157489 (20ebb1 hex)
IOMEGA=> bootm 0x10000000
## Booting image at 10000000 ...
   Image Name:   Linux-4.4.3
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    2157425 Bytes =  2.1 MB
   Load Address: 00500000
   Entry Point:  005001f8
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Memory <- <0x0 0x20000000> (512MB)
ethernet0: local-mac-address <- 00:d0:b8:01:d1:9f
ethernet1: local-mac-address <- 9b:e3:00:01:72:6f
CPU clock-frequency <- 0x179a7b00 (396MHz)
CPU timebase-frequency <- 0x3ef1480 (66MHz)
CPU bus-frequency <- 0xfbc5200 (264MHz)
 
zImage starting: loaded at 0x00500000 (sp: 0x1ffb2ce8)
Allocating 0x439a88 bytes for kernel ...
gunzipping (0x00000000 <- 0x0050e000:0x00940fe8)...done 0x422920 bytes
 
Linux/PowerPC load: root=/dev/mtdblock1 ro rootfstype=cramfs devfs=mount
console=ttyS0,115200 init=/linuxrc
Finalizing device tree... flat tree at 0x94d120
 
 
But at this point the process crash and the system is reset.
It should be something near the handover between the first kenel boot stage
and the vmlinux start, but I do not have a jtag to proceed the
investigation.
 
In any case it seems that the execution never entry the vmlinux start
(head_32.S).
 
I try to add this macro at the begin of the file:
 
        .equ cnsladdr, 0xe0004500 (console address txreg)
 
.macro dbg_prnt nid
        lis     r24,  <http://lists.busybox.net/mailman/listinfo/buildroot>
cnsladdr at ha
        addi    r24, r24,
<http://lists.busybox.net/mailman/listinfo/buildroot> cnsladdr at l
        li      r25, 'd'
        stb     r25, 0(r24)
        li      r25, 'b'
        stb     r25, 0(r24)
        li      r25, 'g'
        stb     r25, 0(r24)
        li      r25, '0'
        addi    r25, r25, \nid
        stb     r25, 0(r24)
        li      r25, '\n'
        stb     r25, 0(r24)
.endm
 
 
But I do not see anything in the console.
The problem seems releted to the vmlinux call in arc/powerpc/boot/main.c
 
kentry = (kernel_entry_t) vmlinux.addr;
 
 
Any suggestion?
Bye.

 


------=_NextPart_000_0033_01D1B861.BC4AC410
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><META =
HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 15 =
(filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Vorformatiert Zchn";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.E-MailFormatvorlage17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.HTMLVorformatiertZchn
	{mso-style-name:"HTML Vorformatiert Zchn";
	mso-style-priority:99;
	mso-style-link:"HTML Vorformatiert";
	font-family:"Courier New";
	mso-fareast-language:DE;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 2.0cm 70.85pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DDE =
link=3D"#0563C1" vlink=3D"#954F72"><div class=3DWordSection1><p =
class=3DMsoNormal><span lang=3DEN-GB>Dear =
All,<o:p></o:p></span></p><pre><span lang=3DEN-GB>I'm trying with =
buildroot to build the linux-4.4.3 for an iomega =
150d<o:p></o:p></span></pre><pre><span lang=3DEN-GB>machine mounting the =
mpc8347E sys.<o:p></o:p></span></pre><pre><span lang=3DEN-GB>Due the old =
U-Boot version is not possible to use the standard uImage, =
but<o:p></o:p></span></pre><pre><span lang=3DEN-GB>it is needed to set =
the cuImage target (the one embedding the device =
tree).<o:p></o:p></span></pre><pre><span =
lang=3DEN-GB><o:p>&nbsp;</o:p></span></pre><pre><span lang=3DEN-GB>I =
start using the default configuration<o:p></o:p></span></pre><pre><span =
lang=3DEN-GB>arch/powerpc/configs/mpc83xx_defconfig,<o:p></o:p></span></p=
re><pre><span lang=3DEN-GB>and the default device tree =
mpc834x_mds.<o:p></o:p></span></pre><pre><span =
lang=3DEN-GB><o:p>&nbsp;</o:p></span></pre><pre><span lang=3DEN-GB>In =
order to enable the console&nbsp; output during the first linux boot =
stage I<o:p></o:p></span></pre><pre><span lang=3DEN-GB>added the =
following line at the end of the device tree =
file:<o:p></o:p></span></pre><pre><span =
lang=3DEN-GB><o:p>&nbsp;</o:p></span></pre><pre><span =
lang=3DEN-GB>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chosen =
{<o:p></o:p></span></pre><pre><span =
lang=3DEN-GB>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; linux,stdout-path =3D =
&quot;/soc8349/</span><a =
href=3D"http://lists.busybox.net/mailman/listinfo/buildroot"><span =
lang=3DEN-GB>serial at 4500</span></a><span =
lang=3DEN-GB>&quot;;<o:p></o:p></span></pre><pre><span =
lang=3DEN-GB>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
};<o:p></o:p></span></pre><pre><span =
lang=3DEN-GB><o:p>&nbsp;</o:p></span></pre><pre><span lang=3DEN-GB>The =
kernel is compiled and I get the cuImage.mpc834x_mds =
image.<o:p></o:p></span></pre><pre><span =
lang=3DEN-GB><o:p>&nbsp;</o:p></span></pre><pre><span lang=3DEN-GB>Then =
I load it on the machine and execute:<o:p></o:p></span></pre><pre><span =
lang=3DEN-GB><o:p>&nbsp;</o:p></span></pre><pre><span lang=3DEN-GB>tftp =
0x10000000 cuImage.mpc834x_mds<o:p></o:p></span></pre><pre><span =
lang=3DEN-GB>Speed: 1000, full duplex<o:p></o:p></span></pre><pre><span =
lang=3DEN-GB>Using Freescale TSEC0 =
device<o:p></o:p></span></pre><pre><span lang=3DEN-GB>TFTP from server =
192.168.178.36; our IP address is =
192.168.178.10<o:p></o:p></span></pre><pre><span lang=3DEN-GB>Filename =
'cuImage.mpc834x_mds'.<o:p></o:p></span></pre><pre><span =
lang=3DEN-GB>Load address: 0x10000000<o:p></o:p></span></pre><pre><span =
lang=3DEN-GB>Loading: =
#################################################################<o:p></o=
:p></span></pre><pre><span lang=3DEN-GB>&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;###########################################=
######################<o:p></o:p></span></pre><pre><span =
lang=3DEN-GB>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
#################################################################<o:p></o=
:p></span></pre><pre><span =
lang=3DEN-GB>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
#################################################################<o:p></o=
:p></span></pre><pre><span =
lang=3DEN-GB>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
#################################################################<o:p></o=
:p></span></pre><pre><span =
lang=3DEN-GB>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
#################################################################<o:p></o=
:p></span></pre><pre><span =
lang=3DEN-GB>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
################################<o:p></o:p></span></pre><pre><span =
lang=3DEN-GB>done<o:p></o:p></span></pre><pre><span lang=3DEN-GB>Bytes =
transferred =3D 2157489 (20ebb1 hex)<o:p></o:p></span></pre><pre><span =
lang=3DEN-GB>IOMEGA=3D&gt; bootm =
0x10000000<o:p></o:p></span></pre><pre><span lang=3DEN-GB>## Booting =
image at 10000000 ...<o:p></o:p></span></pre><pre><span =
lang=3DEN-GB>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; =
Linux-4.4.3<o:p></o:p></span></pre><pre><span lang=3DEN-GB>&nbsp;&nbsp; =
Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip =
compressed)<o:p></o:p></span></pre><pre><span lang=3DEN-GB>&nbsp;&nbsp; =
Data Size:&nbsp;&nbsp;&nbsp; 2157425 Bytes =3D&nbsp; 2.1 =
MB<o:p></o:p></span></pre><pre><span lang=3DEN-GB>&nbsp;&nbsp; Load =
Address: 00500000<o:p></o:p></span></pre><pre><span =
lang=3DEN-GB>&nbsp;&nbsp; Entry Point:&nbsp; =
005001f8<o:p></o:p></span></pre><pre><span lang=3DEN-GB>&nbsp;&nbsp; =
Verifying Checksum ... OK<o:p></o:p></span></pre><pre><span =
lang=3DEN-GB>&nbsp;&nbsp; Uncompressing Kernel Image ... =
OK<o:p></o:p></span></pre><pre><span lang=3DEN-GB>Memory &lt;- &lt;0x0 =
0x20000000&gt; (512MB)<o:p></o:p></span></pre><pre><span =
lang=3DEN-GB>ethernet0: local-mac-address &lt;- =
00:d0:b8:01:d1:9f<o:p></o:p></span></pre><pre><span =
lang=3DEN-GB>ethernet1: local-mac-address &lt;- =
9b:e3:00:01:72:6f<o:p></o:p></span></pre><pre><span lang=3DEN-GB>CPU =
clock-frequency &lt;- 0x179a7b00 =
(396MHz)<o:p></o:p></span></pre><pre><span lang=3DEN-GB>CPU =
timebase-frequency &lt;- 0x3ef1480 =
(66MHz)<o:p></o:p></span></pre><pre><span lang=3DEN-GB>CPU bus-frequency =
&lt;- 0xfbc5200 (264MHz)<o:p></o:p></span></pre><pre><span =
lang=3DEN-GB><o:p>&nbsp;</o:p></span></pre><pre><span =
lang=3DEN-GB>zImage starting: loaded at 0x00500000 (sp: =
0x1ffb2ce8)<o:p></o:p></span></pre><pre><span lang=3DEN-GB>Allocating =
0x439a88 bytes for kernel ...<o:p></o:p></span></pre><pre><span =
lang=3DEN-GB>gunzipping (0x00000000 &lt;- 0x0050e000:0x00940fe8)...done =
0x422920 bytes<o:p></o:p></span></pre><pre><span =
lang=3DEN-GB><o:p>&nbsp;</o:p></span></pre><pre><span =
lang=3DEN-GB>Linux/PowerPC load: root=3D/dev/mtdblock1 ro =
rootfstype=3Dcramfs devfs=3Dmount<o:p></o:p></span></pre><pre><span =
lang=3DEN-GB>console=3DttyS0,115200 =
init=3D/linuxrc<o:p></o:p></span></pre><pre><span =
lang=3DEN-GB>Finalizing device tree... flat tree at =
0x94d120<o:p></o:p></span></pre><pre><span =
lang=3DEN-GB><o:p>&nbsp;</o:p></span></pre><pre><span =
lang=3DEN-GB><o:p>&nbsp;</o:p></span></pre><pre><span lang=3DEN-GB>But =
at this point the process crash and the system is =
reset.<o:p></o:p></span></pre><pre><span lang=3DEN-GB>It should be =
something near the handover between the first kenel boot =
stage<o:p></o:p></span></pre><pre><span lang=3DEN-GB>and the vmlinux =
start, but I do not have a jtag to proceed =
the<o:p></o:p></span></pre><pre><span =
lang=3DEN-GB>investigation.<o:p></o:p></span></pre><pre><span =
lang=3DEN-GB><o:p>&nbsp;</o:p></span></pre><pre><span lang=3DEN-GB>In =
any case it seems that the execution never entry the vmlinux =
start<o:p></o:p></span></pre><pre><span =
lang=3DEN-GB>(head_32.S).<o:p></o:p></span></pre><pre><span =
lang=3DEN-GB><o:p>&nbsp;</o:p></span></pre><pre><span lang=3DEN-GB>I try =
to add this macro at the begin of the =
file:<o:p></o:p></span></pre><pre><span =
lang=3DEN-GB><o:p>&nbsp;</o:p></span></pre><pre><span =
lang=3DEN-GB>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .equ cnsladdr, =
0xe0004500 (console address txreg)<o:p></o:p></span></pre><pre><span =
lang=3DEN-GB><o:p>&nbsp;</o:p></span></pre><pre><span =
lang=3DEN-GB>.macro dbg_prnt nid<o:p></o:p></span></pre><pre><span =
lang=3DEN-GB>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
lis&nbsp;&nbsp;&nbsp;&nbsp; r24, </span><a =
href=3D"http://lists.busybox.net/mailman/listinfo/buildroot"><span =
lang=3DEN-GB>cnsladdr at ha</span></a><span =
lang=3DEN-GB><o:p></o:p></span></pre><pre><span =
lang=3DEN-GB>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
addi&nbsp;&nbsp;&nbsp; r24, r24, </span><a =
href=3D"http://lists.busybox.net/mailman/listinfo/buildroot"><span =
lang=3DEN-GB>cnsladdr at l</span></a><span =
lang=3DEN-GB><o:p></o:p></span></pre><pre><span =
lang=3DEN-GB>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span =
lang=3DIT>li&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r25, =
'd'<o:p></o:p></span></pre><pre><span =
lang=3DIT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
stb&nbsp;&nbsp;&nbsp;&nbsp; r25, =
0(r24)<o:p></o:p></span></pre><pre><span =
lang=3DIT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
li&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r25, =
'b'<o:p></o:p></span></pre><pre><span =
lang=3DIT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
stb&nbsp;&nbsp;&nbsp;&nbsp; r25, =
0(r24)<o:p></o:p></span></pre><pre><span =
lang=3DIT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
li&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r25, =
'g'<o:p></o:p></span></pre><pre><span =
lang=3DIT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
stb&nbsp;&nbsp;&nbsp;&nbsp; r25, =
0(r24)<o:p></o:p></span></pre><pre><span =
lang=3DIT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
li&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r25, =
'0'<o:p></o:p></span></pre><pre><span =
lang=3DIT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
addi&nbsp;&nbsp;&nbsp; r25, r25, \nid<o:p></o:p></span></pre><pre><span =
lang=3DIT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
stb&nbsp;&nbsp;&nbsp;&nbsp; r25, =
0(r24)<o:p></o:p></span></pre><pre><span =
lang=3DIT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
li&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r25, =
'\n'<o:p></o:p></span></pre><pre><span =
lang=3DIT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span =
lang=3DEN-GB>stb&nbsp;&nbsp;&nbsp;&nbsp; r25, =
0(r24)<o:p></o:p></span></pre><pre><span =
lang=3DEN-GB>.endm<o:p></o:p></span></pre><pre><span =
lang=3DEN-GB><o:p>&nbsp;</o:p></span></pre><pre><span =
lang=3DEN-GB><o:p>&nbsp;</o:p></span></pre><pre><span lang=3DEN-GB>But I =
do not see anything in the console.<o:p></o:p></span></pre><pre><span =
lang=3DEN-GB>The problem seems releted to the vmlinux call in =
arc/powerpc/boot/main.c<o:p></o:p></span></pre><pre><span =
lang=3DEN-GB><o:p>&nbsp;</o:p></span></pre><pre><span =
lang=3DEN-GB>kentry =3D (kernel_entry_t) =
vmlinux.addr;<o:p></o:p></span></pre><pre><span =
lang=3DEN-GB><o:p>&nbsp;</o:p></span></pre><pre><span =
lang=3DEN-GB><o:p>&nbsp;</o:p></span></pre><pre><span lang=3DEN-GB>Any =
suggestion?<o:p></o:p></span></pre><pre>Bye.<o:p></o:p></pre><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p></div></body></html>
------=_NextPart_000_0033_01D1B861.BC4AC410--
