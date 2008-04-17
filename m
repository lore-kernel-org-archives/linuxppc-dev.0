Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 66343DE346
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 08:35:59 +1000 (EST)
Message-Id: <A46A6C3E-E5A7-48FB-9B13-475D442F53EC@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080417192904.GD28286@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 4/5] [POWERPC] QE: implement support for the GPIO LIB API
Date: Thu, 17 Apr 2008 17:35:53 -0500
References: <20080417192656.GA19107@polina.dev.rtsoft.ru>
	<20080417192904.GD28286@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> index a3f9c3f..a4a195a 100644
> --- a/arch/powerpc/sysdev/qe_lib/qe_io.c
> +++ b/arch/powerpc/sysdev/qe_lib/qe_io.c
> @@ -20,7 +20,8 @@
> #include <linux/errno.h>
> #include <linux/module.h>
> #include <linux/ioport.h>
> -
> +#include <linux/spinlock.h>
> +#include <linux/of_gpio.h>
> #include <asm/io.h>
> #include <asm/qe.h>
> #include <asm/prom.h>
> @@ -214,6 +215,140 @@ int par_io_of_config(struct device_node *np)
> }
> EXPORT_SYMBOL(par_io_of_config);

can we split this out into a new file since its pretty much a driver.

>
>
> +/*
> + * GPIO LIB API implementation
> + */
> +
> +struct qe_gpio_chip {
> +	struct of_mm_gpio_chip mm_gc;
> +	spinlock_t lock;
> +
> +	/* shadowed data register to clear/set bits safely */
> +	u32 cpdata;
> +};
> +
> +static inline struct qe_gpio_chip *
> +to_qe_gpio_chip(struct of_mm_gpio_chip *mm_gc)
> +{
> +	return container_of(mm_gc, struct qe_gpio_chip, mm_gc);
> +}
> +
> +static void qe_gpio_save_regs(struct of_mm_gpio_chip *mm_gc)
> +{
> +	struct qe_gpio_chip *qe_gc = to_qe_gpio_chip(mm_gc);
> +	struct port_regs __iomem *regs = mm_gc->regs;
> +
> +	qe_gc->cpdata = in_be32(&regs->cpdata);
> +}
> +
> +static int qe_gpio_get(struct gpio_chip *gc, unsigned int gpio)
> +{
> +	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> +	struct port_regs __iomem *regs = mm_gc->regs;
> +	u32 pin_mask;
> +
> +	/* calculate pin location */
> +	pin_mask = (u32) (1 << (NUM_OF_PINS - 1 - gpio));
> +
> +	return !!(in_be32(&regs->cpdata) & pin_mask);
> +}
> +
> +static void qe_gpio_set(struct gpio_chip *gc, unsigned int gpio,  
> int val)
> +{
> +	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> +	struct qe_gpio_chip *qe_gc = to_qe_gpio_chip(mm_gc);
> +	struct port_regs __iomem *regs = mm_gc->regs;
> +	unsigned long flags;
> +	u32 pin_mask = 1 << (NUM_OF_PINS - 1 - gpio);
> +
> +	spin_lock_irqsave(&qe_gc->lock, flags);
> +
> +	if (val)
> +		qe_gc->cpdata |= pin_mask;
> +	else
> +		qe_gc->cpdata &= ~pin_mask;
> +
> +	out_be32(&regs->cpdata, qe_gc->cpdata);
> +
> +	spin_unlock_irqrestore(&qe_gc->lock, flags);
> +}
> +
> +static int qe_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
> +{
> +	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> +	struct qe_gpio_chip *qe_gc = to_qe_gpio_chip(mm_gc);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&qe_gc->lock, flags);
> +
> +	__par_io_config_pin(mm_gc->regs, gpio, 2, 0, 0, 0);
> +
> +	spin_unlock_irqrestore(&qe_gc->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int qe_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio,  
> int val)
> +{
> +	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> +	struct qe_gpio_chip *qe_gc = to_qe_gpio_chip(mm_gc);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&qe_gc->lock, flags);
> +
> +	__par_io_config_pin(mm_gc->regs, gpio, 1, 0, 0, 0);
> +
> +	spin_unlock_irqrestore(&qe_gc->lock, flags);
> +
> +	qe_gpio_set(gc, gpio, val);
> +
> +	return 0;
> +}
> +
> +static int __init qe_add_gpiochips(void)
> +{
> +	int ret;
> +	struct device_node *np;
> +
> +	for_each_compatible_node(np, NULL, "fsl,qe-pario-bank") {
> +		struct qe_gpio_chip *qe_gc;
> +		struct of_mm_gpio_chip *mm_gc;
> +		struct of_gpio_chip *of_gc;
> +		struct gpio_chip *gc;
> +
> +		qe_gc = kzalloc(sizeof(*qe_gc), GFP_KERNEL);
> +		if (!qe_gc) {
> +			ret = -ENOMEM;
> +			goto err;
> +		}
> +
> +		spin_lock_init(&qe_gc->lock);
> +
> +		mm_gc = &qe_gc->mm_gc;
> +		of_gc = &mm_gc->of_gc;
> +		gc = &of_gc->gc;
> +
> +		mm_gc->save_regs = qe_gpio_save_regs;
> +		of_gc->gpio_cells = 2;
> +		gc->ngpio = NUM_OF_PINS;
> +		gc->direction_input = qe_gpio_dir_in;
> +		gc->direction_output = qe_gpio_dir_out;
> +		gc->get = qe_gpio_get;
> +		gc->set = qe_gpio_set;
> +
> +		ret = of_mm_gpiochip_add(np, mm_gc);
> +		if (ret)
> +			goto err;
> +	}
> +
> +	return 0;
> +err:
> +	pr_err("%s: registration failed with status %d\n", np->full_name,  
> ret);
> +	of_node_put(np);
> +	return ret;
> +}
> +arch_initcall(qe_add_gpiochips);
> +
> #ifdef DEBUG
> static void dump_par_io(void)
> {
> -- 
> 1.5.5
