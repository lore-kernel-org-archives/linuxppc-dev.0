Return-Path: <michal.simek@xilinx.com>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0047.outbound.protection.outlook.com [104.47.34.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJ6BF51mGzDvrn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 23:28:37 +1100 (AEDT)
Subject: Re: [Patch v7 7/7] powerpc/virtex: Use generic xilinx irqchip driver
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
 <monstr@monstr.eu>, <tglx@linutronix.de>, <jason@lakedaemon.net>,
 <marc.zyngier@arm.com>
References: <20161114121351.10924-1-Zubair.Kakakhel@imgtec.com>
 <20161114121351.10924-8-Zubair.Kakakhel@imgtec.com>
CC: <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>,
 <linuxppc-dev@lists.ozlabs.org>, <mpe@ellerman.id.au>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <92d4f856-aef5-721f-bb18-bfc5a3f53573@xilinx.com>
Date: Tue, 15 Nov 2016 13:28:19 +0100
MIME-Version: 1.0
In-Reply-To: <20161114121351.10924-8-Zubair.Kakakhel@imgtec.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 14.11.2016 13:13, Zubair Lutfullah Kakakhel wrote:
> The Xilinx interrupt controller driver is now available in drivers/irqchip.
> Switch to using that driver.
> 
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
> 
> ---
> V6 - V7
> Rebase to v4.9-rc5
> 
> V5 -> V6 Added Acked-by Micheal Ellerman
> 
> V5 New patch
> 
> Tested on virtex440-ml507 using qemu
> ---
>  arch/powerpc/include/asm/xilinx_intc.h |   2 +-
>  arch/powerpc/platforms/40x/Kconfig     |   1 +
>  arch/powerpc/platforms/40x/virtex.c    |   2 +-
>  arch/powerpc/platforms/44x/Kconfig     |   1 +
>  arch/powerpc/platforms/44x/virtex.c    |   2 +-
>  arch/powerpc/sysdev/xilinx_intc.c      | 211 +--------------------------------
>  drivers/irqchip/irq-xilinx-intc.c      |   3 +-
>  7 files changed, 9 insertions(+), 213 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/xilinx_intc.h b/arch/powerpc/include/asm/xilinx_intc.h
> index 343612f..3192d7f 100644
> --- a/arch/powerpc/include/asm/xilinx_intc.h
> +++ b/arch/powerpc/include/asm/xilinx_intc.h
> @@ -14,7 +14,7 @@
>  #ifdef __KERNEL__
>  
>  extern void __init xilinx_intc_init_tree(void);
> -extern unsigned int xilinx_intc_get_irq(void);
> +extern unsigned int xintc_get_irq(void);
>  
>  #endif /* __KERNEL__ */
>  #endif /* _ASM_POWERPC_XILINX_INTC_H */
> diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/40x/Kconfig
> index e3257f2..1d7c1b1 100644
> --- a/arch/powerpc/platforms/40x/Kconfig
> +++ b/arch/powerpc/platforms/40x/Kconfig
> @@ -64,6 +64,7 @@ config XILINX_VIRTEX_GENERIC_BOARD
>  	default n
>  	select XILINX_VIRTEX_II_PRO
>  	select XILINX_VIRTEX_4_FX
> +	select XILINX_INTC
>  	help
>  	  This option enables generic support for Xilinx Virtex based boards.
>  
> diff --git a/arch/powerpc/platforms/40x/virtex.c b/arch/powerpc/platforms/40x/virtex.c
> index 91a08ea..e3d5e09 100644
> --- a/arch/powerpc/platforms/40x/virtex.c
> +++ b/arch/powerpc/platforms/40x/virtex.c
> @@ -48,7 +48,7 @@ define_machine(virtex) {
>  	.probe			= virtex_probe,
>  	.setup_arch		= xilinx_pci_init,
>  	.init_IRQ		= xilinx_intc_init_tree,
> -	.get_irq		= xilinx_intc_get_irq,
> +	.get_irq		= xintc_get_irq,
>  	.restart		= ppc4xx_reset_system,
>  	.calibrate_decr		= generic_calibrate_decr,
>  };
> diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
> index 48fc180..25b8d64 100644
> --- a/arch/powerpc/platforms/44x/Kconfig
> +++ b/arch/powerpc/platforms/44x/Kconfig
> @@ -241,6 +241,7 @@ config XILINX_VIRTEX440_GENERIC_BOARD
>  	depends on 44x
>  	default n
>  	select XILINX_VIRTEX_5_FXT
> +	select XILINX_INTC
>  	help
>  	  This option enables generic support for Xilinx Virtex based boards
>  	  that use a 440 based processor in the Virtex 5 FXT FPGA architecture.
> diff --git a/arch/powerpc/platforms/44x/virtex.c b/arch/powerpc/platforms/44x/virtex.c
> index a7e0802..3eb13ed 100644
> --- a/arch/powerpc/platforms/44x/virtex.c
> +++ b/arch/powerpc/platforms/44x/virtex.c
> @@ -54,7 +54,7 @@ define_machine(virtex) {
>  	.probe			= virtex_probe,
>  	.setup_arch		= xilinx_pci_init,
>  	.init_IRQ		= xilinx_intc_init_tree,
> -	.get_irq		= xilinx_intc_get_irq,
> +	.get_irq		= xintc_get_irq,
>  	.calibrate_decr		= generic_calibrate_decr,
>  	.restart		= ppc4xx_reset_system,
>  };
> diff --git a/arch/powerpc/sysdev/xilinx_intc.c b/arch/powerpc/sysdev/xilinx_intc.c
> index 0f52d79..4a86dcf 100644
> --- a/arch/powerpc/sysdev/xilinx_intc.c
> +++ b/arch/powerpc/sysdev/xilinx_intc.c
> @@ -29,194 +29,7 @@
>  #include <asm/processor.h>
>  #include <asm/i8259.h>
>  #include <asm/irq.h>
> -
> -/*
> - * INTC Registers
> - */
> -#define XINTC_ISR	0	/* Interrupt Status */
> -#define XINTC_IPR	4	/* Interrupt Pending */
> -#define XINTC_IER	8	/* Interrupt Enable */
> -#define XINTC_IAR	12	/* Interrupt Acknowledge */
> -#define XINTC_SIE	16	/* Set Interrupt Enable bits */
> -#define XINTC_CIE	20	/* Clear Interrupt Enable bits */
> -#define XINTC_IVR	24	/* Interrupt Vector */
> -#define XINTC_MER	28	/* Master Enable */
> -
> -static struct irq_domain *master_irqhost;
> -
> -#define XILINX_INTC_MAXIRQS	(32)
> -
> -/* The following table allows the interrupt type, edge or level,
> - * to be cached after being read from the device tree until the interrupt
> - * is mapped
> - */
> -static int xilinx_intc_typetable[XILINX_INTC_MAXIRQS];
> -
> -/* Map the interrupt type from the device tree to the interrupt types
> - * used by the interrupt subsystem
> - */
> -static unsigned char xilinx_intc_map_senses[] = {
> -	IRQ_TYPE_EDGE_RISING,
> -	IRQ_TYPE_EDGE_FALLING,
> -	IRQ_TYPE_LEVEL_HIGH,
> -	IRQ_TYPE_LEVEL_LOW,
> -};
> -
> -/*
> - * The interrupt controller is setup such that it doesn't work well with
> - * the level interrupt handler in the kernel because the handler acks the
> - * interrupt before calling the application interrupt handler. To deal with
> - * that, we use 2 different irq chips so that different functions can be
> - * used for level and edge type interrupts.
> - *
> - * IRQ Chip common (across level and edge) operations
> - */
> -static void xilinx_intc_mask(struct irq_data *d)
> -{
> -	int irq = irqd_to_hwirq(d);
> -	void * regs = irq_data_get_irq_chip_data(d);
> -	pr_debug("mask: %d\n", irq);
> -	out_be32(regs + XINTC_CIE, 1 << irq);
> -}
> -
> -static int xilinx_intc_set_type(struct irq_data *d, unsigned int flow_type)
> -{
> -	return 0;
> -}
> -
> -/*
> - * IRQ Chip level operations
> - */
> -static void xilinx_intc_level_unmask(struct irq_data *d)
> -{
> -	int irq = irqd_to_hwirq(d);
> -	void * regs = irq_data_get_irq_chip_data(d);
> -	pr_debug("unmask: %d\n", irq);
> -	out_be32(regs + XINTC_SIE, 1 << irq);
> -
> -	/* ack level irqs because they can't be acked during
> -	 * ack function since the handle_level_irq function
> -	 * acks the irq before calling the inerrupt handler
> -	 */
> -	out_be32(regs + XINTC_IAR, 1 << irq);
> -}
> -
> -static struct irq_chip xilinx_intc_level_irqchip = {
> -	.name = "Xilinx Level INTC",
> -	.irq_mask = xilinx_intc_mask,
> -	.irq_mask_ack = xilinx_intc_mask,
> -	.irq_unmask = xilinx_intc_level_unmask,
> -	.irq_set_type = xilinx_intc_set_type,
> -};
> -
> -/*
> - * IRQ Chip edge operations
> - */
> -static void xilinx_intc_edge_unmask(struct irq_data *d)
> -{
> -	int irq = irqd_to_hwirq(d);
> -	void *regs = irq_data_get_irq_chip_data(d);
> -	pr_debug("unmask: %d\n", irq);
> -	out_be32(regs + XINTC_SIE, 1 << irq);
> -}
> -
> -static void xilinx_intc_edge_ack(struct irq_data *d)
> -{
> -	int irq = irqd_to_hwirq(d);
> -	void * regs = irq_data_get_irq_chip_data(d);
> -	pr_debug("ack: %d\n", irq);
> -	out_be32(regs + XINTC_IAR, 1 << irq);
> -}
> -
> -static struct irq_chip xilinx_intc_edge_irqchip = {
> -	.name = "Xilinx Edge  INTC",
> -	.irq_mask = xilinx_intc_mask,
> -	.irq_unmask = xilinx_intc_edge_unmask,
> -	.irq_ack = xilinx_intc_edge_ack,
> -	.irq_set_type = xilinx_intc_set_type,
> -};
> -
> -/*
> - * IRQ Host operations
> - */
> -
> -/**
> - * xilinx_intc_xlate - translate virq# from device tree interrupts property
> - */
> -static int xilinx_intc_xlate(struct irq_domain *h, struct device_node *ct,
> -				const u32 *intspec, unsigned int intsize,
> -				irq_hw_number_t *out_hwirq,
> -				unsigned int *out_flags)
> -{
> -	if ((intsize < 2) || (intspec[0] >= XILINX_INTC_MAXIRQS))
> -		return -EINVAL;
> -
> -	/* keep a copy of the interrupt type til the interrupt is mapped
> -	 */
> -	xilinx_intc_typetable[intspec[0]] = xilinx_intc_map_senses[intspec[1]];
> -
> -	/* Xilinx uses 2 interrupt entries, the 1st being the h/w
> -	 * interrupt number, the 2nd being the interrupt type, edge or level
> -	 */
> -	*out_hwirq = intspec[0];
> -	*out_flags = xilinx_intc_map_senses[intspec[1]];
> -
> -	return 0;
> -}
> -static int xilinx_intc_map(struct irq_domain *h, unsigned int virq,
> -				  irq_hw_number_t irq)
> -{
> -	irq_set_chip_data(virq, h->host_data);
> -
> -	if (xilinx_intc_typetable[irq] == IRQ_TYPE_LEVEL_HIGH ||
> -	    xilinx_intc_typetable[irq] == IRQ_TYPE_LEVEL_LOW) {
> -		irq_set_chip_and_handler(virq, &xilinx_intc_level_irqchip,
> -					 handle_level_irq);
> -	} else {
> -		irq_set_chip_and_handler(virq, &xilinx_intc_edge_irqchip,
> -					 handle_edge_irq);
> -	}
> -	return 0;
> -}
> -
> -static const struct irq_domain_ops xilinx_intc_ops = {
> -	.map = xilinx_intc_map,
> -	.xlate = xilinx_intc_xlate,
> -};
> -
> -struct irq_domain * __init
> -xilinx_intc_init(struct device_node *np)
> -{
> -	struct irq_domain * irq;
> -	void * regs;
> -
> -	/* Find and map the intc registers */
> -	regs = of_iomap(np, 0);
> -	if (!regs) {
> -		pr_err("xilinx_intc: could not map registers\n");
> -		return NULL;
> -	}
> -
> -	/* Setup interrupt controller */
> -	out_be32(regs + XINTC_IER, 0); /* disable all irqs */
> -	out_be32(regs + XINTC_IAR, ~(u32) 0); /* Acknowledge pending irqs */
> -	out_be32(regs + XINTC_MER, 0x3UL); /* Turn on the Master Enable. */
> -
> -	/* Allocate and initialize an irq_domain structure. */
> -	irq = irq_domain_add_linear(np, XILINX_INTC_MAXIRQS, &xilinx_intc_ops,
> -				    regs);
> -	if (!irq)
> -		panic(__FILE__ ": Cannot allocate IRQ host\n");
> -
> -	return irq;
> -}
> -
> -int xilinx_intc_get_irq(void)
> -{
> -	void * regs = master_irqhost->host_data;
> -	pr_debug("get_irq:\n");
> -	return irq_linear_revmap(master_irqhost, in_be32(regs + XINTC_IVR));
> -}
> +#include <linux/irqchip.h>
>  
>  #if defined(CONFIG_PPC_I8259)
>  /*
> @@ -265,31 +78,11 @@ static void __init xilinx_i8259_setup_cascade(void)
>  static inline void xilinx_i8259_setup_cascade(void) { return; }
>  #endif /* defined(CONFIG_PPC_I8259) */
>  
> -static const struct of_device_id xilinx_intc_match[] __initconst = {
> -	{ .compatible = "xlnx,opb-intc-1.00.c", },
> -	{ .compatible = "xlnx,xps-intc-1.00.a", },
> -	{}
> -};
> -
>  /*
>   * Initialize master Xilinx interrupt controller
>   */
>  void __init xilinx_intc_init_tree(void)
>  {
> -	struct device_node *np;
> -
> -	/* find top level interrupt controller */
> -	for_each_matching_node(np, xilinx_intc_match) {
> -		if (!of_get_property(np, "interrupts", NULL))
> -			break;
> -	}
> -	BUG_ON(!np);
> -
> -	master_irqhost = xilinx_intc_init(np);
> -	BUG_ON(!master_irqhost);
> -
> -	irq_set_default_host(master_irqhost);
> -	of_node_put(np);
> -
> +	irqchip_init();
>  	xilinx_i8259_setup_cascade();
>  }
> diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
> index d330917..3db7ab1 100644
> --- a/drivers/irqchip/irq-xilinx-intc.c
> +++ b/drivers/irqchip/irq-xilinx-intc.c
> @@ -237,4 +237,5 @@ static int __init xilinx_intc_of_init(struct device_node *intc,
>  
>  }
>  
> -IRQCHIP_DECLARE(xilinx_intc, "xlnx,xps-intc-1.00.a", xilinx_intc_of_init);
> +IRQCHIP_DECLARE(xilinx_intc_xps, "xlnx,xps-intc-1.00.a", xilinx_intc_of_init);
> +IRQCHIP_DECLARE(xilinx_intc_opb, "xlnx,opb-intc-1.00.c", xilinx_intc_of_init);
> 


Looks reasonable.
Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
