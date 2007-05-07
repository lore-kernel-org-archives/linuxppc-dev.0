Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 55C67DDE37
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 00:58:59 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l47EwuqA019241
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 10:58:56 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l47Ewuc5200536
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 08:58:56 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l47Ewu0W025742
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 08:58:56 -0600
Subject: [PATCH v3 4/7] Add support for 750CL Holly board
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
In-Reply-To: <1178549324.2990.52.camel@zod.rchland.ibm.com>
References: <1178549324.2990.52.camel@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Mon, 07 May 2007 09:53:24 -0500
Message-Id: <1178549604.2990.62.camel@zod.rchland.ibm.com>
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

Add PowerPC 750 Holly/Hickory platform support

Signed-off-by: Stephen Winiecki <stevewin@us.ibm.com>
Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 arch/powerpc/Kconfig                        |    2 
 arch/powerpc/platforms/embedded6xx/Kconfig  |   14 -
 arch/powerpc/platforms/embedded6xx/Makefile |    1 
 arch/powerpc/platforms/embedded6xx/holly.c  |  316 ++++++++++++++++++++++++++++
 4 files changed, 329 insertions(+), 4 deletions(-)

--- linux-2.6.orig/arch/powerpc/Kconfig
+++ linux-2.6/arch/powerpc/Kconfig
@@ -659,7 +659,7 @@ config MCA
 config PCI
 	bool "PCI support" if 40x || CPM2 || PPC_83xx || PPC_85xx || PPC_86xx \
 		|| PPC_MPC52xx || (EMBEDDED && (PPC_PSERIES || PPC_ISERIES)) \
-		|| MPC7448HPC2 || PPC_PS3
+		|| MPC7448HPC2 || PPC_PS3 || PPC_HOLLY
 	default y if !40x && !CPM2 && !8xx && !APUS && !PPC_83xx \
 		&& !PPC_85xx && !PPC_86xx
 	default PCI_PERMEDIA if !4xx && !CPM2 && !8xx && APUS
--- linux-2.6.orig/arch/powerpc/platforms/embedded6xx/Kconfig
+++ linux-2.6/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -20,16 +20,24 @@ config MPC7448HPC2
 	select TSI108_BRIDGE
 	select DEFAULT_UIMAGE
 	select PPC_UDBG_16550
-	select MPIC
-	select MPIC_WEIRD
 	help
 	  Select MPC7448HPC2 if configuring for Freescale MPC7448HPC2 (Taiga)
 	  platform
+
+config PPC_HOLLY
+	bool "PPC750GX/CL with TSI10x bridge (Hickory/Holly)"
+	select TSI108_BRIDGE
+	select PPC_UDBG_16550
+	help
+	  Select PPC_HOLLY if configuring for an IBM 750GX/CL Eval
+	  Board with TSI108/9 bridge (Hickory/Holly)
 endchoice
 
 config TSI108_BRIDGE
 	bool
-	depends on MPC7448HPC2
+	depends on MPC7448HPC2 || PPC_HOLLY
+	select MPIC
+	select MPIC_WEIRD
 	default y
 
 config MPC10X_BRIDGE
--- linux-2.6.orig/arch/powerpc/platforms/embedded6xx/Makefile
+++ linux-2.6/arch/powerpc/platforms/embedded6xx/Makefile
@@ -3,3 +3,4 @@
 #
 obj-$(CONFIG_MPC7448HPC2)	+= mpc7448_hpc2.o
 obj-$(CONFIG_LINKSTATION)	+= linkstation.o ls_uart.o
+obj-$(CONFIG_PPC_HOLLY)		+= holly.o
--- /dev/null
+++ linux-2.6/arch/powerpc/platforms/embedded6xx/holly.c
@@ -0,0 +1,316 @@
+/*
+ * Board setup routines for the IBM 750GX/CL platform w/ TSI10x bridge
+ *
+ * Copyright 2007 IBM Corporation
+ *
+ * Stephen Winiecki <stevewin@us.ibm.com>
+ * Josh Boyer <jwboyer@linux.vnet.ibm.com>
+ *
+ * Based on code from mpc7448_hpc2.c
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
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
+#include <asm/tsi108_irq.h>
+#include <asm/tsi108_pci.h>
+#include <asm/mpic.h>
+#include <asm/of_platform.h>
+
+#undef DEBUG
+
+#define HOLLY_PCI_CFG_PHYS 0x7e000000
+
+int holly_exclude_device(u_char bus, u_char devfn)
+{
+	if (bus == 0 && PCI_SLOT(devfn) == 0)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	else
+		return PCIBIOS_SUCCESSFUL;
+}
+
+static void holly_remap_bridge(void)
+{
+	u32 lut_val, lut_addr;
+	int i;
+
+	printk(KERN_INFO "Remapping PCI bridge\n");
+
+	/* Re-init the PCI bridge and LUT registers to have mappings that don't
+	 * rely on PIBS
+	 */
+	lut_addr = 0x900;
+	for (i = 0; i < 31; i++) {
+		tsi108_write_reg(TSI108_PB_OFFSET + lut_addr, 0x00000201);
+		lut_addr += 4;
+		tsi108_write_reg(TSI108_PB_OFFSET + lut_addr, 0x0);
+		lut_addr += 4;
+	}
+
+	/* Reserve the last LUT entry for PCI I/O space */
+	tsi108_write_reg(TSI108_PB_OFFSET + lut_addr, 0x00000241);
+	lut_addr += 4;
+	tsi108_write_reg(TSI108_PB_OFFSET + lut_addr, 0x0);
+
+	/* Map PCI I/O space */
+	tsi108_write_reg(TSI108_PCI_PFAB_IO_UPPER, 0x0);
+	tsi108_write_reg(TSI108_PCI_PFAB_IO, 0x1);
+
+	/* Map PCI CFG space */
+	tsi108_write_reg(TSI108_PCI_PFAB_BAR0_UPPER, 0x0);
+	tsi108_write_reg(TSI108_PCI_PFAB_BAR0, 0x7c000000 | 0x01);
+
+	/* We don't need MEM32 and PRM remapping so disable them */
+	tsi108_write_reg(TSI108_PCI_PFAB_MEM32, 0x0);
+	tsi108_write_reg(TSI108_PCI_PFAB_PFM3, 0x0);
+	tsi108_write_reg(TSI108_PCI_PFAB_PFM4, 0x0);
+
+	/* Set P2O_BAR0 */
+	tsi108_write_reg(TSI108_PCI_P2O_BAR0_UPPER, 0x0);
+	tsi108_write_reg(TSI108_PCI_P2O_BAR0, 0xc0000000);
+
+	/* Init the PCI LUTs to do no remapping */
+	lut_addr = 0x500;
+	lut_val = 0x00000002;
+
+	for (i = 0; i < 32; i++) {
+		tsi108_write_reg(TSI108_PCI_OFFSET + lut_addr, lut_val);
+		lut_addr += 4;
+		tsi108_write_reg(TSI108_PCI_OFFSET + lut_addr, 0x40000000);
+		lut_addr += 4;
+		lut_val += 0x02000000;
+	}
+	tsi108_write_reg(TSI108_PCI_P2O_PAGE_SIZES, 0x00007900);
+
+	/* Set 64-bit PCI bus address for system memory */
+	tsi108_write_reg(TSI108_PCI_P2O_BAR2_UPPER, 0x0);
+	tsi108_write_reg(TSI108_PCI_P2O_BAR2, 0x0);
+}
+
+static void __init holly_setup_arch(void)
+{
+	struct device_node *cpu;
+	struct device_node *np;
+
+	if (ppc_md.progress)
+		ppc_md.progress("holly_setup_arch():set_bridge", 0);
+
+	cpu = of_find_node_by_type(NULL, "cpu");
+	if (cpu != 0) {
+		const unsigned int *fp;
+
+		fp = of_get_property(cpu, "clock-frequency", NULL);
+		if (fp != 0)
+			loops_per_jiffy = *fp / HZ;
+		else
+			loops_per_jiffy = 50000000 / HZ;
+		of_node_put(cpu);
+	}
+	tsi108_csr_vir_base = get_vir_csrbase();
+
+	/* setup PCI host bridge */
+	holly_remap_bridge();
+
+	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
+		tsi108_setup_pci(np, HOLLY_PCI_CFG_PHYS);
+
+	ppc_md.pci_exclude_device = holly_exclude_device;
+	if (ppc_md.progress)
+		ppc_md.progress("tsi108: resources set", 0x100);
+
+	printk(KERN_INFO "PPC750GX/CL Platform\n");
+}
+
+/*
+ * Interrupt setup and service.  Interrrupts on the holly come
+ * from the four external INT pins, PCI interrupts are routed via
+ * PCI interrupt control registers, it generates internal IRQ23
+ *
+ * Interrupt routing on the Holly Board:
+ * TSI108:PB_INT[0] -> CPU0:INT#
+ * TSI108:PB_INT[1] -> CPU0:MCP#
+ * TSI108:PB_INT[2] -> N/C
+ * TSI108:PB_INT[3] -> N/C
+ */
+static void __init holly_init_IRQ(void)
+{
+	struct mpic *mpic;
+	phys_addr_t mpic_paddr = 0;
+	struct device_node *tsi_pic;
+#ifdef CONFIG_PCI
+	unsigned int cascade_pci_irq;
+	struct device_node *tsi_pci;
+	struct device_node *cascade_node = NULL;
+#endif
+
+	tsi_pic = of_find_node_by_type(NULL, "open-pic");
+	if (tsi_pic) {
+		unsigned int size;
+		const void *prop = of_get_property(tsi_pic, "reg", &size);
+		mpic_paddr = of_translate_address(tsi_pic, prop);
+	}
+
+	if (mpic_paddr == 0) {
+		printk(KERN_ERR "%s: No tsi108 PIC found !\n", __func__);
+		return;
+	}
+
+	pr_debug("%s: tsi108 pic phys_addr = 0x%x\n", __func__, (u32) mpic_paddr);
+
+	mpic = mpic_alloc(tsi_pic, mpic_paddr,
+			MPIC_PRIMARY | MPIC_BIG_ENDIAN | MPIC_WANTS_RESET |
+			MPIC_SPV_EOI | MPIC_NO_PTHROU_DIS | MPIC_REGSET_TSI108,
+			24,
+			NR_IRQS-4, /* num_sources used */
+			"Tsi108_PIC");
+
+	BUG_ON(mpic == NULL);
+
+	mpic_assign_isu(mpic, 0, mpic_paddr + 0x100);
+
+	mpic_init(mpic);
+
+#ifdef CONFIG_PCI
+	tsi_pci = of_find_node_by_type(NULL, "pci");
+	if (tsi_pci == NULL) {
+		printk(KERN_ERR "%s: No tsi108 pci node found !\n", __func__);
+		return;
+	}
+
+	cascade_node = of_find_node_by_type(NULL, "pic-router");
+	if (cascade_node == NULL) {
+		printk(KERN_ERR "%s: No tsi108 pci cascade node found !\n", __func__);
+		return;
+	}
+
+	cascade_pci_irq = irq_of_parse_and_map(tsi_pci, 0);
+	pr_debug("%s: tsi108 cascade_pci_irq = 0x%x\n", __func__, (u32) cascade_pci_irq);
+	tsi108_pci_int_init(cascade_node);
+	set_irq_data(cascade_pci_irq, mpic);
+	set_irq_chained_handler(cascade_pci_irq, tsi108_irq_cascade);
+#endif
+	/* Configure MPIC outputs to CPU0 */
+	tsi108_write_reg(TSI108_MPIC_OFFSET + 0x30c, 0);
+	of_node_put(tsi_pic);
+}
+
+void holly_show_cpuinfo(struct seq_file *m)
+{
+	seq_printf(m, "vendor\t\t: IBM\n");
+	seq_printf(m, "machine\t\t: PPC750 GX/CL\n");
+}
+
+void holly_restart(char *cmd)
+{
+	__be32 __iomem *ocn_bar1 = NULL;
+	unsigned long bar;
+	struct device_node *bridge = NULL;
+	const void *prop;
+	int size;
+	phys_addr_t addr = 0xc0000000;
+
+	local_irq_disable();
+
+	bridge = of_find_node_by_type(NULL, "tsi-bridge");
+	if (bridge) {
+		prop = of_get_property(bridge, "reg", &size);
+		addr = of_translate_address(bridge, prop);
+	}
+	addr += (TSI108_PB_OFFSET + 0x414);
+
+	ocn_bar1 = ioremap(addr, 0x4);
+
+	/* Turn on the BOOT bit so the addresses are correctly
+	 * routed to the HLP interface */
+	bar = ioread32be(ocn_bar1);
+	bar |= 2;
+	iowrite32be(bar, ocn_bar1);
+	iosync();
+
+	/* Set SRR0 to the reset vector and turn on MSR_IP */
+	mtspr(SPRN_SRR0, 0xfff00100);
+	mtspr(SPRN_SRR1, MSR_IP);
+
+	/* Do an rfi to jump back to firmware.  Somewhat evil,
+	 * but it works
+	 */
+	__asm__ __volatile__("rfi" : : : "memory");
+
+	/* Spin until reset happens.  Shouldn't really get here */
+	for (;;) ;
+}
+
+void holly_power_off(void)
+{
+	local_irq_disable();
+	/* No way to shut power off with software */
+	for (;;) ;
+}
+
+void holly_halt(void)
+{
+	holly_power_off();
+}
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init holly_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (!of_flat_dt_is_compatible(root, "ibm,holly"))
+		return 0;
+	return 1;
+}
+
+static int ppc750_machine_check_exception(struct pt_regs *regs)
+{
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
+}
+
+define_machine(holly){
+	.name                   	= "PPC750 GX/CL TSI",
+	.probe                  	= holly_probe,
+	.setup_arch             	= holly_setup_arch,
+	.init_IRQ               	= holly_init_IRQ,
+	.show_cpuinfo           	= holly_show_cpuinfo,
+	.get_irq                	= mpic_get_irq,
+	.restart                	= holly_restart,
+	.calibrate_decr         	= generic_calibrate_decr,
+	.machine_check_exception	= ppc750_machine_check_exception,
+	.progress               	= udbg_progress,
+};
