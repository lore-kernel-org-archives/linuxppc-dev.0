Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7B5B3DDE3B
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 01:51:30 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l6AFpKVb028698
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 08:51:21 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6AFpI7x008024
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 10:51:19 -0500 (CDT)
Subject: [patch 1/6] Create common fsl pci/e files based on 86xx platform
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Message-Id: <1184082665.20129.179.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 10 Jul 2007 23:51:06 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Roy Zang <tie-fei.zang@freescale.com>

Move
arch/powerpc/platforms/86xx/pci.c -> arch/powerpc/sysdev/fsl_pci.c
arch/powerpc/sysdev/fsl_pcie.h -> arch/powerpc/sysdev/fsl_pci.h
as the base to unify 83xx/85xx/86xx pci and pcie.

Add CONFIG_FSL_PCI to build fsl_pci.c for Freescale pci and pcie option.
The code is still work for 86xx platform.

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
 arch/powerpc/Kconfig                 |    4 +
 arch/powerpc/platforms/86xx/Kconfig  |    1 +
 arch/powerpc/platforms/86xx/Makefile |    1 -
 arch/powerpc/platforms/86xx/pci.c    |  238 ----------------------------------
 arch/powerpc/sysdev/Makefile         |    1 +
 arch/powerpc/sysdev/fsl_pci.c        |  238 ++++++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/fsl_pci.h        |   94 +++++++++++++
 arch/powerpc/sysdev/fsl_pcie.h       |   94 -------------
 8 files changed, 338 insertions(+), 333 deletions(-)
 delete mode 100644 arch/powerpc/platforms/86xx/pci.c
 create mode 100644 arch/powerpc/sysdev/fsl_pci.c
 create mode 100644 arch/powerpc/sysdev/fsl_pci.h
 delete mode 100644 arch/powerpc/sysdev/fsl_pcie.h

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index cbfbd98..8c780bf 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -419,6 +419,10 @@ config SBUS
 config FSL_SOC
 	bool
 
+config FSL_PCI
+ 	bool
+	depends on PPC_86xx
+
 # Yes MCA RS/6000s exist but Linux-PPC does not currently support any
 config MCA
 	bool
diff --git a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/platforms/86xx/Kconfig
index 0faebfd..c848173 100644
--- a/arch/powerpc/platforms/86xx/Kconfig
+++ b/arch/powerpc/platforms/86xx/Kconfig
@@ -16,6 +16,7 @@ config MPC8641
 	bool
 	select PPC_INDIRECT_PCI
 	select PPC_INDIRECT_PCI_BE
+	select FSL_PCI
 	select PPC_UDBG_16550
 	select MPIC
 	default y if MPC8641_HPCN
diff --git a/arch/powerpc/platforms/86xx/Makefile b/arch/powerpc/platforms/86xx/Makefile
index 418fd8f..3376c77 100644
--- a/arch/powerpc/platforms/86xx/Makefile
+++ b/arch/powerpc/platforms/86xx/Makefile
@@ -4,4 +4,3 @@
 
 obj-$(CONFIG_SMP)		+= mpc86xx_smp.o
 obj-$(CONFIG_MPC8641_HPCN)	+= mpc86xx_hpcn.o
-obj-$(CONFIG_PCI)		+= pci.o
diff --git a/arch/powerpc/platforms/86xx/pci.c b/arch/powerpc/platforms/86xx/pci.c
deleted file mode 100644
index 73cd5b0..0000000
--- a/arch/powerpc/platforms/86xx/pci.c
+++ /dev/null
@@ -1,238 +0,0 @@
-/*
- * MPC86XX pci setup code
- *
- * Recode: ZHANG WEI <wei.zhang@freescale.com>
- * Initial author: Xianghua Xiao <x.xiao@freescale.com>
- *
- * Copyright 2006 Freescale Semiconductor Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include <linux/types.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/pci.h>
-#include <linux/serial.h>
-
-#include <asm/system.h>
-#include <asm/atomic.h>
-#include <asm/io.h>
-#include <asm/prom.h>
-#include <asm/pci-bridge.h>
-#include <sysdev/fsl_soc.h>
-#include <sysdev/fsl_pcie.h>
-
-#include "mpc86xx.h"
-
-#undef DEBUG
-
-#ifdef DEBUG
-#define DBG(fmt, args...) printk(KERN_ERR "%s: " fmt, __FUNCTION__, ## args)
-#else
-#define DBG(fmt, args...)
-#endif
-
-struct pcie_outbound_window_regs {
-	uint    pexotar;               /* 0x.0 - PCI Express outbound translation address register */
-	uint    pexotear;              /* 0x.4 - PCI Express outbound translation extended address register */
-	uint    pexowbar;              /* 0x.8 - PCI Express outbound window base address register */
-	char    res1[4];
-	uint    pexowar;               /* 0x.10 - PCI Express outbound window attributes register */
-	char    res2[12];
-};
-
-struct pcie_inbound_window_regs {
-	uint    pexitar;               /* 0x.0 - PCI Express inbound translation address register */
-	char    res1[4];
-	uint    pexiwbar;              /* 0x.8 - PCI Express inbound window base address register */
-	uint    pexiwbear;             /* 0x.c - PCI Express inbound window base extended address register */
-	uint    pexiwar;               /* 0x.10 - PCI Express inbound window attributes register */
-	char    res2[12];
-};
-
-static void __init setup_pcie_atmu(struct pci_controller *hose, struct resource *rsrc)
-{
-	volatile struct ccsr_pex *pcie;
-	volatile struct pcie_outbound_window_regs *pcieow;
-	volatile struct pcie_inbound_window_regs *pcieiw;
-	int i = 0;
-
-	DBG("PCIE memory map start 0x%x, size 0x%x\n", rsrc->start,
-			rsrc->end - rsrc->start + 1);
-	pcie = ioremap(rsrc->start, rsrc->end - rsrc->start + 1);
-
-	/* Disable all windows (except pexowar0 since its ignored) */
-	pcie->pexowar1 = 0;
-	pcie->pexowar2 = 0;
- 	pcie->pexowar3 = 0;
- 	pcie->pexowar4 = 0;
- 	pcie->pexiwar1 = 0;
- 	pcie->pexiwar2 = 0;
- 	pcie->pexiwar3 = 0;
-
- 	pcieow = (struct pcie_outbound_window_regs *)&pcie->pexotar1;
- 	pcieiw = (struct pcie_inbound_window_regs *)&pcie->pexitar1;
-
- 	/* Setup outbound MEM window */
- 	for(i = 0; i < 3; i++)
- 		if (hose->mem_resources[i].flags & IORESOURCE_MEM){
- 			DBG("PCIE MEM resource start 0x%08x, size 0x%08x.\n",
- 				hose->mem_resources[i].start,
- 				hose->mem_resources[i].end
- 				  - hose->mem_resources[i].start + 1);
- 			pcieow->pexotar = (hose->mem_resources[i].start) >> 12
- 				& 0x000fffff;
- 			pcieow->pexotear = 0;
- 			pcieow->pexowbar = (hose->mem_resources[i].start) >> 12
- 				& 0x000fffff;
- 			/* Enable, Mem R/W */
- 			pcieow->pexowar = 0x80044000 |
- 				(__ilog2(hose->mem_resources[i].end
- 					 - hose->mem_resources[i].start + 1)
- 				 - 1);
- 			pcieow++;
- 		}
-
- 	/* Setup outbound IO window */
- 	if (hose->io_resource.flags & IORESOURCE_IO){
- 		DBG("PCIE IO resource start 0x%08x, size 0x%08x, phy base 0x%08x.\n",
- 			hose->io_resource.start,
- 			hose->io_resource.end - hose->io_resource.start + 1,
- 			hose->io_base_phys);
- 		pcieow->pexotar = (hose->io_resource.start) >> 12 & 0x000fffff;
- 		pcieow->pexotear = 0;
- 		pcieow->pexowbar = (hose->io_base_phys) >> 12 & 0x000fffff;
- 		/* Enable, IO R/W */
- 		pcieow->pexowar = 0x80088000 | (__ilog2(hose->io_resource.end
- 					- hose->io_resource.start + 1) - 1);
- 	}
-
- 	/* Setup 2G inbound Memory Window @ 0 */
- 	pcieiw->pexitar = 0x00000000;
- 	pcieiw->pexiwbar = 0x00000000;
- 	/* Enable, Prefetch, Local Mem, Snoop R/W, 2G */
- 	pcieiw->pexiwar = 0xa0f5501e;
-}
-
-static void __init
-mpc86xx_setup_pcie(struct pci_controller *hose, u32 pcie_offset, u32 pcie_size)
-{
-	u16 cmd;
-
-	DBG("PCIE host controller register offset 0x%08x, size 0x%08x.\n",
-			pcie_offset, pcie_size);
-
-	early_read_config_word(hose, 0, 0, PCI_COMMAND, &cmd);
-	cmd |= PCI_COMMAND_SERR | PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY
-	    | PCI_COMMAND_IO;
-	early_write_config_word(hose, 0, 0, PCI_COMMAND, cmd);
-
-	early_write_config_byte(hose, 0, 0, PCI_LATENCY_TIMER, 0x80);
-}
-
-static void __devinit quirk_fsl_pcie_transparent(struct pci_dev *dev)
-{
-	struct resource *res;
-	int i, res_idx = PCI_BRIDGE_RESOURCES;
-	struct pci_controller *hose;
-
-	/*
-	 * Make the bridge be transparent.
-	 */
-	dev->transparent = 1;
-
-	hose = pci_bus_to_host(dev->bus);
-	if (!hose) {
-		printk(KERN_ERR "Can't find hose for bus %d\n",
-		       dev->bus->number);
-		return;
-	}
-
-	if (hose->io_resource.flags) {
-		res = &dev->resource[res_idx++];
-		res->start = hose->io_resource.start;
-		res->end = hose->io_resource.end;
-		res->flags = hose->io_resource.flags;
-	}
-
-	for (i = 0; i < 3; i++) {
-		res = &dev->resource[res_idx + i];
-		res->start = hose->mem_resources[i].start;
-		res->end = hose->mem_resources[i].end;
-		res->flags = hose->mem_resources[i].flags;
-	}
-}
-
-
-DECLARE_PCI_FIXUP_EARLY(0x1957, 0x7010, quirk_fsl_pcie_transparent);
-DECLARE_PCI_FIXUP_EARLY(0x1957, 0x7011, quirk_fsl_pcie_transparent);
-
-#define PCIE_LTSSM	0x404	/* PCIe Link Training and Status */
-#define PCIE_LTSSM_L0	0x16	/* L0 state */
-
-int __init mpc86xx_add_bridge(struct device_node *dev)
-{
-	int len;
-	struct pci_controller *hose;
-	struct resource rsrc;
-	const int *bus_range;
-	int has_address = 0;
-	int primary = 0;
-	u16 val;
-
-	DBG("Adding PCIE host bridge %s\n", dev->full_name);
-
-	/* Fetch host bridge registers address */
-	has_address = (of_address_to_resource(dev, 0, &rsrc) == 0);
-
-	/* Get bus range if any */
-	bus_range = of_get_property(dev, "bus-range", &len);
-	if (bus_range == NULL || len < 2 * sizeof(int))
-		printk(KERN_WARNING "Can't get bus-range for %s, assume"
-		       " bus 0\n", dev->full_name);
-
-	pci_assign_all_buses = 1;
-	hose = pcibios_alloc_controller(dev);
-	if (!hose)
-		return -ENOMEM;
-
-	hose->indirect_type = PPC_INDIRECT_TYPE_EXT_REG |
-				PPC_INDIRECT_TYPE_SURPRESS_PRIMARY_BUS;
-
-	hose->first_busno = bus_range ? bus_range[0] : 0x0;
-	hose->last_busno = bus_range ? bus_range[1] : 0xff;
-
-	setup_indirect_pci(hose, rsrc.start, rsrc.start + 0x4);
-
-	/* Probe the hose link training status */
-	early_read_config_word(hose, 0, 0, PCIE_LTSSM, &val);
-	if (val < PCIE_LTSSM_L0)
-		return -ENXIO;
-
-	/* Setup the PCIE host controller. */
-	mpc86xx_setup_pcie(hose, rsrc.start, rsrc.end - rsrc.start + 1);
-
-	if ((rsrc.start & 0xfffff) == 0x8000)
-		primary = 1;
-
-	printk(KERN_INFO "Found MPC86xx PCIE host bridge at 0x%08lx. "
-	       "Firmware bus number: %d->%d\n",
-	       (unsigned long) rsrc.start,
-	       hose->first_busno, hose->last_busno);
-
-	DBG(" ->Hose at 0x%p, cfg_addr=0x%p,cfg_data=0x%p\n",
-		hose, hose->cfg_addr, hose->cfg_data);
-
-	/* Interpret the "ranges" property */
-	/* This also maps the I/O region and sets isa_io/mem_base */
-	pci_process_bridge_OF_ranges(hose, dev, primary);
-
-	/* Setup PEX window registers */
-	setup_pcie_atmu(hose, &rsrc);
-
-	return 0;
-}
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 7d8ac1b..0a9ae95 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_PPC_PMI)		+= pmi.o
 obj-$(CONFIG_U3_DART)		+= dart_iommu.o
 obj-$(CONFIG_MMIO_NVRAM)	+= mmio_nvram.o
 obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
+obj-$(CONFIG_FSL_PCI)		+= fsl_pci.o
 obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o
 obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
 mv64x60-$(CONFIG_PCI)		+= mv64x60_pci.o
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
new file mode 100644
index 0000000..24ba1b6
--- /dev/null
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -0,0 +1,238 @@
+/*
+ * MPC86XX pci setup code
+ *
+ * Recode: ZHANG WEI <wei.zhang@freescale.com>
+ * Initial author: Xianghua Xiao <x.xiao@freescale.com>
+ *
+ * Copyright 2006 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/serial.h>
+
+#include <asm/system.h>
+#include <asm/atomic.h>
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <asm/pci-bridge.h>
+#include <sysdev/fsl_soc.h>
+#include <sysdev/fsl_pci.h>
+
+#include "../platforms/86xx/mpc86xx.h"
+
+#undef DEBUG
+
+#ifdef DEBUG
+#define DBG(fmt, args...) printk(KERN_ERR "%s: " fmt, __FUNCTION__, ## args)
+#else
+#define DBG(fmt, args...)
+#endif
+
+struct pcie_outbound_window_regs {
+	uint    pexotar;               /* 0x.0 - PCI Express outbound translation address register */
+	uint    pexotear;              /* 0x.4 - PCI Express outbound translation extended address register */
+	uint    pexowbar;              /* 0x.8 - PCI Express outbound window base address register */
+	char    res1[4];
+	uint    pexowar;               /* 0x.10 - PCI Express outbound window attributes register */
+	char    res2[12];
+};
+
+struct pcie_inbound_window_regs {
+	uint    pexitar;               /* 0x.0 - PCI Express inbound translation address register */
+	char    res1[4];
+	uint    pexiwbar;              /* 0x.8 - PCI Express inbound window base address register */
+	uint    pexiwbear;             /* 0x.c - PCI Express inbound window base extended address register */
+	uint    pexiwar;               /* 0x.10 - PCI Express inbound window attributes register */
+	char    res2[12];
+};
+
+static void __init setup_pcie_atmu(struct pci_controller *hose, struct resource *rsrc)
+{
+	volatile struct ccsr_pex *pcie;
+	volatile struct pcie_outbound_window_regs *pcieow;
+	volatile struct pcie_inbound_window_regs *pcieiw;
+	int i = 0;
+
+	DBG("PCIE memory map start 0x%x, size 0x%x\n", rsrc->start,
+			rsrc->end - rsrc->start + 1);
+	pcie = ioremap(rsrc->start, rsrc->end - rsrc->start + 1);
+
+	/* Disable all windows (except pexowar0 since its ignored) */
+	pcie->pexowar1 = 0;
+	pcie->pexowar2 = 0;
+ 	pcie->pexowar3 = 0;
+ 	pcie->pexowar4 = 0;
+ 	pcie->pexiwar1 = 0;
+ 	pcie->pexiwar2 = 0;
+ 	pcie->pexiwar3 = 0;
+
+ 	pcieow = (struct pcie_outbound_window_regs *)&pcie->pexotar1;
+ 	pcieiw = (struct pcie_inbound_window_regs *)&pcie->pexitar1;
+
+ 	/* Setup outbound MEM window */
+ 	for(i = 0; i < 3; i++)
+ 		if (hose->mem_resources[i].flags & IORESOURCE_MEM){
+ 			DBG("PCIE MEM resource start 0x%08x, size 0x%08x.\n",
+ 				hose->mem_resources[i].start,
+ 				hose->mem_resources[i].end
+ 				  - hose->mem_resources[i].start + 1);
+ 			pcieow->pexotar = (hose->mem_resources[i].start) >> 12
+ 				& 0x000fffff;
+ 			pcieow->pexotear = 0;
+ 			pcieow->pexowbar = (hose->mem_resources[i].start) >> 12
+ 				& 0x000fffff;
+ 			/* Enable, Mem R/W */
+ 			pcieow->pexowar = 0x80044000 |
+ 				(__ilog2(hose->mem_resources[i].end
+ 					 - hose->mem_resources[i].start + 1)
+ 				 - 1);
+ 			pcieow++;
+ 		}
+
+ 	/* Setup outbound IO window */
+ 	if (hose->io_resource.flags & IORESOURCE_IO){
+ 		DBG("PCIE IO resource start 0x%08x, size 0x%08x, phy base 0x%08x.\n",
+ 			hose->io_resource.start,
+ 			hose->io_resource.end - hose->io_resource.start + 1,
+ 			hose->io_base_phys);
+ 		pcieow->pexotar = (hose->io_resource.start) >> 12 & 0x000fffff;
+ 		pcieow->pexotear = 0;
+ 		pcieow->pexowbar = (hose->io_base_phys) >> 12 & 0x000fffff;
+ 		/* Enable, IO R/W */
+ 		pcieow->pexowar = 0x80088000 | (__ilog2(hose->io_resource.end
+ 					- hose->io_resource.start + 1) - 1);
+ 	}
+
+ 	/* Setup 2G inbound Memory Window @ 0 */
+ 	pcieiw->pexitar = 0x00000000;
+ 	pcieiw->pexiwbar = 0x00000000;
+ 	/* Enable, Prefetch, Local Mem, Snoop R/W, 2G */
+ 	pcieiw->pexiwar = 0xa0f5501e;
+}
+
+static void __init
+mpc86xx_setup_pcie(struct pci_controller *hose, u32 pcie_offset, u32 pcie_size)
+{
+	u16 cmd;
+
+	DBG("PCIE host controller register offset 0x%08x, size 0x%08x.\n",
+			pcie_offset, pcie_size);
+
+	early_read_config_word(hose, 0, 0, PCI_COMMAND, &cmd);
+	cmd |= PCI_COMMAND_SERR | PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY
+	    | PCI_COMMAND_IO;
+	early_write_config_word(hose, 0, 0, PCI_COMMAND, cmd);
+
+	early_write_config_byte(hose, 0, 0, PCI_LATENCY_TIMER, 0x80);
+}
+
+static void __devinit quirk_fsl_pcie_transparent(struct pci_dev *dev)
+{
+	struct resource *res;
+	int i, res_idx = PCI_BRIDGE_RESOURCES;
+	struct pci_controller *hose;
+
+	/*
+	 * Make the bridge be transparent.
+	 */
+	dev->transparent = 1;
+
+	hose = pci_bus_to_host(dev->bus);
+	if (!hose) {
+		printk(KERN_ERR "Can't find hose for bus %d\n",
+		       dev->bus->number);
+		return;
+	}
+
+	if (hose->io_resource.flags) {
+		res = &dev->resource[res_idx++];
+		res->start = hose->io_resource.start;
+		res->end = hose->io_resource.end;
+		res->flags = hose->io_resource.flags;
+	}
+
+	for (i = 0; i < 3; i++) {
+		res = &dev->resource[res_idx + i];
+		res->start = hose->mem_resources[i].start;
+		res->end = hose->mem_resources[i].end;
+		res->flags = hose->mem_resources[i].flags;
+	}
+}
+
+
+DECLARE_PCI_FIXUP_EARLY(0x1957, 0x7010, quirk_fsl_pcie_transparent);
+DECLARE_PCI_FIXUP_EARLY(0x1957, 0x7011, quirk_fsl_pcie_transparent);
+
+#define PCIE_LTSSM	0x404	/* PCIe Link Training and Status */
+#define PCIE_LTSSM_L0	0x16	/* L0 state */
+
+int __init mpc86xx_add_bridge(struct device_node *dev)
+{
+	int len;
+	struct pci_controller *hose;
+	struct resource rsrc;
+	const int *bus_range;
+	int has_address = 0;
+	int primary = 0;
+	u16 val;
+
+	DBG("Adding PCIE host bridge %s\n", dev->full_name);
+
+	/* Fetch host bridge registers address */
+	has_address = (of_address_to_resource(dev, 0, &rsrc) == 0);
+
+	/* Get bus range if any */
+	bus_range = of_get_property(dev, "bus-range", &len);
+	if (bus_range == NULL || len < 2 * sizeof(int))
+		printk(KERN_WARNING "Can't get bus-range for %s, assume"
+		       " bus 0\n", dev->full_name);
+
+	pci_assign_all_buses = 1;
+	hose = pcibios_alloc_controller(dev);
+	if (!hose)
+		return -ENOMEM;
+
+	hose->indirect_type = PPC_INDIRECT_TYPE_EXT_REG |
+				PPC_INDIRECT_TYPE_SURPRESS_PRIMARY_BUS;
+
+	hose->first_busno = bus_range ? bus_range[0] : 0x0;
+	hose->last_busno = bus_range ? bus_range[1] : 0xff;
+
+	setup_indirect_pci(hose, rsrc.start, rsrc.start + 0x4);
+
+	/* Probe the hose link training status */
+	early_read_config_word(hose, 0, 0, PCIE_LTSSM, &val);
+	if (val < PCIE_LTSSM_L0)
+		return -ENXIO;
+
+	/* Setup the PCIE host controller. */
+	mpc86xx_setup_pcie(hose, rsrc.start, rsrc.end - rsrc.start + 1);
+
+	if ((rsrc.start & 0xfffff) == 0x8000)
+		primary = 1;
+
+	printk(KERN_INFO "Found MPC86xx PCIE host bridge at 0x%08lx. "
+	       "Firmware bus number: %d->%d\n",
+	       (unsigned long) rsrc.start,
+	       hose->first_busno, hose->last_busno);
+
+	DBG(" ->Hose at 0x%p, cfg_addr=0x%p,cfg_data=0x%p\n",
+		hose, hose->cfg_addr, hose->cfg_data);
+
+	/* Interpret the "ranges" property */
+	/* This also maps the I/O region and sets isa_io/mem_base */
+	pci_process_bridge_OF_ranges(hose, dev, primary);
+
+	/* Setup PEX window registers */
+	setup_pcie_atmu(hose, &rsrc);
+
+	return 0;
+}
diff --git a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h
new file mode 100644
index 0000000..8d9779c
--- /dev/null
+++ b/arch/powerpc/sysdev/fsl_pci.h
@@ -0,0 +1,94 @@
+/*
+ * MPC85xx/86xx PCI Express structure define
+ *
+ * Copyright 2007 Freescale Semiconductor, Inc
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+#ifdef __KERNEL__
+#ifndef __POWERPC_FSL_PCIE_H
+#define __POWERPC_FSL_PCIE_H
+
+/* PCIE Express IO block registers in 85xx/86xx */
+
+struct ccsr_pex {
+	__be32 __iomem    pex_config_addr;	/* 0x.000 - PCI Express Configuration Address Register */
+	__be32 __iomem    pex_config_data;	/* 0x.004 - PCI Express Configuration Data Register */
+	u8 __iomem    res1[4];
+	__be32 __iomem    pex_otb_cpl_tor;	/* 0x.00c - PCI Express Outbound completion timeout register */
+	__be32 __iomem    pex_conf_tor;		/* 0x.010 - PCI Express configuration timeout register */
+	u8 __iomem    res2[12];
+	__be32 __iomem    pex_pme_mes_dr;	/* 0x.020 - PCI Express PME and message detect register */
+	__be32 __iomem    pex_pme_mes_disr;	/* 0x.024 - PCI Express PME and message disable register */
+	__be32 __iomem    pex_pme_mes_ier;	/* 0x.028 - PCI Express PME and message interrupt enable register */
+	__be32 __iomem    pex_pmcr;		/* 0x.02c - PCI Express power management command register */
+	u8 __iomem    res3[3024];
+	__be32 __iomem    pexotar0;		/* 0x.c00 - PCI Express outbound translation address register 0 */
+	__be32 __iomem    pexotear0;		/* 0x.c04 - PCI Express outbound translation extended address register 0*/
+	u8 __iomem    res4[8];
+	__be32 __iomem    pexowar0;		/* 0x.c10 - PCI Express outbound window attributes register 0*/
+	u8 __iomem    res5[12];
+	__be32 __iomem    pexotar1;		/* 0x.c20 - PCI Express outbound translation address register 1 */
+	__be32 __iomem    pexotear1;		/* 0x.c24 - PCI Express outbound translation extended address register 1*/
+	__be32 __iomem    pexowbar1;		/* 0x.c28 - PCI Express outbound window base address register 1*/
+	u8 __iomem    res6[4];
+	__be32 __iomem    pexowar1;		/* 0x.c30 - PCI Express outbound window attributes register 1*/
+	u8 __iomem    res7[12];
+	__be32 __iomem    pexotar2;		/* 0x.c40 - PCI Express outbound translation address register 2 */
+	__be32 __iomem    pexotear2;		/* 0x.c44 - PCI Express outbound translation extended address register 2*/
+	__be32 __iomem    pexowbar2;		/* 0x.c48 - PCI Express outbound window base address register 2*/
+	u8 __iomem    res8[4];
+	__be32 __iomem    pexowar2;		/* 0x.c50 - PCI Express outbound window attributes register 2*/
+	u8 __iomem    res9[12];
+	__be32 __iomem    pexotar3;		/* 0x.c60 - PCI Express outbound translation address register 3 */
+	__be32 __iomem    pexotear3;		/* 0x.c64 - PCI Express outbound translation extended address register 3*/
+	__be32 __iomem    pexowbar3;		/* 0x.c68 - PCI Express outbound window base address register 3*/
+	u8 __iomem    res10[4];
+	__be32 __iomem    pexowar3;		/* 0x.c70 - PCI Express outbound window attributes register 3*/
+	u8 __iomem    res11[12];
+	__be32 __iomem    pexotar4;		/* 0x.c80 - PCI Express outbound translation address register 4 */
+	__be32 __iomem    pexotear4;		/* 0x.c84 - PCI Express outbound translation extended address register 4*/
+	__be32 __iomem    pexowbar4;		/* 0x.c88 - PCI Express outbound window base address register 4*/
+	u8 __iomem    res12[4];
+	__be32 __iomem    pexowar4;		/* 0x.c90 - PCI Express outbound window attributes register 4*/
+	u8 __iomem    res13[12];
+	u8 __iomem    res14[256];
+	__be32 __iomem    pexitar3;		/* 0x.da0 - PCI Express inbound translation address register 3 */
+	u8 __iomem    res15[4];
+	__be32 __iomem    pexiwbar3;		/* 0x.da8 - PCI Express inbound window base address register 3 */
+	__be32 __iomem    pexiwbear3;		/* 0x.dac - PCI Express inbound window base extended address register 3 */
+	__be32 __iomem    pexiwar3;		/* 0x.db0 - PCI Express inbound window attributes register 3 */
+	u8 __iomem    res16[12];
+	__be32 __iomem    pexitar2;		/* 0x.dc0 - PCI Express inbound translation address register 2 */
+	u8 __iomem    res17[4];
+	__be32 __iomem    pexiwbar2;		/* 0x.dc8 - PCI Express inbound window base address register 2 */
+	__be32 __iomem    pexiwbear2;		/* 0x.dcc - PCI Express inbound window base extended address register 2 */
+	__be32 __iomem    pexiwar2;		/* 0x.dd0 - PCI Express inbound window attributes register 2 */
+	u8 __iomem    res18[12];
+	__be32 __iomem    pexitar1;		/* 0x.de0 - PCI Express inbound translation address register 2 */
+	u8 __iomem    res19[4];
+	__be32 __iomem    pexiwbar1;		/* 0x.de8 - PCI Express inbound window base address register 2 */
+	__be32 __iomem    pexiwbear1;		/* 0x.dec - PCI Express inbound window base extended address register 2 */
+	__be32 __iomem    pexiwar1;		/* 0x.df0 - PCI Express inbound window attributes register 2 */
+	u8 __iomem    res20[12];
+	__be32 __iomem    pex_err_dr;		/* 0x.e00 - PCI Express error detect register */
+	u8 __iomem    res21[4];
+	__be32 __iomem    pex_err_en;		/* 0x.e08 - PCI Express error interrupt enable register */
+	u8 __iomem    res22[4];
+	__be32 __iomem    pex_err_disr;		/* 0x.e10 - PCI Express error disable register */
+	u8 __iomem    res23[12];
+	__be32 __iomem    pex_err_cap_stat;	/* 0x.e20 - PCI Express error capture status register */
+	u8 __iomem    res24[4];
+	__be32 __iomem    pex_err_cap_r0;	/* 0x.e28 - PCI Express error capture register 0 */
+	__be32 __iomem    pex_err_cap_r1;	/* 0x.e2c - PCI Express error capture register 0 */
+	__be32 __iomem    pex_err_cap_r2;	/* 0x.e30 - PCI Express error capture register 0 */
+	__be32 __iomem    pex_err_cap_r3;	/* 0x.e34 - PCI Express error capture register 0 */
+};
+
+#endif /* __POWERPC_FSL_PCIE_H */
+#endif /* __KERNEL__ */
diff --git a/arch/powerpc/sysdev/fsl_pcie.h b/arch/powerpc/sysdev/fsl_pcie.h
deleted file mode 100644
index 8d9779c..0000000
--- a/arch/powerpc/sysdev/fsl_pcie.h
+++ /dev/null
@@ -1,94 +0,0 @@
-/*
- * MPC85xx/86xx PCI Express structure define
- *
- * Copyright 2007 Freescale Semiconductor, Inc
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- *
- */
-
-#ifdef __KERNEL__
-#ifndef __POWERPC_FSL_PCIE_H
-#define __POWERPC_FSL_PCIE_H
-
-/* PCIE Express IO block registers in 85xx/86xx */
-
-struct ccsr_pex {
-	__be32 __iomem    pex_config_addr;	/* 0x.000 - PCI Express Configuration Address Register */
-	__be32 __iomem    pex_config_data;	/* 0x.004 - PCI Express Configuration Data Register */
-	u8 __iomem    res1[4];
-	__be32 __iomem    pex_otb_cpl_tor;	/* 0x.00c - PCI Express Outbound completion timeout register */
-	__be32 __iomem    pex_conf_tor;		/* 0x.010 - PCI Express configuration timeout register */
-	u8 __iomem    res2[12];
-	__be32 __iomem    pex_pme_mes_dr;	/* 0x.020 - PCI Express PME and message detect register */
-	__be32 __iomem    pex_pme_mes_disr;	/* 0x.024 - PCI Express PME and message disable register */
-	__be32 __iomem    pex_pme_mes_ier;	/* 0x.028 - PCI Express PME and message interrupt enable register */
-	__be32 __iomem    pex_pmcr;		/* 0x.02c - PCI Express power management command register */
-	u8 __iomem    res3[3024];
-	__be32 __iomem    pexotar0;		/* 0x.c00 - PCI Express outbound translation address register 0 */
-	__be32 __iomem    pexotear0;		/* 0x.c04 - PCI Express outbound translation extended address register 0*/
-	u8 __iomem    res4[8];
-	__be32 __iomem    pexowar0;		/* 0x.c10 - PCI Express outbound window attributes register 0*/
-	u8 __iomem    res5[12];
-	__be32 __iomem    pexotar1;		/* 0x.c20 - PCI Express outbound translation address register 1 */
-	__be32 __iomem    pexotear1;		/* 0x.c24 - PCI Express outbound translation extended address register 1*/
-	__be32 __iomem    pexowbar1;		/* 0x.c28 - PCI Express outbound window base address register 1*/
-	u8 __iomem    res6[4];
-	__be32 __iomem    pexowar1;		/* 0x.c30 - PCI Express outbound window attributes register 1*/
-	u8 __iomem    res7[12];
-	__be32 __iomem    pexotar2;		/* 0x.c40 - PCI Express outbound translation address register 2 */
-	__be32 __iomem    pexotear2;		/* 0x.c44 - PCI Express outbound translation extended address register 2*/
-	__be32 __iomem    pexowbar2;		/* 0x.c48 - PCI Express outbound window base address register 2*/
-	u8 __iomem    res8[4];
-	__be32 __iomem    pexowar2;		/* 0x.c50 - PCI Express outbound window attributes register 2*/
-	u8 __iomem    res9[12];
-	__be32 __iomem    pexotar3;		/* 0x.c60 - PCI Express outbound translation address register 3 */
-	__be32 __iomem    pexotear3;		/* 0x.c64 - PCI Express outbound translation extended address register 3*/
-	__be32 __iomem    pexowbar3;		/* 0x.c68 - PCI Express outbound window base address register 3*/
-	u8 __iomem    res10[4];
-	__be32 __iomem    pexowar3;		/* 0x.c70 - PCI Express outbound window attributes register 3*/
-	u8 __iomem    res11[12];
-	__be32 __iomem    pexotar4;		/* 0x.c80 - PCI Express outbound translation address register 4 */
-	__be32 __iomem    pexotear4;		/* 0x.c84 - PCI Express outbound translation extended address register 4*/
-	__be32 __iomem    pexowbar4;		/* 0x.c88 - PCI Express outbound window base address register 4*/
-	u8 __iomem    res12[4];
-	__be32 __iomem    pexowar4;		/* 0x.c90 - PCI Express outbound window attributes register 4*/
-	u8 __iomem    res13[12];
-	u8 __iomem    res14[256];
-	__be32 __iomem    pexitar3;		/* 0x.da0 - PCI Express inbound translation address register 3 */
-	u8 __iomem    res15[4];
-	__be32 __iomem    pexiwbar3;		/* 0x.da8 - PCI Express inbound window base address register 3 */
-	__be32 __iomem    pexiwbear3;		/* 0x.dac - PCI Express inbound window base extended address register 3 */
-	__be32 __iomem    pexiwar3;		/* 0x.db0 - PCI Express inbound window attributes register 3 */
-	u8 __iomem    res16[12];
-	__be32 __iomem    pexitar2;		/* 0x.dc0 - PCI Express inbound translation address register 2 */
-	u8 __iomem    res17[4];
-	__be32 __iomem    pexiwbar2;		/* 0x.dc8 - PCI Express inbound window base address register 2 */
-	__be32 __iomem    pexiwbear2;		/* 0x.dcc - PCI Express inbound window base extended address register 2 */
-	__be32 __iomem    pexiwar2;		/* 0x.dd0 - PCI Express inbound window attributes register 2 */
-	u8 __iomem    res18[12];
-	__be32 __iomem    pexitar1;		/* 0x.de0 - PCI Express inbound translation address register 2 */
-	u8 __iomem    res19[4];
-	__be32 __iomem    pexiwbar1;		/* 0x.de8 - PCI Express inbound window base address register 2 */
-	__be32 __iomem    pexiwbear1;		/* 0x.dec - PCI Express inbound window base extended address register 2 */
-	__be32 __iomem    pexiwar1;		/* 0x.df0 - PCI Express inbound window attributes register 2 */
-	u8 __iomem    res20[12];
-	__be32 __iomem    pex_err_dr;		/* 0x.e00 - PCI Express error detect register */
-	u8 __iomem    res21[4];
-	__be32 __iomem    pex_err_en;		/* 0x.e08 - PCI Express error interrupt enable register */
-	u8 __iomem    res22[4];
-	__be32 __iomem    pex_err_disr;		/* 0x.e10 - PCI Express error disable register */
-	u8 __iomem    res23[12];
-	__be32 __iomem    pex_err_cap_stat;	/* 0x.e20 - PCI Express error capture status register */
-	u8 __iomem    res24[4];
-	__be32 __iomem    pex_err_cap_r0;	/* 0x.e28 - PCI Express error capture register 0 */
-	__be32 __iomem    pex_err_cap_r1;	/* 0x.e2c - PCI Express error capture register 0 */
-	__be32 __iomem    pex_err_cap_r2;	/* 0x.e30 - PCI Express error capture register 0 */
-	__be32 __iomem    pex_err_cap_r3;	/* 0x.e34 - PCI Express error capture register 0 */
-};
-
-#endif /* __POWERPC_FSL_PCIE_H */
-#endif /* __KERNEL__ */
-- 
1.5.1
