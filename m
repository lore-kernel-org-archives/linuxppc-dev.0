Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D3F64DDEE7
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Mar 2009 17:30:09 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n266U4Ad021371
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Mar 2009 23:30:04 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n266U328017672
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Mar 2009 00:30:03 -0600 (CST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C99E24.FB41BDA6"
Subject: RE: 83xx: Marking or Allocating Pages as Cache-Inhibited
Date: Fri, 6 Mar 2009 14:30:02 +0800
Message-ID: <D7CCA83BB0796C49BC0BB53B6AB1208916CF98@zch01exm21.fsl.freescale.net>
In-Reply-To: <64ac01180903052210r2aee7246g50fd0656c491a40b@mail.gmail.com>
References: <64ac01180903052032i75792fa6x864f91c511b3f228@mail.gmail.com>
	<D7CCA83BB0796C49BC0BB53B6AB1208916CF73@zch01exm21.fsl.freescale.net>
	<D7CCA83BB0796C49BC0BB53B6AB1208916CF75@zch01exm21.fsl.freescale.net>
	<64ac01180903052138k4226022cq840d497dccecd939@mail.gmail.com>
	<D7CCA83BB0796C49BC0BB53B6AB1208916CF81@zch01exm21.fsl.freescale.net>
	<64ac01180903052210r2aee7246g50fd0656c491a40b@mail.gmail.com>
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

------_=_NextPart_001_01C99E24.FB41BDA6
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Did you enable the descriptor bit 3 to have a try?


________________________________

	From: Ben Menchaca [mailto:ben.menchaca@gmail.com]=20
	Sent: Friday, March 06, 2009 2:10 PM
	To: Liu Dave-R63238
	Cc: linuxppc-dev@ozlabs.org
	Subject: Re: 83xx: Marking or Allocating Pages as
Cache-Inhibited
=09
=09
	I can look at ACR morning...although I can say with a fair
amount of certainty that I have not changed it from the POR value.
=09
	I will try enabling No Snoop for CSB in the descriptor (bit 3,
yes?)...this seems a bit counterintuitive to me.
=09
	What is the hope regarding these two?  Some combination I am not
seeing?
=09
=09
=09
	On Thu, Mar 5, 2009 at 11:40 PM, Liu Dave-R63238
<DaveLiu@freescale.com> wrote:
=09

		what is the value of ACR register?


________________________________

			From: Ben Menchaca
[mailto:ben.menchaca@gmail.com]=20
			Sent: Friday, March 06, 2009 1:38 PM
			To: Liu Dave-R63238
			Cc: linuxppc-dev@ozlabs.org
			Subject: Re: 83xx: Marking or Allocating Pages
as Cache-Inhibited
		=09
		=09
			1.  BAT2 in linux is set to WIMG=3D0010, and
covers all 64M
			2.  PEX_DEVICE_CONTROL in PCI-E Config Space
(0x54): 0x1020
			3.  PEX_xDMA_CTRL is set to 0x00000401 at the
initiation of the DMA.
			4.  OWAR0 is set to 0xFFFFF005, so NSNP is 0.
			5.  The DMA descriptor (randomly chosen when I
hit a trigger...just ignore the size...) contains 0002AFF3 at offset 0,
so nosnoops are cleared. =20
		=09
			Core is 400MHz, and CSB is 133MHz.
		=09
			- Ben
		=09
		=09
			On Thu, Mar 5, 2009 at 11:27 PM, Liu Dave-R63238
<DaveLiu@freescale.com> wrote:
		=09

				and what settings  is DMA description
bit 3?
			=09

				> -----Original Message-----
				> From:
linuxppc-dev-bounces+daveliu=3Dfreescale.com@ozlabs.org
				> [mailto:linuxppc-dev-bounces+daveliu
<mailto:linuxppc-dev-bounces%2Bdaveliu> =3Dfreescale.com@ozlabs.org]
			=09
				>  On Behalf Of Liu Dave-R63238
				> Sent: Friday, March 06, 2009 1:22 PM
				> To: Ben Menchaca;
linuxppc-dev@ozlabs.org
				> Subject: RE: 83xx: Marking or
Allocating Pages as Cache-Inhibited
				>
				> Did you enable the snoop bit at
PEX_WDMA_CTRL[SNOOP] and
				> PEX_RDMA_CTRL[SNOOP]?
				>
				> What is the freq settings? CORE/CSB
bus.
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
				>       Sent: Friday, March 06, 2009
12:33 PM
				>       To: linuxppc-dev@ozlabs.org
				>       Subject: 83xx: Marking or
Allocating Pages as Cache-Inhibited
				>
				>
				>       I am working on a Freescale
8314e design, and the
				> embedded device is configured as a
PCI-e endpoint running a
				> 2.6.27-5 kernel.  For context, we have
written a kernel
				> module which, among other things, uses
the RDMA/WDMA engine
				> in the PCI-e IP block.  On the host
side, these DMAs are
				> coherent.  However, on the embedded
side, things are quite a
				> bit less rosy; we must manually
flush/invalidate cache lines
				> for WDMA/RDMAs to occur successfully.
After speaking with
				> (several) FAEs at Freescale, we
believe there is a
				> configuration issue that is the cause,
but we have yet to
				> have anyone successfully point to it.
				>
				>       Disabling the data cache
altogether resolves the issue
				> entirely, but of course, also
completely tanks performance.
				> As a temporary workaround, I would
like to simply mark the
				> pages (obtained currently via
dma_alloc_coherent) involved as
				> cache-inhibited.  I have attempted to
do this via some
				> snippets remaining in fec.c
(va_to_pte, uncache_pte to set
				> _PAGE_NO_CACHE, flush_tlb_page, then
unmap_pte), but this is
				> almost certainly braindead; va_to_pte
is not a part of the
				> 83xx source, as far as I can tell; 8xx
only.
				>
				>       A quick pointer in the correct
direction for marking
				> pages as cache-inhibited on a 2.6.27-5
kernel would be
				> appreciated, or if my approach to a
workaround is flawed, a
				> pointer to the correct way would be
great.
				>
				>       Ben Menchaca
				>
				>
			=09
				>
_______________________________________________
				> Linuxppc-dev mailing list
				> Linuxppc-dev@ozlabs.org
				>
https://ozlabs.org/mailman/listinfo/linuxppc-dev
				>
				>
			=09




------_=_NextPart_001_01C99E24.FB41BDA6
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3492" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D922142906-06032009><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>Did you enable the descriptor bit 3 to have a=20
try?</FONT></SPAN></DIV><BR>
<BLOCKQUOTE=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px =
solid; MARGIN-RIGHT: 0px">
  <DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
  <HR tabIndex=3D-1>
  <FONT face=3DTahoma size=3D2><B>From:</B> Ben Menchaca=20
  [mailto:ben.menchaca@gmail.com] <BR><B>Sent:</B> Friday, March 06, =
2009 2:10=20
  PM<BR><B>To:</B> Liu Dave-R63238<BR><B>Cc:</B>=20
  linuxppc-dev@ozlabs.org<BR><B>Subject:</B> Re: 83xx: Marking or =
Allocating=20
  Pages as Cache-Inhibited<BR></FONT><BR></DIV>
  <DIV></DIV>I can look at ACR morning...although I can say with a fair =
amount=20
  of certainty that I have not changed it from the POR value.<BR><BR>I =
will try=20
  enabling No Snoop for CSB in the descriptor (bit 3, yes?)...this seems =
a bit=20
  counterintuitive to me.<BR><BR>What is the hope regarding these =
two?&nbsp;=20
  Some combination I am not seeing?<BR><BR><BR>
  <DIV class=3Dgmail_quote>On Thu, Mar 5, 2009 at 11:40 PM, Liu =
Dave-R63238 <SPAN=20
  dir=3Dltr>&lt;<A href=3D"mailto:DaveLiu@freescale.com"=20
  target=3D_blank>DaveLiu@freescale.com</A>&gt;</SPAN> wrote:<BR>
  <BLOCKQUOTE class=3Dgmail_quote=20
  style=3D"PADDING-LEFT: 1ex; MARGIN: 0pt 0pt 0pt 0.8ex; BORDER-LEFT: =
rgb(204,204,204) 1px solid">
    <DIV>
    <DIV dir=3Dltr align=3Dleft><SPAN><FONT face=3DArial color=3D#0000ff =
size=3D2>what is=20
    the value of ACR register?</FONT></SPAN></DIV><BR>
    <BLOCKQUOTE=20
    style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: =
rgb(0,0,255) 2px solid; MARGIN-RIGHT: 0px">
      <DIV lang=3Den-us dir=3Dltr align=3Dleft>
      <HR>
      <FONT face=3DTahoma size=3D2><B>From:</B> Ben Menchaca [mailto:<A=20
      href=3D"mailto:ben.menchaca@gmail.com"=20
      target=3D_blank>ben.menchaca@gmail.com</A>] <BR><B>Sent:</B> =
Friday, March=20
      06, 2009 1:38 PM<BR><B>To:</B> Liu Dave-R63238<BR><B>Cc:</B> <A=20
      href=3D"mailto:linuxppc-dev@ozlabs.org"=20
      target=3D_blank>linuxppc-dev@ozlabs.org</A><BR><B>Subject:</B> Re: =
83xx:=20
      Marking or Allocating Pages as =
Cache-Inhibited<BR></FONT><BR></DIV>
      <DIV>
      <DIV></DIV>
      <DIV>
      <DIV></DIV><FONT style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Tahoma"><FONT=20
      style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Tahoma"><FONT=20
      style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Tahoma"><FONT=20
      style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Tahoma"><FONT=20
      style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Tahoma">1.&nbsp; BAT2 in =
linux is set=20
      to WIMG=3D0010, and covers all 64M<BR>2.&nbsp; PEX_DEVICE_CONTROL =
in PCI-E=20
      Config Space (0x54): 0x1020<BR>3.&nbsp; PEX_xDMA_CTRL is set to=20
      <SPAN></SPAN>0x00000401 at the initiation of the DMA.<BR>4.&nbsp; =
OWAR0 is=20
      set to 0xFFFFF005, so NSNP is 0.<BR>5.&nbsp; The DMA descriptor =
(randomly=20
      chosen when I hit a trigger...just ignore the size...) contains =
0002AFF3=20
      at offset 0, so nosnoops are=20
      cleared.</FONT></FONT></FONT></FONT></FONT><FONT=20
      style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Tahoma"><FONT=20
      style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Tahoma"><FONT=20
      style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Tahoma"><FONT=20
      style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Tahoma">&nbsp; <BR><BR>Core =
is=20
      400MHz, and CSB is 133MHz.</FONT></FONT></FONT></FONT><BR><FONT=20
      color=3D#888888><BR>- Ben<BR></FONT><BR>
      <DIV class=3Dgmail_quote>On Thu, Mar 5, 2009 at 11:27 PM, Liu =
Dave-R63238=20
      <SPAN dir=3Dltr>&lt;<A href=3D"mailto:DaveLiu@freescale.com"=20
      target=3D_blank>DaveLiu@freescale.com</A>&gt;</SPAN> wrote:<BR>
      <BLOCKQUOTE class=3Dgmail_quote=20
      style=3D"PADDING-LEFT: 1ex; MARGIN: 0pt 0pt 0pt 0.8ex; =
BORDER-LEFT: rgb(204,204,204) 1px solid">and=20
        what settings &nbsp;is DMA description bit 3?<BR>
        <DIV><BR>&gt; -----Original Message-----<BR>&gt; From:=20
        linuxppc-dev-bounces+daveliu=3D<A href=3D"http://freescale.com"=20
        target=3D_blank>freescale.com</A>@<A href=3D"http://ozlabs.org"=20
        target=3D_blank>ozlabs.org</A><BR>&gt; [mailto:<A=20
        href=3D"mailto:linuxppc-dev-bounces%2Bdaveliu"=20
        target=3D_blank>linuxppc-dev-bounces+daveliu</A>=3D<A=20
        href=3D"http://freescale.com" =
target=3D_blank>freescale.com</A>@<A=20
        href=3D"http://ozlabs.org" =
target=3D_blank>ozlabs.org</A>]<BR></DIV>
        <DIV>
        <DIV></DIV>
        <DIV>&gt; &nbsp;On Behalf Of Liu Dave-R63238<BR>&gt; Sent: =
Friday, March=20
        06, 2009 1:22 PM<BR>&gt; To: Ben Menchaca; <A=20
        href=3D"mailto:linuxppc-dev@ozlabs.org"=20
        target=3D_blank>linuxppc-dev@ozlabs.org</A><BR>&gt; Subject: RE: =
83xx:=20
        Marking or Allocating Pages as Cache-Inhibited<BR>&gt;<BR>&gt; =
Did you=20
        enable the snoop bit at PEX_WDMA_CTRL[SNOOP] and<BR>&gt;=20
        PEX_RDMA_CTRL[SNOOP]?<BR>&gt;<BR>&gt; What is the freq settings? =

        CORE/CSB bus.<BR>&gt;<BR>&gt; Thanks, Dave<BR>&gt;<BR>&gt;=20
        ________________________________<BR>&gt;<BR>&gt; &nbsp; &nbsp; =
&nbsp;=20
        From: linuxppc-dev-bounces+daveliu=3D<A =
href=3D"http://freescale.com"=20
        target=3D_blank>freescale.com</A>@<A href=3D"http://ozlabs.org"=20
        target=3D_blank>ozlabs.org</A><BR>&gt; [mailto:<A=20
        href=3D"mailto:linuxppc-dev-bounces%2Bdaveliu"=20
        target=3D_blank>linuxppc-dev-bounces+daveliu</A>=3D<A=20
        href=3D"http://freescale.com" =
target=3D_blank>freescale.com</A>@<A=20
        href=3D"http://ozlabs.org" =
target=3D_blank>ozlabs.org</A>]<BR>&gt; &nbsp;On=20
        Behalf Of Ben Menchaca<BR>&gt; &nbsp; &nbsp; &nbsp; Sent: =
Friday, March=20
        06, 2009 12:33 PM<BR>&gt; &nbsp; &nbsp; &nbsp; To: <A=20
        href=3D"mailto:linuxppc-dev@ozlabs.org"=20
        target=3D_blank>linuxppc-dev@ozlabs.org</A><BR>&gt; &nbsp; =
&nbsp; &nbsp;=20
        Subject: 83xx: Marking or Allocating Pages as=20
        Cache-Inhibited<BR>&gt;<BR>&gt;<BR>&gt; &nbsp; &nbsp; &nbsp; I =
am=20
        working on a Freescale 8314e design, and the<BR>&gt; embedded =
device is=20
        configured as a PCI-e endpoint running a<BR>&gt; 2.6.27-5 =
kernel.=20
        &nbsp;For context, we have written a kernel<BR>&gt; module =
which, among=20
        other things, uses the RDMA/WDMA engine<BR>&gt; in the PCI-e IP =
block.=20
        &nbsp;On the host side, these DMAs are<BR>&gt; coherent. =
&nbsp;However,=20
        on the embedded side, things are quite a<BR>&gt; bit less rosy; =
we must=20
        manually flush/invalidate cache lines<BR>&gt; for WDMA/RDMAs to =
occur=20
        successfully. &nbsp;After speaking with<BR>&gt; (several) FAEs =
at=20
        Freescale, we believe there is a<BR>&gt; configuration issue =
that is the=20
        cause, but we have yet to<BR>&gt; have anyone successfully point =
to=20
        it.<BR>&gt;<BR>&gt; &nbsp; &nbsp; &nbsp; Disabling the data =
cache=20
        altogether resolves the issue<BR>&gt; entirely, but of course, =
also=20
        completely tanks performance.<BR>&gt; As a temporary workaround, =
I would=20
        like to simply mark the<BR>&gt; pages (obtained currently via=20
        dma_alloc_coherent) involved as<BR>&gt; cache-inhibited. &nbsp;I =
have=20
        attempted to do this via some<BR>&gt; snippets remaining in =
fec.c=20
        (va_to_pte, uncache_pte to set<BR>&gt; _PAGE_NO_CACHE, =
flush_tlb_page,=20
        then unmap_pte), but this is<BR>&gt; almost certainly braindead; =

        va_to_pte is not a part of the<BR>&gt; 83xx source, as far as I =
can=20
        tell; 8xx only.<BR>&gt;<BR>&gt; &nbsp; &nbsp; &nbsp; A quick =
pointer in=20
        the correct direction for marking<BR>&gt; pages as =
cache-inhibited on a=20
        2.6.27-5 kernel would be<BR>&gt; appreciated, or if my approach =
to a=20
        workaround is flawed, a<BR>&gt; pointer to the correct way would =
be=20
        great.<BR>&gt;<BR>&gt; &nbsp; &nbsp; &nbsp; Ben=20
        Menchaca<BR>&gt;<BR>&gt;<BR></DIV></DIV>&gt;=20
        _______________________________________________<BR>&gt; =
Linuxppc-dev=20
        mailing list<BR>&gt; <A href=3D"mailto:Linuxppc-dev@ozlabs.org"=20
        target=3D_blank>Linuxppc-dev@ozlabs.org</A><BR>&gt; <A=20
        href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-dev"=20
        =
target=3D_blank>https://ozlabs.org/mailman/listinfo/linuxppc-dev</A><BR>&=
gt;<BR>&gt;<BR></BLOCKQUOTE></DIV><BR></DIV></DIV></BLOCKQUOTE></DIV></BL=
OCKQUOTE></DIV><BR></BLOCKQUOTE></BODY></HTML>

------_=_NextPart_001_01C99E24.FB41BDA6--
