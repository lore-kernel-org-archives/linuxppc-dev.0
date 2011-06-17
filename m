Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 2/2] powerpc: add support for MPIC message register API
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Meador Inge <meador_inge@mentor.com>
In-Reply-To: <1306869543-18812-3-git-send-email-meador_inge@mentor.com>
References: <1306869543-18812-1-git-send-email-meador_inge@mentor.com>
	<1306869543-18812-3-git-send-email-meador_inge@mentor.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 17 Jun 2011 15:33:04 +1000
Message-ID: <1308288784.32158.30.camel@pasglop>
Mime-Version: 1.0
Cc: openmcapi-dev@googlegroups.com,
	Hollis Blanchard <hollis_blanchard@mentor.com>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-05-31 at 14:19 -0500, Meador Inge wrote:
> Some MPIC implementations contain one or more blocks of message registers
> that are used to send messages between cores via IPIs.  A simple API has
> been added to access (get/put, read, write, etc ...) these message registers.
> The available message registers are initially discovered via nodes in the
> device tree.  A separate commit contains a binding for the message register
> nodes.

Ok, so I finally got to look at that in a bit more details...
> +#ifndef _ASM_MPIC_MSGR_H
> +#define _ASM_MPIC_MSGR_H
> +
> +#include <linux/types.h>
> +
> +struct mpic_msgr {
> +	u32 __iomem *addr;
> +	u32 __iomem *mer;
> +	u32 __iomem	*msr;
> +	int irq;
> +	atomic_t in_use;
> +	int num;
> +};

General comment... I'm really not fan of "msgr", I'd rather see
"mpic_message_*", it's a tad more verbose but looks a lot better, no ?

Also do you need those 3 iomem pointers ? Not just one with fixed
offsets ? Or do they come from vastly different sources ?

atomic_t in_use looks fishy, but let's see how you use it...

> +extern struct mpic_msgr* mpic_msgr_get(unsigned int reg_num);
> +extern void mpic_msgr_put(struct mpic_msgr* msgr);
> +extern void mpic_msgr_enable(struct mpic_msgr *msgr);
> +extern void mpic_msgr_disable(struct mpic_msgr *msgr);
> +extern void mpic_msgr_write(struct mpic_msgr *msgr, u32 message);
> +extern u32 mpic_msgr_read(struct mpic_msgr *msgr);
> +extern void mpic_msgr_clear(struct mpic_msgr *msgr);
> +extern void mpic_msgr_set_destination(struct mpic_msgr *msgr, u32 cpu_num);
> +extern int mpic_msgr_get_irq(struct mpic_msgr *msgr);

Documentation of the API please.

> +#endif
> diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
> index f7b0772..4d65593 100644
> --- a/arch/powerpc/platforms/Kconfig
> +++ b/arch/powerpc/platforms/Kconfig
> @@ -78,6 +78,14 @@ config MPIC_WEIRD
>  	bool
>  	default n
>  
> +config MPIC_MSGR
> +	bool "MPIC message register support"
> +	depends on MPIC
> +	default n
> +	help
> +	  Enables support for the MPIC message registers.  These
> +	  registers are used for inter-processor communication.
> +
>  config PPC_I8259
>  	bool
>  	default n
> diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
> index 1e0c933..6d40185 100644
> --- a/arch/powerpc/sysdev/Makefile
> +++ b/arch/powerpc/sysdev/Makefile
> @@ -3,7 +3,8 @@ subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
>  ccflags-$(CONFIG_PPC64)		:= -mno-minimal-toc
>  
>  mpic-msi-obj-$(CONFIG_PCI_MSI)	+= mpic_msi.o mpic_u3msi.o mpic_pasemi_msi.o
> -obj-$(CONFIG_MPIC)		+= mpic.o $(mpic-msi-obj-y)
> +mpic-msgr-obj-$(CONFIG_MPIC_MSGR)	+= mpic_msgr.o
> +obj-$(CONFIG_MPIC)		+= mpic.o $(mpic-msi-obj-y) $(mpic-msgr-obj-y)
>  fsl-msi-obj-$(CONFIG_PCI_MSI)	+= fsl_msi.o
>  obj-$(CONFIG_PPC_MSI_BITMAP)	+= msi_bitmap.o
>  
> diff --git a/arch/powerpc/sysdev/mpic_msgr.c b/arch/powerpc/sysdev/mpic_msgr.c
> new file mode 100644
> index 0000000..bfa0612
> --- /dev/null
> +++ b/arch/powerpc/sysdev/mpic_msgr.c
> @@ -0,0 +1,279 @@
> +/*
> + * Copyright 2011-2012, Meador Inge, Mentor Graphics Corporation.
> + *
> + * Some ideas based on un-pushed work done by Vivek Mahajan, Jason Jin, and
> + * Mingkai Hu from Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; version 2 of the
> + * License.
> + *
> + */
> +
> +#include <linux/list.h>
> +#include <linux/of_platform.h>
> +#include <linux/errno.h>
> +#include <asm/prom.h>
> +#include <asm/hw_irq.h>
> +#include <asm/ppc-pci.h>
> +#include <asm/mpic_msgr.h>
> +
> +#define MPIC_MSGR_REGISTERS_PER_BLOCK 4
> +#define MSGR_INUSE 0
> +#define MSGR_FREE 1
> +
> +/* Internal structure used *only* for IO mapping register blocks. */
> +struct mpic_msgr_block {
> +	struct msgr {
> +		u32 msgr;
> +		u8 res[12];
> +	} msgrs[MPIC_MSGR_REGISTERS_PER_BLOCK];
> +	u8 res0[192];
> +	u32 mer;
> +	u8 res1[12];
> +	u32 msr;
> +};

So this represent HW registers ? Please make it clear in the comment.
I'm not a terrible fan of using structures to map HW especially with so
few registers.

> +static struct mpic_msgr **mpic_msgrs = 0;
> +static unsigned int mpic_msgr_count = 0;
> +
> +struct mpic_msgr* mpic_msgr_get(unsigned int reg_num)
> +{
> +	struct mpic_msgr* msgr;
> +
> +	if (reg_num >= mpic_msgr_count)
> +		return ERR_PTR(-ENODEV);
> +
> +	msgr = mpic_msgrs[reg_num];

No locking on the array access, might be ok if those things are never
plugged in/out I suppose...

> +	if (atomic_cmpxchg(&msgr->in_use, MSGR_FREE, MSGR_INUSE) == MSGR_FREE)
> +		return msgr;
> +
> +	return ERR_PTR(-EBUSY);
> +}
> +EXPORT_SYMBOL(mpic_msgr_get);

So how are those things intended to be used ? Clients get a fixed
"register" number to use ? It looks like this stuff would have been
better off using some kind of allocator no ? A bitmap would have done
the job... or do you really need to have some kind of fixed numbering
associated with clients ?

> +void mpic_msgr_put(struct mpic_msgr* msgr)
> +{
> +	atomic_set(&msgr->in_use, MSGR_FREE);
> +}
> +EXPORT_SYMBOL(mpic_msgr_put);

Shouldn't it be disabled too while at it ?

> +void mpic_msgr_enable(struct mpic_msgr *msgr)
> +{
> +	out_be32(msgr->mer, in_be32(msgr->mer) | (1 << msgr->num));
> +}
> +EXPORT_SYMBOL(mpic_msgr_enable);

Why are all those exported non-GPL ? We have a policy of making new
in-kernel APIs generally GPL only.

> +void mpic_msgr_disable(struct mpic_msgr *msgr)
> +{
> +	out_be32(msgr->mer, in_be32(msgr->mer) & ~(1 << msgr->num));
> +}
> +EXPORT_SYMBOL(mpic_msgr_disable);

I see read-modify-write cycles here with no synchronization/locking
whatsoever... Might be ok as long as you document it in the doc of the
API, ie, the caller is required to synchronize.

> +void mpic_msgr_write(struct mpic_msgr *msgr, u32 message)
> +{
> +	out_be32(msgr->addr, message);
> +}
> +EXPORT_SYMBOL(mpic_msgr_write);
> +
> +u32 mpic_msgr_read(struct mpic_msgr *msgr)
> +{
> +	return in_be32(msgr->addr);
> +}
> +EXPORT_SYMBOL(mpic_msgr_read);

Those look like significant bloat/overhead for what is just an MMIO
wrapper on a register access, why not make them static inline's
instead ?

> +void mpic_msgr_clear(struct mpic_msgr *msgr)
> +{
> +	(void) mpic_msgr_read(msgr);
> +}
> +EXPORT_SYMBOL(mpic_msgr_clear);
> +
> +void mpic_msgr_set_destination(struct mpic_msgr *msgr, u32 cpu_num)
> +{
> +	out_be32(msgr->addr, 1 << cpu_num);
> +}
> +EXPORT_SYMBOL(mpic_msgr_set_destination);

Please make it clear that this takes a HW CPU number. How is that going
to be used ? Wouldn't you be better off having a __ variant taking the
HW CPU number an the "public" variant doing the conversion from a Linux
number ?

> +int mpic_msgr_get_irq(struct mpic_msgr *msgr)
> +{
> +	return msgr->irq;
> +}
> +EXPORT_SYMBOL(mpic_msgr_get_irq);
> +
> +/* The following three functions are used to compute the order and number of
> + * the message register blocks.  They are clearly very inefficent.  However,
> + * they are called *only* a few times during device initialization.
> + */
> +static unsigned int mpic_msgr_number_of_blocks(void)
> +{
> +	unsigned int count;
> +	struct device_node *aliases;
> +
> +	count = 0;
> +	aliases = of_find_node_by_name(NULL, "aliases");
> +
> +	if (aliases) {
> +		char buf[32];
> +
> +		for (;;) {
> +			snprintf(buf, sizeof(buf), "mpic-msgr-block%d", count);
> +			if (!of_find_property(aliases, buf, NULL))
> +				break;
> +
> +			count += 1;
> +		}
> +	}
> +
> +	return count;
> +}

I don't like relying on aliases as a way to figure out what HW is
present, that's not right. You should find the actual devices themselves
based on their compatible properties.

All of that stuff also assume these things are never going to be
hot-plugged. IE. will they never go in/out of partition in hypervisors
(or even be virtualized) ?

> +static unsigned int mpic_msgr_number_of_registers(void)
> +{
> +	return mpic_msgr_number_of_blocks() * MPIC_MSGR_REGISTERS_PER_BLOCK;
> +}
> +
> +static int mpic_msgr_block_number(struct device_node *node)
> +{
> +	struct device_node *aliases;
> +	unsigned int index, number_of_blocks;
> +	char buf[64];
> +
> +	number_of_blocks = mpic_msgr_number_of_blocks();
> +	aliases = of_find_node_by_name(NULL, "aliases");
> +	if (!aliases)
> +		return -1;
> +
> +	for (index = 0; index < number_of_blocks; ++index) {
> +		struct property *prop;
> +
> +		snprintf(buf, sizeof(buf), "mpic-msgr-block%d", index);
> +		prop = of_find_property(aliases, buf, NULL);
> +		if (node == of_find_node_by_path(prop->value))
> +			break;
> +	}
> +
> +	return index == number_of_blocks ? -1 : index;
> +}
> +
> +/* The probe function for a single message register block.
> + */
> +static __devinit int mpic_msgr_probe(struct platform_device *dev)
> +{
> +	struct mpic_msgr_block __iomem *msgr_block;
> +	int block_number;
> +	struct resource rsrc;
> +	unsigned int i;
> +	unsigned int irq_index;
> +	struct device_node *np = dev->dev.of_node;
> +	unsigned int receive_mask;
> +	const unsigned int *prop;
> +
> +	if (!np) {
> +		dev_err(&dev->dev, "Device OF-Node is NULL");
> +		return -EFAULT;
> +	}
> +
> +	/* Allocate the message register array upon the first device
> +	 * registered.
> +	 */
> +	if (!mpic_msgrs) {
> +		mpic_msgr_count = mpic_msgr_number_of_registers();
> +		dev_info(&dev->dev, "Found %d message registers\n", mpic_msgr_count);
> +
> +		mpic_msgrs = kzalloc(sizeof(struct mpic_msgr) * mpic_msgr_count,
> +							 GFP_KERNEL);
> +		if (!mpic_msgrs) {
> +			dev_err(&dev->dev, "No memory for message register blocks\n");
> +			return -ENOMEM;
> +		}
> +	}
> +	dev_info(&dev->dev, "Of-device full name %s\n", np->full_name);

Ok, so we have another scheme of:

 - Count all devices in the system of a given type
 - Assign them numbers
 - API uses number

That sucks... unless you have an allocator. And even then.

I'd rather clients use something like struct mpic_msgr (or msg_reg or
message_reg) as the "handle" to one of these things.

It can be obtained via an allocator or a device tree parsing routine if
there's a fixed relationship between clients and registers, I don't
really know how that stuff is to be used, but in any case, the whole
thing stinks as it is.

> +	/* IO map the message register block. */
> +	of_address_to_resource(np, 0, &rsrc);
> +	msgr_block = ioremap(rsrc.start, rsrc.end - rsrc.start);
> +	if (!msgr_block) {
> +		dev_err(&dev->dev, "Failed to iomap MPIC message registers");
> +		return -EFAULT;
> +	}
> +
> +	/* Ensure the block has a defined order. */
> +	block_number = mpic_msgr_block_number(np);
> +	if (block_number < 0) {
> +		dev_err(&dev->dev, "Failed to find message register block alias\n");
> +		return -ENODEV;
> +	}
> +	dev_info(&dev->dev, "Setting up message register block %d\n", block_number);
> +
> +	/* Grab the receive mask which specifies what registers can receive
> +	 * interrupts.
> +	 */
> +	prop = of_get_property(np, "mpic-msgr-receive-mask", NULL);
> +	receive_mask = (prop) ? *prop : 0xF;
> +
> +	/* Build up the appropriate message register data structures. */
> +	for (i = 0, irq_index = 0; i < MPIC_MSGR_REGISTERS_PER_BLOCK; ++i) {
> +		struct mpic_msgr *msgr;
> +		unsigned int reg_number;
> +
> +		msgr = kzalloc(sizeof(struct mpic_msgr), GFP_KERNEL);
> +		if (!msgr) {
> +			dev_err(&dev->dev, "No memory for message register\n");
> +			return -ENOMEM;
> +		}
> +
> +		reg_number = block_number * MPIC_MSGR_REGISTERS_PER_BLOCK + i;
> +		msgr->addr = &msgr_block->msgrs[i].msgr;
> +		msgr->mer = &msgr_block->mer;
> +		msgr->msr = &msgr_block->msr;
> +		atomic_set(&msgr->in_use, MSGR_FREE);
> +		msgr->num = reg_number;
> +
> +		if (receive_mask & (1 << i)) {
> +			struct resource irq;
> +
> +			if (of_irq_to_resource(np, irq_index, &irq) == NO_IRQ) {
> +				dev_err(&dev->dev, "Missing interrupt specifier");
> +				kfree(msgr);
> +				return -EFAULT;
> +			}
> +			msgr->irq = irq.start;
> +			irq_index += 1;
> +		} else {
> +			msgr->irq = NO_IRQ;
> +		}
> +
> +		mpic_msgrs[reg_number] = msgr;
> +		mpic_msgr_disable(msgr);
> +		dev_info(&dev->dev, "Register %d initialized: irq %d\n",
> +				 msgr->num, msgr->irq);
> +	
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id mpic_msgr_ids[] = {
> +	{
> +		.compatible = "fsl,mpic-v3.1-msgr",
> +		.data = NULL,
> +	},
> +	{}
> +};
> +
> +static struct platform_driver mpic_msgr_driver = {
> +	.driver = {
> +		.name = "mpic-msgr",
> +		.owner = THIS_MODULE,
> +		.of_match_table = mpic_msgr_ids,
> +	},
> +	.probe = mpic_msgr_probe,
> +};
> +
> +static __init int mpic_msgr_init(void)
> +{
> +	return platform_driver_register(&mpic_msgr_driver);
> +}
> +subsys_initcall(mpic_msgr_init);

Ben.
