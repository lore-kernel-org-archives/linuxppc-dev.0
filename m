Return-Path: <B42677@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7F2622C0077
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 12:14:51 +1000 (EST)
From: Zhang Haijun-B42677 <B42677@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH] DTS: Add compatible list for eSDHC
Date: Wed, 3 Jul 2013 02:14:42 +0000
Message-ID: <99E897753B6F7048BD8CCDB4661D02E1361BBF@039-SN2MPN1-023.039d.mgd.msft.net>
References: <99E897753B6F7048BD8CCDB4661D02E13609E1@039-SN2MPN1-023.039d.mgd.msft.net>
 (from B42677@freescale.com on Tue Jul  2 03:00:43 2013)
 <1372791279.8183.115@snotra>
In-Reply-To: <1372791279.8183.115@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Fleming Andy-AFLEMING <afleming@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>




Regards
Haijun.


> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Wednesday, July 03, 2013 2:55 AM
> To: Zhang Haijun-B42677
> Cc: Wood Scott-B07421; galak@kernel.crashing.org; linuxppc-
> dev@lists.ozlabs.org; Fleming Andy-AFLEMING
> Subject: Re: [PATCH] DTS: Add compatible list for eSDHC
>=20
> On 07/02/2013 03:00:43 AM, Zhang Haijun-B42677 wrote:
> >
> >
> >
> > Regards
> > Haijun.
> >
> > > -----Original Message-----
> > > From: Wood Scott-B07421
> > > Sent: Tuesday, July 02, 2013 8:05 AM
> > > To: Zhang Haijun-B42677
> > > Cc: galak@kernel.crashing.org; linuxppc-dev@lists.ozlabs.org; Zhang
> > > Haijun-B42677; Fleming Andy-AFLEMING
> > > Subject: Re: [PATCH] DTS: Add compatible list for eSDHC
> > >
> > > On 07/01/2013 12:21:50 AM, Haijun Zhang wrote:
> > > > Add compatible of esdhc for below board:
> > > > p2041   p3041   p4080   p5020   p5040
> > > >
> > > > Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
> > > > CC: Scott Wood <scottwood@freescale.com>
> > > > CC: Fleming Andrew-AFLEMING <AFLEMING@freescale.com>
> > > > ---
> > > >  arch/powerpc/boot/dts/fsl/p2041si-post.dtsi | 1 +
> > > > arch/powerpc/boot/dts/fsl/p3041si-post.dtsi | 1 +
> > > > arch/powerpc/boot/dts/fsl/p4080si-post.dtsi | 1 +
> > > > arch/powerpc/boot/dts/fsl/p5020si-post.dtsi | 1 +
> > > > arch/powerpc/boot/dts/fsl/p5040si-post.dtsi | 1 +
> > > >  5 files changed, 5 insertions(+)
> > >
> > > Is there something specific that depends on this, or are you just
> > trying
> > > to conform to other examples?
> > >
> > > I don't think we need the SoC name here, given that eSDHC has a
> > version
> > > register that you can read (and an SVR in the unlikely case that
> > that
> > > isn't adequate).  If you did end up relying on this device tree
> > change,
> > > you'd be broken if an older device trees is used.
> > >
> > [Haijun Wrote:] Yes, in mmc driver (sdhci-pltfm.c)some quirks depends
> > on Soc name and its Soc version (sdhci-of-esdhc.c), even if they had
> > the same eSDHC version.
>=20
> Then please use SVR for applying errata workarounds to these chips,
> rather than rely on the device tree being updated.  The SVR approach also
> lets you deal with cases where the erratum is present in one rev of an
> SoC but not another.
[Haijun Wrote:] Ok, I'll update this in mmc driver.
>=20
> Is SDHCI_QUIRK_BROKEN_TIMEOUT_VAL present on these chips?  If so, which
> chips (of the same eSDHC version) is it not present on?
>=20
[Haijun Wrote:] I also confused about this quirk, I'm not sure if this quir=
k is indeed need by them. The calculation of the timeout value used to have=
 some defect, so some board may encounter timeout err when using sd card. I=
 had send patch to change it, but I'm not sure which of them is due to the =
calculation err. This quirk just let the card use the max value to wait for=
 data or command transfer complete. No impact to performance and function. =
So I leave them no changed.
> -Scott
