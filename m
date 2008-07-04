Return-Path: <G.Chen@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B9C8DDDE20
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 13:55:07 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m643t1sq006549
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Jul 2008 20:55:01 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m643sxA4017571
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Jul 2008 22:55:00 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH v2 4/5] spi: Add OF binding support for SPI busses
Date: Fri, 4 Jul 2008 11:54:57 +0800
Message-ID: <58A20A281BAF1047B4EAE68DE5C0BDC2010121B7@zch01exm21.fsl.freescale.net>
In-Reply-To: <20080703010313.26187.99119.stgit@trillian.secretlab.ca>
References: <20080703005749.26187.71719.stgit@trillian.secretlab.ca>
	<20080703010313.26187.99119.stgit@trillian.secretlab.ca>
From: "Chen Gong" <G.Chen@freescale.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Cc: david-b@pacbell.net, linuxppc-dev@ozlabs.org, fabrizio.garetto@gmail.com,
	linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: linuxppc-dev-bounces+b11801=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+b11801=3Dfreescale.com@ozlabs.org]=20
> On Behalf Of Grant Likely
> Sent: 2008?7?3? 9:03
> To: linuxppc-dev@ozlabs.org;=20
> spi-devel-general@lists.sourceforge.net; linux-kernel@vger.kernel.org
> Cc: david-b@pacbell.net; fabrizio.garetto@gmail.com
> Subject: [PATCH v2 4/5] spi: Add OF binding support for SPI busses
>=20
> From: Grant Likely <grant.likely@secretlab.ca>
>=20
> This patch adds support for populating an SPI bus based on data in the
> OF device tree.  This is useful for powerpc platforms which use the
> device tree instead of discrete code for describing platform layout.
>=20
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>=20
>  drivers/of/Kconfig     |    6 +++
>  drivers/of/Makefile    |    1 +
>  drivers/of/of_spi.c    |   88=20
> ++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/of_spi.h |   18 ++++++++++
>  4 files changed, 113 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index 3a7a11a..edd6e92 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -13,3 +13,9 @@ config OF_I2C
>  	depends on PPC_OF && I2C
>  	help
>  	  OpenFirmware I2C accessors
> +
> +config OF_SPI
> +	def_tristate SPI
> +	depends on OF && PPC_OF && SPI
> +	help
> +	  OpenFirmware SPI accessors
> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
> index 548772e..4c3c6f8 100644
> --- a/drivers/of/Makefile
> +++ b/drivers/of/Makefile
> @@ -2,3 +2,4 @@ obj-y =3D base.o
>  obj-$(CONFIG_OF_DEVICE) +=3D device.o platform.o
>  obj-$(CONFIG_OF_GPIO)   +=3D gpio.o
>  obj-$(CONFIG_OF_I2C)	+=3D of_i2c.o
> +obj-$(CONFIG_OF_SPI)	+=3D of_spi.o
> diff --git a/drivers/of/of_spi.c b/drivers/of/of_spi.c
> new file mode 100644
> index 0000000..ed0c807
> --- /dev/null
> +++ b/drivers/of/of_spi.c
> @@ -0,0 +1,88 @@
> +/*
> + * SPI OF support routines
> + * Copyright (C) 2008 Secret Lab Technologies Ltd.
> + *
> + * Support routines for deriving SPI device attachments from=20
> the device
> + * tree.
> + */
> +
> +#include <linux/of.h>
> +#include <linux/device.h>
> +#include <linux/spi/spi.h>
> +#include <linux/of_spi.h>
> +
> +/**
> + * of_register_spi_devices - Register child devices onto the SPI bus
> + * @master:	Pointer to spi_master device
> + * @np:		parent node of SPI device nodes
> + *
> + * Registers an spi_device for each child node of 'np' which=20
> has a 'reg'
> + * property.
> + */
> +void of_register_spi_devices(struct spi_master *master,=20
> struct device_node *np)
> +{
> +	struct spi_device *spi;
> +	struct device_node *nc;
> +	const u32 *prop;
> +	const char *sprop;
> +	int rc;
> +	int len;
> +
> +	for_each_child_of_node(np, nc) {
> +		/* Alloc an spi_device */
> +		spi =3D spi_alloc_device(master);
> +		if (!spi) {
> +			dev_err(&master->dev, "spi_device alloc=20
> error for %s\n",
> +				nc->full_name);
> +			continue;
> +		}
> +
> +		/* Device address */
> +		prop =3D of_get_property(nc, "reg", &len);
> +		if (!prop || len < sizeof(*prop)) {
> +			dev_err(&master->dev, "%s has no 'reg'=20
> property\n",
> +				nc->full_name);
> +			continue;
> +		}
> +		spi->chip_select =3D *prop;
> +
> +		/* Mode (clock phase/polarity/etc.) */
> +		if (of_find_property(nc, "spi,cpha", NULL))
> +			spi->mode |=3D SPI_CPHA;
> +		if (of_find_property(nc, "spi,cpol", NULL))
> +			spi->mode |=3D SPI_CPOL;

so becuase in function spi_alloc_deive, spi is allocated by kzalloc,
how about writing as follows:
		/* Mode (clock phase/polarity/etc.) */
		prop =3D of_get_property(nc, "spi,cpha", NULL))
                        if (prop)
			spi->mode |=3D *prop;
		prop =3D of_get_property(nc, "spi,cpol", NULL))
                        if (prop)
			spi->mode |=3D *prop;

> +
> +		/* Device speed */
> +		prop =3D of_get_property(nc, "max-speed", &len);
> +		if (!prop || len < sizeof(*prop)) {
> +			dev_err(&master->dev, "%s has no=20
> 'max-speed' property\n",
> +				nc->full_name);
> +			continue;
> +		}
> +		spi->max_speed_hz =3D *prop;
> +
> +		/* IRQ */
> +		spi->irq =3D irq_of_parse_and_map(nc, 0);
> +
> +		/* Select device driver */
> +		sprop =3D of_get_property(nc, "linux,modalias", &len);
> +		if (sprop && len > 0)
> +			strncpy(spi->modalias, sprop, KOBJ_NAME_LEN);
> +		else
> +			strncpy(spi->modalias, "spidev", KOBJ_NAME_LEN);
> +
 how about writing as follows:

		if (sprop && len > 0)
			strncpy(spi->modalias, sprop, KOBJ_NAME_LEN -
1);
		else
			strncpy(spi->modalias, "spidev", KOBJ_NAME_LEN -
1);
