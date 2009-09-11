Return-Path: <pbathija@amcc.com>
Received: from sdcmail01.amcc.com (sdcmail01.amcc.com [198.137.200.72])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 36086B7B5C
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Sep 2009 15:35:26 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA32A1.A7A1AE69"
Subject: RE: AW: PowerPC PCI DMA issues (prefetch/coherency?)
Date: Thu, 10 Sep 2009 22:35:21 -0700
Message-ID: <9D1E2BDCB5C57B46B56E6D80843439EB0580C926@SDCEXCHANGE01.ad.amcc.com>
References: <1251926572.10090.17.camel@Adam> <200909110712.11858.sr@denx.de>
	<1252646270.8566.64.camel@pasglop> <200909110725.36208.sr@denx.de>
From: "Pravin Bathija" <pbathija@amcc.com>
To: "Stefan Roese" <sr@denx.de>,
	<linuxppc-dev@lists.ozlabs.org>
Cc: Andrea Zypchen <azypchen@intldata.ca>, lebon@lebon.org.ua,
	Prodyut Hazarika <phazarika@amcc.com>, tburns@datacast.com,
	azilkie@datacast.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA32A1.A7A1AE69
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> Stefan Roese wrote:
> Correct. IIRC, some PATA driver as Pravin already mentioned.
=20
> Cheers,
> Stefan

Thanks Stefan. The whole intention of the patch/hack (or whatever one =
might call it :) ) was to avoid rogue drivers from setting =
pci_cache_line_size to non-zero value even though the underlying =
hardware doesn't support MRM calls. Nonetheless this approach works only =
if the drivers use the kernel API for PCI config space access provided =
by the powerpc platform driver.

Regards,
Pravin


On Friday 11 September 2009 07:17:50 Benjamin Herrenschmidt wrote:
> On Fri, 2009-09-11 at 07:12 +0200, Stefan Roese wrote:
> > It's already there. See commit:
> >
> > 5ce4b59653b2c2053cd9a011918ac1e4747f24cc
> >
> > powerpc/4xx: Workaround for PPC440EPx/GRx PCI_28 Errata
>=20
> Ok, that's another way to do it. Will catch nasty drivers who
> try to write directly rather than clear pci_cache_line_size I =
suppose...




------_=_NextPart_001_01CA32A1.A7A1AE69
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7653.38">
<TITLE>RE: AW: PowerPC PCI DMA issues (prefetch/coherency?)</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>&gt; Stefan Roese wrote:<BR>
&gt; Correct. IIRC, some PATA driver as Pravin already mentioned.<BR>
<BR>
&gt; Cheers,<BR>
&gt; Stefan<BR>
<BR>
Thanks Stefan. The whole intention of the patch/hack (or whatever one =
might call it :) ) was to avoid rogue drivers from setting =
pci_cache_line_size to non-zero value even though the underlying =
hardware doesn't support MRM calls. Nonetheless this approach works only =
if the drivers use the kernel API for PCI config space access provided =
by the powerpc platform driver.<BR>
<BR>
Regards,<BR>
Pravin<BR>
<BR>
<BR>
On Friday 11 September 2009 07:17:50 Benjamin Herrenschmidt wrote:<BR>
&gt; On Fri, 2009-09-11 at 07:12 +0200, Stefan Roese wrote:<BR>
&gt; &gt; It's already there. See commit:<BR>
&gt; &gt;<BR>
&gt; &gt; 5ce4b59653b2c2053cd9a011918ac1e4747f24cc<BR>
&gt; &gt;<BR>
&gt; &gt; powerpc/4xx: Workaround for PPC440EPx/GRx PCI_28 Errata<BR>
&gt;<BR>
&gt; Ok, that's another way to do it. Will catch nasty drivers who<BR>
&gt; try to write directly rather than clear pci_cache_line_size I =
suppose...<BR>
<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CA32A1.A7A1AE69--
