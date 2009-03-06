Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E350CDDF6F
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Mar 2009 16:40:57 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n265er0l006400
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Mar 2009 22:40:54 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n265ep2C004965
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Mar 2009 23:40:51 -0600 (CST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C99E1E.1BC79886"
Subject: RE: 83xx: Marking or Allocating Pages as Cache-Inhibited
Date: Fri, 6 Mar 2009 13:40:50 +0800
Message-ID: <D7CCA83BB0796C49BC0BB53B6AB1208916CF81@zch01exm21.fsl.freescale.net>
In-Reply-To: <64ac01180903052138k4226022cq840d497dccecd939@mail.gmail.com>
References: <64ac01180903052032i75792fa6x864f91c511b3f228@mail.gmail.com>
	<D7CCA83BB0796C49BC0BB53B6AB1208916CF73@zch01exm21.fsl.freescale.net>
	<D7CCA83BB0796C49BC0BB53B6AB1208916CF75@zch01exm21.fsl.freescale.net>
	<64ac01180903052138k4226022cq840d497dccecd939@mail.gmail.com>
From: "Liu Dave-R63238" <DaveLiu@freescale.com>
To: "Ben Menchaca" <ben.menchaca@gmail.com>
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

------_=_NextPart_001_01C99E1E.1BC79886
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

what is the value of ACR register?


________________________________

	From: Ben Menchaca [mailto:ben.menchaca@gmail.com]=20
	Sent: Friday, March 06, 2009 1:38 PM
	To: Liu Dave-R63238
	Cc: linuxppc-dev@ozlabs.org
	Subject: Re: 83xx: Marking or Allocating Pages as
Cache-Inhibited
=09
=09
	1.  BAT2 in linux is set to WIMG=3D0010, and covers all 64M
	2.  PEX_DEVICE_CONTROL in PCI-E Config Space (0x54): 0x1020
	3.  PEX_xDMA_CTRL is set to 0x00000401 at the initiation of the
DMA.
	4.  OWAR0 is set to 0xFFFFF005, so NSNP is 0.
	5.  The DMA descriptor (randomly chosen when I hit a
trigger...just ignore the size...) contains 0002AFF3 at offset 0, so
nosnoops are cleared. =20
=09
	Core is 400MHz, and CSB is 133MHz.
=09
	- Ben
=09
=09
	On Thu, Mar 5, 2009 at 11:27 PM, Liu Dave-R63238
<DaveLiu@freescale.com> wrote:
=09

		and what settings  is DMA description bit 3?
	=09

		> -----Original Message-----
		> From:
linuxppc-dev-bounces+daveliu=3Dfreescale.com@ozlabs.org
		> [mailto:linuxppc-dev-bounces+daveliu
<mailto:linuxppc-dev-bounces%2Bdaveliu> =3Dfreescale.com@ozlabs.org]
	=09
		>  On Behalf Of Liu Dave-R63238
		> Sent: Friday, March 06, 2009 1:22 PM
		> To: Ben Menchaca; linuxppc-dev@ozlabs.org
		> Subject: RE: 83xx: Marking or Allocating Pages as
Cache-Inhibited
		>
		> Did you enable the snoop bit at PEX_WDMA_CTRL[SNOOP]
and
		> PEX_RDMA_CTRL[SNOOP]?
		>
		> What is the freq settings? CORE/CSB bus.
		>
		> Thanks, Dave
		>
		> ________________________________
		>
		>       From:
linuxppc-dev-bounces+daveliu=3Dfreescale.com@ozlabs.org
		> [mailto:linuxppc-dev-bounces+daveliu
<mailto:linuxppc-dev-bounces%2Bdaveliu> =3Dfreescale.com@ozlabs.org]
		>  On Behalf Of Ben Menchaca
		>       Sent: Friday, March 06, 2009 12:33 PM
		>       To: linuxppc-dev@ozlabs.org
		>       Subject: 83xx: Marking or Allocating Pages as
Cache-Inhibited
		>
		>
		>       I am working on a Freescale 8314e design, and
the
		> embedded device is configured as a PCI-e endpoint
running a
		> 2.6.27-5 kernel.  For context, we have written a
kernel
		> module which, among other things, uses the RDMA/WDMA
engine
		> in the PCI-e IP block.  On the host side, these DMAs
are
		> coherent.  However, on the embedded side, things are
quite a
		> bit less rosy; we must manually flush/invalidate cache
lines
		> for WDMA/RDMAs to occur successfully.  After speaking
with
		> (several) FAEs at Freescale, we believe there is a
		> configuration issue that is the cause, but we have yet
to
		> have anyone successfully point to it.
		>
		>       Disabling the data cache altogether resolves the
issue
		> entirely, but of course, also completely tanks
performance.
		> As a temporary workaround, I would like to simply mark
the
		> pages (obtained currently via dma_alloc_coherent)
involved as
		> cache-inhibited.  I have attempted to do this via some
		> snippets remaining in fec.c (va_to_pte, uncache_pte to
set
		> _PAGE_NO_CACHE, flush_tlb_page, then unmap_pte), but
this is
		> almost certainly braindead; va_to_pte is not a part of
the
		> 83xx source, as far as I can tell; 8xx only.
		>
		>       A quick pointer in the correct direction for
marking
		> pages as cache-inhibited on a 2.6.27-5 kernel would be
		> appreciated, or if my approach to a workaround is
flawed, a
		> pointer to the correct way would be great.
		>
		>       Ben Menchaca
		>
		>
	=09
		> _______________________________________________
		> Linuxppc-dev mailing list
		> Linuxppc-dev@ozlabs.org
		> https://ozlabs.org/mailman/listinfo/linuxppc-dev
		>
		>
	=09



------_=_NextPart_001_01C99E1E.1BC79886
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3492" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D249334005-06032009><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>what is the value of ACR =
register?</FONT></SPAN></DIV><BR>
<BLOCKQUOTE=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px =
solid; MARGIN-RIGHT: 0px">
  <DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
  <HR tabIndex=3D-1>
  <FONT face=3DTahoma size=3D2><B>From:</B> Ben Menchaca=20
  [mailto:ben.menchaca@gmail.com] <BR><B>Sent:</B> Friday, March 06, =
2009 1:38=20
  PM<BR><B>To:</B> Liu Dave-R63238<BR><B>Cc:</B>=20
  linuxppc-dev@ozlabs.org<BR><B>Subject:</B> Re: 83xx: Marking or =
Allocating=20
  Pages as Cache-Inhibited<BR></FONT><BR></DIV>
  <DIV></DIV><FONT style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Tahoma"><FONT=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Tahoma"><FONT=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Tahoma"><FONT=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Tahoma"><FONT=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Tahoma">1.&nbsp; BAT2 in linux =
is set to=20
  WIMG=3D0010, and covers all 64M<BR>2.&nbsp; PEX_DEVICE_CONTROL in =
PCI-E Config=20
  Space (0x54): 0x1020<BR>3.&nbsp; PEX_xDMA_CTRL is set to=20
  <SPAN></SPAN>0x00000401 at the initiation of the DMA.<BR>4.&nbsp; =
OWAR0 is set=20
  to 0xFFFFF005, so NSNP is 0.<BR>5.&nbsp; The DMA descriptor (randomly =
chosen=20
  when I hit a trigger...just ignore the size...) contains 0002AFF3 at =
offset 0,=20
  so nosnoops are cleared.</FONT></FONT></FONT></FONT></FONT><FONT=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Tahoma"><FONT=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Tahoma"><FONT=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Tahoma"><FONT=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Tahoma">&nbsp; <BR><BR>Core is =
400MHz,=20
  and CSB is 133MHz.</FONT></FONT></FONT></FONT><BR><FONT =
color=3D#888888><BR>-=20
  Ben<BR></FONT><BR>
  <DIV class=3Dgmail_quote>On Thu, Mar 5, 2009 at 11:27 PM, Liu =
Dave-R63238 <SPAN=20
  dir=3Dltr>&lt;<A=20
  =
href=3D"mailto:DaveLiu@freescale.com">DaveLiu@freescale.com</A>&gt;</SPAN=
>=20
  wrote:<BR>
  <BLOCKQUOTE class=3Dgmail_quote=20
  style=3D"PADDING-LEFT: 1ex; MARGIN: 0pt 0pt 0pt 0.8ex; BORDER-LEFT: =
rgb(204,204,204) 1px solid">and=20
    what settings &nbsp;is DMA description bit 3?<BR>
    <DIV class=3Dim><BR>&gt; -----Original Message-----<BR>&gt; From:=20
    linuxppc-dev-bounces+daveliu=3D<A href=3D"http://freescale.com"=20
    target=3D_blank>freescale.com</A>@<A href=3D"http://ozlabs.org"=20
    target=3D_blank>ozlabs.org</A><BR>&gt; [mailto:<A=20
    =
href=3D"mailto:linuxppc-dev-bounces%2Bdaveliu">linuxppc-dev-bounces+davel=
iu</A>=3D<A=20
    href=3D"http://freescale.com" target=3D_blank>freescale.com</A>@<A=20
    href=3D"http://ozlabs.org" target=3D_blank>ozlabs.org</A>]<BR></DIV>
    <DIV>
    <DIV></DIV>
    <DIV class=3Dh5>&gt; &nbsp;On Behalf Of Liu Dave-R63238<BR>&gt; =
Sent: Friday,=20
    March 06, 2009 1:22 PM<BR>&gt; To: Ben Menchaca; <A=20
    =
href=3D"mailto:linuxppc-dev@ozlabs.org">linuxppc-dev@ozlabs.org</A><BR>&g=
t;=20
    Subject: RE: 83xx: Marking or Allocating Pages as=20
    Cache-Inhibited<BR>&gt;<BR>&gt; Did you enable the snoop bit at=20
    PEX_WDMA_CTRL[SNOOP] and<BR>&gt; =
PEX_RDMA_CTRL[SNOOP]?<BR>&gt;<BR>&gt; What=20
    is the freq settings? CORE/CSB bus.<BR>&gt;<BR>&gt; Thanks,=20
    Dave<BR>&gt;<BR>&gt; =
________________________________<BR>&gt;<BR>&gt; &nbsp;=20
    &nbsp; &nbsp; From: linuxppc-dev-bounces+daveliu=3D<A=20
    href=3D"http://freescale.com" target=3D_blank>freescale.com</A>@<A=20
    href=3D"http://ozlabs.org" target=3D_blank>ozlabs.org</A><BR>&gt; =
[mailto:<A=20
    =
href=3D"mailto:linuxppc-dev-bounces%2Bdaveliu">linuxppc-dev-bounces+davel=
iu</A>=3D<A=20
    href=3D"http://freescale.com" target=3D_blank>freescale.com</A>@<A=20
    href=3D"http://ozlabs.org" target=3D_blank>ozlabs.org</A>]<BR>&gt; =
&nbsp;On=20
    Behalf Of Ben Menchaca<BR>&gt; &nbsp; &nbsp; &nbsp; Sent: Friday, =
March 06,=20
    2009 12:33 PM<BR>&gt; &nbsp; &nbsp; &nbsp; To: <A=20
    =
href=3D"mailto:linuxppc-dev@ozlabs.org">linuxppc-dev@ozlabs.org</A><BR>&g=
t;=20
    &nbsp; &nbsp; &nbsp; Subject: 83xx: Marking or Allocating Pages as=20
    Cache-Inhibited<BR>&gt;<BR>&gt;<BR>&gt; &nbsp; &nbsp; &nbsp; I am =
working on=20
    a Freescale 8314e design, and the<BR>&gt; embedded device is =
configured as a=20
    PCI-e endpoint running a<BR>&gt; 2.6.27-5 kernel. &nbsp;For context, =
we have=20
    written a kernel<BR>&gt; module which, among other things, uses the=20
    RDMA/WDMA engine<BR>&gt; in the PCI-e IP block. &nbsp;On the host =
side,=20
    these DMAs are<BR>&gt; coherent. &nbsp;However, on the embedded =
side, things=20
    are quite a<BR>&gt; bit less rosy; we must manually flush/invalidate =
cache=20
    lines<BR>&gt; for WDMA/RDMAs to occur successfully. &nbsp;After =
speaking=20
    with<BR>&gt; (several) FAEs at Freescale, we believe there is =
a<BR>&gt;=20
    configuration issue that is the cause, but we have yet to<BR>&gt; =
have=20
    anyone successfully point to it.<BR>&gt;<BR>&gt; &nbsp; &nbsp; =
&nbsp;=20
    Disabling the data cache altogether resolves the issue<BR>&gt; =
entirely, but=20
    of course, also completely tanks performance.<BR>&gt; As a temporary =

    workaround, I would like to simply mark the<BR>&gt; pages (obtained=20
    currently via dma_alloc_coherent) involved as<BR>&gt; =
cache-inhibited.=20
    &nbsp;I have attempted to do this via some<BR>&gt; snippets =
remaining in=20
    fec.c (va_to_pte, uncache_pte to set<BR>&gt; _PAGE_NO_CACHE, =
flush_tlb_page,=20
    then unmap_pte), but this is<BR>&gt; almost certainly braindead; =
va_to_pte=20
    is not a part of the<BR>&gt; 83xx source, as far as I can tell; 8xx=20
    only.<BR>&gt;<BR>&gt; &nbsp; &nbsp; &nbsp; A quick pointer in the =
correct=20
    direction for marking<BR>&gt; pages as cache-inhibited on a 2.6.27-5 =
kernel=20
    would be<BR>&gt; appreciated, or if my approach to a workaround is =
flawed,=20
    a<BR>&gt; pointer to the correct way would be great.<BR>&gt;<BR>&gt; =
&nbsp;=20
    &nbsp; &nbsp; Ben Menchaca<BR>&gt;<BR>&gt;<BR></DIV></DIV>&gt;=20
    _______________________________________________<BR>&gt; Linuxppc-dev =
mailing=20
    list<BR>&gt; <A=20
    =
href=3D"mailto:Linuxppc-dev@ozlabs.org">Linuxppc-dev@ozlabs.org</A><BR>&g=
t; <A=20
    href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-dev"=20
    =
target=3D_blank>https://ozlabs.org/mailman/listinfo/linuxppc-dev</A><BR>&=
gt;<BR>&gt;<BR></BLOCKQUOTE></DIV><BR></BLOCKQUOTE></BODY></HTML>

------_=_NextPart_001_01C99E1E.1BC79886--
