Return-Path: <R61911@freescale.com>
Received: from VA3EHSOBE009.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id 631E8B70E7
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Aug 2010 20:05:06 +1000 (EST)
Received: from mail29-va3 (localhost.localdomain [127.0.0.1])	by
	mail29-va3-R.bigfish.com (Postfix) with ESMTP id 9DE3894019A	for
	<linuxppc-dev@ozlabs.org>; Tue, 10 Aug 2010 10:05:03 +0000 (UTC)
Received: from VA3EHSMHS009.bigfish.com (unknown [10.7.14.247])	by
	mail29-va3.bigfish.com (Postfix) with ESMTP id 0AD69C98050	for
	<linuxppc-dev@ozlabs.org>; Tue, 10 Aug 2010 10:05:03 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o7AA4xsH009753	for <linuxppc-dev@ozlabs.org>;
	Tue, 10 Aug 2010 03:04:59 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP
	id o7AAGSeD008683	for <linuxppc-dev@ozlabs.org>;
	Tue, 10 Aug 2010 05:16:28 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: RE: [PATCH 1/3 v2] sdhci: Add auto CMD12 support for eSDHC driver
Date: Tue, 10 Aug 2010 18:04:54 +0800
Message-ID: <3850A844E6A3854C827AC5C0BEC7B60A0562AF@zch01exm23.fsl.freescale.net>
In-Reply-To: <20100809174333.GC7665@oksana.dev.rtsoft.ru>
From: Zang Roy-R61911 <r61911@freescale.com>
To: "Anton Vorontsov" <cbouatmailru@gmail.com>,
	"Grant Likely" <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-mmc@vger.kernel.org
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
> From: Anton Vorontsov [mailto:cbouatmailru@gmail.com]=20
> Sent: Tuesday, August 10, 2010 1:44 AM
> To: Grant Likely
> Cc: Zang Roy-R61911; linuxppc-dev@ozlabs.org;=20
> akpm@linux-foundation.org; linux-mmc@vger.kernel.org
> Subject: Re: [PATCH 1/3 v2] sdhci: Add auto CMD12 support for=20
> eSDHC driver
>=20
> On Wed, Aug 04, 2010 at 07:02:56PM -0600, Grant Likely wrote:
> > On Mon, Aug 2, 2010 at 9:11 PM, Roy Zang=20
> <tie-fei.zang@freescale.com> wrote:
> > > From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > >
> > > Add auto CMD12 command support for eSDHC driver.
> > > This is needed by P4080 and P1022 for block read/write.
> > > Manual asynchronous CMD12 abort operation causes protocol=20
> violations on
> > > these silicons.
> > >
> > > Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > > Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> > > ---
> > > =A0drivers/mmc/host/sdhci-of-core.c | =A0 =A04 ++++
> > > =A0drivers/mmc/host/sdhci.c =A0 =A0 =A0 =A0 | =A0 14 =
++++++++++++--
> > > =A0drivers/mmc/host/sdhci.h =A0 =A0 =A0 =A0 | =A0 =A02 ++
> > > =A03 files changed, 18 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > > index c6d1bd8..a92566e 100644
> > > --- a/drivers/mmc/host/sdhci.c
> > > +++ b/drivers/mmc/host/sdhci.c
> > > @@ -817,8 +817,12 @@ static void=20
> sdhci_set_transfer_mode(struct sdhci_host *host,
> > > =A0 =A0 =A0 =A0WARN_ON(!host->data);
> > >
> > > =A0 =A0 =A0 =A0mode =3D SDHCI_TRNS_BLK_CNT_EN;
> > > - =A0 =A0 =A0 if (data->blocks > 1)
> > > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode |=3D SDHCI_TRNS_MULTI;
> > > + =A0 =A0 =A0 if (data->blocks > 1) {
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->quirks &=20
> SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode |=3D =
SDHCI_TRNS_MULTI |=20
> SDHCI_TRNS_ACMD12;
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode |=3D =
SDHCI_TRNS_MULTI;
> >=20
> > nit:
> > +               mode |=3D SDHCI_TRNS_MULTI;
> > +               if (host->quirks &=20
> SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
> > +                       mode |=3D SDHCI_TRNS_ACMD12;
> >=20
> > Clearer, no?
>=20
> Much clearer. I would prefer the nit incorporated.
Agree.

>=20
> Another nit:
>=20
> > @@ -154,6 +154,10 @@ static int __devinit=20
> sdhci_of_probe(struct of_device *ofdev,
> >                 host->ops =3D &sdhci_of_data->ops;
> >         }
> >=20
> > +       if (of_get_property(np, "sdhci,auto-cmd12", NULL))
> > +               host->quirks |=3D =
SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
> > +
> > +     =20
>=20
> ^^ No need for the two empty lines.
Agree.
>=20
> >        if (of_get_property(np, "sdhci,1-bit-only", NULL))
>=20
> Though, technically the patch looks OK, feel free to add my
>=20
>   Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>
I send a new patch to fix the nip. you are Cced.
Thanks.
Roy
