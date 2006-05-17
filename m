Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id DCD6467B4F
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 20:13:55 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k4HAXibr001308
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 03:33:44 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k4HAPXUH019882
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 05:25:34 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD46730626D619@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH/2.6.17-rc4 1/10] Powerpc: Add general support for mpc7448h
	pc2 (Taiga) platform
Date: Wed, 17 May 2006 18:13:44 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
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

Add support for Freescale mpcc7448 (Taiga) board support

Signed-off-by: Roy Zang  <tie-fei.zang@freescale.com>

---

 arch/powerpc/Kconfig                       |   24 +++
 arch/powerpc/kernel/legacy_serial.c        |   39 ++++
 arch/powerpc/platforms/74xx/Makefile       |    4 
 arch/powerpc/platforms/74xx/misc.c         |   38 ++++
 arch/powerpc/platforms/74xx/mpc7448_hpc2.c |  257 ++++++++++++++++++++++++++++
 arch/powerpc/platforms/74xx/mpc7448_hpc2.h |   80 +++++++++
 arch/powerpc/platforms/74xx/pci.c          |  103 +++++++++++
 arch/powerpc/platforms/Makefile            |    1 
 8 files changed, 545 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/platforms/74xx/Makefile
 create mode 100644 arch/powerpc/platforms/74xx/misc.c
 create mode 100644 arch/powerpc/platforms/74xx/mpc7448_hpc2.c
 create mode 100644 arch/powerpc/platforms/74xx/mpc7448_hpc2.h
 create mode 100644 arch/powerpc/platforms/74xx/pci.c

13c16416da4fa51ec771bd4863d94344d139b2f5
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 6729c98..abeac1f 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -332,6 +332,27 @@ config APUS
 	  Select APUS if configuring for a PowerUP Amiga.
 	  More information is available at:
 	  <http://linux-apus.sourceforge.net/>.
+
+config MPC7448HPC2
+	bool "Freescale MPC7448HPC2(Taiga)"
+	select DEFAULT_UIMAGE
+	select PPC_UDBG_16550
+	help
+	  Select MPC7448HPC2 if configuring for Freescale MPC7448HPC2 (Taiga)
+	  platform
+
+config 74xx
+	bool
+	depends on MPC7448HPC2
+	default y
+	help
+	  Select 74xx support
+	  
+config TSI108_BRIDGE
+	bool
+	depends on MPC7448HPC2
+	default y
+	  
 endchoice
 
 config PPC_PSERIES
@@ -798,7 +819,8 @@ config MCA
 	bool
 
 config PCI
-	bool "PCI support" if 40x || CPM2 || PPC_83xx || PPC_85xx || PPC_MPC52xx || (EMBEDDED && PPC_ISERIES)
+	bool "PCI support" if 40x || CPM2 || PPC_83xx || PPC_85xx || PPC_MPC52xx || (EMBEDDED && PPC_ISERIES) \
+				  || MPC7448HPC2
 	default y if !40x && !CPM2 && !8xx && !APUS && !PPC_83xx && !PPC_85xx
 	default PCI_PERMEDIA if !4xx && !CPM2 && !8xx && APUS
 	default PCI_QSPAN if !4xx && !CPM2 && 8xx
diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index 6e67b5b..f99238d 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -134,6 +134,34 @@ static int __init add_legacy_soc_port(st
 	return add_legacy_port(np, -1, UPIO_MEM, addr, addr, NO_IRQ, flags);
 }
 
+static int __init add_legacy_tsi_port(struct device_node *np,
+				      struct device_node *tsi_dev)
+{
+	phys_addr_t addr;
+	u32 *addrp;
+	upf_t flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_SHARE_IRQ;
+
+	/* We only support ports that have a clock frequency properly
+	 * encoded in the device-tree.
+	 */
+	if (get_property(np, "clock-frequency", NULL) == NULL)
+		return -1;
+
+	/* Get the address */
+	addrp = of_get_address(tsi_dev, 0, NULL, NULL);
+	if (addrp == NULL)
+		return -1;
+
+	addr = of_translate_address(tsi_dev, addrp);
+
+	/* Add port, irq will be dealt with later. We passed a translated
+	 * IO port value. It will be fixed up later along with the irq
+	 */
+	return add_legacy_port(np, -1, UPIO_MEM, addr, addr, NO_IRQ, flags);
+}
+
+
+
 static int __init add_legacy_isa_port(struct device_node *np,
 				      struct device_node *isa_brg)
 {
@@ -302,6 +330,17 @@ void __init find_legacy_serial_ports(voi
 		of_node_put(isa);
 	}
 
+	/* First fill our array with tsi-bridge ports */
+	for (np = NULL; (np = of_find_compatible_node(np, "serial", "ns16550")) != NULL;) {
+		struct device_node *tsi = of_get_parent(np);
+		if (tsi && !strcmp(tsi->type, "tsi-bridge")) {
+			index = add_legacy_tsi_port(np, np);
+			if (index >= 0 && np == stdout)
+				legacy_serial_console = index;
+		}
+		of_node_put(tsi);
+	}
+	
 #ifdef CONFIG_PCI
 	/* Next, try to locate PCI ports */
 	for (np = NULL; (np = of_find_all_nodes(np));) {
diff --git a/arch/powerpc/platforms/74xx/Makefile b/arch/powerpc/platforms/74xx/Makefile
new file mode 100644
index 0000000..ed5648c
--- /dev/null
+++ b/arch/powerpc/platforms/74xx/Makefile
@@ -0,0 +1,4 @@
+#
+# Makefile for the PowerPC 74xx linux kernel.
+#
+obj-$(CONFIG_MPC7448HPC2)	+= mpc7448_hpc2.o pci.o misc.o
diff --git a/arch/powerpc/platforms/74xx/misc.c b/arch/powerpc/platforms/74xx/misc.c
new file mode 100644
index 0000000..6228875
--- /dev/null
+++ b/arch/powerpc/platforms/74xx/misc.c
@@ -0,0 +1,38 @@
+
+/*
+ * MPC74xx generic code.
+ *
+ * Maintained by Roy Zang 
+ * 
+ * Copyright 2006 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <asm/irq.h>
+extern void _nmask_and_or_msr(unsigned long nmask, unsigned long or_val);
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
diff --git a/arch/powerpc/platforms/74xx/mpc7448_hpc2.c b/arch/powerpc/platforms/74xx/mpc7448_hpc2.c
new file mode 100644
index 0000000..b060ae1
--- /dev/null
+++ b/arch/powerpc/platforms/74xx/mpc7448_hpc2.c
@@ -0,0 +1,257 @@
+/*
+ * mpc7448_hpc2.c
+ *
+ * Board setup routines for the Freescale Taiga platform
+ *
+ * Author: Jacob Pan
+ *	 jacob.pan@freescale.com
+ * Author: Xianghua Xiao
+ *       updated for taiga board from emulation platform 2005.5
+ *       x.xiao@freescale.com
+ * Maintainer: Roy Zang <tie-fei.zang@freescale.com>      
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
+#include <asm/tsi108_pic.h>
+
+#ifndef CONFIG_PCI
+isa_io_base = MPC7448_HPC2_ISA_IO_BASE;
+isa_mem_base = MPC7448_HPC2_ISA_MEM_BASE;
+pci_dram_offset = MPC7448_HPC2_PCI_MEM_OFFSET;
+#endif
+
+extern int add_bridge(struct device_node *dev);
+extern void mpc7448_hpc2_restart(char *cmd);
+extern void mpc7448_hpc2_power_off(void);
+extern void mpc7448_hpc2_halt(void);
+
+#ifdef TSI108_ETH
+hw_info hw_info_table[TSI108_ETH_MAX_PORTS + 1] = {
+	{TSI108_CSR_ADDR_PHYS + TSI108_ETH_OFFSET,
+	 TSI108_CSR_ADDR_PHYS + TSI108_ETH_OFFSET,
+	 TSI108_PHY0_ADDR, IRQ_TSI108_GIGE0},
+
+	{TSI108_CSR_ADDR_PHYS + TSI108_ETH_OFFSET + 0x400,
+	 TSI108_CSR_ADDR_PHYS + TSI108_ETH_OFFSET,
+	 TSI108_PHY1_ADDR, IRQ_TSI108_GIGE1},
+
+	{TBL_END, TBL_END, TBL_END, TBL_END}
+};
+#endif
+
+/*
+ * Define all of the IRQ senses and polarities.  Taken from the
+ * mpc7448hpc  manual.
+ * Note:  Likely, this table and the following function should be
+ *        obtained and derived from the OF Device Tree.
+ */
+
+static u_char mpc7448_hpc2_pic_initsenses[] __initdata = {
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* INT[0] XINT0 from FPGA */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* INT[1] XINT1 from FPGA */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* INT[2] PHY_INT from both GIGE */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* INT[3] RESERVED */
+};
+
+/*
+ * mpc7448hpc2 PCI interrupt routing. all PCI interrupt comes from
+ * external PCI source at 23. need to program pci interrupt control registers
+ * to route per slot IRQs.
+ */
+
+static inline int
+mpc7448_hpc2_map_irq(struct pci_dev *dev, unsigned char idsel,
+		     unsigned char pin)
+{
+	static char pci_irq_table[][4] =
+	    /*
+	     *      PCI IDSEL/INTPIN->INTLINE
+	     *         A     B     C     D
+	     */
+	{
+		{IRQ_PCI_INTA, IRQ_PCI_INTB, IRQ_PCI_INTC, IRQ_PCI_INTD},	/* A SLOT 1 IDSEL 17 */
+		{IRQ_PCI_INTB, IRQ_PCI_INTC, IRQ_PCI_INTD, IRQ_PCI_INTA},	/* B SLOT 2 IDSEL 18 */
+		{IRQ_PCI_INTC, IRQ_PCI_INTD, IRQ_PCI_INTA, IRQ_PCI_INTB},	/* C SATA IDSEL 19 */
+		{IRQ_PCI_INTD, IRQ_PCI_INTA, IRQ_PCI_INTB, IRQ_PCI_INTC},	/* D USB IDSEL 20 */
+	};
+
+	const long min_idsel = 1, max_idsel = 4, irqs_per_slot = 4;
+	return PCI_IRQ_TABLE_LOOKUP;
+}
+
+int mpc7448_hpc2_exclude_device(u_char bus, u_char devfn)
+{
+	if (bus == 0 && PCI_SLOT(devfn) == 0)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	else
+		return PCIBIOS_SUCCESSFUL;
+}
+
+static __inline__ void mpc7448_hpc2_l2cr_prefetch_enable(void)
+{
+	unsigned long msscr0;
+	__asm__ __volatile__("mfspr %0, 0x3f6\n \
+		ori %0,%0,0x3\n	         \
+		sync \n                  \
+		mtspr 0x3f6,%0\n   \
+		sync\n			 \
+		isync ":"=r"(msscr0));
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
+
+#ifdef CONFIG_PCI
+
+	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
+		add_bridge(np);
+
+	ppc_md.pci_swizzle = common_swizzle;
+	ppc_md.pci_map_irq = mpc7448_hpc2_map_irq;
+	ppc_md.pci_exclude_device = mpc7448_hpc2_exclude_device;
+	if (ppc_md.progress)
+		ppc_md.progress("tsi108: resources set", 0x100);
+#endif
+
+#ifdef CONFIG_DUMMY_CONSOLE
+	conswitchp = &dummy_con;
+#endif
+
+	printk(KERN_INFO "MPC7448HPC2 (TAIGA) Platform\n");
+	printk(KERN_INFO
+	       "Jointly ported by Freescale and Tundra Semiconductor\n");
+	printk(KERN_INFO
+	       "Enabling L2 cache then enabling the HID0 prefetch engine.\n");
+	_set_L2CR(L2CR_L2E);
+	mpc7448_hpc2_l2cr_prefetch_enable();
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
+
+	tsi108_pic_init(mpc7448_hpc2_pic_initsenses);
+
+	/* Configure MPIC outputs to CPU0 */
+	tsi108_pic_set_output(0, IRQ_SENSE_EDGE, IRQ_POLARITY_NEGATIVE);
+}
+
+static void __init mpc7448_hpc2_map_io(void)
+{
+	/* PCI IO  mapping */
+	io_block_mapping(MPC7448_HPC2_PCI_IO_BASE_VIRT,
+			 MPC7448_HPC2_PCI_IO_BASE_PHYS, 0x00800000, _PAGE_IO);
+	/* Tsi108 CSR mapping */
+	io_block_mapping(TSI108_CSR_ADDR_VIRT, TSI108_CSR_ADDR_PHYS,
+			 0x100000, _PAGE_IO);
+
+	/* PCI Config mapping */
+	io_block_mapping(MPC7448_HPC2_PCI_CFG_BASE_VIRT,
+			 MPC7448_HPC2_PCI_CFG_BASE_PHYS,
+			 MPC7448_HPC2_PCI_CFG_SIZE, _PAGE_IO);
+
+	tsi108_pci_cfg_base = MPC7448_HPC2_PCI_CFG_BASE_VIRT;
+	/* NVRAM mapping */
+	io_block_mapping(MPC7448_HPC2_NVRAM_BASE_ADDR,
+			 MPC7448_HPC2_NVRAM_BASE_ADDR, MPC7448_HPC2_NVRAM_SIZE,
+			 _PAGE_IO);
+}
+
+void mpc7448_hpc2_show_cpuinfo(struct seq_file *m)
+{
+	seq_printf(m, "vendor\t\t: Freescale Semiconductor\n");
+	seq_printf(m, "machine\t\t: MPC7448hpc2\n");
+}
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init mpc7448_hpc2_probe(void)
+{
+	/* We always match for now, eventually we should look at the flat
+	   dev tree to ensure this is the board we are suppose to run on
+	 */
+	return 1;
+}
+
+define_machine(mpc7448_hpc2){
+	.name 			= "MPC7448 HPC2",
+	.probe 			= mpc7448_hpc2_probe,
+	.setup_arch 		= mpc7448_hpc2_setup_arch,
+	.init_IRQ 		= mpc7448_hpc2_init_IRQ,
+	.show_cpuinfo 		= mpc7448_hpc2_show_cpuinfo,
+	.get_irq 		= tsi108_pic_get_irq,
+	.restart 		= mpc7448_hpc2_restart,
+	.calibrate_decr 	= generic_calibrate_decr,
+	.setup_io_mappings 	= mpc7448_hpc2_map_io,
+	.progress 		= udbg_progress,
+};
diff --git a/arch/powerpc/platforms/74xx/mpc7448_hpc2.h b/arch/powerpc/platforms/74xx/mpc7448_hpc2.h
new file mode 100644
index 0000000..8833520
--- /dev/null
+++ b/arch/powerpc/platforms/74xx/mpc7448_hpc2.h
@@ -0,0 +1,80 @@
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
+/* Ethernet defines
+ */
+#define TSI108_ETH
+#define TSI108_ETH_MAX_PORTS	(2)	/* TSI108 Ethernet block has 2 ports */
+#define TSI108_PHY0_ADDR	(8)	/* PHY address for GIGE port 0 */
+#define TSI108_PHY1_ADDR	(9)	/* PHY address for GIGE port 1 */
+
+/* Base Addresses for the PCI bus 
+ * HOST_PCI initiator (outbound) window to PCI bus
+ */
+#define MPC7448_HPC2_PCI_MEM_OFFSET	(0x00000000)
+#define MPC7448_HPC2_PCI_IO_BASE_PHYS	(0xfa000000)
+#define MPC7448_HPC2_PCI_IO_BASE_VIRT	(MPC7448_HPC2_PCI_IO_BASE_PHYS)
+#define MPC7448_HPC2_PCI_MEM_BASE	(0xe0000000)
+#define MPC7448_HPC2_ISA_IO_BASE	(0x00000000)
+#define MPC7448_HPC2_ISA_MEM_BASE	(0x00000000)
+
+#define MPC7448_HPC2_PCI_CFG_BASE_PHYS	(0xfb000000)
+#define MPC7448_HPC2_PCI_CFG_BASE_VIRT	(MPC7448_HPC2_PCI_CFG_BASE_PHYS)
+#define MPC7448_HPC2_PCI_CFG_SIZE	(0x01000000)
+
+#define MPC7448_HPC2_PCI_MEM_START	(0xE0000000)
+#define MPC7448_HPC2_PCI_MEM_END	(0xF9FFFFFF)
+
+#define MPC7448_HPC2_PCI_IO_START	(0xFA000000)
+#define MPC7448_HPC2_PCI_IO_END	(0xFA00FFFF)
+
+#define MPC7448_HPC2_PCI_CFG_OFFSET	(0xFB000000)
+#define MPC7448_HPC2_PCI_IO_OFFSET	(0xFA000000)
+
+#define MPC7448_HPC2_PCI_MEM32_OFFSET	0x00000000	/* PCI MEM32 space offset within
+							   the PCI window */
+#define MPC7448_HPC2_PCI_PFM_OFFSET	0x10000000	/* PCI PFM1 space offset within
+							   the PCI window */
+
+/* Memory-mapped CIU resources (CPU view)
+ * The memory map is set by initialization code in monitor
+ */
+
+#define TSI108_CSR_ADDR_PHYS	(0xC0000000)	/* Physical Tsi108 CSR Base Address */
+#define TSI108_CSR_ADDR_VIRT	(0xF0000000)	/* Virtual Tsi108 CSR Base Address */
+
+#define FLASH_BASE_ADDR		(0xFF000000)	/* Boot FLASH Base Address */
+
+#define SDRAM_BASE_ADDR		0x00000000	/* SDRAM base address */
+#define BOARD_SDRAM_SIZE	0x20000000	/* Default value: 512MB */
+
+/* Size of SDRAM space reserved for user space. This limits space available
+ * for dynamic allocation. 
+ */
+#define USER_RESERVED_MEM	(BOARD_SDRAM_SIZE - 0x02000000)
+
+#define USER_RESERVED_BASE  \
+  (SDRAM_BASE_ADDR + (BOARD_SDRAM_SIZE - USER_RESERVED_MEM)
+
+/* Memory mapped NVRAM/RTC */
+#define MPC7448_HPC2_NVRAM_BASE_ADDR	(0xFC000000)
+#define MPC7448_HPC2_NVRAM_SIZE	(0x8000)
+
+#endif				/* __PPC_PLATFORMS_MPC7448_HPC2_H */
diff --git a/arch/powerpc/platforms/74xx/pci.c b/arch/powerpc/platforms/74xx/pci.c
new file mode 100644
index 0000000..fd822ed
--- /dev/null
+++ b/arch/powerpc/platforms/74xx/pci.c
@@ -0,0 +1,103 @@
+/*
+ * TSI 108 PCI hose setup up code
+ *
+ * Maintained by Roy Zang
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+
+#include <asm/system.h>
+#include <asm/atomic.h>
+#include <asm/io.h>
+#include <asm/pci-bridge.h>
+#include <asm/prom.h>
+#include <asm/tsi108.h>
+#include "mpc7448_hpc2.h"
+
+#undef DEBUG
+
+#ifdef DEBUG
+#define DBG(x...) printk(x)
+#else
+#define DBG(x...)
+#endif
+
+extern int tsi108_direct_write_config(struct pci_bus *bus, unsigned int devfn,
+				      int offset, int len, u32 val);
+extern int tsi108_direct_read_config(struct pci_bus *bus, unsigned int devfn,
+				     int offset, int len, u32 * val);
+
+void tsi108_clear_pci_error(u32 pci_cfg_base);
+
+extern int
+tsi108_read_config(int bus, unsigned int devfn, int offset, int len, u32 * val);
+#ifdef CONFIG_PCI
+static struct pci_ops direct_pci_ops = {
+	tsi108_direct_read_config,
+	tsi108_direct_write_config
+};
+
+void tsi108_clear_pci_cfg_error(void)
+{
+	tsi108_clear_pci_error(MPC7448_HPC2_PCI_CFG_BASE_PHYS);
+}
+
+int __init add_bridge(struct device_node *dev)
+{
+	int len;
+	struct pci_controller *hose;
+	struct resource rsrc;
+	int *bus_range;
+	int primary = 0, has_address = 0;
+
+	DBG("TSI_PCI: %s tsi108_pci_cfg_base=0x%x\n", __FUNCTION__,
+	    tsi108_pci_cfg_base);
+
+	/* Fetch host bridge registers address */
+	has_address = (of_address_to_resource(dev, 0, &rsrc) == 0);
+
+	/* Get bus range if any */
+	bus_range = (int *)get_property(dev, "bus-range", &len);
+	if (bus_range == NULL || len < 2 * sizeof(int)) {
+		printk(KERN_WARNING "Can't get bus-range for %s, assume"
+		       " bus 0\n", dev->full_name);
+	}
+
+	hose = pcibios_alloc_controller();
+
+	if (!hose) {
+		printk("PCI Host bridge init failed\n");
+		return -ENOMEM;
+	}
+	hose->arch_data = dev;
+	hose->set_cfg_type = 1;
+
+	hose->first_busno = bus_range ? bus_range[0] : 0;
+	hose->last_busno = bus_range ? bus_range[1] : 0xff;
+
+	(hose)->ops = &direct_pci_ops;
+
+	printk(KERN_INFO "Found tsi108 PCI host bridge at 0x%08lx. "
+	       "Firmware bus number: %d->%d\n",
+	       rsrc.start, hose->first_busno, hose->last_busno);
+
+	/* Interpret the "ranges" property */
+	/* This also maps the I/O region and sets isa_io/mem_base */
+	pci_process_bridge_OF_ranges(hose, dev, primary);
+	return 0;
+
+}
+#endif
diff --git a/arch/powerpc/platforms/Makefile b/arch/powerpc/platforms/Makefile
index c4f6b0d..71ca0e0 100644
--- a/arch/powerpc/platforms/Makefile
+++ b/arch/powerpc/platforms/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_PPC_CHRP)		+= chrp/
 obj-$(CONFIG_4xx)		+= 4xx/
 obj-$(CONFIG_PPC_83xx)		+= 83xx/
 obj-$(CONFIG_PPC_85xx)		+= 85xx/
+obj-$(CONFIG_74xx)		+= 74xx/
 obj-$(CONFIG_PPC_PSERIES)	+= pseries/
 obj-$(CONFIG_PPC_ISERIES)	+= iseries/
 obj-$(CONFIG_PPC_MAPLE)		+= maple/
-- 
1.3.0
