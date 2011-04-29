Return-Path: <B32579@freescale.com>
From: Kushwaha Prabhakar-B32579 <B32579@freescale.com>
To: Meador Inge <meador_inge@mentor.com>
Subject: RE: [PATCH 2/2] powerpc: add support for MPIC message register API
Date: Fri, 29 Apr 2011 05:00:22 +0000
Message-ID: <071A08F2C6A57E4E94D980ECA553F8741959CA@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1303232375-25014-1-git-send-email-meador_inge@mentor.com>
	<1303232375-25014-3-git-send-email-meador_inge@mentor.com>
In-Reply-To: <1303232375-25014-3-git-send-email-meador_inge@mentor.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "openmcapi-dev@googlegroups.com" <openmcapi-dev@googlegroups.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	Hollis Blanchard <hollis_blanchard@mentor.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I have no comments about coding and architecture. It looks fine.

Only have a query about its use case..
  "Any application intended to use message interrupt requires to know reg_n=
um because of struct mpic_msgr* mpic_msgr_get(unsigned int reg_num) API"

It will be good to search available unit internally and provide its pointer=
. It will make application more flexible.=20

Regards,
Prabhakar

> -----Original Message-----
> From: devicetree-discuss-bounces+b32579=3Dfreescale.com@lists.ozlabs.org
> [mailto:devicetree-discuss-bounces+b32579=3Dfreescale.com@lists.ozlabs.or=
g]
> On Behalf Of Meador Inge
> Sent: Tuesday, April 19, 2011 10:30 PM
> To: linuxppc-dev@lists.ozlabs.org
> Cc: openmcapi-dev@googlegroups.com; devicetree-discuss@lists.ozlabs.org;
> Hollis Blanchard
> Subject: [PATCH 2/2] powerpc: add support for MPIC message register API
>=20
> Some MPIC implementations contain one or more blocks of message registers
> that are used to send messages between cores via IPIs.  A simple API has
> been added to access (get/put, read, write, etc ...) these message
> registers.
> The available message registers are initially discovered via nodes in the
> device tree.  A separate commit contains a binding for the message
> register nodes.
>=20
> Signed-off-by: Meador Inge <meador_inge@mentor.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Hollis Blanchard <hollis_blanchard@mentor.com>
> ---
>  arch/powerpc/include/asm/mpic_msgr.h |   35 +++++
>  arch/powerpc/platforms/Kconfig       |    8 +
>  arch/powerpc/sysdev/Makefile         |    3 +-
>  arch/powerpc/sysdev/mpic_msgr.c      |  279
> ++++++++++++++++++++++++++++++++++
>  4 files changed, 324 insertions(+), 1 deletions(-)  create mode 100644
> arch/powerpc/include/asm/mpic_msgr.h
>  create mode 100644 arch/powerpc/sysdev/mpic_msgr.c
>=20
> diff --git a/arch/powerpc/include/asm/mpic_msgr.h
> b/arch/powerpc/include/asm/mpic_msgr.h
> new file mode 100644
> index 0000000..370dcb4
> --- /dev/null
> +++ b/arch/powerpc/include/asm/mpic_msgr.h
> @@ -0,0 +1,35 @@
> +/*
> + * Copyright 2011-2012, Meador Inge, Mentor Graphics Corporation.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; version 2 of the
> + * License.
> + *
> + */
> +
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
> +
> +extern struct mpic_msgr* mpic_msgr_get(unsigned int reg_num); extern
> +void mpic_msgr_put(struct mpic_msgr* msgr); extern void
> +mpic_msgr_enable(struct mpic_msgr *msgr); extern void
> +mpic_msgr_disable(struct mpic_msgr *msgr); extern void
> +mpic_msgr_write(struct mpic_msgr *msgr, u32 message); extern u32
> +mpic_msgr_read(struct mpic_msgr *msgr); extern void
> +mpic_msgr_clear(struct mpic_msgr *msgr); extern void
> +mpic_msgr_set_destination(struct mpic_msgr *msgr, u32 cpu_num); extern
> +int mpic_msgr_get_irq(struct mpic_msgr *msgr);
> +
> +#endif
> diff --git a/arch/powerpc/platforms/Kconfig
> b/arch/powerpc/platforms/Kconfig index f7b0772..4d65593 100644
> --- a/arch/powerpc/platforms/Kconfig
> +++ b/arch/powerpc/platforms/Kconfig
> @@ -78,6 +78,14 @@ config MPIC_WEIRD
>  	bool
>  	default n
>=20
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
> @@ -3,7 +3,8 @@ subdir-ccflags-$(CONFIG_PPC_WERROR) :=3D -Werror
>  ccflags-$(CONFIG_PPC64)		:=3D -mno-minimal-toc
>=20
>  mpic-msi-obj-$(CONFIG_PCI_MSI)	+=3D mpic_msi.o mpic_u3msi.o
> mpic_pasemi_msi.o
> -obj-$(CONFIG_MPIC)		+=3D mpic.o $(mpic-msi-obj-y)
> +mpic-msgr-obj-$(CONFIG_MPIC_MSGR)	+=3D mpic_msgr.o
> +obj-$(CONFIG_MPIC)		+=3D mpic.o $(mpic-msi-obj-y) $(mpic-msgr-
> obj-y)
>  fsl-msi-obj-$(CONFIG_PCI_MSI)	+=3D fsl_msi.o
>  obj-$(CONFIG_PPC_MSI_BITMAP)	+=3D msi_bitmap.o
>=20
> diff --git a/arch/powerpc/sysdev/mpic_msgr.c
> b/arch/powerpc/sysdev/mpic_msgr.c new file mode 100644 index
> 0000000..352bfa6
> --- /dev/null
> +++ b/arch/powerpc/sysdev/mpic_msgr.c
> @@ -0,0 +1,279 @@
> +/*
> + * Copyright 2011-2012, Meador Inge, Mentor Graphics Corporation.
> + *
> + * Some ideas based on un-pushed work done by Vivek Mahajan, Jason Jin,
> +and
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
> +#define MPIC_MSGR_REGISTERS_PER_BLOCK 4 #define MSGR_INUSE 0 #define
> +MSGR_FREE 1
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
> +
> +static struct mpic_msgr **mpic_msgrs =3D 0; static unsigned int
> +mpic_msgr_count =3D 0;
> +
> +struct mpic_msgr* mpic_msgr_get(unsigned int reg_num) {
> +	struct mpic_msgr* msgr;
> +
> +	if (reg_num >=3D mpic_msgr_count)
> +		return ERR_PTR(-ENODEV);
> +
> +	msgr =3D mpic_msgrs[reg_num];
> +
> +	if (atomic_cmpxchg(&msgr->in_use, MSGR_FREE, MSGR_INUSE) =3D=3D
> MSGR_FREE)
> +		return msgr;
> +
> +	return ERR_PTR(-EBUSY);
> +}
> +EXPORT_SYMBOL(mpic_msgr_get);
> +
> +void mpic_msgr_put(struct mpic_msgr* msgr) {
> +	atomic_set(&msgr->in_use, MSGR_FREE);
> +}
> +EXPORT_SYMBOL(mpic_msgr_put);
> +
> +void mpic_msgr_enable(struct mpic_msgr *msgr) {
> +	out_be32(msgr->mer, in_be32(msgr->mer) | (1 << msgr->num)); }
> +EXPORT_SYMBOL(mpic_msgr_enable);
> +
> +void mpic_msgr_disable(struct mpic_msgr *msgr) {
> +	out_be32(msgr->mer, in_be32(msgr->mer) & ~(1 << msgr->num)); }
> +EXPORT_SYMBOL(mpic_msgr_disable);
> +
> +void mpic_msgr_write(struct mpic_msgr *msgr, u32 message) {
> +	out_be32(msgr->addr, message);
> +}
> +EXPORT_SYMBOL(mpic_msgr_write);
> +
> +u32 mpic_msgr_read(struct mpic_msgr *msgr) {
> +	return in_be32(msgr->addr);
> +}
> +EXPORT_SYMBOL(mpic_msgr_read);
> +
> +void mpic_msgr_clear(struct mpic_msgr *msgr) {
> +	(void) mpic_msgr_read(msgr);
> +}
> +EXPORT_SYMBOL(mpic_msgr_clear);
> +
> +void mpic_msgr_set_destination(struct mpic_msgr *msgr, u32 cpu_num) {
> +	out_be32(msgr->addr, 1 << cpu_num);
> +}
> +EXPORT_SYMBOL(mpic_msgr_set_destination);
> +
> +int mpic_msgr_get_irq(struct mpic_msgr *msgr) {
> +	return msgr->irq;
> +}
> +EXPORT_SYMBOL(mpic_msgr_get_irq);
> +
> +/* The following three functions are used to compute the order and
> +number of
> + * the message register blocks.  They are clearly very inefficent.
> +However,
> + * they are called *only* a few times during device initialization.
> + */
> +static unsigned int mpic_msgr_number_of_blocks(void) {
> +	unsigned int count;
> +	struct device_node *aliases;
> +
> +	count =3D 0;
> +	aliases =3D of_find_node_by_name(NULL, "aliases");
> +
> +	if (aliases) {
> +		char buf[32];
> +
> +		for (;;) {
> +			snprintf(buf, sizeof(buf), "msgr-block%d", count);
> +			if (!of_find_property(aliases, buf, NULL))
> +				break;
> +
> +			count +=3D 1;
> +		}
> +	}
> +
> +	return count;
> +}
> +
> +static unsigned int mpic_msgr_number_of_registers(void)
> +{
> +	return mpic_msgr_number_of_blocks() *
> MPIC_MSGR_REGISTERS_PER_BLOCK; }
> +
> +static int mpic_msgr_block_number(struct device_node *node) {
> +	struct device_node *aliases;
> +	unsigned int index, number_of_blocks;
> +	char buf[64];
> +
> +	number_of_blocks =3D mpic_msgr_number_of_blocks();
> +	aliases =3D of_find_node_by_name(NULL, "aliases");
> +	if (!aliases)
> +		return -1;
> +
> +	for (index =3D 0; index < number_of_blocks; ++index) {
> +		struct property *prop;
> +
> +		snprintf(buf, sizeof(buf), "msgr-block%d", index);
> +		prop =3D of_find_property(aliases, buf, NULL);
> +		if (node =3D=3D of_find_node_by_path(prop->value))
> +			break;
> +	}
> +
> +	return index =3D=3D number_of_blocks ? -1 : index; }
> +
> +/* The probe function for a single message register block.
> + */
> +static __devinit int mpic_msgr_probe(struct platform_device *dev) {
> +	struct mpic_msgr_block __iomem *msgr_block;
> +	int block_number;
> +	struct resource rsrc;
> +	unsigned int i;
> +	unsigned int irq_index;
> +	struct device_node *np =3D dev->dev.of_node;
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
> +		mpic_msgr_count =3D mpic_msgr_number_of_registers();
> +		dev_info(&dev->dev, "Found %d message registers\n",
> mpic_msgr_count);
> +
> +		mpic_msgrs =3D kzalloc(sizeof(struct mpic_msgr) *
> mpic_msgr_count,
> +							 GFP_KERNEL);
> +		if (!mpic_msgrs) {
> +			dev_err(&dev->dev, "No memory for message register
> blocks\n");
> +			return -ENOMEM;
> +		}
> +	}
> +	dev_info(&dev->dev, "Of-device full name %s\n", np->full_name);
> +
> +	/* IO map the message register block. */
> +	of_address_to_resource(np, 0, &rsrc);
> +	msgr_block =3D ioremap(rsrc.start, rsrc.end - rsrc.start);
> +	if (!msgr_block) {
> +		dev_err(&dev->dev, "Failed to iomap MPIC message registers");
> +		return -EFAULT;
> +	}
> +
> +	/* Ensure the block has a defined order. */
> +	block_number =3D mpic_msgr_block_number(np);
> +	if (block_number < 0) {
> +		dev_err(&dev->dev, "Failed to find message register block
> alias\n");
> +		return -ENODEV;
> +	}
> +	dev_info(&dev->dev, "Setting up message register block %d\n",
> +block_number);
> +
> +	/* Grab the receive mask which specifies what registers can receive
> +	 * interrupts.
> +	 */
> +	prop =3D of_get_property(np, "msg-receive-mask", NULL);
> +	receive_mask =3D (prop) ? *prop : 0xF;
> +
> +	/* Build up the appropriate message register data structures. */
> +	for (i =3D 0, irq_index =3D 0; i < MPIC_MSGR_REGISTERS_PER_BLOCK; ++i)
> {
> +		struct mpic_msgr *msgr;
> +		unsigned int reg_number;
> +
> +		msgr =3D kzalloc(sizeof(struct mpic_msgr), GFP_KERNEL);
> +		if (!msgr) {
> +			dev_err(&dev->dev, "No memory for message register\n");
> +			return -ENOMEM;
> +		}
> +
> +		reg_number =3D block_number * MPIC_MSGR_REGISTERS_PER_BLOCK +
> i;
> +		msgr->addr =3D &msgr_block->msgrs[i].msgr;
> +		msgr->mer =3D &msgr_block->mer;
> +		msgr->msr =3D &msgr_block->msr;
> +		atomic_set(&msgr->in_use, MSGR_FREE);
> +		msgr->num =3D reg_number;
> +
> +		if (receive_mask & (1 << i)) {
> +			struct resource irq;
> +
> +			if (of_irq_to_resource(np, irq_index, &irq) =3D=3D NO_IRQ)
> {
> +				dev_err(&dev->dev, "Missing interrupt
> specifier");
> +				kfree(msgr);
> +				return -EFAULT;
> +			}
> +			msgr->irq =3D irq.start;
> +			irq_index +=3D 1;
> +		} else {
> +			msgr->irq =3D NO_IRQ;
> +		}
> +
> +		mpic_msgrs[reg_number] =3D msgr;
> +		mpic_msgr_disable(msgr);
> +		dev_info(&dev->dev, "Register %d initialized: irq %d\n",
> +				 msgr->num, msgr->irq);
> +
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id mpic_msgr_ids[] =3D {
> +	{
> +		.compatible =3D "fsl,mpic-v3.1-msgr",
> +		.data =3D NULL,
> +	},
> +	{}
> +};
> +
> +static struct platform_driver mpic_msgr_driver =3D {
> +	.driver =3D {
> +		.name =3D "mpic-msgr",
> +		.owner =3D THIS_MODULE,
> +		.of_match_table =3D mpic_msgr_ids,
> +	},
> +	.probe =3D mpic_msgr_probe,
> +};
> +
> +static __init int mpic_msgr_init(void)
> +{
> +	return platform_driver_register(&mpic_msgr_driver);
> +}
> +subsys_initcall(mpic_msgr_init);
> --
> 1.6.3.3
>=20
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
