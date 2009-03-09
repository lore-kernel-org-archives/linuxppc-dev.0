Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9A401DDFB0
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Mar 2009 13:31:18 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n292Uw2L022686
	for <linuxppc-dev@ozlabs.org>; Sun, 8 Mar 2009 19:31:03 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n292Uupc005591
	for <linuxppc-dev@ozlabs.org>; Sun, 8 Mar 2009 21:30:56 -0500 (CDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9A05F.12CAD3AA"
Subject: RE: 83xx: Marking or Allocating Pages as Cache-Inhibited
Date: Mon, 9 Mar 2009 10:30:52 +0800
Message-ID: <D7CCA83BB0796C49BC0BB53B6AB1208916D06A@zch01exm21.fsl.freescale.net>
In-Reply-To: <64ac01180903060830m1e5927c6y76b8302b0fb68eb6@mail.gmail.com>
References: <64ac01180903052032i75792fa6x864f91c511b3f228@mail.gmail.com>
	<D7CCA83BB0796C49BC0BB53B6AB1208916CF73@zch01exm21.fsl.freescale.net>
	<D7CCA83BB0796C49BC0BB53B6AB1208916CF75@zch01exm21.fsl.freescale.net>
	<64ac01180903052138k4226022cq840d497dccecd939@mail.gmail.com>
	<D7CCA83BB0796C49BC0BB53B6AB1208916CF81@zch01exm21.fsl.freescale.net>
	<64ac01180903052210r2aee7246g50fd0656c491a40b@mail.gmail.com>
	<D7CCA83BB0796C49BC0BB53B6AB1208916CF98@zch01exm21.fsl.freescale.net>
	<64ac01180903060812n1f355207lb3fa6de3ed17ae41@mail.gmail.com>
	<64ac01180903060830m1e5927c6y76b8302b0fb68eb6@mail.gmail.com>
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

------_=_NextPart_001_01C9A05F.12CAD3AA
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi Ben,
=20
The second issue. you told me "some hosts" has problem,
and some hosts worked well.
=20
what is the problem-hosts?
=20
The issue seems like the hosts did set the NO SNOOP attribute
bit at TLP.
=20
The PEX_DEVICE_CONTROL is standard PCI configuration space
register, it controls the behavior of the initiator's transaction.
For 8315, it is outbound, not inbound transaction.
=20
Thanks, Dave


________________________________

	From: Ben Menchaca [mailto:ben.menchaca@gmail.com]=20
	Sent: Saturday, March 07, 2009 12:30 AM
	To: Liu Dave-R63238
	Cc: linuxppc-dev@ozlabs.org
	Subject: Re: 83xx: Marking or Allocating Pages as
Cache-Inhibited
=09
=09
	Thank you for your help!  That bit resolved all of the RDMA/WDMA
coherency issues on the CSB side...except:
=09
	We expose a 1MB region of memory from CSB via a BAR (BAR1, if it
matters) to the Host.  This region is also not behaving correctly with
respect to coherency on SOME hosts; again, disabling our cache makes it
work correctly on all hosts.  We have set PEX_DEVICE_CONTROL in PCI-E
Config Space (0x54) to 0x2010 (sorry about the endianness below).  We
thought that CLEARING the no-snoop bit here would indicate that snooping
was required for this region...is this a similar issue?
=09
	- Ben
=09
=09
	On Fri, Mar 6, 2009 at 10:12 AM, Ben Menchaca
<ben.menchaca@gmail.com> wrote:
=09

		Testing now...it looks like it (almost) works, though!
Why does setting no-snoop cause snooping to work?  More on the effect on
setting that bit in a few minutes...need more testing.
		=20
		ACR is 0x00030300.
	=09
		- Ben=20


		On Fri, Mar 6, 2009 at 12:30 AM, Liu Dave-R63238
<DaveLiu@freescale.com> wrote:
	=09

			Did you enable the descriptor bit 3 to have a
try?


________________________________

			=09
				From: Ben Menchaca
[mailto:ben.menchaca@gmail.com]=20
			=09
				Sent: Friday, March 06, 2009 2:10 PM=20

				To: Liu Dave-R63238
				Cc: linuxppc-dev@ozlabs.org
				Subject: Re: 83xx: Marking or Allocating
Pages as Cache-Inhibited
			=09

				I can look at ACR morning...although I
can say with a fair amount of certainty that I have not changed it from
the POR value.
			=09
				I will try enabling No Snoop for CSB in
the descriptor (bit 3, yes?)...this seems a bit counterintuitive to me.
			=09
				What is the hope regarding these two?
Some combination I am not seeing?
			=09
			=09
			=09
				On Thu, Mar 5, 2009 at 11:40 PM, Liu
Dave-R63238 <DaveLiu@freescale.com> wrote:
			=09

				what is the value of ACR register?


________________________________

				From: Ben Menchaca
[mailto:ben.menchaca@gmail.com]=20
				Sent: Friday, March 06, 2009 1:38 PM
				To: Liu Dave-R63238
				Cc: linuxppc-dev@ozlabs.org
				Subject: Re: 83xx: Marking or Allocating
Pages as Cache-Inhibited
			=09
			=09
				1.  BAT2 in linux is set to WIMG=3D0010,
and covers all 64M
				2.  PEX_DEVICE_CONTROL in PCI-E Config
Space (0x54): 0x1020
				3.  PEX_xDMA_CTRL is set to 0x00000401
at the initiation of the DMA.
				4.  OWAR0 is set to 0xFFFFF005, so NSNP
is 0.
				5.  The DMA descriptor (randomly chosen
when I hit a trigger...just ignore the size...) contains 0002AFF3 at
offset 0, so nosnoops are cleared. =20
			=09
				Core is 400MHz, and CSB is 133MHz.
			=09
				- Ben
			=09
			=09
				On Thu, Mar 5, 2009 at 11:27 PM, Liu
Dave-R63238 <DaveLiu@freescale.com> wrote:
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






------_=_NextPart_001_01C9A05F.12CAD3AA
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3492" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D456321902-09032009><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>Hi Ben,</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D456321902-09032009><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D456321902-09032009><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>The second issue. you told me "some hosts" has=20
problem,</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D456321902-09032009><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>and some hosts worked well.</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D456321902-09032009><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D456321902-09032009><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>what is the problem-hosts?</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D456321902-09032009><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D456321902-09032009><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>The issue seems like the hosts did set the NO =
SNOOP=20
attribute</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D456321902-09032009><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>bit at TLP.</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D456321902-09032009><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D456321902-09032009><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>The PEX_DEVICE_CONTROL is standard PCI =
configuration=20
space</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D456321902-09032009><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>register, it controls the behavior of the =
initiator's=20
transaction.</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D456321902-09032009><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>For 8315, it is outbound, not inbound=20
transaction.</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D456321902-09032009><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D456321902-09032009><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>Thanks, Dave</FONT></SPAN></DIV><BR>
<BLOCKQUOTE=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px =
solid; MARGIN-RIGHT: 0px">
  <DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
  <HR tabIndex=3D-1>
  <FONT face=3DTahoma size=3D2><B>From:</B> Ben Menchaca=20
  [mailto:ben.menchaca@gmail.com] <BR><B>Sent:</B> Saturday, March 07, =
2009=20
  12:30 AM<BR><B>To:</B> Liu Dave-R63238<BR><B>Cc:</B>=20
  linuxppc-dev@ozlabs.org<BR><B>Subject:</B> Re: 83xx: Marking or =
Allocating=20
  Pages as Cache-Inhibited<BR></FONT><BR></DIV>
  <DIV></DIV>Thank you for your help!&nbsp; That bit resolved all of the =

  RDMA/WDMA coherency issues on the CSB side...except:<BR><BR>We expose =
a 1MB=20
  region of memory from CSB via a BAR (BAR1, if it matters) to the =
Host.&nbsp;=20
  This region is also not behaving correctly with respect to coherency =
on SOME=20
  hosts; again, disabling our cache makes it work correctly on all =
hosts.&nbsp;=20
  We have set <FONT style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Tahoma"><FONT =

  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Tahoma"><FONT=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Tahoma"><FONT=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Tahoma"><FONT=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Tahoma">PEX_DEVICE_CONTROL in =
PCI-E=20
  Config Space (0x54) to </FONT></FONT></FONT></FONT></FONT><FONT=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Tahoma"><FONT=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Tahoma"><FONT=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Tahoma"><FONT=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Tahoma"><FONT=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Tahoma">0x2010 (sorry about the =

  endianness below).&nbsp; We thought that CLEARING the no-snoop bit =
here would=20
  indicate that snooping was required for this region...is this a =
similar=20
  issue?<BR><BR>- Ben<BR></FONT></FONT></FONT></FONT></FONT><BR>
  <DIV class=3Dgmail_quote>On Fri, Mar 6, 2009 at 10:12 AM, Ben Menchaca =
<SPAN=20
  dir=3Dltr>&lt;<A=20
  =
href=3D"mailto:ben.menchaca@gmail.com">ben.menchaca@gmail.com</A>&gt;</SP=
AN>=20
  wrote:<BR>
  <BLOCKQUOTE class=3Dgmail_quote=20
  style=3D"PADDING-LEFT: 1ex; MARGIN: 0pt 0pt 0pt 0.8ex; BORDER-LEFT: =
rgb(204,204,204) 1px solid">Testing=20
    now...it looks like it (almost) works, though!&nbsp; Why does =
setting=20
    no-snoop cause snooping to work?&nbsp; More on the effect on setting =
that=20
    bit in a few minutes...need more testing.<BR>&nbsp;<BR>ACR is=20
    0x00030300.<BR><FONT color=3D#888888><BR>- Ben</FONT>
    <DIV>
    <DIV></DIV>
    <DIV class=3Dh5><BR><BR>
    <DIV class=3Dgmail_quote>On Fri, Mar 6, 2009 at 12:30 AM, Liu =
Dave-R63238=20
    <SPAN dir=3Dltr>&lt;<A href=3D"mailto:DaveLiu@freescale.com"=20
    target=3D_blank>DaveLiu@freescale.com</A>&gt;</SPAN> wrote:<BR>
    <BLOCKQUOTE class=3Dgmail_quote=20
    style=3D"PADDING-LEFT: 1ex; MARGIN: 0pt 0pt 0pt 0.8ex; BORDER-LEFT: =
rgb(204,204,204) 1px solid">
      <DIV>
      <DIV dir=3Dltr align=3Dleft><SPAN><FONT face=3DArial =
color=3D#0000ff size=3D2>Did=20
      you enable the descriptor bit 3 to have a =
try?</FONT></SPAN></DIV><BR>
      <BLOCKQUOTE=20
      style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: =
rgb(0,0,255) 2px solid; MARGIN-RIGHT: 0px">
        <DIV lang=3Den-us dir=3Dltr align=3Dleft>
        <HR>
        <FONT face=3DTahoma size=3D2>
        <DIV><B>From:</B> Ben Menchaca [mailto:<A=20
        href=3D"mailto:ben.menchaca@gmail.com"=20
        target=3D_blank>ben.menchaca@gmail.com</A>] =
<BR></DIV><B>Sent:</B> Friday,=20
        March 06, 2009 2:10 PM
        <DIV>
        <DIV></DIV>
        <DIV><BR><B>To:</B> Liu Dave-R63238<BR><B>Cc:</B> <A=20
        href=3D"mailto:linuxppc-dev@ozlabs.org"=20
        target=3D_blank>linuxppc-dev@ozlabs.org</A><BR><B>Subject:</B> =
Re: 83xx:=20
        Marking or Allocating Pages as=20
        Cache-Inhibited<BR></DIV></DIV></FONT><BR></DIV>
        <DIV>
        <DIV></DIV>
        <DIV>
        <DIV></DIV>I can look at ACR morning...although I can say with a =
fair=20
        amount of certainty that I have not changed it from the POR=20
        value.<BR><BR>I will try enabling No Snoop for CSB in the =
descriptor=20
        (bit 3, yes?)...this seems a bit counterintuitive to =
me.<BR><BR>What is=20
        the hope regarding these two?&nbsp; Some combination I am not=20
        seeing?<BR><BR><BR>
        <DIV class=3Dgmail_quote>On Thu, Mar 5, 2009 at 11:40 PM, Liu =
Dave-R63238=20
        <SPAN dir=3Dltr>&lt;<A href=3D"mailto:DaveLiu@freescale.com"=20
        target=3D_blank>DaveLiu@freescale.com</A>&gt;</SPAN> wrote:<BR>
        <BLOCKQUOTE class=3Dgmail_quote=20
        style=3D"PADDING-LEFT: 1ex; MARGIN: 0pt 0pt 0pt 0.8ex; =
BORDER-LEFT: rgb(204,204,204) 1px solid">
          <DIV>
          <DIV dir=3Dltr align=3Dleft><SPAN><FONT face=3DArial =
color=3D#0000ff=20
          size=3D2>what is the value of ACR =
register?</FONT></SPAN></DIV><BR>
          <BLOCKQUOTE=20
          style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: =
rgb(0,0,255) 2px solid; MARGIN-RIGHT: 0px">
            <DIV lang=3Den-us dir=3Dltr align=3Dleft>
            <HR>
            <FONT face=3DTahoma size=3D2><B>From:</B> Ben Menchaca =
[mailto:<A=20
            href=3D"mailto:ben.menchaca@gmail.com"=20
            target=3D_blank>ben.menchaca@gmail.com</A>] <BR><B>Sent:</B> =
Friday,=20
            March 06, 2009 1:38 PM<BR><B>To:</B> Liu =
Dave-R63238<BR><B>Cc:</B>=20
            <A href=3D"mailto:linuxppc-dev@ozlabs.org"=20
            =
target=3D_blank>linuxppc-dev@ozlabs.org</A><BR><B>Subject:</B> Re:=20
            83xx: Marking or Allocating Pages as=20
            Cache-Inhibited<BR></FONT><BR></DIV>
            <DIV>
            <DIV></DIV>
            <DIV>
            <DIV></DIV><FONT style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Tahoma"><FONT=20
            style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Tahoma"><FONT=20
            style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Tahoma"><FONT=20
            style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Tahoma"><FONT=20
            style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Tahoma">1.&nbsp; BAT2 =
in linux=20
            is set to WIMG=3D0010, and covers all 64M<BR>2.&nbsp;=20
            PEX_DEVICE_CONTROL in PCI-E Config Space (0x54): =
0x1020<BR>3.&nbsp;=20
            PEX_xDMA_CTRL is set to <SPAN></SPAN>0x00000401 at the =
initiation of=20
            the DMA.<BR>4.&nbsp; OWAR0 is set to 0xFFFFF005, so NSNP is=20
            0.<BR>5.&nbsp; The DMA descriptor (randomly chosen when I =
hit a=20
            trigger...just ignore the size...) contains 0002AFF3 at =
offset 0, so=20
            nosnoops are =
cleared.</FONT></FONT></FONT></FONT></FONT><FONT=20
            style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Tahoma"><FONT=20
            style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Tahoma"><FONT=20
            style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Tahoma"><FONT=20
            style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Tahoma">&nbsp; =
<BR><BR>Core is=20
            400MHz, and CSB is =
133MHz.</FONT></FONT></FONT></FONT><BR><FONT=20
            color=3D#888888><BR>- Ben<BR></FONT><BR>
            <DIV class=3Dgmail_quote>On Thu, Mar 5, 2009 at 11:27 PM, =
Liu=20
            Dave-R63238 <SPAN dir=3Dltr>&lt;<A =
href=3D"mailto:DaveLiu@freescale.com"=20
            target=3D_blank>DaveLiu@freescale.com</A>&gt;</SPAN> =
wrote:<BR>
            <BLOCKQUOTE class=3Dgmail_quote=20
            style=3D"PADDING-LEFT: 1ex; MARGIN: 0pt 0pt 0pt 0.8ex; =
BORDER-LEFT: rgb(204,204,204) 1px solid">and=20
              what settings &nbsp;is DMA description bit 3?<BR>
              <DIV><BR>&gt; -----Original Message-----<BR>&gt; From:=20
              linuxppc-dev-bounces+daveliu=3D<A =
href=3D"http://freescale.com"=20
              target=3D_blank>freescale.com</A>@<A =
href=3D"http://ozlabs.org"=20
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
Friday,=20
              March 06, 2009 1:22 PM<BR>&gt; To: Ben Menchaca; <A=20
              href=3D"mailto:linuxppc-dev@ozlabs.org"=20
              target=3D_blank>linuxppc-dev@ozlabs.org</A><BR>&gt; =
Subject: RE:=20
              83xx: Marking or Allocating Pages as=20
              Cache-Inhibited<BR>&gt;<BR>&gt; Did you enable the snoop =
bit at=20
              PEX_WDMA_CTRL[SNOOP] and<BR>&gt;=20
              PEX_RDMA_CTRL[SNOOP]?<BR>&gt;<BR>&gt; What is the freq =
settings?=20
              CORE/CSB bus.<BR>&gt;<BR>&gt; Thanks, Dave<BR>&gt;<BR>&gt; =

              ________________________________<BR>&gt;<BR>&gt; &nbsp; =
&nbsp;=20
              &nbsp; From: linuxppc-dev-bounces+daveliu=3D<A=20
              href=3D"http://freescale.com" =
target=3D_blank>freescale.com</A>@<A=20
              href=3D"http://ozlabs.org" =
target=3D_blank>ozlabs.org</A><BR>&gt;=20
              [mailto:<A href=3D"mailto:linuxppc-dev-bounces%2Bdaveliu"=20
              target=3D_blank>linuxppc-dev-bounces+daveliu</A>=3D<A=20
              href=3D"http://freescale.com" =
target=3D_blank>freescale.com</A>@<A=20
              href=3D"http://ozlabs.org" =
target=3D_blank>ozlabs.org</A>]<BR>&gt;=20
              &nbsp;On Behalf Of Ben Menchaca<BR>&gt; &nbsp; &nbsp; =
&nbsp; Sent:=20
              Friday, March 06, 2009 12:33 PM<BR>&gt; &nbsp; &nbsp; =
&nbsp; To:=20
              <A href=3D"mailto:linuxppc-dev@ozlabs.org"=20
              target=3D_blank>linuxppc-dev@ozlabs.org</A><BR>&gt; &nbsp; =
&nbsp;=20
              &nbsp; Subject: 83xx: Marking or Allocating Pages as=20
              Cache-Inhibited<BR>&gt;<BR>&gt;<BR>&gt; &nbsp; &nbsp; =
&nbsp; I am=20
              working on a Freescale 8314e design, and the<BR>&gt; =
embedded=20
              device is configured as a PCI-e endpoint running a<BR>&gt; =

              2.6.27-5 kernel. &nbsp;For context, we have written a=20
              kernel<BR>&gt; module which, among other things, uses the=20
              RDMA/WDMA engine<BR>&gt; in the PCI-e IP block. &nbsp;On =
the host=20
              side, these DMAs are<BR>&gt; coherent. &nbsp;However, on =
the=20
              embedded side, things are quite a<BR>&gt; bit less rosy; =
we must=20
              manually flush/invalidate cache lines<BR>&gt; for =
WDMA/RDMAs to=20
              occur successfully. &nbsp;After speaking with<BR>&gt; =
(several)=20
              FAEs at Freescale, we believe there is a<BR>&gt; =
configuration=20
              issue that is the cause, but we have yet to<BR>&gt; have =
anyone=20
              successfully point to it.<BR>&gt;<BR>&gt; &nbsp; &nbsp; =
&nbsp;=20
              Disabling the data cache altogether resolves the =
issue<BR>&gt;=20
              entirely, but of course, also completely tanks=20
              performance.<BR>&gt; As a temporary workaround, I would =
like to=20
              simply mark the<BR>&gt; pages (obtained currently via=20
              dma_alloc_coherent) involved as<BR>&gt; cache-inhibited. =
&nbsp;I=20
              have attempted to do this via some<BR>&gt; snippets =
remaining in=20
              fec.c (va_to_pte, uncache_pte to set<BR>&gt; =
_PAGE_NO_CACHE,=20
              flush_tlb_page, then unmap_pte), but this is<BR>&gt; =
almost=20
              certainly braindead; va_to_pte is not a part of =
the<BR>&gt; 83xx=20
              source, as far as I can tell; 8xx only.<BR>&gt;<BR>&gt; =
&nbsp;=20
              &nbsp; &nbsp; A quick pointer in the correct direction for =

              marking<BR>&gt; pages as cache-inhibited on a 2.6.27-5 =
kernel=20
              would be<BR>&gt; appreciated, or if my approach to a =
workaround is=20
              flawed, a<BR>&gt; pointer to the correct way would be=20
              great.<BR>&gt;<BR>&gt; &nbsp; &nbsp; &nbsp; Ben=20
              Menchaca<BR>&gt;<BR>&gt;<BR></DIV></DIV>&gt;=20
              _______________________________________________<BR>&gt;=20
              Linuxppc-dev mailing list<BR>&gt; <A=20
              href=3D"mailto:Linuxppc-dev@ozlabs.org"=20
              target=3D_blank>Linuxppc-dev@ozlabs.org</A><BR>&gt; <A=20
              href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-dev"=20
              =
target=3D_blank>https://ozlabs.org/mailman/listinfo/linuxppc-dev</A><BR>&=
gt;<BR>&gt;<BR></BLOCKQUOTE></DIV><BR></DIV></DIV></BLOCKQUOTE></DIV></BL=
OCKQUOTE></DIV><BR></DIV></DIV></BLOCKQUOTE></DIV></BLOCKQUOTE></DIV><BR>=
</DIV></DIV></BLOCKQUOTE></DIV><BR></BLOCKQUOTE></BODY></HTML>

------_=_NextPart_001_01C9A05F.12CAD3AA--
