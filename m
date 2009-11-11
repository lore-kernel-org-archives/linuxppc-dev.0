Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f199.google.com (mail-yw0-f199.google.com
	[209.85.211.199]) by ozlabs.org (Postfix) with ESMTP id E4346B7088
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Nov 2009 08:03:47 +1100 (EST)
Received: by ywh37 with SMTP id 37so1488791ywh.17
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Nov 2009 13:03:46 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4AFACC55.3010802@mocean-labs.com>
References: <4AFACC55.3010802@mocean-labs.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 11 Nov 2009 14:03:26 -0700
Message-ID: <fa686aa40911111303q1cdbaf52vd3d34575b3ed0eaa@mail.gmail.com>
Subject: Re: [PATCH 1/4] xilinx_spi: Split into of driver and generic part.
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

On Wed, Nov 11, 2009 at 7:38 AM, Richard R=F6jfors
<richard.rojfors@mocean-labs.com> wrote:
> This patch splits the xilinx_spi driver into a generic part and a
> OF driver part.
>
> The reason for this is to later add in a platform driver as well.

Hey Richard,

Thanks for the quick response.  A couple of important comments, and a
bunch of nitpicks.  Comments below.

> diff --git a/drivers/spi/xilinx_spi.c b/drivers/spi/xilinx_spi.c
> index 46b8c5c..1562e9b 100644
> --- a/drivers/spi/xilinx_spi.c
> +++ b/drivers/spi/xilinx_spi.c
> @@ -14,11 +14,6 @@
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
> @@ -78,7 +73,7 @@ struct xilinx_spi {
> =A0 =A0 =A0 =A0/* bitbang has to be first */
> =A0 =A0 =A0 =A0struct spi_bitbang bitbang;
> =A0 =A0 =A0 =A0struct completion done;
> -
> + =A0 =A0 =A0 struct resource mem; /* phys mem */
> =A0 =A0 =A0 =A0void __iomem =A0 =A0*regs; =A0/* virt. address of the cont=
rol registers */
>
> =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 irq;
> @@ -283,40 +278,17 @@ static irqreturn_t xilinx_spi_irq(int irq, void *de=
v_id)
> =A0 =A0 =A0 =A0return IRQ_HANDLED;
> =A0}
>
> -static int __init xilinx_spi_of_probe(struct of_device *ofdev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 const struct of_device_id *match)
> +struct spi_master *xilinx_spi_init(struct device *dev, struct resource *=
mem,
> + =A0 =A0 =A0 u32 irq, s16 bus_num, u16 num_chipselect)

Nit: I personally prefer like _setup and _teardown instead of _init
and _deinit; but that's just me.  (and bike sheds should be blue)

Also, in patch 4/4, a new platform_data structure is defined.  The
platform probe routine extracts the pdata and passes each item
individually to _init.  The of_driver probe does the same, except it
extracts the data from the device tree.  That is also the approach
that I used to take when writing drivers with multiple bindings.
However, it becomes a problem as a driver matures and more and more
data needs to be passed.

Instead, how about getting the of_driver probe to allocate and
populate the pdata structure and stow it in of_dev->dev.platform_data.
 That way the _init function signature stays sane, the platform driver
code becomes simpler, and the driver is better prepared to handle the
eventual deprecation of the of_platform bus.

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
> + =A0 =A0 =A0 int ret =3D 0;
>
> - =A0 =A0 =A0 /* Get resources(memory, IRQ) associated with the device */
> - =A0 =A0 =A0 master =3D spi_alloc_master(&ofdev->dev, sizeof(struct xili=
nx_spi));
> -
> - =A0 =A0 =A0 if (master =3D=3D NULL) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 master =3D spi_alloc_master(dev, sizeof(struct xilinx_spi))=
;
>
> - =A0 =A0 =A0 dev_set_drvdata(&ofdev->dev, master);
> -
> - =A0 =A0 =A0 rc =3D of_address_to_resource(ofdev->node, 0, r_mem);
> - =A0 =A0 =A0 if (rc) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&ofdev->dev, "invalid address\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto put_master;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 rc =3D of_irq_to_resource(ofdev->node, 0, r_irq);
> - =A0 =A0 =A0 if (rc =3D=3D NO_IRQ) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&ofdev->dev, "no IRQ found\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto put_master;
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (master =3D=3D NULL)

Nit: 'if (!master)' is a pretty well accepted idiom.

> @@ -329,128 +301,70 @@ static int __init xilinx_spi_of_probe(struct of_de=
vice *ofdev,
[...]
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
> + =A0 =A0 =A0 return ERR_PTR(ret);

The SPI subsystem does not use the ERR_PTR() pattern, and errors are
already printed to the console when a failure occurs.  Please return
NULL on failure so that the driver isn't mixing idioms.

> diff --git a/drivers/spi/xilinx_spi.h b/drivers/spi/xilinx_spi.h
> new file mode 100644
> index 0000000..84c98ee
> --- /dev/null
> +++ b/drivers/spi/xilinx_spi.h
> @@ -0,0 +1,31 @@
> +/*
> + * xilinx_spi.h

Nit: filename is kind of meaningless.  Say what that file /is/ instead.
ie: * Xilinx SPI device driver API and platform data header file

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
> +#define _XILINX_SPI_H_ 1

Nit: The '1' is unnecessary

> +
> +#include <linux/spi/spi.h>
> +#include <linux/spi/spi_bitbang.h>
> +
> +#define XILINX_SPI_NAME "xilinx_spi"
> +
> +struct spi_master *xilinx_spi_init(struct device *dev, struct resource *=
mem,
> + =A0 =A0 =A0 u32 irq, s16 bus_num, u16 num_chipselect);
> +
> +void xilinx_spi_deinit(struct spi_master *master);
> +#endif
> diff --git a/drivers/spi/xilinx_spi_of.c b/drivers/spi/xilinx_spi_of.c
> new file mode 100644
> index 0000000..5440253
> --- /dev/null
> +++ b/drivers/spi/xilinx_spi_of.c
> @@ -0,0 +1,126 @@
> +/*
> + * xilinx_spi_of.c Support for Xilinx SPI OF devices

Ditto nit here.

Looking good.  Thanks for this work.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
