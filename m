Return-Path: <jacmet@gmail.com>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.150])
	by ozlabs.org (Postfix) with ESMTP id CDE32B7BEE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Jan 2010 03:24:19 +1100 (EST)
Received: by ey-out-1920.google.com with SMTP id 26so3681125eyw.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jan 2010 08:24:17 -0800 (PST)
Sender: Peter Korsgaard <jacmet@gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH-V3] mpc8xxx_gpio: add interrupt support
References: <1262883466-29371-1-git-send-email-jacmet@sunsite.dk>
Date: Tue, 12 Jan 2010 17:24:10 +0100
In-Reply-To: <1262883466-29371-1-git-send-email-jacmet@sunsite.dk> (Peter
	Korsgaard's message of "Thu, 7 Jan 2010 17:57:46 +0100")
Message-ID: <87skabqok5.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>>>> Peter Korsgaard <jacmet@sunsite.dk> writes:

Hi,

Anton, any comments on this?

 > Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
 > ---
 > Changes since v1:
 > - Document OF binding for IRQ as requested by Kumar.

 > Changes since v2:
 > - Fix xlate prototype mismatch warning (intspec should be const)

 >  .../powerpc/dts-bindings/fsl/8xxx_gpio.txt         |   22 +++-
 >  arch/powerpc/sysdev/mpc8xxx_gpio.c                 |  147 ++++++++++++++++++++
 >  2 files changed, 168 insertions(+), 1 deletions(-)

 > diff --git a/Documentation/powerpc/dts-bindings/fsl/8xxx_gpio.txt b/Documentation/powerpc/dts-bindings/fsl/8xxx_gpio.txt
 > index d015dce..b0019eb 100644
 > --- a/Documentation/powerpc/dts-bindings/fsl/8xxx_gpio.txt
 > +++ b/Documentation/powerpc/dts-bindings/fsl/8xxx_gpio.txt
 > @@ -11,7 +11,7 @@ Required properties:
 >    83xx, "fsl,mpc8572-gpio" for 85xx and "fsl,mpc8610-gpio" for 86xx.
 >  - #gpio-cells : Should be two. The first cell is the pin number and the
 >    second cell is used to specify optional parameters (currently unused).
 > - - interrupts : Interrupt mapping for GPIO IRQ (currently unused).
 > + - interrupts : Interrupt mapping for GPIO IRQ.
 >   - interrupt-parent : Phandle for the interrupt controller that
 >     services interrupts for this device.
 >  - gpio-controller : Marks the port as GPIO controller.
 > @@ -38,3 +38,23 @@ Example of gpio-controller nodes for a MPC8347 SoC:
 
 >  See booting-without-of.txt for details of how to specify GPIO
 >  information for devices.
 > +
 > +To use GPIO pins as interrupt sources for peripherals, specify the
 > +GPIO controller as the interrupt parent and define GPIO number +
 > +trigger mode using the interrupts property, which is defined like
 > +this:
 > +
 > +interrupts = <number trigger>, where:
 > + - number: GPIO pin (0..31)
 > + - trigger: trigger mode:
 > +	2 = trigger on falling edge
 > +	3 = trigger on both edges
 > +
 > +Example of device using this is:
 > +
 > +	funkyfpga@0 {
 > +		compatible = "funky-fpga";
 > +		...
 > +		interrupts = <4 3>;
 > +		interrupt-parent = <&gpio1>;
 > +	};
 > diff --git a/arch/powerpc/sysdev/mpc8xxx_gpio.c b/arch/powerpc/sysdev/mpc8xxx_gpio.c
 > index ee1c0e1..1bd930e 100644
 > --- a/arch/powerpc/sysdev/mpc8xxx_gpio.c
 > +++ b/arch/powerpc/sysdev/mpc8xxx_gpio.c
 > @@ -15,6 +15,7 @@
 >  #include <linux/of.h>
 >  #include <linux/of_gpio.h>
 >  #include <linux/gpio.h>
 > +#include <linux/irq.h>
 
 >  #define MPC8XXX_GPIO_PINS	32
 
 > @@ -34,6 +35,7 @@ struct mpc8xxx_gpio_chip {
 >  	 * open drain mode safely
 >  	 */
 >  	u32 data;
 > +	struct irq_host *irq;
 >  };
 
 >  static inline u32 mpc8xxx_gpio2mask(unsigned int gpio)
 > @@ -127,12 +129,136 @@ static int mpc8xxx_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val
 >  	return 0;
 >  }
 
 > +static int mpc8xxx_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
 > +{
 > +	struct of_mm_gpio_chip *mm = to_of_mm_gpio_chip(gc);
 > +	struct mpc8xxx_gpio_chip *mpc8xxx_gc = to_mpc8xxx_gpio_chip(mm);
 > +
 > +	if (mpc8xxx_gc->irq && offset < MPC8XXX_GPIO_PINS)
 > +		return irq_create_mapping(mpc8xxx_gc->irq, offset);
 > +	else
 > +		return -ENXIO;
 > +}
 > +
 > +static void mpc8xxx_gpio_irq_cascade(unsigned int irq, struct irq_desc *desc)
 > +{
 > +	struct mpc8xxx_gpio_chip *mpc8xxx_gc = get_irq_desc_data(desc);
 > +	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
 > +	unsigned int mask;
 > +
 > +	mask = in_be32(mm->regs + GPIO_IER) & in_be32(mm->regs + GPIO_IMR);
 > +	if (mask)
 > +		generic_handle_irq(irq_linear_revmap(mpc8xxx_gc->irq,
 > +						     32 - ffs(mask)));
 > +}
 > +
 > +static void mpc8xxx_irq_unmask(unsigned int virq)
 > +{
 > +	struct mpc8xxx_gpio_chip *mpc8xxx_gc = get_irq_chip_data(virq);
 > +	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
 > +	unsigned long flags;
 > +
 > +	spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
 > +
 > +	setbits32(mm->regs + GPIO_IMR, mpc8xxx_gpio2mask(virq_to_hw(virq)));
 > +
 > +	spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
 > +}
 > +
 > +static void mpc8xxx_irq_mask(unsigned int virq)
 > +{
 > +	struct mpc8xxx_gpio_chip *mpc8xxx_gc = get_irq_chip_data(virq);
 > +	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
 > +	unsigned long flags;
 > +
 > +	spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
 > +
 > +	clrbits32(mm->regs + GPIO_IMR, mpc8xxx_gpio2mask(virq_to_hw(virq)));
 > +
 > +	spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
 > +}
 > +
 > +static void mpc8xxx_irq_ack(unsigned int virq)
 > +{
 > +	struct mpc8xxx_gpio_chip *mpc8xxx_gc = get_irq_chip_data(virq);
 > +	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
 > +
 > +	out_be32(mm->regs + GPIO_IER, mpc8xxx_gpio2mask(virq_to_hw(virq)));
 > +}
 > +
 > +static int mpc8xxx_irq_set_type(unsigned int virq, unsigned int flow_type)
 > +{
 > +	struct mpc8xxx_gpio_chip *mpc8xxx_gc = get_irq_chip_data(virq);
 > +	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
 > +	unsigned long flags;
 > +
 > +	switch (flow_type) {
 > +	case IRQ_TYPE_EDGE_FALLING:
 > +		spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
 > +		setbits32(mm->regs + GPIO_ICR,
 > +			  mpc8xxx_gpio2mask(virq_to_hw(virq)));
 > +		spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
 > +		break;
 > +
 > +	case IRQ_TYPE_EDGE_BOTH:
 > +		spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
 > +		clrbits32(mm->regs + GPIO_ICR,
 > +			  mpc8xxx_gpio2mask(virq_to_hw(virq)));
 > +		spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
 > +		break;
 > +
 > +	default:
 > +		return -EINVAL;
 > +	}
 > +
 > +	return 0;
 > +}
 > +
 > +static struct irq_chip mpc8xxx_irq_chip = {
 > +	.name		= "mpc8xxx-gpio",
 > +	.unmask		= mpc8xxx_irq_unmask,
 > +	.mask		= mpc8xxx_irq_mask,
 > +	.ack		= mpc8xxx_irq_ack,
 > +	.set_type	= mpc8xxx_irq_set_type,
 > +};
 > +
 > +static int mpc8xxx_gpio_irq_map(struct irq_host *h, unsigned int virq,
 > +				irq_hw_number_t hw)
 > +{
 > +	set_irq_chip_data(virq, h->host_data);
 > +	set_irq_chip_and_handler(virq, &mpc8xxx_irq_chip, handle_level_irq);
 > +	set_irq_type(virq, IRQ_TYPE_NONE);
 > +
 > +	return 0;
 > +}
 > +
 > +static int mpc8xxx_gpio_irq_xlate(struct irq_host *h, struct device_node *ct,
 > +				  const u32 *intspec, unsigned int intsize,
 > +				  irq_hw_number_t *out_hwirq,
 > +				  unsigned int *out_flags)
 > +
 > +{
 > +	/* interrupt sense values coming from the device tree equal either
 > +	 * EDGE_FALLING or EDGE_BOTH
 > +	 */
 > +	*out_hwirq = intspec[0];
 > +	*out_flags = intspec[1];
 > +
 > +	return 0;
 > +}
 > +
 > +static struct irq_host_ops mpc8xxx_gpio_irq_ops = {
 > +	.map	= mpc8xxx_gpio_irq_map,
 > +	.xlate	= mpc8xxx_gpio_irq_xlate,
 > +};
 > +
 >  static void __init mpc8xxx_add_controller(struct device_node *np)
 >  {
 >  	struct mpc8xxx_gpio_chip *mpc8xxx_gc;
 >  	struct of_mm_gpio_chip *mm_gc;
 >  	struct of_gpio_chip *of_gc;
 >  	struct gpio_chip *gc;
 > +	unsigned hwirq;
 >  	int ret;
 
 >  	mpc8xxx_gc = kzalloc(sizeof(*mpc8xxx_gc), GFP_KERNEL);
 > @@ -157,11 +283,32 @@ static void __init mpc8xxx_add_controller(struct device_node *np)
 >  	else
 > 		gc->get = mpc8xxx_gpio_get;
 > 	gc->set = mpc8xxx_gpio_set;
 > +	gc->to_irq = mpc8xxx_gpio_to_irq;
 
 >  	ret = of_mm_gpiochip_add(np, mm_gc);
 >  	if (ret)
 >  		goto err;
 
 > +	hwirq = irq_of_parse_and_map(np, 0);
 > +	if (hwirq == NO_IRQ)
 > +		goto skip_irq;
 > +
 > +	mpc8xxx_gc->irq =
 > +		irq_alloc_host(np, IRQ_HOST_MAP_LINEAR, MPC8XXX_GPIO_PINS,
 > +			       &mpc8xxx_gpio_irq_ops, MPC8XXX_GPIO_PINS);
 > +	if (!mpc8xxx_gc->irq)
 > +		goto skip_irq;
 > +
 > +	mpc8xxx_gc->irq->host_data = mpc8xxx_gc;
 > +
 > +	/* ack and mask all irqs */
 > +	out_be32(mm_gc->regs + GPIO_IER, 0xffffffff);
 > +	out_be32(mm_gc->regs + GPIO_IMR, 0);
 > +
 > +	set_irq_data(hwirq, mpc8xxx_gc);
 > +	set_irq_chained_handler(hwirq, mpc8xxx_gpio_irq_cascade);
 > +
 > +skip_irq:
 >  	return;
 
 >  err:
 > -- 
 > 1.6.5


-- 
Bye, Peter Korsgaard
