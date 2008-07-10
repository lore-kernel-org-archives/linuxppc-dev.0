Return-Path: <John.Linn@xilinx.com>
Received: from WA4EHSOBE004.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16]) by ozlabs.org (Postfix) with ESMTP id F2A00DDF8C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Jul 2008 00:21:54 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8E298.479D1BD1"
Subject: RE: Booting ML405 (Kernel panic - not syncing: No init found)
Date: Thu, 10 Jul 2008 08:21:44 -0600
In-Reply-To: <4875B95C.8020809@cdac.in>
References: <48744475.2080605@cdac.in> <20080709143318.GB26524@secretlab.ca>
	<4875B95C.8020809@cdac.in>
From: John Linn <John.Linn@xilinx.com>
To: "neeraj garg" <neerajg@cdac.in>, <grant.likely@secretlab.ca>,
	<marco.stornelli@coritel.it>
Message-ID: <20080710142146.6B1D0107005D@mail69-wa4.bigfish.com>
Cc: lorenzo@alphagolf.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------_=_NextPart_001_01C8E298.479D1BD1
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

With regards to arch/ppc:

 =


I just built and tested it from the Xilinx Git tree (with ELDK 4.1) and
don't see the problem you see.  You shouldn't need anything on the
command line for the init, but I tried it matching yours without any
issue.  =


 =


I noticed that you are using a UART Lite and I test with 16550.  We have
a reference design available for the 405 also to help you get a baseline
before you make changes, you can see where to get it at
http://git.xilinx.com <http://git.xilinx.com/>  also.   Getting a good
solid baseline before you make changes can make life easier, and maybe
you already did this and I don't realize it ;).

 =


I can't tell how your kernel is configured, so I would use the Xilinx
provided default kernel configuration, then make changes from there
(like from 8250 UART and console to UART Lite).

 =


>make ARCH=3Dppc ml405_defconfig

>make ARCH=3Dppc zImage.initrd

 =


Since you pulled from the Xilinx Git tree, you should be able to get the
ML405 running easily (assuming I have done my job right).

 =


You should be able to use arch/powerpc and it would be best to do that
as arch/ppc is not well supported now.  If you use the Xilinx default
kernel configuration you shouldn't need to do anything (such as finding
405 in the menuconfig)  if you use our reference design for the board
(bit stream).

 =


I just tested from the Xilinx Git tree on the ML405 with arch/powerpc
and it looked good (using ELDK 4.1 tools).  The following commands
should build a kernel that runs on it. You might want to update if you
haven't pulled from the Xilinx Git tree in a while (git pull, or clone
the tree again in a new directory).

 =


>make ARCH=3Dpowerpc mrproper

>make ARCH=3Dpowerpc ml405_defconfig

>make ARCH=3Dpowerpc zImage.initrd

 =


With regards to the fact that you're restricting the memory to 32 Meg,
you might get try not doing this to get the kernel running properly,
then make that change.

 =


Hope that helps,

John

 =


 =


________________________________

From: neeraj garg [mailto:neerajg@cdac.in] =

Sent: Thursday, July 10, 2008 1:25 AM
To: grant.likely@secretlab.ca; John Linn; marco.stornelli@coritel.it
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Booting ML405 (Kernel panic - not syncing: No init found)

 =


Hi,

Yes I am using ARCH=3Dppc (actual line is $make ARCH=3Dppc
CROSS_COMPILE=3Dpowerpc-405-linux-gnu- zImage.initrd ) for this I have
placed ramdisk.image.gz in arch/ppc/boot/images. In case of ARCH=3Dpowerpc
I cannot find processor type 405 , in make menuconfig. Thats why i am
using ARCH=3Dppc.

And when I give kernel command string as init=3D/bin/sh , it says : =

>Failed to execute /bin/sh.  Attempting defaults...
[    3.744035] Kernel panic - not syncing: No init found.  Try passing
init=3D option to kernel.
[    3.768073] Rebooting in 30 seconds..

--init is present in sbin/init which is a soft link to ../bin/busybox

--I used powepc-405-gnu-readelf -h bin/sh to verify that it is compiled
for powerpc itself.

Any other suggestions ?




-----------------------------------------------------
Neeraj Garg
 =




Grant Likely wrote: =


On Wed, Jul 09, 2008 at 10:24:13AM +0530, neeraj garg wrote:
  =


	Hi,
	 =

	I am trying to boot ML405 with Linux source code downloaded from

	http://www.git.xilinx.com . My cross compiler tool chain version
is  =

	gcc-3.4.1, glibc-2.3.2 and binutils-2.15. I have also downloaded
RAMDISK  =

	from same url (http://www.git.xilinx.com). When I download  =

	zImage.initrd.elf using XMD everything goes fine, untill RAMDISK
is  =

	uncompressed, I get following messages :
	 =

	    =


<snip>
  =


	                                          [    3.736691] Failed
to  =

	execute /sbin/init.  Attempting defaults...
	[    3.748073] Kernel panic - not syncing: No init found.  Try
passing  =

	init=3D option to kernel.
	[    3.772040] Rebooting in 180 seconds..[  183.487314]
Signal: 8
	 =

	    =


 =

Try changing the kernel parameters line to specify init=3D/bin/sh and see
what happens.
 =

g.
  =



This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.


------_=_NextPart_001_01C8E298.479D1BD1
Content-Type: text/html; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
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
	font-family:"Times New Roman";
	color:black;}
h1
	{margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:.3in;
	text-indent:-.3in;
	page-break-after:avoid;
	mso-list:l1 level1 lfo3;
	font-size:16.0pt;
	font-family:Arial;}
h2
	{margin-top:0in;
	margin-right:0in;
	margin-bottom:12.0pt;
	margin-left:.4in;
	text-indent:-.4in;
	page-break-after:avoid;
	mso-list:l1 level2 lfo3;
	font-size:14.0pt;
	font-family:Arial;}
h3
	{margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:.5in;
	text-indent:-.5in;
	page-break-after:avoid;
	mso-list:l2 level3 lfo6;
	font-size:13.0pt;
	font-family:Arial;}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:blue;
	text-decoration:underline;}
pre
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";
	color:black;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
@page Section1
	{size:8.5in 11.0in;
	margin:.5in .5in .5in .5in;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 @list l0
	{mso-list-id:186799414;
	mso-list-type:hybrid;
	mso-list-template-ids:-621376826 -2034617428 67698691 67698693 67698689 67=
698691 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-start-at:21;
	mso-level-number-format:bullet;
	mso-level-text:\F0D8;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:Arial;}
@list l1
	{mso-list-id:1143350910;
	mso-list-template-ids:1338282562;}
@list l1:level1
	{mso-level-style-link:"Heading 1";
	mso-level-text:%1;
	mso-level-tab-stop:.3in;
	mso-level-number-position:left;
	margin-left:.3in;
	text-indent:-.3in;}
@list l1:level2
	{mso-level-style-link:"Heading 2";
	mso-level-text:"%1\.%2";
	mso-level-tab-stop:.4in;
	mso-level-number-position:left;
	margin-left:.4in;
	text-indent:-.4in;}
@list l1:level3
	{mso-level-text:"%1\.%2\.%3";
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	margin-left:.5in;
	text-indent:-.5in;}
@list l1:level4
	{mso-level-text:"%1\.%2\.%3\.%4";
	mso-level-tab-stop:.6in;
	mso-level-number-position:left;
	margin-left:.6in;
	text-indent:-.6in;}
@list l1:level5
	{mso-level-text:"%1\.%2\.%3\.%4\.%5";
	mso-level-tab-stop:.7in;
	mso-level-number-position:left;
	margin-left:.7in;
	text-indent:-.7in;}
@list l1:level6
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6";
	mso-level-tab-stop:.8in;
	mso-level-number-position:left;
	margin-left:.8in;
	text-indent:-.8in;}
@list l1:level7
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7";
	mso-level-tab-stop:.9in;
	mso-level-number-position:left;
	margin-left:.9in;
	text-indent:-.9in;}
@list l1:level8
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7\.%8";
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	margin-left:1.0in;
	text-indent:-1.0in;}
@list l1:level9
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7\.%8\.%9";
	mso-level-tab-stop:1.1in;
	mso-level-number-position:left;
	margin-left:1.1in;
	text-indent:-1.1in;}
@list l2
	{mso-list-id:1860200171;
	mso-list-template-ids:1400561736;}
@list l2:level1
	{mso-level-text:%1;
	mso-level-tab-stop:.3in;
	mso-level-number-position:left;
	margin-left:.3in;
	text-indent:-.3in;}
@list l2:level2
	{mso-level-text:"%1\.%2";
	mso-level-tab-stop:.4in;
	mso-level-number-position:left;
	margin-left:.4in;
	text-indent:-.4in;}
@list l2:level3
	{mso-level-reset-level:level2;
	mso-level-style-link:"Heading 3";
	mso-level-text:"%1\.%2\.%3";
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	margin-left:.5in;
	text-indent:-.5in;}
@list l2:level4
	{mso-level-text:"%1\.%2\.%3\.%4";
	mso-level-tab-stop:.6in;
	mso-level-number-position:left;
	margin-left:.6in;
	text-indent:-.6in;}
@list l2:level5
	{mso-level-text:"%1\.%2\.%3\.%4\.%5";
	mso-level-tab-stop:.7in;
	mso-level-number-position:left;
	margin-left:.7in;
	text-indent:-.7in;}
@list l2:level6
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6";
	mso-level-tab-stop:.8in;
	mso-level-number-position:left;
	margin-left:.8in;
	text-indent:-.8in;}
@list l2:level7
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7";
	mso-level-tab-stop:.9in;
	mso-level-number-position:left;
	margin-left:.9in;
	text-indent:-.9in;}
@list l2:level8
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7\.%8";
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	margin-left:1.0in;
	text-indent:-1.0in;}
@list l2:level9
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7\.%8\.%9";
	mso-level-tab-stop:1.1in;
	mso-level-number-position:left;
	margin-left:1.1in;
	text-indent:-1.1in;}
@list l3
	{mso-list-id:2077240681;
	mso-list-template-ids:-762429638;}
@list l3:level1
	{mso-level-text:%1;
	mso-level-tab-stop:.3in;
	mso-level-number-position:left;
	margin-left:.3in;
	text-indent:-.3in;}
@list l3:level2
	{mso-level-text:"%1\.%2";
	mso-level-tab-stop:.4in;
	mso-level-number-position:left;
	margin-left:.4in;
	text-indent:-.4in;}
@list l3:level3
	{mso-level-text:"%1\.%2\.%3";
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	margin-left:.5in;
	text-indent:-.5in;}
@list l3:level4
	{mso-level-text:"%1\.%2\.%3\.%4";
	mso-level-tab-stop:.6in;
	mso-level-number-position:left;
	margin-left:.6in;
	text-indent:-.6in;}
@list l3:level5
	{mso-level-text:"%1\.%2\.%3\.%4\.%5";
	mso-level-tab-stop:.7in;
	mso-level-number-position:left;
	margin-left:.7in;
	text-indent:-.7in;}
@list l3:level6
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6";
	mso-level-tab-stop:.8in;
	mso-level-number-position:left;
	margin-left:.8in;
	text-indent:-.8in;}
@list l3:level7
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7";
	mso-level-tab-stop:.9in;
	mso-level-number-position:left;
	margin-left:.9in;
	text-indent:-.9in;}
@list l3:level8
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7\.%8";
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	margin-left:1.0in;
	text-indent:-1.0in;}
@list l3:level9
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7\.%8\.%9";
	mso-level-tab-stop:1.1in;
	mso-level-number-position:left;
	margin-left:1.1in;
	text-indent:-1.1in;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body bgcolor=3Dwhite lang=3DEN-US link=3Dblue vlink=3Dblue>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>With regards to arch/ppc:<o:p></o:p></=
span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>I just built and tested it from the Xi=
linx
Git tree (with ELDK 4.1) and don&#8217;t see the problem you see. &nbsp;You=

shouldn&#8217;t need anything on the command line for the init, but I tried=
 it
matching yours without any issue.&nbsp; <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>I noticed that you are using a UART Li=
te
and I test with 16550. &nbsp;We have a reference design available for the 4=
05
also to help you get a baseline before you make changes, you can see where =
to
get it at <a href=3D"http://git.xilinx.com/">http://git.xilinx.com</a> also=
. &nbsp;&nbsp;Getting
a good solid baseline before you make changes can make life easier, and may=
be
you already did this and I don&#8217;t realize it ;).<o:p></o:p></span></fo=
nt></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>I can&#8217;t tell how your kernel is
configured, so I would use the Xilinx provided default kernel configuration=
,
then make changes from there (like from 8250 UART and console to UART Lite)=
.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>&gt;make ARCH=3Dppc ml405_defconfig<o:=
p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>&gt;make ARCH=3Dppc zImage.initrd<o:p>=
</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Since you pulled from the Xilinx Git t=
ree,
you should be able to get the ML405 running easily (assuming I have done my=
 job
right).<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>You should be able to use arch/powerpc=
 and
it would be best to do that as arch/ppc is not well supported now. &nbsp;If=
 you
use the Xilinx default kernel configuration you shouldn&#8217;t need to do
anything (such as finding 405 in the menuconfig) &nbsp;if you use our refer=
ence
design for the board (bit stream).<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>I just tested from the Xilinx Git tree=
 on
the ML405 with arch/powerpc and it looked good (using ELDK 4.1 tools). &nbs=
p;The
following commands should build a kernel that runs on it. You might want to=

update if you haven&#8217;t pulled from the Xilinx Git tree in a while (git=

pull, or clone the tree again in a new directory).<o:p></o:p></span></font>=
</p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>&gt;make ARCH=3Dpowerpc mrproper<o:p><=
/o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>&gt;make ARCH=3Dpowerpc ml405_defconfi=
g<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>&gt;make ARCH=3Dpowerpc zImage.initrd<=
o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 color=3Dn=
avy
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial;color:navy'>=
With
regards to the fact that you&#8217;re restricting the memory to 32 Meg, you=

might get try not doing this to get the kernel running properly, then make =
that
change.</span></font><font size=3D2 color=3Dblack face=3D"Courier New"><spa=
n
style=3D'font-size:10.0pt;font-family:"Courier New";color:windowtext'><o:p>=
</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Hope that helps,<o:p></o:p></span></fo=
nt></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>John<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<div style=3D'border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt'>

<div>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><font siz=
e=3D3
color=3Dblack face=3D"Times New Roman"><span style=3D'font-size:12.0pt;colo=
r:windowtext'>

<hr size=3D2 width=3D"100%" align=3Dcenter tabindex=3D-1>

</span></font></div>

<p class=3DMsoNormal><b><font size=3D2 color=3Dblack face=3DTahoma><span
style=3D'font-size:10.0pt;font-family:Tahoma;color:windowtext;font-weight:b=
old'>From:</span></font></b><font
size=3D2 color=3Dblack face=3DTahoma><span style=3D'font-size:10.0pt;font-f=
amily:Tahoma;
color:windowtext'> neeraj garg [mailto:neerajg@cdac.in] <br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Thursday, July 10, 200=
8 1:25
AM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> grant.likely@secretlab.c=
a;
John Linn; marco.stornelli@coritel.it<br>
<b><span style=3D'font-weight:bold'>Cc:</span></b> linuxppc-embedded@ozlabs=
.org<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> Re: Booting ML405 (=
Kernel
panic - not syncing: No init found)</span></font><font color=3Dblack><span
style=3D'color:windowtext'><o:p></o:p></span></font></p>

</div>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New Roman">=
<span
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New Roman">=
<span
style=3D'font-size:12.0pt'>Hi,<br>
<br>
Yes I am using ARCH=3Dppc (actual line is $make ARCH=3Dppc
CROSS_COMPILE=3Dpowerpc-405-linux-gnu- zImage.initrd ) for this I have plac=
ed
ramdisk.image.gz in arch/ppc/boot/images. In case of ARCH=3Dpowerpc I canno=
t find
processor type 405 , in make menuconfig. Thats why i am using ARCH=3Dppc.<b=
r>
<br>
And when I give kernel command string as init=3D/bin/sh , it says : <br>
&gt;Failed to execute /bin/sh.&nbsp; Attempting defaults...<br>
[&nbsp;&nbsp;&nbsp; 3.744035] Kernel panic - not syncing: No init found.&nb=
sp;
Try passing init=3D option to kernel.<br>
[&nbsp;&nbsp;&nbsp; 3.768073] Rebooting in 30 seconds..<br>
<br>
--init is present in sbin/init which is a soft link to ../bin/busybox<br>
<br>
--I used powepc-405-gnu-readelf -h bin/sh to verify that it is compiled for=

powerpc itself.<br>
<br>
Any other suggestions ?<br>
<br>
<br>
<o:p></o:p></span></font></p>

<pre><font size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-=
size:10.0pt'>-----------------------------------------------------<o:p></o:=
p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>Neeraj Garg<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'><o:p>&nbsp;</o:p></span></font></pre>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New Roman">=
<span
style=3D'font-size:12.0pt'><br>
<br>
Grant Likely wrote: <o:p></o:p></span></font></p>

<pre wrap=3D""><font size=3D2 color=3Dblack face=3D"Courier New"><span
style=3D'font-size:10.0pt'>On Wed, Jul 09, 2008 at 10:24:13AM +0530, neeraj=
 garg wrote:<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>&nbsp; <o:p></o:p></span></font></pre>

<blockquote style=3D'margin-top:5.0pt;margin-bottom:5.0pt' type=3Dcite><pre=
 wrap=3D""><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>Hi,<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'><o:p>&nbsp;</o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>I am trying to boot ML405 with Linux source code downloaded from&nbsp; <o=
:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'><a
href=3D"http://www.git.xilinx.com">http://www.git.xilinx.com</a> . My cross=
 compiler tool chain version is&nbsp; <o:p></o:p></span></font></pre><pre><=
font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>gcc-3.4.1, glibc-2.3.2 and binutils-2.15. I have also downloaded RAMDISK&=
nbsp; <o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>from same url (<a
href=3D"http://www.git.xilinx.com">http://www.git.xilinx.com</a>). When I d=
ownload&nbsp; <o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>zImage.initrd.elf using XMD everything goes fine, untill RAMDISK is&nbsp;=
 <o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>uncompressed, I get following messages :<o:p></o:p></span></font></pre><p=
re><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'><o:p>&nbsp;</o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>&nbsp;&nbsp;&nbsp; <o:p></o:p></span></font></pre></blockquote>

<pre wrap=3D""><font size=3D2 color=3Dblack face=3D"Courier New"><span
style=3D'font-size:10.0pt'>&lt;snip&gt;<o:p></o:p></span></font></pre><pre>=
<font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>&nbsp; <o:p></o:p></span></font></pre>

<blockquote style=3D'margin-top:5.0pt;margin-bottom:5.0pt' type=3Dcite><pre=
 wrap=3D""><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;[&nbsp;&nbsp;&nbsp; 3.736691] Failed to&nbsp; <o:p>=
</o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>execute /sbin/init.&nbsp; Attempting defaults...<o:p></o:p></span></font>=
</pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>[&nbsp;&nbsp;&nbsp; 3.748073] Kernel panic - not syncing: No init found.&=
nbsp; Try passing&nbsp; <o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>init=3D option to kernel.<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>[&nbsp;&nbsp;&nbsp; 3.772040] Rebooting in 180 seconds..[&nbsp; 183.48731=
4]&nbsp;&nbsp; Signal: 8<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'><o:p>&nbsp;</o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>&nbsp;&nbsp;&nbsp; <o:p></o:p></span></font></pre></blockquote>

<pre wrap=3D""><font size=3D2 color=3Dblack face=3D"Courier New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>Try changing the kernel parameters line to specify init=3D/bin/sh and see=
<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>what happens.<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'><o:p>&nbsp;</o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>g.<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span style=3D'font-size:10.0pt=
'>&nbsp; <o:p></o:p></span></font></pre></div>

</div>

<br clear=3Dall> This email and any attachments are intended for the sole u=
se of the named recipient(s) and contain(s) confidential information that m=
ay be proprietary, privileged or copyrighted under applicable law. If you a=
re not the intended recipient, do not read, copy, or forward this email mes=
sage or any attachments. Delete this email message and any attachments imme=
diately.
</body>

</html>


------_=_NextPart_001_01C8E298.479D1BD1--
