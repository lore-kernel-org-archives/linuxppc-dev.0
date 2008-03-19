Return-Path: <John.Linn@xilinx.com>
Received: from outbound6-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 3F75ADDED2
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Mar 2008 02:11:15 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C889CE.8F0A5900"
Subject: RE: Uart(lite)/ELDK 4.1 section mismatch -> ML403
Date: Wed, 19 Mar 2008 08:36:02 -0600
In-Reply-To: <2516330804619D4EA81F9AC9ACE9D874341E39@ADCSVR.adc.arcobel.nl>
References: <2516330804619D4EA81F9AC9ACE9D874341E39@ADCSVR.adc.arcobel.nl>
From: "John Linn" <John.Linn@xilinx.com>
To: "Rob Schalken" <rob.schalken@core-vision.nl>,
	<linuxppc-embedded@ozlabs.org>
Message-Id: <20080319143615.2AFDC1AE81B9@mail73-dub.bigfish.com>
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

------_=_NextPart_001_01C889CE.8F0A5900
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi Rob,

=20

It sounds like your xparameters*.h with the #defines for the device
addresses is right for the uart as the bootstrap loader is working.

=20

I don't believe early boot works was my experience with it.

=20

What messages did you see in the __log_bug as this is the best tool, is
it booting all the way without a console or crashing during boot when it
tries to start the console?

=20

Make sure the #define XPAR_DDR_0_SIZE 0x4000000 is in the
xparameters_ml403.h. It it's wrong the kernel will crash quickly based
on my experience.

=20

Xilinx has a git server that I have been working on updating, not sure
how many changes there are in our git server as opposed to what you
have.  I have been testing arch/ppc with the ML405 which is the same as
the ML403 except a larger FPGA, but my testing has been with the 550
UART as the default.  I realize it's a tangent, but you can pull from
our server if you want as I know the state of it
(git://git.xilinx.com/linux-2.6-xlnx.git). =20

=20

Thanks

John Linn

=20

________________________________

From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org] On
Behalf Of Rob Schalken
Sent: Wednesday, March 19, 2008 8:02 AM
To: linuxppc-embedded@ozlabs.org
Subject: Uart(lite)/ELDK 4.1 section mismatch -> ML403

=20

I want to Port the Linux 2.6.24.3 to the ML403 board.  I tried some
different configurations:

=20

**UartLite

After changing some defines and creating some symbolic link, the simple
boot loader seems to

Work. My kernel also starts because when I read the memory (using XMD),
I could read the _log_buf and

Some information was put in. I used the kernel command line:
console=3DttyUL0 ip=3Doff root=3D/dev/ram rw. =20

But I did not get any kernel message on my serial console! When I
enabled the early boot text over

Serial port, the compiler gives some errors (gen550_init, RS_TABLE_SIZE,
etc.)!

=20

**16550 Uart

After my disaster with the Uartlite, I started to use the 16550 uart.
But I immediately get the following

Error:

arch/ppc/boot/common/ns16550.c:22: error: 'RS_TABLE_SIZE' undeclared
here (not in a function)

arch/ppc/boot/common/ns16550.c:24: error: 'SERIAL_PORT_DFNS' undeclared
here (not in a function)

make[2]: *** [arch/ppc/boot/common/ns16550.o] Error 1

make[1]: *** [arch/ppc/boot/common] Error 2

make: *** [zImage] Error 2

=20

I use ELDK 4.1 toolchain, which result in the following section mismatch
(warning)

WARNING: vmlinux.o(.text+0x223c): Section mismatch: reference to
.init.text:earl y_init (between 'start_here' and 'initial_mmu')

WARNING: vmlinux.o(.text+0x2254): Section mismatch: reference to
.init.text:mach ine_init (between 'start_here' and 'initial_mmu')

WARNING: vmlinux.o(.text+0x2258): Section mismatch: reference to
.init.text:MMU_ init (between 'start_here' and 'initial_mmu')

WARNING: vmlinux.o(.text+0x22b2): Section mismatch: reference to
.init.text:star t_kernel (between 'start_here' and 'initial_mmu')

WARNING: vmlinux.o(.text+0x22b6): Section mismatch: reference to
.init.text:star t_kernel (between 'start_here' and 'initial_mmu')

=20

By the way, the hardware is working, this has been tested!!

=20

Could someone help to get a uart work! I only want to receive a message
from the kernel!!!!=20

=20

=20


______________________________________________________________________
This email has been scanned by the MessageLabs Email Security System.
For more information please visit http://www.messagelabs.com/email=20
______________________________________________________________________


------_=_NextPart_001_01C889CE.8F0A5900
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40"
xmlns:ns0=3D"http://schemas.microsoft.com/office/2004/12/omml">

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
<![endif]-->
<style>
<!--a:link
	{mso-style-priority:99;}
span.MSOHYPERLINK
	{mso-style-priority:99;}
a:visited
	{mso-style-priority:99;}
span.MSOHYPERLINKFOLLOWED
	{mso-style-priority:99;}
p.MSOACETATE
	{mso-style-priority:99;}
li.MSOACETATE
	{mso-style-priority:99;}
div.MSOACETATE
	{mso-style-priority:99;}
p.MSOLISTPARAGRAPH
	{mso-style-priority:34;}
li.MSOLISTPARAGRAPH
	{mso-style-priority:34;}
div.MSOLISTPARAGRAPH
	{mso-style-priority:34;}
span.BALLOONTEXTCHAR
	{mso-style-priority:99;}

 /* Font Definitions */
 @font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:Calibri;}
h1
	{margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:.3in;
	text-indent:-.3in;
	page-break-after:avoid;
	mso-list:l0 level1 lfo3;
	font-size:16.0pt;
	font-family:Calibri;}
h2
	{margin-top:0in;
	margin-right:0in;
	margin-bottom:12.0pt;
	margin-left:.4in;
	text-indent:-.4in;
	page-break-after:avoid;
	mso-list:l0 level2 lfo3;
	font-size:14.0pt;
	font-family:Calibri;}
h3
	{margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:.5in;
	text-indent:-.5in;
	page-break-after:avoid;
	mso-list:l1 level3 lfo6;
	font-size:13.0pt;
	font-family:Calibri;}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:Tahoma;}
span.BalloonTextChar
	{font-family:Tahoma;}
p.msolistparagraph, li.msolistparagraph, div.msolistparagraph
	{margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:Calibri;}
span.EmailStyle20
	{mso-style-type:personal;
	font-family:Calibri;
	color:windowtext;}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 @list l0
	{mso-list-id:1143350910;
	mso-list-template-ids:1338282562;}
@list l0:level1
	{mso-level-style-link:"Heading 1";
	mso-level-text:%1;
	mso-level-tab-stop:.3in;
	mso-level-number-position:left;
	margin-left:.3in;
	text-indent:-.3in;}
@list l0:level2
	{mso-level-style-link:"Heading 2";
	mso-level-text:"%1\.%2";
	mso-level-tab-stop:.4in;
	mso-level-number-position:left;
	margin-left:.4in;
	text-indent:-.4in;}
@list l0:level3
	{mso-level-text:"%1\.%2\.%3";
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	margin-left:.5in;
	text-indent:-.5in;}
@list l0:level4
	{mso-level-text:"%1\.%2\.%3\.%4";
	mso-level-tab-stop:.6in;
	mso-level-number-position:left;
	margin-left:.6in;
	text-indent:-.6in;}
@list l0:level5
	{mso-level-text:"%1\.%2\.%3\.%4\.%5";
	mso-level-tab-stop:.7in;
	mso-level-number-position:left;
	margin-left:.7in;
	text-indent:-.7in;}
@list l0:level6
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6";
	mso-level-tab-stop:.8in;
	mso-level-number-position:left;
	margin-left:.8in;
	text-indent:-.8in;}
@list l0:level7
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7";
	mso-level-tab-stop:.9in;
	mso-level-number-position:left;
	margin-left:.9in;
	text-indent:-.9in;}
@list l0:level8
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7\.%8";
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	margin-left:1.0in;
	text-indent:-1.0in;}
@list l0:level9
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7\.%8\.%9";
	mso-level-tab-stop:1.1in;
	mso-level-number-position:left;
	margin-left:1.1in;
	text-indent:-1.1in;}
@list l1
	{mso-list-id:1860200171;
	mso-list-template-ids:1400561736;}
@list l1:level1
	{mso-level-text:%1;
	mso-level-tab-stop:.3in;
	mso-level-number-position:left;
	margin-left:.3in;
	text-indent:-.3in;}
@list l1:level2
	{mso-level-text:"%1\.%2";
	mso-level-tab-stop:.4in;
	mso-level-number-position:left;
	margin-left:.4in;
	text-indent:-.4in;}
@list l1:level3
	{mso-level-reset-level:level2;
	mso-level-style-link:"Heading 3";
	mso-level-text:"%1\.%2\.%3";
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
	{mso-list-id:2077240681;
	mso-list-template-ids:-762429638;}
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
	{mso-level-text:"%1\.%2\.%3";
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

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Hi =
Rob,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>It sounds like your xparameters*.h =
with the
#defines for the device addresses is right for the uart as the bootstrap =
loader
is working.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>I don&#8217;t believe early boot =
works was
my experience with it.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>What messages did you see in the =
__log_bug
as this is the best tool, is it booting all the way without a console or
crashing during boot when it tries to start the =
console?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Make sure the #define =
XPAR_DDR_0_SIZE
0x4000000 is in the xparameters_ml403.h. It it&#8217;s wrong the kernel =
will
crash quickly based on my experience.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Xilinx has a git server that I have =
been
working on updating, not sure how many changes there are in our git =
server as
opposed to what you have.&nbsp; I have been testing arch/ppc with the =
ML405 which is
the same as the ML403 except a larger FPGA, but my testing has been with =
the
550 UART as the default.&nbsp; I realize it&#8217;s a tangent, but you =
can pull from
our server if you want as I know the state of it =
(git://git.xilinx.com/linux-2.6-xlnx.git).
&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Thanks<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>John =
Linn<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<div>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><font =
size=3D3
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;font-family:"Times New Roman"'>

<hr size=3D2 width=3D"100%" align=3Dcenter tabindex=3D-1>

</span></font></div>

<p class=3DMsoNormal><b><font size=3D2 face=3DTahoma><span =
style=3D'font-size:10.0pt;
font-family:Tahoma;font-weight:bold'>From:</span></font></b><font =
size=3D2
face=3DTahoma><span style=3D'font-size:10.0pt;font-family:Tahoma'>
linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org] =
<b><span
style=3D'font-weight:bold'>On Behalf Of </span></b>Rob Schalken<br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Wednesday, March =
19, 2008
8:02 AM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> =
linuxppc-embedded@ozlabs.org<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> Uart(lite)/ELDK =
4.1
section mismatch -&gt; ML403</span></font><font size=3D3 face=3D"Times =
New Roman"><span
style=3D'font-size:12.0pt;font-family:"Times New =
Roman"'><o:p></o:p></span></font></p>

</div>

<p class=3DMsoNormal><font size=3D2 face=3DCalibri><span =
style=3D'font-size:11.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DCalibri><span =
style=3D'font-size:11.0pt'>I
want to Port the Linux 2.6.24.3 to the ML403 board. &nbsp;I tried some
different configurations:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DCalibri><span =
style=3D'font-size:11.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DCalibri><span =
style=3D'font-size:11.0pt'>**UartLite<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DCalibri><span =
style=3D'font-size:11.0pt'>After
changing some defines and creating some symbolic link, the simple boot =
loader
seems to<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DCalibri><span =
style=3D'font-size:11.0pt'>Work.
My kernel also starts because when I read the memory (using XMD), I =
could read
the _<i><span style=3D'font-style:italic'>log</span></i>_buf =
and<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DCalibri><span =
style=3D'font-size:11.0pt'>Some
information was put in. I used the kernel command line: console=3DttyUL0 =
ip=3Doff
root=3D/dev/ram rw.&nbsp; <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DCalibri><span =
style=3D'font-size:11.0pt'>But
I did not get any kernel message on my serial console! When I enabled =
the early
boot text over<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DCalibri><span =
style=3D'font-size:11.0pt'>Serial
port, the compiler gives some errors (gen550_init, RS_TABLE_SIZE, =
etc.)!<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DCalibri><span =
style=3D'font-size:11.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DCalibri><span =
style=3D'font-size:11.0pt'>**16550
Uart<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DCalibri><span =
style=3D'font-size:11.0pt'>After
my disaster with the Uartlite, I started to use the 16550 uart. But I
immediately get the following<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DCalibri><span =
style=3D'font-size:11.0pt'>Error:<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-indent:35.4pt'><font size=3D2 =
face=3DCalibri><span
style=3D'font-size:11.0pt'>arch/ppc/boot/common/ns16550.c:22: error: =
'RS_TABLE_SIZE'
undeclared here (not in a function)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-indent:35.4pt'><font size=3D2 =
face=3DCalibri><span
style=3D'font-size:11.0pt'>arch/ppc/boot/common/ns16550.c:24: error:
'SERIAL_PORT_DFNS' undeclared here (not in a =
function)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-indent:35.4pt'><font size=3D2 =
face=3DCalibri><span
style=3D'font-size:11.0pt'>make[2]: *** [arch/ppc/boot/common/ns16550.o] =
Error 1<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-indent:35.4pt'><font size=3D2 =
face=3DCalibri><span
style=3D'font-size:11.0pt'>make[1]: *** [arch/ppc/boot/common] Error =
2<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-indent:35.4pt'><font size=3D2 =
face=3DCalibri><span
style=3D'font-size:11.0pt'>make: *** [zImage] Error =
2<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-indent:35.4pt'><font size=3D2 =
face=3DCalibri><span
style=3D'font-size:11.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DCalibri><span =
style=3D'font-size:11.0pt'>I
use ELDK 4.1 toolchain, which result in the following section mismatch
(warning)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-indent:35.4pt'><font size=3D2 =
face=3DCalibri><span
style=3D'font-size:11.0pt'>WARNING: vmlinux.o(.text+0x223c): Section =
mismatch:
reference to .init.text:earl y_init (between 'start_here' and =
'initial_mmu')<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-indent:35.4pt'><font size=3D2 =
face=3DCalibri><span
style=3D'font-size:11.0pt'>WARNING: vmlinux.o(.text+0x2254): Section =
mismatch:
reference to .init.text:mach ine_init (between 'start_here' and =
'initial_mmu')<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-indent:35.4pt'><font size=3D2 =
face=3DCalibri><span
style=3D'font-size:11.0pt'>WARNING: vmlinux.o(.text+0x2258): Section =
mismatch:
reference to .init.text:MMU_ init (between 'start_here' and =
'initial_mmu')<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-indent:35.4pt'><font size=3D2 =
face=3DCalibri><span
style=3D'font-size:11.0pt'>WARNING: vmlinux.o(.text+0x22b2): Section =
mismatch:
reference to .init.text:star t_kernel (between 'start_here' and =
'initial_mmu')<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-indent:35.4pt'><font size=3D2 =
face=3DCalibri><span
style=3D'font-size:11.0pt'>WARNING: vmlinux.o(.text+0x22b6): Section =
mismatch:
reference to .init.text:star t_kernel (between 'start_here' and =
'initial_mmu')<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DCalibri><span =
style=3D'font-size:11.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DCalibri><span =
style=3D'font-size:11.0pt'>By
the way, the hardware is working, this has been =
tested!!<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DCalibri><span =
style=3D'font-size:11.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DCalibri><span =
style=3D'font-size:11.0pt'>Could
someone help to get a uart work! I only want to receive a message from =
the
kernel!!!! <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DCalibri><span =
style=3D'font-size:11.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DCalibri><span =
style=3D'font-size:11.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DNL
style=3D'font-size:12.0pt;font-family:"Times New Roman"'><br>
______________________________________________________________________<br=
>
This email has been scanned by the MessageLabs Email Security =
System.<br>
For more information please visit http://www.messagelabs.com/email <br>
______________________________________________________________________<o:=
p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C889CE.8F0A5900--
