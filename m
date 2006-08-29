Return-Path: <DaveLiu@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 8A45C67B66
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Aug 2006 12:12:26 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k7T3VLQe027204 for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Aug 2006 21:31:21 -0600 (MDT)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k7T2CLC6022379
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Aug 2006 21:12:23 -0500 (CDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6CB10.8F5B8D3B"
Subject: RE: MPC83xx and Gianfar Drive Oops
Date: Tue, 29 Aug 2006 10:12:20 +0800
Message-ID: <995B09A8299C2C44B59866F6391D263511B9EE@zch01exm21.fsl.freescale.net>
In-Reply-To: <5a4792c00608281633p4921016fn62a6f7cedba9e03@mail.gmail.com>
From: "Liu Dave-r63238" <DaveLiu@freescale.com>
To: "SIP COP 009" <sipcop009@gmail.com>, <linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C6CB10.8F5B8D3B
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Do testing with the latest kernel version,
see if it still have the oops.


________________________________

	From: linuxppc-embedded-bounces+daveliu=3Dfreescale.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+daveliu=3Dfreescale.com@ozlabs.org] On
Behalf Of SIP COP 009
	Sent: Tuesday, August 29, 2006 7:34 AM
	To: linuxppc-embedded@ozlabs.org
	Cc: sipcop009@gmail.com
	Subject: MPC83xx and Gianfar Drive Oops
=09
=09
	Folks,
=09
	Anyone seen this before ?
=09
	We have the MPC8349 based EVM board which has 2 GigEs. IP
forwarding is enabled on the system. The kernel/gianfar is  2.6.11
based.
=09
	We were trying to stress the GigE interfaces by sending
bidirectional smartbits traffic.=20
=09
	We observe the following kernel oops:
	e-99-0-21-1# Oops: Exception in kernel mode, sig: 5 [#1]
	NIP: C016EB80 LR: C016EB80 SP: C0241DE0 REGS: c0241d30 TRAP:
0700
	Tainted: P
	MSR: 00029032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11 TASK =3D
c022bdb0[0] 'swapper' THREAD: c0240000 Last syscall: 120
	GPR00: C016EB80 C0241DE0 C022BDB0 00000030 C0263BF4 000001A1
DF700060 3B9ACA00
	GPR08: C0263BF8 C023DB24 DEA5DE9C C0241CF0 00003C9B 1001A1F8
1FFF8000 00000000
	GPR16: FFFFFFFF 00000001 00000000 1FFF297C 1FF9E330 00000001
007FFF00 C0230000
	GPR24: 00000001 0000FFFC DFD6B800 0000003F DDC42F48 00000000
D7FA9140 DFD6BA20 Call trace: [c01495d4]  [c0149748]  [c0176078]
[c0018d34]  [c0018e00] [c0005438]  [c000460c]  [c00038ac]  [c00054d0]
[c0003928]  [c0242674] [000035fc] Kernel panic - not syncing: Aiee,
killing interrupt handler!
	  <0>Rebooting in 180 seconds..
=09
	After decoding this it looks like the following:
=09
	Enter hex value: c01495d4
	0xc01495d4:gfar_error(0xc01494bc)+0x118
	Enter hex value: c0149748
	0xc0149748:gfar_gdrvinfo(0xc0149718)+0x30
	Enter hex value: c0176078
	0xc0176078:dev_ioctl(0xc0175f0c)+0x16c
	Enter hex value: c0018d34
	0xc0018d34:__do_softirq(0xc0018cb4)+0x80
	Enter hex value: c0018e00
	0xc0018e00:do_softirq(0xc0018da8)+0x58
	Enter hex value: c0005438
	0xc0005438:do_IRQ(0xc00053b4)+0x84
	Enter hex value: c000460c
	0xc000460c:ret_from_except(0xc000460c)+0x0
	Enter hex value: c00038ac
	0xc00038ac:ppc6xx_idle(0xc00037c8)+0xe4
	Enter hex value: c00054d0
	0xc00054d0:cpu_idle(0xc00054a8)+0x28
=09
	Any idea on this one ? Any new fixes that went in for such
issues ?
=09
	Thanks!
	ashutosh
=09
=09


------_=_NextPart_001_01C6CB10.8F5B8D3B
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1555" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D260051002-29082006><FONT =
face=3D&#23435;&#20307;=20
color=3D#0000ff size=3D2>Do testing with the latest kernel=20
version,</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D260051002-29082006><FONT =
face=3D&#23435;&#20307;=20
color=3D#0000ff size=3D2>see if it still have the =
oops.</FONT></SPAN></DIV><BR>
<BLOCKQUOTE=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px =
solid; MARGIN-RIGHT: 0px">
  <DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
  <HR tabIndex=3D-1>
  <FONT face=3DTahoma size=3D2><B>From:</B>=20
  linuxppc-embedded-bounces+daveliu=3Dfreescale.com@ozlabs.org=20
  [mailto:linuxppc-embedded-bounces+daveliu=3Dfreescale.com@ozlabs.org] =
<B>On=20
  Behalf Of </B>SIP COP 009<BR><B>Sent:</B> Tuesday, August 29, 2006 =
7:34=20
  AM<BR><B>To:</B> linuxppc-embedded@ozlabs.org<BR><B>Cc:</B>=20
  sipcop009@gmail.com<BR><B>Subject:</B> MPC83xx and Gianfar Drive=20
  Oops<BR></FONT><BR></DIV>
  <DIV></DIV>Folks,<BR><BR>Anyone seen this before ?<BR><BR>We have the =
MPC8349=20
  based EVM board which has 2 GigEs. IP forwarding is enabled on the =
system. The=20
  kernel/gianfar is&nbsp; 2.6.11 based.<BR><BR>We were trying to stress =
the GigE=20
  interfaces by sending bidirectional smartbits traffic. <BR><BR>We =
observe the=20
  following kernel oops:<BR>e-99-0-21-1# Oops: Exception in kernel mode, =
sig: 5=20
  [#1]<BR>NIP: C016EB80 LR: C016EB80 SP: C0241DE0 REGS: c0241d30 TRAP:=20
  0700<BR>Tainted: P<BR>MSR: 00029032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11 =
TASK =3D=20
  c022bdb0[0] 'swapper' THREAD: c0240000 Last syscall: 120<BR>GPR00: =
C016EB80=20
  C0241DE0 C022BDB0 00000030 C0263BF4 000001A1 DF700060 =
3B9ACA00<BR>GPR08:=20
  C0263BF8 C023DB24 DEA5DE9C C0241CF0 00003C9B 1001A1F8 1FFF8000=20
  00000000<BR>GPR16: FFFFFFFF 00000001 00000000 1FFF297C 1FF9E330 =
00000001=20
  007FFF00 C0230000<BR>GPR24: 00000001 0000FFFC DFD6B800 0000003F =
DDC42F48=20
  00000000 D7FA9140 DFD6BA20 Call trace: [c01495d4]&nbsp; =
[c0149748]&nbsp;=20
  [c0176078]&nbsp; [c0018d34]&nbsp; [c0018e00] [c0005438]&nbsp; =
[c000460c]&nbsp;=20
  [c00038ac]&nbsp; [c00054d0]&nbsp; [c0003928]&nbsp; [c0242674] =
[000035fc]=20
  Kernel panic - not syncing: Aiee, killing interrupt handler!<BR>&nbsp; =

  &lt;0&gt;Rebooting in 180 seconds..<BR><BR>After decoding this it =
looks like=20
  the following:<BR><BR>Enter hex value:=20
  c01495d4<BR>0xc01495d4:gfar_error(0xc01494bc)+0x118<BR>Enter hex =
value:=20
  c0149748<BR>0xc0149748:gfar_gdrvinfo(0xc0149718)+0x30<BR>Enter hex =
value:=20
  c0176078<BR>0xc0176078:dev_ioctl(0xc0175f0c)+0x16c<BR>Enter hex value: =

  c0018d34<BR>0xc0018d34:__do_softirq(0xc0018cb4)+0x80<BR>Enter hex =
value:=20
  c0018e00<BR>0xc0018e00:do_softirq(0xc0018da8)+0x58<BR>Enter hex value: =

  c0005438<BR>0xc0005438:do_IRQ(0xc00053b4)+0x84<BR>Enter hex value:=20
  c000460c<BR>0xc000460c:ret_from_except(0xc000460c)+0x0<BR>Enter hex =
value:=20
  c00038ac<BR>0xc00038ac:ppc6xx_idle(0xc00037c8)+0xe4<BR>Enter hex =
value:=20
  c00054d0<BR>0xc00054d0:cpu_idle(0xc00054a8)+0x28<BR><BR>Any idea on =
this one ?=20
  Any new fixes that went in for such issues=20
?<BR><BR>Thanks!<BR>ashutosh<BR><BR></BLOCKQUOTE></BODY></HTML>

------_=_NextPart_001_01C6CB10.8F5B8D3B--
