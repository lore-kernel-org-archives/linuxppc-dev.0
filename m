Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DE1561007D8
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Dec 2009 05:28:34 +1100 (EST)
In-Reply-To: <1259441037-15725-10-git-send-email-albert_herranz@yahoo.es>
References: <1259441037-15725-1-git-send-email-albert_herranz@yahoo.es>
	<1259441037-15725-10-git-send-email-albert_herranz@yahoo.es>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A6D0F7F3-74DB-42BE-BC1D-4C251A75CB16@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH v2 09/11] powerpc: gamecube/wii: flipper interrupt
	controller support
Date: Tue, 1 Dec 2009 19:35:59 +0100
To: Albert Herranz <albert_herranz@yahoo.es>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Add support for the interrupt controller included in the "Flipper"
> chipset of the Nintendo GameCube video game console.
> The same interrupt controller is also present in the "Hollywood"  
> chipset
> of the Nintendo Wii.
>
> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
Acked-by: Segher Boessenkool <segher@kernel.crashing.org>

> ---
> v1 -> v2
> - Build always Flipper interrupt controller when GAMECUBE_COMMON and
>   get rid of FLIPPER_PIC option. Suggestion by Grant Likely.
> - Use NO_IRQ instead of -1. Suggestion by Benjamin Herrenschmidt.
> - Write 0xffffffff instead of ~0 to clear interrupts.
>   Suggestion by Segher Boessenkool.
> - Use __fls instead of open coded asm. Suggestion by Segher  
> Boessenkool.
> - Use a write instead of a read/modify/write to ack interrupts.
>   Suggestion by Segher Boessenkool and Benjamin Herrenschmidt.
> - Use name instead of typename for struct irq_chip.
> - Adapt to updated device tree.
>
>  arch/powerpc/platforms/embedded6xx/Makefile      |    1 +
>  arch/powerpc/platforms/embedded6xx/flipper-pic.c |  263 +++++++++++ 
> +++++++++++
>  arch/powerpc/platforms/embedded6xx/flipper-pic.h |   25 ++
>  3 files changed, 289 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/platforms/embedded6xx/flipper-pic.c
>  create mode 100644 arch/powerpc/platforms/embedded6xx/flipper-pic.h
>
> diff --git a/arch/powerpc/platforms/embedded6xx/Makefile b/arch/ 
> powerpc/platforms/embedded6xx/Makefile
> index 0ab7492..b80f47c 100644
> --- a/arch/powerpc/platforms/embedded6xx/Makefile
> +++ b/arch/powerpc/platforms/embedded6xx/Makefile
> @@ -8,3 +8,4 @@ obj-$(CONFIG_PPC_HOLLY)		+= holly.o
>  obj-$(CONFIG_PPC_PRPMC2800)	+= prpmc2800.o
>  obj-$(CONFIG_PPC_C2K)		+= c2k.o
>  obj-$(CONFIG_USBGECKO_UDBG)	+= usbgecko_udbg.o
> +obj-$(CONFIG_GAMECUBE_COMMON)	+= flipper-pic.o
> diff --git a/arch/powerpc/platforms/embedded6xx/flipper-pic.c b/ 
> arch/powerpc/platforms/embedded6xx/flipper-pic.c
> new file mode 100644
> index 0000000..d596328
> --- /dev/null
> +++ b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
> @@ -0,0 +1,263 @@
> +/*
> + * arch/powerpc/platforms/embedded6xx/flipper-pic.c
> + *
> + * Nintendo GameCube/Wii "Flipper" interrupt controller support.
> + * Copyright (C) 2004-2009 The GameCube Linux Team
> + * Copyright (C) 2007,2008,2009 Albert Herranz
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + */
> +#define DRV_MODULE_NAME "flipper-pic"
> +#define pr_fmt(fmt) DRV_MODULE_NAME ": " fmt
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/irq.h>
> +#include <linux/of.h>
> +#include <asm/io.h>
> +
> +#include "flipper-pic.h"
> +
> +#define FLIPPER_NR_IRQS		32
> +
> +/*
> + * Each interrupt has a corresponding bit in both
> + * the Interrupt Cause (ICR) and Interrupt Mask (IMR) registers.
> + *
> + * Enabling/disabling an interrupt line involves setting/clearing
> + * the corresponding bit in IMR.
> + * Except for the RSW interrupt, all interrupts get deasserted  
> automatically
> + * when the source deasserts the interrupt.
> + */
> +#define FLIPPER_ICR		0x00
> +#define FLIPPER_ICR_RSS		(1<<16) /* reset switch state */
> +
> +#define FLIPPER_IMR		0x04
> +
> +#define FLIPPER_RESET		0x24
> +
> +
> +/*
> + * IRQ chip hooks.
> + *
> + */
> +
> +static void flipper_pic_mask_and_ack(unsigned int virq)
> +{
> +	int irq = virq_to_hw(virq);
> +	void __iomem *io_base = get_irq_chip_data(virq);
> +	u32 mask = 1 << irq;
> +
> +	clrbits32(io_base + FLIPPER_IMR, mask);
> +	/* this is at least needed for RSW */
> +	out_be32(io_base + FLIPPER_ICR, mask);
> +}
> +
> +static void flipper_pic_ack(unsigned int virq)
> +{
> +	int irq = virq_to_hw(virq);
> +	void __iomem *io_base = get_irq_chip_data(virq);
> +
> +	/* this is at least needed for RSW */
> +	out_be32(io_base + FLIPPER_ICR, 1 << irq);
> +}
> +
> +static void flipper_pic_mask(unsigned int virq)
> +{
> +	int irq = virq_to_hw(virq);
> +	void __iomem *io_base = get_irq_chip_data(virq);
> +
> +	clrbits32(io_base + FLIPPER_IMR, 1 << irq);
> +}
> +
> +static void flipper_pic_unmask(unsigned int virq)
> +{
> +	int irq = virq_to_hw(virq);
> +	void __iomem *io_base = get_irq_chip_data(virq);
> +
> +	setbits32(io_base + FLIPPER_IMR, 1 << irq);
> +}
> +
> +
> +static struct irq_chip flipper_pic = {
> +	.name		= "flipper-pic",
> +	.ack		= flipper_pic_ack,
> +	.mask_ack	= flipper_pic_mask_and_ack,
> +	.mask		= flipper_pic_mask,
> +	.unmask		= flipper_pic_unmask,
> +};
> +
> +/*
> + * IRQ host hooks.
> + *
> + */
> +
> +static struct irq_host *flipper_irq_host;
> +
> +static int flipper_pic_map(struct irq_host *h, unsigned int virq,
> +			   irq_hw_number_t hwirq)
> +{
> +	set_irq_chip_data(virq, h->host_data);
> +	get_irq_desc(virq)->status |= IRQ_LEVEL;
> +	set_irq_chip_and_handler(virq, &flipper_pic, handle_level_irq);
> +	return 0;
> +}
> +
> +static void flipper_pic_unmap(struct irq_host *h, unsigned int irq)
> +{
> +	set_irq_chip_data(irq, NULL);
> +	set_irq_chip(irq, NULL);
> +}
> +
> +static int flipper_pic_match(struct irq_host *h, struct  
> device_node *np)
> +{
> +	return 1;
> +}
> +
> +
> +static struct irq_host_ops flipper_irq_host_ops = {
> +	.map = flipper_pic_map,
> +	.unmap = flipper_pic_unmap,
> +	.match = flipper_pic_match,
> +};
> +
> +/*
> + * Platform hooks.
> + *
> + */
> +
> +static void __flipper_quiesce(void __iomem *io_base)
> +{
> +	/* mask and ack all IRQs */
> +	out_be32(io_base + FLIPPER_IMR, 0x00000000);
> +	out_be32(io_base + FLIPPER_ICR, 0xffffffff);
> +}
> +
> +struct irq_host * __init flipper_pic_init(struct device_node *np)
> +{
> +	struct device_node *pi;
> +	struct irq_host *irq_host = NULL;
> +	struct resource res;
> +	void __iomem *io_base;
> +	int retval;
> +
> +	pi = of_get_parent(np);
> +	if (!pi) {
> +		pr_err("no parent found\n");
> +		goto out;
> +	}
> +	if (!of_device_is_compatible(pi, "nintendo,flipper-pi")) {
> +		pr_err("unexpected parent compatible\n");
> +		goto out;
> +	}
> +
> +	retval = of_address_to_resource(pi, 0, &res);
> +	if (retval) {
> +		pr_err("no io memory range found\n");
> +		goto out;
> +	}
> +	io_base = ioremap(res.start, resource_size(&res));
> +
> +	pr_info("controller at 0x%08x mapped to 0x%p\n", res.start,  
> io_base);
> +
> +	__flipper_quiesce(io_base);
> +
> +	irq_host = irq_alloc_host(np, IRQ_HOST_MAP_LINEAR, FLIPPER_NR_IRQS,
> +				  &flipper_irq_host_ops, -1);
> +	if (!irq_host) {
> +		pr_err("failed to allocate irq_host\n");
> +		return NULL;
> +	}
> +
> +	irq_host->host_data = io_base;
> +
> +out:
> +	return irq_host;
> +}
> +
> +unsigned int flipper_pic_get_irq(void)
> +{
> +	void __iomem *io_base = flipper_irq_host->host_data;
> +	int irq;
> +	u32 irq_status;
> +
> +	irq_status = in_be32(io_base + FLIPPER_ICR) &
> +		     in_be32(io_base + FLIPPER_IMR);
> +	if (irq_status == 0)
> +		return NO_IRQ;	/* no more IRQs pending */
> +
> +	irq = __ffs(irq_status);
> +	return irq_linear_revmap(flipper_irq_host, irq);
> +}
> +
> +/*
> + * Probe function.
> + *
> + */
> +
> +void __init flipper_pic_probe(void)
> +{
> +	struct device_node *np;
> +
> +	np = of_find_compatible_node(NULL, NULL, "nintendo,flipper-pic");
> +	BUG_ON(!np);
> +
> +	flipper_irq_host = flipper_pic_init(np);
> +	BUG_ON(!flipper_irq_host);
> +
> +	irq_set_default_host(flipper_irq_host);
> +
> +	of_node_put(np);
> +}
> +
> +/*
> + * Misc functions related to the flipper chipset.
> + *
> + */
> +
> +/**
> + * flipper_quiesce() - quiesce flipper irq controller
> + *
> + * Mask and ack all interrupt sources.
> + *
> + */
> +void flipper_quiesce(void)
> +{
> +	void __iomem *io_base = flipper_irq_host->host_data;
> +
> +	__flipper_quiesce(io_base);
> +}
> +
> +/*
> + * Resets the platform.
> + */
> +void flipper_platform_reset(void)
> +{
> +	void __iomem *io_base;
> +
> +	if (flipper_irq_host && flipper_irq_host->host_data) {
> +		io_base = flipper_irq_host->host_data;
> +		out_8(io_base + FLIPPER_RESET, 0x00);
> +	}
> +}
> +
> +/*
> + * Returns non-zero if the reset button is pressed.
> + */
> +int flipper_is_reset_button_pressed(void)
> +{
> +	void __iomem *io_base;
> +	u32 icr;
> +
> +	if (flipper_irq_host && flipper_irq_host->host_data) {
> +		io_base = flipper_irq_host->host_data;
> +		icr = in_be32(io_base + FLIPPER_ICR);
> +		return !(icr & FLIPPER_ICR_RSS);
> +	}
> +	return 0;
> +}
> +
> diff --git a/arch/powerpc/platforms/embedded6xx/flipper-pic.h b/ 
> arch/powerpc/platforms/embedded6xx/flipper-pic.h
> new file mode 100644
> index 0000000..e339186
> --- /dev/null
> +++ b/arch/powerpc/platforms/embedded6xx/flipper-pic.h
> @@ -0,0 +1,25 @@
> +/*
> + * arch/powerpc/platforms/embedded6xx/flipper-pic.h
> + *
> + * Nintendo GameCube/Wii "Flipper" interrupt controller support.
> + * Copyright (C) 2004-2009 The GameCube Linux Team
> + * Copyright (C) 2007,2008,2009 Albert Herranz
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + */
> +
> +#ifndef __FLIPPER_PIC_H
> +#define __FLIPPER_PIC_H
> +
> +unsigned int flipper_pic_get_irq(void);
> +void __init flipper_pic_probe(void);
> +
> +void flipper_quiesce(void);
> +void flipper_platform_reset(void);
> +int flipper_is_reset_button_pressed(void);
> +
> +#endif
> -- 
> 1.6.3.3
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
