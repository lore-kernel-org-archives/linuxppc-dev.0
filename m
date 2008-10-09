Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id C5D99DE1DE
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 02:43:04 +1100 (EST)
Date: Thu, 9 Oct 2008 19:43:02 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] powerpc/4xx: Add 4xx gpio support
Message-ID: <20081009154302.GA12785@oksana.dev.rtsoft.ru>
References: <1223564014-16757-1-git-send-email-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <1223564014-16757-1-git-send-email-sr@denx.de>
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

Hi Stefan,

On Thu, Oct 09, 2008 at 04:53:34PM +0200, Stefan Roese wrote:
> This patch adds a 4xx gpio driver. Tested on a 405EP and a 440EPx
> platform.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> ---
> 
> This driver probably needs some final polishing. E.g. some parts can
> be extraced from ppc4xx_gpio_dir_in()/ppc4xx_gpio_dir_out() and moved
> into seperate functions to make the code more compact. Also some
> documentation would be handy. I didn't include it for now since I
> wanted this driver version out now for comments. Documentation
> will follow in a later version.
> 
> Other suggestion are welcome. :)

Few comments below.

>  arch/powerpc/sysdev/Kconfig       |    8 ++
>  arch/powerpc/sysdev/Makefile      |    1 +
>  arch/powerpc/sysdev/ppc4xx_gpio.c |  233 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 242 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/sysdev/ppc4xx_gpio.c
> 
> diff --git a/arch/powerpc/sysdev/Kconfig b/arch/powerpc/sysdev/Kconfig
> index 72fb35b..f4a8edb 100644
> --- a/arch/powerpc/sysdev/Kconfig
> +++ b/arch/powerpc/sysdev/Kconfig
> @@ -6,3 +6,11 @@ config PPC4xx_PCI_EXPRESS
>  	bool
>  	depends on PCI && 4xx
>  	default n
> +
> +config PPC4xx_GPIO
> +	bool "PPC4xx GPIO support"
> +	depends on 4xx
> +	select ARCH_REQUIRE_GPIOLIB
> +	select GENERIC_GPIO
> +	help
> +	  Enable gpiolib support for PPC4xx based boards

I heard that we tend to put platform GPIO Kconfig symbols into
the arch/powerpc/platforms/Kconfig. Otherwise user-selectable
options appear at the top-level menu in the `menuconfig'.

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
> diff --git a/arch/powerpc/sysdev/ppc4xx_gpio.c b/arch/powerpc/sysdev/ppc4xx_gpio.c
> new file mode 100644
> index 0000000..9847579
> --- /dev/null
> +++ b/arch/powerpc/sysdev/ppc4xx_gpio.c
> @@ -0,1 +1,233 @@
> +/*
> + * IBM/AMCC PPC4xx GPIO LIB API implementation
> + *
> + * Copyright 2008 Stefan Roese <sr@denx.de>, DENX Software Engineering
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#undef DEBUG

dd

> +#include <linux/stddef.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/errno.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>

interrupts?

> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
> +#include <linux/of_platform.h>

#include <linux/gpio.h>
#include <linux/types.h>
#include <linux/spinlock.h>

> +#include <asm/dcr.h>
> +#include <asm/dcr-regs.h>
> +#include <asm/reg.h>
> +#include <asm/io.h>

linux/io.h

> +
> +#define GPIO_ALT1_SEL	0x40000000
> +#define GPIO_ALT2_SEL	0x80000000
> +#define GPIO_ALT3_SEL	0xc0000000
> +#define GPIO_IN_SEL	0x40000000
> +#define GPIO_MASK	0xc0000000
> +
> +#define GPIO_MAX	32
> +#define GPIO_VAL(gpio)	(0x80000000 >> (gpio))
> +
> +struct ppc4xx_gpio {
> +	u32 or;		/* 0x00: Output */

I think __be32 here would be better.

> +	u32 tcr;	/* 0x04: Three-State Control */
> +	u32 osrl;	/* 0x08: Output Select (Low) */
> +	u32 osrh;	/* 0x0c: Output Select (High) */
> +	u32 tsrl;	/* 0x10: Three-State Select (Low) */
> +	u32 tsrh;	/* 0x14: Three-State Select (High) */
> +	u32 odr;	/* 0x18: Open Drain */
> +	u32 ir;		/* 0x1c: Input */
> +	u32 rr1;	/* 0x20: Receive Register 1 */
> +	u32 rr2;	/* 0x24: Receive Register 2 */
> +	u32 rr3;	/* 0x28: Receive Register 3 */
> +	u32 res;
> +	u32 isr1l;	/* 0x30: Input Select 1 (Low) */
> +	u32 isr1h;	/* 0x34: Input Select 1 (High) */
> +	u32 isr2l;	/* 0x38: Input Select 1 (Low) */
> +	u32 isr2h;	/* 0x3c: Input Select 1 (High) */
> +	u32 isr3l;	/* 0x40: Input Select 1 (Low) */
> +	u32 isr3h;	/* 0x44: Input Select 1 (High) */
> +};
> +
> +struct ppc4xx_gpio_chip {
> +	struct of_mm_gpio_chip mmchip;
> +	spinlock_t lock;

Um, no shadowed registers.. can cause problems with open drain
pins, no?

> +};
> +
> +static inline struct ppc4xx_gpio_chip *
> +to_ppc4xx_gpio_chip(struct of_mm_gpio_chip *mm_gc)
> +{
> +	return container_of(mm_gc, struct ppc4xx_gpio_chip, mmchip);
> +}
> +
> +static int ppc4xx_gpio_get(struct gpio_chip *gc, unsigned int gpio)
> +{
> +	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> +	struct ppc4xx_gpio __iomem *regs = mm_gc->regs;
> +
> +	return (in_be32(&regs->ir) & GPIO_VAL(gpio) ? 1 : 0);

Outermost parenthesis aren't necessary. Plus no need for ? 1 : 0.
gpio_get returns 0 for low state, and any value != 0 for high state.

> +}
> +
> +static inline void __ppc4xx_gpio_set(struct gpio_chip *gc,
> +				     unsigned int gpio, int val)
> +{
> +	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> +	struct ppc4xx_gpio __iomem *regs = mm_gc->regs;
> +
> +	if (val)
> +		out_be32(&regs->or, in_be32(&regs->or) | GPIO_VAL(gpio));
> +	else
> +		out_be32(&regs->or, in_be32(&regs->or) & ~GPIO_VAL(gpio));
> +}
> +
> +static void ppc4xx_gpio_set(struct gpio_chip *gc,
> +			    unsigned int gpio, int val)
> +{
> +	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> +	struct ppc4xx_gpio_chip *chip = to_ppc4xx_gpio_chip(mm_gc);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&chip->lock, flags);
> +	__ppc4xx_gpio_set(gc, gpio, val);
> +	spin_unlock_irqrestore(&chip->lock, flags);
> +
> +	pr_debug("%s: gpio: %d val: %d\n", __func__, gpio, val);
> +}
> +
> +static int ppc4xx_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
> +{
> +	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> +	struct ppc4xx_gpio_chip *chip = to_ppc4xx_gpio_chip(mm_gc);
> +	struct ppc4xx_gpio __iomem *regs = mm_gc->regs;
> +	unsigned long flags;
> +	u32 offs, mask, mask2, val32;

I'd write is as

u32 offs;
u32 mask;
...

> +	u32 gpio2 = 0;
> +
> +	spin_lock_irqsave(&chip->lock, flags);
> +
> +	if (gpio >= GPIO_MAX / 2) {
> +		offs = 0x4;
> +		gpio2 = (gpio - GPIO_MAX / 2) << 1;
> +	}
> +
> +	mask = 0x80000000 >> gpio;
> +	mask2 = 0xc0000000 >> gpio2;
> +
> +	/* first set TCR to 0 */
> +	out_be32(&regs->tcr, in_be32(&regs->tcr) & ~mask);
> +
> +	/* now set the direction */
> +	val32 = in_be32(&regs->isr1l + offs) & ~mask2;
> +	val32 |= GPIO_IN_SEL >> gpio2;
> +	out_be32(&regs->isr1l + offs, val32);

clrsetbits32() would make this look nicer.

> +
> +	spin_unlock_irqrestore(&chip->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int ppc4xx_gpio_dir_out(struct gpio_chip *gc,
> +			       unsigned int gpio, int val)
> +{
> +	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> +	struct ppc4xx_gpio_chip *chip = to_ppc4xx_gpio_chip(mm_gc);
> +	struct ppc4xx_gpio __iomem *regs = mm_gc->regs;
> +	unsigned long flags;
> +	u32 offs, mask, mask2, val32;
> +	u32 gpio2 = 0;
> +
> +	spin_lock_irqsave(&chip->lock, flags);
> +
> +	if (gpio >= GPIO_MAX / 2) {
> +		offs = 0x4;
> +		gpio2 = (gpio - GPIO_MAX / 2) << 1;
> +	}
> +
> +	mask = 0x80000000 >> gpio;
> +	mask2 = 0xc0000000 >> gpio2;
> +
> +	/* first set TCR to 0 */
> +	out_be32(&regs->tcr, in_be32(&regs->tcr) & ~mask);

clrbits32()

> +
> +	/* set initial value */
> +	__ppc4xx_gpio_set(gc, gpio, val);
> +
> +	/* now set the direction */
> +	val32 = in_be32(&regs->osrl + offs) & ~mask2;
> +	out_be32(&regs->osrl + offs, val32);

clrbits32()

> +
> +	/* now configure TCR to drive output */
> +	out_be32(&regs->tcr, in_be32(&regs->tcr) | mask);

setbits32()

> +
> +	spin_unlock_irqrestore(&chip->lock, flags);
> +
> +	pr_debug("%s: gpio: %d val: %d\n", __func__, gpio, val);
> +
> +	return 0;
> +}
> +
> +static int __devinit ppc4xx_gpiochip_probe(struct of_device *ofdev,
> +					   const struct of_device_id *match)
> +{
> +	struct ppc4xx_gpio_chip *chip;
> +	struct of_gpio_chip *ofchip;
> +	int ret;
> +
> +	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	ofchip = &chip->mmchip.of_gc;
> +
> +	spin_lock_init(&chip->lock);
> +
> +	ofchip->gpio_cells = 2;
> +	ofchip->gc.ngpio = 32;
> +	ofchip->gc.direction_input = ppc4xx_gpio_dir_in;
> +	ofchip->gc.direction_output = ppc4xx_gpio_dir_out;
> +	ofchip->gc.get = ppc4xx_gpio_get;
> +	ofchip->gc.set = ppc4xx_gpio_set;
> +
> +	ret = of_mm_gpiochip_add(ofdev->node, &chip->mmchip);
> +	if (ret) {
> +		free(chip);

kfree()

> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ppc4xx_gpiochip_remove(struct of_device *ofdev)
> +{
> +	return -EBUSY;
> +}
> +
> +static const struct of_device_id ppc4xx_gpiochip_match[] = {
> +	{
> +		.compatible = "ibm,gpio",

Seems too generic, but I really don't know the 4xx enough to tell
that for sure...

> +	},
> +	{}
> +};
> +
> +static struct of_platform_driver ppc4xx_gpiochip_driver = {
> +	.name = "gpio",

This is too generic for sure.

> +	.match_table = ppc4xx_gpiochip_match,
> +	.probe = ppc4xx_gpiochip_probe,
> +	.remove = ppc4xx_gpiochip_remove,
> +};
> +
> +static int __init ppc4xx_gpio_init(void)
> +{
> +	if (of_register_platform_driver(&ppc4xx_gpiochip_driver))
> +		printk(KERN_ERR "%s: Unable to register GPIO driver\n", __func__);
> +
> +	return 0;
> +}
> +arch_initcall(ppc4xx_gpio_init);

There is no point of doing this in arch_initcall since most boards
call of_platform_bus_probe() at device_initcall time... It would be
better to get rid of the of_platform_driver() and just walk the device
tree via for_each_compatible_node() { register chips } in this
arch_initcall.


Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
