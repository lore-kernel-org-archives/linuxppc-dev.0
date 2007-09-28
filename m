Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id BC5A1DDE3F
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 06:13:54 +1000 (EST)
Date: Fri, 28 Sep 2007 15:17:19 -0500
From: Olof Johansson <olof@lixom.net>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 03/18] Virtex: add xilinx interrupt controller driver
Message-ID: <20070928201719.GA23749@lixom.net>
References: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
	<20070928181606.18608.30412.stgit@trillian.cg.shawcable.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070928181606.18608.30412.stgit@trillian.cg.shawcable.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 28, 2007 at 12:16:07PM -0600, Grant Likely wrote:

> +/*
> + * INTC Registers
> + */
> +#define ISR	0	/* Interrupt Status */
> +#define IPR	4	/* Interrupt Pending */
> +#define IER	8	/* Interrupt Enable */
> +#define IAR	12	/* Interrupt Acknowledge */
> +#define SIE	16	/* Set Interrupt Enable bits */
> +#define CIE	20	/* Clear Interrupt Enable bits */
> +#define IVR	24	/* Interrupt Vector */
> +#define MER	28	/* Master Enable */

The defines are fairly generic, I guess you haven't ran across cases
where there's naming conflicts, but you might want to prefix them with
something more unique just in case.

> +static struct irq_host *master_irqhost;
> +
> +/*
> + * IRQ Chip operations
> + */
> +static void xilinx_intc_mask(unsigned int virq)
> +{
> +	int irq = irq_map[virq].hwirq;
> +	void * regs = get_irq_chip_data(virq);
> +	pr_debug("mask: %d\n", irq);
> +	out_be32(regs + CIE, 1 << irq);
> +}
> +
> +static void xilinx_intc_unmask(unsigned int virq)
> +{
> +	int irq = irq_map[virq].hwirq;
> +	void * regs = get_irq_chip_data(virq);
> +	pr_debug("unmask: %d\n", irq);
> +	out_be32(regs + SIE, 1 << irq);
> +}
> +
> +static void xilinx_intc_ack(unsigned int virq)
> +{
> +	int irq = irq_map[virq].hwirq;
> +	void * regs = get_irq_chip_data(virq);
> +	pr_debug("ack: %d\n", irq);
> +	out_be32(regs + IAR, 1 << irq);
> +}

I guess some of the above are open-coded instead of using virq_to_hw()
for performance reasons, it could be useful to have comments regarding
this so they aren't changed by some janitor down the road. Or, in case
they're not performance-critical, change them to use virq_to_hw.


-Olof
