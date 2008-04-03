Return-Path: <John.Linn@xilinx.com>
Received: from outbound5-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id D2EBCDDF42
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Apr 2008 00:29:05 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8958E.AD0B71B4"
Subject: RE: [PATCH 3/3][POWERPC][V2] Xilinx: boot support for Xilinx uart
	16550.
Date: Thu, 3 Apr 2008 07:28:59 -0600
In-Reply-To: <7e0dd21a0804030623s3571716fk8585b517c9aac1ed@mail.gmail.com>
References: <12071551351007-git-send-email-john.linn@xilinx.com>
	<20080402165216.C835D1CF8088@mail12-sin.bigfish.com>
	<7e0dd21a0804030623s3571716fk8585b517c9aac1ed@mail.gmail.com>
From: "John Linn" <John.Linn@xilinx.com>
To: "Johann Baudy" <johaahn@gmail.com>
Message-Id: <20080403132901.B50D1194805D@mail96-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8958E.AD0B71B4
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi Johann,

=20

You're right about it being missing. I have another patch for virtex
specific initialization that handles that.  I have not submitted it yet
as I was trying to get these patches thru the system.

=20

I have been told in this forum that the bootstrap loader should not be
setting up the baud rate and that normally the boot loader does it.

=20

In the case of FPGAs, we don't always use a boot loader so we need this
to happen in the bootstrap loader.  I can forward that patch to you if
you're interested before it goes to this group.

=20

Thanks,

John

=20

________________________________

From: Johann Baudy [mailto:johaahn@gmail.com]=20
Sent: Thursday, April 03, 2008 7:23 AM
To: John Linn
Cc: linuxppc-dev@ozlabs.org; grant.likely@secretlab.ca
Subject: Re: [PATCH 3/3][POWERPC][V2] Xilinx: boot support for Xilinx
uart 16550.

=20

Hi John,

I've a small question about ns16550 boot support.
I can't see any code related to either "clock-frequency" or
"current-speed" key words.
Such actions are performed in of_serial.c to get appropriate baud rate
(update of UART_DLL and UART_DLM).

Is it needed or is it a misunderstanding?=20
Personally, I have added this below debug code (dirty :)) to make it
work.

diff --git a/arch/powerpc/boot/ns16550.c b/arch/powerpc/boot/ns16550.c
index f8f1b2f..850e223 100644
--- a/arch/powerpc/boot/ns16550.c
+++ b/arch/powerpc/boot/ns16550.c
@@ -26,6 +26,9 @@
 #define UART_MSR    6    /* In:  Modem Status Register */
 #define UART_SCR    7    /* I/O: Scratch Register */
=20
+#define UART_LCR_DLAB 0x80      /* Divisor latch access */
+#define UART_LCR_8_DATA_BITS 0x03
+
 static unsigned char *reg_base;
 static u32 reg_shift;
=20
@@ -56,6 +59,10 @@ int ns16550_console_init(void *devp, struct
serial_console_data *scdp)
 {
     int n;
     unsigned long reg_phys;
+  unsigned long divisor=3D0;
+  unsigned long spd=3D0, clk=3D0;
+
+
=20
     n =3D getprop(devp, "virtual-reg", &reg_base, sizeof(reg_base));
     if (n !=3D sizeof(reg_base)) {
@@ -75,5 +82,23 @@ int ns16550_console_init(void *devp, struct
serial_console_data *scdp)
     scdp->tstc =3D ns16550_tstc;
     scdp->close =3D NULL;
=20
+    n =3D getprop(devp, "current-speed", &spd, sizeof(spd));
+
+
+    n =3D getprop(devp, "clock-frequency", &clk, sizeof(clk));
+
+
+  if(spd&&clk)
+  {
+
+     divisor =3D clk / (spd * 16UL);
+
+     out_8(reg_base + (UART_FCR << reg_shift), 0x06);
+     out_8(reg_base + (UART_LCR << reg_shift),
UART_LCR_8_DATA_BITS|UART_LCR_DLAB);
+     out_8(reg_base + (UART_DLL << reg_shift), divisor&0xff);
+     out_8(reg_base + (UART_DLM << reg_shift), (divisor>>8)&0xff);
+     out_8(reg_base + (UART_LCR << reg_shift), UART_LCR_8_DATA_BITS);
+
+  }
     return 0;
=20
Best regards,
Johann

On Wed, Apr 2, 2008 at 4:52 PM, John Linn <john.linn@xilinx.com> wrote:

The Xilinx 16550 uart core is not a standard 16550 because it uses
word-based addressing rather than byte-based adressing. With
additional properties it is compatible with the open firmware
'ns16550' compatible binding.

This code updates the ns16550 driver to use the reg-offset property
so that the Xilinx UART 16550 can be used with it. The reg-shift
was already being handled.

Signed-off-by: John Linn <john.linn@xilinx.com>
---
 arch/powerpc/boot/ns16550.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/ns16550.c b/arch/powerpc/boot/ns16550.c
index f8f1b2f..da9d2c2 100644
--- a/arch/powerpc/boot/ns16550.c
+++ b/arch/powerpc/boot/ns16550.c
@@ -56,6 +56,7 @@ int ns16550_console_init(void *devp, struct
serial_console_data *scdp)
 {
       int n;
       unsigned long reg_phys;
+       u32 reg_offset;

       n =3D getprop(devp, "virtual-reg", &reg_base, sizeof(reg_base));
       if (n !=3D sizeof(reg_base)) {
@@ -65,6 +66,10 @@ int ns16550_console_init(void *devp, struct
serial_console_data *scdp)
               reg_base =3D (void *)reg_phys;
       }

+       n =3D getprop(devp, "reg-offset", &reg_offset,
sizeof(reg_offset));
+       if (n =3D=3D sizeof(reg_offset))
+               reg_base +=3D reg_offset;
+
       n =3D getprop(devp, "reg-shift", &reg_shift, sizeof(reg_shift));
       if (n !=3D sizeof(reg_shift))
               reg_shift =3D 0;
--
1.5.2.1



_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev




--=20
Johann Baudy
johaahn@gmail.com=20


------_=_NextPart_001_01C8958E.AD0B71B4
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
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
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
h1
	{margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:.3in;
	text-indent:-.3in;
	page-break-after:avoid;
	mso-list:l0 level1 lfo3;
	font-size:16.0pt;
	font-family:"Times New Roman";}
h2
	{margin-top:0in;
	margin-right:0in;
	margin-bottom:12.0pt;
	margin-left:.4in;
	text-indent:-.4in;
	page-break-after:avoid;
	mso-list:l0 level2 lfo3;
	font-size:14.0pt;
	font-family:"Times New Roman";}
h3
	{margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:.5in;
	text-indent:-.5in;
	page-break-after:avoid;
	mso-list:l1 level3 lfo6;
	font-size:13.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:blue;
	text-decoration:underline;}
span.EmailStyle17
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

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dblue>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Hi =
Johann,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>You&#8217;re right about it being =
missing.
I have another patch for virtex specific initialization that handles =
that.&nbsp; I
have not submitted it yet as I was trying to get these patches thru the =
system.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>I have been told in this forum that =
the
bootstrap loader should not be setting up the baud rate and that =
normally the
boot loader does it.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>In the case of FPGAs, we =
don&#8217;t
always use a boot loader so we need this to happen in the bootstrap =
loader.&nbsp; I
can forward that patch to you if you&#8217;re interested before it goes =
to this
group.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Thanks,<o:p></o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>John<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

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
face=3DTahoma><span style=3D'font-size:10.0pt;font-family:Tahoma'> =
Johann Baudy
[mailto:johaahn@gmail.com] <br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Thursday, April 03, =
2008
7:23 AM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> John Linn<br>
<b><span style=3D'font-weight:bold'>Cc:</span></b> =
linuxppc-dev@ozlabs.org;
grant.likely@secretlab.ca<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> Re: [PATCH
3/3][POWERPC][V2] Xilinx: boot support for Xilinx uart =
16550.</span></font><o:p></o:p></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><font size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>Hi John,<br>
<br>
I've a small question about ns16550 boot support.<br>
I can't see any code related to either &quot;clock-frequency&quot; or
&quot;current-speed&quot; key words.<br>
Such actions are performed in of_serial.c to get appropriate baud rate =
(update
of UART_DLL and UART_DLM).<br>
<br>
Is it needed or is it a misunderstanding? <br>
Personally, I have added this below debug code (dirty :)) to make it =
work.<br>
<br>
diff --git a/arch/powerpc/boot/ns16550.c =
b/arch/powerpc/boot/ns16550.c<br>
index f8f1b2f..850e223 100644<br>
--- a/arch/powerpc/boot/ns16550.c<br>
+++ b/arch/powerpc/boot/ns16550.c<br>
@@ -26,6 +26,9 @@<br>
&nbsp;#define UART_MSR&nbsp;&nbsp;&nbsp; 6&nbsp;&nbsp;&nbsp; /* =
In:&nbsp; Modem
Status Register */<br>
&nbsp;#define UART_SCR&nbsp;&nbsp;&nbsp; 7&nbsp;&nbsp;&nbsp; /* I/O: =
Scratch
Register */<br>
&nbsp;<br>
+#define UART_LCR_DLAB 0x80&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Divisor =
latch
access */<br>
+#define UART_LCR_8_DATA_BITS 0x03<br>
+<br>
&nbsp;static unsigned char *reg_base;<br>
&nbsp;static u32 reg_shift;<br>
&nbsp;<br>
@@ -56,6 +59,10 @@ int ns16550_console_init(void *devp, struct
serial_console_data *scdp)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp; int n;<br>
&nbsp;&nbsp;&nbsp;&nbsp; unsigned long reg_phys;<br>
+&nbsp; unsigned long divisor=3D0;<br>
+&nbsp; unsigned long spd=3D0, clk=3D0;<br>
+<br>
+<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; n =3D getprop(devp, &quot;virtual-reg&quot;,
&amp;reg_base, sizeof(reg_base));<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (n !=3D sizeof(reg_base)) {<br>
@@ -75,5 +82,23 @@ int ns16550_console_init(void *devp, struct
serial_console_data *scdp)<br>
&nbsp;&nbsp;&nbsp;&nbsp; scdp-&gt;tstc =3D ns16550_tstc;<br>
&nbsp;&nbsp;&nbsp;&nbsp; scdp-&gt;close =3D NULL;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp; n =3D getprop(devp, &quot;current-speed&quot;, =
&amp;spd,
sizeof(spd));<br>
+<br>
+<br>
+&nbsp;&nbsp;&nbsp; n =3D getprop(devp, &quot;clock-frequency&quot;, =
&amp;clk,
sizeof(clk));<br>
+<br>
+<br>
+&nbsp; if(spd&amp;&amp;clk)<br>
+&nbsp; {<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp; divisor =3D clk / (spd * 16UL);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp; out_8(reg_base + (UART_FCR &lt;&lt; =
reg_shift),
0x06);<br>
+&nbsp;&nbsp;&nbsp;&nbsp; out_8(reg_base + (UART_LCR &lt;&lt; =
reg_shift),
UART_LCR_8_DATA_BITS|UART_LCR_DLAB);<br>
+&nbsp;&nbsp;&nbsp;&nbsp; out_8(reg_base + (UART_DLL &lt;&lt; =
reg_shift),
divisor&amp;0xff);<br>
+&nbsp;&nbsp;&nbsp;&nbsp; out_8(reg_base + (UART_DLM &lt;&lt; =
reg_shift),
(divisor&gt;&gt;8)&amp;0xff);<br>
+&nbsp;&nbsp;&nbsp;&nbsp; out_8(reg_base + (UART_LCR &lt;&lt; =
reg_shift),
UART_LCR_8_DATA_BITS);<br>
+<br>
+&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
Best regards,<br>
Johann<o:p></o:p></span></font></p>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>On Wed, Apr 2, 2008 at 4:52 PM, John Linn &lt;<a
href=3D"mailto:john.linn@xilinx.com">john.linn@xilinx.com</a>&gt; =
wrote:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>The Xilinx 16550 uart core is not a standard 16550 because it =
uses<br>
word-based addressing rather than byte-based adressing. With<br>
additional properties it is compatible with the open firmware<br>
'ns16550' compatible binding.<br>
<br>
This code updates the ns16550 driver to use the reg-offset property<br>
so that the Xilinx UART 16550 can be used with it. The reg-shift<br>
was already being handled.<br>
<br>
Signed-off-by: John Linn &lt;<a =
href=3D"mailto:john.linn@xilinx.com">john.linn@xilinx.com</a>&gt;<br>
---<br>
&nbsp;arch/powerpc/boot/ns16550.c | &nbsp; &nbsp;5 +++++<br>
&nbsp;1 files changed, 5 insertions(+), 0 deletions(-)<br>
<br>
diff --git a/arch/powerpc/boot/ns16550.c =
b/arch/powerpc/boot/ns16550.c<br>
index f8f1b2f..da9d2c2 100644<br>
--- a/arch/powerpc/boot/ns16550.c<br>
+++ b/arch/powerpc/boot/ns16550.c<br>
@@ -56,6 +56,7 @@ int ns16550_console_init(void *devp, struct
serial_console_data *scdp)<br>
&nbsp;{<br>
&nbsp; &nbsp; &nbsp; &nbsp;int n;<br>
&nbsp; &nbsp; &nbsp; &nbsp;unsigned long reg_phys;<br>
+ &nbsp; &nbsp; &nbsp; u32 reg_offset;<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp;n =3D getprop(devp, &quot;virtual-reg&quot;,
&amp;reg_base, sizeof(reg_base));<br>
&nbsp; &nbsp; &nbsp; &nbsp;if (n !=3D sizeof(reg_base)) {<br>
@@ -65,6 +66,10 @@ int ns16550_console_init(void *devp, struct =
serial_console_data
*scdp)<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;reg_base =3D =
(void
*)reg_phys;<br>
&nbsp; &nbsp; &nbsp; &nbsp;}<br>
<br>
+ &nbsp; &nbsp; &nbsp; n =3D getprop(devp, &quot;reg-offset&quot;,
&amp;reg_offset, sizeof(reg_offset));<br>
+ &nbsp; &nbsp; &nbsp; if (n =3D=3D sizeof(reg_offset))<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; reg_base +=3D =
reg_offset;<br>
+<br>
&nbsp; &nbsp; &nbsp; &nbsp;n =3D getprop(devp, &quot;reg-shift&quot;, =
&amp;reg_shift,
sizeof(reg_shift));<br>
&nbsp; &nbsp; &nbsp; &nbsp;if (n !=3D sizeof(reg_shift))<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;reg_shift =3D =
0;<br>
--<br>
<a href=3D"http://1.5.2.1" target=3D"_blank">1.5.2.1</a><br>
<br>
<br>
<br>
_______________________________________________<br>
Linuxppc-dev mailing list<br>
<a =
href=3D"mailto:Linuxppc-dev@ozlabs.org">Linuxppc-dev@ozlabs.org</a><br>
<a href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-dev" =
target=3D"_blank">https://ozlabs.org/mailman/listinfo/linuxppc-dev</a><o:=
p></o:p></span></font></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><br>
<br clear=3Dall>
<br>
-- <br>
Johann Baudy<br>
<a href=3D"mailto:johaahn@gmail.com">johaahn@gmail.com</a> =
<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C8958E.AD0B71B4--
