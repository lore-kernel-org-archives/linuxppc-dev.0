Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 757D3DE0B6
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Sep 2008 02:16:10 +1000 (EST)
Date: Fri, 5 Sep 2008 20:16:07 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH] powerpc: gpio driver for mpc831x/834x/837x with OF
	bindings
Message-ID: <20080905161607.GA10826@oksana.dev.rtsoft.ru>
References: <1220627327-28852-1-git-send-email-jacmet@sunsite.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <1220627327-28852-1-git-send-email-jacmet@sunsite.dk>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 05, 2008 at 05:08:47PM +0200, Peter Korsgaard wrote:
> Structured similar to the existing QE GPIO support.
> 
> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
> ---

I posted identical driver in June. ;-)

http://ozlabs.org/pipermail/linuxppc-dev/2008-June/057395.html

>  .../powerpc/dts-bindings/fsl/83xx_gpio.txt         |   33 +++++
>  arch/powerpc/sysdev/Kconfig                        |    9 ++
>  arch/powerpc/sysdev/Makefile                       |    1 +
>  arch/powerpc/sysdev/mpc83xx_gpio.c                 |  141 ++++++++++++++++++++
>  4 files changed, 184 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/powerpc/dts-bindings/fsl/83xx_gpio.txt
>  create mode 100644 arch/powerpc/sysdev/mpc83xx_gpio.c
> 
> diff --git a/Documentation/powerpc/dts-bindings/fsl/83xx_gpio.txt b/Documentation/powerpc/dts-bindings/fsl/83xx_gpio.txt
> new file mode 100644
> index 0000000..f43f048
> --- /dev/null
> +++ b/Documentation/powerpc/dts-bindings/fsl/83xx_gpio.txt
> @@ -0,0 +1,33 @@
> +GPIO controllers on MPC831x/834x/837x SoCs
> +
> +Every GPIO controller node must have #gpio-cells property defined,
> +this information will be used to translate gpio-specifiers.
> +
> +Required properties:
> +- compatible : "fsl,mpc8349-gpio"
> +- #gpio-cells : Should be two. The first cell is the pin number and the
> +  second cell is used to specify optional parameters (currently unused).
> + - interrupts : Interrupt mapping for GPIO IRQ (currently unused).
> + - interrupt-parent : Phandle for the interrupt controller that
> +   services interrupts for this device.
> +- gpio-controller : Marks the port as GPIO controller.
> +
> +Example of gpio-controller nodes for a MPC8349 SoC:
> +
> +	gpio1: gpio-controller@c00 {
> +		#gpio-cells = <2>;
> +		compatible = "fsl,mpc8349-gpio";
> +		reg = <0xc00 0x100>;
> +		interrupts = <74 0x8>;
> +		interrupt-parent = <&ipic>;
> +		gpio-controller;
> +	};
> +
> +	gpio2: gpio-controller@d00 {
> +		#gpio-cells = <2>;
> +		compatible = "fsl,mpc8349-gpio";
> +		reg = <0xd00 0x100>;
> +		interrupts = <75 0x8>;
> +		interrupt-parent = <&ipic>;
> +		gpio-controller;
> +	};
> diff --git a/arch/powerpc/sysdev/Kconfig b/arch/powerpc/sysdev/Kconfig
> index 72fb35b..d28c3c5 100644
> --- a/arch/powerpc/sysdev/Kconfig
> +++ b/arch/powerpc/sysdev/Kconfig
> @@ -6,3 +6,12 @@ config PPC4xx_PCI_EXPRESS
>  	bool
>  	depends on PCI && 4xx
>  	default n
> +
> +config MPC83xx_GPIO
> +	bool "MPC83xx GPIO support"
> +	depends on PPC_MPC831x || PPC_MPC834x || PPC_MPC837x
> +	select GENERIC_GPIO
> +	select ARCH_REQUIRE_GPIOLIB
> +	help
> +	  Say Y here if you're going to use hardware that connects to the
> +	  MPC831x/834x/837x GPIOs.
> diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
> index a90054b..ced5793 100644
> --- a/arch/powerpc/sysdev/Makefile
> +++ b/arch/powerpc/sysdev/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
>  obj-$(CONFIG_FSL_PCI)		+= fsl_pci.o $(fsl-msi-obj-y)
>  obj-$(CONFIG_FSL_LBC)		+= fsl_lbc.o
>  obj-$(CONFIG_FSL_GTM)		+= fsl_gtm.o
> +obj-$(CONFIG_MPC83xx_GPIO)	+= mpc83xx_gpio.o
>  obj-$(CONFIG_RAPIDIO)		+= fsl_rio.o
>  obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o
>  obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
> diff --git a/arch/powerpc/sysdev/mpc83xx_gpio.c b/arch/powerpc/sysdev/mpc83xx_gpio.c
> new file mode 100644
> index 0000000..a8a132d
> --- /dev/null
> +++ b/arch/powerpc/sysdev/mpc83xx_gpio.c
> @@ -0,0 +1,141 @@
> +/*
> + * GPIOs on MPC831x/834x/837x
> + *
> + * Copyright (C) 2008 Peter Korsgaard <jacmet@sunsite.dk>
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/spinlock.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
> +#include <linux/gpio.h>
> +
> +#define GPIO_DIR	0x00
> +#define GPIO_ODR	0x04
> +#define GPIO_DAT	0x08
> +#define GPIO_IER	0x0c
> +#define GPIO_IMR	0x10
> +#define GPIO_ICR	0x14
> +
> +struct mpc83xx_gpio_chip {
> +	struct of_mm_gpio_chip mm_gc;
> +	spinlock_t lock;
> +};
> +
> +static inline struct mpc83xx_gpio_chip *
> +to_mpc83xx_gpio_chip(struct of_mm_gpio_chip *mm)
> +{
> +	return container_of(mm, struct mpc83xx_gpio_chip, mm_gc);
> +}
> +
> +static int mpc83xx_gpio_get(struct gpio_chip *gc, unsigned int gpio)
> +{
> +	struct of_mm_gpio_chip *mm = to_of_mm_gpio_chip(gc);
> +	u32 bit = 1u << (31-gpio);
> +
> +	return !!(in_be32(mm->regs + GPIO_DAT) & bit);
> +}
> +
> +static void mpc83xx_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
> +{
> +	struct of_mm_gpio_chip *mm = to_of_mm_gpio_chip(gc);
> +	struct mpc83xx_gpio_chip *mpc83xx_gc = to_mpc83xx_gpio_chip(mm);
> +	unsigned long flags;
> +	u32 data, bit = 1u << (31-gpio);
> +
> +	spin_lock_irqsave(&mpc83xx_gc->lock, flags);
> +
> +	data = in_be32(mm->regs + GPIO_DAT);
> +	if (val)
> +		data |= bit;
> +	else
> +		data &= ~bit;
> +	out_be32(mm->regs + GPIO_DAT, data);
> +
> +	spin_unlock_irqrestore(&mpc83xx_gc->lock, flags);
> +}
> +
> +static int mpc83xx_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
> +{
> +	struct of_mm_gpio_chip *mm = to_of_mm_gpio_chip(gc);
> +	struct mpc83xx_gpio_chip *mpc83xx_gc = to_mpc83xx_gpio_chip(mm);
> +	unsigned long flags;
> +	u32 bit = 1u << (31-gpio);
> +
> +	spin_lock_irqsave(&mpc83xx_gc->lock, flags);
> +
> +	out_be32(mm->regs + GPIO_DIR,
> +		 in_be32(mm->regs + GPIO_DIR) & ~bit);
> +
> +	spin_unlock_irqrestore(&mpc83xx_gc->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int mpc83xx_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
> +{
> +	struct of_mm_gpio_chip *mm = to_of_mm_gpio_chip(gc);
> +	struct mpc83xx_gpio_chip *mpc83xx_gc = to_mpc83xx_gpio_chip(mm);
> +	unsigned long flags;
> +	u32 bit = 1u << (31-gpio);
> +
> +	mpc83xx_gpio_set(gc, gpio, val);
> +
> +	spin_lock_irqsave(&mpc83xx_gc->lock, flags);
> +	out_be32(mm->regs + GPIO_DIR,
> +		 in_be32(mm->regs + GPIO_DIR) | bit);
> +
> +	spin_unlock_irqrestore(&mpc83xx_gc->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int __init mpc83xx_add_gpiochips(void)
> +{
> +	struct device_node *np;
> +
> +	for_each_compatible_node(np, NULL, "fsl,mpc8349-gpio") {
> +		int ret;
> +		struct mpc83xx_gpio_chip *mpc83xx_gc;
> +		struct of_mm_gpio_chip *mm_gc;
> +		struct of_gpio_chip *of_gc;
> +		struct gpio_chip *gc;
> +
> +		mpc83xx_gc = kzalloc(sizeof(*mpc83xx_gc), GFP_KERNEL);
> +		if (!mpc83xx_gc) {
> +			ret = -ENOMEM;
> +			goto err;
> +		}
> +
> +		spin_lock_init(&mpc83xx_gc->lock);
> +
> +		mm_gc = &mpc83xx_gc->mm_gc;
> +		of_gc = &mm_gc->of_gc;
> +		gc = &of_gc->gc;
> +
> +		of_gc->gpio_cells = 2;
> +		gc->ngpio = 32;
> +		gc->direction_input = mpc83xx_gpio_dir_in;
> +		gc->direction_output = mpc83xx_gpio_dir_out;
> +		gc->get = mpc83xx_gpio_get;
> +		gc->set = mpc83xx_gpio_set;
> +
> +		ret = of_mm_gpiochip_add(np, mm_gc);
> +		if (ret)
> +			goto err;
> +		continue;
> +err:
> +		pr_err("%s: registration failed with status %d\n",
> +		       np->full_name, ret);
> +		kfree(mpc83xx_gc);
> +		/* try others anyway */
> +	}
> +	return 0;
> +}
> +arch_initcall(mpc83xx_add_gpiochips);
> -- 
> 1.5.6.3
> 

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
