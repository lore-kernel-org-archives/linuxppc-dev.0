Return-Path: <IMPLSoft3UK@music-group.com>
Received: from mailer-one.behringer.com (mailer-one.behringer.com
	[202.95.85.221]) by ozlabs.org (Postfix) with ESMTP id 5471AB711F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Sep 2010 22:30:57 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CB50E2.A4954F0F"
Subject: Help configuring CF / IDE on 8315E
Date: Fri, 10 Sep 2010 20:20:53 +0800
Message-ID: <82DCCB9E0C003C42BBB911CC2E19AAC1317A0E@SGEXCHV1.BEHRINGER.CORP.INTRA>
From: "IMPL Soft3 UK \(Implementation Software Design: BELCHAM Rob +44 1562
	741515 ext 345\)" <IMPLSoft3UK@music-group.com>
To: <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CB50E2.A4954F0F
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi List,

=20

Can anyone point me at any examples or documentation which might help me
configure the IDE/ATA driver for our custom board ?

=20

Our board has an MPC8315E which interfaces to a compact flash card in
true IDE mode via an FPGA on the peripheral bus. The CF registers will
be memory mapped as part of the FPGA address space, but how do I tell
the IDE driver where this is ?

=20

The legacy board, (runs a 2.4 kernel ) which this new board is replacing
had a file in drivers/ide/ which setup these addresses & IRQ with a
couple of functions :-

=20

=20

void nonpci_ide_init_hwif_ports( hw_regs_t *hw, ide_ioreg_t data_port,

  ide_ioreg_t ctrl_port, int *irq )

{

  int i;

  static ide_ioreg_t mapped =3D 0;

=20

  if( data_port =3D=3D 0 ) {

    /* Clear this array if no data_port supplied */

    for (i =3D IDE_DATA_OFFSET; i <=3D IDE_STATUS_OFFSET; ++i )

      hw->io_ports[ i ] =3D data_port;

    hw->io_ports[ IDE_CONTROL_OFFSET ] =3D 0;

  }

  else {

    /* Only configure if base address (data_port) is supplied */

    if( mapped =3D=3D 0 )

      mapped =3D (ide_ioreg_t)( ioremap(data_port, 64) );

    for( i =3D IDE_DATA_OFFSET; i <=3D IDE_STATUS_OFFSET; ++i )

      hw->io_ports[ i ] =3D mapped + (i*4);

   =20

    hw->io_ports[ IDE_CONTROL_OFFSET ] =3D mapped + 0x38;   =20

  }

}

=20

int nonpci_ide_default_irq( ide_ioreg_t base ) {

  return base =3D=3D FPGA_IDE ? IDE_IRQ : 0;

}

=20

ide_ioreg_t nonpci_ide_default_io_base( int index ) {

  return index =3D=3D 0 ? FPGA_IDE : 0;

}

=20

But the closest thing to this I can find in the kernel I'm using for the
new board (2.6.29.6) is ide_arm.c (see below), but this appears to be
setting up io ports. Can I just hack a copy of this file & replace the
IO port numbers with the physical FPGA addresses ?

=20

#define IDE_ARM_IO      0x1f0

#define IDE_ARM_IRQ     IRQ_HARDDISK

=20

static int __init ide_arm_init(void)

{

      unsigned long base =3D IDE_ARM_IO, ctl =3D IDE_ARM_IO + 0x206;

      hw_regs_t hw, *hws[] =3D { &hw, NULL, NULL, NULL };

=20

      if (!request_region(base, 8, DRV_NAME)) {

            printk(KERN_ERR "%s: I/O resource 0x%lX-0x%lX not free.\n",

                        DRV_NAME, base, base + 7);

            return -EBUSY;

      }

=20

      if (!request_region(ctl, 1, DRV_NAME)) {

            printk(KERN_ERR "%s: I/O resource 0x%lX not free.\n",

                        DRV_NAME, ctl);

            release_region(base, 8);

            return -EBUSY;

      }

=20

      memset(&hw, 0, sizeof(hw));

      ide_std_init_ports(&hw, base, ctl);

      hw.irq =3D IDE_ARM_IRQ;

      hw.chipset =3D ide_generic;

=20

      return ide_host_add(NULL, hws, NULL);

}

=20

Surely I can't be the first person to connect a compact flash to a
powerquicc processor in this way : does a suitable driver exist
somewhere already ?

=20

=20

Kind Regards,

=20

BELCHAM, Rob

Principal Engineer, DSP

MIDAS KLARK TEKNIK LIMITED

Tel: +44 1562 741515 ext 345

Email: IMPLSoft3UK@music-group.com

Web: www.midasconsoles.com | www.klarkteknik.com | www.ktsquareone.com


:-) Build Teamwork   :-) Take Ownership   :-) Don't Waste Resources
:-) Clean Workplace =3D Clean Mind   :-) Respect Guidelines and Policies
:-) Improve Yourself and Help Others   :-) Don't Forget to Smile and Say
Thank You =20


This email is intended exclusively for the addressee(s) named above and
may contain privileged and confidential information. If you are not
(among) the intended recipient(s), you may not copy, utilize or
distribute any of the information contained herein. If you have received
this email in error, please notify us immediately via return email and
delete the original from your mailbox. Thank you.

=20


------_=_NextPart_001_01CB50E2.A4954F0F
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@SimSun";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:Arial;}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
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

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Hi List,<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Can anyone point me at any examples or documentation which might =
help
me configure the IDE/ATA driver for our custom board =
?<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Our board has an MPC8315E which interfaces to a compact flash =
card in
true IDE mode via an FPGA on the peripheral bus. The CF registers will =
be
memory mapped as part of the FPGA address space, but how do I tell the =
IDE
driver where this is ?<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>The legacy board, (runs a 2.4 kernel ) which this new board is
replacing had a file in drivers/ide/ which setup these addresses &amp; =
IRQ with
a couple of functions :-<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>void nonpci_ide_init_hwif_ports( hw_regs_t *hw, ide_ioreg_t =
data_port,<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp; ide_ioreg_t ctrl_port, int *irq =
)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>{<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp; int i;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp; static ide_ioreg_t mapped =3D =
0;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp; if( data_port =3D=3D 0 ) {<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp; /* Clear this array if no data_port supplied =
*/<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp; for (i =3D IDE_DATA_OFFSET; i &lt;=3D =
IDE_STATUS_OFFSET; ++i )<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw-&gt;io_ports[ i ] =3D =
data_port;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp; hw-&gt;io_ports[ IDE_CONTROL_OFFSET ] =3D =
0;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp; }<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp; else {<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp; /* Only configure if base address (data_port) =
is supplied */<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp; if( mapped =3D=3D 0 =
)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapped =3D (ide_ioreg_t)( =
ioremap(data_port, 64) );<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp; for( i =3D IDE_DATA_OFFSET; i &lt;=3D =
IDE_STATUS_OFFSET; ++i )<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw-&gt;io_ports[ i ] =3D mapped + =
(i*4);<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp; <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp; hw-&gt;io_ports[ IDE_CONTROL_OFFSET ] =3D =
mapped + 0x38;&nbsp;&nbsp;&nbsp; <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp; }<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>}<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>int nonpci_ide_default_irq( ide_ioreg_t base ) =
{<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp; return base =3D=3D FPGA_IDE ? IDE_IRQ : =
0;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>}<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>ide_ioreg_t nonpci_ide_default_io_base( int index ) =
{<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp; return index =3D=3D 0 ? FPGA_IDE : =
0;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>}<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>But the closest thing to this I can find in the kernel I'm using =
for
the new board (2.6.29.6) is ide_arm.c (see below), but this appears to =
be
setting up io ports. Can I just hack a copy of this file &amp; replace =
the IO
port numbers with the physical FPGA addresses =
?<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>#define IDE_ARM_IO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x1f0<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>#define IDE_ARM_IRQ&nbsp;&nbsp;&nbsp;&nbsp; =
IRQ_HARDDISK<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>static int __init =
ide_arm_init(void)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>{<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long base =3D =
IDE_ARM_IO, ctl =3D IDE_ARM_IO + 0x206;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw_regs_t hw, *hws[] =3D { =
&amp;hw, NULL, NULL, NULL };<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!request_region(base, 8, =
DRV_NAME)) {<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; printk(KERN_ERR &quot;%s: I/O resource 0x%lX-0x%lX not
free.\n&quot;,<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 DRV_NAME, base, base + 7);<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; return -EBUSY;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!request_region(ctl, 1, =
DRV_NAME)) {<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; printk(KERN_ERR &quot;%s: I/O resource 0x%lX not
free.\n&quot;,<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 DRV_NAME, ctl);<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; release_region(base, 8);<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; return -EBUSY;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;hw, 0, =
sizeof(hw));<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ide_std_init_ports(&amp;hw, base, =
ctl);<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw.irq =3D =
IDE_ARM_IRQ;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw.chipset =3D =
ide_generic;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ide_host_add(NULL, hws, =
NULL);<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>}<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Surely I can't be the first person to connect a compact flash to =
a
powerquicc processor in this way : does a suitable driver exist =
somewhere
already ?<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<table class=3DMsoNormalTable border=3D0 cellspacing=3D0 cellpadding=3D0 =
width=3D"100%"
 style=3D'width:100.0%'>
 <tr>
  <td nowrap valign=3Dtop style=3D'padding:0cm 0cm 0cm 0cm'>
  <p class=3DMsoNormal><font size=3D2 color=3Dblack face=3DArial><span
  style=3D'font-size:10.0pt;color:black'>Kind =
Regards,</span></font><o:p></o:p></p>
  </td>
 </tr>
 <tr>
  <td nowrap valign=3Dtop style=3D'padding:0cm 0cm 0cm 0cm'>
  <p class=3DMsoNormal><font size=3D2 color=3Dblack face=3DArial><span
  =
style=3D'font-size:10.0pt;color:black'>&nbsp;</span></font><o:p></o:p></p=
>
  </td>
 </tr>
 <tr>
  <td nowrap valign=3Dtop style=3D'padding:0cm 0cm 0cm 0cm'>
  <p class=3DMsoNormal><font size=3D2 color=3Dblack face=3DArial><span
  style=3D'font-size:10.0pt;color:black'>BELCHAM, =
Rob</span></font><o:p></o:p></p>
  </td>
 </tr>
 <tr>
  <td nowrap valign=3Dtop style=3D'padding:0cm 0cm 0cm 0cm'>
  <p class=3DMsoNormal><font size=3D2 color=3Dblack face=3DArial><span
  style=3D'font-size:10.0pt;color:black'>Principal Engineer, =
DSP</span></font><o:p></o:p></p>
  </td>
 </tr>
 <tr>
  <td nowrap valign=3Dtop style=3D'padding:0cm 0cm 0cm 0cm'>
  <p class=3DMsoNormal><font size=3D2 color=3Dblack face=3DArial><span
  style=3D'font-size:10.0pt;color:black'>MIDAS KLARK TEKNIK =
LIMITED</span></font><o:p></o:p></p>
  </td>
 </tr>
 <tr>
  <td nowrap valign=3Dtop style=3D'padding:0cm 0cm 0cm 0cm'>
  <p class=3DMsoNormal><font size=3D2 color=3Dblack face=3DArial><span
  style=3D'font-size:10.0pt;color:black'>Tel: +44 1562 741515 ext =
345</span></font><o:p></o:p></p>
  </td>
 </tr>
 <tr>
  <td nowrap valign=3Dtop style=3D'padding:0cm 0cm 0cm 0cm'>
  <p class=3DMsoNormal><font size=3D2 color=3Dblack face=3DArial><span
  style=3D'font-size:10.0pt;color:black'>Email: <a
  =
href=3D"mailto:IMPLSoft3UK@music-group.com">IMPLSoft3UK@music-group.com</=
a></span></font><o:p></o:p></p>
  </td>
 </tr>
 <tr>
  <td nowrap valign=3Dtop style=3D'padding:0cm 0cm 0cm 0cm'>
  <p class=3DMsoNormal><font size=3D2 color=3Dblack face=3DArial><span
  style=3D'font-size:10.0pt;color:black'>Web: <a
  href=3D"http://www.midasconsoles.com">www.midasconsoles.com</a> | <a
  href=3D"http://www.klarkteknik.com">www.klarkteknik.com</a> | <a
  =
href=3D"http://www.ktsquareone.com">www.ktsquareone.com</a></span></font>=
<o:p></o:p></p>
  </td>
 </tr>
</table>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
style=3D'font-size:
9.0pt;color:navy'><br>
</span></font><font size=3D2 color=3Dnavy face=3DWingdings><span =
style=3D'font-size:
10.0pt;font-family:Wingdings;color:navy'>J</span></font><font size=3D1
color=3Dnavy><span style=3D'font-size:9.0pt;color:navy'>&nbsp;Build
Teamwork&nbsp;&nbsp; </span></font><font size=3D2 color=3Dnavy =
face=3DWingdings><span
style=3D'font-size:10.0pt;font-family:Wingdings;color:navy'>J</span></fon=
t><font
size=3D1 color=3Dnavy><span =
style=3D'font-size:9.0pt;color:navy'>&nbsp;Take
Ownership&nbsp;&nbsp; </span></font><font size=3D2 color=3Dnavy =
face=3DWingdings><span
style=3D'font-size:10.0pt;font-family:Wingdings;color:navy'>J</span></fon=
t><font
size=3D1 color=3Dnavy><span =
style=3D'font-size:9.0pt;color:navy'>&nbsp;Don&#8217;t
Waste Resources&nbsp;&nbsp; </span></font><font size=3D2 color=3Dnavy
face=3DWingdings><span =
style=3D'font-size:10.0pt;font-family:Wingdings;color:navy'>J</span></fon=
t><font
size=3D1 color=3Dnavy><span =
style=3D'font-size:9.0pt;color:navy'>&nbsp;Clean
Workplace =3D Clean Mind&nbsp;&nbsp; </span></font><font size=3D2 =
color=3Dnavy
face=3DWingdings><span =
style=3D'font-size:10.0pt;font-family:Wingdings;color:navy'>J</span></fon=
t><font
size=3D1 color=3Dnavy><span =
style=3D'font-size:9.0pt;color:navy'>&nbsp;Respect
Guidelines and Policies&nbsp;&nbsp; </span></font><font size=3D2 =
color=3Dnavy
face=3DWingdings><span =
style=3D'font-size:10.0pt;font-family:Wingdings;color:navy'>J</span></fon=
t><font
size=3D1 color=3Dnavy><span =
style=3D'font-size:9.0pt;color:navy'>&nbsp;Improve
Yourself and Help Others&nbsp;&nbsp;&nbsp;</span></font><font size=3D2
color=3Dnavy face=3DWingdings><span =
style=3D'font-size:10.0pt;font-family:Wingdings;
color:navy'>J</span></font><font size=3D1 color=3Dnavy><span =
style=3D'font-size:9.0pt;
color:navy'>&nbsp;Don&#8217;t Forget to Smile and Say Thank You&nbsp; =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3D"#595959" face=3DArial><span
style=3D'font-size:7.5pt;color:#595959'><br>
This email is intended exclusively for the addressee(s) named above and =
may
contain privileged and confidential information. If you are not (among) =
the
intended recipient(s), you may not copy, utilize or distribute any of =
the
information contained herein. If you have received this email in error, =
please
notify us immediately via return email and delete the original from your
mailbox. Thank you.</span></font><font size=3D1 color=3Dnavy><span
style=3D'font-size:9.0pt;color:navy'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01CB50E2.A4954F0F--
