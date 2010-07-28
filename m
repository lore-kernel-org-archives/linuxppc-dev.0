Return-Path: <R61911@freescale.com>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
	[213.199.154.141]) by ozlabs.org (Postfix) with ESMTP id 9F82DB6EDF
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jul 2010 19:58:48 +1000 (EST)
Received: from mail3-db3 (localhost.localdomain [127.0.0.1])	by
	mail3-db3-R.bigfish.com (Postfix) with ESMTP id E10A35F8470	for
	<linuxppc-dev@ozlabs.org>; Wed, 28 Jul 2010 09:43:30 +0000 (UTC)
Received: from DB3EHSMHS003.bigfish.com (unknown [10.3.81.248])	by
	mail3-db3.bigfish.com (Postfix) with ESMTP id 3F30A1878069	for
	<linuxppc-dev@ozlabs.org>; Wed, 28 Jul 2010 09:43:19 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o6S9h9RC005795	for
	<linuxppc-dev@ozlabs.org>; Wed, 28 Jul 2010 02:43:09 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o6S9uU2g025582	for <linuxppc-dev@ozlabs.org>;
	Wed, 28 Jul 2010 04:56:31 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH 3/3] mmc: Add ESDHC weird register workaround
Date: Wed, 28 Jul 2010 17:43:00 +0800
Message-ID: <83024545B35D6445A690EFD603E7869A0512E0@zch01exm23.fsl.freescale.net>
In-Reply-To: <20100728080312.GA16994@oksana.dev.rtsoft.ru>
References: <1280296461-17077-1-git-send-email-tie-fei.zang@freescale.com>
	<20100728080312.GA16994@oksana.dev.rtsoft.ru>
From: Zang Roy-R61911 <r61911@freescale.com>
To: "Anton Vorontsov" <cbouatmailru@gmail.com>
Cc: linuxppc-dev@ozlabs.org, linux-mmc@vger.kernel.org
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
> Sent: Wednesday, July 28, 2010 16:03 PM
> To: Zang Roy-R61911
> Cc: linux-mmc-approval@vger.kernel.org; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH 3/3] mmc: Add ESDHC weird register workaround
>=20
> On Wed, Jul 28, 2010 at 01:54:21PM +0800, Roy Zang wrote:
> > P4080 ESDHC controller induces weird register setting.
> > This patch adds the workaround to correct the weird=20
> register setting.
> >=20
> > Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> > ---
> >  drivers/mmc/host/sdhci-of-core.c |    5 +++++
> >  drivers/mmc/host/sdhci.c         |   13 +++++++++++++
> >  drivers/mmc/host/sdhci.h         |    2 ++
> >  3 files changed, 20 insertions(+), 0 deletions(-)
> >=20
> > diff --git a/drivers/mmc/host/sdhci-of-core.c=20
> b/drivers/mmc/host/sdhci-of-core.c
> > index 0c30242..1b6945a 100644
> > --- a/drivers/mmc/host/sdhci-of-core.c
> > +++ b/drivers/mmc/host/sdhci-of-core.c
> > @@ -164,6 +164,11 @@ static int __devinit=20
> sdhci_of_probe(struct of_device *ofdev,
> >  	if (sdhci_of_wp_inverted(np))
> >  		host->quirks |=3D SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
> > =20
> > +	if (of_device_is_compatible(np, "fsl,p4080-esdhc")) {
> > +		host->quirks |=3D SDHCI_QUIRK_QORIQ_REG_WEIRD;
> > +		host->quirks &=3D ~SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
>=20
> You do not mention this change in the patch description, why?
This is not needed any more. Will be removed.
>=20
> > +	}
> > +
> >  	clk =3D of_get_property(np, "clock-frequency", &size);
> >  	if (clk && size =3D=3D sizeof(*clk) && *clk)
> >  		of_host->clock =3D *clk;
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 1424d08..b5b3627 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -788,6 +788,15 @@ static void sdhci_prepare_data(struct=20
> sdhci_host *host, struct mmc_data *data)
> >  		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> >  	}
> > =20
> > +	/* The default value of DMAS bits of Protocol Control=20
> Register is not
> > +	 * correct. clear these two bits to use simple DMA */
> > +#define  ESDHCI_CTRL_DMAS_MASK		0xFFFFFCFF
> > +	if (host->quirks & SDHCI_QUIRK_QORIQ_REG_WEIRD) {
> > +		ctrl =3D sdhci_readl(host, SDHCI_HOST_CONTROL);
> > +		ctrl =3D ctrl & ESDHCI_CTRL_DMAS_MASK;
> > +		sdhci_writel(host, ctrl, SDHCI_HOST_CONTROL);
> > +	}
>=20
> You should implement register quirks via SDHCI IO accessors.
What does you mean "SDHCI IO accessors?
It makes more sense to define something like:
SDHCI_QUIRK_QORIQ_PROCTL_WEIRD.
Any comment?

>=20
> See esdhc_writew() for example.
>=20
> >  	if (!(host->flags & SDHCI_REQ_USE_DMA)) {
> >  		int flags;
> > =20
> > @@ -1699,6 +1708,10 @@ int sdhci_add_host(struct sdhci_host *host)
> > =20
> >  	caps =3D sdhci_readl(host, SDHCI_CAPABILITIES);
> > =20
> > +	 /* Workaround for P4080 host controller capabilities */
> > +	if (host->quirks & SDHCI_QUIRK_QORIQ_REG_WEIRD)
> > +		caps &=3D ~(SDHCI_CAN_VDD_180 | SDHCI_CAN_VDD_330);
>=20
> Ditto. Make a quirk for cap register. Or implement
> SDHCI_QUIRK_NO_VDD_180 and SDHCI_QUIRK_NO_VDD_300 quirks
> instead.
Second proposal more makes sense to me.
Thanks.
Roy
