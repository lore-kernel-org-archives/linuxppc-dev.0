Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 62BFCDE568
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 05:46:53 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: PPC440EPx gpio driver
Date: Thu, 9 Oct 2008 20:46:44 +0200
References: <48ED1E96.4060406@harris.com>
	<20081009173810.GA14959@oksana.dev.rtsoft.ru>
	<48EE47C1.1000303@harris.com>
In-Reply-To: <48EE47C1.1000303@harris.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810092046.44665.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Steve,

On Thursday 09 October 2008, Steven A. Falco wrote:
> I've moved the config variable to platforms/44x, and added the #include
> of linux/types.h.
>
> Since I don't have any PPC405 boards, I am unable to test with that CPU.
> So, I am reluctant to add the config variable to platforms/40x.  It
> would be trivial to add, if someone else has a suitable setup and could
> run a test.

Yes, please add it and I'll run a test tomorrow on my 405EP system.

It would be great if you could generate a git style patch where you put the 
patch description on top of the mail and can put those comments (like changes 
between versions) below the "---" line. Those comments will not appear in the 
git history after applying. And then please add a version number to the 
subject. Example:

[PATCH v2] powerpc/4xx: Add 4xx gpio driver

Some more comments below.

> Signed-off-by: Steve Falco <sfalco at harris.com>
>
> diff --git a/arch/powerpc/include/asm/ppc4xx.h
> b/arch/powerpc/include/asm/ppc4xx.h index 033039a..589ff5c 100644
> --- a/arch/powerpc/include/asm/ppc4xx.h
> +++ b/arch/powerpc/include/asm/ppc4xx.h
> @@ -13,6 +13,30 @@
>  #ifndef __ASM_POWERPC_PPC4xx_H__
>  #define __ASM_POWERPC_PPC4xx_H__
>
> +#include <linux/types.h>
> +
> +/* GPIO */
> +struct ppc4xx_gpio {
> +	__be32 gpio_or;
> +	__be32 gpio_tcr;
> +	__be32 gpio_osrl;
> +	__be32 gpio_osrh;
> +	__be32 gpio_tsrl;
> +	__be32 gpio_tsrh;
> +	__be32 gpio_odr;
> +	__be32 gpio_ir;
> +	__be32 gpio_rr1;
> +	__be32 gpio_rr2;
> +	__be32 gpio_rr3;
> +	__be32 reserved1;
> +	__be32 gpio_isr1l;
> +	__be32 gpio_isr1h;
> +	__be32 gpio_isr2l;
> +	__be32 gpio_isr2h;
> +	__be32 gpio_isr3l;
> +	__be32 gpio_isr3h;
> +};
> +

Not sure if we really need those defines in this header. They are only 
referenced by the gpio driver so why not move it to the driver instead?

>  extern void ppc4xx_reset_system(char *cmd);
>
>  #endif /* __ASM_POWERPC_PPC4xx_H__ */
> diff --git a/arch/powerpc/platforms/44x/Kconfig
> b/arch/powerpc/platforms/44x/Kconfig index 249ba01..eec5cb4 100644
> --- a/arch/powerpc/platforms/44x/Kconfig
> +++ b/arch/powerpc/platforms/44x/Kconfig
> @@ -127,6 +143,14 @@ config XILINX_VIRTEX440_GENERIC_BOARD
>  	  Most Virtex 5 designs should use this unless it needs to do some
>  	  special configuration at board probe time.
>
> +config PPC4xx_GPIO
> +	bool "PPC4xx GPIO support"
> +	depends on 44x
> +	select ARCH_REQUIRE_GPIOLIB
> +	select GENERIC_GPIO
> +	help
> +	  Enable gpiolib support for ppc440 based boards
> +

Please add gpio support for 40x as well. I'll test it tomorrow.

>  # 44x specific CPU modules, selected based on the board above.
>  config 440EP
>  	bool
> diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
> index a90054b..35d5765 100644
> --- a/arch/powerpc/sysdev/Makefile
> +++ b/arch/powerpc/sysdev/Makefile
> @@ -35,6 +35,7 @@ obj-$(CONFIG_OF_RTC)		+= of_rtc.o
>  ifeq ($(CONFIG_PCI),y)
>  obj-$(CONFIG_4xx)		+= ppc4xx_pci.o
>  endif
> +obj-$(CONFIG_PPC4xx_GPIO)	+= ppc4xx_gpio.o
>
>  # Temporary hack until we have migrated to asm-powerpc
>  ifeq ($(ARCH),powerpc)
> diff --git a/arch/powerpc/sysdev/ppc4xx_gpio.c
> b/arch/powerpc/sysdev/ppc4xx_gpio.c new file mode 100644
> index 0000000..d401eba
> --- /dev/null
> +++ b/arch/powerpc/sysdev/ppc4xx_gpio.c
> @@ -0,0 +1,239 @@
> +/*
> + * PPC4xx gpio driver
> + *
> + * Copyright (c) 2008 Harris Corporation
> + * Copyright (c) 2008 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
> + * Copyright (c) MontaVista Software, Inc. 2008.
> + *
> + * Author: Steve Falco <sfalco@harris.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2
> + * as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 
> USA + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/spinlock.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
> +#include <linux/gpio.h>
> +#include <linux/types.h>
> +
> +#include <asm/ppc4xx.h>
> +
> +struct ppc4xx_gpio_chip {
> +	struct of_mm_gpio_chip mm_gc;
> +	spinlock_t lock;
> +	u32 shadow_or;
> +	u32 shadow_tcr;
> +	u32 shadow_osrl;
> +	u32 shadow_osrh;
> +	u32 shadow_tsrl;
> +	u32 shadow_tsrh;
> +	u32 shadow_odr;
> +};

Do we really need all those shadow registers? Access to the "real" registers 
is done while holding the spinlock.

> +
> +/*
> + * GPIO LIB API implementation for GPIOs
> + *
> + * There are a maximum of 64 gpios, spread over two sets of control
> registers. + * The sets are called GPIO0 and GPIO1.  Each set is managed
> separately, so + * there will be two entried in the .dts file.
> + */
> +
> +static inline struct ppc4xx_gpio_chip *
> +to_ppc4xx_gpiochip(struct of_mm_gpio_chip *mm_gc)
> +{
> +	return container_of(mm_gc, struct ppc4xx_gpio_chip, mm_gc);
> +}
> +
> +static int ppc4xx_gpio_get(struct gpio_chip *gc, unsigned int gpio)
> +{
> +	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> +	struct ppc4xx_gpio __iomem *regs = mm_gc->regs;
> +	u32 ret;
> +
> +	ret = (in_be32(&regs->gpio_ir) >> (31 - gpio)) & 1;
> +
> +	return ret;

	return in_be32(&regs->gpio_ir) >> (31 - gpio)) & 1;

should be enough.

> +}
> +
> +static inline void
> +__ppc4xx_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
> +{
> +	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> +	struct ppc4xx_gpio_chip *chip = to_ppc4xx_gpiochip(mm_gc);
> +	struct ppc4xx_gpio __iomem *regs = mm_gc->regs;
> +
> +	if (val)
> +		chip->shadow_or |= 1 << (31 - gpio);

This "1 << (31 - gpio)" is used quite often. Perhaps it makes sense to use a 
macro here to make the code better readable.

> +	else
> +		chip->shadow_or &= ~(1 << (31 - gpio));
> +	out_be32(&regs->gpio_or, chip->shadow_or);
> +}
> +
> +static void
> +ppc4xx_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
> +{
> +	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> +	struct ppc4xx_gpio_chip *chip = to_ppc4xx_gpiochip(mm_gc);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&chip->lock, flags);
> +
> +	__ppc4xx_gpio_set(gc, gpio, val);
> +
> +	spin_unlock_irqrestore(&chip->lock, flags);
> +
> +	pr_debug("%s: gpio: %d val: %d\n", __func__, gpio, val);
> +}
> +
> +static int ppc4xx_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
> +{
> +	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> +	struct ppc4xx_gpio_chip *chip = to_ppc4xx_gpiochip(mm_gc);
> +	struct ppc4xx_gpio __iomem *regs = mm_gc->regs;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&chip->lock, flags);
> +
> +	/* Disable open-drain function */
> +	chip->shadow_odr &= ~(1 << (31 - gpio));
> +	out_be32(&regs->gpio_odr, chip->shadow_odr);
> +
> +	/* Float the pin */
> +	chip->shadow_tcr &= ~(1 << (31 - gpio));
> +	out_be32(&regs->gpio_tcr, chip->shadow_tcr);
> +
> +	/* Bits 0-15 use TSRL/OSRL, bits 16-31 use TSRH/OSRH */
> +	if (gpio < 16) {
> +		chip->shadow_osrl &= ~(3 << ((15 - gpio) * 2));
> +		out_be32(&regs->gpio_osrl, chip->shadow_osrl);
> +
> +		chip->shadow_tsrl &= ~(3 << ((15 - gpio) * 2));
> +		out_be32(&regs->gpio_tsrl, chip->shadow_tsrl);
> +	} else {
> +		chip->shadow_osrh &= ~(3 << ((31 - gpio) * 2));
> +		out_be32(&regs->gpio_osrh, chip->shadow_osrh);
> +
> +		chip->shadow_tsrh &= ~(3 << ((31 - gpio) * 2));
> +		out_be32(&regs->gpio_tsrh, chip->shadow_tsrh);
> +	}
> +
> +	spin_unlock_irqrestore(&chip->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int
> +ppc4xx_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
> +{
> +	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> +	struct ppc4xx_gpio_chip *chip = to_ppc4xx_gpiochip(mm_gc);
> +	struct ppc4xx_gpio __iomem *regs = mm_gc->regs;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&chip->lock, flags);
> +
> +	/* First set initial value */
> +	__ppc4xx_gpio_set(gc, gpio, val);
> +
> +	/* Disable open-drain function */
> +	chip->shadow_odr &= ~(1 << (31 - gpio));
> +	out_be32(&regs->gpio_odr, chip->shadow_odr);
> +
> +	/* Drive the pin */
> +	chip->shadow_tcr |= (1 << (31 - gpio));
> +	out_be32(&regs->gpio_tcr, chip->shadow_tcr);
> +
> +	/* Bits 0-15 use TSRL, bits 16-31 use TSRH */
> +	if (gpio < 16) {
> +		chip->shadow_osrl &= ~(3 << ((15 - gpio) * 2));
> +		out_be32(&regs->gpio_osrl, chip->shadow_osrl);
> +
> +		chip->shadow_tsrl &= ~(3 << ((15 - gpio) * 2));
> +		out_be32(&regs->gpio_tsrl, chip->shadow_tsrl);
> +	} else {
> +		chip->shadow_osrh &= ~(3 << ((31 - gpio) * 2));
> +		out_be32(&regs->gpio_osrh, chip->shadow_osrh);
> +
> +		chip->shadow_tsrh &= ~(3 << ((31 - gpio) * 2));
> +		out_be32(&regs->gpio_tsrh, chip->shadow_tsrh);
> +	}
> +
> +	spin_unlock_irqrestore(&chip->lock, flags);
> +
> +	pr_debug("%s: gpio: %d val: %d\n", __func__, gpio, val);
> +
> +	return 0;
> +}
> +
> +static void __init ppc4xx_gpio_save_regs(struct of_mm_gpio_chip *mm_gc)
> +{
> +	struct ppc4xx_gpio_chip *chip = to_ppc4xx_gpiochip(mm_gc);
> +	struct ppc4xx_gpio __iomem *regs = mm_gc->regs;
> +
> +	chip->shadow_or = in_be32(&regs->gpio_or);
> +	chip->shadow_tcr = in_be32(&regs->gpio_tcr);
> +	chip->shadow_osrl = in_be32(&regs->gpio_osrl);
> +	chip->shadow_osrh = in_be32(&regs->gpio_osrh);
> +	chip->shadow_tsrl = in_be32(&regs->gpio_tsrl);
> +	chip->shadow_tsrh = in_be32(&regs->gpio_tsrh);
> +	chip->shadow_odr = in_be32(&regs->gpio_odr);
> +}
> +
> +static int __init ppc4xx_add_gpiochips(void)
> +{
> +	struct device_node *np;
> +
> +	for_each_compatible_node(np, NULL, "amcc,ppc4xx-gpio") {
> +		int ret;
> +		struct ppc4xx_gpio_chip *ppc4xx_gc;
> +		struct of_mm_gpio_chip *mm_gc;
> +		struct of_gpio_chip *of_gc;
> +		struct gpio_chip *gc;
> +
> +		ppc4xx_gc = kzalloc(sizeof(*ppc4xx_gc), GFP_KERNEL);
> +		if (!ppc4xx_gc) {
> +			ret = -ENOMEM;
> +			goto err;
> +		}
> +
> +		spin_lock_init(&ppc4xx_gc->lock);
> +
> +		mm_gc = &ppc4xx_gc->mm_gc;
> +		of_gc = &mm_gc->of_gc;
> +		gc = &of_gc->gc;
> +
> +		mm_gc->save_regs = ppc4xx_gpio_save_regs;
> +		of_gc->gpio_cells = 2;
> +		gc->ngpio = 32;
> +		gc->direction_input = ppc4xx_gpio_dir_in;
> +		gc->direction_output = ppc4xx_gpio_dir_out;
> +		gc->get = ppc4xx_gpio_get;
> +		gc->set = ppc4xx_gpio_set;
> +
> +		ret = of_mm_gpiochip_add(np, mm_gc);
> +		if (ret)
> +			goto err;
> +		continue;
> +err:
> +		pr_err("%s: registration failed with status %d\n",
> +		       np->full_name, ret);
> +		kfree(ppc4xx_gc);

This probably crashes if the kzalloc() fails above.

> +		/* try others anyway */
> +	}
> +	return 0;
> +}
> +arch_initcall(ppc4xx_add_gpiochips);
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev


Best regards,
Stefan
