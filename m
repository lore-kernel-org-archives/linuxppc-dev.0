Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 87CFB67B52
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Aug 2006 11:45:26 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k7I1jPGG002621 for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Aug 2006 18:45:25 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k7I1jMEj018419
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Aug 2006 20:45:24 -0500 (CDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6C267.F7BA8835"
Subject: RE: reboot on PQ2FADS board.
Date: Fri, 18 Aug 2006 09:45:21 +0800
Message-ID: <995B09A8299C2C44B59866F6391D26350CDA9C@zch01exm21.fsl.freescale.net>
In-Reply-To: <BE82DD0EDDEFDE4CA878520C017D8C6F045BA3CF@eolrexc1.eolcorporate.com>
From: "Liu Dave-r63238" <DaveLiu@freescale.com>
To: "Zhimin \(Jimmy\) Liu" <zliu@edgar-online.com>,
	<linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C6C267.F7BA8835
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Liu,
=20
please try this..
=20
     u32 msr;
    =20
     volatile immap_t *immap =3D (immap_t *) IMAP_ADDR;
    =20
    =20
     /* Interrupts and MachineCheck off */
     __asm__ __volatile__ ("mfmsr    %0":"=3Dr" (msr):);
    =20
     msr &=3D ~(MSR_ME | MSR_EE);
     __asm__ __volatile__ ("mtmsr    %0"::"r" (msr));=20
    =20
     immap->im_clkrst.car_rmr =3D 1;    /* Checkstop Reset enable */

     immap->resxxx =3D 0;        /* please find one immap illegal =
address
                                   access it, trig reset */
     for (;;);



________________________________

	From: linuxppc-embedded-bounces+daveliu=3Dfreescale.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+daveliu=3Dfreescale.com@ozlabs.org] On
Behalf Of Zhimin (Jimmy) Liu
	Sent: Friday, August 18, 2006 1:00 AM
	To: linuxppc-embedded@ozlabs.org
	Subject: reboot on PQ2FADS board.
=09
=09

	Did you sovlve the problem? I have same issue for the  PQ2FADS
board.=20

	jimmy=20


------_=_NextPart_001_01C6C267.F7BA8835
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>reboot on PQ2FADS board.</TITLE>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1555" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D070543201-18082006><FONT =
face=3D&#23435;&#20307;=20
color=3D#0000ff size=3D2>Hi Liu,</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D070543201-18082006><FONT =
face=3D&#23435;&#20307;=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D070543201-18082006><FONT =
face=3D&#23435;&#20307;=20
color=3D#0000ff size=3D2>please try this..</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D070543201-18082006><FONT =
face=3D&#23435;&#20307;=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D070543201-18082006><FONT =
face=3D&#23435;&#20307;=20
color=3D#0000ff size=3D2>&nbsp;&nbsp;&nbsp;&nbsp; u32=20
msr;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>&nbsp;&nbsp;&nbsp;&nbsp; =
volatile=20
immap_t *immap =3D (immap_t *)=20
IMAP_ADDR;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;<BR>&nbsp;&nbsp;&nbsp;&nbsp;=20
/* Interrupts and MachineCheck off */<BR>&nbsp;&nbsp;&nbsp;&nbsp; =
__asm__=20
__volatile__ ("mfmsr&nbsp;&nbsp;&nbsp; %0":"=3Dr"=20
(msr):);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>&nbsp;&nbsp;&nbsp;&nbsp; =
msr=20
&amp;=3D ~(MSR_ME | MSR_EE);<BR>&nbsp;&nbsp;&nbsp;&nbsp; __asm__ =
__volatile__=20
("mtmsr&nbsp;&nbsp;&nbsp; %0"::"r"=20
(msr));&nbsp;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR></FONT></SPAN><FONT =
face=3D&#23435;&#20307;=20
color=3D#0000ff size=3D2>&nbsp;&nbsp;&nbsp;&nbsp; =
immap-&gt;im_clkrst.car_rmr =3D=20
1;&nbsp;&nbsp;&nbsp; /* Checkstop Reset enable */<BR></DIV></FONT>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D070543201-18082006><FONT =
face=3D&#23435;&#20307;=20
color=3D#0000ff size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;immap-&gt;resxxx =
=3D=20
0;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/*&nbsp;please find=20
one&nbsp;immap illegal address</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D070543201-18082006><FONT =
face=3D&#23435;&#20307;=20
color=3D#0000ff=20
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
access=20
it, trig reset&nbsp;*/<BR>&nbsp;&nbsp;&nbsp;&nbsp; for=20
(;;);<BR></DIV></FONT></SPAN><BR>
<BLOCKQUOTE dir=3Dltr=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px =
solid; MARGIN-RIGHT: 0px">
  <DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
  <HR tabIndex=3D-1>
  <FONT face=3DTahoma size=3D2><B>From:</B>=20
  linuxppc-embedded-bounces+daveliu=3Dfreescale.com@ozlabs.org=20
  [mailto:linuxppc-embedded-bounces+daveliu=3Dfreescale.com@ozlabs.org] =
<B>On=20
  Behalf Of </B>Zhimin (Jimmy) Liu<BR><B>Sent:</B> Friday, August 18, =
2006 1:00=20
  AM<BR><B>To:</B> linuxppc-embedded@ozlabs.org<BR><B>Subject:</B> =
reboot on=20
  PQ2FADS board.<BR></FONT><BR></DIV>
  <DIV></DIV><!-- Converted from text/rtf format -->
  <P><FONT face=3DArial size=3D2>Did you sovlve the problem? I have same =
issue for=20
  the&nbsp; PQ2FADS board.</FONT> </P>
  <P><FONT face=3DArial size=3D2>jimmy</FONT> =
</P></BLOCKQUOTE></BODY></HTML>

------_=_NextPart_001_01C6C267.F7BA8835--
