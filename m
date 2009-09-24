Return-Path: <B22826@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7ACDBB7043
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2009 18:23:06 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n8O8N2TR003725
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2009 01:23:02 -0700 (MST)
Received: from zmy16exm21.fsl.freescale.net (zmy16exm21.ap.freescale.net
	[10.211.3.25])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n8O8PAO4004866
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2009 03:25:10 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 6/6] P2020DS: Remove sdhci-dma-broken and
	sdhci-ahb2mag-irq-bypass properties
Date: Thu, 24 Sep 2009 16:22:59 +0800
Message-ID: <CF6163088BDE8747873ADAA4AF922BF287EDAD@zmy16exm21.fsl.freescale.net>
In-Reply-To: <20090923115954.GC6425@oksana.dev.rtsoft.ru>
References: <1253696892-15262-1-git-send-email-B22826@freescale.com>
	<1253696892-15262-2-git-send-email-B22826@freescale.com>
	<1253696892-15262-3-git-send-email-B22826@freescale.com>
	<1253696892-15262-4-git-send-email-B22826@freescale.com>
	<1253696892-15262-5-git-send-email-B22826@freescale.com>
	<1253696892-15262-6-git-send-email-B22826@freescale.com>
	<20090923115954.GC6425@oksana.dev.rtsoft.ru>
From: "Gao Guanhua-B22826" <B22826@freescale.com>
To: <avorontsov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, sdhci-devel@lists.ossman.eu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Anton Vorontsov [mailto:avorontsov@ru.mvista.com]=20
> Sent: Wednesday, September 23, 2009 8:00 PM
> To: Gao Guanhua-B22826
> Cc: sdhci-devel@lists.ossman.eu; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH 6/6] P2020DS: Remove sdhci-dma-broken and=20
> sdhci-ahb2mag-irq-bypass properties
>=20
> On Wed, Sep 23, 2009 at 05:08:12PM +0800, Gao Guanhua wrote:
> > The SDHC on P2020DS board use DMA mode by default.
> > This patch remove the properties used in PIO mode.
>=20
> You just added the properties in 3/6 and 4/6, and now you=20
> instantly remove them?

Add them to support the PIO mode, the board has a hardware bug, sdhc can
only work in PIO mode.
Then the bug has been fixed. So remove those properties.
Yes, maybe I shouldnot add the property in the dts, and only support PIO
in driver.

Thanks.

>=20
> > ---
> >  arch/powerpc/boot/dts/p2020ds.dts |    2 --
> >  1 files changed, 0 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/arch/powerpc/boot/dts/p2020ds.dts=20
> > b/arch/powerpc/boot/dts/p2020ds.dts
> > index 29989fb..3263397 100644
> > --- a/arch/powerpc/boot/dts/p2020ds.dts
> > +++ b/arch/powerpc/boot/dts/p2020ds.dts
> > @@ -459,8 +459,6 @@
> >  			reg =3D <0x2e000 0x1000>;
> >  			interrupts =3D <72 0x2>;
> >  			interrupt-parent =3D <&mpic>;
> > -			fsl,sdhci-dma-broken;
> > -			fsl,sdhci-ahb2mag-irq-bypass;
> >  			fsl,sdhci-adjust-timeout;
> >  			clock-frequency =3D <0>;
> >  		};
> > --
> > 1.6.4
>=20
> --
> Anton Vorontsov
> email: cbouatmailru@gmail.com
> irc://irc.freenode.net/bd2
>=20
>=20
