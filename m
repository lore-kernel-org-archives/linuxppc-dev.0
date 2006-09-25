Return-Path: <DaveLiu@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id B420E679E9
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Sep 2006 13:54:49 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k8P3slPt016832 for <linuxppc-embedded@ozlabs.org>;
	Sun, 24 Sep 2006 20:54:47 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k8P3siLS020331
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 24 Sep 2006 22:54:45 -0500 (CDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6E056.55DF04CC"
Subject: RE: kernel opps during PCI read
Date: Mon, 25 Sep 2006 11:54:42 +0800
Message-ID: <995B09A8299C2C44B59866F6391D263516C244@zch01exm21.fsl.freescale.net>
In-Reply-To: <CE711B0E5D7A1A4096A808997E00832901B32FEE@fmt-ex01.net.com>
From: "Liu Dave-r63238" <DaveLiu@freescale.com>
To: "Tony Hardie" <Tony_Hardie@net.com>, <linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C6E056.55DF04CC
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The machine checking is happening when you configuration read from PCI
bus.
please check the register settings for PCI.
=20
-DAve

	Hiya, I'm running into the following issue running on our custom
PPC8270 (PQ2FADS style) system.

	It only seems to happen when we load the system just a little
(more PCI interrupts and transactions).

	=20

	Any ideas?

	=20

	=20

	/ # [  456.440195] Machine check in kernel mode.

	[  456.442646] Caused by (from SRR1=3D41030): Transfer error ack
signal

	[  456.448828] Oops: machine check, sig: 7 [#1]

	[  456.453088] PREEMPT

	[  456.455269] NIP: C00119CC LR: C0011914 CTR: C0011334

	[  456.460233] REGS: c01fbd40 TRAP: 0200   Tainted: P
(2.6.17.3)

	[  456.466493] MSR: 00041030 <ME,IR,DR>  CR: 22002082  XER:
20000000

	[  456.472589] TASK =3D c01b5f20[0] 'swapper' THREAD: c01fa000

	[  456.477809] GPR00: 00000000 C01FBDF0 C01B5F20 00000000
FFFFFF7F 00000003 00000001 C01FBE18

	[  456.486164] GPR08: 00000000 F0010904 00000000 F0010907
00000000 100934F0 07FFF000 00000001

	[  456.494520] GPR16: 00800000 07FFE964 FFFFFFFF 00000000
07FFC6BC 007FFF00 FF800040 07FA7770

	[  456.502876] GPR24: C0210000 C01FBE58 00000001 000000CF
C01FBE18 000000A0 C024A000 C03AAA00

	[  456.511406] NIP [C00119CC] indirect_read_config+0x100/0x14c

	[  456.516977] LR [C0011914] indirect_read_config+0x48/0x14c

	[  456.522373] Call Trace:

	[  456.524812] [C01FBDF0] [C01FA028]
init_thread_union+0x28/0x2000 (unreliable)

	[  456.531862] [C01FBE10] [C00E2FB0]
pci_bus_read_config_byte+0x60/0xa8

	[  456.538216] [C01FBE50] [C909373C] OnInterrupt+0x40/0x178
[bridge]

	[  456.544309] [C01FBE70] [C003EA54] handle_IRQ_event+0x64/0xb8

	[  456.549966] [C01FBE90] [C003EBE0] __do_IRQ+0x138/0x1c0

	[  456.555102] [C01FBEC0] [C0009D04] do_IRQ+0x44/0x88

	[  456.559889] [C01FBEE0] [C0004914] ret_from_except+0x0/0x14

	[  456.565372] [C01FBFA0] [C000C9B8] cpu_idle+0xe0/0xf8

	[  456.570334] [C01FBFB0] [C0003A64] rest_init+0x3c/0x4c

	[  456.575382] [C01FBFC0] [C01FC6C4] start_kernel+0x1d0/0x228

	[  456.580865] [C01FBFF0] [000032C0] 0x32c0

	[  456.584781] Instruction dump:

	[  456.587741] bb410008 38210020 7c0803a6 4e800020 887f004c
813e0010 5460063e 7c004a78

	[  456.595487] 3120ffff 7d490110 4bffff70 7c0928ae <0c000000>
4c00012c 901c0000 38600000

	 [  456.615184] Kernel panic - not syncing: Aiee, killing
interrupt handler!

	=20

	Cheers

	Tony

	=20

	Tony Hardie B.Sc
	VX Software Architect
	Net.com
	6900 Paseo Padre Parkway
	Fremont
	CA, 94555
	Ph: 510-574-2386
	Mob: 510-449-4339

	=20


------_=_NextPart_001_01C6E056.55DF04CC
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML xmlns=3D"http://www.w3.org/TR/REC-html40" xmlns:o =3D=20
"urn:schemas-microsoft-com:office:office" xmlns:w =3D=20
"urn:schemas-microsoft-com:office:word" xmlns:st1 =3D=20
"urn:schemas-microsoft-com:office:smarttags" xmlns:ns0 =3D=20
"urn:schemas-microsoft-com:office:smarttags"><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1561" name=3DGENERATOR><o:SmartTagType =
name=3D"City"=20
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"></o:SmartTagT=
ype><o:SmartTagType=20
name=3D"place"=20
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"></o:SmartTagT=
ype><o:SmartTagType=20
name=3D"Street"=20
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"></o:SmartTagT=
ype><o:SmartTagType=20
name=3D"address"=20
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"></o:SmartTagT=
ype><!--[if !mso]>
<STYLE>st1\:* {
	BEHAVIOR: url(#default#ieooui)
}
</STYLE>
<![endif]-->
<STYLE>@page Section1 {size: 8.5in 11.0in; margin: 1.0in 1.25in 1.0in =
1.25in; }
P.MsoNormal {
	FONT-SIZE: 12pt; MARGIN: 0in 0in 0pt; FONT-FAMILY: "Times New Roman"
}
LI.MsoNormal {
	FONT-SIZE: 12pt; MARGIN: 0in 0in 0pt; FONT-FAMILY: "Times New Roman"
}
DIV.MsoNormal {
	FONT-SIZE: 12pt; MARGIN: 0in 0in 0pt; FONT-FAMILY: "Times New Roman"
}
A:link {
	COLOR: blue; TEXT-DECORATION: underline
}
SPAN.MsoHyperlink {
	COLOR: blue; TEXT-DECORATION: underline
}
A:visited {
	COLOR: purple; TEXT-DECORATION: underline
}
SPAN.MsoHyperlinkFollowed {
	COLOR: purple; TEXT-DECORATION: underline
}
SPAN.EmailStyle17 {
	COLOR: windowtext; FONT-FAMILY: Arial; mso-style-type: personal-compose
}
DIV.Section1 {
	page: Section1
}
</STYLE>
</HEAD>
<BODY lang=3DEN-US vLink=3Dpurple link=3Dblue>
<DIV dir=3Dltr align=3Dleft><SPAN =
class=3D015315203-25092006></SPAN><FONT=20
face=3D&#23435;&#20307;><FONT color=3D#0000ff><FONT size=3D2>T<SPAN =
class=3D015315203-25092006>he=20
machine checking is happening when you configuration read from PCI=20
bus.</SPAN></FONT></FONT></FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3D&#23435;&#20307;><FONT =
color=3D#0000ff><FONT size=3D2><SPAN=20
class=3D015315203-25092006>please check the register settings for=20
PCI.</SPAN></FONT></FONT></FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3D&#23435;&#20307;><FONT =
color=3D#0000ff><FONT size=3D2><SPAN=20
class=3D015315203-25092006></SPAN></FONT></FONT></FONT>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3D&#23435;&#20307;><FONT =
color=3D#0000ff><FONT size=3D2><SPAN=20
class=3D015315203-25092006>-DAve</SPAN></FONT></FONT></FONT></DIV>
<BLOCKQUOTE dir=3Dltr=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px =
solid; MARGIN-RIGHT: 0px">
  <DIV></DIV>
  <DIV class=3DSection1>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">Hiya, I&#8217;m running =
into the=20
  following issue running on our custom PPC8270 (PQ2FADS style)=20
  system.<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">It only seems to happen =
when we=20
  load the system just a little (more PCI interrupts and=20
  transactions).<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p>&nbsp;</o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">Any=20
  ideas?<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p>&nbsp;</o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p>&nbsp;</o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">/ # [&nbsp; 456.440195] =
Machine=20
  check in kernel mode.<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp; 456.442646] =
Caused by=20
  (from SRR1=3D41030): Transfer error ack =
signal<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp; 456.448828] =
Oops: machine=20
  check, sig: 7 [#1]<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp; 456.453088]=20
  PREEMPT<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp; 456.455269] NIP: =
C00119CC=20
  LR: C0011914 CTR: C0011334<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp; 456.460233] =
REGS: c01fbd40=20
  TRAP: 0200&nbsp;&nbsp; Tainted: P&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  &nbsp;(2.6.17.3)<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp; 456.466493] MSR: =
00041030=20
  &lt;ME,IR,DR&gt;&nbsp; CR: 22002082&nbsp; XER:=20
  20000000<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp; 456.472589] TASK =
=3D=20
  c01b5f20[0] 'swapper' THREAD: c01fa000<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp; 456.477809] =
GPR00:=20
  00000000 C01FBDF0 C01B5F20 00000000 FFFFFF7F 00000003 00000001=20
  C01FBE18<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp; 456.486164] =
GPR08:=20
  00000000 F0010904 00000000 F0010907 00000000 100934F0 07FFF000=20
  00000001<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp; 456.494520] =
GPR16:=20
  00800000 07FFE964 FFFFFFFF 00000000 07FFC6BC 007FFF00 FF800040=20
  07FA7770<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp; 456.502876] =
GPR24:=20
  C0210000 C01FBE58 00000001 000000CF C01FBE18 000000A0 C024A000=20
  C03AAA00<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp; 456.511406] NIP =
[C00119CC]=20
  indirect_read_config+0x100/0x14c<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp; 456.516977] LR =
[C0011914]=20
  indirect_read_config+0x48/0x14c<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp; 456.522373] Call =

  Trace:<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp; 456.524812] =
[C01FBDF0]=20
  [C01FA028] init_thread_union+0x28/0x2000=20
  (unreliable)<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp; 456.531862] =
[C01FBE10]=20
  [C00E2FB0] =
pci_bus_read_config_byte+0x60/0xa8<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp; 456.538216] =
[C01FBE50]=20
  [C909373C] OnInterrupt+0x40/0x178 =
[bridge]<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp; 456.544309] =
[C01FBE70]=20
  [C003EA54] handle_IRQ_event+0x64/0xb8<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp; 456.549966] =
[C01FBE90]=20
  [C003EBE0] __do_IRQ+0x138/0x1c0<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp; 456.555102] =
[C01FBEC0]=20
  [C0009D04] do_IRQ+0x44/0x88<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp; 456.559889] =
[C01FBEE0]=20
  [C0004914] ret_from_except+0x0/0x14<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp; 456.565372] =
[C01FBFA0]=20
  [C000C9B8] cpu_idle+0xe0/0xf8<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp; 456.570334] =
[C01FBFB0]=20
  [C0003A64] rest_init+0x3c/0x4c<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp; 456.575382] =
[C01FBFC0]=20
  [C01FC6C4] start_kernel+0x1d0/0x228<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp; 456.580865] =
[C01FBFF0]=20
  [000032C0] 0x32c0<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp; 456.584781] =
Instruction=20
  dump:<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp; 456.587741] =
bb410008=20
  38210020 7c0803a6 4e800020 887f004c 813e0010 5460063e=20
  7c004a78<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp; 456.595487] =
3120ffff=20
  7d490110 4bffff70 7c0928ae &lt;0c000000&gt; 4c00012c 901c0000=20
  38600000<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;[&nbsp; =
456.615184] Kernel=20
  panic - not syncing: Aiee, killing interrupt=20
  handler!<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p>&nbsp;</o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">Cheers<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">Tony<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p>&nbsp;</o:p></SPAN></FONT></P>
  <P class=3DMsoNormal=20
  style=3D"mso-margin-top-alt: auto; mso-margin-bottom-alt: auto"><FONT =
face=3DArial=20
  size=3D2><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">Tony =
Hardie=20
  B.Sc<BR>VX Software Architect<BR>Net.com<BR><st1:Street =
w:st=3D"on"><st1:address=20
  style=3D"BACKGROUND-POSITION: left bottom; BACKGROUND-IMAGE: =
url(res://ietag.dll/#34/#1001); BACKGROUND-REPEAT: repeat-x"=20
  tabIndex=3D0 w:st=3D"on">6900 Paseo Padre=20
  Parkway</st1:address></st1:Street><BR><st1:place w:st=3D"on"><st1:City =

  w:st=3D"on">Fremont</st1:City></st1:place><BR><ns0:country-region=20
  w:endInsDate=3D"2006-09-22T10:32:00Z" w:endInsAuthor=3D"Tony Hardie"=20
  w:insDate=3D"2006-09-22T10:32:00Z" w:insAuthor=3D"Tony =
Hardie"><ns0:place=20
  w:endInsDate=3D"2006-09-22T10:32:00Z" w:endInsAuthor=3D"Tony Hardie"=20
  w:insDate=3D"2006-09-22T10:32:00Z" w:insAuthor=3D"Tony Hardie">CA,=20
  94555</ns0:place></ns0:country-region><BR>Ph: 510-574-2386<BR>Mob:=20
  510-449-4339</SPAN></FONT><o:p></o:p></P>
  <P class=3DMsoNormal><FONT face=3D"Times New Roman" size=3D3><SPAN=20
  style=3D"FONT-SIZE: =
12pt"><o:p>&nbsp;</o:p></SPAN></FONT></P></DIV></BLOCKQUOTE></BODY></HTML=
>

------_=_NextPart_001_01C6E056.55DF04CC--
