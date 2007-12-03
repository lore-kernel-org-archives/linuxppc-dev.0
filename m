Return-Path: <Tony.Li@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 32C80DDE01
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Dec 2007 20:18:12 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	lB39I3XI000101
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Dec 2007 02:18:04 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id lB39I0vX028754
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Dec 2007 03:18:01 -0600 (CST)
Subject: Re: [PATCH] Add IPIC MSI interrupt support
From: Li Li <r64360@freescale.com>
To: michael@ellerman.id.au
In-Reply-To: <1196654521.13554.32.camel@concordia>
References: <1196394519.29683.8.camel@Guyver>
	<1196654521.13554.32.camel@concordia>
Content-Type: text/plain
Date: Mon, 03 Dec 2007 17:07:50 +0800
Message-Id: <1196672870.14353.21.camel@Guyver>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Gala Kumar <kumar.gala@freescale.com>, Li Tony <Tony.Li@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Michael,

I emulate mpic to write this IPIC MSI routines. :)


> > diff --git a/arch/powerpc/platforms/83xx/mpc837x_mds.c b/arch/powerpc/platforms/83xx/mpc837x_mds.c
> > index 6048f1b..dbea34b 100644
> > --- a/arch/powerpc/platforms/83xx/mpc837x_mds.c
> > +++ b/arch/powerpc/platforms/83xx/mpc837x_mds.c
> > @@ -17,6 +17,9 @@
> >  
> >  #include <asm/time.h>
> >  #include <asm/ipic.h>
> > +#if CONFIG_IPIC_MSI
> > +#include <asm/ipic_msi.h>
> > +#endif
> >  #include <asm/udbg.h>
> >  #include <asm/prom.h>
> 
> I'd rather you just include it unconditionally.

Yes. that is ok for me.

> 
> > @@ -84,6 +87,14 @@ static void __init mpc837x_mds_init_IRQ(void)
> >  	 * in case the boot rom changed something on us.
> >  	 */
> >  	ipic_set_default_priority();
> > +
> > +#if CONFIG_IPIC_MSI
> > +	np = of_find_compatible_node(NULL, NULL, "fsl,ipic-msi");
> > +	if (!np)
> > +		return;
> > +
> > +	ipic_msi_init(np, ipic_msi_cascade);
> > +#endif
> 
> If you have a no-op version of ipic_msi_init() in your header file then
> you can remove the #ifdef in the C code - which I think is nicer.
> 

Seems you do not like #ifdef. :)  I agree it.
So, I move this #ifdef into header file.

> Why do you pass the handler into the init routine, rather than have the
> init routine just set the handler. Then you could make the handler
> static.
> 

In IPIC, the 8 MSI interrupts is handled as level intrrupt.
I just provide a versatile in case it is changed.

> >  }
> >  
> >  /*
> > diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
> > index 99a77d7..5946b6a 100644
> > --- a/arch/powerpc/sysdev/Makefile
> > +++ b/arch/powerpc/sysdev/Makefile
> > @@ -25,6 +25,7 @@ ifeq ($(CONFIG_PPC_MERGE),y)
> >  obj-$(CONFIG_PPC_INDIRECT_PCI)	+= indirect_pci.o
> >  obj-$(CONFIG_PPC_I8259)		+= i8259.o
> >  obj-$(CONFIG_PPC_83xx)		+= ipic.o
> > +obj-$(CONFIG_IPIC_MSI)		+= ipic_msi.o
> >  obj-$(CONFIG_4xx)		+= uic.o
> >  obj-$(CONFIG_XILINX_VIRTEX)	+= xilinx_intc.o
> >  endif
> > diff --git a/arch/powerpc/sysdev/ipic_msi.c b/arch/powerpc/sysdev/ipic_msi.c
> > new file mode 100644
> > index 0000000..57758f7
> > --- /dev/null
> > +++ b/arch/powerpc/sysdev/ipic_msi.c
> > @@ -0,0 +1,359 @@
> > +/*
> > + * arch/powerpc/sysdev/ipic_msi.c
> > + *
> > + * IPIC MSI routines implementations.
> > + *
> > + * Auther: Tony Li <tony.li@freescale.com>
> > + *
> > + * Copyright (c) 2007 Freescale Semiconductor, Inc.
> > + *
> > + * This program is free software; you can redistribute  it and/or modify it
> > + * under  the terms of  the GNU General  Public License as published by the
> > + * Free Software Foundation;  either version 2 of the  License, or (at your
> > + * option) any later version.
> > + */
> > +
> > +
> > +#include <linux/pci.h>
> > +#include <linux/msi.h>
> > +#include <linux/irq.h>
> > +
> > +#include <asm/ipic_msi.h>
> > +
> > +#define MSIR0	0x43
> > +#define MSIR1	0x4
> > +#define MSIR2	0x51
> > +#define MSIR3	0x52
> > +#define MSIR4	0x56
> > +#define MSIR5	0x57
> > +#define MSIR6	0x58
> > +#define MSIR7	0x59
> > +
> > +
> > +static struct ipic_msi *ipic_msi;
> > +static DEFINE_SPINLOCK(ipic_msi_lock);
> > +static DEFINE_SPINLOCK(ipic_msi_bitmap_lock);
> > +
> > +static inline u32 ipic_msi_read(volatile u32 __iomem *base, unsigned int reg)
> > +{
> > +	return in_be32(base + (reg >> 2));
> > +}
> > +
> > +static inline void ipic_msi_write(volatile u32 __iomem *base,
> > +					unsigned int reg, u32 value)
> > +{
> > +	out_be32(base + (reg >> 2), value);
> > +}
> > +
> > +static struct ipic_msi * ipic_msi_from_irq(unsigned int virq)
> > +{
> > +	return ipic_msi;
> > +}
> > +
> > +#define	ipic_msi_irq_to_hw(virq)	((unsigned int)irq_map[virq].hwirq)
> 
> What's wrong with virq_to_hw() ?
> 

viqr_to_hw is not __inline__.

> 
> > +static void ipic_msi_unmask(unsigned int virq)
> > +{
> > +	struct ipic_msi *msi = ipic_msi_from_irq(virq);
> > +	unsigned int src = ipic_msi_irq_to_hw(virq);
> > +	unsigned long flags;
> > +	u32 temp;
> > +
> > +	spin_lock_irqsave(&ipic_msi_lock, flags);
> > +	temp = ipic_msi_read(msi->regs, IPIC_MSIMR);
> > +	ipic_msi_write(msi->regs, IPIC_MSIMR,
> > +		temp & ~(1 << (src / msi->int_per_msir)));
> > +
> > +	spin_unlock_irqrestore(&ipic_msi_lock, flags);
> > +}
> > +
> > +static void ipic_msi_mask(unsigned int virq)
> > +{
> > +	struct ipic_msi *msi = ipic_msi_from_irq(virq);
> > +	unsigned int src = ipic_msi_irq_to_hw(virq);
> > +	unsigned long flags;
> > +	u32 temp;
> > +
> > +	spin_lock_irqsave(&ipic_msi_lock, flags);
> > +
> > +	temp = ipic_msi_read(msi->regs, IPIC_MSIMR);
> > +	ipic_msi_write(msi->regs, IPIC_MSIMR,
> > +		temp | (1 << (src / msi->int_per_msir)));
> > +
> > +	spin_unlock_irqrestore(&ipic_msi_lock, flags);
> > +}
> > +/*
> > + * We do not need this actually. The MSIR register has been read once
> > + * in ipic_msi_get_irq. So, this MSI interrupt has been acked
> > + */
> > +static void ipic_msi_ack(unsigned int virq)
> > +{
> > +	struct ipic_msi *msi = ipic_msi_from_irq(virq);
> > +	unsigned int src = ipic_msi_irq_to_hw(virq);
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&ipic_msi_lock, flags);
> > +
> > +	ipic_msi_read(msi->regs, IPIC_MSIR0 + (4 * (src / msi->int_per_msir)));
> > +
> > +	spin_unlock_irqrestore(&ipic_msi_lock,flags);
> > +}
> > +
> > +static struct irq_chip ipic_msi_chip = {
> > +	.typename = " IPIC MSI ",
> > +	.unmask = ipic_msi_unmask,
> > +	.mask = ipic_msi_mask,
> > +	.ack = ipic_msi_ack,
> > +};
> > +
> > +static int ipic_msi_host_map(struct irq_host *h, unsigned int virq,
> > +				irq_hw_number_t hw)
> > +{
> > +	struct ipic_msi *msi = h->host_data;
> > +	struct irq_chip *chip = msi->hc_irq;
> > +
> > +	set_irq_chip_data(virq, msi);
> > +	get_irq_desc(virq)->status |= IRQ_TYPE_EDGE_FALLING;
> > +
> > +	set_irq_chip_and_handler(virq, chip, handle_edge_irq);
> > +	return 0;
> > +}
> > +
> > +static struct irq_host_ops ipic_msi_host_ops = {
> > +	.map = ipic_msi_host_map,
> > +};
> > +
> > +irq_hw_number_t ipic_msi_alloc_hwirqs(struct ipic_msi *msi, int num)
> > +{
> > +	unsigned long flags;
> > +	int offset, order = get_count_order(num);
> > +
> > +	spin_lock_irqsave(&ipic_msi_bitmap_lock, flags);
> > +
> > +	offset = bitmap_find_free_region(msi->ipic_msi_bitmap,
> > +			msi->nr_msir * msi->int_per_msir, order);
> > +
> > +	spin_unlock_irqrestore(&ipic_msi_bitmap_lock, flags);
> > +
> > +	pr_debug("%s: allocated 0x%x (2^%d) at offset 0x%x\n",
> > +		__FUNCTION__, num, order, offset);
> > +
> > +	return offset;
> > +}
> > +
> > +void ipic_msi_free_hwirqs(struct ipic_msi *msi, int offset, int num)
> > +{
> > +	unsigned long flags;
> > +	int order = get_count_order(num);
> > +
> > +	pr_debug("%s: freeing 0x%x (2^%d) at offset 0x%x\n",
> > +		__FUNCTION__, num, order, offset);
> > +
> > +	spin_lock_irqsave(&ipic_msi_bitmap_lock, flags);
> > +	bitmap_release_region(msi->ipic_msi_bitmap, offset, order);
> > +	spin_unlock_irqrestore(&ipic_msi_bitmap_lock, flags);
> > +}
> > +
> > +static int ipic_msi_init_allocator(struct ipic_msi *msi)
> > +{
> > +	int size;
> > +
> > +	size = BITS_TO_LONGS(msi->nr_msir * msi->int_per_msir) * sizeof(long);
> > +	msi->ipic_msi_bitmap = alloc_maybe_bootmem(size, GFP_KERNEL);
> > +
> > +	if (msi->ipic_msi_bitmap == NULL) {
> > +		pr_debug("%s: ENOMEM allocating allocator bitmap!\n",
> > +				__FUNCTION__);
> > +		return -ENOMEM;
> > +	}
> > +	memset(msi->ipic_msi_bitmap, 0, size);
> > +
> > +	return 0;
> > +}
> 
> The last three routines are almost identical to the mpic_msi.c ones, if
> in future we have a third implementation that looks almost identical
> maybe we should consolidate them.
> 

Yes. I agree.

> > +
> > +static void ipic_msi_compose_msg(struct ipic_msi *msi, int hwirq,
> > +						struct msi_msg *msg)
> > +{
> > +	unsigned int srs;
> > +	unsigned int ibs;
> > +
> > +	srs = hwirq / msi->int_per_msir;
> > +	ibs = hwirq - srs * msi->int_per_msir;
> > +
> > +	msg->address_lo = msi->msi_addr_lo;
> > +	msg->address_hi = msi->msi_addr_hi;
> > +	msg->data = (srs << 5) | (ibs & 0x1F);
> > +
> > +	pr_debug("%s: allocated srs: %d, ibs: %d\n",
> > +		__FUNCTION__, srs, ibs);
> > +
> > +}
> > +
> > +static int ipic_msi_setup_irqs(struct pci_dev *pdev, int nvec, int type)
> > +{
> > +	struct ipic_msi *msi = ipic_msi;
> > +	irq_hw_number_t hwirq;
> > +	unsigned int virq;
> > +	struct msi_desc *entry;
> > +	struct msi_msg msg;
> > +
> > +	list_for_each_entry(entry, &pdev->msi_list, list) {
> > +		hwirq = ipic_msi_alloc_hwirqs(msi, 1);
> > +		if (hwirq < 0) {
> > +			pr_debug("%s: fail allocating msi interrupt\n",
> > +					__FUNCTION__);
> > +			return hwirq;
> > +		}
> > +
> > +		/* This hwirq belongs to the irq_host other than irq_host of IPIC
> > + 		 * So, it is independent to hwirq of IPIC */
> > +		virq = irq_create_mapping(msi->irqhost, hwirq);
> > +		if (virq == NO_IRQ) {
> > +			pr_debug("%s: fail mapping hwirq 0x%lx\n",
> > +					__FUNCTION__, hwirq);
> > +			ipic_msi_free_hwirqs(msi, hwirq, 1);
> > +			return -ENOSPC;
> > +		}
> > +		set_irq_msi(virq, entry);
> > +		ipic_msi_compose_msg(msi, hwirq, &msg);
> > +		write_msi_msg(virq, &msg);
> > +
> > +		hwirq++;
> 
>                   ^^^^ this looks like my bug

I have a question here. Do we support more MSI interrupts on ONE pci
device?

> 
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void ipic_msi_teardown_irqs(struct pci_dev *pdev)
> > +{
> > +	struct msi_desc *entry;
> > +	struct ipic_msi *msi = ipic_msi;
> > +
> > +	list_for_each_entry(entry, &pdev->msi_list, list) {
> > +		if (entry->irq == NO_IRQ)
> > +			continue;
> > +		set_irq_msi(entry->irq, NULL);
> > +		ipic_msi_free_hwirqs(msi, virq_to_hw(entry->irq), 1);
> > +		irq_dispose_mapping(entry->irq);
> > +	}
> > +
> > +	return;
> > +}
> > +
> > +void __init ipic_msi_init(struct device_node *node,
> > +			void (*handler)(unsigned int irq, struct irq_desc *desc))
> > +{
> > +	struct ipic_msi *msi;
> > +	struct resource res;
> > +	int i;
> > +	int rc = 0;
> > +
> > +	msi = alloc_maybe_bootmem(sizeof(*msi), GFP_KERNEL);
> > +	if (msi == NULL)
> > +		return;
> > +
> > +	memset(msi, 0, sizeof(*msi));
> > +
> > +
> > +	msi->irqhost = irq_alloc_host(of_node_get(node), IRQ_HOST_MAP_LINEAR,
> > +					NR_MSIR, &ipic_msi_host_ops, 0);
> > +	if (msi->irqhost == NULL) {
> > +		of_node_put(node);
> > +		goto out;
> > +	}
> > +
> > +	rc = of_address_to_resource(node, 0, &res);
> > +	if (rc) {
> > +		of_node_put(node);
> > +		goto out;
> > +	}
> > +
> > +	msi->regs = ioremap(res.start, res.end - res.start + 1);
> > +	msi->irqhost->host_data = msi;
> > +	msi->hc_irq = &ipic_msi_chip;
> > +
> > +	msi->msi_addr_lo = 0xE00007F8;
> > +	msi->msi_addr_hi = 0;
> > +	msi->nr_msir = ARRAY_SIZE(msi->msir);
> > +	msi->int_per_msir = 32;
> > +	for (i = 0; i < msi->nr_msir; i++) {
> > +		unsigned int virt_msir = irq_of_parse_and_map(node, i);
> > +		if (virt_msir != NO_IRQ) {
> > +			set_irq_data(virt_msir, msi);
> > +			set_irq_chained_handler(virt_msir, handler);
> > +			msi->msir[i] = virt_msir;
> > +		} else
> > +			msi->msir[i] = NO_IRQ;
> > +	}
> > +
> > +	rc = ipic_msi_init_allocator(msi);
> > +	if (rc)
> 		< missing of_node_put() ? >
> > +		goto out;
> > +
> > +	ipic_msi = msi;
> > +
> > +	WARN_ON(ppc_md.setup_msi_irqs);
> > +	ppc_md.setup_msi_irqs = ipic_msi_setup_irqs;
> > +	ppc_md.teardown_msi_irqs = ipic_msi_teardown_irqs;
> > +
> 	  return ?
> 

Sorry for that. It is a mistake.

> > +out:
> > +	if (mem_init_done)
> > +		kfree(msi);
> > +
> > +	return;
> > +}
> > +
> > +static int ipic_msi_get_irq(struct ipic_msi *msi, int virt_msir)
> > +{
> > +	int msir = -1;
> > +	unsigned int temp;
> > +	unsigned int offset;
> > +	int i;
> > +
> > +	for (i = 0; i < msi->nr_msir; i++)
> > +		if (virt_msir == msi->msir[i]) {
> > +			msir = i;
> > +			break;
> > +		}
> > +
> > +	if (i >= msi->nr_msir)
> > +		return NO_IRQ;
> > +
> > +	temp = ipic_msi_read(msi->regs, IPIC_MSIR0 + (i * 4));
> > +	offset = ffs(temp) - 1;
> > +
> > +	return irq_linear_revmap(msi->irqhost, (msir * msi->int_per_msir + offset));
> > +}
> > +
> > +void ipic_msi_cascade(unsigned int irq, struct irq_desc *desc)
> > +{
> > +	struct ipic_msi *msi;
> > +	unsigned int cascade_irq;
> > +
> > +	spin_lock(&desc->lock);
> > +	if (desc->chip->mask_ack)
> > +		desc->chip->mask_ack(irq);
> > +	else {
> > +		desc->chip->mask(irq);
> > +		desc->chip->ack(irq);
> > +	}
> > +
> > +	if (unlikely(desc->status & IRQ_INPROGRESS))
> > +		goto unlock;
> > +
> > +	desc->status |= IRQ_INPROGRESS;
> > +	msi = desc->handler_data;
> > +	cascade_irq = ipic_msi_get_irq(msi, irq);
> > +
> > +	spin_unlock(&desc->lock);
> > +
> > +	if (cascade_irq != NO_IRQ)
> > +		generic_handle_irq(cascade_irq);
> > +
> > +	spin_lock(&desc->lock);
> > +	desc->status &= ~IRQ_INPROGRESS;
> > +	if (!(desc->status & IRQ_DISABLED) && desc->chip->unmask)
> > +		desc->chip->unmask(irq);
> > +
> > +unlock:
> > +	spin_unlock(&desc->lock);
> > +}
> 
> I don't know your hardware, but this looks a bit weird. Doesn't the
> upstream handler do most of this logic for you?
> 

I just emulate the handle_level_irq to write this.
But I need get irq number from MSI controller (ipic_msi_get_irq) and
then call interrupt routine of that irq number.

- Tony
