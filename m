Return-Path: <rolandd@cisco.com>
Received: from ams-iport-1.cisco.com (ams-iport-1.cisco.com [144.254.224.140])
	by ozlabs.org (Postfix) with ESMTP id 39E7B684C7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Oct 2005 14:20:41 +1000 (EST)
In-Reply-To: <200510112120.42FGm7PG3M7nv7YB@cisco.com>
Date: Tue, 11 Oct 2005 21:20:30 -0700
Message-Id: <200510112120.RAZZVC32rWQh86Yb@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: mporter@kernel.crashing.org
From: Roland Dreier <rolandd@cisco.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH 4/4] [PPC32] Add Yucca (440SPe eval board) platform
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Add support for AMCC PowerPC 440SPe "Yucca" eval board platform.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 arch/ppc/boot/simple/Makefile   |    6 +
 arch/ppc/platforms/4xx/Kconfig  |   11 +
 arch/ppc/platforms/4xx/Makefile |    1 
 arch/ppc/platforms/4xx/yucca.c  |  420 +++++++++++++++++++++++++++++++++++++++
 arch/ppc/platforms/4xx/yucca.h  |  111 ++++++++++
 arch/ppc/syslib/Makefile        |    1 
 include/asm-ppc/ibm4xx.h        |    4 
 7 files changed, 552 insertions(+), 2 deletions(-)
 create mode 100644 arch/ppc/platforms/4xx/yucca.c
 create mode 100644 arch/ppc/platforms/4xx/yucca.h

applies-to: b69675164534e119bbe349478dbeab0c9431826c
68e399cc8c52337dced563bcd344316689312f7f
diff --git a/arch/ppc/boot/simple/Makefile b/arch/ppc/boot/simple/Makefile
index b7bd8f6..ff0904e 100644
--- a/arch/ppc/boot/simple/Makefile
+++ b/arch/ppc/boot/simple/Makefile
@@ -79,6 +79,12 @@ zimageinitrd-$(CONFIG_LUAN)		:= zImage.i
   entrypoint-$(CONFIG_LUAN)		:= 0x01000000
      extra.o-$(CONFIG_LUAN)		:= pibs.o
 
+      zimage-$(CONFIG_YUCCA)		:= zImage-TREE
+zimageinitrd-$(CONFIG_YUCCA)		:= zImage.initrd-TREE
+         end-$(CONFIG_YUCCA)		:= yucca
+  entrypoint-$(CONFIG_YUCCA)		:= 0x01000000
+     extra.o-$(CONFIG_YUCCA)		:= pibs.o
+
       zimage-$(CONFIG_OCOTEA)		:= zImage-TREE
 zimageinitrd-$(CONFIG_OCOTEA)		:= zImage.initrd-TREE
          end-$(CONFIG_OCOTEA)		:= ocotea
diff --git a/arch/ppc/platforms/4xx/Kconfig b/arch/ppc/platforms/4xx/Kconfig
index 108d5a7..e70e4c6 100644
--- a/arch/ppc/platforms/4xx/Kconfig
+++ b/arch/ppc/platforms/4xx/Kconfig
@@ -82,6 +82,12 @@ config LUAN
 	help
 	  This option enables support for the IBM PPC440SP evaluation board.
 
+config YUCCA
+	bool "Yucca"
+	select WANT_EARLY_SERIAL
+	help
+	  This option enables support for the AMCC PPC440SPe evaluation board.
+
 config OCOTEA
 	bool "Ocotea"
 	select WANT_EARLY_SERIAL
@@ -126,7 +132,8 @@ config 440SP
 
 config 440SPE
 	bool
-	default n
+	depends on YUCCA
+	default y
 
 config 440
 	bool
@@ -162,7 +169,7 @@ config BOOKE
 
 config IBM_OCP
 	bool
-	depends on ASH || BAMBOO || BUBINGA || CPCI405 || EBONY || EP405 || LUAN || OCOTEA || REDWOOD_5 || REDWOOD_6 || SYCAMORE || WALNUT
+	depends on ASH || BAMBOO || BUBINGA || CPCI405 || EBONY || EP405 || LUAN || YUCCA || OCOTEA || REDWOOD_5 || REDWOOD_6 || SYCAMORE || WALNUT
 	default y
 
 config XILINX_OCP
diff --git a/arch/ppc/platforms/4xx/Makefile b/arch/ppc/platforms/4xx/Makefile
index 694accd..c9bb611 100644
--- a/arch/ppc/platforms/4xx/Makefile
+++ b/arch/ppc/platforms/4xx/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_EBONY)		+= ebony.o
 obj-$(CONFIG_EP405)		+= ep405.o
 obj-$(CONFIG_BUBINGA)		+= bubinga.o
 obj-$(CONFIG_LUAN)		+= luan.o
+obj-$(CONFIG_YUCCA)		+= yucca.o
 obj-$(CONFIG_OCOTEA)		+= ocotea.o
 obj-$(CONFIG_REDWOOD_5)		+= redwood5.o
 obj-$(CONFIG_REDWOOD_6)		+= redwood6.o
diff --git a/arch/ppc/platforms/4xx/yucca.c b/arch/ppc/platforms/4xx/yucca.c
new file mode 100644
index 0000000..b382022
--- /dev/null
+++ b/arch/ppc/platforms/4xx/yucca.c
@@ -0,0 +1,420 @@
+/*
+ * arch/ppc/platforms/4xx/yucca.c
+ *
+ * Yucca board specific routines
+ *
+ * Roland Dreier <rolandd@cisco.com> (based on luan.c by Matt Porter)
+ *
+ * Copyright 2004-2005 MontaVista Software Inc.
+ * Copyright (c) 2005 Cisco Systems.  All rights reserved.
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
+#include <linux/reboot.h>
+#include <linux/pci.h>
+#include <linux/kdev_t.h>
+#include <linux/types.h>
+#include <linux/major.h>
+#include <linux/blkdev.h>
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/ide.h>
+#include <linux/initrd.h>
+#include <linux/seq_file.h>
+#include <linux/root_dev.h>
+#include <linux/tty.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+
+#include <asm/system.h>
+#include <asm/pgtable.h>
+#include <asm/page.h>
+#include <asm/dma.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+#include <asm/ocp.h>
+#include <asm/pci-bridge.h>
+#include <asm/time.h>
+#include <asm/todc.h>
+#include <asm/bootinfo.h>
+#include <asm/ppc4xx_pic.h>
+#include <asm/ppcboot.h>
+
+#include <syslib/ibm44x_common.h>
+#include <syslib/ibm440gx_common.h>
+#include <syslib/ibm440sp_common.h>
+#include <syslib/ppc440spe_pcie.h>
+
+bd_t __res;
+
+static struct ibm44x_clocks clocks __initdata;
+
+static void __init
+yucca_calibrate_decr(void)
+{
+	unsigned int freq;
+
+	if (mfspr(SPRN_CCR1) & CCR1_TCS)
+		freq = YUCCA_TMR_CLK;
+	else
+		freq = clocks.cpu;
+
+	ibm44x_calibrate_decr(freq);
+}
+
+static int
+yucca_show_cpuinfo(struct seq_file *m)
+{
+	seq_printf(m, "vendor\t\t: AMCC\n");
+	seq_printf(m, "machine\t\t: PPC440SPe EVB (Yucca)\n");
+
+	return 0;
+}
+
+static enum {
+	HOSE_UNKNOWN,
+	HOSE_PCIX,
+	HOSE_PCIE0,
+	HOSE_PCIE1,
+	HOSE_PCIE2
+} hose_type[4];
+
+static inline int
+yucca_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
+{
+	struct pci_controller *hose = pci_bus_to_hose(dev->bus->number);
+
+	if (hose_type[hose->index] == HOSE_PCIX) {
+		static char pci_irq_table[][4] =
+		/*
+		 *	PCI IDSEL/INTPIN->INTLINE
+		 *	  A   B   C   D
+		 */
+		{
+			{ 81, -1, -1, -1 },	/* IDSEL 1 - PCIX0 Slot 0 */
+		};
+		const long min_idsel = 1, max_idsel = 1, irqs_per_slot = 4;
+		return PCI_IRQ_TABLE_LOOKUP;
+	} else if (hose_type[hose->index] == HOSE_PCIE0) {
+		static char pci_irq_table[][4] =
+		/*
+		 *	PCI IDSEL/INTPIN->INTLINE
+		 *	  A   B   C   D
+		 */
+		{
+			{ 96, 97, 98, 99 },
+		};
+		const long min_idsel = 1, max_idsel = 1, irqs_per_slot = 4;
+		return PCI_IRQ_TABLE_LOOKUP;
+	} else if (hose_type[hose->index] == HOSE_PCIE1) {
+		static char pci_irq_table[][4] =
+		/*
+		 *	PCI IDSEL/INTPIN->INTLINE
+		 *	  A   B   C   D
+		 */
+		{
+			{ 100, 101, 102, 103 },
+		};
+		const long min_idsel = 1, max_idsel = 1, irqs_per_slot = 4;
+		return PCI_IRQ_TABLE_LOOKUP;
+	} else if (hose_type[hose->index] == HOSE_PCIE2) {
+		static char pci_irq_table[][4] =
+		/*
+		 *	PCI IDSEL/INTPIN->INTLINE
+		 *	  A   B   C   D
+		 */
+		{
+			{ 104, 105, 106, 107 },
+		};
+		const long min_idsel = 1, max_idsel = 1, irqs_per_slot = 4;
+		return PCI_IRQ_TABLE_LOOKUP;
+	}
+	return -1;
+}
+
+static void __init yucca_set_emacdata(void)
+{
+	struct ocp_def *def;
+	struct ocp_func_emac_data *emacdata;
+
+	/* Set phy_map, phy_mode, and mac_addr for the EMAC */
+	def = ocp_get_one_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC, 0);
+	emacdata = def->additions;
+	emacdata->phy_map = 0x00000001;	/* Skip 0x00 */
+	emacdata->phy_mode = PHY_MODE_GMII;
+	memcpy(emacdata->mac_addr, __res.bi_enetaddr, 6);
+}
+
+static int __init yucca_pcie_card_present(int port)
+{
+   void __iomem *pcie_fpga_base;
+   u16 reg;
+
+   pcie_fpga_base = ioremap64(YUCCA_FPGA_REG_BASE, YUCCA_FPGA_REG_SIZE);
+   reg = in_be16(pcie_fpga_base + FPGA_REG1C);
+   iounmap(pcie_fpga_base);
+
+   switch(port) {
+   case 0: return !(reg & FPGA_REG1C_PE0_PRSNT);
+   case 1: return !(reg & FPGA_REG1C_PE1_PRSNT);
+   case 2: return !(reg & FPGA_REG1C_PE2_PRSNT);
+   default: return 0;
+   }
+}
+
+/*
+ * For the given slot, set rootpoint mode, send power to the slot,
+ * turn on the green LED and turn off the yellow LED, enable the clock
+ * and turn off reset.
+ */
+static void __init yucca_setup_pcie_fpga_rootpoint(int port)
+{
+	void __iomem *pcie_reg_fpga_base;
+	u16 power, clock, green_led, yellow_led, reset_off, rootpoint, endpoint;
+
+	pcie_reg_fpga_base = ioremap64(YUCCA_FPGA_REG_BASE, YUCCA_FPGA_REG_SIZE);
+
+	switch(port) {
+	case 0:
+		rootpoint   = FPGA_REG1C_PE0_ROOTPOINT;
+		endpoint    = 0;
+		power 	    = FPGA_REG1A_PE0_PWRON;
+		green_led   = FPGA_REG1A_PE0_GLED;
+		clock 	    = FPGA_REG1A_PE0_REFCLK_ENABLE;
+		yellow_led  = FPGA_REG1A_PE0_YLED;
+		reset_off   = FPGA_REG1C_PE0_PERST;
+		break;
+	case 1:
+		rootpoint   = 0;
+		endpoint    = FPGA_REG1C_PE1_ENDPOINT;
+		power 	    = FPGA_REG1A_PE1_PWRON;
+		green_led   = FPGA_REG1A_PE1_GLED;
+		clock 	    = FPGA_REG1A_PE1_REFCLK_ENABLE;
+		yellow_led  = FPGA_REG1A_PE1_YLED;
+		reset_off   = FPGA_REG1C_PE1_PERST;
+		break;
+	case 2:
+		rootpoint   = 0;
+		endpoint    = FPGA_REG1C_PE2_ENDPOINT;
+		power 	    = FPGA_REG1A_PE2_PWRON;
+		green_led   = FPGA_REG1A_PE2_GLED;
+		clock 	    = FPGA_REG1A_PE2_REFCLK_ENABLE;
+		yellow_led  = FPGA_REG1A_PE2_YLED;
+		reset_off   = FPGA_REG1C_PE2_PERST;
+		break;
+
+	default:
+		return;
+	}
+
+	out_be16(pcie_reg_fpga_base + FPGA_REG1A,
+		 ~(power | clock | green_led) &
+		 (yellow_led | in_be16(pcie_reg_fpga_base + FPGA_REG1A)));
+	out_be16(pcie_reg_fpga_base + FPGA_REG1C,
+		 ~(endpoint | reset_off) &
+		 (rootpoint | in_be16(pcie_reg_fpga_base + FPGA_REG1C)));
+
+	/*
+	 * Leave device in reset for a while after powering on the
+	 * slot to give it a chance to initialize.
+	 */
+	mdelay(250);
+
+	out_be16(pcie_reg_fpga_base + FPGA_REG1C,
+		 reset_off | in_be16(pcie_reg_fpga_base + FPGA_REG1C));
+
+	iounmap(pcie_reg_fpga_base);
+}
+
+static void __init
+yucca_setup_hoses(void)
+{
+	struct pci_controller *hose;
+	char name[20];
+	int i;
+
+	if (0 && ppc440spe_init_pcie()) {
+		printk(KERN_WARNING "PPC440SPe PCI Express initialization failed\n");
+		return;
+	}
+
+	for (i = 0; i <= 2; ++i) {
+		if (!yucca_pcie_card_present(i))
+			continue;
+
+		printk(KERN_INFO "PCIE%d: card present\n", i);
+		yucca_setup_pcie_fpga_rootpoint(i);
+		if (ppc440spe_init_pcie_rootport(i)) {
+			printk(KERN_WARNING "PCIE%d: initialization failed\n", i);
+			continue;
+		}
+
+		hose = pcibios_alloc_controller();
+		if (!hose)
+			return;
+
+		sprintf(name, "PCIE%d host bridge", i);
+		pci_init_resource(&hose->io_resource,
+				  YUCCA_PCIX_LOWER_IO,
+				  YUCCA_PCIX_UPPER_IO,
+				  IORESOURCE_IO,
+				  name);
+
+		hose->mem_space.start = YUCCA_PCIE_LOWER_MEM +
+			i * YUCCA_PCIE_MEM_SIZE;
+		hose->mem_space.end   = hose->mem_space.start +
+			YUCCA_PCIE_MEM_SIZE - 1;
+
+		pci_init_resource(&hose->mem_resources[0],
+				  hose->mem_space.start,
+				  hose->mem_space.end,
+				  IORESOURCE_MEM,
+				  name);
+
+		hose->first_busno = 0;
+		hose->last_busno  = 15;
+		hose_type[hose->index] = HOSE_PCIE0 + i;
+
+		ppc440spe_setup_pcie(hose, i);
+
+		ppc_md.progress("pre pciauto", 0x122);
+
+		hose->last_busno = pciauto_bus_scan(hose, hose->first_busno);
+
+		ppc_md.progress("post pciauto", 0x123);
+	}
+
+	ppc_md.pci_swizzle = common_swizzle;
+	ppc_md.pci_map_irq = yucca_map_irq;
+}
+
+TODC_ALLOC();
+
+static void __init
+yucca_early_serial_map(void)
+{
+	struct uart_port port;
+
+	/* Setup ioremapped serial port access */
+	memset(&port, 0, sizeof(port));
+	port.membase = ioremap64(PPC440SPE_UART0_ADDR, 8);
+	port.irq = UART0_INT;
+	port.uartclk = clocks.uart0;
+	port.regshift = 0;
+	port.iotype = SERIAL_IO_MEM;
+	port.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
+	port.line = 0;
+
+	if (early_serial_setup(&port) != 0) {
+		printk("Early serial init of port 0 failed\n");
+	}
+
+	port.membase = ioremap64(PPC440SPE_UART1_ADDR, 8);
+	port.irq = UART1_INT;
+	port.uartclk = clocks.uart1;
+	port.line = 1;
+
+	if (early_serial_setup(&port) != 0) {
+		printk("Early serial init of port 1 failed\n");
+	}
+
+	port.membase = ioremap64(PPC440SPE_UART2_ADDR, 8);
+	port.irq = UART2_INT;
+	port.uartclk = BASE_BAUD;
+	port.line = 2;
+
+	if (early_serial_setup(&port) != 0) {
+		printk("Early serial init of port 2 failed\n");
+	}
+}
+
+static void __init
+yucca_setup_arch(void)
+{
+	yucca_set_emacdata();
+
+#if !defined(CONFIG_BDI_SWITCH)
+	/*
+	 * The Abatron BDI JTAG debugger does not tolerate others
+	 * mucking with the debug registers.
+	 */
+        mtspr(SPRN_DBCR0, (DBCR0_TDE | DBCR0_IDM));
+#endif
+
+	/*
+	 * Determine various clocks.
+	 * To be completely correct we should get SysClk
+	 * from FPGA, because it can be changed by on-board switches
+	 * --ebs
+	 */
+	/* 440GX and 440SP clocking is the same -mdp */
+	ibm440gx_get_clocks(&clocks, 33333333, 6 * 1843200);
+	ocp_sys_info.opb_bus_freq = clocks.opb;
+
+	/* init to some ~sane value until calibrate_delay() runs */
+        loops_per_jiffy = 50000000/HZ;
+
+	/* Setup PCIXn host bridges */
+	yucca_setup_hoses();
+
+#ifdef CONFIG_BLK_DEV_INITRD
+	if (initrd_start)
+		ROOT_DEV = Root_RAM0;
+	else
+#endif
+#ifdef CONFIG_ROOT_NFS
+		ROOT_DEV = Root_NFS;
+#else
+		ROOT_DEV = Root_HDA1;
+#endif
+
+	yucca_early_serial_map();
+
+	/* Identify the system */
+	printk("Yucca port (Roland Dreier <rolandd@cisco.com>)\n");
+}
+
+void __init platform_init(unsigned long r3, unsigned long r4,
+		unsigned long r5, unsigned long r6, unsigned long r7)
+{
+	parse_bootinfo(find_bootinfo());
+
+	/*
+	 * If we were passed in a board information, copy it into the
+	 * residual data area.
+	 */
+	if (r3)
+		__res = *(bd_t *)(r3 + KERNELBASE);
+
+#if defined(CONFIG_BLK_DEV_INITRD)
+	/*
+	 * If the init RAM disk has been configured in, and there's a valid
+	 * starting address for it, set it up.
+	 */
+	if (r4) {
+		initrd_start = r4 + KERNELBASE;
+		initrd_end = r5 + KERNELBASE;
+	}
+#endif /* CONFIG_BLK_DEV_INITRD */
+
+	ibm44x_platform_init();
+
+	ppc_md.setup_arch = yucca_setup_arch;
+	ppc_md.show_cpuinfo = yucca_show_cpuinfo;
+	ppc_md.find_end_of_memory = ibm440sp_find_end_of_memory;
+	ppc_md.get_irq = NULL;		/* Set in ppc4xx_pic_init() */
+
+	ppc_md.calibrate_decr = yucca_calibrate_decr;
+#ifdef CONFIG_KGDB
+	ppc_md.early_serial_map = yucca_early_serial_map;
+#endif
+}
diff --git a/arch/ppc/platforms/4xx/yucca.h b/arch/ppc/platforms/4xx/yucca.h
new file mode 100644
index 0000000..de34ba3
--- /dev/null
+++ b/arch/ppc/platforms/4xx/yucca.h
@@ -0,0 +1,111 @@
+/*
+ * arch/ppc/platforms/4xx/yucca.h
+ *
+ * Yucca board definitions
+ *
+ * Roland Dreier <rolandd@cisco.com> (based on luan.h by Matt Porter)
+ *
+ * Copyright 2004-2005 MontaVista Software Inc.
+ * Copyright (c) 2005 Cisco Systems.  All rights reserved.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+#ifdef __KERNEL__
+#ifndef __ASM_YUCCA_H__
+#define __ASM_YUCCA_H__
+
+#include <linux/config.h>
+#include <platforms/4xx/ppc440spe.h>
+
+/* F/W TLB mapping used in bootloader glue to reset EMAC */
+#define PPC44x_EMAC0_MR0	0xa0000800
+
+/* Location of MAC addresses in PIBS image */
+#define PIBS_FLASH_BASE		0xffe00000
+#define PIBS_MAC_BASE		(PIBS_FLASH_BASE+0x1b0400)
+
+/* External timer clock frequency */
+#define YUCCA_TMR_CLK		25000000
+
+/*
+ * FPGA registers
+ */
+#define YUCCA_FPGA_REG_BASE			0x00000004e2000000ULL
+#define YUCCA_FPGA_REG_SIZE			0x24
+
+#define FPGA_REG1A				0x1a
+
+#define FPGA_REG1A_PE0_GLED			0x8000
+#define FPGA_REG1A_PE1_GLED			0x4000
+#define FPGA_REG1A_PE2_GLED			0x2000
+#define FPGA_REG1A_PE0_YLED			0x1000
+#define FPGA_REG1A_PE1_YLED			0x0800
+#define FPGA_REG1A_PE2_YLED			0x0400
+#define FPGA_REG1A_PE0_PWRON			0x0200
+#define FPGA_REG1A_PE1_PWRON			0x0100
+#define FPGA_REG1A_PE2_PWRON			0x0080
+#define FPGA_REG1A_PE0_REFCLK_ENABLE		0x0040
+#define FPGA_REG1A_PE1_REFCLK_ENABLE		0x0020
+#define FPGA_REG1A_PE2_REFCLK_ENABLE		0x0010
+#define FPGA_REG1A_PE_SPREAD0			0x0008
+#define FPGA_REG1A_PE_SPREAD1			0x0004
+#define FPGA_REG1A_PE_SELSOURCE_0		0x0002
+#define FPGA_REG1A_PE_SELSOURCE_1		0x0001
+
+#define FPGA_REG1C				0x1c
+
+#define FPGA_REG1C_PE0_ROOTPOINT		0x8000
+#define FPGA_REG1C_PE1_ENDPOINT			0x4000
+#define FPGA_REG1C_PE2_ENDPOINT			0x2000
+#define FPGA_REG1C_PE0_PRSNT			0x1000
+#define FPGA_REG1C_PE1_PRSNT			0x0800
+#define FPGA_REG1C_PE2_PRSNT			0x0400
+#define FPGA_REG1C_PE0_WAKE			0x0080
+#define FPGA_REG1C_PE1_WAKE			0x0040
+#define FPGA_REG1C_PE2_WAKE			0x0020
+#define FPGA_REG1C_PE0_PERST			0x0010
+#define FPGA_REG1C_PE1_PERST			0x0008
+#define FPGA_REG1C_PE2_PERST			0x0004
+
+/*
+ * Serial port defines
+ */
+#define RS_TABLE_SIZE	3
+
+/* PIBS defined UART mappings, used before early_serial_setup */
+#define UART0_IO_BASE	0xa0000200
+#define UART1_IO_BASE	0xa0000300
+#define UART2_IO_BASE	0xa0000600
+
+#define BASE_BAUD	11059200
+#define STD_UART_OP(num)					\
+	{ 0, BASE_BAUD, 0, UART##num##_INT,			\
+		(ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST),	\
+		iomem_base: UART##num##_IO_BASE,		\
+		io_type: SERIAL_IO_MEM},
+
+#define SERIAL_PORT_DFNS	\
+	STD_UART_OP(0)		\
+	STD_UART_OP(1)		\
+	STD_UART_OP(2)
+
+/* PCI support */
+#define YUCCA_PCIX_LOWER_IO	0x00000000
+#define YUCCA_PCIX_UPPER_IO	0x0000ffff
+#define YUCCA_PCIX_LOWER_MEM	0x80000000
+#define YUCCA_PCIX_UPPER_MEM	0x8fffffff
+#define YUCCA_PCIE_LOWER_MEM	0x90000000
+#define YUCCA_PCIE_MEM_SIZE	0x10000000
+
+#define YUCCA_PCIX_MEM_SIZE	0x10000000
+#define YUCCA_PCIX_MEM_OFFSET	0x00000000
+#define YUCCA_PCIE_MEM_SIZE	0x10000000
+#define YUCCA_PCIE_MEM_OFFSET	0x00000000
+
+#endif				/* __ASM_YUCCA_H__ */
+#endif				/* __KERNEL__ */
diff --git a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
index a060740..99cc996 100644
--- a/arch/ppc/syslib/Makefile
+++ b/arch/ppc/syslib/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_GT64260)		+= gt64260_pic.o
 obj-$(CONFIG_LOPEC)		+= i8259.o pci_auto.o todc_time.o
 obj-$(CONFIG_HDPU)		+= pci_auto.o
 obj-$(CONFIG_LUAN)		+= indirect_pci.o pci_auto.o todc_time.o
+obj-$(CONFIG_YUCCA)		+= indirect_pci.o pci_auto.o todc_time.o
 obj-$(CONFIG_KATANA)		+= pci_auto.o
 obj-$(CONFIG_MV64360)		+= mv64360_pic.o
 obj-$(CONFIG_MV64X60)		+= mv64x60.o mv64x60_win.o indirect_pci.o
diff --git a/include/asm-ppc/ibm4xx.h b/include/asm-ppc/ibm4xx.h
index e992369..6c28ae7 100644
--- a/include/asm-ppc/ibm4xx.h
+++ b/include/asm-ppc/ibm4xx.h
@@ -97,6 +97,10 @@ void ppc4xx_init(unsigned long r3, unsig
 #include <platforms/4xx/luan.h>
 #endif
 
+#if defined(CONFIG_YUCCA)
+#include <platforms/4xx/yucca.h>
+#endif
+
 #if defined(CONFIG_OCOTEA)
 #include <platforms/4xx/ocotea.h>
 #endif
---
0.99.8.GIT
