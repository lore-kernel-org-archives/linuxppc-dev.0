Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 0F43E67BA7
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jun 2006 17:07:21 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k5D7OFiA013272
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jun 2006 00:24:15 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k5D77GpC017547
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jun 2006 02:07:17 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD4673069C3F3D@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>
Subject: [PATCH/2.6.17-rc6 1/4 v2] Powerpc: Add general support for mpc74
	48hpc2 (Taiga) platform
Date: Tue, 13 Jun 2006 15:07:15 +0800
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Alexandre.Bounine@tundra.com,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add support for Freescale mpc7448 (Taiga) board support

Signed-off-by: Roy Zang  <tie-fei.zang@freescale.com>

---

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 6729c98..d8a9add 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -323,7 +323,7 @@ config PPC_ISERIES
 
 config EMBEDDED6xx
 	bool "Embedded 6xx/7xx/7xxx-based board"
-	depends on PPC32 && BROKEN
+	depends on PPC32 && (BROKEN||BROKEN_ON_SMP)
 
 config APUS
 	bool "Amiga-APUS"
@@ -408,7 +408,8 @@ config U3_DART
 	default n
 
 config MPIC
-	depends on PPC_PSERIES || PPC_PMAC || PPC_MAPLE || PPC_CHRP
+	depends on PPC_PSERIES || PPC_PMAC || PPC_MAPLE || PPC_CHRP \
+			       || MPC7448HPC2
 	bool
 	default y
 
@@ -798,7 +799,8 @@ config MCA
 	bool
 
 config PCI
-	bool "PCI support" if 40x || CPM2 || PPC_83xx || PPC_85xx || PPC_MPC52xx || (EMBEDDED && PPC_ISERIES)
+	bool "PCI support" if 40x || CPM2 || PPC_83xx || PPC_85xx || PPC_MPC52xx || (EMBEDDED && PPC_ISERIES) \
+				  || MPC7448HPC2
 	default y if !40x && !CPM2 && !8xx && !APUS && !PPC_83xx && !PPC_85xx
 	default PCI_PERMEDIA if !4xx && !CPM2 && !8xx && APUS
 	default PCI_QSPAN if !4xx && !CPM2 && 8xx
diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index 6e67b5b..c0e19ef 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -302,6 +302,17 @@ void __init find_legacy_serial_ports(voi
 		of_node_put(isa);
 	}
 
+	/* First fill our array with tsi-bridge ports */
+	for (np = NULL; (np = of_find_compatible_node(np, "serial", "ns16550")) != NULL;) {
+		struct device_node *tsi = of_get_parent(np);
+		if (tsi && !strcmp(tsi->type, "tsi-bridge")) {
+			index = add_legacy_soc_port(np, np);
+			if (index >= 0 && np == stdout)
+				legacy_serial_console = index;
+		}
+		of_node_put(tsi);
+	}
+	
 #ifdef CONFIG_PCI
 	/* Next, try to locate PCI ports */
 	for (np = NULL; (np = of_find_all_nodes(np));) {
diff --git a/arch/powerpc/platforms/Makefile b/arch/powerpc/platforms/Makefile
index c4f6b0d..308fead 100644
--- a/arch/powerpc/platforms/Makefile
+++ b/arch/powerpc/platforms/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_PPC_PSERIES)	+= pseries/
 obj-$(CONFIG_PPC_ISERIES)	+= iseries/
 obj-$(CONFIG_PPC_MAPLE)		+= maple/
 obj-$(CONFIG_PPC_CELL)		+= cell/
+obj-$(CONFIG_EMBEDDED6xx)	+= embedded6xx/
diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/platforms/embedded6xx/Kconfig
index 4fdbc9a..2b78196 100644
--- a/arch/powerpc/platforms/embedded6xx/Kconfig
+++ b/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -74,6 +74,16 @@ config SANDPOINT
 	  Select SANDPOINT if configuring for a Motorola Sandpoint X3
 	  (any flavor).
 
+config MPC7448HPC2
+	bool "Freescale MPC7448HPC2(Taiga)"
+	select TSI108_BRIDGE
+	select DEFAULT_UIMAGE
+	select PPC_UDBG_16550
+	select MPIC
+	help
+	  Select MPC7448HPC2 if configuring for Freescale MPC7448HPC2 (Taiga)
+	  platform
+
 config RADSTONE_PPC7D
 	bool "Radstone Technology PPC7D board"
 	select PPC_I8259
@@ -221,6 +231,11 @@ config MV64X60
 	select PPC_INDIRECT_PCI
 	default y
 
+config TSI108_BRIDGE
+	bool
+	depends on MPC7448HPC2
+	default y
+	
 menu "Set bridge options"
 	depends on MV64X60
 
diff --git a/arch/powerpc/platforms/embedded6xx/Makefile b/arch/powerpc/platforms/embedded6xx/Makefile
new file mode 100644
index 0000000..fa499fe
--- /dev/null
+++ b/arch/powerpc/platforms/embedded6xx/Makefile
@@ -0,0 +1,4 @@
+#
+# Makefile for the 6xx/7xx/7xxxx linux kernel.
+#
+obj-$(CONFIG_MPC7448HPC2)	+= mpc7448_hpc2.o
diff --git a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
new file mode 100644
index 0000000..1273bd6
--- /dev/null
+++ b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
@@ -0,0 +1,335 @@
+/*
+ * mpc7448_hpc2.c
+ *
+ * Board setup routines for the Freescale Taiga platform
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
+ * This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/config.h>
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
+extern int tsi108_irq_cascade(struct pt_regs *regs, void *unused);
+
+/*
+ * Define all of the IRQ senses and polarities.  Taken from the
+ * mpc7448hpc  manual.
+ * Note:  Likely, this table and the following function should be
+ *        obtained and derived from the OF Device Tree.
+ */
+
+static u_char mpc7448_hpc2_pic_initsenses[] __initdata = {
+	/* External on-board sources */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* INT[0] XINT0 from FPGA */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* INT[1] XINT1 from FPGA */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* INT[2] PHY_INT from both GIGE */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* INT[3] RESERVED */
+	/* Internal Tsi108/109 interrupt sources */
+	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* Reserved IRQ */
+	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* Reserved IRQ */
+	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* Reserved IRQ */
+	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* Reserved IRQ */
+	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* DMA0 */
+	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* DMA1 */
+	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* DMA2 */
+	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* DMA3 */
+	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* UART0 */
+	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* UART1 */
+	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* I2C */
+	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* GPIO */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* GIGE0 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* GIGE1 */
+	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* Reserved IRQ */
+	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* HLP */
+	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* SDC */
+	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* Processor IF */
+	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* Reserved IRQ */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* PCI/X block */
+};
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
+	unsigned int *interrupt;
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
+	interrupt = (unsigned int *) get_property(node, "interrupt-map", &len);
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
+		unsigned int *fp;
+
+		fp = (int *)get_property(cpu, "clock-frequency", NULL);
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
+	struct device_node *tsi_pic;
+
+	tsi_pic = of_find_node_by_type(NULL, "open-pic");
+	if (tsi_pic) {
+		unsigned int size;
+		void *prop = get_property(tsi_pic, "reg", &size);
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
+	mpic = mpic_alloc(mpic_paddr,
+			MPIC_PRIMARY | MPIC_BIG_ENDIAN | MPIC_WANTS_RESET |
+			MPIC_SPV_EOI | MPIC_MOD_ID(MPIC_ID_TSI108),
+			0, /* num_sources used */
+			TSI108_IRQ_BASE,
+			0, /* num_sources used */
+			NR_IRQS - 4 /* XXXX */,
+			mpc7448_hpc2_pic_initsenses,
+			sizeof(mpc7448_hpc2_pic_initsenses), "Tsi108_PIC");
+
+	BUG_ON(mpic == NULL); /* XXXX */
+
+	mpic_init(mpic);
+	mpic_setup_cascade(IRQ_TSI108_PCI, tsi108_irq_cascade, mpic);
+	tsi108_pci_int_init();
+
+	/* Configure MPIC outputs to CPU0 */
+	tsi108_write_reg(TSI108_MPIC_OFFSET + 0x30c, 0);
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
diff --git a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.h b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.h
new file mode 100644
index 0000000..8296990
--- /dev/null
+++ b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.h
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
