Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id D923B67C56
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Nov 2006 00:23:16 +1100 (EST)
Message-Id: <20061102125626.707718000@localhost.localdomain>
References: <20061102125555.252338000@localhost.localdomain>
Date: Thu, 02 Nov 2006 13:56:02 +0100
From: s.hauer@pengutronix.de
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 07/16] powerpc: move MPC7448HPC2 platform support to
	platforms/74xx
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch moves the only platform support in platforms/embedded6xx to
a directory of its own. There seems to be no need for a embedded6xx
directory since they have nothing in common.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Index: arch/powerpc/platforms/74xx/Makefile
===================================================================
--- /dev/null
+++ b/arch/powerpc/platforms/74xx/Makefile
@@ -0,0 +1,4 @@
+#
+# Makefile for the 6xx/7xx/7xxxx linux kernel.
+#
+obj-$(CONFIG_MPC7448HPC2)	+= mpc7448_hpc2.o
Index: arch/powerpc/platforms/74xx/mpc7448_hpc2.c
===================================================================
--- /dev/null
+++ b/arch/powerpc/platforms/74xx/mpc7448_hpc2.c
@@ -0,0 +1,308 @@
+/*
+ * mpc7448_hpc2.c
+ *
+ * Board setup routines for the Freescale mpc7448hpc2(taiga) platform
+ *
+ * Author: Jacob Pan
+ *	 jacob.pan@freescale.com
+ * Author: Xianghua Xiao
+ *       x.xiao@freescale.com
+ * Maintainer: Roy Zang <tie-fei.zang@freescale.com>
+ * 	Add Flat Device Tree support fot mpc7448hpc2 board
+ *
+ * Copyright 2004-2006 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/kdev_t.h>
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/ide.h>
+#include <linux/seq_file.h>
+#include <linux/root_dev.h>
+#include <linux/serial.h>
+#include <linux/tty.h>
+#include <linux/serial_core.h>
+
+#include <asm/system.h>
+#include <asm/time.h>
+#include <asm/machdep.h>
+#include <asm/prom.h>
+#include <asm/udbg.h>
+#include <asm/tsi108.h>
+#include <asm/pci-bridge.h>
+#include <asm/reg.h>
+#include <mm/mmu_decl.h>
+#include "mpc7448_hpc2.h"
+#include <asm/tsi108_irq.h>
+#include <asm/mpic.h>
+
+#undef DEBUG
+#ifdef DEBUG
+#define DBG(fmt...) do { printk(fmt); } while(0)
+#else
+#define DBG(fmt...) do { } while(0)
+#endif
+
+#ifndef CONFIG_PCI
+isa_io_base = MPC7448_HPC2_ISA_IO_BASE;
+isa_mem_base = MPC7448_HPC2_ISA_MEM_BASE;
+pci_dram_offset = MPC7448_HPC2_PCI_MEM_OFFSET;
+#endif
+
+extern int tsi108_setup_pci(struct device_node *dev);
+extern void _nmask_and_or_msr(unsigned long nmask, unsigned long or_val);
+extern void tsi108_pci_int_init(void);
+extern void tsi108_irq_cascade(unsigned int irq, struct irq_desc *desc);
+
+int mpc7448_hpc2_exclude_device(u_char bus, u_char devfn)
+{
+	if (bus == 0 && PCI_SLOT(devfn) == 0)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	else
+		return PCIBIOS_SUCCESSFUL;
+}
+
+/*
+ * find pci slot by devfn in interrupt map of OF tree
+ */
+u8 find_slot_by_devfn(unsigned int *interrupt_map, unsigned int devfn)
+{
+	int i;
+	unsigned int tmp;
+	for (i = 0; i < 4; i++){
+		tmp = interrupt_map[i*4*7];
+		if ((tmp >> 11) == (devfn >> 3))
+			return i;
+	}
+	return i;
+}
+
+/*
+ * Scans the interrupt map for pci device
+ */
+void mpc7448_hpc2_fixup_irq(struct pci_dev *dev)
+{
+	struct pci_controller *hose;
+	struct device_node *node;
+	const unsigned int *interrupt;
+	int busnr;
+	int len;
+	u8 slot;
+	u8 pin;
+
+	/* Lookup the hose */
+	busnr = dev->bus->number;
+	hose = pci_bus_to_hose(busnr);
+	if (!hose)
+		printk(KERN_ERR "No pci hose found\n");
+
+	/* Check it has an OF node associated */
+	node = (struct device_node *) hose->arch_data;
+	if (!node)
+		printk(KERN_ERR "No pci node found\n");
+
+	interrupt = get_property(node, "interrupt-map", &len);
+	slot = find_slot_by_devfn(interrupt, dev->devfn);
+	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
+	if (pin == 0 || pin > 4)
+		pin = 1;
+	pin--;
+	dev->irq  = interrupt[slot*4*7 + pin*7 + 5];
+	DBG("TSI_PCI: dev->irq = 0x%x\n", dev->irq);
+}
+/* temporary pci irq map fixup*/
+
+void __init mpc7448_hpc2_pcibios_fixup(void)
+{
+	struct pci_dev *dev = NULL;
+	for_each_pci_dev(dev) {
+		mpc7448_hpc2_fixup_irq(dev);
+		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
+	}
+}
+
+static void __init mpc7448_hpc2_setup_arch(void)
+{
+	struct device_node *cpu;
+	struct device_node *np;
+	if (ppc_md.progress)
+		ppc_md.progress("mpc7448_hpc2_setup_arch():set_bridge", 0);
+
+	cpu = of_find_node_by_type(NULL, "cpu");
+	if (cpu != 0) {
+		const unsigned int *fp;
+
+		fp = get_property(cpu, "clock-frequency", NULL);
+		if (fp != 0)
+			loops_per_jiffy = *fp / HZ;
+		else
+			loops_per_jiffy = 50000000 / HZ;
+		of_node_put(cpu);
+	}
+	tsi108_csr_vir_base = get_vir_csrbase();
+
+#ifdef	CONFIG_ROOT_NFS
+	ROOT_DEV = Root_NFS;
+#else
+	ROOT_DEV = Root_HDA1;
+#endif
+
+#ifdef CONFIG_BLK_DEV_INITRD
+	ROOT_DEV = Root_RAM0;
+#endif
+
+	/* setup PCI host bridge */
+#ifdef CONFIG_PCI
+	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
+		tsi108_setup_pci(np);
+
+	ppc_md.pci_exclude_device = mpc7448_hpc2_exclude_device;
+	if (ppc_md.progress)
+		ppc_md.progress("tsi108: resources set", 0x100);
+#endif
+
+	printk(KERN_INFO "MPC7448HPC2 (TAIGA) Platform\n");
+	printk(KERN_INFO
+	       "Jointly ported by Freescale and Tundra Semiconductor\n");
+	printk(KERN_INFO
+	       "Enabling L2 cache then enabling the HID0 prefetch engine.\n");
+}
+
+/*
+ * Interrupt setup and service.  Interrrupts on the mpc7448_hpc2 come
+ * from the four external INT pins, PCI interrupts are routed via
+ * PCI interrupt control registers, it generates internal IRQ23
+ *
+ * Interrupt routing on the Taiga Board:
+ * TSI108:PB_INT[0] -> CPU0:INT#
+ * TSI108:PB_INT[1] -> CPU0:MCP#
+ * TSI108:PB_INT[2] -> N/C
+ * TSI108:PB_INT[3] -> N/C
+ */
+static void __init mpc7448_hpc2_init_IRQ(void)
+{
+	struct mpic *mpic;
+	phys_addr_t mpic_paddr = 0;
+	unsigned int cascade_pci_irq;
+	struct device_node *tsi_pci;
+	struct device_node *tsi_pic;
+
+	tsi_pic = of_find_node_by_type(NULL, "open-pic");
+	if (tsi_pic) {
+		unsigned int size;
+		const void *prop = get_property(tsi_pic, "reg", &size);
+		mpic_paddr = of_translate_address(tsi_pic, prop);
+	}
+
+	if (mpic_paddr == 0) {
+		printk("%s: No tsi108 PIC found !\n", __FUNCTION__);
+		return;
+	}
+
+	DBG("%s: tsi108pic phys_addr = 0x%x\n", __FUNCTION__,
+	    (u32) mpic_paddr);
+
+	mpic = mpic_alloc(tsi_pic, mpic_paddr,
+			MPIC_PRIMARY | MPIC_BIG_ENDIAN | MPIC_WANTS_RESET |
+			MPIC_SPV_EOI | MPIC_NO_PTHROU_DIS | MPIC_REGSET_TSI108,
+			0, /* num_sources used */
+			0, /* num_sources used */
+			"Tsi108_PIC");
+
+	BUG_ON(mpic == NULL); /* XXXX */
+	mpic_init(mpic);
+
+	tsi_pci = of_find_node_by_type(NULL, "pci");
+	if (tsi_pci == 0) {
+		printk("%s: No tsi108 pci node found !\n", __FUNCTION__);
+		return;
+	}
+
+	cascade_pci_irq = irq_of_parse_and_map(tsi_pci, 0);
+	set_irq_data(cascade_pci_irq, mpic);
+	set_irq_chained_handler(cascade_pci_irq, tsi108_irq_cascade);
+
+	tsi108_pci_int_init();
+
+	/* Configure MPIC outputs to CPU0 */
+	tsi108_write_reg(TSI108_MPIC_OFFSET + 0x30c, 0);
+	of_node_put(tsi_pic);
+}
+
+void mpc7448_hpc2_show_cpuinfo(struct seq_file *m)
+{
+	seq_printf(m, "vendor\t\t: Freescale Semiconductor\n");
+	seq_printf(m, "machine\t\t: MPC7448hpc2\n");
+}
+
+void mpc7448_hpc2_restart(char *cmd)
+{
+	local_irq_disable();
+
+	/* Set exception prefix high - to the firmware */
+	_nmask_and_or_msr(0, MSR_IP);
+
+	for (;;) ;		/* Spin until reset happens */
+}
+
+void mpc7448_hpc2_power_off(void)
+{
+	local_irq_disable();
+	for (;;) ;		/* No way to shut power off with software */
+}
+
+void mpc7448_hpc2_halt(void)
+{
+	mpc7448_hpc2_power_off();
+}
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init mpc7448_hpc2_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (!of_flat_dt_is_compatible(root, "mpc74xx"))
+		return 0;
+	return 1;
+}
+
+static int mpc7448_machine_check_exception(struct pt_regs *regs)
+{
+	extern void tsi108_clear_pci_cfg_error(void);
+	const struct exception_table_entry *entry;
+
+	/* Are we prepared to handle this fault */
+	if ((entry = search_exception_tables(regs->nip)) != NULL) {
+		tsi108_clear_pci_cfg_error();
+		regs->msr |= MSR_RI;
+		regs->nip = entry->fixup;
+		return 1;
+	}
+	return 0;
+
+}
+
+define_machine(mpc7448_hpc2){
+	.name 			= "MPC7448 HPC2",
+	.probe 			= mpc7448_hpc2_probe,
+	.setup_arch 		= mpc7448_hpc2_setup_arch,
+	.init_IRQ 		= mpc7448_hpc2_init_IRQ,
+	.show_cpuinfo 		= mpc7448_hpc2_show_cpuinfo,
+	.get_irq 		= mpic_get_irq,
+	.pcibios_fixup 		= mpc7448_hpc2_pcibios_fixup,
+	.restart 		= mpc7448_hpc2_restart,
+	.calibrate_decr 	= generic_calibrate_decr,
+	.machine_check_exception= mpc7448_machine_check_exception,
+	.progress 		= udbg_progress,
+};
Index: arch/powerpc/platforms/74xx/mpc7448_hpc2.h
===================================================================
--- /dev/null
+++ b/arch/powerpc/platforms/74xx/mpc7448_hpc2.h
@@ -0,0 +1,26 @@
+/*
+ * mpc7448_hpc2.h
+ *
+ * Definitions for Freescale MPC7448_HPC2 platform
+ *
+ * Author: Jacob Pan
+ *         jacob.pan@freescale.com
+ * Maintainer: Roy Zang <roy.zang@freescale.com>
+ *
+ * 2006 (c) Freescale Semiconductor, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#ifndef __PPC_PLATFORMS_MPC7448_HPC2_H
+#define __PPC_PLATFORMS_MPC7448_HPC2_H
+
+#include <asm/ppcboot.h>
+
+/* Base Addresses for the PCI bus
+ */
+#define MPC7448_HPC2_PCI_MEM_OFFSET	(0x00000000)
+#define MPC7448_HPC2_ISA_IO_BASE	(0x00000000)
+#define MPC7448_HPC2_ISA_MEM_BASE	(0x00000000)
+#endif				/* __PPC_PLATFORMS_MPC7448_HPC2_H */
Index: arch/powerpc/platforms/embedded6xx/Kconfig
===================================================================
--- a/arch/powerpc/platforms/embedded6xx/Kconfig
+++ b//dev/null
@@ -1,15 +0,0 @@
-choice
-	prompt "Machine Type"
-	depends on EMBEDDED6xx
-
-config MPC7448HPC2
-	bool "Freescale MPC7448HPC2(Taiga)"
-	select TSI108_BRIDGE
-	select DEFAULT_UIMAGE
-	select PPC_UDBG_16550
-	select MPIC
-	select MPIC_WEIRD
-	help
-	  Select MPC7448HPC2 if configuring for Freescale MPC7448HPC2 (Taiga)
-	  platform
-endchoice
Index: arch/powerpc/platforms/embedded6xx/Makefile
===================================================================
--- a/arch/powerpc/platforms/embedded6xx/Makefile
+++ b//dev/null
@@ -1,4 +0,0 @@
-#
-# Makefile for the 6xx/7xx/7xxxx linux kernel.
-#
-obj-$(CONFIG_MPC7448HPC2)	+= mpc7448_hpc2.o
Index: arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
===================================================================
--- a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
+++ b//dev/null
@@ -1,308 +0,0 @@
-/*
- * mpc7448_hpc2.c
- *
- * Board setup routines for the Freescale mpc7448hpc2(taiga) platform
- *
- * Author: Jacob Pan
- *	 jacob.pan@freescale.com
- * Author: Xianghua Xiao
- *       x.xiao@freescale.com
- * Maintainer: Roy Zang <tie-fei.zang@freescale.com>
- * 	Add Flat Device Tree support fot mpc7448hpc2 board
- *
- * Copyright 2004-2006 Freescale Semiconductor, Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#include <linux/stddef.h>
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/kdev_t.h>
-#include <linux/console.h>
-#include <linux/delay.h>
-#include <linux/irq.h>
-#include <linux/ide.h>
-#include <linux/seq_file.h>
-#include <linux/root_dev.h>
-#include <linux/serial.h>
-#include <linux/tty.h>
-#include <linux/serial_core.h>
-
-#include <asm/system.h>
-#include <asm/time.h>
-#include <asm/machdep.h>
-#include <asm/prom.h>
-#include <asm/udbg.h>
-#include <asm/tsi108.h>
-#include <asm/pci-bridge.h>
-#include <asm/reg.h>
-#include <mm/mmu_decl.h>
-#include "mpc7448_hpc2.h"
-#include <asm/tsi108_irq.h>
-#include <asm/mpic.h>
-
-#undef DEBUG
-#ifdef DEBUG
-#define DBG(fmt...) do { printk(fmt); } while(0)
-#else
-#define DBG(fmt...) do { } while(0)
-#endif
-
-#ifndef CONFIG_PCI
-isa_io_base = MPC7448_HPC2_ISA_IO_BASE;
-isa_mem_base = MPC7448_HPC2_ISA_MEM_BASE;
-pci_dram_offset = MPC7448_HPC2_PCI_MEM_OFFSET;
-#endif
-
-extern int tsi108_setup_pci(struct device_node *dev);
-extern void _nmask_and_or_msr(unsigned long nmask, unsigned long or_val);
-extern void tsi108_pci_int_init(void);
-extern void tsi108_irq_cascade(unsigned int irq, struct irq_desc *desc);
-
-int mpc7448_hpc2_exclude_device(u_char bus, u_char devfn)
-{
-	if (bus == 0 && PCI_SLOT(devfn) == 0)
-		return PCIBIOS_DEVICE_NOT_FOUND;
-	else
-		return PCIBIOS_SUCCESSFUL;
-}
-
-/*
- * find pci slot by devfn in interrupt map of OF tree
- */
-u8 find_slot_by_devfn(unsigned int *interrupt_map, unsigned int devfn)
-{
-	int i;
-	unsigned int tmp;
-	for (i = 0; i < 4; i++){
-		tmp = interrupt_map[i*4*7];
-		if ((tmp >> 11) == (devfn >> 3))
-			return i;
-	}
-	return i;
-}
-
-/*
- * Scans the interrupt map for pci device
- */
-void mpc7448_hpc2_fixup_irq(struct pci_dev *dev)
-{
-	struct pci_controller *hose;
-	struct device_node *node;
-	const unsigned int *interrupt;
-	int busnr;
-	int len;
-	u8 slot;
-	u8 pin;
-
-	/* Lookup the hose */
-	busnr = dev->bus->number;
-	hose = pci_bus_to_hose(busnr);
-	if (!hose)
-		printk(KERN_ERR "No pci hose found\n");
-
-	/* Check it has an OF node associated */
-	node = (struct device_node *) hose->arch_data;
-	if (!node)
-		printk(KERN_ERR "No pci node found\n");
-
-	interrupt = get_property(node, "interrupt-map", &len);
-	slot = find_slot_by_devfn(interrupt, dev->devfn);
-	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
-	if (pin == 0 || pin > 4)
-		pin = 1;
-	pin--;
-	dev->irq  = interrupt[slot*4*7 + pin*7 + 5];
-	DBG("TSI_PCI: dev->irq = 0x%x\n", dev->irq);
-}
-/* temporary pci irq map fixup*/
-
-void __init mpc7448_hpc2_pcibios_fixup(void)
-{
-	struct pci_dev *dev = NULL;
-	for_each_pci_dev(dev) {
-		mpc7448_hpc2_fixup_irq(dev);
-		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
-	}
-}
-
-static void __init mpc7448_hpc2_setup_arch(void)
-{
-	struct device_node *cpu;
-	struct device_node *np;
-	if (ppc_md.progress)
-		ppc_md.progress("mpc7448_hpc2_setup_arch():set_bridge", 0);
-
-	cpu = of_find_node_by_type(NULL, "cpu");
-	if (cpu != 0) {
-		const unsigned int *fp;
-
-		fp = get_property(cpu, "clock-frequency", NULL);
-		if (fp != 0)
-			loops_per_jiffy = *fp / HZ;
-		else
-			loops_per_jiffy = 50000000 / HZ;
-		of_node_put(cpu);
-	}
-	tsi108_csr_vir_base = get_vir_csrbase();
-
-#ifdef	CONFIG_ROOT_NFS
-	ROOT_DEV = Root_NFS;
-#else
-	ROOT_DEV = Root_HDA1;
-#endif
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	ROOT_DEV = Root_RAM0;
-#endif
-
-	/* setup PCI host bridge */
-#ifdef CONFIG_PCI
-	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
-		tsi108_setup_pci(np);
-
-	ppc_md.pci_exclude_device = mpc7448_hpc2_exclude_device;
-	if (ppc_md.progress)
-		ppc_md.progress("tsi108: resources set", 0x100);
-#endif
-
-	printk(KERN_INFO "MPC7448HPC2 (TAIGA) Platform\n");
-	printk(KERN_INFO
-	       "Jointly ported by Freescale and Tundra Semiconductor\n");
-	printk(KERN_INFO
-	       "Enabling L2 cache then enabling the HID0 prefetch engine.\n");
-}
-
-/*
- * Interrupt setup and service.  Interrrupts on the mpc7448_hpc2 come
- * from the four external INT pins, PCI interrupts are routed via
- * PCI interrupt control registers, it generates internal IRQ23
- *
- * Interrupt routing on the Taiga Board:
- * TSI108:PB_INT[0] -> CPU0:INT#
- * TSI108:PB_INT[1] -> CPU0:MCP#
- * TSI108:PB_INT[2] -> N/C
- * TSI108:PB_INT[3] -> N/C
- */
-static void __init mpc7448_hpc2_init_IRQ(void)
-{
-	struct mpic *mpic;
-	phys_addr_t mpic_paddr = 0;
-	unsigned int cascade_pci_irq;
-	struct device_node *tsi_pci;
-	struct device_node *tsi_pic;
-
-	tsi_pic = of_find_node_by_type(NULL, "open-pic");
-	if (tsi_pic) {
-		unsigned int size;
-		const void *prop = get_property(tsi_pic, "reg", &size);
-		mpic_paddr = of_translate_address(tsi_pic, prop);
-	}
-
-	if (mpic_paddr == 0) {
-		printk("%s: No tsi108 PIC found !\n", __FUNCTION__);
-		return;
-	}
-
-	DBG("%s: tsi108pic phys_addr = 0x%x\n", __FUNCTION__,
-	    (u32) mpic_paddr);
-
-	mpic = mpic_alloc(tsi_pic, mpic_paddr,
-			MPIC_PRIMARY | MPIC_BIG_ENDIAN | MPIC_WANTS_RESET |
-			MPIC_SPV_EOI | MPIC_NO_PTHROU_DIS | MPIC_REGSET_TSI108,
-			0, /* num_sources used */
-			0, /* num_sources used */
-			"Tsi108_PIC");
-
-	BUG_ON(mpic == NULL); /* XXXX */
-	mpic_init(mpic);
-
-	tsi_pci = of_find_node_by_type(NULL, "pci");
-	if (tsi_pci == 0) {
-		printk("%s: No tsi108 pci node found !\n", __FUNCTION__);
-		return;
-	}
-
-	cascade_pci_irq = irq_of_parse_and_map(tsi_pci, 0);
-	set_irq_data(cascade_pci_irq, mpic);
-	set_irq_chained_handler(cascade_pci_irq, tsi108_irq_cascade);
-
-	tsi108_pci_int_init();
-
-	/* Configure MPIC outputs to CPU0 */
-	tsi108_write_reg(TSI108_MPIC_OFFSET + 0x30c, 0);
-	of_node_put(tsi_pic);
-}
-
-void mpc7448_hpc2_show_cpuinfo(struct seq_file *m)
-{
-	seq_printf(m, "vendor\t\t: Freescale Semiconductor\n");
-	seq_printf(m, "machine\t\t: MPC7448hpc2\n");
-}
-
-void mpc7448_hpc2_restart(char *cmd)
-{
-	local_irq_disable();
-
-	/* Set exception prefix high - to the firmware */
-	_nmask_and_or_msr(0, MSR_IP);
-
-	for (;;) ;		/* Spin until reset happens */
-}
-
-void mpc7448_hpc2_power_off(void)
-{
-	local_irq_disable();
-	for (;;) ;		/* No way to shut power off with software */
-}
-
-void mpc7448_hpc2_halt(void)
-{
-	mpc7448_hpc2_power_off();
-}
-
-/*
- * Called very early, device-tree isn't unflattened
- */
-static int __init mpc7448_hpc2_probe(void)
-{
-	unsigned long root = of_get_flat_dt_root();
-
-	if (!of_flat_dt_is_compatible(root, "mpc74xx"))
-		return 0;
-	return 1;
-}
-
-static int mpc7448_machine_check_exception(struct pt_regs *regs)
-{
-	extern void tsi108_clear_pci_cfg_error(void);
-	const struct exception_table_entry *entry;
-
-	/* Are we prepared to handle this fault */
-	if ((entry = search_exception_tables(regs->nip)) != NULL) {
-		tsi108_clear_pci_cfg_error();
-		regs->msr |= MSR_RI;
-		regs->nip = entry->fixup;
-		return 1;
-	}
-	return 0;
-
-}
-
-define_machine(mpc7448_hpc2){
-	.name 			= "MPC7448 HPC2",
-	.probe 			= mpc7448_hpc2_probe,
-	.setup_arch 		= mpc7448_hpc2_setup_arch,
-	.init_IRQ 		= mpc7448_hpc2_init_IRQ,
-	.show_cpuinfo 		= mpc7448_hpc2_show_cpuinfo,
-	.get_irq 		= mpic_get_irq,
-	.pcibios_fixup 		= mpc7448_hpc2_pcibios_fixup,
-	.restart 		= mpc7448_hpc2_restart,
-	.calibrate_decr 	= generic_calibrate_decr,
-	.machine_check_exception= mpc7448_machine_check_exception,
-	.progress 		= udbg_progress,
-};
Index: arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.h
===================================================================
--- a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.h
+++ b//dev/null
@@ -1,26 +0,0 @@
-/*
- * mpc7448_hpc2.h
- *
- * Definitions for Freescale MPC7448_HPC2 platform
- *
- * Author: Jacob Pan
- *         jacob.pan@freescale.com
- * Maintainer: Roy Zang <roy.zang@freescale.com>
- *
- * 2006 (c) Freescale Semiconductor, Inc.  This file is licensed under
- * the terms of the GNU General Public License version 2.  This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-
-#ifndef __PPC_PLATFORMS_MPC7448_HPC2_H
-#define __PPC_PLATFORMS_MPC7448_HPC2_H
-
-#include <asm/ppcboot.h>
-
-/* Base Addresses for the PCI bus
- */
-#define MPC7448_HPC2_PCI_MEM_OFFSET	(0x00000000)
-#define MPC7448_HPC2_ISA_IO_BASE	(0x00000000)
-#define MPC7448_HPC2_ISA_MEM_BASE	(0x00000000)
-#endif				/* __PPC_PLATFORMS_MPC7448_HPC2_H */
Index: arch/powerpc/platforms/Makefile
===================================================================
--- a/arch/powerpc/platforms/Makefile.orig
+++ b/arch/powerpc/platforms/Makefile
@@ -15,4 +15,4 @@ obj-$(CONFIG_PPC_ISERIES)	+= iseries/
 obj-$(CONFIG_PPC_MAPLE)		+= maple/
 obj-$(CONFIG_PPC_PASEMI)		+= pasemi/
 obj-$(CONFIG_PPC_CELL)		+= cell/
-obj-$(CONFIG_EMBEDDED6xx)	+= embedded6xx/
+obj-$(CONFIG_74xx)		+= 74xx/
Index: arch/powerpc/Kconfig
===================================================================
--- a/arch/powerpc/Kconfig.orig
+++ b/arch/powerpc/Kconfig
@@ -602,7 +602,6 @@ config PPC_TODC
 
 endmenu
 
-source arch/powerpc/platforms/embedded6xx/Kconfig
 source arch/powerpc/platforms/4xx/Kconfig
 source arch/powerpc/platforms/82xx/Kconfig
 source arch/powerpc/platforms/83xx/Kconfig

--
 Dipl.-Ing. Sascha Hauer | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry
    Handelsregister: Amtsgericht Hildesheim, HRA 2686
      Hannoversche Str. 2, 31134 Hildesheim, Germany
    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
