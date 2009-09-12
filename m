Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 74F88B70C4
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Sep 2009 16:28:52 +1000 (EST)
Subject: Re: [RFC] powerpc/irq: Add generic API for setting up cascaded IRQs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20090912054410.21847.63718.stgit@localhost.localdomain>
References: <20090912054410.21847.63718.stgit@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 12 Sep 2009 16:28:44 +1000
Message-Id: <1252736925.8375.65.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-09-11 at 23:46 -0600, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> prototype implementation.  This probably doesn't work at all right now.
> 
> Ben, I'm posting this now to get your thoughts before I go too far down
> this path.

Looks ok. I was initially thinking about putting get_irq() in irq_host,
but as we discussed on IRC, a host is not necessarily a PIC, and it's
nice for the parent to have a way to setup/init the cascade in case
it needs to do some HW tweaking there as well.

However, why cascade_setup() and not setup_cascade() which sounds
somewhat more natural ? :-)

Cheers,
Ben.

> Cheers,
> g.
> 
> ---
> 
>  arch/powerpc/include/asm/irq.h            |    3 ++
>  arch/powerpc/kernel/irq.c                 |   20 +++++++++++++++
>  arch/powerpc/platforms/52xx/mpc52xx_pic.c |   39 +++++++++++++++++++++++++++++
>  3 files changed, 62 insertions(+), 0 deletions(-)
> 
> 
> diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/irq.h
> index 0a51376..014e1e8 100644
> --- a/arch/powerpc/include/asm/irq.h
> +++ b/arch/powerpc/include/asm/irq.h
> @@ -90,6 +90,9 @@ struct irq_host_ops {
>  	/* Update of such a mapping  */
>  	void (*remap)(struct irq_host *h, unsigned int virq, irq_hw_number_t hw);
>  
> +	/* Setup hook for cascade irqs */
> +	int (*cascade_setup)(int virq, int (*get_irq)(void *data), void *data);
> +
>  	/* Translate device-tree interrupt specifier from raw format coming
>  	 * from the firmware to a irq_hw_number_t (interrupt line number) and
>  	 * type (sense) that can be passed to set_irq_type(). In the absence
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index f7f376e..5a9cb46 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -750,6 +750,26 @@ unsigned int irq_of_parse_and_map(struct device_node *dev, int index)
>  }
>  EXPORT_SYMBOL_GPL(irq_of_parse_and_map);
>  
> +unsigned int irq_of_cascade_setup(int virq, int (*get_irq)(void *data),
> +				  void *data)
> +{
> +	struct irq_host *host = irq_map[virq].host;
> +
> +	if (!host) {
> +		pr_err("error: no irq host found virq %i !\n", virq);
> +		return -ENODEV;
> +	}
> +
> +	/* If host has no cascade setup function, then this method for
> +	 * setting up a cascade is not available */
> +	if (!host->ops->cascade_setup) {
> +		pr_err("error: no cascade_setup support on virq %i\n", virq);
> +		return -EINVAL;
> +	}
> +
> +	return host->ops->cascade_setup(virq, get_irq, data);
> +}
> +
>  void irq_dispose_mapping(unsigned int virq)
>  {
>  	struct irq_host *host;
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
> index 480f806..a91c69b 100644
> --- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
> @@ -437,9 +437,48 @@ static int mpc52xx_irqhost_map(struct irq_host *h, unsigned int virq,
>  	return 0;
>  }
>  
> +struct mpc52xx_cascade_data {
> +	int (*get_irq)(void *data);
> +	void *data;
> +};
> +
> +void mpc52xx_handle_level_cascade(unsigned int irq, struct irq_desc *desc)
> +{
> +	struct mpc52xx_cascade_data *cascade_data = get_irq_desc_data(desc);
> +	int cascade_virq;
> +
> +	cascade_virq = cascade_data->get_irq(cascade_data->data);
> +	if (cascade_virq)
> +		generic_handle_irq(cascade_virq);
> +}
> +
> +void mpc52xx_handle_edge_cascade(unsigned int virq, struct irq_desc *desc)
> +{
> +	mpc52xx_handle_level_cascade(virq, desc);
> +	/** TODO: clear edge IRQ here **/
> +}
> +
> +int mpc52xx_cascade_setup(int virq, int (*get_irq)(void *data), void *data)
> +{
> +	struct mpc52xx_cascade_data *cascade_data;
> +
> +	cascade_data = kzalloc(sizeof(struct mpc52xx_cascade_data), GFP_KERNEL);
> +	if (!cascade_data)
> +		return -ENOMEM;
> +
> +	/* TODO: make this handle edge cascades too */
> +	cascade_data->get_irq = get_irq;
> +	cascade_data->data = data;
> +	set_irq_data(virq, cascade_data);
> +	set_irq_chained_handler(virq, mpc52xx_handle_level_cascade);
> +
> +	return 0;
> +}
> +
>  static struct irq_host_ops mpc52xx_irqhost_ops = {
>  	.xlate = mpc52xx_irqhost_xlate,
>  	.map = mpc52xx_irqhost_map,
> +	.cascade_setup = mpc52xx_cascade_setup,
>  };
>  
>  /**
