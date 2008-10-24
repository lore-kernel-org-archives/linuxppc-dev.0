Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 75335DDDEA
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 08:42:00 +1100 (EST)
Date: Sat, 25 Oct 2008 01:41:59 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: John Linn <john.linn@xilinx.com>
Subject: Re: [PATCH] [powerpc] GPIO: Adding new Xilinx driver
Message-ID: <20081024214159.GA15204@oksana.dev.rtsoft.ru>
References: <20081024195908.7D1A1142806C@mail74-wa4.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20081024195908.7D1A1142806C@mail74-wa4.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, Kiran Sutariya <kirans@xilinx.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 24, 2008 at 12:59:00PM -0700, John Linn wrote:
> This driver supports the Xilinx XPS GPIO IP core which has the typical
> GPIO features.
> 
> Signed-off-by: Kiran Sutariya <kirans@xilinx.com>
> Signed-off-by: John Linn <john.linn@xilinx.com>

Looks good. Just few comments below.

> ---
>  drivers/gpio/Kconfig       |    8 ++
>  drivers/gpio/Makefile      |    1 +
>  drivers/gpio/xilinx_gpio.c |  240 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 249 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/gpio/xilinx_gpio.c
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 7f2ee27..f6b0da8 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -65,6 +65,14 @@ config GPIO_SYSFS
>  
>  # put expanders in the right section, in alphabetical order
>  
> +comment "Memory mapped GPIO expanders:"
> +
> +config GPIO_XILINX
> +	bool "Xilinx GPIO support"
> +	depends on OF

I persume that the driver wasn't build-tested on SPARC, so I'd recommend
to change the depends to PPC_OF. Plus, the driver should also select
GENERIC_GPIO and ARCH_REQUIRE_GPIOLIB. (Later we'll switch to
ARCH_WANT_OPTIONAL_GPIOLIB for whole PPC.)

> +	help
> +	  Say yes here to support the Xilinx FPGA GPIO device

If nothing has changed, we should place the arch-specific GPIO
drivers into the arch/. So, Kconfig entry should go into the
arch/powerpc/platforms/Kconfig.

and the driver itself into arch/powerpc/sysdev/.

> @@ -0,0 +1,240 @@
> +/*
> + * Xilinx gpio driver
> + *
> + * Copyright 2008 Xilinx, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2
> + * as published by the Free Software Foundation.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */

#include <linux/init.h>
#include <linux/errno.h>
#include <linux/gpio.h>

> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_gpio.h>
> +#include <linux/io.h>
> +#include <linux/gpio.h>
> +

[...]
> +	spin_lock_init(&chip->gpio_lock);
> +
> +	ofchip->gpio_cells = 2;
> +	ofchip->gc.direction_input = xgpio_dir_in;
> +	ofchip->gc.direction_output = xgpio_dir_out;
> +	ofchip->gc.get = xgpio_get;
> +	ofchip->gc.set = xgpio_set;
> +
> +	/* Call the OF gpio helper to setup and register the GPIO device */
> +	status = of_mm_gpiochip_add(ofdev->node, &chip->mmchip);
> +	if (status) {
> +		kfree(chip);
> +		dev_err(&ofdev->dev, "Error in probe function error value %d\n",
> +			status);
> +		return status;
> +	}

At this point the GPIO controller is registered, so somebody
might already request and work with the GPIOs...

> +	/* Finally, write the initial state to the device */
> +	out_be32(chip->mmchip.regs + XGPIO_DATA_OFFSET, chip->gpio_state);
> +	out_be32(chip->mmchip.regs + XGPIO_TRI_OFFSET, chip->gpio_dir);

But initial values were set up just now, after the registration.

There is the `save_regs' callback in the of_mm_gpio_chip structure,
it is used exactly to avoid this situation.

> +	dev_info(&ofdev->dev, "registered Xilinx GPIO controller\n");
> +	return 0;
> +}
> +
> +/**
> + * xgpio_of_remove - Remove method for the GPIO device.
> + * @of_dev: pointer to OF device structure.
> + *
> + * This function returns a negative error as we cannot unregister GPIO chips.
> + */
> +static int __devexit xgpio_of_remove(struct of_device *ofdev)
> +{
> +	return -EBUSY;
> +}
> +
> +static struct of_device_id xgpio_of_match[] __devinitdata = {
> +	{ .compatible = "xlnx,xps-gpio-1.00.a", },
> +	{ /* end of list */ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, xgpio_of_match);
> +
> +static struct of_platform_driver xgpio_of_driver = {

There is no much point in doing the of_platform_driver for the
SOC GPIOs. More than that, of_platform bus is probed at the
device_initcall time, so there is also no point in the subsys_initcall
for this driver.

I'd recommend to do the registration as in
arch/powerpc/sysdev/qe_lib/gpio.c.

> +	.name = "xilinx_gpio",
> +	.match_table = xgpio_of_match,
> +	.probe = xgpio_of_probe,
> +	.remove = __devexit_p(xgpio_of_remove),
> +};
> +
> +static int __init xgpio_init(void)
> +{
> +	return of_register_platform_driver(&xgpio_of_driver);
> +}
> +
> +/* Make sure we get initialized before anyone else tries to use us */
> +subsys_initcall(xgpio_init);
> +/* No exit call at the moment as we cannot unregister of GPIO chips */

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
