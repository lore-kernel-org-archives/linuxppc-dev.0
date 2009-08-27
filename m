Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E7E7AB7B70
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Aug 2009 14:16:07 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4F348DDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 14:16:07 +1000 (EST)
Subject: Re: [PATCH] powerpc: add cascade support to xilinx intc controller
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20090825060848.3913.60710.stgit@localhost.localdomain>
References: <20090825060848.3913.60710.stgit@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 27 Aug 2009 14:15:57 +1000
Message-Id: <1251346557.20467.26.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, john.linn@xilinx.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-08-25 at 00:08 -0600, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> This patch allows the Xilinx intc interrupt controller to be cascaded
> instead of being the master irqhost.  Useful when attaching an FPGA
> to an SoC that has its own interrupt controller.

Something doesn't look quite right ...

>  /*
> + * Cascaded Xilinx interrupt controller
> + */
> +static void xilinx_intc_cascade(unsigned int virq, struct irq_desc *desc)
> +{
> +	struct irq_host *cascade_irqhost = get_irq_data(virq);
> +	void *regs = cascade_irqhost->host_data;
> +	unsigned int cascade_virq;
> +
> +	pr_debug("%s(virq=%i) irq_host=%p\n", __func__, virq, cascade_irqhost);
> +	cascade_virq = irq_linear_revmap(cascade_irqhost,
> +					 in_be32(regs + XINTC_IVR));
> +	if (cascade_virq)
> +		generic_handle_irq(cascade_virq);
> +}

The cascade handler generally has to be part of the -host- controller or
the platform code (we should try maybe to invent a way to make that
more transparent but today it's not) because it may need to do special
things to ack the interrupt on the host controller.

For example, if I have an MPIC based setup with a cascaded xilinx FPGA,
I want to use something that does the EOI right on the MPIC. In fact,
it's -almost- like what we need to do for a cascade, is to find a way to
stick a get_irq() function pointer somewhere in the irq-desc for the
cascaded interrupt, and have in the -host- a generic cascade handler.

Also, you seem to be trying to do the revmap of the child interrupt
using the parent host.. .that doesn't make sense. Each PIC has it's own
revmap and the child PIC uses it's own revmap as well.

The rest of the code seems to entertain a similar confusion...

Cheers,
Ben.

> +/**
> + * xilinx_intc_cascade_setup - Add a xilinx intc device as a cascaded controller
> + * @cascade_node: device node for xilinx intc controller.
> + */
> +int xilinx_intc_cascade_setup(struct device_node *cascade_node)
> +{
> +	struct irq_host *cascade_irqhost;
> +	int cascade_virq;
> +
> +	if (!cascade_node) {
> +		pr_err("%s(): cannot find xilinx intc node\n", __func__);
> +		return -ENODEV;
> +	}
> +
> +	/* Make sure this is a xilinx intc device */
> +	if (!of_match_node(xilinx_intc_match, cascade_node)) {
> +		pr_err("%s(): %s is not compatible\n",
> +			__func__, cascade_node->name);
> +		return -EINVAL;
> +	}
> +
> +	/* Map a VIRQ for the cascaded handler */
> +	cascade_virq = irq_of_parse_and_map(cascade_node, 0);
> +	if (!cascade_virq) {
> +		pr_err("%s(): error mapping cascade interrupt\n", __func__);
> +		return -ENODEV;
> +	}
> +
> +	/* Set up the irqhost and register it */
> +	cascade_irqhost = xilinx_intc_init(cascade_node);
> +	set_irq_data(cascade_virq, cascade_irqhost);
> +	set_irq_chained_handler(cascade_virq, xilinx_intc_cascade);
> +
> +	pr_debug("%s(): cascading virq %i to irq_host %p\n",
> +		 __func__, cascade_virq, cascade_irqhost);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(xilinx_intc_cascade_setup);
> +
> +/*
>   * Initialize master Xilinx interrupt controller
>   */
>  void __init xilinx_intc_init_tree(void)
