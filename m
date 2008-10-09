Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 531D5DE415
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 03:08:05 +1100 (EST)
Date: Thu, 9 Oct 2008 20:08:03 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: "Steven A. Falco" <sfalco@harris.com>
Subject: Re: PPC440EPx gpio driver
Message-ID: <20081009160803.GA20923@oksana.dev.rtsoft.ru>
References: <48ED1E96.4060406@harris.com> <48EE1EE1.1050206@harris.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <48EE1EE1.1050206@harris.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 09, 2008 at 11:10:25AM -0400, Steven A. Falco wrote:
> Anton - thanks very much for your comments.  I learned a lot, and I've
> incorporated your suggestions into the driver, copy attached.
> 
> Stefan - hope I didn't step on your toes, but I was not aware you were
> also working on this.  Anyway, it seemed like a good place to make my
> first "significant" contribution to the kernel source.  But I'll defer
> to the choice of the community.

Looks better, thanks.

> Signed-off-by: Steve Falco <sfalco at harris.com>
> 
> diff --git a/arch/powerpc/include/asm/ppc4xx.h b/arch/powerpc/include/asm/ppc4xx.h
> index 033039a..acbccb7 100644
> --- a/arch/powerpc/include/asm/ppc4xx.h
> +++ b/arch/powerpc/include/asm/ppc4xx.h
> @@ -13,6 +13,28 @@
>  #ifndef __ASM_POWERPC_PPC4xx_H__
>  #define __ASM_POWERPC_PPC4xx_H__

#include <linux/types.h>
here.

> +/* GPIO */
> +struct ppc4xx_gpio {

(ah.. here are the memory mapped registers)

> +	unsigned int gpio_or;

Then __be32 here.

> +	unsigned int gpio_tcr;
> +	unsigned int gpio_osrl;
> +	unsigned int gpio_osrh;
> +	unsigned int gpio_tsrl;
> +	unsigned int gpio_tsrh;
> +	unsigned int gpio_odr;
> +	unsigned int gpio_ir;
> +	unsigned int gpio_rr1;
> +	unsigned int gpio_rr2;
> +	unsigned int gpio_rr3;
> +	unsigned int reserved1;
> +	unsigned int gpio_isr1l;
> +	unsigned int gpio_isr1h;
> +	unsigned int gpio_isr2l;
> +	unsigned int gpio_isr2h;
> +	unsigned int gpio_isr3l;
> +	unsigned int gpio_isr3h;
> +};
> +
>  extern void ppc4xx_reset_system(char *cmd);
>  
>  #endif /* __ASM_POWERPC_PPC4xx_H__ */
> diff --git a/arch/powerpc/platforms/44x/ppc4xx-gpio.c b/arch/powerpc/platforms/44x/ppc4xx-gpio.c
> new file mode 100644
> index 0000000..fb80544
> --- /dev/null
> +++ b/arch/powerpc/platforms/44x/ppc4xx-gpio.c
> @@ -0,0 +1,265 @@
> +/*
> + * PPC4xx gpio driver
> + *
> + * Copyright (c) 2008 Harris Corporation
> + * Copyright (c) 2008 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
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
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#include <linux/of.h>
> +#include <linux/kernel.h>
> +#include <linux/of_gpio.h>
> +#include <linux/io.h>
> +#include <linux/of_platform.h>
> +#include <linux/init.h>
> +#include <linux/compiler.h>
> +#include <linux/types.h>
> +#include <linux/spinlock.h>
> +#include <linux/gpio.h>
> +
> +#include <asm/ppc4xx.h>
> +
> +struct ppc4xx_gpiochip {
> +	struct of_mm_gpio_chip mmchip;
> +	spinlock_t gpio_lock;
> +	__be32 shadow_or;

It appears that in my previous reply I was commenting on the
shadowed registers, not the memory mapped ones. :-/

Well, __be32 works here too, but the shadowed registers would
be better of just u32 type. Sorry for the confusion.

> +	__be32 shadow_tcr;
> +	__be32 shadow_osrl;
> +	__be32 shadow_osrh;
> +	__be32 shadow_tsrl;
> +	__be32 shadow_tsrh;
> +	__be32 shadow_odr;
> +};
> +
> +/*
> + * GPIO LIB API implementation for GPIOs
> + *
> + * There are a maximum of 64 gpios, spread over two sets of control registers.
> + * The sets are called GPIO0 and GPIO1.  Each set is managed separately, so
> + * there will be two entried in the .dts file.
> + */
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
> +}
> +
> +static inline void
> +__ppc4xx_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
> +{
> +	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> +	struct ppc4xx_gpiochip *chip = container_of(mm_gc,
> +			struct ppc4xx_gpiochip, mmchip);
> +	struct ppc4xx_gpio __iomem *regs = mm_gc->regs;
> +
> +	if (val)
> +		chip->shadow_or |= 1 << (31 - gpio);
> +	else
> +		chip->shadow_or &= ~(1 << (31 - gpio));
> +	out_be32(&regs->gpio_or, chip->shadow_or);
> +}
> +
> +static void
> +ppc4xx_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
> +{
> +	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> +	struct ppc4xx_gpiochip *chip = container_of(mm_gc,
> +			struct ppc4xx_gpiochip, mmchip);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&chip->gpio_lock, flags);
> +
> +	__ppc4xx_gpio_set(gc, gpio, val);
> +
> +	spin_unlock_irqrestore(&chip->gpio_lock, flags);
> +
> +	pr_debug("%s: gpio: %d val: %d\n", __func__, gpio, val);
> +}
> +
> +static int ppc4xx_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
> +{
> +	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> +	struct ppc4xx_gpiochip *chip = container_of(mm_gc,
> +			struct ppc4xx_gpiochip, mmchip);
> +	struct ppc4xx_gpio __iomem *regs = mm_gc->regs;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&chip->gpio_lock, flags);
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
> +	spin_unlock_irqrestore(&chip->gpio_lock, flags);
> +
> +	return 0;
> +}
> +
> +static int
> +ppc4xx_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
> +{
> +	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> +	struct ppc4xx_gpiochip *chip = container_of(mm_gc,
> +			struct ppc4xx_gpiochip, mmchip);
> +	struct ppc4xx_gpio __iomem *regs = mm_gc->regs;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&chip->gpio_lock, flags);
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
> +	spin_unlock_irqrestore(&chip->gpio_lock, flags);
> +
> +	pr_debug("%s: gpio: %d val: %d\n", __func__, gpio, val);
> +
> +	return 0;
> +}
> +
> +static void __devinit ppc4xx_gpiochip_save_regs(struct of_mm_gpio_chip *mm_gc)
> +{
> +	struct ppc4xx_gpiochip *chip = container_of(mm_gc,
> +			struct ppc4xx_gpiochip, mmchip);
> +	struct ppc4xx_gpio __iomem *regs;
> +
> +	regs = mm_gc->regs;
> +	chip->shadow_or = in_be32(&regs->gpio_or);
> +	chip->shadow_tcr = in_be32(&regs->gpio_tcr);
> +	chip->shadow_osrl = in_be32(&regs->gpio_osrl);
> +	chip->shadow_osrh = in_be32(&regs->gpio_osrh);
> +	chip->shadow_tsrl = in_be32(&regs->gpio_tsrl);
> +	chip->shadow_tsrh = in_be32(&regs->gpio_tsrh);
> +	chip->shadow_odr = in_be32(&regs->gpio_odr);
> +}
> +
> +static int __devinit ppc4xx_gpiochip_probe(struct of_device *ofdev,
> +					const struct of_device_id *match)
> +{
> +	struct ppc4xx_gpiochip *chip;
> +	struct of_gpio_chip *ofchip;
> +	int ret;
> +
> +	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&chip->gpio_lock);
> +
> +	chip->mmchip.save_regs = ppc4xx_gpiochip_save_regs;
> +
> +	ofchip = &chip->mmchip.of_gc;
> +
> +	ofchip->gpio_cells          = 2;
> +	ofchip->gc.ngpio            = 32;
> +	ofchip->gc.direction_input  = ppc4xx_gpio_dir_in;
> +	ofchip->gc.direction_output = ppc4xx_gpio_dir_out;
> +	ofchip->gc.get              = ppc4xx_gpio_get;
> +	ofchip->gc.set              = ppc4xx_gpio_set;
> +
> +	ret = of_mm_gpiochip_add(ofdev->node, &chip->mmchip);
> +	if (ret) {
> +		kfree(chip);
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
> +		.compatible = "amcc,ppc4xx-gpio",
> +	},
> +	{}
> +};
> +
> +static struct of_platform_driver ppc4xx_gpiochip_driver = {
> +	.name = "ppc4xx-gpio",
> +	.match_table = ppc4xx_gpiochip_match,
> +	.probe = ppc4xx_gpiochip_probe,
> +	.remove = ppc4xx_gpiochip_remove,
> +};
> +
> +static int __init ppc4xx_gpio_init(void)
> +{
> +	if (of_register_platform_driver(&ppc4xx_gpiochip_driver))
> +		printk(KERN_ERR "%s: Unable to register GPIO driver\n",
> +			       	__func__);
> +
> +	return 0;
> +}
> +
> +
> +/* Make sure we get initialised before anyone else tries to use us */
> +subsys_initcall(ppc4xx_gpio_init);

On the second thought, as I commented on the Stefan's patch,
there is no point of doing subsys_initcall() for the OF platform
driver, since platforms tend to probe the OF bus at device_initcall
time.

So, in the end I'd suggest to chose driver-less registration approach,
as in arch/powerpc/sysdev/qe_lib/gpio.c. That way GPIOs will appear
even earlier, at the arch_initcall time.


Thanks again,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
