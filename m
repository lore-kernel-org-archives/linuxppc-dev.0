Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 71201DE044
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Jan 2009 09:30:42 +1100 (EST)
Date: Sat, 24 Jan 2009 23:30:36 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-mtd@lists.infradead.org
Subject: Re: [PATCH 2/2] maps/mtd-ram: add an of-platform driver
Message-ID: <20090124223036.GB13207@pengutronix.de>
References: <1232559685-2268-1-git-send-email-w.sang@pengutronix.de>
	<1232559685-2268-3-git-send-email-w.sang@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
In-Reply-To: <1232559685-2268-3-git-send-email-w.sang@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, ben-linux@fluff.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

found one question thing myself...

On Wed, Jan 21, 2009 at 06:41:25PM +0100, Wolfram Sang wrote:
> Create an of-aware driver using the now exported generic functions from
> plat-ram.c. A typical oftree snipplet for it looks like this:
>=20
> sram@04e00000 {
> 	compatible =3D "mtd-ram";
> 	reg =3D <0x04e00000 0x00200000>;
> 	bank-width =3D <2>;
> };
>=20
> Partitions on this device are not yet supported.
>=20
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
>  drivers/mtd/maps/Kconfig  |    6 ++
>  drivers/mtd/maps/Makefile |    1 +
>  drivers/mtd/maps/of-ram.c |  120 +++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 127 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/mtd/maps/of-ram.c
>=20
> diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
> index 0225cbb..b238b6d 100644
> --- a/drivers/mtd/maps/Kconfig
> +++ b/drivers/mtd/maps/Kconfig
> @@ -551,5 +551,11 @@ config MTD_PLATRAM
> =20
>  	  This selection automatically selects the map_ram driver.
> =20
> +config MTD_OFRAM
> +	tristate "Map driver for of-device RAM (mtd-ram)"
> +	depends on MTD_PLATRAM && OF
> +	help
> +	  Map driver for RAM areas described via the of-device
> +	  system.
>  endmenu
> =20
> diff --git a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
> index 6d9ba35..f8e3908 100644
> --- a/drivers/mtd/maps/Makefile
> +++ b/drivers/mtd/maps/Makefile
> @@ -58,6 +58,7 @@ obj-$(CONFIG_MTD_WRSBC8260)	+=3D wr_sbc82xx_flash.o
>  obj-$(CONFIG_MTD_DMV182)	+=3D dmv182.o
>  obj-$(CONFIG_MTD_SHARP_SL)	+=3D sharpsl-flash.o
>  obj-$(CONFIG_MTD_PLATRAM)	+=3D plat-ram.o
> +obj-$(CONFIG_MTD_OFRAM)		+=3D of-ram.o
>  obj-$(CONFIG_MTD_OMAP_NOR)	+=3D omap_nor.o
>  obj-$(CONFIG_MTD_INTEL_VR_NOR)	+=3D intel_vr_nor.o
>  obj-$(CONFIG_MTD_BFIN_ASYNC)	+=3D bfin-async-flash.o
> diff --git a/drivers/mtd/maps/of-ram.c b/drivers/mtd/maps/of-ram.c
> new file mode 100644
> index 0000000..4d334a9
> --- /dev/null
> +++ b/drivers/mtd/maps/of-ram.c
> @@ -0,0 +1,120 @@
> +/*
> + * drivers/mtd/maps/of-ram.c
> + *
> + * Generic of device based RAM map
> + *
> + * Copyright (C) 2009 Wolfram Sang, Pengutronix
> + *
> + * Using plat-ram.c by Ben Dooks
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms of the GNU General Public License version 2 as publis=
hed by
> + * the Free Software Foundation.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/mtd/plat-ram.h>
> +
> +static int of_ram_probe(struct of_device *op, const struct of_device_id =
*match)
> +{
> +	struct platdata_mtd_ram *pdata;
> +	struct resource *resource;
> +	const char *name;
> +	const u32 *bankwidth;
> +	int ret =3D -ENOMEM;
> +
> +	pdata =3D kzalloc(sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		goto bad0;
> +	op->dev.platform_data =3D pdata;
> +
> +	name =3D of_get_property(op->node, "name", NULL);

As this pointer gets passed on and used, I must probably add something
like of_node_get(op->node) here and put the node later in the remove
function? Not 100% sure, though...

> +	if (!name) {
> +		ret =3D -ENOENT;
> +		dev_dbg(&op->dev, "could not get node name\n");
> +		goto bad1;
> +	}
> +
> +	resource =3D kzalloc(sizeof(struct resource), GFP_KERNEL);
> +	if (!resource)
> +		goto bad1;
> +
> +	if (of_address_to_resource(op->node, 0, resource)) {
> +		ret =3D -ENXIO;
> +		dev_dbg(&op->dev, "could not create resource\n");
> +		goto bad2;
> +	}
> +
> +	bankwidth =3D of_get_property(op->node, "bank-width", NULL);
> +	if (*bankwidth =3D=3D 0) {
> +		ret =3D -ENOENT;
> +		dev_dbg(&op->dev, "bank width not set\n");
> +		goto bad2;
> +	}
> +	pdata->bankwidth =3D *bankwidth;
> +
> +	ret =3D __platram_probe(&op->dev, name, resource, pdata);
> +	kfree(resource);
> +
> +	if (ret)
> +		goto bad1;
> +
> +	return 0;
> +
> + bad2:
> +	kfree(resource);
> + bad1:
> +	op->dev.platform_data =3D NULL;
> +	kfree(pdata);
> + bad0:
> +	return ret;
> +}
> +
> +static int of_ram_remove(struct of_device *op)
> +{
> +	int ret;
> +	struct platdata_mtd_ram *pdata =3D op->dev.platform_data;
> +
> +	ret =3D __platram_remove(&op->dev);
> +	op->dev.platform_data =3D NULL;
> +	kfree(pdata);
> +	return ret;
> +}
> +
> +static struct of_device_id of_ram_match[] =3D {
> +	{ .compatible =3D "mtd-ram", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, of_ram_match);
> +
> +static struct of_platform_driver of_ram_driver =3D {
> +	.owner =3D THIS_MODULE,
> +	.name =3D "of-ram",
> +	.match_table =3D of_ram_match,
> +	.probe =3D of_ram_probe,
> +	.remove =3D of_ram_remove,
> +};
> +
> +static int __init of_ram_init(void)
> +{
> +	return of_register_platform_driver(&of_ram_driver);
> +}
> +
> +static void __exit of_ram_exit(void)
> +{
> +	of_unregister_platform_driver(&of_ram_driver);
> +}
> +
> +module_init(of_ram_init);
> +module_exit(of_ram_exit);
> +
> +MODULE_AUTHOR("Wolfram Sang");
> +MODULE_DESCRIPTION("MTD OF RAM map driver");
> +MODULE_LICENSE("GPL v2");
> --=20
> 1.5.6.5
>=20

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkl7lowACgkQD27XaX1/VRvw5QCgpihsjbrf8HMl2B33XiAbrsSj
Qv0AmgLW4vbY1XZgJke19E5Ax+TBrUjX
=6f1Q
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
