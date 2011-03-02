Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 2/2] powerpc: make MPIC honor the "pic-no-reset"
	device tree property
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Meador Inge <meador_inge@mentor.com>
In-Reply-To: <1298671177-19572-3-git-send-email-meador_inge@mentor.com>
References: <1298671177-19572-1-git-send-email-meador_inge@mentor.com>
	<1298671177-19572-3-git-send-email-meador_inge@mentor.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 02 Mar 2011 14:22:20 +1100
Message-ID: <1299036140.8833.818.camel@pasglop>
Mime-Version: 1.0
Cc: Hollis Blanchard <hollis_blanchard@mentor.com>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> diff --git a/arch/powerpc/include/asm/mpic.h b/arch/powerpc/include/asm/mpic.h
> index e000cce..7e1be12 100644
> --- a/arch/powerpc/include/asm/mpic.h
> +++ b/arch/powerpc/include/asm/mpic.h
> @@ -325,6 +325,8 @@ struct mpic
>  #ifdef CONFIG_PM
>  	struct mpic_irq_save	*save_data;
>  #endif
> +
> +	int cpu;
>  };

Why ? The MPIC isn't specifically associated with a CPU and whatever we
pick as default during boot isn't relevant later on, so I don't see why
we should have global permanent state here.
>  
> +static inline void mpic_init_vector(struct mpic *mpic, int source)
> +{
> +	/* start with vector = source number, and masked */
> +	u32 vecpri = MPIC_VECPRI_MASK | source | (8 << MPIC_VECPRI_PRIORITY_SHIFT);
> +
> +	/* init hw */
> +	mpic_irq_write(source, MPIC_INFO(IRQ_VECTOR_PRI), vecpri);
> +	mpic_irq_write(source, MPIC_INFO(IRQ_DESTINATION), 1 << mpic->cpu);
> +}

Just pass the CPU as an argument... but better... just don't do that,
put the code back where it was and ... see below :-)
 
>  /* Check if we have one of those nice broken MPICs with a flipped endian on
> @@ -622,6 +631,14 @@ static unsigned int mpic_is_ipi(struct mpic *mpic, unsigned int irq)
>  	return (src >= mpic->ipi_vecs[0] && src <= mpic->ipi_vecs[3]);
>  }
>  
> +/* Determine if the linux irq is a timer interrupt */
> +static unsigned int mpic_is_timer_interrupt(struct mpic *mpic, unsigned int irq)
> +{
> +	unsigned int src = mpic_irq_to_hw(irq);
> +
> +	return (src >= mpic->timer_vecs[0] && src <= mpic->timer_vecs[3]);
> +}
> +
>  
>  /* Convert a cpu mask from logical to physical cpu numbers. */
>  static inline u32 mpic_physmask(u32 cpumask)
> @@ -967,6 +984,15 @@ static int mpic_host_map(struct irq_host *h, unsigned int virq,
>  	if (hw >= mpic->irq_count)
>  		return -EINVAL;
>  
> +	/* If the MPIC was reset, then all vectors have already been
> +	 * initialized.  Otherwise, the appropriate vector needs to be
> +	 * initialized here to ensure that only used sources are setup with
> +	 * a vector.
> +	 */
> +	if (mpic->flags & MPIC_NO_RESET)
> +		if (!(mpic_is_ipi(mpic, hw) || mpic_is_timer_interrupt(mpic, hw)))
> +			mpic_init_vector(mpic, hw);
> +

The above isn't useful. Of those two registers you want to initialize,
afaik, one (the destination) will be initialized by the core calling
into set_affinity when the interrupt is requested, and the other one is
partially initialized in set_type, I'd say just modify set_type to
initialize the source as well, and problem solved, no ? Or is there a
chance that the interrupt was left unmasked ? I think it would be kosher
to mask it in set_type unconditionally, I don't think it's ever supposed
to be called for an enabled interrupt.

>  	mpic_msi_reserve_hwirq(mpic, hw);
>  
>  	/* Default chip */
> @@ -1033,6 +1059,11 @@ static struct irq_host_ops mpic_host_ops = {
>  	.xlate = mpic_host_xlate,
>  };
>  
> +static int mpic_reset_prohibited(struct device_node *node)
> +{
> +	return node && of_get_property(node, "pic-no-reset", NULL);
> +}
> +
>  /*
>   * Exported functions
>   */
> @@ -1153,7 +1184,16 @@ struct mpic * __init mpic_alloc(struct device_node *node,
>  	mpic_map(mpic, node, paddr, &mpic->tmregs, MPIC_INFO(TIMER_BASE), 0x1000);
>  
>  	/* Reset */
> -	if (flags & MPIC_WANTS_RESET) {
> +
> +	/* When using a device-node, reset requests are only honored if the MPIC
> +	 * is allowed to reset.
> +	 */
> +	if (mpic_reset_prohibited(node)) {
> +		mpic->flags |= MPIC_NO_RESET;
> +	}

No { } for single line nested statements

> +	if ((flags & MPIC_WANTS_RESET) && !(mpic->flags & MPIC_NO_RESET)) {
> +		printk(KERN_DEBUG "mpic: Resetting\n");
>  		mpic_write(mpic->gregs, MPIC_INFO(GREG_GLOBAL_CONF_0),
>  			   mpic_read(mpic->gregs, MPIC_INFO(GREG_GLOBAL_CONF_0))
>  			   | MPIC_GREG_GCONF_RESET);
> @@ -1270,7 +1310,6 @@ void __init mpic_set_default_senses(struct mpic *mpic, u8 *senses, int count)
>  void __init mpic_init(struct mpic *mpic)
>  {
>  	int i;
> -	int cpu;
>  
>  	BUG_ON(mpic->num_sources == 0);
>  
> @@ -1314,21 +1353,17 @@ void __init mpic_init(struct mpic *mpic)
>  	mpic_pasemi_msi_init(mpic);
>  
>  	if (mpic->flags & MPIC_PRIMARY)
> -		cpu = hard_smp_processor_id();
> +		mpic->cpu = hard_smp_processor_id();
>  	else
> -		cpu = 0;
> +		mpic->cpu = 0;

Get rid of all that.
 
> -	for (i = 0; i < mpic->num_sources; i++) {
> -		/* start with vector = source number, and masked */
> -		u32 vecpri = MPIC_VECPRI_MASK | i |
> -			(8 << MPIC_VECPRI_PRIORITY_SHIFT);
> -		
> -		/* check if protected */
> -		if (mpic->protected && test_bit(i, mpic->protected))
> -			continue;
> -		/* init hw */
> -		mpic_irq_write(i, MPIC_INFO(IRQ_VECTOR_PRI), vecpri);
> -		mpic_irq_write(i, MPIC_INFO(IRQ_DESTINATION), 1 << cpu);
> +	if (!(mpic->flags & MPIC_NO_RESET)) {
> +		for (i = 0; i < mpic->num_sources; i++) {
> +			/* check if protected */
> +			if (mpic->protected && test_bit(i, mpic->protected))
> +				continue;
> +			mpic_init_vector(mpic, i);
> +		}
>  	}
>  	
>  	/* Init spurious vector */

Cheers,
Ben.
