Return-Path: <bantonovici@priority.mb.ca>
Message-ID: <000d01c5911b$0f049430$cd01a8c0@DESIGNLAB>
From: "Bogdan Antonovici" <bantonovici@priority.mb.ca>
To: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>
References: <1121959795.800.18.camel@rd-lab>
	<1a928a85f53f5dcd972161356611a312@embeddededge.com>
	<1122047198.6726.13.camel@rd-lab> <20050722125750.GA5950@dmt.cnet>
Date: Mon, 25 Jul 2005 08:16:24 -0500
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_000A_01C590F1.26038490"
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, linuxppc-embedded@ozlabs.org,
	ppckernel <ppckernel@ppckernel.org>
Subject: Re: swap_dup: Bad swap file entry 00480020
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_000A_01C590F1.26038490
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Yes, it was. After some research on the previous message i realized that =
it run out of memory so i did mem=3D8M and it hasn't been crashed since =
then.
I still would like to understand why that swap code was run when the =
swapping wasn't activated at all.
Thank you.
Bogdan
  ----- Original Message -----=20
  From: Marcelo Tosatti=20
  To: bogdan antonovici=20
  Cc: Dan Malek ; linuxppc-dev ; ppckernel ; =
linuxppc-embedded@ozlabs.org=20
  Sent: Friday, July 22, 2005 7:57 AM
  Subject: Re: swap_dup: Bad swap file entry 00480020


  On Fri, Jul 22, 2005 at 10:46:38AM -0500, bogdan antonovici wrote:
  > Hi Dan,
  >=20
  > I checked the driver code. I found a pointer that was in my opinion
  > initialized too late and i corrected that but other than that i =
haven't
  > found anything.
  > I ran the driver alone, enabling the interrupts and the interrupt
  > routine doesn't cause any trouble.
  > I started my application and i haven't seen any sign of trouble.
  > But once i started also the snmpd after few interrupts i got the
  > message:
  >=20
  > __alloc_pages: 0-order allocation failed (gfp=3D0x1d2/0)
  > VM: killing process sectionmond

  Thats a different problem: you ran out of memory and the VM can't swap
  out any data.

  So its likely that the pagetable corruption is gone (it was indeed a =
bug
  in the driver as Dan suspected).

  > sectionmond being my application.
  > My read and write driver operation are requesting a page for a =
buffer
  > but they also release it. Should i declare the buffer pointer with
  > volatile attribute?
  > Do you know what may cause that message?

  Out of memory condition.

------=_NextPart_000_000A_01C590F1.26038490
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2745.2800" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Yes, it was. After some research on the =
previous=20
message i realized that it run out of memory so i did mem=3D8M and it =
hasn't been=20
crashed since then.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I still would like to understand why =
that swap code=20
was run when the swapping wasn't activated at all.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Thank you.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Bogdan</FONT></DIV>
<BLOCKQUOTE=20
style=3D"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px; =
BORDER-LEFT: #000000 2px solid; MARGIN-RIGHT: 0px">
  <DIV style=3D"FONT: 10pt arial">----- Original Message ----- </DIV>
  <DIV=20
  style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black"><B>From:</B>=20
  <A title=3Dmarcelo.tosatti@cyclades.com=20
  href=3D"mailto:marcelo.tosatti@cyclades.com">Marcelo Tosatti</A> =
</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>To:</B> <A =
title=3Dbantonovici@priority.mb.ca=20
  href=3D"mailto:bantonovici@priority.mb.ca">bogdan antonovici</A> =
</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Cc:</B> <A =
title=3Ddan@embeddededge.com=20
  href=3D"mailto:dan@embeddededge.com">Dan Malek</A> ; <A=20
  title=3Dlinuxppc-dev@ozlabs.org=20
  href=3D"mailto:linuxppc-dev@ozlabs.org">linuxppc-dev</A> ; <A=20
  title=3Dppckernel@ppckernel.org=20
  href=3D"mailto:ppckernel@ppckernel.org">ppckernel</A> ; <A=20
  title=3Dlinuxppc-embedded@ozlabs.org=20
  =
href=3D"mailto:linuxppc-embedded@ozlabs.org">linuxppc-embedded@ozlabs.org=
</A>=20
  </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Sent:</B> Friday, July 22, 2005 =
7:57 AM</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Subject:</B> Re: swap_dup: Bad swap =
file=20
  entry 00480020</DIV>
  <DIV><BR></DIV>On Fri, Jul 22, 2005 at 10:46:38AM -0500, bogdan =
antonovici=20
  wrote:<BR>&gt; Hi Dan,<BR>&gt; <BR>&gt; I checked the driver code. I =
found a=20
  pointer that was in my opinion<BR>&gt; initialized too late and i =
corrected=20
  that but other than that i haven't<BR>&gt; found anything.<BR>&gt; I =
ran the=20
  driver alone, enabling the interrupts and the interrupt<BR>&gt; =
routine=20
  doesn't cause any trouble.<BR>&gt; I started my application and i =
haven't seen=20
  any sign of trouble.<BR>&gt; But once i started also the snmpd after =
few=20
  interrupts i got the<BR>&gt; message:<BR>&gt; <BR>&gt; __alloc_pages: =
0-order=20
  allocation failed (gfp=3D0x1d2/0)<BR>&gt; VM: killing process=20
  sectionmond<BR><BR>Thats a different problem: you ran out of memory =
and the VM=20
  can't swap<BR>out any data.<BR><BR>So its likely that the pagetable =
corruption=20
  is gone (it was indeed a bug<BR>in the driver as Dan =
suspected).<BR><BR>&gt;=20
  sectionmond being my application.<BR>&gt; My read and write driver =
operation=20
  are requesting a page for a buffer<BR>&gt; but they also release it. =
Should i=20
  declare the buffer pointer with<BR>&gt; volatile attribute?<BR>&gt; Do =
you=20
  know what may cause that message?<BR><BR>Out of memory=20
condition.</BLOCKQUOTE></BODY></HTML>

------=_NextPart_000_000A_01C590F1.26038490--
