Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] Add MPC52xx Interrupt controller support for
	ARCH=powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicolas DET <nd@bplan-gmbh.de>
In-Reply-To: <200610292310.k9TNAHXZ013852@post.webmailer.de>
References: <200610292310.k9TNAHXZ013852@post.webmailer.de>
Content-Type: text/plain
Date: Tue, 31 Oct 2006 15:27:10 +1100
Message-Id: <1162268830.25682.271.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, sl@bplan-gmbh.de, sha@pengutronix.de,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-10-30 at 00:10 +0100, Nicolas DET wrote:

> +/*
> + * void call to be used for .ack in the irq_chip_ops
> + * indeed, some of our irq does noy need ack
> + * but the kernel call .ack if it's valid or not
> +*/
> +
> +static void mpc52xx_voidfunc(unsigned int virq)
> +{
> +#ifdef DEBUG
> +       int irq;
> +       int l2irq;
> +
> +       irq = irq_map[virq].hwirq;
> +       l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
> +
> +       pr_debug("%s: irq=%x, l2=%d\n", __func__, irq, l2irq);
> +#endif
> +}

As I said on IRC, we might be able to get away without that one, but
that's not urgent.

> +       irq = irq_map[virq].hwirq;
> +       l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
> +
> +       pr_debug("%s: irq=%x, l2=%d\n", __func__, irq, l2irq);
> +
> +       if (l2irq != 0)
> +               BUG();

Use BUG_ON(l2irq != 0); instead, generates better code (though I don't
think you really need to keep those checks once you've verified things
work fine).

> +       val = in_be32(&intr->ctrl);
> +       val &= ~(1 << 11);
> +       out_be32(&intr->ctrl, val);
> +}

>From the above, I deduce there is only one possible crit interrupt
right ? Also, it looks a lot, from the rest of the code that it's
basically just "main irq" 0, so why do you do two different L2's for
it ?

In fact, I'm a bit dubious of the way you differenciated "mainirq" and
"main" by giving them the same L2 number while they have different chips
and register sets... that seems to defeat the whole purpose of having
the L2 in the first place don't you think ?

I would have rather an L2 for CRIT + "IRQMAIN" thing (that is interrupts
using intr->ctrl bits 11 and below, I'll let you find a nice "name" for
it, maybe EXTIRQ ? (external irq), then a level for "MAIN" using
intr->main_mask etc... 

> +       case MPC52xx_IRQ_L1_CRIT:
> +               pr_debug("%s: Critical. l2=%x\n", __func__, l2irq);
> +
> +               if (l2irq != 0)
> +                       BUG();
> +
> +               type = mpc52xx_irqx_gettype(l2irq);
> +               good_irqchip = &mpc52xx_crit_irqchip;
> +               break;
> +
> +       case MPC52xx_IRQ_L1_MAIN:
> +               pr_debug("%s: Main IRQ[1-3] l2=%x\n", __func__, l2irq);
> +
> +               if ((l2irq >= 0) && (l2irq <= 3)) {
> +                       type = mpc52xx_irqx_gettype(l2irq);
> +                       good_irqchip = &mpc52xx_mainirq_irqchip;
> +               } else {
> +                       good_irqchip = &mpc52xx_main_irqchip;
> +               }
> +               break;

See my comment above... Also, the only ones that can be edge are the
ones using intr->ctrl, thus if you do things right, you don't need your
fake ack, just only provide an ack for these. For the others, provide an
ack&mask that just masks :) (Though it's debateable wether we should
make the generic ack&mask test for ack beeing NULL indeed, I'll talk to
thomas about it).

> +       case MPC52xx_IRQ_L1_PERP:
> +               pr_debug("%s: Peripherals. l2=%x\n", __func__, l2irq);
> +               good_irqchip = &mpc52xx_periph_irqchip;
> +               break;
> +
> +       case MPC52xx_IRQ_L1_SDMA:
> +               pr_debug("%s: SDMA. l2=%x\n", __func__, l2irq);
> +               good_irqchip = &mpc52xx_sdma_irqchip;
> +               break;
> +
> +       set_irq_chip_and_handler(virq, good_irqchip, good_handle);
> +       set_irq_type(virq, type);

set_irq_type() does nothing if you haven't hooked a set_type callback to
your irq_chip and none of yours does so just drop it for now and look at
how this is done in mpic or ipic. If you actually want to implement
proper set_type (which you might need to do if you want that code to
work without having the firmware pre-initialize interrupts with the
right type at boot), you probably want to set the handler in
set_irq_type().
