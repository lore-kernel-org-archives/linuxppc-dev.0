Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BCDB4B70AB
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  6 Jun 2009 02:00:16 +1000 (EST)
MIME-Version: 1.0
In-Reply-To: <1244203514-12516-3-git-send-email-w.sang@pengutronix.de>
References: <1244203514-12516-1-git-send-email-w.sang@pengutronix.de>
	<1244203514-12516-3-git-send-email-w.sang@pengutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 5 Jun 2009 09:53:51 -0600
Message-ID: <fa686aa40906050853n76f12c4habd1f4e82566fa9@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] mtd/maps/mtd-ram: add an of-platform driver
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree-discuss@ozlabs.org, albrecht.dress@arcor.de,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	Ben Dooks <ben-linux@fluff.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 5, 2009 at 6:05 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> Create an of-aware driver using the now exported generic functions from
> plat-ram.c. Also add the documentation for the binding. Partitions are
> not yet supported. Tested on a phyCORE-MPC5200B-IO.
>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Albrecht Dre=DF <albrecht.dress@arcor.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: linuxppc-dev@ozlabs.org
> Cc: devicetree-discuss@ozlabs.org
> Cc: linux-mtd@lists.infradead.org

On brief review, looks good to me (for both patches).
Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> Changes in V2:
>
> - added binding documentation
> - added __devinit & friends
> - put struct resource on stack during probe
> - simplified getting the name of the of-device
> - made error path more readable & add check for valid bank-width-pointer
> - rename driver to "of-mtd-ram"
>
> =A0Documentation/powerpc/dts-bindings/mtd-ram.txt | =A0 18 ++++
> =A0drivers/mtd/maps/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 =A07 ++
> =A0drivers/mtd/maps/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A01 +
> =A0drivers/mtd/maps/of-ram.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0102 ++++++++++++++++++++++++
> =A04 files changed, 128 insertions(+), 0 deletions(-)
> =A0create mode 100644 Documentation/powerpc/dts-bindings/mtd-ram.txt
> =A0create mode 100644 drivers/mtd/maps/of-ram.c
>
> diff --git a/Documentation/powerpc/dts-bindings/mtd-ram.txt b/Documentati=
on/powerpc/dts-bindings/mtd-ram.txt
> new file mode 100644
> index 0000000..a2e9932
> --- /dev/null
> +++ b/Documentation/powerpc/dts-bindings/mtd-ram.txt
> @@ -0,0 +1,18 @@
> +RAM emulating an MTD
> +
> +An external RAM like SRAM or FRAM can also be treated as an MTD.
> +
> + - compatible : should contain the specific model of the RAM chip
> + =A0 used, if known, followed by "mtd-ram".
> + - reg : Address range of the RAM chip
> + - bank-width : Width (in bytes) of the RAM bank.
> +
> +Partitions are not yet supported.
> +
> +Example:
> +
> + =A0 =A0 =A0 sram@2,0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "samsung,k6f1616u6a", "mtd-r=
am";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <2 0 0x00200000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank-width =3D <2>;
> + =A0 =A0 =A0 };
> diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
> index 82923bd..bdd9ebc 100644
> --- a/drivers/mtd/maps/Kconfig
> +++ b/drivers/mtd/maps/Kconfig
> @@ -551,6 +551,13 @@ config MTD_PLATRAM
>
> =A0 =A0 =A0 =A0 =A0This selection automatically selects the map_ram drive=
r.
>
> +config MTD_OFRAM
> + =A0 =A0 =A0 tristate "Map driver for of-device RAM (of-mtd-ram)"
> + =A0 =A0 =A0 depends on MTD_PLATRAM && OF
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Map driver for RAM areas described via the of-device
> + =A0 =A0 =A0 =A0 system.
> +
> =A0config MTD_VMU
> =A0 =A0 =A0 =A0tristate "Map driver for Dreamcast VMU"
> =A0 =A0 =A0 =A0depends on MAPLE
> diff --git a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
> index 2dbc1be..a7a2db3 100644
> --- a/drivers/mtd/maps/Makefile
> +++ b/drivers/mtd/maps/Makefile
> @@ -57,6 +57,7 @@ obj-$(CONFIG_MTD_IXP2000) =A0 =A0 +=3D ixp2000.o
> =A0obj-$(CONFIG_MTD_WRSBC8260) =A0 =A0+=3D wr_sbc82xx_flash.o
> =A0obj-$(CONFIG_MTD_DMV182) =A0 =A0 =A0 +=3D dmv182.o
> =A0obj-$(CONFIG_MTD_PLATRAM) =A0 =A0 =A0+=3D plat-ram.o
> +obj-$(CONFIG_MTD_OFRAM) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D of-ram.o
> =A0obj-$(CONFIG_MTD_OMAP_NOR) =A0 =A0 +=3D omap_nor.o
> =A0obj-$(CONFIG_MTD_INTEL_VR_NOR) +=3D intel_vr_nor.o
> =A0obj-$(CONFIG_MTD_BFIN_ASYNC) =A0 +=3D bfin-async-flash.o
> diff --git a/drivers/mtd/maps/of-ram.c b/drivers/mtd/maps/of-ram.c
> new file mode 100644
> index 0000000..e2f4476
> --- /dev/null
> +++ b/drivers/mtd/maps/of-ram.c
> @@ -0,0 +1,102 @@
> +/*
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
> +static __devinit int of_ram_probe(struct of_device *op,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct of_device_id *=
match)
> +{
> + =A0 =A0 =A0 struct platdata_mtd_ram *pdata;
> + =A0 =A0 =A0 struct resource res;
> + =A0 =A0 =A0 const u32 *bankwidth;
> + =A0 =A0 =A0 int ret =3D -ENOENT;
> +
> + =A0 =A0 =A0 pdata =3D kzalloc(sizeof(*pdata), GFP_KERNEL);
> + =A0 =A0 =A0 if (!pdata)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 op->dev.platform_data =3D pdata;
> +
> + =A0 =A0 =A0 ret =3D of_address_to_resource(op->node, 0, &res);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&op->dev, "could not create resourc=
e (%d)\n", ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_free;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 bankwidth =3D of_get_property(op->node, "bank-width", NULL)=
;
> + =A0 =A0 =A0 if (!bankwidth || *bankwidth =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&op->dev, "bank width not set\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_free;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 pdata->bankwidth =3D *bankwidth;
> +
> + =A0 =A0 =A0 ret =3D __platram_probe(&op->dev, op->node->name, &res, pda=
ta);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&op->dev, "error probing device (%d=
)\n", ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_free;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +
> +out_free:
> + =A0 =A0 =A0 op->dev.platform_data =3D NULL;
> + =A0 =A0 =A0 kfree(pdata);
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static __devexit int of_ram_remove(struct of_device *op)
> +{
> + =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 struct platdata_mtd_ram *pdata =3D op->dev.platform_data;
> +
> + =A0 =A0 =A0 ret =3D __platram_remove(&op->dev);
> + =A0 =A0 =A0 op->dev.platform_data =3D NULL;
> + =A0 =A0 =A0 kfree(pdata);
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static const struct of_device_id __devinitconst of_ram_match[] =3D {
> + =A0 =A0 =A0 { .compatible =3D "mtd-ram", },
> + =A0 =A0 =A0 {},
> +};
> +MODULE_DEVICE_TABLE(of, of_ram_match);
> +
> +static struct of_platform_driver of_ram_driver =3D {
> + =A0 =A0 =A0 .owner =3D THIS_MODULE,
> + =A0 =A0 =A0 .name =3D "of-mtd-ram",
> + =A0 =A0 =A0 .match_table =3D of_ram_match,
> + =A0 =A0 =A0 .probe =3D of_ram_probe,
> + =A0 =A0 =A0 .remove =3D __devexit_p(of_ram_remove),
> +};
> +
> +static int __init of_ram_init(void)
> +{
> + =A0 =A0 =A0 return of_register_platform_driver(&of_ram_driver);
> +}
> +module_init(of_ram_init);
> +
> +static void __exit of_ram_exit(void)
> +{
> + =A0 =A0 =A0 of_unregister_platform_driver(&of_ram_driver);
> +}
> +module_exit(of_ram_exit);
> +
> +MODULE_AUTHOR("Wolfram Sang");
> +MODULE_DESCRIPTION("OF-MTD-RAM map driver");
> +MODULE_LICENSE("GPL v2");
> --
> 1.6.2
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
