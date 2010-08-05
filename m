Return-Path: <R61911@freescale.com>
Received: from TX2EHSOBE001.bigfish.com (tx2ehsobe001.messaging.microsoft.com
	[65.55.88.11]) by ozlabs.org (Postfix) with ESMTP id 8435EB6EDD
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 12:15:30 +1000 (EST)
Received: from mail4-tx2 (localhost.localdomain [127.0.0.1])	by
	mail4-tx2-R.bigfish.com (Postfix) with ESMTP id 023F1DB8515	for
	<linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 02:15:27 +0000 (UTC)
Received: from TX2EHSMHS047.bigfish.com (unknown [10.9.14.252])	by
	mail4-tx2.bigfish.com (Postfix) with ESMTP id 14469490088	for
	<linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 02:14:40 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o752EcWT021983	for <linuxppc-dev@ozlabs.org>;
	Wed, 4 Aug 2010 19:14:38 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP
	id o752EhkU024120	for <linuxppc-dev@ozlabs.org>;
	Wed, 4 Aug 2010 21:14:44 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: RE: [PATCH 1/3 v2] sdhci: Add auto CMD12 support for eSDHC driver
Date: Thu, 5 Aug 2010 10:14:38 +0800
Message-ID: <3850A844E6A3854C827AC5C0BEC7B60AEA19@zch01exm23.fsl.freescale.net>
In-Reply-To: <AANLkTinJKO3-iXOXuL7CMWCj5qMMHyMrtnadwPpqTeBu@mail.gmail.com>
From: Zang Roy-R61911 <r61911@freescale.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
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
> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On=20
> Behalf Of Grant Likely
> Sent: Thursday, August 05, 2010 9:03 AM
> To: Zang Roy-R61911
> Cc: linux-mmc@vger.kernel.org; linuxppc-dev@ozlabs.org;=20
> akpm@linux-foundation.org
> Subject: Re: [PATCH 1/3 v2] sdhci: Add auto CMD12 support for=20
> eSDHC driver
>=20
> On Mon, Aug 2, 2010 at 9:11 PM, Roy Zang=20
> <tie-fei.zang@freescale.com> wrote:
> > From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> >
> > Add auto CMD12 command support for eSDHC driver.
> > This is needed by P4080 and P1022 for block read/write.
> > Manual asynchronous CMD12 abort operation causes protocol=20
> violations on
> > these silicons.
> >
> > Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> > ---
> > =A0drivers/mmc/host/sdhci-of-core.c | =A0 =A04 ++++
> > =A0drivers/mmc/host/sdhci.c =A0 =A0 =A0 =A0 | =A0 14 ++++++++++++--
> > =A0drivers/mmc/host/sdhci.h =A0 =A0 =A0 =A0 | =A0 =A02 ++
> > =A03 files changed, 18 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index c6d1bd8..a92566e 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -817,8 +817,12 @@ static void=20
> sdhci_set_transfer_mode(struct sdhci_host *host,
> > =A0 =A0 =A0 =A0WARN_ON(!host->data);
> >
> > =A0 =A0 =A0 =A0mode =3D SDHCI_TRNS_BLK_CNT_EN;
> > - =A0 =A0 =A0 if (data->blocks > 1)
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode |=3D SDHCI_TRNS_MULTI;
> > + =A0 =A0 =A0 if (data->blocks > 1) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->quirks &=20
> SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode |=3D =
SDHCI_TRNS_MULTI |=20
> SDHCI_TRNS_ACMD12;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode |=3D =
SDHCI_TRNS_MULTI;
>=20
> nit:
> +               mode |=3D SDHCI_TRNS_MULTI;
> +               if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
> +                       mode |=3D SDHCI_TRNS_ACMD12;
>=20
> Clearer, no?
why?
Roy
