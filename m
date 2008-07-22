Return-Path: <Uwe.Kleine-Koenig@digi.com>
Received: from mail164.messagelabs.com (mail164.messagelabs.com
	[216.82.253.131])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail164.messagelabs.com",
	Issuer "MessageLabs" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id EE1A3DDDF4
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 16:17:42 +1000 (EST)
Date: Tue, 22 Jul 2008 08:17:30 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>
To: Markus Brunner <super.firetwister@googlemail.com>
Subject: Re: UIO not working on ppc405 onchip registers
Message-ID: <20080722061730.GB12576@digi.com>
References: <200807212152.16080.super.firetwister@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <200807212152.16080.super.firetwister@gmail.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"linux-embedded@vger.kernel.org" <linux-embedded@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Markus,

Markus Brunner wrote:
> I'm unable to get UIO working on the ppc405ep onchip registers (e.g. gpio/iic)
> however it's working fine on peripherals.
I don't know powerpc in general nor ppc405ep in detail but IIRC arm has
problems if some memory is mapped twice.  Might this be the problem
here?

> It seems to me to be a problem with UIO on powerpc, because if I change the
> address (and nothing more) to point to a external FPGA it's working fine.
> I also tried the generic uio_pdrv which had the same problems.
> Sometimes I get a "bus error" sometimes it only produces wrong results.
> The "bus error" occurred when not a full 32 bit register was read (e.g. only a
> byte of it), but I'm not sure if it doesn't occur for other reasons as well.
Well, if this is a 32bit memory mapped device and you do a non-32 bit
access strage things can happen.

> 
> diff -upNr linux-2.6.26/drivers/uio-orig/Kconfig linux-2.6.26/drivers/uio/Kconfig
> --- linux-2.6.26/drivers/uio-orig/Kconfig       2008-07-18 09:15:51.000000000 +0200
> +++ linux-2.6.26/drivers/uio/Kconfig    2008-07-18 09:16:18.000000000 +0200
> @@ -39,4 +39,12 @@ config UIO_SMX
> 
>           If you compile this as a module, it will be called uio_smx.
> 
> +config UIO_GPIO
> +       tristate "Driver for PPC_4xx GPIO"
> +       depends on UIO
> +       default n
> +       help
> +         Driver for PPC_4xx GPIO Registers
> +
>  endif
This endif matches an "if UIO", so there is no need to depend on UIO
explicitly.

> diff -upNr linux-2.6.26/drivers/uio-orig/Makefile linux-2.6.26/drivers/uio/Makefile
> --- linux-2.6.26/drivers/uio-orig/Makefile      2008-07-18 09:27:18.000000000 +0200
> +++ linux-2.6.26/drivers/uio/Makefile   2008-07-18 09:16:50.000000000 +0200
> @@ -1,3 +1,4 @@
>  obj-$(CONFIG_UIO)      += uio.o
>  obj-$(CONFIG_UIO_CIF)  += uio_cif.o
>  obj-$(CONFIG_UIO_SMX)  += uio_smx.o
> +obj-$(CONFIG_UIO_GPIO) += uio_ppc_4xx-gpio.o
> diff -upNr linux-2.6.26/drivers/uio-orig/uio-gpio.c linux-2.6.26/drivers/uio/uio-gpio.c
> --- linux-2.6.26/drivers/uio-orig/uio-gpio.c    1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.26/drivers/uio/uio-gpio.c 2008-07-18 09:18:56.000000000 +0200
> @@ -0,0 +1,59 @@
> +#include <sys/types.h>
> +#include <sys/time.h>
> +#include <sys/stat.h>
> +#include <sys/mman.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +const unsigned long pin_mask( unsigned int pin) { return (0x80000000 >> (pin));}
> +
> +const char UIO_DEV[]  = "/dev/uio0";
> +const unsigned int UIO_SIZE =   0x1000;
> +const unsigned int UIO_ADDR = 0xef600700;
> +
> +const int  or = 0;
> +const int tcr = 1;
> +
> +const unsigned int gpio_pin = 0;        /* What gpio pin do you want to toggle? */
> +
> +volatile unsigned long *gpio_regs;
> +
> +int main(int argc, char *argv[])
> +{
> +       int uiofd = open(UIO_DEV,O_RDWR);
For debugging this is OK, in the final application you should add some
tests.  Check the UIO documentation for the details.

> +       if (uiofd < 0)
> +               return uiofd;
> +
> +       unsigned long* map_addr = mmap(NULL,
> +                                      UIO_SIZE,
> +                                      PROT_READ | PROT_WRITE,
> +                                      MAP_SHARED,
> +                                      uiofd,
> +                                      0);
> +       if (map_addr == ((unsigned long*) -1))
> +               return -1;
> [...]
> diff -upNr linux-2.6.26/drivers/uio-orig/uio_ppc_4xx-gpio.c linux-2.6.26/drivers/uio/uio_ppc_4xx-gpio.c
> --- linux-2.6.26/drivers/uio-orig/uio_ppc_4xx-gpio.c    1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.26/drivers/uio/uio_ppc_4xx-gpio.c 2008-07-18 09:23:32.000000000 +0200
> @@ -0,0 +1,74 @@
> +/*
> + * simple UIO GPIO driver.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/uio_driver.h>
> +
> +#include <asm/io.h>
> +
> +static struct uio_info info = {
> +       .name = "uio_gpio",
> +       .version = "0.0.0",
> +       .irq = UIO_IRQ_NONE,
> +       .irq_flags = 0,
> +        .mem[0].addr = 0xef600700,
> +        .mem[0].size = 0x1000,
> +       .mem[0].memtype = UIO_MEM_PHYS,
> +};
IIRC you should initialise the other mem members.

> +static int __devinit uio_gpio_probe(struct device *dev)
> +{
> +       if (uio_register_device(dev, &info)){
> +               printk(KERN_ERR "uio_gpio: uio_register_device failed\n");
> +               return -ENODEV;
> +       }
> +       return 0;
> +}
> +
> +static int uio_gpio_remove(struct device *dev)
> +{
> +       uio_unregister_device(&info);
> +       info.mem[0].addr = 0;
> +       info.mem[0].size = 0;
> +       return 0;
> +}
Are you sure that overwriting info.mem[0].addr is a good idea?  Then
unbinding the platform device and rebinding it fails to do the right
thing for sure.

> +static struct platform_device *uio_gpio_device;
> +
> +static struct device_driver uio_gpio_driver = {
> +       .name           = "uio_gpio",
> +       .bus            = &platform_bus_type,
> +       .probe          = uio_gpio_probe,
> +       .remove         = uio_gpio_remove,
> +};
> +
> +
> +static int __init uio_gpio_init(void)
> +{
> +       uio_gpio_device = platform_device_register_simple("uio_gpio", -1,
> +                                                          NULL, 0);
> +       if (IS_ERR(uio_gpio_device))
> +               return PTR_ERR(uio_gpio_device);
> +
> +       return driver_register(&uio_gpio_driver);
> +}
> +
> +static void __exit uio_gpio_exit(void)
> +{
> +       platform_device_unregister(uio_gpio_device);
> +       driver_unregister(&uio_gpio_driver);
> +}
> +
> +module_init(uio_gpio_init);
> +module_exit(uio_gpio_exit);
> +
> +MODULE_LICENSE("GPL");
The header says this is GPL v2.  So you should use "GPL v2" here, too.

Best regards
Uwe

-- 
Uwe Kleine-König, Software Engineer
Digi International GmbH Branch Breisach, Küferstrasse 8, 79206 Breisach, Germany
Tax: 315/5781/0242 / VAT: DE153662976 / Reg. Amtsgericht Dortmund HRB 13962
