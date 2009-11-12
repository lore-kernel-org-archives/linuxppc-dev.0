Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f228.google.com (mail-gx0-f228.google.com
	[209.85.217.228]) by ozlabs.org (Postfix) with ESMTP id 7D5BBB7B6C
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 01:56:28 +1100 (EST)
Received: by gxk28 with SMTP id 28so231115gxk.9
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Nov 2009 06:56:26 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4AFC1B1E.60304@mocean-labs.com>
References: <4AFC1B1E.60304@mocean-labs.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 12 Nov 2009 07:56:05 -0700
Message-ID: <fa686aa40911120656x3b94b9c7tfabd6e7956ed41fb@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] xilinx_spi: Split into of driver and generic part.
To: =?ISO-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors@mocean-labs.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>, dbrownell@users.sourceforge.net,
	John Linn <John.Linn@xilinx.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 12, 2009 at 7:26 AM, Richard R=F6jfors
<richard.rojfors@mocean-labs.com> wrote:
> This patch splits the xilinx_spi driver into a generic part and a
> OF driver part.
>
> The reason for this is to later add in a platform driver as well.
>
> Signed-off-by: Richard R=F6jfors <richard.rojfors@mocean-labs.com>
> ---
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 4b6f7cb..e60b264 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -236,7 +236,7 @@ config SPI_TXX9
>
> =A0config SPI_XILINX
> =A0 =A0 =A0 =A0tristate "Xilinx SPI controller"
> - =A0 =A0 =A0 depends on (XILINX_VIRTEX || MICROBLAZE) && EXPERIMENTAL
> + =A0 =A0 =A0 depends on EXPERIMENTAL
> =A0 =A0 =A0 =A0select SPI_BITBANG
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0This exposes the SPI controller IP from the Xilinx EDK=
.
> @@ -244,6 +244,12 @@ config SPI_XILINX
> =A0 =A0 =A0 =A0 =A0See the "OPB Serial Peripheral Interface (SPI) (v1.00e=
)"
> =A0 =A0 =A0 =A0 =A0Product Specification document (DS464) for hardware de=
tails.
>
> +config SPI_XILINX_OF
> + =A0 =A0 =A0 tristate "Xilinx SPI controller OF device"
> + =A0 =A0 =A0 depends on SPI_XILINX && (XILINX_VIRTEX || MICROBLAZE)
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 This is the OF driver for the SPI controller IP from th=
e Xilinx EDK.
> +
> =A0#
> =A0# Add new SPI master controllers in alphabetical order above this line
> =A0#
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 21a1182..97dee8f 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -31,6 +31,7 @@ obj-$(CONFIG_SPI_S3C24XX_GPIO) =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0+=3D spi_s3c24xx_gpio.o
> =A0obj-$(CONFIG_SPI_S3C24XX) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D spi_s3c24xx.=
o
> =A0obj-$(CONFIG_SPI_TXX9) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D spi_txx9.o
> =A0obj-$(CONFIG_SPI_XILINX) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D xilinx_spi.o
> +obj-$(CONFIG_SPI_XILINX_OF) =A0 =A0 =A0 =A0 =A0 =A0+=3D xilinx_spi_of.o
> =A0obj-$(CONFIG_SPI_SH_SCI) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D spi_sh_sci.o
> =A0obj-$(CONFIG_SPI_STMP3XXX) =A0 =A0 =A0 =A0 =A0 =A0 +=3D spi_stmp.o
> =A0# =A0 =A0 =A0... add above this line ...
> diff --git a/drivers/spi/xilinx_spi.c b/drivers/spi/xilinx_spi.c
> index 46b8c5c..5761a4c 100644
> --- a/drivers/spi/xilinx_spi.c
> +++ b/drivers/spi/xilinx_spi.c
> @@ -14,16 +14,14 @@
> =A0#include <linux/module.h>
> =A0#include <linux/init.h>
> =A0#include <linux/interrupt.h>
> -#include <linux/platform_device.h>
> -
> -#include <linux/of_platform.h>
> -#include <linux/of_device.h>
> -#include <linux/of_spi.h>
>
> =A0#include <linux/spi/spi.h>
> =A0#include <linux/spi/spi_bitbang.h>
> =A0#include <linux/io.h>
>
> +#include "xilinx_spi.h"
> +#include <linux/spi/xilinx_spi.h>
> +
> =A0#define XILINX_SPI_NAME "xilinx_spi"
>
> =A0/* Register definitions as per "OPB Serial Peripheral Interface (SPI) =
(v1.00e)
> @@ -78,7 +76,7 @@ struct xilinx_spi {
> =A0 =A0 =A0 =A0/* bitbang has to be first */
> =A0 =A0 =A0 =A0struct spi_bitbang bitbang;
> =A0 =A0 =A0 =A0struct completion done;
> -
> + =A0 =A0 =A0 struct resource mem; /* phys mem */
> =A0 =A0 =A0 =A0void __iomem =A0 =A0*regs; =A0/* virt. address of the cont=
rol registers */
>
> =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 irq;
> @@ -283,40 +281,22 @@ static irqreturn_t xilinx_spi_irq(int irq, void *de=
v_id)
> =A0 =A0 =A0 =A0return IRQ_HANDLED;
> =A0}
>
> -static int __init xilinx_spi_of_probe(struct of_device *ofdev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 const struct of_device_id *match)
> +struct spi_master *xilinx_spi_init(struct device *dev, struct resource *=
mem,
> + =A0 =A0 =A0 u32 irq, s16 bus_num)
> =A0{
> =A0 =A0 =A0 =A0struct spi_master *master;
> =A0 =A0 =A0 =A0struct xilinx_spi *xspi;
> - =A0 =A0 =A0 struct resource r_irq_struct;
> - =A0 =A0 =A0 struct resource r_mem_struct;
> -
> - =A0 =A0 =A0 struct resource *r_irq =3D &r_irq_struct;
> - =A0 =A0 =A0 struct resource *r_mem =3D &r_mem_struct;
> - =A0 =A0 =A0 int rc =3D 0;
> - =A0 =A0 =A0 const u32 *prop;
> - =A0 =A0 =A0 int len;
> -
> - =A0 =A0 =A0 /* Get resources(memory, IRQ) associated with the device */
> - =A0 =A0 =A0 master =3D spi_alloc_master(&ofdev->dev, sizeof(struct xili=
nx_spi));
> + =A0 =A0 =A0 struct xspi_platform_data *pdata =3D dev->platform_data;
> + =A0 =A0 =A0 int ret;
>
> - =A0 =A0 =A0 if (master =3D=3D NULL) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 dev_set_drvdata(&ofdev->dev, master);
> -
> - =A0 =A0 =A0 rc =3D of_address_to_resource(ofdev->node, 0, r_mem);
> - =A0 =A0 =A0 if (rc) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&ofdev->dev, "invalid address\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto put_master;
> + =A0 =A0 =A0 if (!pdata) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "No platform data attached\n")=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 rc =3D of_irq_to_resource(ofdev->node, 0, r_irq);
> - =A0 =A0 =A0 if (rc =3D=3D NO_IRQ) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&ofdev->dev, "no IRQ found\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto put_master;
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 master =3D spi_alloc_master(dev, sizeof(struct xilinx_spi))=
;
> + =A0 =A0 =A0 if (!master)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>
> =A0 =A0 =A0 =A0/* the spi->mode bits understood by this driver: */
> =A0 =A0 =A0 =A0master->mode_bits =3D SPI_CPOL | SPI_CPHA;
> @@ -329,128 +309,67 @@ static int __init xilinx_spi_of_probe(struct of_de=
vice *ofdev,
> =A0 =A0 =A0 =A0xspi->bitbang.master->setup =3D xilinx_spi_setup;
> =A0 =A0 =A0 =A0init_completion(&xspi->done);
>
> - =A0 =A0 =A0 xspi->irq =3D r_irq->start;
> -
> - =A0 =A0 =A0 if (!request_mem_region(r_mem->start,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r_mem->end - r_mem->start +=
 1, XILINX_SPI_NAME)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D -ENXIO;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&ofdev->dev, "memory request failu=
re\n");
> + =A0 =A0 =A0 if (!request_mem_region(mem->start, resource_size(mem),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 XILINX_SPI_NAME))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto put_master;
> - =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 xspi->regs =3D ioremap(r_mem->start, r_mem->end - r_mem->st=
art + 1);
> + =A0 =A0 =A0 xspi->regs =3D ioremap(mem->start, resource_size(mem));
> =A0 =A0 =A0 =A0if (xspi->regs =3D=3D NULL) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D -ENOMEM;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&ofdev->dev, "ioremap failure\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto release_mem;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(dev, "ioremap failure\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto map_failed;
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 xspi->irq =3D r_irq->start;
>
> - =A0 =A0 =A0 /* dynamic bus assignment */
> - =A0 =A0 =A0 master->bus_num =3D -1;
> + =A0 =A0 =A0 master->bus_num =3D bus_num;
> + =A0 =A0 =A0 master->num_chipselect =3D pdata->num_chipselect;
>
> - =A0 =A0 =A0 /* number of slave select bits is required */
> - =A0 =A0 =A0 prop =3D of_get_property(ofdev->node, "xlnx,num-ss-bits", &=
len);
> - =A0 =A0 =A0 if (!prop || len < sizeof(*prop)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&ofdev->dev, "no 'xlnx,num-ss-bits=
' property\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto unmap_io;
> - =A0 =A0 =A0 }
> - =A0 =A0 =A0 master->num_chipselect =3D *prop;
> + =A0 =A0 =A0 xspi->mem =3D *mem;
> + =A0 =A0 =A0 xspi->irq =3D irq;
>
> =A0 =A0 =A0 =A0/* SPI controller initializations */
> =A0 =A0 =A0 =A0xspi_init_hw(xspi->regs);
>
> =A0 =A0 =A0 =A0/* Register for SPI Interrupt */
> - =A0 =A0 =A0 rc =3D request_irq(xspi->irq, xilinx_spi_irq, 0, XILINX_SPI=
_NAME, xspi);
> - =A0 =A0 =A0 if (rc !=3D 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&ofdev->dev, "irq request failure:=
 %d\n", xspi->irq);
> + =A0 =A0 =A0 ret =3D request_irq(xspi->irq, xilinx_spi_irq, 0, XILINX_SP=
I_NAME, xspi);
> + =A0 =A0 =A0 if (ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto unmap_io;
> - =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 rc =3D spi_bitbang_start(&xspi->bitbang);
> - =A0 =A0 =A0 if (rc !=3D 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&ofdev->dev, "spi_bitbang_start FAI=
LED\n");
> + =A0 =A0 =A0 ret =3D spi_bitbang_start(&xspi->bitbang);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "spi_bitbang_start FAILED\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto free_irq;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 dev_info(&ofdev->dev, "at 0x%08X mapped to 0x%08X, irq=3D%d=
\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned int)r_mem->start,=
 (u32)xspi->regs, xspi->irq);
> -
> - =A0 =A0 =A0 /* Add any subnodes on the SPI bus */
> - =A0 =A0 =A0 of_register_spi_devices(master, ofdev->node);
> -
> - =A0 =A0 =A0 return rc;
> + =A0 =A0 =A0 dev_info(dev, "at 0x%08X mapped to 0x%08X, irq=3D%d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (u32)mem->start, (u32)xspi->regs, xspi->irq=
);
> + =A0 =A0 =A0 return master;
>
> =A0free_irq:
> =A0 =A0 =A0 =A0free_irq(xspi->irq, xspi);
> =A0unmap_io:
> =A0 =A0 =A0 =A0iounmap(xspi->regs);
> -release_mem:
> - =A0 =A0 =A0 release_mem_region(r_mem->start, resource_size(r_mem));
> +map_failed:
> + =A0 =A0 =A0 release_mem_region(mem->start, resource_size(mem));
> =A0put_master:
> =A0 =A0 =A0 =A0spi_master_put(master);
> - =A0 =A0 =A0 return rc;
> + =A0 =A0 =A0 return NULL;
> =A0}
> +EXPORT_SYMBOL(xilinx_spi_init);
>
> -static int __devexit xilinx_spi_remove(struct of_device *ofdev)
> +void xilinx_spi_deinit(struct spi_master *master)
> =A0{
> =A0 =A0 =A0 =A0struct xilinx_spi *xspi;
> - =A0 =A0 =A0 struct spi_master *master;
> - =A0 =A0 =A0 struct resource r_mem;
>
> - =A0 =A0 =A0 master =3D platform_get_drvdata(ofdev);
> =A0 =A0 =A0 =A0xspi =3D spi_master_get_devdata(master);
>
> =A0 =A0 =A0 =A0spi_bitbang_stop(&xspi->bitbang);
> =A0 =A0 =A0 =A0free_irq(xspi->irq, xspi);
> =A0 =A0 =A0 =A0iounmap(xspi->regs);
> - =A0 =A0 =A0 if (!of_address_to_resource(ofdev->node, 0, &r_mem))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_mem_region(r_mem.start, resource_si=
ze(&r_mem));
> - =A0 =A0 =A0 dev_set_drvdata(&ofdev->dev, 0);
> - =A0 =A0 =A0 spi_master_put(xspi->bitbang.master);
> -
> - =A0 =A0 =A0 return 0;
> -}
> -
> -/* work with hotplug and coldplug */
> -MODULE_ALIAS("platform:" XILINX_SPI_NAME);
> -
> -static int __exit xilinx_spi_of_remove(struct of_device *op)
> -{
> - =A0 =A0 =A0 return xilinx_spi_remove(op);
> -}
>
> -static struct of_device_id xilinx_spi_of_match[] =3D {
> - =A0 =A0 =A0 { .compatible =3D "xlnx,xps-spi-2.00.a", },
> - =A0 =A0 =A0 { .compatible =3D "xlnx,xps-spi-2.00.b", },
> - =A0 =A0 =A0 {}
> -};
> -
> -MODULE_DEVICE_TABLE(of, xilinx_spi_of_match);
> -
> -static struct of_platform_driver xilinx_spi_of_driver =3D {
> - =A0 =A0 =A0 .owner =3D THIS_MODULE,
> - =A0 =A0 =A0 .name =3D "xilinx-xps-spi",
> - =A0 =A0 =A0 .match_table =3D xilinx_spi_of_match,
> - =A0 =A0 =A0 .probe =3D xilinx_spi_of_probe,
> - =A0 =A0 =A0 .remove =3D __exit_p(xilinx_spi_of_remove),
> - =A0 =A0 =A0 .driver =3D {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "xilinx-xps-spi",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE,
> - =A0 =A0 =A0 },
> -};
> -
> -static int __init xilinx_spi_init(void)
> -{
> - =A0 =A0 =A0 return of_register_platform_driver(&xilinx_spi_of_driver);
> + =A0 =A0 =A0 release_mem_region(xspi->mem.start, resource_size(&xspi->me=
m));
> + =A0 =A0 =A0 spi_master_put(xspi->bitbang.master);
> =A0}
> -module_init(xilinx_spi_init);
> +EXPORT_SYMBOL(xilinx_spi_deinit);
>
> -static void __exit xilinx_spi_exit(void)
> -{
> - =A0 =A0 =A0 of_unregister_platform_driver(&xilinx_spi_of_driver);
> -}
> -module_exit(xilinx_spi_exit);
> =A0MODULE_AUTHOR("MontaVista Software, Inc. <source@mvista.com>");
> =A0MODULE_DESCRIPTION("Xilinx SPI driver");
> =A0MODULE_LICENSE("GPL");
> diff --git a/drivers/spi/xilinx_spi.h b/drivers/spi/xilinx_spi.h
> new file mode 100644
> index 0000000..d211acc
> --- /dev/null
> +++ b/drivers/spi/xilinx_spi.h
> @@ -0,0 +1,32 @@
> +/*
> + * Xilinx SPI device driver API and platform data header file
> + *
> + * Copyright (c) 2009 Intel Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#ifndef _XILINX_SPI_H_
> +#define _XILINX_SPI_H_
> +
> +#include <linux/spi/spi.h>
> +#include <linux/spi/spi_bitbang.h>
> +
> +#define XILINX_SPI_NAME "xilinx_spi"
> +
> +struct spi_master *xilinx_spi_init(struct device *dev, struct resource *=
mem,
> + =A0 =A0 =A0 u32 irq, s16 bus_num);
> +
> +void xilinx_spi_deinit(struct spi_master *master);
> +#endif
> diff --git a/drivers/spi/xilinx_spi_of.c b/drivers/spi/xilinx_spi_of.c
> new file mode 100644
> index 0000000..8c3fb54
> --- /dev/null
> +++ b/drivers/spi/xilinx_spi_of.c
> @@ -0,0 +1,136 @@
> +/*
> + * Xilinx SPI OF device driver
> + *
> + * Copyright (c) 2009 Intel Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +/* Supports:
> + * Xilinx SPI devices as OF devices
> + *
> + * Inspired by xilinx_spi.c, 2002-2007 (c) MontaVista Software, Inc.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +
> +#include <linux/of_platform.h>
> +#include <linux/of_device.h>
> +#include <linux/of_spi.h>
> +
> +#include <linux/spi/xilinx_spi.h>
> +#include "xilinx_spi.h"
> +
> +
> +static int __init xilinx_spi_of_probe(struct of_device *ofdev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 const struct of_device_id *match)
> +{
> + =A0 =A0 =A0 struct resource r_irq_struct;
> + =A0 =A0 =A0 struct resource r_mem_struct;
> + =A0 =A0 =A0 struct spi_master *master;
> +
> + =A0 =A0 =A0 struct resource *r_irq =3D &r_irq_struct;
> + =A0 =A0 =A0 struct resource *r_mem =3D &r_mem_struct;

This r_{irq,mem}_struct/*r_{irq,mem} construct is really weird (I do
understand this is just copied from the old code).  r_*_struct can
just be dropped and reference the structures with &r_irq and &_mem.

> + =A0 =A0 =A0 int rc =3D 0;
> + =A0 =A0 =A0 const u32 *prop;
> + =A0 =A0 =A0 int len;
> +
> + =A0 =A0 =A0 rc =3D of_address_to_resource(ofdev->node, 0, r_mem);
> + =A0 =A0 =A0 if (rc) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&ofdev->dev, "invalid address\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return rc;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 rc =3D of_irq_to_resource(ofdev->node, 0, r_irq);
> + =A0 =A0 =A0 if (rc =3D=3D NO_IRQ) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&ofdev->dev, "no IRQ found\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (!ofdev->dev.platform_data) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ofdev->dev.platform_data =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kzalloc(sizeof(struct xspi_=
platform_data), GFP_KERNEL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!ofdev->dev.platform_data)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }

Minor memory leak.  Anything alloced in the probe path should also be
freed in the remove path.  It's not going to spiral out of control or
anything, but it is important to be strict about such things.  Drop
the outer if{} block here and kfree platform_data on remove.

> +
> + =A0 =A0 =A0 /* number of slave select bits is required */
> + =A0 =A0 =A0 prop =3D of_get_property(ofdev->node, "xlnx,num-ss-bits", &=
len);
> + =A0 =A0 =A0 if (!prop || len < sizeof(*prop)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&ofdev->dev, "no 'xlnx,num-ss-bits=
' property\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 ofdev->dev.platform_data->num_chipselect =3D *prop;

Have you compile tested this?  platform_data is a void*, the
dereference will not work.  I know you don't have hardware; but
getting the needed cross compiler is easy.

> + =A0 =A0 =A0 master =3D xilinx_spi_init(&ofdev->dev, r_mem, r_irq->start=
, -1);
> + =A0 =A0 =A0 if (!master)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 dev_set_drvdata(&ofdev->dev, master);
> +
> + =A0 =A0 =A0 /* Add any subnodes on the SPI bus */
> + =A0 =A0 =A0 of_register_spi_devices(master, ofdev->node);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int __devexit xilinx_spi_remove(struct of_device *ofdev)
> +{
> + =A0 =A0 =A0 xilinx_spi_deinit(dev_get_drvdata(&ofdev->dev));
> + =A0 =A0 =A0 dev_set_drvdata(&ofdev->dev, 0);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int __exit xilinx_spi_of_remove(struct of_device *op)
> +{
> + =A0 =A0 =A0 return xilinx_spi_remove(op);
> +}
> +
> +static struct of_device_id xilinx_spi_of_match[] =3D {
> + =A0 =A0 =A0 { .compatible =3D "xlnx,xps-spi-2.00.a", },
> + =A0 =A0 =A0 { .compatible =3D "xlnx,xps-spi-2.00.b", },
> + =A0 =A0 =A0 {}
> +};
> +
> +MODULE_DEVICE_TABLE(of, xilinx_spi_of_match);
> +
> +static struct of_platform_driver xilinx_spi_of_driver =3D {
> + =A0 =A0 =A0 .owner =3D THIS_MODULE,
> + =A0 =A0 =A0 .name =3D "xilinx-xps-spi",

You can actually drop the above two lines.  They aren't needed.

> + =A0 =A0 =A0 .match_table =3D xilinx_spi_of_match,
> + =A0 =A0 =A0 .probe =3D xilinx_spi_of_probe,
> + =A0 =A0 =A0 .remove =3D __exit_p(xilinx_spi_of_remove),
> + =A0 =A0 =A0 .driver =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "xilinx-xps-spi",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE,
> + =A0 =A0 =A0 },
> +};

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
