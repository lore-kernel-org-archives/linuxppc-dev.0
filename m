Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f20.google.com (mail-gx0-f20.google.com
	[209.85.217.20]) by ozlabs.org (Postfix) with ESMTP id 44C7BDDF32
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Feb 2009 07:23:20 +1100 (EST)
Received: by gxk13 with SMTP id 13so1762372gxk.9
	for <linuxppc-dev@ozlabs.org>; Mon, 02 Feb 2009 12:23:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20090131203950.GA3859@pengutronix.de>
References: <20090127163022.32583.85199.stgit@localhost.localdomain>
	<20090131203950.GA3859@pengutronix.de>
Date: Mon, 2 Feb 2009 13:23:18 -0700
Message-ID: <fa686aa40902021223n2c01207bg569dde790fb3fe3e@mail.gmail.com>
Subject: Re: [PATCH 2] powerpc/5200: Rework GPT driver to also be an IRQ
	controller
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hey Wolfram, thanks for the comments.

Some of the comments are due to the verbatim movement of the gpio
portion of the code out of mpc52xx_gpio.c, and my style just tends
towards using in/out pairs instead of set/clr bits, but I'm not
particularly attached to it.  I've made updates and I'll repost
shortly.

Replies below.

On Sat, Jan 31, 2009 at 1:39 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> On Tue, Jan 27, 2009 at 09:30:22AM -0700, Grant Likely wrote:
>> +++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
>> + * When using the GPIO line as an output, it can either be driven as normal
>> + * IO, or it can be an OC output.  At the moment it is the responsibility
>
> Not quite sure, but maybe OC can be written in its long form to ease
> understanding.

Fixed.

>> +#include <asm/time.h>
>
> checkpatch asks if linux/time.h will do?

Removed entirely.

>> +/**
>> + * struct mpc52xx_gpt - Private data structure for MPC52xx GPT driver
>> + * @dev: pointer to device structure
>> + * @regs: virtual address of GPT registers
>
> @lock is missing here.

fixed.

>> +static void mpc52xx_gpt_irq_unmask(unsigned int virq)
>> +{
>> +     struct mpc52xx_gpt_priv *gpt = get_irq_chip_data(virq);
>> +     unsigned long flags;
>> +     u32 val;
>> +
>> +     spin_lock_irqsave(&gpt->lock, flags);
>> +     val = in_be32(&gpt->regs->mode) | MPC52xx_GPT_MODE_IRQ_EN;
>> +     out_be32(&gpt->regs->mode, val);
>
> setbits32 (from <asm/io.h>)?

sure.

>> +static void mpc52xx_gpt_irq_ack(unsigned int virq)
>> +{
>> +     struct mpc52xx_gpt_priv *gpt = get_irq_chip_data(virq);
>> +
>> +     out_be32(&gpt->regs->status, 0xf);
>
> One magic value left.

fixed

>> +void mpc52xx_gpt_irq_cascade(unsigned int virq, struct irq_desc *desc)
>> +{
>> +     struct mpc52xx_gpt_priv *gpt = get_irq_data(virq);
>> +     int sub_virq;
>> +     u32 status;
>> +
>> +     /* Ask the FPGA for IRQ status.  If 'val' is 0, then no irqs
>> +      * are pending.  'ffs()' is 1 based */
>> +     status = in_be32(&gpt->regs->status) | 0xF;
>> +     if (status) {
>
> Which FPGA? Why ffs (not used here)? if is always true? Or do you mean
> '& 0xF' above? Looks a bit like leftovers which makes it confusing to
> follow the rest of the code.

Oops, that is a bit of old cruft.  Fixed.

>> +     if ((intsize < 1) || (intspec[0] < 1) || (intspec[0] > 3)) {
>> +             dev_err(gpt->dev, "bad irq specifier in %s\n", ct->full_name);
>> +             return -ENODEV;
>
> -EINVAL?

Fixed.

>> +     }
>> +
>> +     *out_hwirq = 0; /* The GPT only has 1 IRQ line */
>> +     *out_flags = intspec[0];
>> +
>> +     WARN_ON(*out_flags == 0);
>
> Isn't this already covered by the if above?

Fixed

>> +     spin_unlock_irqrestore(&gpt->lock, flags);
>> +
>> +     dev_dbg(gpt->dev, "%s() complete. virq=%i\n", __func__, cascade_virq);
>> +
>> +     return;
>
> You didn't use return in the other void-functions.

fixed

>> +#if defined(CONFIG_GPIOLIB)
>> +static inline struct mpc52xx_gpt_priv *gc_to_mpc52xx_gpt(struct gpio_chip *gc)
>> +{
>> +     return container_of(to_of_gpio_chip(gc), struct mpc52xx_gpt_priv,of_gc);
>
> Space after ',' !

The space would push the line over the 80 char boundary.  Dropping the
space was tidier than spilling or breaking the line.

>> +     spin_lock_irqsave(&gpt->lock, flags);
>> +     r = in_be32(&gpt->regs->mode) & ~MPC52xx_GPT_MODE_GPIO_MASK;
>> +     if (val)
>> +             out_be32(&gpt->regs->mode, r | MPC52xx_GPT_MODE_GPIO_OUT_HIGH);
>> +     else
>> +             out_be32(&gpt->regs->mode, r | MPC52xx_GPT_MODE_GPIO_OUT_LOW);
>
> What about this?
>
> clrsetbits_be32(&gpt->regs->mode, MPC52xx_GPT_MODE_GPIO_MASK,
>        val ? MPC52xx_GPT_MODE_GPIO_OUT_HIGH : MPC52xx_GPT_MODE_GPIO_OUT_LOW);
>
> (Possibly, it can be broken better to make it more readable)

Reworked.

>
>> +     gpt->of_gc.gc.label = kstrdup(node->full_name, GFP_KERNEL);
>> +     if (!gpt->of_gc.gc.label) {
>> +             dev_err(gpt->dev, "out of memory\n");
>> +             return;
>
> -ENOMEM would be nice here. And then check for it in the calling
> function.

I'm going to think about this some more.  I could do so, but then I'd
need to add a bunch of code for an unwind path when things go wrong,
and just because the GPIO bit fails, it doesn't mean that the IRQ bit
won't work (of course, if it does fail, then things are really sick
and you're going to be digging through the boot log anyway).  Plus
this driver does not support being a module or unbinding the device
because the associated GPIOs and IRQs can potentially be so critical.
I'm tending toward leaving it as is and keeping the patch simple.

>> +     }
>> +
>> +     gpt->of_gc.gpio_cells = 2;
>> +     gpt->of_gc.gc.ngpio = 1;
>> +     gpt->of_gc.gc.direction_input  = mpc52xx_gpt_gpio_dir_in;
>> +     gpt->of_gc.gc.direction_output = mpc52xx_gpt_gpio_dir_out;
>> +     gpt->of_gc.gc.get = mpc52xx_gpt_gpio_get;
>> +     gpt->of_gc.gc.set = mpc52xx_gpt_gpio_set;
>> +     gpt->of_gc.gc.base = -1;
>> +     gpt->of_gc.xlate = of_gpio_simple_xlate;
>> +     node->data = &gpt->of_gc;
>> +     of_node_get(node);
>> +
>> +     /* Setup external pin in GPIO mode */
>> +     val = in_be32(&gpt->regs->mode) & ~MPC52xx_GPT_MODE_MS_MASK;
>> +     out_be32(&gpt->regs->mode, val | MPC52xx_GPT_MODE_MS_GPIO);
>
> clrsetbits_be32

fixed.

>
>> +
>> +     rc = gpiochip_add(&gpt->of_gc.gc);
>> +     if (rc)
>> +             dev_err(gpt->dev, "gpiochip_add() failed; rc=%i\n", rc);
>
> return -Esomething?

same argument as above

>> +     for (i = 0; i < ARRAY_SIZE(mpc52xx_gpt_attrib); i++)
>> +             err |= device_create_file(gpt->dev, &mpc52xx_gpt_attrib[i]);
>
> I think it should give an error for every device that failed but...

fixed

>
>> +
>> +     if (err)
>> +             dev_err(gpt->dev, "device_create_file() failed\n");
>> +}
>> +
>> +#else /* defined(CONFIG_SYSFS) */
>> +static void mpc52xx_gpt_create_attribs(struct mpc52xx_gpt_priv *) { return 0; }
>> +#endif /* defined(CONFIG_SYSFS) */
>
> ...to me the whole sysfs stuff looks like developer-only information.
> I'd rather drop it or make it at least DEBUG. Or you just check the
> registers via memedit [1] and /dev/mem.

It's pretty light weight and very useful for debug on deployed
machines.  I'm going to leave it in (for now, at least until the
driver has some miles under it).

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
