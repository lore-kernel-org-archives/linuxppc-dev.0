Return-Path: <sr@denx.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.189])
	by ozlabs.org (Postfix) with ESMTP id CACF5DDF08
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Apr 2007 19:09:51 +1000 (EST)
Received: from ubuntu (achn-4db49c99.pool.einsundeins.de [77.180.156.153])
	by post.webmailer.de (mrclete mo45) (RZmta 5.5)
	with ESMTP id F018f2j324vawA for <linuxppc-dev@ozlabs.org>;
	Mon, 2 Apr 2007 11:09:44 +0200 (MEST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] ppc: Add support for AMCC Katmai (440SPe) board
Date: Mon, 2 Apr 2007 11:10:59 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200704021110.59993.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds initial support for the AMCC 440SPe eval board Katmai.

Signed-off-by: Stefan Roese <sr@denx.de>

---
commit c0a317e96506a56d94c66d361d5488afe2ab17c7
tree bfc8cfbf8c87009ae859e4356a067da1683caec0
parent c268079210504e5c5a2ae94aa449aa244545ba22
author Stefan Roese <sr@denx.de> Mon, 02 Apr 2007 10:45:36 +0200
committer Stefan Roese <sr@denx.de> Mon, 02 Apr 2007 10:45:36 +0200

 arch/ppc/platforms/4xx/Kconfig  |   22 +-
 arch/ppc/platforms/4xx/Makefile |    3 
 arch/ppc/platforms/4xx/katmai.c |  525 +++++++++++++++++++++++++++++++++++++++
 arch/ppc/platforms/4xx/katmai.h |   68 +++++
 include/asm-ppc/ibm4xx.h        |   12 +
 5 files changed, 617 insertions(+), 13 deletions(-)

diff --git a/arch/ppc/platforms/4xx/Kconfig b/arch/ppc/platforms/4xx/Kconfig
index 705ae56..c61c031 100644
--- a/arch/ppc/platforms/4xx/Kconfig
+++ b/arch/ppc/platforms/4xx/Kconfig
@@ -80,17 +80,17 @@ config EBONY
 	help
 	  This option enables support for the IBM PPC440GP evaluation board.
 
-config LUAN
-	bool "Luan"
+config KATMAI
+	bool "Katmai"
 	select WANT_EARLY_SERIAL
 	help
-	  This option enables support for the IBM PPC440SP evaluation board.
+	  This option enables support for the AMCC PPC440SPe evaluation board.
 
-config YUCCA
-	bool "Yucca"
+config LUAN
+	bool "Luan"
 	select WANT_EARLY_SERIAL
 	help
-	  This option enables support for the AMCC PPC440SPe evaluation board.
+	  This option enables support for the IBM PPC440SP evaluation board.
 
 config OCOTEA
 	bool "Ocotea"
@@ -104,6 +104,12 @@ config TAISHAN
 	help
 	  This option enables support for the AMCC PPC440GX evaluation board.
 
+config YUCCA
+	bool "Yucca"
+	select WANT_EARLY_SERIAL
+	help
+	  This option enables support for the AMCC PPC440SPe evaluation board.
+
 endchoice
 
 config EP405PC
@@ -142,7 +148,7 @@ config 440SP
 
 config 440SPE
 	bool
-	depends on YUCCA
+	depends on KATMAI || YUCCA
 	default y
 
 config 440
@@ -179,7 +185,7 @@ config BOOKE
 
 config IBM_OCP
 	bool
-	depends on ASH || BAMBOO || BUBINGA || CPCI405 || EBONY || EP405 || LUAN || YUCCA || OCOTEA || REDWOOD_5 || REDWOOD_6 || SYCAMORE || TAISHAN || WALNUT
+	depends on ASH || BAMBOO || BUBINGA || CPCI405 || EBONY || EP405 || KATMAI || LUAN || OCOTEA || REDWOOD_5 || REDWOOD_6 || SYCAMORE || TAISHAN || WALNUT || YUCCA
 	default y
 
 config IBM_EMAC4
diff --git a/arch/ppc/platforms/4xx/Makefile b/arch/ppc/platforms/4xx/Makefile
index fa6610b..7e4ebeb 100644
--- a/arch/ppc/platforms/4xx/Makefile
+++ b/arch/ppc/platforms/4xx/Makefile
@@ -6,8 +6,8 @@ obj-$(CONFIG_CPCI405)		+= cpci405.o
 obj-$(CONFIG_EBONY)		+= ebony.o
 obj-$(CONFIG_EP405)		+= ep405.o
 obj-$(CONFIG_BUBINGA)		+= bubinga.o
+obj-$(CONFIG_KATMAI)		+= katmai.o
 obj-$(CONFIG_LUAN)		+= luan.o
-obj-$(CONFIG_YUCCA)		+= yucca.o
 obj-$(CONFIG_OCOTEA)		+= ocotea.o
 obj-$(CONFIG_REDWOOD_5)		+= redwood5.o
 obj-$(CONFIG_REDWOOD_6)		+= redwood6.o
@@ -16,6 +16,7 @@ obj-$(CONFIG_TAISHAN)		+= taishan.o
 obj-$(CONFIG_WALNUT)		+= walnut.o
 obj-$(CONFIG_XILINX_ML300)	+= xilinx_ml300.o
 obj-$(CONFIG_XILINX_ML403)	+= xilinx_ml403.o
+obj-$(CONFIG_YUCCA)		+= yucca.o
 
 obj-$(CONFIG_405GP)		+= ibm405gp.o
 obj-$(CONFIG_REDWOOD_5)		+= ibmstb4.o
diff --git a/arch/ppc/platforms/4xx/katmai.c b/arch/ppc/platforms/4xx/katmai.c
new file mode 100644
index 0000000..8a048e8
--- /dev/null
+++ b/arch/ppc/platforms/4xx/katmai.c
@@ -0,0 +1,525 @@
+/*
+ * Katmai board specific routines
+ *
+ * Copyright 2007 DENX Software Engineering, Stefan Roese <sr@denx.de>
+ *
+ * Based on yucca.c by Roland Dreier
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
+#include <linux/platform_device.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/ndfc.h>
+#include <linux/mtd/physmap.h>
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
+#include <asm/bootinfo.h>
+#include <asm/ppc4xx_pic.h>
+#include <asm/ppcboot.h>
+
+#include <syslib/ibm44x_common.h>
+#include <syslib/ibm440gx_common.h>
+#include <syslib/ibm440sp_common.h>
+#include <syslib/ppc440spe_pcie.h>
+
+extern bd_t __res;
+
+static struct ibm44x_clocks clocks __initdata;
+
+unsigned char ppc4xx_uic_ext_irq_cfg[] __initdata = {
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* IRQ15: EXT */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* IRQ14: EXT */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* IRQ13: EXT */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* IRQ12: PCI-X slot */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* IRQ11: EXT */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* IRQ10: EXT */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* IRQ9:  EXT */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* IRQ8:  EXT */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* IRQ7:  EXT */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* IRQ6:  EXT */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* IRQ5:  EXT */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* IRQ4:  Xilinx SysACE */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* IRQ3:  EXT */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* IRQ2:  EXT */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* IRQ1:  EXT */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* IRQ0:  EXT */
+};
+
+/*
+ * NOR FLASH configuration (using mtd physmap driver)
+ */
+
+/* start will be added dynamically, end is always fixed */
+static struct resource katmai_nor_resource = {
+	.flags = IORESOURCE_MEM,
+};
+
+#define RW_PART0_OF	0
+#define RW_PART0_SZ	0x180000
+#define RW_PART1_SZ	0x200000
+/* Partition 2 will be autosized dynamically... */
+#define RW_PART3_SZ	0x40000
+#define RW_PART4_SZ	0x40000
+
+static struct mtd_partition katmai_nor_parts[] = {
+	{
+		.name = "kernel",
+		.offset = 0,
+		.size = RW_PART0_SZ
+	},
+	{
+		.name = "root",
+		.offset = MTDPART_OFS_APPEND,
+		.size = RW_PART1_SZ,
+	},
+	{
+		.name = "user",
+		.offset = MTDPART_OFS_APPEND,
+	},
+	{
+		.name = "env",
+		.offset = MTDPART_OFS_APPEND,
+		.size = RW_PART3_SZ,
+	},
+	{
+		.name = "u-boot",
+		.offset = MTDPART_OFS_APPEND,
+		.size = RW_PART4_SZ,
+	}
+};
+
+static struct physmap_flash_data katmai_nor_data = {
+	.width		= 2,
+	.parts		= katmai_nor_parts,
+	.nr_parts	= ARRAY_SIZE(katmai_nor_parts),
+};
+
+static struct platform_device katmai_nor_device = {
+	.name		= "physmap-flash",
+	.id		= 0,
+	.dev = {
+			.platform_data = &katmai_nor_data,
+		},
+	.num_resources	= 1,
+	.resource	= &katmai_nor_resource,
+};
+
+static int katmai_setup_flash(void)
+{
+	katmai_nor_resource.start = __res.bi_flashstart;
+	katmai_nor_resource.end = __res.bi_flashstart +
+		__res.bi_flashsize - 1;
+
+	/*
+	 * Adjust partition 2 to flash size
+	 */
+	katmai_nor_parts[2].size = __res.bi_flashsize -
+		RW_PART0_SZ - RW_PART1_SZ - RW_PART3_SZ - RW_PART4_SZ;
+
+	platform_device_register(&katmai_nor_device);
+
+	return 0;
+}
+arch_initcall(katmai_setup_flash);
+
+static void __init
+katmai_calibrate_decr(void)
+{
+	unsigned int freq;
+
+	if (mfspr(SPRN_CCR1) & CCR1_TCS)
+		freq = KATMAI_TMR_CLK;
+	else
+		freq = clocks.cpu;
+
+	ibm44x_calibrate_decr(freq);
+}
+
+static int
+katmai_show_cpuinfo(struct seq_file *m)
+{
+	seq_printf(m, "vendor\t\t: AMCC\n");
+	seq_printf(m, "machine\t\t: PPC440SPe EVB (Katmai)\n");
+
+	return 0;
+}
+
+static void __init katmai_set_emacdata(void)
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
+enum katmai_hoses {
+	HOSE_PCIX,
+	HOSE_PCIE0,
+	HOSE_PCIE1,
+	HOSE_PCIE2,
+	HOSE_MAX
+};
+
+static enum katmai_hoses hose_type[4];
+
+#define is_pcix_hose(_hs_) ((_hs_) == HOSE_PCIX)
+#define is_pcie_hose(_hs_) (((_hs_) >= HOSE_PCIE0) && ((_hs_) <= HOSE_PCIE2))
+#define pcie_hose_num(_hs_) ((_hs_) - HOSE_PCIE0)
+
+#define PCIX_READW(offset)				\
+	(readw((void *)((u32)pcix_reg_base+offset)))
+
+#define PCIX_WRITEW(value, offset)				\
+	(writew(value, (void *)((u32)pcix_reg_base+offset)))
+
+#define PCIX_WRITEL(value, offset)				\
+	(writel(value, (void *)((u32)pcix_reg_base+offset)))
+
+static void __init
+ppc440spe_setup_pcix(struct pci_controller *hose)
+{
+	void *pcix_reg_base;
+
+	pcix_reg_base = ioremap64(PCIX0_REG_BASE, PCIX_REG_SIZE);
+
+	/* Disable all windows */
+	PCIX_WRITEL(0, PCIX0_POM0SA);
+	PCIX_WRITEL(0, PCIX0_POM1SA);
+	PCIX_WRITEL(0, PCIX0_POM2SA);
+	PCIX_WRITEL(0, PCIX0_PIM0SA);
+	PCIX_WRITEL(0, PCIX0_PIM0SAH);
+	PCIX_WRITEL(0, PCIX0_PIM1SA);
+	PCIX_WRITEL(0, PCIX0_PIM2SA);
+	PCIX_WRITEL(0, PCIX0_PIM2SAH);
+
+	/*
+	 * Setup 512MB PLB->PCI outbound mem window
+	 * (a_n000_0000->0_n000_0000)
+	 * */
+	PCIX_WRITEL(0x0000000d, PCIX0_POM0LAH);
+	PCIX_WRITEL(hose->mem_space.start, PCIX0_POM0LAL);
+	PCIX_WRITEL(0x00000000, PCIX0_POM0PCIAH);
+	PCIX_WRITEL(hose->mem_space.start, PCIX0_POM0PCIAL);
+	PCIX_WRITEL(~(hose->mem_space.end - hose->mem_space.start) | 1 ,
+		    PCIX0_POM0SA);
+
+	/* Setup 1GB PCI->PLB inbound memory window at 0, enable MSIs */
+	PCIX_WRITEL(0x00000000, PCIX0_PIM0LAH);
+	PCIX_WRITEL(0x00000000, PCIX0_PIM0LAL);
+	PCIX_WRITEL(0xc0000007, PCIX0_PIM0SA);
+	PCIX_WRITEL(0xffffffff, PCIX0_PIM0SAH);
+
+	/* Enable PCIX0 I/O, Mem, and Busmaster cycles */
+	PCIX_WRITEW(PCIX_READW(PCIX0_COMMAND) | PCI_COMMAND_MEMORY |
+		    PCI_COMMAND_MASTER, PCIX0_COMMAND);
+
+	iounmap(pcix_reg_base);
+	eieio();
+}
+
+static inline int
+katmai_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
+{
+	struct pci_controller *hose = pci_bus_to_hose(dev->bus->number);
+
+	if (hose_type[hose->index] == HOSE_PCIX) {
+		static char pci_irq_table[][4] =
+			/*
+			 *	PCI IDSEL/INTPIN->INTLINE
+			 *	  A   B   C   D
+			 */
+			{
+				{ 52, -1, -1, -1 },	/* IDSEL 1 - PCIX0 Slot 0 */
+			};
+		const long min_idsel = 1, max_idsel = 1, irqs_per_slot = 4;
+		return PCI_IRQ_TABLE_LOOKUP;
+	} else if (hose_type[hose->index] == HOSE_PCIE0) {
+		static char pci_irq_table[][4] =
+			/*
+			 *	PCI IDSEL/INTPIN->INTLINE
+			 *	  A   B   C   D
+			 */
+			{
+				{ 96, 97, 98, 99 },
+			};
+		const long min_idsel = 1, max_idsel = 1, irqs_per_slot = 4;
+		return PCI_IRQ_TABLE_LOOKUP;
+	} else if (hose_type[hose->index] == HOSE_PCIE1) {
+		static char pci_irq_table[][4] =
+			/*
+			 *	PCI IDSEL/INTPIN->INTLINE
+			 *	  A   B   C   D
+			 */
+			{
+				{ 100, 101, 102, 103 },
+			};
+		const long min_idsel = 1, max_idsel = 1, irqs_per_slot = 4;
+		return PCI_IRQ_TABLE_LOOKUP;
+	} else if (hose_type[hose->index] == HOSE_PCIE2) {
+		static char pci_irq_table[][4] =
+			/*
+			 *	PCI IDSEL/INTPIN->INTLINE
+			 *	  A   B   C   D
+			 */
+			{
+				{ 104, 105, 106, 107 },
+			};
+		const long min_idsel = 1, max_idsel = 1, irqs_per_slot = 4;
+		return PCI_IRQ_TABLE_LOOKUP;
+	}
+	return -1;
+}
+
+static int __init katmai_pcie_card_present(int port)
+{
+	u32 val;
+	void __iomem *gpio_base;
+
+	gpio_base = ioremap64(GPIO_BASE, 0x100);
+	val = in_be32(gpio_base + GPIO0_IR_OFFS);
+	iounmap(gpio_base);
+
+	switch (port) {
+	case 0:
+		return !(val & GPIO_VAL(CFG_GPIO_PCIE_PRESENT0));
+	case 1:
+		return !(val & GPIO_VAL(CFG_GPIO_PCIE_PRESENT1));
+	case 2:
+		return !(val & GPIO_VAL(CFG_GPIO_PCIE_PRESENT2));
+	default:
+		return 0;
+	}
+}
+
+static void __init
+katmai_setup_hoses(void)
+{
+	struct pci_controller *hose;
+	char name[20];
+ 	enum katmai_hoses hs;
+ 	int bus_no = 0;
+
+	for (hs = HOSE_PCIX; hs < HOSE_MAX; ++hs) {
+		if (is_pcie_hose(hs)) {
+			if (!katmai_pcie_card_present(pcie_hose_num(hs)))
+				continue;
+
+			pr_debug("PCIE%d: card present\n", pcie_hose_num(hs));
+
+			if (ppc440spe_init_pcie_root_or_endport(pcie_hose_num(hs))) {
+				printk(KERN_ERR "PCIE%d: initialization "
+				       "failed\n", pcie_hose_num(hs));
+				continue;
+			}
+		}
+
+		hose = pcibios_alloc_controller();
+		if (!hose)
+			return;
+
+		sprintf(name, "PCI%s%d host bridge",
+			is_pcix_hose(hs) ? "X" : "E",
+			is_pcie_hose(hs) ?  pcie_hose_num(hs) : 0
+			);
+
+		pci_init_resource(&hose->io_resource,
+				  KATMAI_PCIX_LOWER_IO, KATMAI_PCIX_UPPER_IO,
+				  IORESOURCE_IO, name);
+
+		if (is_pcix_hose(hs)) {
+			hose->mem_space.start = KATMAI_PCIX_LOWER_MEM;
+			hose->mem_space.end   = hose->mem_space.start +
+				KATMAI_PCIX_MEM_SIZE - 1;
+		} else {
+			hose->mem_space.start = KATMAI_PCIE_LOWER_MEM +
+				pcie_hose_num(hs) * KATMAI_PCIE_MEM_SIZE;
+			hose->mem_space.end   = hose->mem_space.start +
+				KATMAI_PCIE_MEM_SIZE - 1;
+		}
+
+		pci_init_resource(&hose->mem_resources[0],
+				  hose->mem_space.start,
+				  hose->mem_space.end,
+				  IORESOURCE_MEM,
+				  name);
+
+		hose->first_busno = bus_no;
+		hose->last_busno  = 0xFF;
+		hose_type[hose->index] = hs;
+
+		if (is_pcix_hose(hs)) {
+			hose->io_space.start = KATMAI_PCIX_LOWER_IO;
+			hose->io_space.end = KATMAI_PCIX_UPPER_IO;
+			isa_io_base =
+				(unsigned long)
+				ioremap64(PCIX0_IO_BASE, PCIX_IO_SIZE);
+			hose->io_base_virt = (void *)isa_io_base;
+
+			ppc440spe_setup_pcix(hose);
+
+			setup_indirect_pci(hose, PCIX0_CFGA, PCIX0_CFGD);
+			hose->set_cfg_type = 1;
+		} else {
+			if (ppc440spe_setup_pcie(hose, pcie_hose_num(hs)) != 0) {
+				printk(KERN_WARNING
+				       "PCIE setup failed for hose no %d\n",
+				       pcie_hose_num(hs));
+				continue;
+			}
+		}
+
+		hose->last_busno = pciauto_bus_scan(hose, hose->first_busno);
+		bus_no = hose->last_busno + 1;
+		pr_debug("%s: resources allocated\n", name);
+	}
+
+	ppc_md.pci_swizzle = common_swizzle;
+ 	ppc_md.pci_map_irq = katmai_map_irq;
+}
+
+static void __init
+katmai_early_serial_map(void)
+{
+	struct uart_port port;
+
+	/* Setup ioremapped serial port access */
+	memset(&port, 0, sizeof(port));
+	port.membase = ioremap64(PPC440SPE_UART0_ADDR, 8);
+	port.irq = UART0_INT;
+	port.uartclk = clocks.uart0;
+	port.regshift = 0;
+	port.iotype = UPIO_MEM;
+	port.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
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
+katmai_setup_arch(void)
+{
+	katmai_set_emacdata();
+
+#if !defined(CONFIG_BDI_SWITCH)
+	/*
+	 * The Abatron BDI JTAG debugger does not tolerate others
+	 * mucking with the debug registers.
+	 */
+	mtspr(SPRN_DBCR0, (DBCR0_TDE | DBCR0_IDM));
+#endif
+
+	/*
+	 * Determine various clocks.
+	 * To be completely correct we should get SysClk
+	 * from FPGA, because it can be changed by on-board switches
+	 * --ebs
+	 */
+	/* 440GX and 440SPe clocking is the same - rd */
+	ibm440gx_get_clocks(&clocks, 33333333, 6 * 1843200);
+	ocp_sys_info.opb_bus_freq = clocks.opb;
+
+	/* init to some ~sane value until calibrate_delay() runs */
+	loops_per_jiffy = 50000000/HZ;
+
+	/* Setup PCIXn host bridges */
+	katmai_setup_hoses();
+
+#ifdef CONFIG_BLK_DEV_INITRD
+	if (initrd_start)
+		ROOT_DEV = Root_RAM0;
+	else
+#endif
+#ifdef CONFIG_ROOT_NFS
+		ROOT_DEV = Root_NFS;
+#else
+	ROOT_DEV = Root_HDA1;
+#endif
+
+	katmai_early_serial_map();
+
+	/* Identify the system */
+	printk("AMCC PowerPC 440SPe Katmai Platform\n");
+}
+
+static void katmai_restart(char *cmd)
+{
+	local_irq_disable();
+	mtspr(SPRN_DBCR0, DBCR0_RST_CHIP);
+}
+
+void __init platform_init(unsigned long r3, unsigned long r4,
+			  unsigned long r5, unsigned long r6, unsigned long r7)
+{
+	ibm44x_platform_init(r3, r4, r5, r6, r7);
+
+	ppc_md.setup_arch = katmai_setup_arch;
+	ppc_md.show_cpuinfo = katmai_show_cpuinfo;
+	ppc_md.find_end_of_memory = ibm440sp_find_end_of_memory;
+	ppc_md.get_irq = NULL;		/* Set in ppc4xx_pic_init() */
+
+	ppc_md.calibrate_decr = katmai_calibrate_decr;
+#ifdef CONFIG_KGDB
+	ppc_md.early_serial_map = katmai_early_serial_map;
+#endif
+	ppc_md.restart = katmai_restart;
+}
diff --git a/arch/ppc/platforms/4xx/katmai.h b/arch/ppc/platforms/4xx/katmai.h
new file mode 100644
index 0000000..f1ad993
--- /dev/null
+++ b/arch/ppc/platforms/4xx/katmai.h
@@ -0,0 +1,68 @@
+/*
+ * Katmai board definitions
+ *
+ * Copyright 2007 DENX Software Engineering, Stefan Roese <sr@denx.de>
+ *
+ * Based on yucca.h by Roland Dreier
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
+#ifndef __ASM_KATMAI_H__
+#define __ASM_KATMAI_H__
+
+#include <platforms/4xx/ppc440spe.h>
+
+/* External timer clock frequency */
+#define KATMAI_TMR_CLK		25000000
+
+#define GPIO_VAL(gpio)		(0x80000000 >> (gpio))
+#define CFG_GPIO_PCIE_PRESENT0	17
+#define CFG_GPIO_PCIE_PRESENT1	21
+#define CFG_GPIO_PCIE_PRESENT2	23
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
+		iomem_base: (void*)UART##num##_IO_BASE,		\
+		io_type: SERIAL_IO_MEM},
+
+#define SERIAL_PORT_DFNS	\
+	STD_UART_OP(0)		\
+	STD_UART_OP(1)		\
+	STD_UART_OP(2)
+
+/* PCI support */
+#define KATMAI_PCIX_LOWER_IO	0x00000000
+#define KATMAI_PCIX_UPPER_IO	0x0000ffff
+#define KATMAI_PCIX_LOWER_MEM	0x80000000
+#define KATMAI_PCIX_UPPER_MEM	0x8fffffff
+#define KATMAI_PCIX_MEM_SIZE	0x10000000
+#define KATMAI_PCIX_MEM_OFFSET	0x00000000
+
+#define KATMAI_PCIE_LOWER_MEM	0x90000000
+#define KATMAI_PCIE_MEM_SIZE	0x10000000
+#define BOARD_PCIE_MEM_SIZE	KATMAI_PCIE_MEM_SIZE	/* used in syslib/ppc440spe_pcie.c */
+#define KATMAI_PCIE_MEM_OFFSET	0x00000000
+
+#endif				/* __ASM_KATMAI_H__ */
+#endif				/* __KERNEL__ */
diff --git a/include/asm-ppc/ibm4xx.h b/include/asm-ppc/ibm4xx.h
index 92fd02d..4ba6087 100644
--- a/include/asm-ppc/ibm4xx.h
+++ b/include/asm-ppc/ibm4xx.h
@@ -97,12 +97,12 @@ void ppc4xx_init(unsigned long r3, unsigned long r4, unsigned long r5,
 #include <platforms/4xx/ebony.h>
 #endif
 
-#if defined(CONFIG_LUAN)
-#include <platforms/4xx/luan.h>
+#if defined(CONFIG_KATMAI)
+#include <platforms/4xx/katmai.h>
 #endif
 
-#if defined(CONFIG_YUCCA)
-#include <platforms/4xx/yucca.h>
+#if defined(CONFIG_LUAN)
+#include <platforms/4xx/luan.h>
 #endif
 
 #if defined(CONFIG_OCOTEA)
@@ -113,6 +113,10 @@ void ppc4xx_init(unsigned long r3, unsigned long r4, unsigned long r5,
 #include <platforms/4xx/taishan.h>
 #endif
 
+#if defined(CONFIG_YUCCA)
+#include <platforms/4xx/yucca.h>
+#endif
+
 #ifndef __ASSEMBLY__
 #ifdef CONFIG_40x
 /*
