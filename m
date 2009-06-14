Return-Path: <hjk@linutronix.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A47BDB70E5
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 14 Jun 2009 22:21:58 +1000 (EST)
Date: Sun, 14 Jun 2009 14:21:36 +0200
From: "Hans J. Koch" <hjk@linutronix.de>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 2/2] uio: add an of_genirq driver
Message-ID: <20090614122136.GD3639@local>
References: <1244765062-14144-1-git-send-email-w.sang@pengutronix.de>
	<1244765062-14144-3-git-send-email-w.sang@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1244765062-14144-3-git-send-email-w.sang@pengutronix.de>
Cc: devicetree-discuss@ozlabs.org, "Hans J. Koch" <hjk@linutronix.de>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Greg KH <gregkh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 12, 2009 at 02:04:22AM +0200, Wolfram Sang wrote:
> Picking up the now exported generic probe function from the
> platform-variant of this driver, this patch adds an of-version. Also add
> the binding documentation.

Some minor problems, see below.

> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Hans J. Koch <hjk@linutronix.de>
> Cc: Greg KH <gregkh@suse.de>
> ---
> 
> In probe, I put the resources-array on the stack to simplify the code. If this
> is considered too huge for the stack (140 byte for a 32-bit system at the
> moment), I can also post a version using kzalloc.
> 
>  Documentation/powerpc/dts-bindings/uio-generic.txt |   16 +++
>  drivers/uio/Kconfig                                |    6 +
>  drivers/uio/Makefile                               |    1 +
>  drivers/uio/uio_of_genirq.c                        |   98 ++++++++++++++++++++
>  4 files changed, 121 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/powerpc/dts-bindings/uio-generic.txt
>  create mode 100644 drivers/uio/uio_of_genirq.c
> 
> diff --git a/Documentation/powerpc/dts-bindings/uio-generic.txt b/Documentation/powerpc/dts-bindings/uio-generic.txt
> new file mode 100644
> index 0000000..8ad9861
> --- /dev/null
> +++ b/Documentation/powerpc/dts-bindings/uio-generic.txt
> @@ -0,0 +1,16 @@
> +UIO for custom devices
> +
> +A device which will be mapped using the UIO subsystem.
> +
> +Properties:
> + - compatible : should contain the specific model used, followed by
> +                "generic-uio".
> + - reg : address range(s) of the device (up to MAX_UIO_MAPS)
> + - interrupts : interrupt of the device
> +
> +Example:
> +        c64fpga@0 {
> +                compatible = "ptx,c64fpga001", "generic-uio";
> +                reg = <0x0 0x10000>;
> +                interrupts = <0 0 3>;
> +        };
> diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
> index 7f86534..18efe38 100644
> --- a/drivers/uio/Kconfig
> +++ b/drivers/uio/Kconfig
> @@ -46,6 +46,12 @@ config UIO_PDRV_GENIRQ
>  
>  	  If you don't know what to do here, say N.
>  
> +config UIO_OF_GENIRQ
> +	tristate "Userspace I/O OF driver with generic IRQ handling"
> +	depends on UIO_PDRV_GENIRQ && OF
> +	help
> +	  OF wrapper for the above platform driver.
> +
>  config UIO_SMX
>  	tristate "SMX cryptengine UIO interface"
>  	default n
> diff --git a/drivers/uio/Makefile b/drivers/uio/Makefile
> index 5c2586d..089fd56 100644
> --- a/drivers/uio/Makefile
> +++ b/drivers/uio/Makefile
> @@ -2,6 +2,7 @@ obj-$(CONFIG_UIO)	+= uio.o
>  obj-$(CONFIG_UIO_CIF)	+= uio_cif.o
>  obj-$(CONFIG_UIO_PDRV)	+= uio_pdrv.o
>  obj-$(CONFIG_UIO_PDRV_GENIRQ)	+= uio_pdrv_genirq.o
> +obj-$(CONFIG_UIO_OF_GENIRQ)	+= uio_of_genirq.o
>  obj-$(CONFIG_UIO_SMX)	+= uio_smx.o
>  obj-$(CONFIG_UIO_AEC)	+= uio_aec.o
>  obj-$(CONFIG_UIO_SERCOS3)	+= uio_sercos3.o
> diff --git a/drivers/uio/uio_of_genirq.c b/drivers/uio/uio_of_genirq.c
> new file mode 100644
> index 0000000..254ec5b
> --- /dev/null
> +++ b/drivers/uio/uio_of_genirq.c
> @@ -0,0 +1,98 @@
> +/*
> + * OF wrapper to make use of the uio_pdrv_genirq-driver.
> + *
> + * Copyright (C) 2009 Wolfram Sang, Pengutronix
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/uio_driver.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/uio_pdrv_genirq.h>
> +
> +#define OF_DRIVER_VERSION "1"
> +
> +static __devinit int uio_of_genirq_probe(struct of_device *op,
> +		const struct of_device_id *match)
> +{
> +	struct uio_info *uioinfo;
> +	struct resource resources[MAX_UIO_MAPS];
> +	int i, ret;
> +
> +	uioinfo = kzalloc(sizeof(*uioinfo), GFP_KERNEL);
> +	if (!uioinfo)
> +		return -ENOMEM;
> +
> +	uioinfo->name = op->node->name;
> +	uioinfo->version = OF_DRIVER_VERSION;
> +	uioinfo->irq = irq_of_parse_and_map(op->node, 0);
> +	if (!uioinfo->irq)
> +		uioinfo->irq = UIO_IRQ_NONE;

Please don't do this. It's inconsistent if all other UIO drivers require
people to use UIO_IRQ_NONE and you also allow zero. UIO_IRQ_NONE was
introduced because 0 may be a legal interrupt number on some platforms.

> +
> +	for (i = 0; i < MAX_UIO_MAPS; ++i)
> +		if (of_address_to_resource(op->node, i, &resources[i]))
> +			break;
> +
> +	ret = __uio_pdrv_genirq_probe(&op->dev, uioinfo, &resources, i);
> +	if (ret)
> +		goto err_cleanup;
> +
> +	return 0;
> +
> +err_cleanup:
> +	if (uioinfo->irq != UIO_IRQ_NONE)
> +		irq_dispose_mapping(uioinfo->irq);
> +
> +	kfree(uioinfo);
> +	return ret;
> +}
> +
> +static __devexit int uio_of_genirq_remove(struct of_device *op)
> +{
> +	struct uio_pdrv_genirq_platdata *priv = dev_get_drvdata(&op->dev);
> +
> +	uio_unregister_device(priv->uioinfo);
> +
> +	if (priv->uioinfo->irq != UIO_IRQ_NONE)
> +		irq_dispose_mapping(priv->uioinfo->irq);
> +
> +	kfree(priv->uioinfo);
> +	kfree(priv);
> +	return 0;
> +}
> +
> +/* Match table for of_platform binding */
> +static const struct of_device_id __devinitconst uio_of_genirq_match[] = {

checkpatch.pl complains about that. Please check.

> +	{ .compatible = "generic-uio", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, uio_of_genirq_match);
> +
> +static struct of_platform_driver uio_of_genirq_driver = {
> +	.owner = THIS_MODULE,
> +	.name = "uio-of-genirq",
> +	.match_table = uio_of_genirq_match,
> +	.probe = uio_of_genirq_probe,
> +	.remove = __devexit_p(uio_of_genirq_remove),
> +};
> +
> +static inline int __init uio_of_genirq_init(void)
> +{
> +	return of_register_platform_driver(&uio_of_genirq_driver);
> +}
> +module_init(uio_of_genirq_init);
> +
> +static inline void __exit uio_of_genirq_exit(void)
> +{
> +	of_unregister_platform_driver(&uio_of_genirq_driver);
> +}
> +module_exit(uio_of_genirq_exit);
> +
> +MODULE_AUTHOR("Wolfram Sang");
> +MODULE_DESCRIPTION("Userspace I/O OF driver with generic IRQ handling");
> +MODULE_LICENSE("GPL v2");
> -- 
> 1.6.3.1
