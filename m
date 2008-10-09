Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id D3BF5DE03C
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 00:49:45 +1100 (EST)
Date: Thu, 9 Oct 2008 17:49:43 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: "Steven A. Falco" <sfalco@harris.com>
Subject: Re: PPC440EPx gpio driver
Message-ID: <20081009134943.GA21741@oksana.dev.rtsoft.ru>
References: <48ED1E96.4060406@harris.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <48ED1E96.4060406@harris.com>
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

Hi Steven,

On Wed, Oct 08, 2008 at 04:56:54PM -0400, Steven A. Falco wrote:
> I have begun writing a driver for the GPIOs of the PPC440EPx.  I just
> noticed that the PIKA Warp .dts references a device "ibm,gpio-440ep",
> but so far I have not been able to find a driver for that device.
> 
> So, here is what I have so far (patch is off 2.6.27-rc9).  It is not
> sufficiently general to be merged at this point, but it does appear
> to function with my Sequoia board (only tested gpio input, so far).

It looks good. Few comments below.

> Signed-off-by: Steve Falco <sfalco at harris.com>
> 
> diff --git a/arch/powerpc/platforms/44x/ppc4xx-gpio.c b/arch/powerpc/platforms/44x/ppc4xx-gpio.c
> new file mode 100644
> index 0000000..ce552b4
> --- /dev/null
> +++ b/arch/powerpc/platforms/44x/ppc4xx-gpio.c
> @@ -0,0 +1,246 @@
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
#include <linux/init.h> (for *_initcall)
#include <linux/compiler.h> (for __iomem)
#include <linux/types.h> (in case you'll use __be32).
#include <linux/spinlock.h>

> +
> +#include <asm/gpio.h>

Please don't include asm/gpio.h directly. There is a new header
to include: linux/gpio.h.

> +#include <asm/ppc4xx.h>
> +
> +static DEFINE_SPINLOCK(gpio_lock);

Why not move this lock into the ppc4xx_gpiochip? Per-bank
locks are better anyway, one bank won't block another.

> +struct ppc4xx_gpiochip {
> +	struct of_mm_gpio_chip mmchip;
> +	unsigned int shadow_or;

I'd suggest to use __be32 types here.

> +	unsigned int shadow_tcr;
> +	unsigned int shadow_osrl;
> +	unsigned int shadow_osrh;
> +	unsigned int shadow_tsrl;
> +	unsigned int shadow_tsrh;
> +	unsigned int shadow_odr;
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
> +	unsigned int ret;

u32 ret; would look better, I think.

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
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&gpio_lock, flags);
> +
> +	__ppc4xx_gpio_set(gc, gpio, val);
> +
> +	spin_unlock_irqrestore(&gpio_lock, flags);
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
> +	spin_lock_irqsave(&gpio_lock, flags);
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
> +	if(gpio < 16) {
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
> +	spin_unlock_irqrestore(&gpio_lock, flags);
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
> +	spin_lock_irqsave(&gpio_lock, flags);
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
> +	if(gpio < 16) {
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
> +	spin_unlock_irqrestore(&gpio_lock, flags);
> +
> +	pr_debug("%s: gpio: %d val: %d\n", __func__, gpio, val);
> +
> +	return 0;
> +}
> +
> +static int __devinit ppc4xx_gpiochip_probe(struct of_device *ofdev,
> +					const struct of_device_id *match)
> +{
> +	struct ppc4xx_gpiochip *chip;
> +	struct of_gpio_chip *ofchip;
> +	struct ppc4xx_gpio __iomem *regs;
> +	int ret;
> +
> +	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
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
> +	if (ret)
> +		return ret;

Leaking the allocated "chip".

> +
> +	regs = chip->mmchip.regs;
> +	chip->shadow_or = in_be32(&regs->gpio_or);

The chip is already added, but you set the shadow values just now.
I mean, this is racy.

There is special .save_regs() callback in the struct of_mm_gpio_chip,
made especially to solve this problem.

> +	chip->shadow_tcr = in_be32(&regs->gpio_tcr);
> +	chip->shadow_osrl = in_be32(&regs->gpio_osrl);
> +	chip->shadow_osrh = in_be32(&regs->gpio_osrh);
> +	chip->shadow_tsrl = in_be32(&regs->gpio_tsrl);
> +	chip->shadow_tsrh = in_be32(&regs->gpio_tsrh);
> +	chip->shadow_odr = in_be32(&regs->gpio_odr);
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
> +	.name = "gpio",

The name seems too generic.

> +	.match_table = ppc4xx_gpiochip_match,
> +	.probe = ppc4xx_gpiochip_probe,
> +	.remove = ppc4xx_gpiochip_remove,
> +};
> +
> +static int __init ppc4xx_gpio_init(void)
> +{
> +	if (of_register_platform_driver(&ppc4xx_gpiochip_driver))
> +		printk(KERN_ERR "Unable to register GPIO driver\n");

printk(KERN_ERR "%s: ...", __func__); would make it much clearer which
GPIO driver failed.

> +
> +	return 0;
> +}
> +
> +
> +/* Make sure we get initialised before anyone else tries to use us */
> +subsys_initcall(ppc4xx_gpio_init);

You could get rid of the of_platform_driver and make this
arch_initcall()... I.e. like arch/powerpc/sysdev/qe_lib/gpio.c.

But the driver approach is also OK... I don't have any preference
for this.


Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
