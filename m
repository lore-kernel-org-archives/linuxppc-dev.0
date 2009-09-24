Return-Path: <B22826@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 11A14B7B8C
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2009 18:28:23 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n8O8SKwx005277
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2009 01:28:21 -0700 (MST)
Received: from zmy16exm21.fsl.freescale.net (zmy16exm21.ap.freescale.net
	[10.211.3.25])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n8O8UCIP008275
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2009 03:30:13 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 3/6] P2020DS: Fixup sdhc to use PIO mode
Date: Thu, 24 Sep 2009 16:28:18 +0800
Message-ID: <CF6163088BDE8747873ADAA4AF922BF287EDB0@zmy16exm21.fsl.freescale.net>
In-Reply-To: <20090923115518.GB6425@oksana.dev.rtsoft.ru>
References: <1253696892-15262-1-git-send-email-B22826@freescale.com>
	<1253696892-15262-2-git-send-email-B22826@freescale.com>
	<1253696892-15262-3-git-send-email-B22826@freescale.com>
	<20090923115518.GB6425@oksana.dev.rtsoft.ru>
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

Thanks, I will add them.=20

> -----Original Message-----
> From: Anton Vorontsov [mailto:avorontsov@ru.mvista.com]=20
> Sent: Wednesday, September 23, 2009 7:55 PM
> To: Gao Guanhua-B22826
> Cc: sdhci-devel@lists.ossman.eu; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH 3/6] P2020DS: Fixup sdhc to use PIO mode
>=20
> On Wed, Sep 23, 2009 at 05:08:09PM +0800, Gao Guanhua wrote:
> > The SDHC can not work on DMA mode because of the hardware=20
> bug, so we=20
> > set a broken dma flag and use PIO mode. This patch applies=20
> to Rev1.0.
>=20
> Signed-off-by line is missing (in all patches).
>=20
> > ---
> >  arch/powerpc/boot/dts/p2020ds.dts |    1 +
> >  drivers/mmc/host/sdhci-of.c       |    3 +++
> >  2 files changed, 4 insertions(+), 0 deletions(-)
> >=20
> > diff --git a/arch/powerpc/boot/dts/p2020ds.dts=20
> > b/arch/powerpc/boot/dts/p2020ds.dts
> > index be449ba..574ad4f 100644
> > --- a/arch/powerpc/boot/dts/p2020ds.dts
> > +++ b/arch/powerpc/boot/dts/p2020ds.dts
> > @@ -459,6 +459,7 @@
> >  			reg =3D <0x2e000 0x1000>;
> >  			interrupts =3D <72 0x2>;
> >  			interrupt-parent =3D <&mpic>;
> > +			fsl,sdhci-dma-broken;
>=20
> You might want to update
> Documentation/powerpc/dts-bindings/fsl/esdhc.txt
>=20
> >  			clock-frequency =3D <0>;
> >  		};
> > =20
> > diff --git a/drivers/mmc/host/sdhci-of.c=20
> b/drivers/mmc/host/sdhci-of.c=20
> > index 01ab916..5879483 100644
> > --- a/drivers/mmc/host/sdhci-of.c
> > +++ b/drivers/mmc/host/sdhci-of.c
> > @@ -270,6 +270,9 @@ static int __devinit=20
> sdhci_of_probe(struct of_device *ofdev,
> >  	if (sdhci_of_wp_inverted(np))
> >  		host->quirks |=3D SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
> > =20
> > +	if (of_get_property(np, "fsl,sdhci-dma-broken", NULL))
> > +		host->quirks |=3D SDHCI_QUIRK_BROKEN_DMA;
> > +
> >  	clk =3D of_get_property(np, "clock-frequency", &size);
> >  	if (clk && size =3D=3D sizeof(*clk) && *clk)
> >  		of_host->clock =3D *clk;
> > --
> > 1.6.4
>=20
> Thanks,
>=20
> --
> Anton Vorontsov
> email: cbouatmailru@gmail.com
> irc://irc.freenode.net/bd2
>=20
>=20
