Return-Path: <mwilli60@harris.com>
Received: from mlbefw1.harris.com (mlbefw1.harris.com [192.52.233.75])
	by ozlabs.org (Postfix) with ESMTP id B232CB6FA4
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jun 2011 01:14:28 +1000 (EST)
From: "Williams, Michael (mwilli60)" <mwilli60@harris.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH] hwrng: ppc4xx - add support for ppc4xx TRNG
Date: Wed, 22 Jun 2011 14:49:46 +0000
Message-ID: <DDF11BD7A6602849A91C0D0A8172FC2C05F594@MLBMXUS20.cs.myharris.net>
References: <20110621121955.GB2414@zod.rchland.ibm.com>
In-Reply-To: <20110621121955.GB2414@zod.rchland.ibm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Various PowerPC 4xx SoCs contain a TRNG embedded in the Security
> function.
> This adds a device driver for that TRNG.
>=20
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

Works for me on a 460GT glacier board.

Tested-by: Mike Williams <mike@mikebwilliams.com>

>=20
> ---
>  drivers/char/hw_random/Kconfig      |   12 +++
>  drivers/char/hw_random/Makefile     |    1 +
>  drivers/char/hw_random/ppc4xx-rng.c |  156
> +++++++++++++++++++++++++++++++++++
>  3 files changed, 169 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/char/hw_random/ppc4xx-rng.c
>=20
> diff --git a/drivers/char/hw_random/Kconfig
> b/drivers/char/hw_random/Kconfig
> index a60043b..1d2ebc7 100644
> --- a/drivers/char/hw_random/Kconfig
> +++ b/drivers/char/hw_random/Kconfig
> @@ -210,3 +210,15 @@ config HW_RANDOM_PICOXCELL
>  	  module will be called picoxcell-rng.
>=20
>  	  If unsure, say Y.
> +
> +config HW_RANDOM_PPC4XX
> +	tristate "PowerPC 4xx generic true random number generator
> support"
> +	depends on HW_RANDOM && PPC && 4xx
> +	---help---
> +	 This driver provides the kernel-side support for the TRNG
> hardware
> +	 found in the security function of some PowerPC 4xx SoCs.
> +
> +	 To compile this driver as a module, choose M here: the
> +	 module will be called ppc4xx-rng.
> +
> +	 If unsure, say N.
> diff --git a/drivers/char/hw_random/Makefile
> b/drivers/char/hw_random/Makefile
> index 3db4eb8..c88f244 100644
> --- a/drivers/char/hw_random/Makefile
> +++ b/drivers/char/hw_random/Makefile
> @@ -20,3 +20,4 @@ obj-$(CONFIG_HW_RANDOM_MXC_RNGA) +=3D mxc-rnga.o
>  obj-$(CONFIG_HW_RANDOM_OCTEON) +=3D octeon-rng.o
>  obj-$(CONFIG_HW_RANDOM_NOMADIK) +=3D nomadik-rng.o
>  obj-$(CONFIG_HW_RANDOM_PICOXCELL) +=3D picoxcell-rng.o
> +obj-$(CONFIG_HW_RANDOM_PPC4XX) +=3D ppc4xx-rng.o
> diff --git a/drivers/char/hw_random/ppc4xx-rng.c
> b/drivers/char/hw_random/ppc4xx-rng.c
> new file mode 100644
> index 0000000..b8afa6a
> --- /dev/null
> +++ b/drivers/char/hw_random/ppc4xx-rng.c
> @@ -0,0 +1,156 @@
> +/*
> + * Generic PowerPC 44x RNG driver
> + *
> + * Copyright 2011 IBM Corporation
> + *
> + * This program is free software; you can redistribute it and/or
> modify it
> + * under the terms of the GNU General Public License as published by
> the
> + * Free Software Foundation; version 2 of the License.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/hw_random.h>
> +#include <linux/delay.h>
> +#include <linux/of_platform.h>
> +#include <asm/io.h>
> +
> +#define PPC4XX_TRNG_DEV_CTRL 0x60080
> +
> +#define PPC4XX_TRNGE 0x00020000
> +#define PPC4XX_TRNG_CTRL 0x0008
> +#define PPC4XX_TRNG_CTRL_DALM 0x20
> +#define PPC4XX_TRNG_STAT 0x0004
> +#define PPC4XX_TRNG_STAT_B 0x1
> +#define PPC4XX_TRNG_DATA 0x0000
> +
> +#define MODULE_NAME "ppc4xx_rng"
> +
> +static int ppc4xx_rng_data_present(struct hwrng *rng, int wait)
> +{
> +	void __iomem *rng_regs =3D (void __iomem *) rng->priv;
> +	int busy, i, present =3D 0;
> +
> +	for (i =3D 0; i < 20; i++) {
> +		busy =3D (in_le32(rng_regs + PPC4XX_TRNG_STAT) &
> PPC4XX_TRNG_STAT_B);
> +		if (!busy || !wait) {
> +			present =3D 1;
> +			break;
> +		}
> +		udelay(10);
> +	}
> +	return present;
> +}
> +
> +static int ppc4xx_rng_data_read(struct hwrng *rng, u32 *data)
> +{
> +	void __iomem *rng_regs =3D (void __iomem *) rng->priv;
> +	*data =3D in_le32(rng_regs + PPC4XX_TRNG_DATA);
> +	return 4;
> +}
> +
> +static int ppc4xx_rng_enable(int enable)
> +{
> +	struct device_node *ctrl;
> +	void __iomem *ctrl_reg;
> +	int err =3D 0;
> +	u32 val;
> +
> +	/* Find the main crypto device node and map it to turn the TRNG
> on */
> +	ctrl =3D of_find_compatible_node(NULL, NULL, "amcc,ppc4xx-crypto");
> +	if (!ctrl)
> +		return -ENODEV;
> +
> +	ctrl_reg =3D of_iomap(ctrl, 0);
> +	if (!ctrl_reg) {
> +		err =3D -ENODEV;
> +		goto out;
> +	}
> +
> +	val =3D in_le32(ctrl_reg + PPC4XX_TRNG_DEV_CTRL);
> +
> +	if (enable)
> +		val |=3D PPC4XX_TRNGE;
> +	else
> +		val =3D val & ~PPC4XX_TRNGE;
> +
> +	out_le32(ctrl_reg + PPC4XX_TRNG_DEV_CTRL, val);
> +	iounmap(ctrl_reg);
> +
> +out:
> +	of_node_put(ctrl);
> +
> +	return err;
> +}
> +
> +static struct hwrng ppc4xx_rng =3D {
> +	.name =3D MODULE_NAME,
> +	.data_present =3D ppc4xx_rng_data_present,
> +	.data_read =3D ppc4xx_rng_data_read,
> +};
> +
> +static int __devinit ppc4xx_rng_probe(struct platform_device *dev)
> +{
> +	void __iomem *rng_regs;
> +	int err =3D 0;
> +
> +	rng_regs =3D of_iomap(dev->dev.of_node, 0);
> +	if (!rng_regs)
> +		return -ENODEV;
> +
> +	err =3D ppc4xx_rng_enable(1);
> +	if (err)
> +		return err;
> +
> +	out_le32(rng_regs + PPC4XX_TRNG_CTRL, PPC4XX_TRNG_CTRL_DALM);
> +	ppc4xx_rng.priv =3D (unsigned long) rng_regs;
> +
> +	err =3D hwrng_register(&ppc4xx_rng);
> +
> +	return err;
> +}
> +
> +static int __devexit ppc4xx_rng_remove(struct platform_device *dev)
> +{
> +	void __iomem *rng_regs =3D (void __iomem *) ppc4xx_rng.priv;
> +
> +	hwrng_unregister(&ppc4xx_rng);
> +	ppc4xx_rng_enable(0);
> +	iounmap(rng_regs);
> +
> +	return 0;
> +}
> +
> +static struct of_device_id ppc4xx_rng_match[] =3D {
> +	{ .compatible =3D "ppc4xx-rng", },
> +	{ .compatible =3D "amcc,ppc460ex-rng", },
> +	{ .compatible =3D "amcc,ppc440epx-rng", },
> +	{},
> +};
> +
> +static struct platform_driver ppc4xx_rng_driver =3D {
> +	.driver =3D {
> +		.name =3D MODULE_NAME,
> +		.owner =3D THIS_MODULE,
> +		.of_match_table =3D ppc4xx_rng_match,
> +	},
> +	.probe =3D ppc4xx_rng_probe,
> +	.remove =3D ppc4xx_rng_remove,
> +};
> +
> +static int __init ppc4xx_rng_init(void)
> +{
> +	return platform_driver_register(&ppc4xx_rng_driver);
> +}
> +module_init(ppc4xx_rng_init);
> +
> +static void __exit ppc4xx_rng_exit(void)
> +{
> +	platform_driver_unregister(&ppc4xx_rng_driver);
> +}
> +module_exit(ppc4xx_rng_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Josh Boyer <jwboyer@linux.vnet.ibm.com>");
> +MODULE_DESCRIPTION("HW RNG driver for PPC 4xx processors");
> --
> 1.7.4.4
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
