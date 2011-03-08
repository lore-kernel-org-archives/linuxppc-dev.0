Return-Path: <glikely@secretlab.ca>
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9B7E5B7151
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Mar 2011 15:13:39 +1100 (EST)
Received: by gwj23 with SMTP id 23so2548862gwj.15
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 07 Mar 2011 20:13:36 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Mon, 7 Mar 2011 21:13:32 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: [PATCH 01/28] powerpc: mpic irq_data conversion.
Message-ID: <20110308041332.GB23260@angua.secretlab.ca>
References: <cover.1299541392.git.buytenh@wantstofly.org>
	<20110307235902.GF16649@mail.wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110307235902.GF16649@mail.wantstofly.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 08, 2011 at 12:59:02AM +0100, Lennert Buytenhek wrote:
> Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>

Hi Lennert,

I'm taking a look over now and running some build testing.

However, this needs a wider audience for review before it gets merged.
Can you please repost and cc: benh, sfr, tglx, and linux-kernel?

Thanks,
g.

> ---
>  arch/powerpc/include/asm/mpic.h       |    6 +-
>  arch/powerpc/platforms/pasemi/setup.c |    4 +-
>  arch/powerpc/sysdev/mpic.c            |  131 +++++++++++++++++----------------
>  arch/powerpc/sysdev/mpic.h            |    5 +-
>  arch/powerpc/sysdev/mpic_pasemi_msi.c |   18 ++--
>  arch/powerpc/sysdev/mpic_u3msi.c      |   18 ++--
>  6 files changed, 92 insertions(+), 90 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/mpic.h b/arch/powerpc/include/asm/mpic.h
> index e000cce..946ec49 100644
> --- a/arch/powerpc/include/asm/mpic.h
> +++ b/arch/powerpc/include/asm/mpic.h
> @@ -467,11 +467,11 @@ extern void mpic_request_ipis(void);
>  void smp_mpic_message_pass(int target, int msg);
>  
>  /* Unmask a specific virq */
> -extern void mpic_unmask_irq(unsigned int irq);
> +extern void mpic_unmask_irq(struct irq_data *d);
>  /* Mask a specific virq */
> -extern void mpic_mask_irq(unsigned int irq);
> +extern void mpic_mask_irq(struct irq_data *d);
>  /* EOI a specific virq */
> -extern void mpic_end_irq(unsigned int irq);
> +extern void mpic_end_irq(struct irq_data *d);
>  
>  /* Fetch interrupt from a given mpic */
>  extern unsigned int mpic_get_one_irq(struct mpic *mpic);
> diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
> index f372ec1..a6067b3 100644
> --- a/arch/powerpc/platforms/pasemi/setup.c
> +++ b/arch/powerpc/platforms/pasemi/setup.c
> @@ -240,7 +240,7 @@ static __init void pas_init_IRQ(void)
>  		nmi_virq = irq_create_mapping(NULL, *nmiprop);
>  		mpic_irq_set_priority(nmi_virq, 15);
>  		set_irq_type(nmi_virq, IRQ_TYPE_EDGE_RISING);
> -		mpic_unmask_irq(nmi_virq);
> +		mpic_unmask_irq(irq_get_irq_data(nmi_virq));
>  	}
>  
>  	of_node_put(mpic_node);
> @@ -266,7 +266,7 @@ static int pas_machine_check_handler(struct pt_regs *regs)
>  	if (nmi_virq != NO_IRQ && mpic_get_mcirq() == nmi_virq) {
>  		printk(KERN_ERR "NMI delivered\n");
>  		debugger(regs);
> -		mpic_end_irq(nmi_virq);
> +		mpic_end_irq(irq_get_irq_data(nmi_virq));
>  		goto out;
>  	}
>  
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index b0c8469..95712f6 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -611,7 +611,7 @@ static struct mpic *mpic_find(unsigned int irq)
>  	if (irq < NUM_ISA_INTERRUPTS)
>  		return NULL;
>  
> -	return irq_to_desc(irq)->chip_data;
> +	return get_irq_chip_data(irq);
>  }
>  
>  /* Determine if the linux irq is an IPI */
> @@ -636,16 +636,16 @@ static inline u32 mpic_physmask(u32 cpumask)
>  
>  #ifdef CONFIG_SMP
>  /* Get the mpic structure from the IPI number */
> -static inline struct mpic * mpic_from_ipi(unsigned int ipi)
> +static inline struct mpic * mpic_from_ipi(struct irq_data *d)
>  {
> -	return irq_to_desc(ipi)->chip_data;
> +	return irq_data_get_irq_chip_data(d);
>  }
>  #endif
>  
>  /* Get the mpic structure from the irq number */
>  static inline struct mpic * mpic_from_irq(unsigned int irq)
>  {
> -	return irq_to_desc(irq)->chip_data;
> +	return get_irq_chip_data(irq);
>  }
>  
>  /* Send an EOI */
> @@ -660,13 +660,13 @@ static inline void mpic_eoi(struct mpic *mpic)
>   */
>  
>  
> -void mpic_unmask_irq(unsigned int irq)
> +void mpic_unmask_irq(struct irq_data *d)
>  {
>  	unsigned int loops = 100000;
> -	struct mpic *mpic = mpic_from_irq(irq);
> -	unsigned int src = mpic_irq_to_hw(irq);
> +	struct mpic *mpic = mpic_from_irq(d->irq);
> +	unsigned int src = mpic_irq_to_hw(d->irq);
>  
> -	DBG("%p: %s: enable_irq: %d (src %d)\n", mpic, mpic->name, irq, src);
> +	DBG("%p: %s: enable_irq: %d (src %d)\n", mpic, mpic->name, d->irq, src);
>  
>  	mpic_irq_write(src, MPIC_INFO(IRQ_VECTOR_PRI),
>  		       mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI)) &
> @@ -681,13 +681,13 @@ void mpic_unmask_irq(unsigned int irq)
>  	} while(mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI)) & MPIC_VECPRI_MASK);
>  }
>  
> -void mpic_mask_irq(unsigned int irq)
> +void mpic_mask_irq(struct irq_data *d)
>  {
>  	unsigned int loops = 100000;
> -	struct mpic *mpic = mpic_from_irq(irq);
> -	unsigned int src = mpic_irq_to_hw(irq);
> +	struct mpic *mpic = mpic_from_irq(d->irq);
> +	unsigned int src = mpic_irq_to_hw(d->irq);
>  
> -	DBG("%s: disable_irq: %d (src %d)\n", mpic->name, irq, src);
> +	DBG("%s: disable_irq: %d (src %d)\n", mpic->name, d->irq, src);
>  
>  	mpic_irq_write(src, MPIC_INFO(IRQ_VECTOR_PRI),
>  		       mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI)) |
> @@ -703,12 +703,12 @@ void mpic_mask_irq(unsigned int irq)
>  	} while(!(mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI)) & MPIC_VECPRI_MASK));
>  }
>  
> -void mpic_end_irq(unsigned int irq)
> +void mpic_end_irq(struct irq_data *d)
>  {
> -	struct mpic *mpic = mpic_from_irq(irq);
> +	struct mpic *mpic = mpic_from_irq(d->irq);
>  
>  #ifdef DEBUG_IRQ
> -	DBG("%s: end_irq: %d\n", mpic->name, irq);
> +	DBG("%s: end_irq: %d\n", mpic->name, d->irq);
>  #endif
>  	/* We always EOI on end_irq() even for edge interrupts since that
>  	 * should only lower the priority, the MPIC should have properly
> @@ -720,51 +720,51 @@ void mpic_end_irq(unsigned int irq)
>  
>  #ifdef CONFIG_MPIC_U3_HT_IRQS
>  
> -static void mpic_unmask_ht_irq(unsigned int irq)
> +static void mpic_unmask_ht_irq(struct irq_data *d)
>  {
> -	struct mpic *mpic = mpic_from_irq(irq);
> -	unsigned int src = mpic_irq_to_hw(irq);
> +	struct mpic *mpic = mpic_from_irq(d->irq);
> +	unsigned int src = mpic_irq_to_hw(d->irq);
>  
> -	mpic_unmask_irq(irq);
> +	mpic_unmask_irq(d);
>  
> -	if (irq_to_desc(irq)->status & IRQ_LEVEL)
> +	if (irq_to_desc(d->irq)->status & IRQ_LEVEL)
>  		mpic_ht_end_irq(mpic, src);
>  }
>  
> -static unsigned int mpic_startup_ht_irq(unsigned int irq)
> +static unsigned int mpic_startup_ht_irq(struct irq_data *d)
>  {
> -	struct mpic *mpic = mpic_from_irq(irq);
> -	unsigned int src = mpic_irq_to_hw(irq);
> +	struct mpic *mpic = mpic_from_irq(d->irq);
> +	unsigned int src = mpic_irq_to_hw(d->irq);
>  
> -	mpic_unmask_irq(irq);
> -	mpic_startup_ht_interrupt(mpic, src, irq_to_desc(irq)->status);
> +	mpic_unmask_irq(d);
> +	mpic_startup_ht_interrupt(mpic, src, irq_to_desc(d->irq)->status);
>  
>  	return 0;
>  }
>  
> -static void mpic_shutdown_ht_irq(unsigned int irq)
> +static void mpic_shutdown_ht_irq(struct irq_data *d)
>  {
> -	struct mpic *mpic = mpic_from_irq(irq);
> -	unsigned int src = mpic_irq_to_hw(irq);
> +	struct mpic *mpic = mpic_from_irq(d->irq);
> +	unsigned int src = mpic_irq_to_hw(d->irq);
>  
> -	mpic_shutdown_ht_interrupt(mpic, src, irq_to_desc(irq)->status);
> -	mpic_mask_irq(irq);
> +	mpic_shutdown_ht_interrupt(mpic, src, irq_to_desc(d->irq)->status);
> +	mpic_mask_irq(d);
>  }
>  
> -static void mpic_end_ht_irq(unsigned int irq)
> +static void mpic_end_ht_irq(struct irq_data *d)
>  {
> -	struct mpic *mpic = mpic_from_irq(irq);
> -	unsigned int src = mpic_irq_to_hw(irq);
> +	struct mpic *mpic = mpic_from_irq(d->irq);
> +	unsigned int src = mpic_irq_to_hw(d->irq);
>  
>  #ifdef DEBUG_IRQ
> -	DBG("%s: end_irq: %d\n", mpic->name, irq);
> +	DBG("%s: end_irq: %d\n", mpic->name, d->irq);
>  #endif
>  	/* We always EOI on end_irq() even for edge interrupts since that
>  	 * should only lower the priority, the MPIC should have properly
>  	 * latched another edge interrupt coming in anyway
>  	 */
>  
> -	if (irq_to_desc(irq)->status & IRQ_LEVEL)
> +	if (irq_to_desc(d->irq)->status & IRQ_LEVEL)
>  		mpic_ht_end_irq(mpic, src);
>  	mpic_eoi(mpic);
>  }
> @@ -772,23 +772,23 @@ static void mpic_end_ht_irq(unsigned int irq)
>  
>  #ifdef CONFIG_SMP
>  
> -static void mpic_unmask_ipi(unsigned int irq)
> +static void mpic_unmask_ipi(struct irq_data *d)
>  {
> -	struct mpic *mpic = mpic_from_ipi(irq);
> -	unsigned int src = mpic_irq_to_hw(irq) - mpic->ipi_vecs[0];
> +	struct mpic *mpic = mpic_from_ipi(d);
> +	unsigned int src = mpic_irq_to_hw(d->irq) - mpic->ipi_vecs[0];
>  
> -	DBG("%s: enable_ipi: %d (ipi %d)\n", mpic->name, irq, src);
> +	DBG("%s: enable_ipi: %d (ipi %d)\n", mpic->name, d->irq, src);
>  	mpic_ipi_write(src, mpic_ipi_read(src) & ~MPIC_VECPRI_MASK);
>  }
>  
> -static void mpic_mask_ipi(unsigned int irq)
> +static void mpic_mask_ipi(struct irq_data *d)
>  {
>  	/* NEVER disable an IPI... that's just plain wrong! */
>  }
>  
> -static void mpic_end_ipi(unsigned int irq)
> +static void mpic_end_ipi(struct irq_data *d)
>  {
> -	struct mpic *mpic = mpic_from_ipi(irq);
> +	struct mpic *mpic = mpic_from_ipi(d);
>  
>  	/*
>  	 * IPIs are marked IRQ_PER_CPU. This has the side effect of
> @@ -802,10 +802,11 @@ static void mpic_end_ipi(unsigned int irq)
>  
>  #endif /* CONFIG_SMP */
>  
> -int mpic_set_affinity(unsigned int irq, const struct cpumask *cpumask)
> +int mpic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
> +		      bool force)
>  {
> -	struct mpic *mpic = mpic_from_irq(irq);
> -	unsigned int src = mpic_irq_to_hw(irq);
> +	struct mpic *mpic = mpic_from_irq(d->irq);
> +	unsigned int src = mpic_irq_to_hw(d->irq);
>  
>  	if (mpic->flags & MPIC_SINGLE_DEST_CPU) {
>  		int cpuid = irq_choose_cpu(cpumask);
> @@ -848,15 +849,15 @@ static unsigned int mpic_type_to_vecpri(struct mpic *mpic, unsigned int type)
>  	}
>  }
>  
> -int mpic_set_irq_type(unsigned int virq, unsigned int flow_type)
> +int mpic_set_irq_type(struct irq_data *d, unsigned int flow_type)
>  {
> -	struct mpic *mpic = mpic_from_irq(virq);
> -	unsigned int src = mpic_irq_to_hw(virq);
> -	struct irq_desc *desc = irq_to_desc(virq);
> +	struct mpic *mpic = mpic_from_irq(d->irq);
> +	unsigned int src = mpic_irq_to_hw(d->irq);
> +	struct irq_desc *desc = irq_to_desc(d->irq);
>  	unsigned int vecpri, vold, vnew;
>  
>  	DBG("mpic: set_irq_type(mpic:@%p,virq:%d,src:0x%x,type:0x%x)\n",
> -	    mpic, virq, src, flow_type);
> +	    mpic, d->irq, src, flow_type);
>  
>  	if (src >= mpic->irq_count)
>  		return -EINVAL;
> @@ -907,28 +908,28 @@ void mpic_set_vector(unsigned int virq, unsigned int vector)
>  }
>  
>  static struct irq_chip mpic_irq_chip = {
> -	.mask		= mpic_mask_irq,
> -	.unmask		= mpic_unmask_irq,
> -	.eoi		= mpic_end_irq,
> -	.set_type	= mpic_set_irq_type,
> +	.irq_mask	= mpic_mask_irq,
> +	.irq_unmask	= mpic_unmask_irq,
> +	.irq_eoi	= mpic_end_irq,
> +	.irq_set_type	= mpic_set_irq_type,
>  };
>  
>  #ifdef CONFIG_SMP
>  static struct irq_chip mpic_ipi_chip = {
> -	.mask		= mpic_mask_ipi,
> -	.unmask		= mpic_unmask_ipi,
> -	.eoi		= mpic_end_ipi,
> +	.irq_mask	= mpic_mask_ipi,
> +	.irq_unmask	= mpic_unmask_ipi,
> +	.irq_eoi	= mpic_end_ipi,
>  };
>  #endif /* CONFIG_SMP */
>  
>  #ifdef CONFIG_MPIC_U3_HT_IRQS
>  static struct irq_chip mpic_irq_ht_chip = {
> -	.startup	= mpic_startup_ht_irq,
> -	.shutdown	= mpic_shutdown_ht_irq,
> -	.mask		= mpic_mask_irq,
> -	.unmask		= mpic_unmask_ht_irq,
> -	.eoi		= mpic_end_ht_irq,
> -	.set_type	= mpic_set_irq_type,
> +	.irq_startup	= mpic_startup_ht_irq,
> +	.irq_shutdown	= mpic_shutdown_ht_irq,
> +	.irq_mask	= mpic_mask_irq,
> +	.irq_unmask	= mpic_unmask_ht_irq,
> +	.irq_eoi	= mpic_end_ht_irq,
> +	.irq_set_type	= mpic_set_irq_type,
>  };
>  #endif /* CONFIG_MPIC_U3_HT_IRQS */
>  
> @@ -1060,12 +1061,12 @@ struct mpic * __init mpic_alloc(struct device_node *node,
>  	mpic->hc_irq = mpic_irq_chip;
>  	mpic->hc_irq.name = name;
>  	if (flags & MPIC_PRIMARY)
> -		mpic->hc_irq.set_affinity = mpic_set_affinity;
> +		mpic->hc_irq.irq_set_affinity = mpic_set_affinity;
>  #ifdef CONFIG_MPIC_U3_HT_IRQS
>  	mpic->hc_ht_irq = mpic_irq_ht_chip;
>  	mpic->hc_ht_irq.name = name;
>  	if (flags & MPIC_PRIMARY)
> -		mpic->hc_ht_irq.set_affinity = mpic_set_affinity;
> +		mpic->hc_ht_irq.irq_set_affinity = mpic_set_affinity;
>  #endif /* CONFIG_MPIC_U3_HT_IRQS */
>  
>  #ifdef CONFIG_SMP
> diff --git a/arch/powerpc/sysdev/mpic.h b/arch/powerpc/sysdev/mpic.h
> index e4a6df7..13f3e89 100644
> --- a/arch/powerpc/sysdev/mpic.h
> +++ b/arch/powerpc/sysdev/mpic.h
> @@ -34,9 +34,10 @@ static inline int mpic_pasemi_msi_init(struct mpic *mpic)
>  }
>  #endif
>  
> -extern int mpic_set_irq_type(unsigned int virq, unsigned int flow_type);
> +extern int mpic_set_irq_type(struct irq_data *d, unsigned int flow_type);
>  extern void mpic_set_vector(unsigned int virq, unsigned int vector);
> -extern int mpic_set_affinity(unsigned int irq, const struct cpumask *cpumask);
> +extern int mpic_set_affinity(struct irq_data *d,
> +			     const struct cpumask *cpumask, bool force);
>  extern void mpic_reset_core(int cpu);
>  
>  #endif /* _POWERPC_SYSDEV_MPIC_H */
> diff --git a/arch/powerpc/sysdev/mpic_pasemi_msi.c b/arch/powerpc/sysdev/mpic_pasemi_msi.c
> index 320ad5a..0b7794a 100644
> --- a/arch/powerpc/sysdev/mpic_pasemi_msi.c
> +++ b/arch/powerpc/sysdev/mpic_pasemi_msi.c
> @@ -43,24 +43,24 @@ static void mpic_pasemi_msi_mask_irq(struct irq_data *data)
>  {
>  	pr_debug("mpic_pasemi_msi_mask_irq %d\n", data->irq);
>  	mask_msi_irq(data);
> -	mpic_mask_irq(data->irq);
> +	mpic_mask_irq(data);
>  }
>  
>  static void mpic_pasemi_msi_unmask_irq(struct irq_data *data)
>  {
>  	pr_debug("mpic_pasemi_msi_unmask_irq %d\n", data->irq);
> -	mpic_unmask_irq(data->irq);
> +	mpic_unmask_irq(data);
>  	unmask_msi_irq(data);
>  }
>  
>  static struct irq_chip mpic_pasemi_msi_chip = {
> -	.irq_shutdown	= mpic_pasemi_msi_mask_irq,
> -	.irq_mask	= mpic_pasemi_msi_mask_irq,
> -	.irq_unmask	= mpic_pasemi_msi_unmask_irq,
> -	.eoi		= mpic_end_irq,
> -	.set_type	= mpic_set_irq_type,
> -	.set_affinity	= mpic_set_affinity,
> -	.name		= "PASEMI-MSI",
> +	.irq_shutdown		= mpic_pasemi_msi_mask_irq,
> +	.irq_mask		= mpic_pasemi_msi_mask_irq,
> +	.irq_unmask		= mpic_pasemi_msi_unmask_irq,
> +	.irq_eoi		= mpic_end_irq,
> +	.irq_set_type		= mpic_set_irq_type,
> +	.irq_set_affinity	= mpic_set_affinity,
> +	.name			= "PASEMI-MSI",
>  };
>  
>  static int pasemi_msi_check_device(struct pci_dev *pdev, int nvec, int type)
> diff --git a/arch/powerpc/sysdev/mpic_u3msi.c b/arch/powerpc/sysdev/mpic_u3msi.c
> index a2b028b..71900ac 100644
> --- a/arch/powerpc/sysdev/mpic_u3msi.c
> +++ b/arch/powerpc/sysdev/mpic_u3msi.c
> @@ -26,23 +26,23 @@ static struct mpic *msi_mpic;
>  static void mpic_u3msi_mask_irq(struct irq_data *data)
>  {
>  	mask_msi_irq(data);
> -	mpic_mask_irq(data->irq);
> +	mpic_mask_irq(data);
>  }
>  
>  static void mpic_u3msi_unmask_irq(struct irq_data *data)
>  {
> -	mpic_unmask_irq(data->irq);
> +	mpic_unmask_irq(data);
>  	unmask_msi_irq(data);
>  }
>  
>  static struct irq_chip mpic_u3msi_chip = {
> -	.irq_shutdown	= mpic_u3msi_mask_irq,
> -	.irq_mask	= mpic_u3msi_mask_irq,
> -	.irq_unmask	= mpic_u3msi_unmask_irq,
> -	.eoi		= mpic_end_irq,
> -	.set_type	= mpic_set_irq_type,
> -	.set_affinity	= mpic_set_affinity,
> -	.name		= "MPIC-U3MSI",
> +	.irq_shutdown		= mpic_u3msi_mask_irq,
> +	.irq_mask		= mpic_u3msi_mask_irq,
> +	.irq_unmask		= mpic_u3msi_unmask_irq,
> +	.irq_eoi		= mpic_end_irq,
> +	.irq_set_type		= mpic_set_irq_type,
> +	.irq_set_affinity	= mpic_set_affinity,
> +	.name			= "MPIC-U3MSI",
>  };
>  
>  static u64 read_ht_magic_addr(struct pci_dev *pdev, unsigned int pos)
> -- 
> 1.7.4
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
