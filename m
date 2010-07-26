Return-Path: <B21284@freescale.com>
Received: from VA3EHSOBE003.bigfish.com (va3ehsobe003.messaging.microsoft.com
	[216.32.180.13]) by ozlabs.org (Postfix) with ESMTP id 6FD7FB6EEF
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 17:02:31 +1000 (EST)
Received: from mail164-va3 (localhost.localdomain [127.0.0.1])	by
	mail164-va3-R.bigfish.com (Postfix) with ESMTP id 064871828190	for
	<linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 07:02:28 +0000 (UTC)
Received: from VA3EHSMHS015.bigfish.com (unknown [10.7.14.254])	by
	mail164-va3.bigfish.com (Postfix) with ESMTP id D545E19B004D	for
	<linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 07:02:26 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o6Q72Cx8027999	for
	<linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 00:02:23 -0700 (MST)
Received: from zmy16exm20.fsl.freescale.net (zmy16exm20.ap.freescale.net
	[10.211.3.23])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o6Q7Ed1O007004	for <linuxppc-dev@ozlabs.org>;
	Mon, 26 Jul 2010 02:14:40 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH 2/6] eSPI: add eSPI controller support
Date: Mon, 26 Jul 2010 15:02:08 +0800
Message-ID: <73839B4A0818E747864426270AC332C30540060A@zmy16exm20.fsl.freescale.net>
In-Reply-To: <20100726002525.GA25419@angua.secretlab.ca>
References: <1279591705-7574-1-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-2-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-3-git-send-email-Mingkai.hu@freescale.com>
	<20100726002525.GA25419@angua.secretlab.ca>
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
> Sent: Monday, July 26, 2010 8:25 AM
> To: Hu Mingkai-B21284
> Cc: linuxppc-dev@ozlabs.org; galak@kernel.crashing.org; Zang=20
> Roy-R61911
> Subject: Re: [PATCH 2/6] eSPI: add eSPI controller support
>=20
> > diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig index=20
> > cd564e2..c647a00 100644
> > --- a/drivers/spi/Kconfig
> > +++ b/drivers/spi/Kconfig
> > @@ -196,6 +196,13 @@ config SPI_FSL_SPI
> >  	help
> >  	  This enables using the Freescale SPI controllers in=20
> master mode.
> > =20
> > +config SPI_FSL_ESPI
> > +	tristate "Freescale eSPI controller"
> > +	depends on FSL_SOC
> > +	select SPI_MPC8xxx
> > +	help
> > +	  This enables using the Freescale eSPI controllers in=20
> master mode.
> > +
>=20
> Ditto from last patch.  config SPI_MPC8xxx_SPI
>=20

Ok.

> >  config SPI_OMAP_UWIRE
> >  	tristate "OMAP1 MicroWire"
> >  	depends on ARCH_OMAP1
> > diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile index=20
> > dca9fea..6af459b 100644
> > --- a/drivers/spi/Makefile
> > +++ b/drivers/spi/Makefile
> > @@ -36,6 +36,7 @@ obj-$(CONFIG_SPI_MPC52xx_PSC)	=09
> +=3D mpc52xx_psc_spi.o
> >  obj-$(CONFIG_SPI_MPC52xx)		+=3D mpc52xx_spi.o
> >  obj-$(CONFIG_SPI_MPC8xxx)		+=3D spi_mpc8xxx.o
> >  obj-$(CONFIG_SPI_FSL_SPI)		+=3D fsl_spi.o
> > +obj-$(CONFIG_SPI_FSL_ESPI)		+=3D fsl_espi.o
>=20
> spi_mpc8xxx_espi.o
>=20

Ok.

> >  obj-$(CONFIG_SPI_PPC4xx)		+=3D spi_ppc4xx.o
> >  obj-$(CONFIG_SPI_S3C24XX_GPIO)		+=3D spi_s3c24xx_gpio.o
> >  obj-$(CONFIG_SPI_S3C24XX)		+=3D spi_s3c24xx_hw.o
> > diff --git a/drivers/spi/fsl_espi.c=20
> b/drivers/spi/fsl_espi.c new file=20
> > mode 100644 index 0000000..ac70c8c
> > --- /dev/null
> > +++ b/drivers/spi/fsl_espi.c
> > @@ -0,0 +1,562 @@
> > +/*
> > + * MPC8xxx eSPI controller driver.
> > + *
> > + * Copyright 2010 Freescale Semiconductor, Inc.
> > + *
> > + * This program is free software; you can redistribute  it and/or=20
> > +modify it
> > + * under  the terms of  the GNU General  Public License as=20
> published=20
> > +by the
> > + * Free Software Foundation;  either version 2 of the  License, or=20
> > +(at your
> > + * option) any later version.
> > + */
> > +#include <linux/module.h>
> > +#include <linux/delay.h>
> > +#include <linux/irq.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/fsl_devices.h>
> > +#include <linux/mm.h>
> > +#include <linux/of.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/of_spi.h>
> > +#include <sysdev/fsl_soc.h>
> > +
> > +#include "spi_mpc8xxx.h"
> > +
> > +/* eSPI Controller mode register definitions */
> > +#define SPMODE_ENABLE		(1 << 31)
> > +#define SPMODE_LOOP		(1 << 30)
> > +#define SPMODE_TXTHR(x)		((x) << 8)
> > +#define SPMODE_RXTHR(x)		((x) << 0)
> > +
> > +/* eSPI Controller CS mode register definitions */
> > +#define CSMODE_CI_INACTIVEHIGH	(1 << 31)
> > +#define CSMODE_CP_BEGIN_EDGECLK	(1 << 30)
> > +#define CSMODE_REV		(1 << 29)
> > +#define CSMODE_DIV16		(1 << 28)
> > +#define CSMODE_PM(x)		((x) << 24)
> > +#define CSMODE_POL_1		(1 << 20)
> > +#define CSMODE_LEN(x)		((x) << 16)
> > +#define CSMODE_BEF(x)		((x) << 12)
> > +#define CSMODE_AFT(x)		((x) << 8)
> > +#define CSMODE_CG(x)		((x) << 3)
> > +
> > +/* Default mode/csmode for eSPI controller */ #define=20
> SPMODE_INIT_VAL=20
> > +(SPMODE_TXTHR(4) | SPMODE_RXTHR(3)) #define CSMODE_INIT_VAL=20
> > +(CSMODE_POL_1 | CSMODE_BEF(0) \
> > +			| CSMODE_AFT(0) | CSMODE_CG(1))
> > +
> > +/* SPIE register values */
> > +#define	SPIE_NE		0x00000200	/* Not empty */
> > +#define	SPIE_NF		0x00000100	/* Not full */
> > +
> > +/* SPIM register values */
> > +#define	SPIM_NE		0x00000200	/* Not empty */
> > +#define	SPIM_NF		0x00000100	/* Not full */
> > +#define SPIE_RXCNT(reg)     ((reg >> 24) & 0x3F)
> > +#define SPIE_TXCNT(reg)     ((reg >> 16) & 0x3F)
> > +
> > +/* SPCOM register values */
> > +#define SPCOM_CS(x)		((x) << 30)
> > +#define SPCOM_TRANLEN(x)	((x) << 0)
> > +#define	SPCOM_TRANLEN_MAX	0xFFFF	/* Max=20
> transaction length */
>=20
> Inconsistent whitespacing.  Some lines use tabs; others=20
> spaces.  Should be consistent on all the lines.
>=20

Ok.

> > +
> > +static
> > +int fsl_espi_setup_transfer(struct spi_device *spi, struct=20
> > +spi_transfer *t)
>=20
> Break the line in the arguments instead of the declaration. =20
> When grepping, the stuff at the front of the line is more=20
> important to see.  So:
>=20
> +static int fsl_espi_setup_transfer(struct spi_device *spi,
> +				   struct spi_transfer *t)
>=20

Ok.

> > +{
> > +	struct mpc8xxx_spi *mpc8xxx_spi;
> > +	u8 bits_per_word, pm;
> > +	u32 hz;
> > +	struct spi_mpc8xxx_cs	*cs =3D spi->controller_state;
> > +
> > +	mpc8xxx_spi =3D spi_master_get_devdata(spi->master);
> > +
> > +	if (t) {
> > +		bits_per_word =3D t->bits_per_word;
> > +		hz =3D t->speed_hz;
> > +	} else {
> > +		bits_per_word =3D 0;
> > +		hz =3D 0;
> > +	}
>=20
> Just initialize bits_per_word and hz to 0 when they are=20
> declared to eliminate the else clause.
>=20

Good suggestion.

> > +
> > +	/* spi_transfer level calls that work per-word */
> > +	if (!bits_per_word)
> > +		bits_per_word =3D spi->bits_per_word;
> > +
> > +	/* Make sure its a bit width we support [4..16] */
> > +	if ((bits_per_word < 4) || (bits_per_word > 16))
> > +		return -EINVAL;
> > +
> > +	if (!hz)
> > +		hz =3D spi->max_speed_hz;
> > +
> > +	cs->rx_shift =3D 0;
> > +	cs->tx_shift =3D 0;
> > +	cs->get_rx =3D mpc8xxx_spi_rx_buf_u32;
> > +	cs->get_tx =3D mpc8xxx_spi_tx_buf_u32;
> > +	if (bits_per_word <=3D 8) {
> > +		cs->rx_shift =3D 8 - bits_per_word;
> > +	} else if (bits_per_word <=3D 16) {
> > +		cs->rx_shift =3D 16 - bits_per_word;
> > +		if (spi->mode & SPI_LSB_FIRST)
> > +			cs->get_tx =3D fsl_espi_tx_buf_lsb;
> > +	} else
> > +		return -EINVAL;
> > +
> > +	mpc8xxx_spi->rx_shift =3D cs->rx_shift;
> > +	mpc8xxx_spi->tx_shift =3D cs->tx_shift;
> > +	mpc8xxx_spi->get_rx =3D cs->get_rx;
> > +	mpc8xxx_spi->get_tx =3D cs->get_tx;
> > +
> > +	bits_per_word =3D bits_per_word - 1;
> > +
> > +	/* mask out bits we are going to set */
> > +	cs->hw_mode &=3D ~(CSMODE_LEN(0xF) | CSMODE_DIV16
> > +				  | CSMODE_PM(0xF));
> > +
> > +	cs->hw_mode |=3D CSMODE_LEN(bits_per_word);
> > +
> > +	if ((mpc8xxx_spi->spibrg / hz) > 64) {
> > +		cs->hw_mode |=3D CSMODE_DIV16;
> > +		pm =3D (mpc8xxx_spi->spibrg - 1) / (hz * 64) + 1;
> > +
> > +		WARN_ONCE(pm > 16, "%s: Requested speed is too=20
> low: %d Hz. "
> > +			  "Will use %d Hz instead.\n",=20
> dev_name(&spi->dev),
> > +			  hz, mpc8xxx_spi->spibrg / 1024);
> > +		if (pm > 16)
> > +			pm =3D 16;
> > +	} else
> > +		pm =3D (mpc8xxx_spi->spibrg - 1) / (hz * 4) + 1;
>=20
> When the if clause has { }, please use braces in the else clause also.
>=20

Ok.

> > +static const struct of_device_id of_fsl_espi_match[] =3D {
> > +	{ .compatible =3D "fsl,espi" },
>=20
> Not good practice.  Use the real chip name in the compatible=20
> value.  "fsl,<chip>-espi".
>=20

Ok.

> > +	{},
>=20
> NIT: Drop the comma here to hint that no more elements should=20
> follow after the null entry.
>=20

Ok.

> > +};
> > +MODULE_DEVICE_TABLE(of, of_fsl_espi_match);
> > +
> > +static struct of_platform_driver of_fsl_espi_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "fsl_espi",
> > +		.owner =3D THIS_MODULE,
> > +		.of_match_table =3D of_fsl_espi_match,
> > +	},
> > +	.probe		=3D of_fsl_espi_probe,
> > +	.remove		=3D __devexit_p(of_fsl_espi_remove),
> > +};
> > +
> > +static int __init fsl_espi_init(void) {
> > +	return of_register_platform_driver(&of_fsl_espi_driver);
> > +}
> > +
> > +static void __exit fsl_espi_exit(void) {
> > +	of_unregister_platform_driver(&of_fsl_espi_driver);
> > +}
> > +
> > +module_init(fsl_espi_init);
>=20
> Move module_init() to right below fsl_espi_init.
>=20
Ok.

> > +module_exit(fsl_espi_exit);
> > +
> > +MODULE_AUTHOR("Mingkai Hu");
> > +MODULE_DESCRIPTION("Enhanced MPC8xxx SPI Driver");=20
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/spi/spi_mpc8xxx.h b/drivers/spi/spi_mpc8xxx.h=20
> > index dcc6443..a8e8270 100644
> > --- a/drivers/spi/spi_mpc8xxx.h
> > +++ b/drivers/spi/spi_mpc8xxx.h
> > @@ -20,6 +20,7 @@
> > =20
> >  /* SPI Controller registers */
> >  struct mpc8xxx_spi_reg {
> > +#ifndef CONFIG_SPI_FSL_ESPI
> >  	u8 res1[0x20];
> >  	__be32 mode;
> >  	__be32 event;
> > @@ -27,6 +28,16 @@ struct mpc8xxx_spi_reg {
> >  	__be32 command;
> >  	__be32 transmit;
> >  	__be32 receive;
> > +#else
> > +	__be32 mode;		/* 0x000 - eSPI mode register */
> > +	__be32 event;		/* 0x004 - eSPI event register */
> > +	__be32 mask;		/* 0x008 - eSPI mask register */
> > +	__be32 command;		/* 0x00c - eSPI command register */
> > +	__be32 transmit;	/* 0x010 - eSPI transmit FIFO=20
> access register*/
> > +	__be32 receive;		/* 0x014 - eSPI receive FIFO=20
> access register*/
> > +	u8 res1[8];		/* 0x018 - 0x01c reserved */
> > +	__be32 csmode[4];	/* 0x020 - 0x02c eSPI cs mode=20
> register */
> > +#endif
>=20
> Not multiplatform friendly.  If the two devices use different=20
> register maps, then the register map needs to be defined in=20
> the .c file.  You need to code for the case where a single=20
> kernel may contain both drivers.
>=20

You're right, this will disable the kernel supporting both drivers.
I'll fix it.

Thanks,
Mingkai
