Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0189.outbound.messaging.microsoft.com [213.199.154.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A13E12C02FB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 04:54:53 +1000 (EST)
Date: Tue, 2 Jul 2013 13:54:39 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] DTS: Add compatible list for eSDHC
To: Zhang Haijun-B42677 <B42677@freescale.com>
In-Reply-To: <99E897753B6F7048BD8CCDB4661D02E13609E1@039-SN2MPN1-023.039d.mgd.msft.net>
 (from B42677@freescale.com on Tue Jul  2 03:00:43 2013)
Message-ID: <1372791279.8183.115@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/02/2013 03:00:43 AM, Zhang Haijun-B42677 wrote:
>=20
>=20
>=20
> Regards
> Haijun.
>=20
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Tuesday, July 02, 2013 8:05 AM
> > To: Zhang Haijun-B42677
> > Cc: galak@kernel.crashing.org; linuxppc-dev@lists.ozlabs.org; Zhang
> > Haijun-B42677; Fleming Andy-AFLEMING
> > Subject: Re: [PATCH] DTS: Add compatible list for eSDHC
> >
> > On 07/01/2013 12:21:50 AM, Haijun Zhang wrote:
> > > Add compatible of esdhc for below board:
> > > p2041   p3041   p4080   p5020   p5040
> > >
> > > Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
> > > CC: Scott Wood <scottwood@freescale.com>
> > > CC: Fleming Andrew-AFLEMING <AFLEMING@freescale.com>
> > > ---
> > >  arch/powerpc/boot/dts/fsl/p2041si-post.dtsi | 1 +
> > > arch/powerpc/boot/dts/fsl/p3041si-post.dtsi | 1 +
> > > arch/powerpc/boot/dts/fsl/p4080si-post.dtsi | 1 +
> > > arch/powerpc/boot/dts/fsl/p5020si-post.dtsi | 1 +
> > > arch/powerpc/boot/dts/fsl/p5040si-post.dtsi | 1 +
> > >  5 files changed, 5 insertions(+)
> >
> > Is there something specific that depends on this, or are you just =20
> trying
> > to conform to other examples?
> >
> > I don't think we need the SoC name here, given that eSDHC has a =20
> version
> > register that you can read (and an SVR in the unlikely case that =20
> that
> > isn't adequate).  If you did end up relying on this device tree =20
> change,
> > you'd be broken if an older device trees is used.
> >
> [Haijun Wrote:] Yes, in mmc driver (sdhci-pltfm.c)some quirks depends =20
> on Soc name and its Soc version (sdhci-of-esdhc.c), even if they had =20
> the same eSDHC version.

Then please use SVR for applying errata workarounds to these chips, =20
rather than rely on the device tree being updated.  The SVR approach =20
also lets you deal with cases where the erratum is present in one rev =20
of an SoC but not another.

Is SDHCI_QUIRK_BROKEN_TIMEOUT_VAL present on these chips?  If so, which =20
chips (of the same eSDHC version) is it not present on?

-Scott=
