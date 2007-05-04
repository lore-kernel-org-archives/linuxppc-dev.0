Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id C6C08DDEC6
	for <linuxppc-dev@ozlabs.org>; Sat,  5 May 2007 05:00:11 +1000 (EST)
Date: Fri, 4 May 2007 14:01:40 -0500
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/4] Add support for 750CL Holly board
Message-ID: <20070504190140.GA13067@lixom.net>
References: <1178302414.3026.202.camel@zod.rchland.ibm.com>
	<1178302469.3026.204.camel@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1178302469.3026.204.camel@zod.rchland.ibm.com>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Overall pretty good, I have a few comments below.


-Olof

On Fri, May 04, 2007 at 01:14:29PM -0500, Josh Boyer wrote:
> Add PowerPC 750 Holly/Hickory platform support
> 
> Signed-off-by: Stephen Winiecki <stevewin@us.ibm.com>
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> ---
>  arch/powerpc/Kconfig                        |    2 
>  arch/powerpc/platforms/embedded6xx/Kconfig  |   12 -
>  arch/powerpc/platforms/embedded6xx/Makefile |    1 
>  arch/powerpc/platforms/embedded6xx/holly.c  |  326 ++++++++++++++++++++++++++++
>  arch/powerpc/platforms/embedded6xx/holly.h  |   24 ++
>  drivers/net/tsi108_eth.h                    |    4 
>  include/asm-powerpc/tsi108.h                |    4 
>  7 files changed, 371 insertions(+), 2 deletions(-)
> 
> --- linux-2.6.orig/arch/powerpc/Kconfig
> +++ linux-2.6/arch/powerpc/Kconfig
> @@ -659,7 +659,7 @@ config MCA
>  config PCI
>  	bool "PCI support" if 40x || CPM2 || PPC_83xx || PPC_85xx || PPC_86xx \
>  		|| PPC_MPC52xx || (EMBEDDED && (PPC_PSERIES || PPC_ISERIES)) \
> -		|| MPC7448HPC2 || PPC_PS3
> +		|| MPC7448HPC2 || PPC_PS3 || HOLLY
>  	default y if !40x && !CPM2 && !8xx && !APUS && !PPC_83xx \
>  		&& !PPC_85xx && !PPC_86xx
>  	default PCI_PERMEDIA if !4xx && !CPM2 && !8xx && APUS
> --- linux-2.6.orig/arch/powerpc/platforms/embedded6xx/Kconfig
> +++ linux-2.6/arch/powerpc/platforms/embedded6xx/Kconfig
> @@ -25,11 +25,21 @@ config MPC7448HPC2
>  	help
>  	  Select MPC7448HPC2 if configuring for Freescale MPC7448HPC2 (Taiga)
>  	  platform
> +
> +config HOLLY
> +	bool "PPC750GX/CL with TSI10x bridge (Hickory/Holly)"
> +	select TSI108_BRIDGE
> +	select PPC_UDBG_16550
> +	select MPIC
> +	select MPIC_WEIRD
> +	help
> +	  Select HOLLY if configuring for an IBM 750GX/CL Eval
> +	  Board with TSI108/9 bridge (Hickory/Holly)
>  endchoice
>  
>  config TSI108_BRIDGE
>  	bool
> -	depends on MPC7448HPC2
> +	depends on MPC7448HPC2 || HOLLY
>  	default y
>  
>  config MPC10X_BRIDGE
> --- linux-2.6.orig/arch/powerpc/platforms/embedded6xx/Makefile
> +++ linux-2.6/arch/powerpc/platforms/embedded6xx/Makefile
> @@ -3,3 +3,4 @@
>  #
>  obj-$(CONFIG_MPC7448HPC2)	+= mpc7448_hpc2.o
>  obj-$(CONFIG_LINKSTATION)	+= linkstation.o ls_uart.o
> +obj-$(CONFIG_HOLLY)		+= holly.o
> --- /dev/null
> +++ linux-2.6/arch/powerpc/platforms/embedded6xx/holly.c
> @@ -0,0 +1,326 @@
> +/*
> + * Board setup routines for the IBM 750GX/CL platform w/ TSI10x bridge
> + *
> + * Copyright 2007 IBM Corporation
> + *
> + * Stephen Winiecki <stevewin@us.ibm.com>
> + * Josh Boyer <jwboyer@linux.vnet.ibm.com>
> + *
> + * Based on code from mpc7448_hpc2.c
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + */
> +
> +#include <linux/stddef.h>
> +#include <linux/kernel.h>
> +#include <linux/pci.h>
> +#include <linux/kdev_t.h>
> +#include <linux/console.h>
> +#include <linux/delay.h>
> +#include <linux/irq.h>
> +#include <linux/ide.h>
> +#include <linux/seq_file.h>
> +#include <linux/root_dev.h>
> +#include <linux/serial.h>
> +#include <linux/tty.h>
> +#include <linux/serial_core.h>
> +
> +#include <asm/system.h>
> +#include <asm/time.h>
> +#include <asm/machdep.h>
> +#include <asm/prom.h>
> +#include <asm/udbg.h>
> +#include <asm/tsi108.h>
> +#include <asm/pci-bridge.h>
> +#include <asm/reg.h>
> +#include <mm/mmu_decl.h>
> +#include "holly.h"
> +#include <asm/tsi108_irq.h>
> +#include <asm/mpic.h>
> +#include <asm/of_platform.h>
> +
> +#undef DEBUG
> +#ifdef DEBUG
> +#define DBG(fmt...) do { printk(fmt); } while(0)
> +#else
> +#define DBG(fmt...) do { } while(0)
> +#endif

Please use pr_debug() instead.

> +#ifndef CONFIG_PCI
> +pci_dram_offset = PPC750GXCL_TSI_PCI_MEM_OFFSET;
> +#endif

What's this about?

> +extern int tsi108_setup_pci(struct device_node *dev);
> +extern void tsi108_pci_int_init(struct device_node *node);
> +extern void tsi108_irq_cascade(unsigned int irq, struct irq_desc *desc);
> +
> +int holly_exclude_device(u_char bus, u_char devfn)
> +{
> +	if (bus == 0 && PCI_SLOT(devfn) == 0)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +	else
> +		return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static void holly_remap_bridge(void)
> +{
> +	u32 lut_val, lut_addr = 0x900, misc_cfg;

Please initialize lut_addr right before using it instead of here, especially
since you re-assign it later on.

> +	int i;
> +
> +	printk(KERN_ERR "Remapping PCI bridge\n");
> +
> +	/* Re-init the PCI bridge and LUT registers to have mappings that don't
> +	 * rely on PIBS */

Comment style

> +	for (i = 0; i < 31; i++) {
> +		tsi108_write_reg(TSI108_PB_OFFSET + lut_addr, 0x00000201);
> +		lut_addr += 4;
> +		tsi108_write_reg(TSI108_PB_OFFSET + lut_addr, 0x0);
> +		lut_addr += 4;
> +	}
> +
> +	/* Reserve the last LUT entry for PCI I/O space */
> +	tsi108_write_reg(TSI108_PB_OFFSET + lut_addr, 0x00000241);
> +	lut_addr += 4;
> +	tsi108_write_reg(TSI108_PB_OFFSET + lut_addr, 0x0);
> +
> +	/* Map PCI I/O space */
> +	tsi108_write_reg(TSI108_PCI_OFFSET + 0x210, 0x0);
> +	tsi108_write_reg(TSI108_PCI_OFFSET + 0x20c, 0x1);
> +
> +	/* Map PCI CFG space */
> +	tsi108_write_reg(TSI108_PCI_OFFSET + 0x208, 0x0);
> +	tsi108_write_reg(TSI108_PCI_OFFSET + 0x204, 0x7c000000 | 0x01);
> +
> +	/* We don't need MEM32 and PRM remapping so disable them */
> +	tsi108_write_reg(TSI108_PCI_OFFSET + 0x214, 0x0);
> +	tsi108_write_reg(TSI108_PCI_OFFSET + 0x220, 0x0);
> +	tsi108_write_reg(TSI108_PCI_OFFSET + 0x230, 0x0);

It would be nice to get these constants defined up, but I know it's not always
practical. I'll bring it up anyway. :-)

> +
> +	/* Set P2O_BAR0 */
> +	tsi108_write_reg(TSI108_PCI_OFFSET + 0x14, 0x0);
> +	tsi108_write_reg(TSI108_PCI_OFFSET + 0x10, 0xc0000000);
> +
> +	/* Init the PCI LUTs to do no remapping */
> +	lut_addr = 0x500;
> +	lut_val = 0x00000002;
> +
> +	for (i = 0; i < 32; i++) {
> +		tsi108_write_reg(TSI108_PCI_OFFSET + lut_addr, lut_val);
> +		lut_addr += 4;
> +		tsi108_write_reg(TSI108_PCI_OFFSET + lut_addr, 0x40000000);
> +		lut_addr += 4;
> +		lut_val += 0x02000000;
> +	}
> +	tsi108_write_reg(TSI108_PCI_OFFSET + 0x4c, 0x00007900);
> +
> +	/* Set 64-bit PCI bus address for system memory */
> +	tsi108_write_reg(TSI108_PCI_OFFSET + 0x1c, 0x0);
> +	tsi108_write_reg(TSI108_PCI_OFFSET + 0x18, 0x0);
> +}
> +
> +static void __init holly_setup_arch(void)
> +{
> +	struct device_node *cpu;
> +	struct device_node *np;
> +
> +	if (ppc_md.progress)
> +		ppc_md.progress("holly_setup_arch():set_bridge", 0);
> +
> +	cpu = of_find_node_by_type(NULL, "cpu");
> +	if (cpu != 0) {
> +		const unsigned int *fp;
> +
> +		fp = of_get_property(cpu, "clock-frequency", NULL);
> +		if (fp != 0)
> +			loops_per_jiffy = *fp / HZ;
> +		else
> +			loops_per_jiffy = 50000000 / HZ;
> +		of_node_put(cpu);
> +	}
> +	tsi108_csr_vir_base = get_vir_csrbase();
> +
> +	/* setup PCI host bridge */
> +	holly_remap_bridge();
> +#ifdef CONFIG_PCI
> +	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
> +		tsi108_setup_pci(np);

On an environment without PCI, wouldn't it make more sense to leave it
out of the device tree, and thus not have a match in the above, instead
of taking out CONFIG_PCI?

> +
> +	ppc_md.pci_exclude_device = holly_exclude_device;
> +	if (ppc_md.progress)
> +		ppc_md.progress("tsi108: resources set", 0x100);
> +#endif
> +	printk(KERN_INFO "PPC750GX/CL Platform\n");
> +}
> +
> +/*
> + * Interrupt setup and service.  Interrrupts on the holly come
> + * from the four external INT pins, PCI interrupts are routed via
> + * PCI interrupt control registers, it generates internal IRQ23
> + *
> + * Interrupt routing on the Holly Board:
> + * TSI108:PB_INT[0] -> CPU0:INT#
> + * TSI108:PB_INT[1] -> CPU0:MCP#
> + * TSI108:PB_INT[2] -> N/C
> + * TSI108:PB_INT[3] -> N/C
> + */
> +static void __init holly_init_IRQ(void)
> +{
> +	struct mpic *mpic;
> +	phys_addr_t mpic_paddr = 0;
> +	struct device_node *tsi_pic;
> +#ifdef CONFIG_PCI
> +	unsigned int cascade_pci_irq;
> +	struct device_node *tsi_pci;
> +	struct device_node *cascade_node = NULL;
> +#endif
> +
> +	tsi_pic = of_find_node_by_type(NULL, "open-pic");
> +	if (tsi_pic) {
> +		unsigned int size;
> +		const void *prop = of_get_property(tsi_pic, "reg", &size);
> +		mpic_paddr = of_translate_address(tsi_pic, prop);
> +	}
> +
> +	if (mpic_paddr == 0) {
> +		printk(KERN_ERR "%s: No tsi108 PIC found !\n", __func__);
> +		return;
> +	}
> +
> +	DBG("%s: tsi108 pic phys_addr = 0x%x\n", __func__, (u32) mpic_paddr);
> +
> +	mpic = mpic_alloc(tsi_pic, mpic_paddr,
> +			MPIC_PRIMARY | MPIC_BIG_ENDIAN | MPIC_WANTS_RESET |
> +			MPIC_SPV_EOI | MPIC_NO_PTHROU_DIS | MPIC_REGSET_TSI108,
> +			24,
> +			NR_IRQS-4, /* num_sources used */
> +			"Tsi108_PIC");
> +
> +	BUG_ON(mpic == NULL);
> +
> +	mpic_assign_isu(mpic, 0, mpic_paddr + 0x100);
> +
> +	mpic_init(mpic);
> +
> +#ifdef CONFIG_PCI
> +	tsi_pci = of_find_node_by_type(NULL, "pci");
> +	if (tsi_pci == NULL) {
> +		printk(KERN_ERR "%s: No tsi108 pci node found !\n", __func__);
> +		return;
> +	}
> +
> +	cascade_node = of_find_node_by_type(NULL, "pic-router");
> +	if (cascade_node == NULL) {
> +		printk(KERN_ERR "%s: No tsi108 pci cascade node found !\n", __func__);
> +		return;
> +	}
> +
> +	cascade_pci_irq = irq_of_parse_and_map(tsi_pci, 0);
> +	DBG("%s: tsi108 cascade_pci_irq = 0x%x\n", __func__, (u32) cascade_pci_irq);
> +	tsi108_pci_int_init(cascade_node);
> +	set_irq_data(cascade_pci_irq, mpic);
> +	set_irq_chained_handler(cascade_pci_irq, tsi108_irq_cascade);
> +#endif
> +	/* Configure MPIC outputs to CPU0 */
> +	tsi108_write_reg(TSI108_MPIC_OFFSET + 0x30c, 0);
> +	of_node_put(tsi_pic);
> +}
> +
> +void holly_show_cpuinfo(struct seq_file *m)
> +{
> +	seq_printf(m, "vendor\t\t: IBM\n");
> +	seq_printf(m, "machine\t\t: PPC750 GX/CL\n");
> +}
> +
> +void holly_restart(char *cmd)
> +{
> +	unsigned long *ocn_bar1 = NULL;
> +	unsigned long bar;
> +	struct device_node *bridge = NULL;
> +	const void *prop;
> +	int size;
> +	phys_addr_t addr = 0xc0000000;
> +
> +	local_irq_disable();
> +
> +	bridge = of_find_node_by_type(NULL, "tsi-bridge");
> +	if (bridge) {
> +		prop = of_get_property(bridge, "reg", &size);
> +		addr = of_translate_address(bridge, prop);
> +	}
> +	addr += (TSI108_PB_OFFSET + 0x414);
> +
> +	ocn_bar1 = ioremap(addr, 0x4);
> +
> +	/* Turn on the BOOT bit so the addresses are correctly
> +	 * routed to the HLP interface */
> +	bar = ioread32be(ocn_bar1);
> +	bar |= 2;
> +	iowrite32be(bar, ocn_bar1);
> +	iosync();
> +
> +	/* Set SRR0 to the reset vector and turn on MSR_IP */
> +	mtspr(SPRN_SRR0, 0xfff00100);
> +	mtspr(SPRN_SRR1, MSR_IP);
> +
> +	/* Do an rfi to jump back to firmware.  Somewhat evil,
> +	 * but it works
> +	 */
> +	__asm__ __volatile__("rfi" : : : "memory");

Evil, yes, but it should work. Actually, it should work for me as well,
thanks for the tip. :)

> +
> +	/* Spin until reset happens.  Shouldn't really get here */
> +	for (;;) ;
> +}
> +
> +void holly_power_off(void)
> +{
> +	local_irq_disable();
> +	/* No way to shut power off with software */
> +	for (;;) ;
> +}
> +
> +void holly_halt(void)
> +{
> +	holly_power_off();
> +}
> +
> +/*
> + * Called very early, device-tree isn't unflattened
> + */
> +static int __init holly_probe(void)
> +{
> +	unsigned long root = of_get_flat_dt_root();
> +
> +	if (!of_flat_dt_is_compatible(root, "ppc750"))
> +		return 0;

That's a pretty broad compatible check?

> +	return 1;
> +}
> +
> +static int ppc750_machine_check_exception(struct pt_regs *regs)
> +{
> +	extern void tsi108_clear_pci_cfg_error(void);
> +	const struct exception_table_entry *entry;
> +
> +	/* Are we prepared to handle this fault */
> +	if ((entry = search_exception_tables(regs->nip)) != NULL) {
> +		tsi108_clear_pci_cfg_error();
> +		regs->msr |= MSR_RI;
> +		regs->nip = entry->fixup;
> +		return 1;
> +	}
> +	return 0;
> +}
> +
> +define_machine(holly){
> +	.name 						= "PPC750 GX/CL TSI",
> +	.probe 						= holly_probe,
> +	.setup_arch 				= holly_setup_arch,
> +	.init_IRQ 					= holly_init_IRQ,
> +	.show_cpuinfo 				= holly_show_cpuinfo,
> +	.get_irq 					= mpic_get_irq,
> +	.restart 					= holly_restart,
> +	.calibrate_decr 			= generic_calibrate_decr,
> +	.machine_check_exception	= ppc750_machine_check_exception,
> +	.progress 					= udbg_progress,

These look all unaligned for me.

> +};
> --- /dev/null
> +++ linux-2.6/arch/powerpc/platforms/embedded6xx/holly.h
> @@ -0,0 +1,24 @@
> +/*
> + * Definitions for the IBM 750GX/CL platform w/ TSI10x bridge
> + *
> + * Copyright 2007 IBM Corporation
> + *
> + * Stephen Winiecki <stevewin@us.ibm.com>
> + * Josh Boyer <jwboyer@linux.vnet.ibm.com>
> + *
> + * Based on code from mpc7448_hpc2.h
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + */
> +
> +#ifndef __PPC_PLATFORMS_PPC750GXCL_TSI_H
> +#define __PPC_PLATFORMS_PPC750GXCL_TSI_H
> +
> +#include <asm/ppcboot.h>
> +
> +/* Base Addresses for the PCI bus
> + */
> +#define PPC750GXCL_TSI_PCI_MEM_OFFSET	(0x00000000)
> +#endif				/* __PPC_PLATFORMS_H */
> --- linux-2.6.orig/drivers/net/tsi108_eth.h
> +++ linux-2.6/drivers/net/tsi108_eth.h
> @@ -49,7 +49,11 @@
>   */
>  #define PHY_MV88E	1	/* Marvel 88Exxxx PHY */
>  #define PHY_BCM54XX	2	/* Broardcom BCM54xx PHY */
> +#if defined(CONFIG_HOLLY)
> +#define TSI108_PHY_TYPE PHY_BCM54XX
> +#else
>  #define TSI108_PHY_TYPE	PHY_MV88E
> +#endif

This won't work well if you ever want to build a multiplatform kernel.

>  
>  /*
>   * TSI108 GIGE port registers
> --- linux-2.6.orig/include/asm-powerpc/tsi108.h
> +++ linux-2.6/include/asm-powerpc/tsi108.h
> @@ -68,7 +68,11 @@
>  #define TSI108_PB_ERRCS_ES		(1 << 1)
>  #define TSI108_PB_ISR_PBS_RD_ERR	(1 << 8)
>  
> +#ifdef CONFIG_HOLLY
> +#define TSI108_PCI_CFG_BASE_PHYS	(0x7c000000)
> +#else
>  #define TSI108_PCI_CFG_BASE_PHYS	(0xfb000000)
> +#endif
>  #define TSI108_PCI_CFG_SIZE		(0x01000000)

Same here. Shouldn't this come out of the devicetree?



-Olof
