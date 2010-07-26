Return-Path: <B21284@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) by ozlabs.org (Postfix) with ESMTP id 8E893B70AA
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 17:40:31 +1000 (EST)
Received: from mail147-tx2 (localhost.localdomain [127.0.0.1])	by
	mail147-tx2-R.bigfish.com (Postfix) with ESMTP id 965771A181E3	for
	<linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 07:25:25 +0000 (UTC)
Received: from TX2EHSMHS010.bigfish.com (unknown [10.9.14.239])	by
	mail147-tx2.bigfish.com (Postfix) with ESMTP id 0C53B1598052	for
	<linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 07:25:25 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o6Q7PLiN001218	for
	<linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 00:25:21 -0700 (MST)
Received: from zmy16exm20.fsl.freescale.net (zmy16exm20.ap.freescale.net
	[10.211.3.23])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o6Q7ceTQ014041	for <linuxppc-dev@ozlabs.org>;
	Mon, 26 Jul 2010 02:38:41 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH 3/6] of/spi: add support to parse the SPI flash's
	partitions
Date: Mon, 26 Jul 2010 15:25:18 +0800
Message-ID: <73839B4A0818E747864426270AC332C305400637@zmy16exm20.fsl.freescale.net>
In-Reply-To: <20100726002813.GB25419@angua.secretlab.ca>
References: <1279591705-7574-1-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-2-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-3-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-4-git-send-email-Mingkai.hu@freescale.com>
	<20100726002813.GB25419@angua.secretlab.ca>
From: Hu Mingkai-B21284 <B21284@freescale.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, Zang Roy-R61911 <R61911@freescale.com>
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
> From: Grant Likely [mailto:glikely@secretlab.ca] On Behalf Of=20
> Grant Likely
> Sent: Monday, July 26, 2010 8:28 AM
> To: Hu Mingkai-B21284
> Cc: linuxppc-dev@ozlabs.org; galak@kernel.crashing.org; Zang=20
> Roy-R61911
> Subject: Re: [PATCH 3/6] of/spi: add support to parse the SPI=20
> flash's partitions
>=20
> On Tue, Jul 20, 2010 at 10:08:22AM +0800, Mingkai Hu wrote:
> > Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
> > ---
> >  drivers/of/of_spi.c       |   11 +++++++++++
> >  drivers/spi/spi_mpc8xxx.c |    1 +
> >  2 files changed, 12 insertions(+), 0 deletions(-)
> >=20
> > diff --git a/drivers/of/of_spi.c b/drivers/of/of_spi.c index=20
> > 5fed7e3..284ca0e 100644
> > --- a/drivers/of/of_spi.c
> > +++ b/drivers/of/of_spi.c
> > @@ -10,6 +10,8 @@
> >  #include <linux/device.h>
> >  #include <linux/spi/spi.h>
> >  #include <linux/of_spi.h>
> > +#include <linux/spi/flash.h>
> > +#include <linux/mtd/partitions.h>
> > =20
> >  /**
> >   * of_register_spi_devices - Register child devices onto=20
> the SPI bus=20
> > @@ -26,6 +28,7 @@ void of_register_spi_devices(struct=20
> spi_master *master, struct device_node *np)
> >  	const __be32 *prop;
> >  	int rc;
> >  	int len;
> > +	struct flash_platform_data *pdata;
> > =20
> >  	for_each_child_of_node(np, nc) {
> >  		/* Alloc an spi_device */
> > @@ -81,6 +84,14 @@ void of_register_spi_devices(struct=20
> spi_master *master, struct device_node *np)
> >  		of_node_get(nc);
> >  		spi->dev.of_node =3D nc;
> > =20
> > +		/* Parse the mtd partitions */
> > +		pdata =3D kzalloc(sizeof(*pdata), GFP_KERNEL);
> > +		if (!pdata)
> > +			return;
> > +		pdata->nr_parts =3D of_mtd_parse_partitions(&master->dev,
> > +				nc, &pdata->parts);
> > +		spi->dev.platform_data =3D pdata;
> > +
>=20
> Nack.  Not all spi devices are mtd devices.  In fact, most are not.
>=20
> The spi driver itself should call the of_mtd_parse_partitions=20
> code to get the partition map.  Do not use pdata in this case.
>=20

Yes, we can call of_mtd_parse_partitions to get the partiton map, but
how can we
pass this map to spi device to register to MTD layer?

The spi device is created and registered when call
of_register_spi_device in the
spi controller probe function, then the spi device will traverse the spi
device driver
list to find the proper driver, if matched, then call the spi device
driver probe code
where the mtd partition info is registered to the mtd layer.

so where is the proper place to put the of_mtd_parse_partitions code?


> >  		/* Register the new device */
> >  		request_module(spi->modalias);
> >  		rc =3D spi_add_device(spi);
> > diff --git a/drivers/spi/spi_mpc8xxx.c b/drivers/spi/spi_mpc8xxx.c=20
> > index efed70e..0fadaeb 100644
> > --- a/drivers/spi/spi_mpc8xxx.c
> > +++ b/drivers/spi/spi_mpc8xxx.c
> > @@ -137,6 +137,7 @@ int mpc8xxx_spi_transfer(struct spi_device *spi,
> > =20
> >  void mpc8xxx_spi_cleanup(struct spi_device *spi)  {
> > +	kfree(spi->dev.platform_data);
>=20
> Irrelevant given the above comment, but how does this even=20
> work?  What if a driver was detached and reattached to an=20
> spi_device?  The platform_data would be freed.  Not to=20
> mention that the pointer isn't cleared, so the driver would=20
> have no idea that it has a freed pointer.
>=20

It works. If the driver detached, the spi device platform_data will be
released,
when reattached, the of_register_spi_devices will be called again, the
platform_data
will be allocated.

Thanks,
Mingkai
