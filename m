Return-Path: <michal.simek@xilinx.com>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0043.outbound.protection.outlook.com [104.47.34.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJ6f93399zDsqn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 23:49:21 +1100 (AEDT)
Subject: Re: [Patch v7 3/7] irqchip: xilinx: restructure and use jump label api
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
 <monstr@monstr.eu>, <tglx@linutronix.de>, <jason@lakedaemon.net>,
 <marc.zyngier@arm.com>
References: <20161114121351.10924-1-Zubair.Kakakhel@imgtec.com>
 <20161114121351.10924-4-Zubair.Kakakhel@imgtec.com>
CC: <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>,
 <linuxppc-dev@lists.ozlabs.org>, <mpe@ellerman.id.au>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <f60948d3-d283-bb53-268b-9638f686ff35@xilinx.com>
Date: Tue, 15 Nov 2016 13:49:00 +0100
MIME-Version: 1.0
In-Reply-To: <20161114121351.10924-4-Zubair.Kakakhel@imgtec.com>
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
> Add a global structure to house various variables.
> And cleanup read/write handling by using jump label api.
> 
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
> 
> ---
> V6 -> V7
> Restructure and use jump label api
> Better commit log
> 
> V5 -> V6
> Removed __func__ from printk
> Rebase to v4.9-rc3
> 
> V4 -> V5
> Rebased to v4.9-rc1
> Better error handling
> 
> V3 -> V4
> Better error handling for kzalloc
> Erroring out if the axi intc is probed twice as that isn't
> supported
> 
> V2 -> V3
> New patch. Cleans up driver structure
> ---
>  drivers/irqchip/irq-xilinx-intc.c | 118 +++++++++++++++++++++-----------------
>  1 file changed, 66 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
> index 096c1ed..7331d8c 100644
> --- a/drivers/irqchip/irq-xilinx-intc.c
> +++ b/drivers/irqchip/irq-xilinx-intc.c
> @@ -14,10 +14,9 @@
>  #include <linux/irqchip.h>
>  #include <linux/of_address.h>
>  #include <linux/io.h>
> +#include <linux/jump_label.h>
>  #include <linux/bug.h>
>  
> -static void __iomem *intc_baseaddr;
> -
>  /* No one else should require these constants, so define them locally here. */
>  #define ISR 0x00			/* Interrupt Status Register */
>  #define IPR 0x04			/* Interrupt Pending Register */
> @@ -31,27 +30,30 @@ static void __iomem *intc_baseaddr;
>  #define MER_ME (1<<0)
>  #define MER_HIE (1<<1)
>  
> -static unsigned int (*read_fn)(void __iomem *);
> -static void (*write_fn)(u32, void __iomem *);
> +static DEFINE_STATIC_KEY_FALSE(xintc_is_be);
>  
> -static void intc_write32(u32 val, void __iomem *addr)
> -{
> -	iowrite32(val, addr);
> -}
> +struct xintc_irq_chip {
> +	void		__iomem *base;
> +	struct		irq_domain *root_domain;
> +	u32		intr_mask;
> +};
>  
> -static unsigned int intc_read32(void __iomem *addr)
> -{
> -	return ioread32(addr);
> -}
> +static struct xintc_irq_chip *xintc_irqc;
>  
> -static void intc_write32_be(u32 val, void __iomem *addr)
> +static void xintc_write(int reg, u32 data)
>  {
> -	iowrite32be(val, addr);
> +	if (static_branch_unlikely(&xintc_is_be))
> +		iowrite32be(data, xintc_irqc->base + reg);
> +	else
> +		iowrite32(data, xintc_irqc->base + reg);
>  }
>  
> -static unsigned int intc_read32_be(void __iomem *addr)
> +static unsigned int xintc_read(int reg)
>  {
> -	return ioread32be(addr);
> +	if (static_branch_unlikely(&xintc_is_be))
> +		return ioread32be(xintc_irqc->base + reg);
> +	else
> +		return ioread32(xintc_irqc->base + reg);
>  }
>  
>  static void intc_enable_or_unmask(struct irq_data *d)
> @@ -65,21 +67,21 @@ static void intc_enable_or_unmask(struct irq_data *d)
>  	 * acks the irq before calling the interrupt handler
>  	 */
>  	if (irqd_is_level_type(d))
> -		write_fn(mask, intc_baseaddr + IAR);
> +		xintc_write(IAR, mask);
>  
> -	write_fn(mask, intc_baseaddr + SIE);
> +	xintc_write(SIE, mask);
>  }
>  
>  static void intc_disable_or_mask(struct irq_data *d)
>  {
>  	pr_debug("irq-xilinx: disable: %ld\n", d->hwirq);
> -	write_fn(1 << d->hwirq, intc_baseaddr + CIE);
> +	xintc_write(CIE, 1 << d->hwirq);
>  }
>  
>  static void intc_ack(struct irq_data *d)
>  {
>  	pr_debug("irq-xilinx: ack: %ld\n", d->hwirq);
> -	write_fn(1 << d->hwirq, intc_baseaddr + IAR);
> +	xintc_write(IAR, 1 << d->hwirq);
>  }
>  
>  static void intc_mask_ack(struct irq_data *d)
> @@ -87,8 +89,8 @@ static void intc_mask_ack(struct irq_data *d)
>  	unsigned long mask = 1 << d->hwirq;
>  
>  	pr_debug("irq-xilinx: disable_and_ack: %ld\n", d->hwirq);
> -	write_fn(mask, intc_baseaddr + CIE);
> -	write_fn(mask, intc_baseaddr + IAR);
> +	xintc_write(CIE, mask);
> +	xintc_write(IAR, mask);
>  }
>  
>  static struct irq_chip intc_dev = {
> @@ -99,15 +101,13 @@ static struct irq_chip intc_dev = {
>  	.irq_mask_ack = intc_mask_ack,
>  };
>  
> -static struct irq_domain *root_domain;
> -
>  unsigned int get_irq(void)
>  {
>  	unsigned int hwirq, irq = -1;
>  
> -	hwirq = read_fn(intc_baseaddr + IVR);
> +	hwirq = xintc_read(IVR);
>  	if (hwirq != -1U)
> -		irq = irq_find_mapping(root_domain, hwirq);
> +		irq = irq_find_mapping(xintc_irqc->root_domain, hwirq);
>  
>  	pr_debug("irq-xilinx: hwirq=%d, irq=%d\n", hwirq, irq);
>  
> @@ -116,9 +116,7 @@ unsigned int get_irq(void)
>  
>  static int xintc_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
>  {
> -	u32 intr_mask = (u32)d->host_data;
> -
> -	if (intr_mask & (1 << hw)) {
> +	if (xintc_irqc->intr_mask & (1 << hw)) {
>  		irq_set_chip_and_handler_name(irq, &intc_dev,
>  						handle_edge_irq, "edge");
>  		irq_clear_status_flags(irq, IRQ_LEVEL);
> @@ -138,59 +136,75 @@ static const struct irq_domain_ops xintc_irq_domain_ops = {
>  static int __init xilinx_intc_of_init(struct device_node *intc,
>  					     struct device_node *parent)
>  {
> -	u32 nr_irq, intr_mask;
> +	u32 nr_irq;
>  	int ret;
> +	struct xintc_irq_chip *irqc;
>  
> -	intc_baseaddr = of_iomap(intc, 0);
> -	BUG_ON(!intc_baseaddr);
> +	if (xintc_irqc) {
> +		pr_err("irq-xilinx: Multiple instances aren't supported\n");
> +		return -EINVAL;
> +	}

I don't agree with this.
Pretty long time ago we were added support for multiple instances in
xilinx private tree.
You can look here.

https://github.com/Xilinx/linux-xlnx/blob/master/drivers/irqchip/irq-xilinx-intc.c

Not sure if this the latest way how to do it but as you can see
we were setting up
irq_set_handler_data(irq, intc);

and then when you need that structure we were calling
struct intc *local_intc = irq_data_get_irq_chip_data(d);

And that should be it to support multiple instance of this driver.

Based on 5/7 you are describing your interrupt subsystem like this.

Peripherals --> xilinx_intcontroller -> mips_cpu_int controller
If mips_cpu_int has more than one input you can connect more xilinx intc
controllers.
If not you still have an option to connect
xilinx_intcontroller(up to 32 peripherals) -> xilinx_intcontroller(one
intc + up to 31 peripherals)  -> mips_cpu_int controller

Thanks,
Michal
