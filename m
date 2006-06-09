Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1ABE667C18
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jun 2006 14:16:10 +1000 (EST)
Subject: Re: [PATCH 2/10 v2] Add the MPC8641 HPCN platform files.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1149803821.23938.278.camel@cashmere.sps.mot.com>
References: <1149803821.23938.278.camel@cashmere.sps.mot.com>
Content-Type: text/plain
Date: Fri, 09 Jun 2006 14:15:58 +1000
Message-Id: <1149826559.12687.41.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-06-08 at 16:57 -0500, Jon Loeliger wrote:

> +void
> +mpc86xx_restart(char *cmd)
> +{
> +	void __iomem *rstcr;
> +
> +	local_irq_disable();
> +
> +	/* Assert reset request to Reset Control Register */
> +	rstcr = ioremap(get_immrbase() + MPC86XX_RSTCR_OFFSET, 0x100);
> +	out_be32(rstcr, 0x2);
> +
> +	/* not reached */
> +}

ioremap with irq disabled isn't great....  You should do the ioremap
once at boot.

> +long __init
> +mpc86xx_time_init(void)
> +{
> +	unsigned int temp;
> +
> +	/* Set the time base to zero */
> +	mtspr(SPRN_TBWL, 0);
> +	mtspr(SPRN_TBWU, 0);
> +
> +	temp = mfspr(SPRN_HID0);
> +	temp |= HID0_TBEN;
> +	mtspr(SPRN_HID0, temp);
> +	asm volatile("isync");
> +
> +	return 0;
> +}

Overall, that file is too small :) Move those into your setup.c and make
those static... Also time_init() is too late to enable the timebase
imho. You should have it enabled as soon as possible, possibly as soon
as the cpu setup gets run (though you don't have to initialize it to 0)

> +#ifdef CONFIG_SMP
> +static void __init
> +smp_8641_kick_cpu(int nr)
> +{
> +	*(unsigned long *)KERNELBASE = nr;
> +	asm volatile("dcbf 0,%0"::"r"(KERNELBASE):"memory");
> +	printk("CPU%d released, waiting\n",nr);
> +}
> +
> +static void __init
> +smp_8641_setup_cpu(int cpu_nr)
> +{
> +	mpic_setup_this_cpu();
> +}
> +
> +
> +struct smp_ops_t smp_8641_ops = {
> +	.message_pass = smp_mpic_message_pass,
> +	.probe = smp_mpic_probe,
> +	.kick_cpu = smp_8641_kick_cpu,
> +	.setup_cpu = smp_8641_setup_cpu,
> +	.take_timebase = smp_generic_take_timebase,
> +	.give_timebase = smp_generic_give_timebase,
> +};
> +#endif /* CONFIG_SMP */

This file could/should be called *_smp.c and not need #ifdef's :)

> diff --git a/arch/powerpc/platforms/86xx/mpc8641_hpcn.h b/arch/powerpc/platforms/86xx/mpc8641_hpcn.h
> new file mode 100644
> index 0000000..4ba5b4c
> --- /dev/null
> +++ b/arch/powerpc/platforms/86xx/mpc8641_hpcn.h
> @@ -0,0 +1,54 @@
> +/*
> + * MPC8641 HPCN board definitions
> + *
> + * Copyright 2006 Freescale Semiconductor Inc.
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + *
> + * Author: Xianghua Xiao <x.xiao@freescale.com>
> + */
> +
> +#ifndef __MPC8641_HPCN_H__
> +#define __MPC8641_HPCN_H__
> +
> +#include <linux/config.h>
> +#include <linux/init.h>
> +
> +/* PCI interrupt controller */
> +#define PIRQA		3
> +#define PIRQB		4
> +#define PIRQC		5
> +#define PIRQD		6
> +#define PIRQ7		7
> +#define PIRQE		9
> +#define PIRQF		10
> +#define PIRQG		11
> +#define PIRQH		12
> +
> +/* PEX memory map */
> +#define MPC86XX_PEX_LOWER_IO        0x00000000
> +#define MPC86XX_PEX_UPPER_IO        0x00ffffff
> +
> +#define MPC86XX_PEX_LOWER_MEM       0x80000000
> +#define MPC86XX_PEX_UPPER_MEM       0x9fffffff
> +
> +#define MPC86XX_PEX_IO_BASE         0xe2000000
> +#define MPC86XX_PEX_MEM_OFFSET      0x00000000
> +
> +#define MPC86XX_PEX_IO_SIZE         0x01000000
> +
> +#define PEX1_CFG_ADDR_OFFSET    (0x8000)
> +#define PEX1_CFG_DATA_OFFSET    (0x8004)
> +
> +#define PEX2_CFG_ADDR_OFFSET    (0x9000)
> +#define PEX2_CFG_DATA_OFFSET    (0x9004)
> +
> +#define MPC86xx_PEX_OFFSET PEX1_CFG_ADDR_OFFSET
> +#define MPC86xx_PEX_SIZE	(0x1000)
> +
> +#define MPC86XX_RSTCR_OFFSET	(0xe00b0)	/* Reset Control Register */

Most of the values above should probably be retreived from the
device-tree.

> +#endif	/* __MPC8641_HPCN_H__ */
> diff --git a/arch/powerpc/platforms/86xx/mpc86xx.h b/arch/powerpc/platforms/86xx/mpc86xx.h
> new file mode 100644
> index 0000000..7cc45d4
> --- /dev/null
> +++ b/arch/powerpc/platforms/86xx/mpc86xx.h
> @@ -0,0 +1,31 @@
> +/*
> + * Copyright 2006 Freescale Semiconductor Inc.
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#ifndef __MPC86XX_H__
> +#define __MPC86XX_H__
> +
> +/*
> + * Declaration for the various functions exported by the
> + * mpc86xx_* files. Mostly for use by mpc86xx_setup().
> + */
> +
> +extern void mpc86xx_restart(char *cmd);
> +extern long __init mpc86xx_time_init(void);

As I suggested before, the 2 above should be static in your setup file.

> +extern int __init add_bridge(struct device_node *dev);

Aren't we exposing that already via some header ?

> +extern void __init setup_indirect_pex(struct pci_controller* hose,
> +				      u32 cfg_addr, u32 cfg_data);
> +extern void __init setup_indirect_pex_nomap(struct pci_controller* hose,
> +					    void __iomem * cfg_addr,
> +					    void __iomem * cfg_data);
> +
> +extern struct smp_ops_t smp_8641_ops;

See my comments about the PCI stuff with the PCI patch.

> +#endif	/* __MPC86XX_H__ */
> diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
> new file mode 100644
> index 0000000..d413e95
> --- /dev/null
> +++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
> @@ -0,0 +1,304 @@
> +/*
> + * MPC86xx HPCN board specific routines
> + *
> + * Recode: ZHANG WEI <wei.zhang@freescale.com>
> + * Initial author: Xianghua Xiao <x.xiao@freescale.com>
> + *
> + * Copyright 2006 Freescale Semiconductor Inc.
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/config.h>
> +#include <linux/stddef.h>
> +#include <linux/kernel.h>
> +#include <linux/pci.h>
> +#include <linux/kdev_t.h>
> +#include <linux/delay.h>
> +#include <linux/seq_file.h>
> +#include <linux/root_dev.h>
> +
> +#include <asm/system.h>
> +#include <asm/time.h>
> +#include <asm/machdep.h>
> +#include <asm/pci-bridge.h>
> +#include <asm/mpc86xx.h>
> +#include <asm/prom.h>
> +#include <mm/mmu_decl.h>
> +#include <asm/udbg.h>
> +#include <asm/i8259.h>
> +
> +#include <asm/mpic.h>
> +
> +#include <sysdev/fsl_soc.h>
> +
> +#include "mpc86xx.h"
> +
> +#ifndef CONFIG_PCI
> +unsigned long isa_io_base = 0;
> +unsigned long isa_mem_base = 0;
> +unsigned long pci_dram_offset = 0;
> +#endif
> +
> +
> +/*
> + * Internal interrupts are all Level Sensitive, and Positive Polarity
> + */
> +
> +static u_char mpc86xx_hpcn_openpic_initsenses[] __initdata = {
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  0: Reserved */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  1: MCM */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  2: DDR DRAM */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  3: LBIU */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  4: DMA 0 */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  5: DMA 1 */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  6: DMA 2 */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  7: DMA 3 */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  8: PEX1 */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  9: PEX2 */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 10: Reserved */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 11: Reserved */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 12: DUART2 */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 13: TSEC 1 Transmit */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 14: TSEC 1 Receive */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 15: TSEC 3 transmit */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 16: TSEC 3 receive */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 17: TSEC 3 error */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 18: TSEC 1 Receive/Transmit Error */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 19: TSEC 2 Transmit */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 20: TSEC 2 Receive */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 21: TSEC 4 transmit */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 22: TSEC 4 receive */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 23: TSEC 4 error */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 24: TSEC 2 Receive/Transmit Error */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 25: Unused */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 26: DUART1 */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 27: I2C */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 28: Performance Monitor */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 29: Unused */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 30: Unused */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 31: Unused */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 32: SRIO error/write-port unit */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 33: SRIO outbound doorbell */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 34: SRIO inbound doorbell */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 35: Unused */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 36: Unused */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 37: SRIO outbound message unit 1 */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 38: SRIO inbound message unit 1 */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 39: SRIO outbound message unit 2 */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 40: SRIO inbound message unit 2 */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 41: Unused */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 42: Unused */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 43: Unused */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 44: Unused */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 45: Unused */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 46: Unused */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 47: Unused */
> +	0x0,						/* External  0: */
> +	0x0,						/* External  1: */
> +	0x0,						/* External  2: */
> +	0x0,						/* External  3: */
> +	0x0,						/* External  4: */
> +	0x0,						/* External  5: */
> +	0x0,						/* External  6: */
> +	0x0,						/* External  7: */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External  8: Pixis FPGA */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* External  9: ULI 8259 INTR Cascade */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External 10: Quad ETH PHY */
> +	0x0,						/* External 11: */
> +	0x0,
> +	0x0,
> +	0x0,
> +	0x0,
> +};

All of the above should of course come from the device-tree. 2.6.18 will
have the support for having interrupt routing from it without having
nodes for all devices. I'll post it to the list in a week or so, I'm
coding right now :)

> +void __init
> +mpc86xx_hpcn_init_IRQ(void)
> +{
> +	struct mpic *mpic1;
> +	phys_addr_t OpenPIC_PAddr;
> +
> +	/* Determine the Physical Address of the OpenPIC regs */
> +	OpenPIC_PAddr = get_immrbase() + MPC86xx_OPENPIC_OFFSET;

Do you really _need_ studly caps ? I know we did that before but you
don't have to copy ugly stuff :)

In general, you -need- a device node for the interrupt controller. It
will be made mandatory by the new code. You'll have to provide proper
interrupt informations in your device-tree (it's easy, really). Your
host PCI bridge shall have the interrupt-map for all the slots lines and
your on chip devices have proper interrupt routing info, and all shall
have your interrupt controller node as the interrupt parent.

If you get that right, it will be very easy to "just work" with my new
code.

> +	/* Alloc mpic structure and per isu has 16 INT entries. */
> +	mpic1 = mpic_alloc(OpenPIC_PAddr,
> +			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
> +			16, MPC86xx_OPENPIC_IRQ_OFFSET, 0, 250,
> +			mpc86xx_hpcn_openpic_initsenses,
> +			sizeof(mpc86xx_hpcn_openpic_initsenses),
> +			" MPIC     ");
> +	BUG_ON(mpic1 == NULL);
> +
> +	/* 48 Internal Interrupts */
> +	mpic_assign_isu(mpic1, 0, OpenPIC_PAddr + 0x10200);
> +	mpic_assign_isu(mpic1, 1, OpenPIC_PAddr + 0x10400);
> +	mpic_assign_isu(mpic1, 2, OpenPIC_PAddr + 0x10600);

I haven't looked in detail at your memory map, but do you need separate
ISUs ? They seem to be quite close together to me... Also, you should
invent properties in the mpic node for some of those things, like
big-endian (like apple does) indicating it's a big endian openpic,
etc... If you manage to get close enough to spec & common usage, you
might not even need your own init function at all in the future.

> +	/* 16 External interrupts */
> +	mpic_assign_isu(mpic1, 3, OpenPIC_PAddr + 0x10000);

That looks like you used ISUs in order to "re-order" them... why ?

> +	mpic_init(mpic1);
> +
> +#ifdef CONFIG_PEX
> +	mpic_setup_cascade(MPC86xx_IRQ_EXT9, i8259_irq_cascade, NULL);
> +	i8259_init(0, I8259_OFFSET);
> +#endif
> +}

Cascade handling is changing with my genirq port. It will be easy to
adapt though. Same comments howveer, you should have a device-tree node
for the 8259 (under an ISA bridge, those shall really be in the
device-tree). In general, on-board bridges should be in the device-tree,
only slots or standardly routed child PCI devices need not.

> +int
> +mpc86xx_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
> +{
> +	static char pci_irq_table[][4] = {
> +		/*
> +		 *      PCI IDSEL/INTPIN->INTLINE
> +		 *       A      B      C      D
> +		 */
> +		{PIRQA, PIRQB, PIRQC, PIRQD},   /* IDSEL 17 -- PCI Slot 1 */
> +		{PIRQB, PIRQC, PIRQD, PIRQA},	/* IDSEL 18 -- PCI Slot 2 */
> +		{0, 0, 0, 0},			/* IDSEL 19 */
> +		{0, 0, 0, 0},			/* IDSEL 20 */
> +		{0, 0, 0, 0},			/* IDSEL 21 */
> +		{0, 0, 0, 0},			/* IDSEL 22 */
> +		{0, 0, 0, 0},			/* IDSEL 23 */
> +		{0, 0, 0, 0},			/* IDSEL 24 */
> +		{0, 0, 0, 0},			/* IDSEL 25 */
> +		{0, 0, 0, 0},			/* IDSEL 26 */
> +		{PIRQC, 0, 0, 0},		/* IDSEL 27 -- LAN */
> +		{PIRQE, PIRQF, PIRQH, PIRQ7},	/* IDSEL 28 -- USB 1.1 */
> +		{PIRQE, PIRQF, PIRQG, 0},	/* IDSEL 29 -- Audio & Modem */
> +		{PIRQH, 0, 0, 0},		/* IDSEL 30 -- LPC & PMU*/
> +		{PIRQD, 0, 0, 0},		/* IDSEL 31 -- ATA */
> +	};
> +
> +	const long min_idsel = 17, max_idsel = 31, irqs_per_slot = 4;
> +	return PCI_IRQ_TABLE_LOOKUP + I8259_OFFSET;
> +}

All of the above shall be in the device-tree.

> +
> +int
> +mpc86xx_exclude_device(u_char bus, u_char devfn)
> +{
> +#if !defined(CONFIG_PEX)
> +	if (bus == 0 && PCI_SLOT(devfn) == 0)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +#endif
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +#endif /* CONFIG_PCI */

Hrm... not sure I like that much but let's ignore it for now.
> +
> +static void __init
> +mpc86xx_hpcn_setup_arch(void)
> +{
> +	struct device_node *np;
> +
> +#ifdef CONFIG_SMP
> +	phys_addr_t mcm_paddr;
> +	void *mcm_vaddr = NULL;
> +	unsigned long vaddr;
> +#endif
> +
> +	if (ppc_md.progress)
> +		ppc_md.progress("mpc86xx_hpcn_setup_arch()", 0);
> +
> +	np = of_find_node_by_type(NULL, "cpu");
> +	if (np != 0) {
> +		unsigned int *fp;
> +
> +		fp = (int *)get_property(np, "clock-frequency", NULL);
> +		if (fp != 0)
> +			loops_per_jiffy = *fp / HZ;
> +		else
> +			loops_per_jiffy = 50000000 / HZ;
> +		of_node_put(np);
> +	}

The above looks dodgy... powerpc uses the timebase frequency for delays
anyway, lpj will be initialized by the bogomips code, and should but
unused mostly nowadays anyway.

> +#ifdef CONFIG_PEX
> +	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
> +		add_bridge(np);
> +
> +	ppc_md.pci_swizzle = common_swizzle;
> +	ppc_md.pci_map_irq = mpc86xx_map_irq;
> +	ppc_md.pci_exclude_device = mpc86xx_exclude_device;
> +#endif

I'm not sure I like this CONFIG_PEX (in general). Just use CONFIG_PCI
for now all over the place. PCI-E has it's own binding that we don't
quite respect yet but will do and all of that will be in the
device-tree. However, as far as the kernel is concerned, this is all
under CONFIG_PCI.

> +	printk("HPCN board with 86xx from Freescale Semiconductor\n");
> +
> +#ifdef  CONFIG_ROOT_NFS
> +	ROOT_DEV = Root_NFS;
> +#else
> +	ROOT_DEV = Root_HDA1;
> +#endif
> +
> +#ifdef CONFIG_SMP
> +  	/* Release Core 1 in boot holdoff */
> +	mcm_paddr = get_immrbase() + MPC86xx_MCM_OFFSET;
> +	mcm_vaddr = ioremap(mcm_paddr, MPC86xx_MCM_SIZE);
> +
> +	vaddr = (unsigned long)mcm_vaddr +  MCM_PORT_CONFIG_OFFSET;
> +	out_be32((volatile unsigned *)vaddr, CPU_ALL_RELEASED);
> +	smp_ops = &smp_8641_ops;
> +#endif
> +}

Instead of ifdef's, just do a mpc86xx_smp_init() and put it somewhere
with the other SMP things in the file that contains them (and remove the
#ifdef's there too, just only build the file if CONFIG_SMP is set).

> +
> +void
> +mpc86xx_hpcn_show_cpuinfo(struct seq_file *m)
> +{
> +	uint pvid, svid, phid1;
> +	uint memsize = total_memory;
> +
> +	pvid = mfspr(SPRN_PVR);
> +	svid = mfspr(SPRN_SVR);
>
> +	seq_printf(m, "Vendor\t\t: Freescale Semiconductor\n");
> +	seq_printf(m, "Machine\t\t: MPC86xx HPCN Board\n");
> +	seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
> +	seq_printf(m, "SVR\t\t: 0x%x\n", svid);

The PVR is probably a duplicate and the SVR should be added to per-cpu
info instead.

> +	/* Display cpu Pll setting */
> +	phid1 = mfspr(SPRN_HID1);
> +	seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
> +
> +	/* Display the amount of memory */
> +	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
> +}
> +
> +/*
> + * Called very early, device-tree isn't unflattened
> + */
> +static int __init mpc86xx_hpcn_probe(void)
> +{
> +	unsigned long root = of_get_flat_dt_root();
> +
> +	if (of_flat_dt_is_compatible(root, "mpc86xx"))
> +		return 1;	/* Looks good */
> +
> +	return 0;
> +}
> +
> +define_machine(mpc86xx_hpcn) {
> +	.name			= "MPC86xx HPCN",
> +	.probe			= mpc86xx_hpcn_probe,
> +	.setup_arch		= mpc86xx_hpcn_setup_arch,
> +	.init_IRQ		= mpc86xx_hpcn_init_IRQ,
> +	.show_cpuinfo		= mpc86xx_hpcn_show_cpuinfo,
> +	.get_irq		= mpic_get_irq,
> +	.restart		= mpc86xx_restart,
> +	.time_init		= mpc86xx_time_init,
> +	.calibrate_decr		= generic_calibrate_decr,
> +	.progress		= udbg_progress,
> +};
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
