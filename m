Return-Path: <B21284@freescale.com>
Received: from VA3EHSOBE006.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.31]) by ozlabs.org (Postfix) with ESMTP id ED82AB6EF7
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 18:21:07 +1000 (EST)
Received: from mail194-va3 (localhost.localdomain [127.0.0.1])	by
	mail194-va3-R.bigfish.com (Postfix) with ESMTP id 667E0F1822F	for
	<linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 08:21:03 +0000 (UTC)
Received: from VA3EHSMHS010.bigfish.com (unknown [10.7.14.244])	by
	mail194-va3.bigfish.com (Postfix) with ESMTP id 63C3AB70059	for
	<linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 08:21:02 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o6Q8L0SJ009487	for
	<linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 01:21:00 -0700 (MST)
Received: from zmy16exm20.fsl.freescale.net (zmy16exm20.ap.freescale.net
	[10.211.3.23])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o6Q8YJlD020986	for <linuxppc-dev@ozlabs.org>;
	Mon, 26 Jul 2010 03:34:20 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: RE: [PATCH 3/6] of/spi: add support to parse the SPI flash's
	partitions
Date: Mon, 26 Jul 2010 16:20:57 +0800
Message-ID: <73839B4A0818E747864426270AC332C305400687@zmy16exm20.fsl.freescale.net>
In-Reply-To: <AANLkTimQNWOvk_Tn3yedA-TSEc3x=+QR=rynvB8PKpTp@mail.gmail.com>
References: <1279591705-7574-1-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-2-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-3-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-4-git-send-email-Mingkai.hu@freescale.com>
	<20100726002813.GB25419@angua.secretlab.ca>
	<73839B4A0818E747864426270AC332C305400637@zmy16exm20.fsl.freescale.net>
	<AANLkTimQNWOvk_Tn3yedA-TSEc3x=+QR=rynvB8PKpTp@mail.gmail.com>
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
> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On=20
> Behalf Of Grant Likely
> Sent: Monday, July 26, 2010 3:53 PM
> To: Hu Mingkai-B21284
> Cc: linuxppc-dev@ozlabs.org; galak@kernel.crashing.org; Zang=20
> Roy-R61911
> Subject: Re: [PATCH 3/6] of/spi: add support to parse the SPI=20
> flash's partitions
>=20
> On Mon, Jul 26, 2010 at 1:25 AM, Hu Mingkai-B21284=20
> <B21284@freescale.com> wrote:
> >
> >
> >> -----Original Message-----
> >> From: Grant Likely [mailto:glikely@secretlab.ca] On Behalf=20
> Of Grant=20
> >> Likely
> >> Sent: Monday, July 26, 2010 8:28 AM
> >> To: Hu Mingkai-B21284
> >> Cc: linuxppc-dev@ozlabs.org; galak@kernel.crashing.org; Zang
> >> Roy-R61911
> >> Subject: Re: [PATCH 3/6] of/spi: add support to parse the=20
> SPI flash's=20
> >> partitions
> >>
> >> On Tue, Jul 20, 2010 at 10:08:22AM +0800, Mingkai Hu wrote:
> >> > Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
> >> > ---
> >> > =A0drivers/of/of_spi.c =A0 =A0 =A0 | =A0 11 +++++++++++
> >> > =A0drivers/spi/spi_mpc8xxx.c | =A0 =A01 +
> >> > =A02 files changed, 12 insertions(+), 0 deletions(-)
> >> >
> >> > diff --git a/drivers/of/of_spi.c b/drivers/of/of_spi.c index=20
> >> > 5fed7e3..284ca0e 100644
> >> > --- a/drivers/of/of_spi.c
> >> > +++ b/drivers/of/of_spi.c
> >> > @@ -10,6 +10,8 @@
> >> > =A0#include <linux/device.h>
> >> > =A0#include <linux/spi/spi.h>
> >> > =A0#include <linux/of_spi.h>
> >> > +#include <linux/spi/flash.h>
> >> > +#include <linux/mtd/partitions.h>
> >> >
> >> > =A0/**
> >> > =A0 * of_register_spi_devices - Register child devices onto
> >> the SPI bus
> >> > @@ -26,6 +28,7 @@ void of_register_spi_devices(struct
> >> spi_master *master, struct device_node *np)
> >> > =A0 =A0 const __be32 *prop;
> >> > =A0 =A0 int rc;
> >> > =A0 =A0 int len;
> >> > + =A0 struct flash_platform_data *pdata;
> >> >
> >> > =A0 =A0 for_each_child_of_node(np, nc) {
> >> > =A0 =A0 =A0 =A0 =A0 =A0 /* Alloc an spi_device */ @@ -81,6 +84,14 =
@@ void=20
> >> > of_register_spi_devices(struct
> >> spi_master *master, struct device_node *np)
> >> > =A0 =A0 =A0 =A0 =A0 =A0 of_node_get(nc);
> >> > =A0 =A0 =A0 =A0 =A0 =A0 spi->dev.of_node =3D nc;
> >> >
> >> > + =A0 =A0 =A0 =A0 =A0 /* Parse the mtd partitions */
> >> > + =A0 =A0 =A0 =A0 =A0 pdata =3D kzalloc(sizeof(*pdata), =
GFP_KERNEL);
> >> > + =A0 =A0 =A0 =A0 =A0 if (!pdata)
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> >> > + =A0 =A0 =A0 =A0 =A0 pdata->nr_parts =3D=20
> of_mtd_parse_partitions(&master->dev,
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 nc, =
&pdata->parts);
> >> > + =A0 =A0 =A0 =A0 =A0 spi->dev.platform_data =3D pdata;
> >> > +
> >>
> >> Nack. =A0Not all spi devices are mtd devices. =A0In fact, most are =
not.
> >>
> >> The spi driver itself should call the=20
> of_mtd_parse_partitions code to=20
> >> get the partition map. =A0Do not use pdata in this case.
> >>
> >
> > Yes, we can call of_mtd_parse_partitions to get the=20
> partiton map, but=20
> > how can we pass this map to spi device to register to MTD layer?
> >
> > The spi device is created and registered when call=20
> > of_register_spi_device in the spi controller probe=20
> function, then the=20
> > spi device will traverse the spi device driver list to find=20
> the proper=20
> > driver, if matched, then call the spi device driver probe=20
> code where=20
> > the mtd partition info is registered to the mtd layer.
> >
> > so where is the proper place to put the=20
> of_mtd_parse_partitions code?
>=20
> In the device driver probe code.
>=20

This is the way that I did at first, thus we need to add the same code
in all the spi flash driver to get partition map info.

or we add the get partition map code to of_spi.c?

+/*
+ * of_parse_flash_partition - Parse the flash partition on the SPI bus
+ * @spi:       Pointer to spi_device device
+ */
+void of_parse_flash_partition(struct spi_device *spi)
+{
+       struct mtd_partition *parts;
+       struct flash_platform_data *spi_pdata;
+       int nr_parts =3D 0;
+       static int num_flash;
+       struct device_node *np =3D spi->dev.archdata.of_node;
+
+       nr_parts =3D of_mtd_parse_partitions(&spi->dev, np, &parts);
+       if (!nr_parts)
+               goto end;
+
+       spi_pdata =3D kzalloc(sizeof(*spi_pdata), GFP_KERNEL);
+       if (!spi_pdata)
+               goto end;
+       spi_pdata->name =3D kzalloc(10, GFP_KERNEL);
+       if (!spi_pdata->name)
+               goto free_flash;
+       snprintf(spi_pdata->name, 10, "SPIFLASH%d", num_flash++);
+
+       spi_pdata->parts =3D parts;
+       spi_pdata->nr_parts =3D nr_parts;
+
+       spi->dev.platform_data =3D spi_pdata;
+
+       return;
+
+free_flash:
+       kfree(spi_pdata);
+end:
+       return;
+}


> >> > diff --git a/drivers/spi/spi_mpc8xxx.c=20
> b/drivers/spi/spi_mpc8xxx.c=20
> >> > index efed70e..0fadaeb 100644
> >> > --- a/drivers/spi/spi_mpc8xxx.c
> >> > +++ b/drivers/spi/spi_mpc8xxx.c
> >> > @@ -137,6 +137,7 @@ int mpc8xxx_spi_transfer(struct spi_device=20
> >> > *spi,
> >> >
> >> > =A0void mpc8xxx_spi_cleanup(struct spi_device *spi) =A0{
> >> > + =A0 kfree(spi->dev.platform_data);
> >>
> >> Irrelevant given the above comment, but how does this even work? =
=A0
> >> What if a driver was detached and reattached to an=20
> spi_device? =A0The=20
> >> platform_data would be freed. =A0Not to mention that the=20
> pointer isn't=20
> >> cleared, so the driver would have no idea that it has a freed=20
> >> pointer.
> >>
> >
> > It works. If the driver detached, the spi device=20
> platform_data will be=20
> > released, when reattached, the of_register_spi_devices will=20
> be called=20
> > again, the platform_data will be allocated.
>=20
> Ah right, I wasn't looking in the right place.  On that note=20
> however, the cleanup of spi_device allocated by the OF code=20
> should also have a reciprocal helper that frees them too.  It=20
> shouldn't be done in the individual drivers.
>=20

We can define a helper to free the platform_data, but where it should be =
called?
Maybe spidev_release is a better place to call, after all the =
platfrom_data is allocated
when the spi device is created, so it should be freed when released.

Thanks,
Mingkai
