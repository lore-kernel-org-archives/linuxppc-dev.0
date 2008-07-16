Return-Path: <DaveLiu@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0F830DDEEE
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Jul 2008 12:09:11 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m6G296DU022296 for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Jul 2008 19:09:06 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m6G293Lf002420
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Jul 2008 21:09:04 -0500 (CDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8E6E8.EB2F7BD5"
Subject: RE: Failure of request_irq()  for MPC8313 using arch=powerpc
Date: Wed, 16 Jul 2008 10:09:02 +0800
Message-ID: <58A20A281BAF1047B4EAE68DE5C0BDC2010573E9@zch01exm21.fsl.freescale.net>
In-Reply-To: <BLU119-DAV11096F9EACC27956DCC87BBB8F0@phx.gbl>
References: <BLU119-DAV11096F9EACC27956DCC87BBB8F0@phx.gbl>
From: "Liu Dave" <DaveLiu@freescale.com>
To: "Duy-Ky Nguyen" <duykynguyen@hotmail.com>, <linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C8E6E8.EB2F7BD5
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Nguyen,
=20
If current PowerPC linux is using the virq to request_irq,
you need do the irq_of_parse_and_map(np, 0) to get the virq.
=20
like.
virq =3D irq_of_parse_and_map(np, 0)
request_irq(virq,...);
=20
Hope it can help you.
Thanks,
Dave

________________________________

	From: linuxppc-embedded-bounces+daveliu=3Dfreescale.com@ozlabs.org =
[mailto:linuxppc-embedded-bounces+daveliu=3Dfreescale.com@ozlabs.org] On =
Behalf Of Duy-Ky Nguyen
	Sent: 2008?7?16? 8:59 AM
	To: linuxppc-embedded@ozlabs.org
	Subject: Failure of request_irq() for MPC8313 using arch=3Dpowerpc
=09
=09
	Hello,
	=20
	I had no problem in using request_irq() for MPC8272 with arch=3Dppc =
from Montavista Linux
	=20
	But I have failure for MPC8313 with arch=3Dpowerpc from FreeScale LTIB =
Linux with error code -38
	=20
	I found its header file mpc83xx.h under include/asm-ppc, while it's =
supposed to be under include/asm-powerpc.
	=20
	I did try to copy the header file to directory asm-powerpc
	=20
	From MPC8313 datasheet, I have=20
	=20
	GPIO_IRQ =3D 74
	=20
	and I use
	=20
	DEVICE_NAME =3D "ppc"
	IRQ_FLAG =3D IRQF_SHARED    // use new flag
	here my function call
	=20
	request_irq (GPIO_IRQ,
	      ppc_ISR, =20
	      IRQ_FLAG,
	      DEVICE_NAME,  =20
	      NULL);  =20
=09
	I'd appreciate any help on this problem.
	=20
	Best Regards,
	=20
	Duy-Kyng
	=20
	=20


------_=_NextPart_001_01C8E6E8.EB2F7BD5
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1611" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D317245801-16072008><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>Hi Nguyen,</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D317245801-16072008><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D317245801-16072008><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>If current PowerPC linux is using the virq to=20
request_irq,</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D317245801-16072008><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>you need do the irq_of_parse_and_map(np, 0) to =
get the=20
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
color=3D#0000ff><FONT size=3D2>H<SPAN class=3D317245801-16072008>ope it =
can help=20
you.</SPAN></FONT></FONT></FONT></DIV>
<DIV><FONT><FONT color=3D#0000ff><FONT size=3D2><SPAN=20
class=3D317245801-16072008></SPAN></FONT></FONT></FONT><SPAN=20
class=3D317245801-16072008></SPAN><FONT face=3DArial><FONT =
color=3D#0000ff><FONT=20
size=3D2>T<SPAN =
class=3D317245801-16072008>hanks,</SPAN></FONT></FONT></FONT></DIV>
<DIV><FONT><FONT color=3D#0000ff><FONT size=3D2><SPAN=20
class=3D317245801-16072008></SPAN></FONT></FONT></FONT><SPAN=20
class=3D317245801-16072008></SPAN><FONT face=3DArial><FONT =
color=3D#0000ff><FONT=20
size=3D2>D<SPAN =
class=3D317245801-16072008>ave</SPAN></FONT></FONT></FONT></DIV>
<BLOCKQUOTE dir=3Dltr=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px =
solid; MARGIN-RIGHT: 0px">
  <DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
  <HR tabIndex=3D-1>
  <FONT face=3DTahoma size=3D2><B>From:</B>=20
  linuxppc-embedded-bounces+daveliu=3Dfreescale.com@ozlabs.org=20
  [mailto:linuxppc-embedded-bounces+daveliu=3Dfreescale.com@ozlabs.org] =
<B>On=20
  Behalf Of </B>Duy-Ky Nguyen<BR><B>Sent:</B> =
2008&#24180;7&#26376;16&#26085; 8:59 AM<BR><B>To:</B>=20
  linuxppc-embedded@ozlabs.org<BR><B>Subject:</B> Failure of =
request_irq() for=20
  MPC8313 using arch=3Dpowerpc<BR></FONT><BR></DIV>
  <DIV></DIV>
  <DIV><FONT face=3DArial size=3D2>Hello,</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3DArial size=3D2>I had no problem in using =
request_irq() for=20
  MPC8272 with arch=3Dppc from Montavista Linux</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3DArial size=3D2>But I have failure for MPC8313 with =
arch=3Dpowerpc=20
  from FreeScale LTIB Linux with error code -38</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3DArial size=3D2>I found its header file mpc83xx.h =
under=20
  include/asm-ppc, while it's supposed to be under=20
  include/asm-powerpc.</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3DArial size=3D2>I did try to copy the header file to =
directory=20
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
  <DIV><FONT face=3DArial =
size=3D2>&nbsp;</DIV></BLOCKQUOTE></FONT></BODY></HTML>

------_=_NextPart_001_01C8E6E8.EB2F7BD5--
