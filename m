Return-Path: <duykynguyen@hotmail.com>
Received: from bay0-omc2-s31.bay0.hotmail.com (bay0-omc2-s31.bay0.hotmail.com
	[65.54.246.167]) by ozlabs.org (Postfix) with ESMTP id 6A111DDE1D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Jul 2008 13:44:02 +1000 (EST)
Message-ID: <BLU119-DAV61F2F984D2E145D1E4AA1BB8F0@phx.gbl>
From: "Duy-Ky Nguyen" <duykynguyen@hotmail.com>
To: "Liu Dave" <DaveLiu@freescale.com>,
	<linuxppc-embedded@ozlabs.org>
References: <BLU119-DAV11096F9EACC27956DCC87BBB8F0@phx.gbl>
	<58A20A281BAF1047B4EAE68DE5C0BDC2010573E9@zch01exm21.fsl.freescale.net>
Subject: Re: Failure of request_irq()  for MPC8313 using arch=powerpc
Date: Tue, 15 Jul 2008 20:43:59 -0700
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0028_01C8E6BB.81F418F0"
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

------=_NextPart_000_0028_01C8E6BB.81F418F0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dave,

I've just tried it and it failed.

Before I had tried using the function
int virq =3D of_irq_to_resource(GPIO_IRQ, 0, NULL);
and it failed the same way

I call request_irq() in the operation init and open, it behaves the same

I greatky appreciate your help, Dave.

Best Regards,

Duy-Ky

/////////////////////////////////////////////////////////////////////////=
/
// Start of capture

Unable to handle kernel paging request for data at address 0x0000005e
Faulting instruction address: 0xc000d1e8
Oops: Kernel access of bad area, sig: 11 [#1]

Modules linked in: ppc_drv
NIP: C000D1E8 LR: C000D274 CTR: C0006088
REGS: c7883d20 TRAP: 0300   Not tainted  (2.6.20)
MSR: 00009032 <EE,ME,IR,DR>  CR: 22000448  XER: 00000000
DAR: 0000005E, DSISR: 20000000
TASK =3D c053a810[767] 'rrgg' THREAD: c7882000
GPR00: C000D274 C7883DD0 C053A810 0000004A C0282BA8 C7883E08 C7FD9440 =
C0273EEC
GPR08: 00000000 00000000 00000100 C0006088 22000448 10018D00 07FFD000 =
28000422
GPR16: 10090000 100B0000 100B7328 00000000 00000000 00000000 100C8968 =
100C89A8
GPR24: 100BDFE8 00000000 00000000 C7FD9440 FFFFFFEA C7883E08 C0282BA8 =
0000004A
Call Trace:
[C7883DD0] [C7FD5EE8]  (unreliable)
[C7883DF0] [C000D274]
[C7883E00] [C0009FC8]
[C7883E30] [C000609C]
[C7883E60] [C9072030]
[C7883E70] [C0063E5C]
[C7883EA0] [C005FFAC]
[C7883EC0] [C0060244]
[C7883F20] [C00602B8]
[C7883F40] [C000F540]
--- Exception: c01Instruction dump:
409effc8 80030024 900b0020 4e800020 7d800026 9421ffe0 7c0802a6 bfa10014
7c9e2378 7cbd2b78 91810010 90010024 <83e30014> 2f9f0000 419e0028 =
2e050000
 Segmentation fault

// End of Capture

  ----- Original Message -----=20
  From: Liu Dave=20
  To: Duy-Ky Nguyen ; linuxppc-embedded@ozlabs.org=20
  Sent: Tuesday, July 15, 2008 7:09 PM
  Subject: RE: Failure of request_irq() for MPC8313 using arch=3Dpowerpc


  Hi Nguyen,

  If current PowerPC linux is using the virq to request_irq,
  you need do the irq_of_parse_and_map(np, 0) to get the virq.

  like.
  virq =3D irq_of_parse_and_map(np, 0)
  request_irq(virq,...);

  Hope it can help you.
  Thanks,
  Dave

-------------------------------------------------------------------------=
---
    From: linuxppc-embedded-bounces+daveliu=3Dfreescale.com@ozlabs.org =
[mailto:linuxppc-embedded-bounces+daveliu=3Dfreescale.com@ozlabs.org] On =
Behalf Of Duy-Ky Nguyen
    Sent: 2008=E5=B9=B47=E6=9C=8816=E6=97=A5 8:59 AM
    To: linuxppc-embedded@ozlabs.org
    Subject: Failure of request_irq() for MPC8313 using arch=3Dpowerpc


    Hello,

    I had no problem in using request_irq() for MPC8272 with arch=3Dppc =
from Montavista Linux

    But I have failure for MPC8313 with arch=3Dpowerpc from FreeScale =
LTIB Linux with error code -38

    I found its header file mpc83xx.h under include/asm-ppc, while it's =
supposed to be under include/asm-powerpc.

    I did try to copy the header file to directory asm-powerpc

    From MPC8313 datasheet, I have=20

    GPIO_IRQ =3D 74

    and I use

    DEVICE_NAME =3D "ppc"
    IRQ_FLAG =3D IRQF_SHARED    // use new flag
    here my function call

    request_irq (GPIO_IRQ,
          ppc_ISR, =20
          IRQ_FLAG,
          DEVICE_NAME,  =20
          NULL);  =20

    I'd appreciate any help on this problem.

    Best Regards,

    Duy-Kyng


------=_NextPart_000_0028_01C8E6BB.81F418F0
Content-Type: text/html;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=EF=BB=BF<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dutf-8">
<META content=3D"MSHTML 6.00.2900.3243" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi Dave,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I've just tried it and it =
failed.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Before I had tried using the =
function</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>int virq =3D =
of_irq_to_resource(GPIO_IRQ, 0,=20
NULL);</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>and it failed the same way</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I call request_irq() in the operation =
init and=20
open, it behaves the same</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I greatky appreciate your help, =
Dave.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Best Regards,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Duy-Ky</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial=20
size=3D2>////////////////////////////////////////////////////////////////=
//////////</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>// Start of capture</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Unable to handle kernel paging request =
for data at=20
address 0x0000005e<BR>Faulting instruction address: 0xc000d1e8<BR>Oops: =
Kernel=20
access of bad area, sig: 11 [#1]</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Modules linked in: ppc_drv<BR>NIP: =
C000D1E8 LR:=20
C000D274 CTR: C0006088<BR>REGS: c7883d20 TRAP: 0300&nbsp;&nbsp; Not=20
tainted&nbsp; (2.6.20)<BR>MSR: 00009032 &lt;EE,ME,IR,DR&gt;&nbsp; CR:=20
22000448&nbsp; XER: 00000000<BR>DAR: 0000005E, DSISR: 20000000<BR>TASK =
=3D=20
c053a810[767] 'rrgg' THREAD: c7882000<BR>GPR00: C000D274 C7883DD0 =
C053A810=20
0000004A C0282BA8 C7883E08 C7FD9440 C0273EEC<BR>GPR08: 00000000 00000000 =

00000100 C0006088 22000448 10018D00 07FFD000 28000422<BR>GPR16: 10090000 =

100B0000 100B7328 00000000 00000000 00000000 100C8968 100C89A8<BR>GPR24: =

100BDFE8 00000000 00000000 C7FD9440 FFFFFFEA C7883E08 C0282BA8 =
0000004A<BR>Call=20
Trace:<BR>[C7883DD0] [C7FD5EE8]&nbsp; (unreliable)<BR>[C7883DF0]=20
[C000D274]<BR>[C7883E00] [C0009FC8]<BR>[C7883E30] =
[C000609C]<BR>[C7883E60]=20
[C9072030]<BR>[C7883E70] [C0063E5C]<BR>[C7883EA0] =
[C005FFAC]<BR>[C7883EC0]=20
[C0060244]<BR>[C7883F20] [C00602B8]<BR>[C7883F40] [C000F540]<BR>--- =
Exception:=20
c01Instruction dump:<BR>409effc8 80030024 900b0020 4e800020 7d800026 =
9421ffe0=20
7c0802a6 bfa10014<BR>7c9e2378 7cbd2b78 91810010 90010024 =
&lt;83e30014&gt;=20
2f9f0000 419e0028 2e050000<BR>&nbsp;Segmentation fault<BR></FONT></DIV>
<DIV><FONT face=3DArial size=3D2>// End of Capture</DIV></FONT>
<DIV><FONT face=3DArial size=3D2>&nbsp;</DIV></FONT>
<BLOCKQUOTE dir=3Dltr=20
style=3D"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px; =
BORDER-LEFT: #000000 2px solid; MARGIN-RIGHT: 0px">
  <DIV style=3D"FONT: 10pt arial">----- Original Message ----- </DIV>
  <DIV=20
  style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black"><B>From:</B>=20
  <A title=3DDaveLiu@freescale.com =
href=3D"mailto:DaveLiu@freescale.com">Liu=20
  Dave</A> </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>To:</B> <A =
title=3Dduykynguyen@hotmail.com=20
  href=3D"mailto:duykynguyen@hotmail.com">Duy-Ky Nguyen</A> ; <A=20
  title=3Dlinuxppc-embedded@ozlabs.org=20
  =
href=3D"mailto:linuxppc-embedded@ozlabs.org">linuxppc-embedded@ozlabs.org=
</A>=20
  </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Sent:</B> Tuesday, July 15, 2008 =
7:09=20
PM</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Subject:</B> RE: Failure of =
request_irq() for=20
  MPC8313 using arch=3Dpowerpc</DIV>
  <DIV><BR></DIV>
  <DIV dir=3Dltr align=3Dleft><SPAN class=3D317245801-16072008><FONT =
face=3DArial=20
  color=3D#0000ff size=3D2>Hi Nguyen,</FONT></SPAN></DIV>
  <DIV dir=3Dltr align=3Dleft><SPAN class=3D317245801-16072008><FONT =
face=3DArial=20
  color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
  <DIV dir=3Dltr align=3Dleft><SPAN class=3D317245801-16072008><FONT =
face=3DArial=20
  color=3D#0000ff size=3D2>If current PowerPC linux is using the virq to =

  request_irq,</FONT></SPAN></DIV>
  <DIV dir=3Dltr align=3Dleft><SPAN class=3D317245801-16072008><FONT =
face=3DArial=20
  color=3D#0000ff size=3D2>you need do the irq_of_parse_and_map(np, 0) =
to get the=20
  virq.</FONT></SPAN></DIV>
  <DIV dir=3Dltr align=3Dleft><SPAN class=3D317245801-16072008><FONT =
face=3DArial=20
  color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
  <DIV dir=3Dltr align=3Dleft><SPAN class=3D317245801-16072008><FONT =
face=3DArial=20
  color=3D#0000ff size=3D2>like.</FONT></SPAN></DIV>
  <DIV dir=3Dltr align=3Dleft><SPAN class=3D317245801-16072008><FONT =
face=3DArial=20
  color=3D#0000ff size=3D2>virq =3D irq_of_parse_and_map(np, =
0)</FONT></SPAN></DIV>
  <DIV dir=3Dltr align=3Dleft><SPAN class=3D317245801-16072008><FONT =
face=3DArial=20
  color=3D#0000ff size=3D2>request_irq(virq,...);</FONT></SPAN></DIV>
  <DIV>&nbsp;</DIV>
  <DIV><SPAN class=3D317245801-16072008></SPAN><FONT face=3DArial><FONT=20
  color=3D#0000ff><FONT size=3D2>H<SPAN class=3D317245801-16072008>ope =
it can help=20
  you.</SPAN></FONT></FONT></FONT></DIV>
  <DIV><FONT size=3D+0><FONT color=3D#0000ff><FONT size=3D2><SPAN=20
  class=3D317245801-16072008></SPAN></FONT></FONT></FONT><SPAN=20
  class=3D317245801-16072008></SPAN><FONT face=3DArial><FONT =
color=3D#0000ff><FONT=20
  size=3D2>T<SPAN=20
class=3D317245801-16072008>hanks,</SPAN></FONT></FONT></FONT></DIV>
  <DIV><FONT size=3D+0><FONT color=3D#0000ff><FONT size=3D2><SPAN=20
  class=3D317245801-16072008></SPAN></FONT></FONT></FONT><SPAN=20
  class=3D317245801-16072008></SPAN><FONT face=3DArial><FONT =
color=3D#0000ff><FONT=20
  size=3D2>D<SPAN =
class=3D317245801-16072008>ave</SPAN></FONT></FONT></FONT></DIV>
  <BLOCKQUOTE dir=3Dltr=20
  style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px =
solid; MARGIN-RIGHT: 0px">
    <DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr =
align=3Dleft>
    <HR tabIndex=3D-1>
    <FONT face=3DTahoma size=3D2><B>From:</B> <A=20
    =
href=3D"mailto:linuxppc-embedded-bounces+daveliu=3Dfreescale.com@ozlabs.o=
rg">linuxppc-embedded-bounces+daveliu=3Dfreescale.com@ozlabs.org</A>=20
    =
[mailto:linuxppc-embedded-bounces+daveliu=3Dfreescale.com@ozlabs.org] =
<B>On=20
    Behalf Of </B>Duy-Ky Nguyen<BR><B>Sent:</B> =
2008=E5=B9=B47=E6=9C=8816=E6=97=A5 8:59 AM<BR><B>To:</B>=20
    <A=20
    =
href=3D"mailto:linuxppc-embedded@ozlabs.org">linuxppc-embedded@ozlabs.org=
</A><BR><B>Subject:</B>=20
    Failure of request_irq() for MPC8313 using =
arch=3Dpowerpc<BR></FONT><BR></DIV>
    <DIV></DIV>
    <DIV><FONT face=3DArial size=3D2>Hello,</FONT></DIV>
    <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
    <DIV><FONT face=3DArial size=3D2>I had no problem in using =
request_irq() for=20
    MPC8272 with arch=3Dppc from Montavista Linux</FONT></DIV>
    <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
    <DIV><FONT face=3DArial size=3D2>But I have failure for MPC8313 with =

    arch=3Dpowerpc from FreeScale LTIB Linux with error code =
-38</FONT></DIV>
    <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
    <DIV><FONT face=3DArial size=3D2>I found its header file mpc83xx.h =
under=20
    include/asm-ppc, while it's supposed to be under=20
    include/asm-powerpc.</FONT></DIV>
    <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
    <DIV><FONT face=3DArial size=3D2>I did try to copy the header file =
to directory=20
    asm-powerpc</FONT></DIV>
    <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
    <DIV><FONT face=3DArial size=3D2>From MPC8313 datasheet, I have =
</FONT></DIV>
    <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
    <DIV><FONT face=3DArial size=3D2>GPIO_IRQ =3D 74</FONT></DIV>
    <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
    <DIV><FONT face=3DArial size=3D2>and I use</FONT></DIV>
    <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
    <DIV><FONT face=3DArial size=3D2>DEVICE_NAME =3D "ppc"</FONT></DIV>
    <DIV><FONT face=3DArial size=3D2>IRQ_FLAG =3D =
IRQF_SHARED&nbsp;&nbsp;&nbsp; // use=20
    new flag</FONT></DIV>
    <DIV><FONT face=3DArial size=3D2>here my function call</FONT></DIV>
    <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
    <DIV><FONT face=3DArial size=3D2>request_irq (GPIO_IRQ,</FONT></DIV>
    <DIV><FONT face=3DArial=20
    =
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ppc_ISR,&nbsp;&nbsp;</FONT><=
/DIV>
    <DIV><FONT face=3DArial=20
    =
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;IRQ_FLAG,<BR>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;DEVICE_NAME,&nbsp;&nbsp;&nbsp;<BR>&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;NULL);&nbsp;&nbsp;&nbsp;<BR></FONT></DIV>
    <DIV><FONT face=3DArial size=3D2>I'd appreciate any help on this=20
    problem.</FONT></DIV>
    <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
    <DIV><FONT face=3DArial size=3D2>Best Regards,</FONT></DIV>
    <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
    <DIV><FONT face=3DArial size=3D2>Duy-Kyng</FONT></DIV>
    <DIV><FONT face=3DArial size=3D2>&nbsp;</DIV></FONT>
    <DIV><FONT face=3DArial=20
size=3D2>&nbsp;</DIV></BLOCKQUOTE></BLOCKQUOTE></FONT></BODY></HTML>

------=_NextPart_000_0028_01C8E6BB.81F418F0--
