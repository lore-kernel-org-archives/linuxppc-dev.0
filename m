Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F2B0D67C06
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2006 13:45:02 +1000 (EST)
Subject: Re: [PATCH 1/3] Adapt ipic driver to new host_ops interface, add
	set_irq_type to set IRQ sense
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kim Phillips <kim.phillips@freescale.com>
In-Reply-To: <20060823203928.3c5f9509.kim.phillips@freescale.com>
References: <20060823203928.3c5f9509.kim.phillips@freescale.com>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 13:44:41 +1000
Message-Id: <1156391081.8433.164.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-08-23 at 20:39 -0500, Kim Phillips wrote:

A lot of it looks good, a few nits though:

> -static void ipic_disable_irq_and_ack(unsigned int irq)
> +static void ipic_ack_irq(unsigned int virq)
>  {
> -	struct ipic *ipic = ipic_from_irq(irq);
> -	unsigned int src = irq - ipic->irq_offset;
> +	struct ipic *ipic = ipic_from_irq(virq);
> +	unsigned int src = ipic_irq_to_hw(virq);
>  	u32 temp;
>  
> -	ipic_disable_irq(irq);
> +	temp = ipic_read(ipic->regs, ipic_info[src].pend);
> +	temp |= (1 << (31 - ipic_info[src].bit));
> +	ipic_write(ipic->regs, ipic_info[src].pend, temp);
> +}

You should have a spinlock protecting you here as you are or'ing bits in
that register from several interrupt sources. The common code provides a
per-source spinlock, but various sources mask/ack routines might be
racing.

> +static void ipic_mask_irq_and_ack(unsigned int virq)
> +{
> +	struct ipic *ipic = ipic_from_irq(virq);
> +	unsigned int src = ipic_irq_to_hw(virq);
> +	u32 temp;
> +
> +	temp = ipic_read(ipic->regs, ipic_info[src].mask);
> +	temp &= ~(1 << (31 - ipic_info[src].bit));
> +	ipic_write(ipic->regs, ipic_info[src].mask, temp);
>  
>  	temp = ipic_read(ipic->regs, ipic_info[src].pend);
>  	temp |= (1 << (31 - ipic_info[src].bit));
>  	ipic_write(ipic->regs, ipic_info[src].pend, temp);
>  }

Same comment as above.
 
> -static void ipic_end_irq(unsigned int irq)
> +static void ipic_end_irq(unsigned int virq)
> +{
> +	if (!(irq_desc[virq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
> +		ipic_unmask_irq(virq);
> +}

You should not need the above. It depends which handler you are using.
If you use the level/edge handlers, they should take care of doing the
appropriate unmasking when necessary (look at kernel/irq/chip.c)

> +static int ipic_set_irq_type(unsigned int virq, unsigned int flow_type)
> +{
> +	struct ipic *ipic = ipic_from_irq(virq);
> +	unsigned int src = ipic_irq_to_hw(virq);
> +	struct irq_desc *desc = get_irq_desc(virq);
> +	unsigned int vold, vnew, edibit;
> +
> +	if (flow_type == IRQ_TYPE_NONE)
> +		flow_type = IRQ_TYPE_LEVEL_LOW;
> +	if (!(flow_type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_EDGE_FALLING))) {
> +		printk(KERN_ERR "ipic: sense type 0x%x not supported\n",
> +			flow_type);
> +		return -EINVAL;
> +	}
> +
> +	desc->status &= ~(IRQ_TYPE_SENSE_MASK | IRQ_LEVEL);
> +	desc->status |= flow_type & IRQ_TYPE_SENSE_MASK;
> +	if (flow_type & IRQ_TYPE_LEVEL_LOW)  {
> +		desc->status |= IRQ_LEVEL;
> +		set_irq_handler(virq, handle_level_irq);
> +	} else {
> +		set_irq_handler(virq, handle_edge_irq);
> +	}
> +
> +	if (src == IPIC_IRQ_EXT0)
> +		edibit = 15;
> +	else
> +		if (src >= IPIC_IRQ_EXT1 && src <= IPIC_IRQ_EXT7)
> +			edibit = (14 - (src - IPIC_IRQ_EXT1));
> +		else
> +			/* only EXT IRQ senses are programmable on ipic */
> +			return 0;

You should fail if attempting to program one of non-programmable ones to
something different than their default type then.

> +	vold = ipic_read(ipic->regs, IPIC_SECNR);
> +	if ((flow_type & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_FALLING) {
> +		vnew = vold | (1 << edibit);
> +	} else {
> +		vnew = vold & ~(1 << edibit);
> +	}
> +	if (vold != vnew)
> +		ipic_write(ipic->regs, IPIC_SECNR, vnew);
> +	return 0;
> +}
> +
> +static struct irq_chip ipic_irq_chip = {
> +	.typename	= " IPIC  ",
> +	.unmask		= ipic_unmask_irq,
> +	.mask		= ipic_mask_irq,
> +	.mask_ack	= ipic_mask_irq_and_ack,
> +	.ack		= ipic_ack_irq,
> +	.end		= ipic_end_irq,
> +	.set_type	= ipic_set_irq_type,
> +};
> +
> +static int ipic_host_match(struct irq_host *h, struct device_node *node)
>  {
> -	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
> -		ipic_enable_irq(irq);
> +	struct ipic *ipic = h->host_data;
> +
> +	/* Exact match, unless ipic node is NULL */
> +	return ipic->of_node == NULL || ipic->of_node == node;
> +}
> +
> +static int ipic_host_map(struct irq_host *h, unsigned int virq,
> +			 irq_hw_number_t hw)
> +{
> +	struct ipic *ipic = h->host_data;
> +	struct irq_chip *chip;
> +
> +	/* Default chip */
> +	chip = &ipic->hc_irq;
> +
> +	set_irq_chip_data(virq, ipic);
> +	set_irq_chip(virq, chip);
> +
> +	return 0;
>  }

Shouldn't you call set_irq_type() (or at least set a handler) here to
setup a default type ? The common code will only call set_irq_type() if
an explicit non-default and different than the current setting handler
is set.

> -struct hw_interrupt_type ipic = {
> -	.typename = " IPIC  ",
> -	.enable = ipic_enable_irq,
> -	.disable = ipic_disable_irq,
> -	.ack = ipic_disable_irq_and_ack,
> -	.end = ipic_end_irq,
> +static int ipic_host_xlate(struct irq_host *h, struct device_node *ct,
> +			   u32 *intspec, unsigned int intsize,
> +			   irq_hw_number_t *out_hwirq, unsigned int *out_flags)
> +
> +{
> +	*out_hwirq = intspec[0];
> +	/* device tree interrupt sense values are assigned either
> +	   LEVEL_LOW (low assertion) or EDGE_FALLING (high-to-low change) */
> +	if (intsize > 1 && (intspec[1] & (IRQ_TYPE_LEVEL_LOW |
> +					  IRQ_TYPE_EDGE_FALLING)))

I'm not sure about the usefulness of the second part of that test...  If
it is, shouldn't you also mask out the other bits in the assignement
below : ?

> +		*out_flags = intspec[1];
> +	else
> +		*out_flags = IRQ_TYPE_NONE;
> +	return 0;
> +}
> +
> +static struct irq_host_ops ipic_host_ops = {
> +	.match	= ipic_host_match,
> +	.map	= ipic_host_map,
> +	.xlate	= ipic_host_xlate,
>  };
>  
> -void __init ipic_init(phys_addr_t phys_addr,
> -		unsigned int flags,
> -		unsigned int irq_offset,
> -		unsigned char *senses,
> -		unsigned int senses_count)
> +void __init ipic_init(struct device_node *node,
> +		unsigned int flags)
>  {
> -	u32 i, temp = 0;
> +	struct ipic	*ipic;
> +	struct resource res;
> +	u32 temp = 0, ret;
> +
> +	ipic = alloc_bootmem(sizeof(struct ipic));
> +	if (ipic == NULL)
> +		return;
> +
> +	memset(ipic, 0, sizeof(struct ipic));
> +	ipic->of_node = node ? of_node_get(node) : NULL;
> +
> +	ipic->irqhost = irq_alloc_host(IRQ_HOST_MAP_LINEAR,
> +				       NR_IPIC_INTS,
> +				       &ipic_host_ops, 0);
> +	if (ipic->irqhost == NULL) {
> +		of_node_put(node);
> +		return;
> +	}
>  
> -	primary_ipic = &p_ipic;
> -	primary_ipic->regs = ioremap(phys_addr, MPC83xx_IPIC_SIZE);
> +	ret = of_address_to_resource(node, 0, &res);
> +	if (ret)
> +		return;
> +
> +	ipic->regs = ioremap(res.start, res.end - res.start + 1);
>  
> -	primary_ipic->irq_offset = irq_offset;
> +	ipic->irqhost->host_data = ipic;
> +	ipic->hc_irq = ipic_irq_chip;
>  
> -	ipic_write(primary_ipic->regs, IPIC_SICNR, 0x0);
> +	/* init hw */
> +	ipic_write(ipic->regs, IPIC_SICNR, 0x0);
>  
>  	/* default priority scheme is grouped. If spread mode is required
>  	 * configure SICFR accordingly */
> @@ -453,49 +580,35 @@ void __init ipic_init(phys_addr_t phys_a
>  	if (flags & IPIC_SPREADMODE_MIX_B)
>  		temp |= SICFR_MPSB;
>  
> -	ipic_write(primary_ipic->regs, IPIC_SICNR, temp);
> +	ipic_write(ipic->regs, IPIC_SICNR, temp);
>  
>  	/* handle MCP route */
>  	temp = 0;
>  	if (flags & IPIC_DISABLE_MCP_OUT)
>  		temp = SERCR_MCPR;
> -	ipic_write(primary_ipic->regs, IPIC_SERCR, temp);
> +	ipic_write(ipic->regs, IPIC_SERCR, temp);
>  
>  	/* handle routing of IRQ0 to MCP */
> -	temp = ipic_read(primary_ipic->regs, IPIC_SEMSR);
> +	temp = ipic_read(ipic->regs, IPIC_SEMSR);
>  
>  	if (flags & IPIC_IRQ0_MCP)
>  		temp |= SEMSR_SIRQ0;
>  	else
>  		temp &= ~SEMSR_SIRQ0;
>  
> -	ipic_write(primary_ipic->regs, IPIC_SEMSR, temp);
> -
> -	for (i = 0 ; i < NR_IPIC_INTS ; i++) {
> -		irq_desc[i+irq_offset].chip = &ipic;
> -		irq_desc[i+irq_offset].status = IRQ_LEVEL;
> -	}
> +	ipic_write(ipic->regs, IPIC_SEMSR, temp);
>  
> -	temp = 0;
> -	for (i = 0 ; i < senses_count ; i++) {
> -		if ((senses[i] & IRQ_SENSE_MASK) == IRQ_SENSE_EDGE) {
> -			temp |= 1 << (15 - i);
> -			if (i != 0)
> -				irq_desc[i + irq_offset + MPC83xx_IRQ_EXT1 - 1].status = 0;
> -			else
> -				irq_desc[irq_offset + MPC83xx_IRQ_EXT0].status = 0;
> -		}
> -	}
> -	ipic_write(primary_ipic->regs, IPIC_SECNR, temp);
> +	primary_ipic = ipic;
> +	irq_set_default_host(primary_ipic->irqhost);
>  
> -	printk ("IPIC (%d IRQ sources, %d External IRQs) at %p\n", NR_IPIC_INTS,
> -			senses_count, primary_ipic->regs);
> +	printk ("IPIC (%d IRQ sources) at %p\n", NR_IPIC_INTS,
> +			primary_ipic->regs);
>  }
>  
> -int ipic_set_priority(unsigned int irq, unsigned int priority)
> +int ipic_set_priority(unsigned int virq, unsigned int priority)
>  {
> -	struct ipic *ipic = ipic_from_irq(irq);
> -	unsigned int src = irq - ipic->irq_offset;
> +	struct ipic *ipic = ipic_from_irq(virq);
> +	unsigned int src = ipic_irq_to_hw(virq);
>  	u32 temp;
>  
>  	if (priority > 7)
> @@ -520,10 +633,10 @@ int ipic_set_priority(unsigned int irq, 
>  	return 0;
>  }
>  
> -void ipic_set_highest_priority(unsigned int irq)
> +void ipic_set_highest_priority(unsigned int virq)
>  {
> -	struct ipic *ipic = ipic_from_irq(irq);
> -	unsigned int src = irq - ipic->irq_offset;
> +	struct ipic *ipic = ipic_from_irq(virq);
> +	unsigned int src = ipic_irq_to_hw(virq);
>  	u32 temp;
>  
>  	temp = ipic_read(ipic->regs, IPIC_SICFR);
> @@ -537,37 +650,10 @@ void ipic_set_highest_priority(unsigned 
>  
>  void ipic_set_default_priority(void)
>  {
> -	ipic_set_priority(MPC83xx_IRQ_TSEC1_TX, 0);
> -	ipic_set_priority(MPC83xx_IRQ_TSEC1_RX, 1);
> -	ipic_set_priority(MPC83xx_IRQ_TSEC1_ERROR, 2);
> -	ipic_set_priority(MPC83xx_IRQ_TSEC2_TX, 3);
> -	ipic_set_priority(MPC83xx_IRQ_TSEC2_RX, 4);
> -	ipic_set_priority(MPC83xx_IRQ_TSEC2_ERROR, 5);
> -	ipic_set_priority(MPC83xx_IRQ_USB2_DR, 6);
> -	ipic_set_priority(MPC83xx_IRQ_USB2_MPH, 7);
> -
> -	ipic_set_priority(MPC83xx_IRQ_UART1, 0);
> -	ipic_set_priority(MPC83xx_IRQ_UART2, 1);
> -	ipic_set_priority(MPC83xx_IRQ_SEC2, 2);
> -	ipic_set_priority(MPC83xx_IRQ_IIC1, 5);
> -	ipic_set_priority(MPC83xx_IRQ_IIC2, 6);
> -	ipic_set_priority(MPC83xx_IRQ_SPI, 7);
> -	ipic_set_priority(MPC83xx_IRQ_RTC_SEC, 0);
> -	ipic_set_priority(MPC83xx_IRQ_PIT, 1);
> -	ipic_set_priority(MPC83xx_IRQ_PCI1, 2);
> -	ipic_set_priority(MPC83xx_IRQ_PCI2, 3);
> -	ipic_set_priority(MPC83xx_IRQ_EXT0, 4);
> -	ipic_set_priority(MPC83xx_IRQ_EXT1, 5);
> -	ipic_set_priority(MPC83xx_IRQ_EXT2, 6);
> -	ipic_set_priority(MPC83xx_IRQ_EXT3, 7);
> -	ipic_set_priority(MPC83xx_IRQ_RTC_ALR, 0);
> -	ipic_set_priority(MPC83xx_IRQ_MU, 1);
> -	ipic_set_priority(MPC83xx_IRQ_SBA, 2);
> -	ipic_set_priority(MPC83xx_IRQ_DMA, 3);
> -	ipic_set_priority(MPC83xx_IRQ_EXT4, 4);
> -	ipic_set_priority(MPC83xx_IRQ_EXT5, 5);
> -	ipic_set_priority(MPC83xx_IRQ_EXT6, 6);
> -	ipic_set_priority(MPC83xx_IRQ_EXT7, 7);
> +	ipic_write(primary_ipic->regs, IPIC_SIPRR_A, IPIC_SIPRR_A_DEFAULT);
> +	ipic_write(primary_ipic->regs, IPIC_SIPRR_D, IPIC_SIPRR_D_DEFAULT);
> +	ipic_write(primary_ipic->regs, IPIC_SMPRR_A, IPIC_SMPRR_A_DEFAULT);
> +	ipic_write(primary_ipic->regs, IPIC_SMPRR_B, IPIC_SMPRR_B_DEFAULT);
>  }
>  
>  void ipic_enable_mcp(enum ipic_mcp_irq mcp_irq)
> @@ -600,17 +686,20 @@ void ipic_clear_mcp_status(u32 mask)
>  	ipic_write(primary_ipic->regs, IPIC_SERMR, mask);
>  }
>  
> -/* Return an interrupt vector or -1 if no interrupt is pending. */
> -int ipic_get_irq(struct pt_regs *regs)
> +/* Return an interrupt vector or NO_IRQ if no interrupt is pending. */
> +unsigned int ipic_get_irq(struct pt_regs *regs)
>  {
>  	int irq;
>  
> -	irq = ipic_read(primary_ipic->regs, IPIC_SIVCR) & 0x7f;
> +	BUG_ON(primary_ipic == NULL);
> +
> +#define IPIC_SIVCR_VECTOR_MASK	0x7f
> +	irq = ipic_read(primary_ipic->regs, IPIC_SIVCR) & IPIC_SIVCR_VECTOR_MASK;
>  
>  	if (irq == 0)    /* 0 --> no irq is pending */
> -		irq = -1;
> +		return NO_IRQ;
>  
> -	return irq;
> +	return irq_linear_revmap(primary_ipic->irqhost, irq);
>  }
>  
>  static struct sysdev_class ipic_sysclass = {
> diff --git a/arch/powerpc/sysdev/ipic.h b/arch/powerpc/sysdev/ipic.h
> index a60c9d1..c28e589 100644
> --- a/arch/powerpc/sysdev/ipic.h
> +++ b/arch/powerpc/sysdev/ipic.h
> @@ -15,7 +15,18 @@ #define __IPIC_H__
>  
>  #include <asm/ipic.h>
>  
> -#define MPC83xx_IPIC_SIZE	(0x00100)
> +#define NR_IPIC_INTS 128
> +
> +/* External IRQS */
> +#define IPIC_IRQ_EXT0 48
> +#define IPIC_IRQ_EXT1 17
> +#define IPIC_IRQ_EXT7 23
> +
> +/* Default Priority Registers */
> +#define IPIC_SIPRR_A_DEFAULT 0x05309770
> +#define IPIC_SIPRR_D_DEFAULT 0x05309770
> +#define IPIC_SMPRR_A_DEFAULT 0x05309770
> +#define IPIC_SMPRR_B_DEFAULT 0x05309770
>  
>  /* System Global Interrupt Configuration Register */
>  #define	SICFR_IPSA	0x00010000
> @@ -31,7 +42,15 @@ #define SERCR_MCPR	0x00000001
>  
>  struct ipic {
>  	volatile u32 __iomem	*regs;
> -	unsigned int		irq_offset;
> +
> +	/* The remapper for this IPIC */
> +	struct irq_host		*irqhost;
> +
> +	/* The "linux" controller struct */
> +	struct irq_chip		hc_irq;
> +
> +	/* The device node of the interrupt controller */
> +	struct device_node	*of_node;
>  };
>  
>  struct ipic_info {
> diff --git a/include/asm-powerpc/ipic.h b/include/asm-powerpc/ipic.h
> index 0fe396a..3f55df4 100644
> --- a/include/asm-powerpc/ipic.h
> +++ b/include/asm-powerpc/ipic.h
> @@ -69,9 +69,7 @@ enum ipic_mcp_irq {
>  	IPIC_MCP_MU   = 7,
>  };
>  
> -extern void ipic_init(phys_addr_t phys_addr, unsigned int flags,
> -		unsigned int irq_offset,
> -		unsigned char *senses, unsigned int senses_count);
> +extern void ipic_init(struct device_node *node, unsigned int flags);
>  extern int ipic_set_priority(unsigned int irq, unsigned int priority);
>  extern void ipic_set_highest_priority(unsigned int irq);
>  extern void ipic_set_default_priority(void);
> @@ -79,7 +77,7 @@ extern void ipic_enable_mcp(enum ipic_mc
>  extern void ipic_disable_mcp(enum ipic_mcp_irq mcp_irq);
>  extern u32 ipic_get_mcp_status(void);
>  extern void ipic_clear_mcp_status(u32 mask);
> -extern int ipic_get_irq(struct pt_regs *regs);
> +extern unsigned int ipic_get_irq(struct pt_regs *regs);
>  
>  #endif /* __ASM_IPIC_H__ */
>  #endif /* __KERNEL__ */
