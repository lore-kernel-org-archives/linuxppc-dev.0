Return-Path: <jacmet@gmail.com>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.149])
	by ozlabs.org (Postfix) with ESMTP id B9BC7B8139
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Dec 2009 18:33:06 +1100 (EST)
Received: by ey-out-1920.google.com with SMTP id 5so65937eyb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 08 Dec 2009 23:33:03 -0800 (PST)
Sender: Peter Korsgaard <jacmet@gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/3] mpc8xxx_gpio: add interrupt support
References: <1259700494-17869-1-git-send-email-jacmet@sunsite.dk>
	<1259700494-17869-2-git-send-email-jacmet@sunsite.dk>
	<1259700494-17869-3-git-send-email-jacmet@sunsite.dk>
Date: Wed, 09 Dec 2009 08:33:00 +0100
In-Reply-To: <1259700494-17869-3-git-send-email-jacmet@sunsite.dk> (Peter
	Korsgaard's message of "Tue, 1 Dec 2009 21:48:14 +0100")
Message-ID: <87pr6omwk3.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>>>> "Peter" == Peter Korsgaard <jacmet@sunsite.dk> writes:

Comments?

 Peter> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
 Peter> ---
 Peter>  arch/powerpc/sysdev/mpc8xxx_gpio.c |  147 ++++++++++++++++++++++++++++++++++++
 Peter>  1 files changed, 147 insertions(+), 0 deletions(-)

 Peter> diff --git a/arch/powerpc/sysdev/mpc8xxx_gpio.c b/arch/powerpc/sysdev/mpc8xxx_gpio.c
 Peter> index 103eace..b46f28b 100644
 Peter> --- a/arch/powerpc/sysdev/mpc8xxx_gpio.c
 Peter> +++ b/arch/powerpc/sysdev/mpc8xxx_gpio.c
 Peter> @@ -15,6 +15,7 @@
 Peter>  #include <linux/of.h>
 Peter>  #include <linux/of_gpio.h>
 Peter>  #include <linux/gpio.h>
 Peter> +#include <linux/irq.h>
 
 Peter>  #define MPC8XXX_GPIO_PINS	32
 
 Peter> @@ -34,6 +35,7 @@ struct mpc8xxx_gpio_chip {
 Peter>  	 * open drain mode safely
 Peter>  	 */
 Peter>  	u32 data;
 Peter> +	struct irq_host *irq;
 Peter>  };
 
 Peter>  static inline u32 mpc8xxx_gpio2mask(unsigned int gpio)
 Peter> @@ -111,12 +113,136 @@ static int mpc8xxx_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val
 Peter>  	return 0;
 Peter>  }
 
 Peter> +static int mpc8xxx_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
 Peter> +{
 Peter> +	struct of_mm_gpio_chip *mm = to_of_mm_gpio_chip(gc);
 Peter> +	struct mpc8xxx_gpio_chip *mpc8xxx_gc = to_mpc8xxx_gpio_chip(mm);
 Peter> +
 Peter> +	if (mpc8xxx_gc->irq && offset < MPC8XXX_GPIO_PINS)
 Peter> +		return irq_create_mapping(mpc8xxx_gc->irq, offset);
 Peter> +	else
 Peter> +		return -ENXIO;
 Peter> +}
 Peter> +
 Peter> +static void mpc8xxx_gpio_irq_cascade(unsigned int irq, struct irq_desc *desc)
 Peter> +{
 Peter> +	struct mpc8xxx_gpio_chip *mpc8xxx_gc = get_irq_desc_data(desc);
 Peter> +	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
 Peter> +	unsigned int mask;
 Peter> +
 Peter> +	mask = in_be32(mm->regs + GPIO_IER) & in_be32(mm->regs + GPIO_IMR);
 Peter> +	if (mask)
 Peter> +		generic_handle_irq(irq_linear_revmap(mpc8xxx_gc->irq,
 Peter> +						     32 - ffs(mask)));
 Peter> +}
 Peter> +
 Peter> +static void mpc8xxx_irq_unmask(unsigned int virq)
 Peter> +{
 Peter> +	struct mpc8xxx_gpio_chip *mpc8xxx_gc = get_irq_chip_data(virq);
 Peter> +	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
 Peter> +	unsigned long flags;
 Peter> +
 Peter> +	spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
 Peter> +
 Peter> +	setbits32(mm->regs + GPIO_IMR, mpc8xxx_gpio2mask(virq_to_hw(virq)));
 Peter> +
 Peter> +	spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
 Peter> +}
 Peter> +
 Peter> +static void mpc8xxx_irq_mask(unsigned int virq)
 Peter> +{
 Peter> +	struct mpc8xxx_gpio_chip *mpc8xxx_gc = get_irq_chip_data(virq);
 Peter> +	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
 Peter> +	unsigned long flags;
 Peter> +
 Peter> +	spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
 Peter> +
 Peter> +	clrbits32(mm->regs + GPIO_IMR, mpc8xxx_gpio2mask(virq_to_hw(virq)));
 Peter> +
 Peter> +	spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
 Peter> +}
 Peter> +
 Peter> +static void mpc8xxx_irq_ack(unsigned int virq)
 Peter> +{
 Peter> +	struct mpc8xxx_gpio_chip *mpc8xxx_gc = get_irq_chip_data(virq);
 Peter> +	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
 Peter> +
 Peter> +	out_be32(mm->regs + GPIO_IER, mpc8xxx_gpio2mask(virq_to_hw(virq)));
 Peter> +}
 Peter> +
 Peter> +static int mpc8xxx_irq_set_type(unsigned int virq, unsigned int flow_type)
 Peter> +{
 Peter> +	struct mpc8xxx_gpio_chip *mpc8xxx_gc = get_irq_chip_data(virq);
 Peter> +	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
 Peter> +	unsigned long flags;
 Peter> +
 Peter> +	switch (flow_type) {
 Peter> +	case IRQ_TYPE_EDGE_FALLING:
 Peter> +		spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
 Peter> +		setbits32(mm->regs + GPIO_ICR,
 Peter> +			  mpc8xxx_gpio2mask(virq_to_hw(virq)));
 Peter> +		spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
 Peter> +		break;
 Peter> +
 Peter> +	case IRQ_TYPE_EDGE_BOTH:
 Peter> +		spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
 Peter> +		clrbits32(mm->regs + GPIO_ICR,
 Peter> +			  mpc8xxx_gpio2mask(virq_to_hw(virq)));
 Peter> +		spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
 Peter> +		break;
 Peter> +
 Peter> +	default:
 Peter> +		return -EINVAL;
 Peter> +	}
 Peter> +
 Peter> +	return 0;
 Peter> +}
 Peter> +
 Peter> +static struct irq_chip mpc8xxx_irq_chip = {
 Peter> +	.name		= "mpc8xxx-gpio",
 Peter> +	.unmask		= mpc8xxx_irq_unmask,
 Peter> +	.mask		= mpc8xxx_irq_mask,
 Peter> +	.ack		= mpc8xxx_irq_ack,
 Peter> +	.set_type	= mpc8xxx_irq_set_type,
 Peter> +};
 Peter> +
 Peter> +static int mpc8xxx_gpio_irq_map(struct irq_host *h, unsigned int virq,
 Peter> +				irq_hw_number_t hw)
 Peter> +{
 Peter> +	set_irq_chip_data(virq, h->host_data);
 Peter> +	set_irq_chip_and_handler(virq, &mpc8xxx_irq_chip, handle_level_irq);
 Peter> +	set_irq_type(virq, IRQ_TYPE_NONE);
 Peter> +
 Peter> +	return 0;
 Peter> +}
 Peter> +
 Peter> +static int mpc8xxx_gpio_irq_xlate(struct irq_host *h, struct device_node *ct,
 Peter> +				  u32 *intspec, unsigned int intsize,
 Peter> +				  irq_hw_number_t *out_hwirq,
 Peter> +				  unsigned int *out_flags)
 Peter> +
 Peter> +{
 Peter> +	/* interrupt sense values coming from the device tree equal either
 Peter> +	 * EDGE_FALLING or EDGE_BOTH
 Peter> +	 */
 Peter> +	*out_hwirq = intspec[0];
 Peter> +	*out_flags = intspec[1];
 Peter> +
 Peter> +	return 0;
 Peter> +}
 Peter> +
 Peter> +static struct irq_host_ops mpc8xxx_gpio_irq_ops = {
 Peter> +	.map	= mpc8xxx_gpio_irq_map,
 Peter> +	.xlate	= mpc8xxx_gpio_irq_xlate,
 Peter> +};
 Peter> +
 Peter>  static void __init mpc8xxx_add_controller(struct device_node *np)
 Peter>  {
 Peter>  	struct mpc8xxx_gpio_chip *mpc8xxx_gc;
 Peter>  	struct of_mm_gpio_chip *mm_gc;
 Peter>  	struct of_gpio_chip *of_gc;
 Peter>  	struct gpio_chip *gc;
 Peter> +	unsigned hwirq;
 Peter>  	int ret;
 
 Peter>  	mpc8xxx_gc = kzalloc(sizeof(*mpc8xxx_gc), GFP_KERNEL);
 Peter> @@ -138,11 +264,32 @@ static void __init mpc8xxx_add_controller(struct device_node *np)
 gc-> direction_output = mpc8xxx_gpio_dir_out;
 gc-> get = mpc8xxx_gpio_get;
 gc-> set = mpc8xxx_gpio_set;
 Peter> +	gc->to_irq = mpc8xxx_gpio_to_irq;
 
 Peter>  	ret = of_mm_gpiochip_add(np, mm_gc);
 Peter>  	if (ret)
 Peter>  		goto err;
 
 Peter> +	hwirq = irq_of_parse_and_map(np, 0);
 Peter> +	if (hwirq == NO_IRQ)
 Peter> +		goto skip_irq;
 Peter> +
 Peter> +	mpc8xxx_gc->irq =
 Peter> +		irq_alloc_host(np, IRQ_HOST_MAP_LINEAR, MPC8XXX_GPIO_PINS,
 Peter> +			       &mpc8xxx_gpio_irq_ops, MPC8XXX_GPIO_PINS);
 Peter> +	if (!mpc8xxx_gc->irq)
 Peter> +		goto skip_irq;
 Peter> +
 Peter> +	mpc8xxx_gc->irq->host_data = mpc8xxx_gc;
 Peter> +
 Peter> +	/* ack and mask all irqs */
 Peter> +	out_be32(mm_gc->regs + GPIO_IER, 0xffffffff);
 Peter> +	out_be32(mm_gc->regs + GPIO_IMR, 0);
 Peter> +
 Peter> +	set_irq_data(hwirq, mpc8xxx_gc);
 Peter> +	set_irq_chained_handler(hwirq, mpc8xxx_gpio_irq_cascade);
 Peter> +
 Peter> +skip_irq:
 Peter>  	return;
 
 Peter>  err:
 Peter> -- 
 Peter> 1.6.5


-- 
Bye, Peter Korsgaard
