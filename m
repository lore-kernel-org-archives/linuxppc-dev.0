Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 11930DDED0
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 01:52:03 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l6AFptor002906
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 08:51:55 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6AFps3S019648
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 10:51:54 -0500 (CDT)
Subject: [patch 2/6] Rewrite Freescale pci/pcie routing for 85xx/86xx
	pci/pcie controller
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Message-Id: <1184082701.20129.181.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 10 Jul 2007 23:51:41 +0800
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

Rewrite Freescale pci/pcie routing for 83xx/85xx/86xx pci/pcie 
controller.

The routing are common for 83xx/85xx/86xx pci/pcie host.

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
 arch/powerpc/sysdev/fsl_pci.c |  244 ++++++++++++++++++-----------------------
 arch/powerpc/sysdev/fsl_pci.h |  143 +++++++++++-------------
 2 files changed, 172 insertions(+), 215 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 24ba1b6..5e15cfc 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -1,136 +1,98 @@
 /*
- * MPC86XX pci setup code
+ * MPC85xx/86xx PCI/PCIE support routing.
  *
- * Recode: ZHANG WEI <wei.zhang@freescale.com>
- * Initial author: Xianghua Xiao <x.xiao@freescale.com>
+ * Copyright 2007 Freescale Semiconductor, Inc
  *
- * Copyright 2006 Freescale Semiconductor Inc.
+ * Initial author: Xianghua Xiao <x.xiao@freescale.com>
+ * Recode: ZHANG WEI <wei.zhang@freescale.com>
+ * Rewrite the routing for Frescale PCI and PCI Express
+ * 	Roy Zang <tie-fei.zang@freescale.com>
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
  * Free Software Foundation;  either version 2 of the  License, or (at your
  * option) any later version.
  */
-
-#include <linux/types.h>
-#include <linux/module.h>
-#include <linux/init.h>
+#include <linux/kernel.h>
 #include <linux/pci.h>
-#include <linux/serial.h>
+#include <linux/delay.h>
+#include <linux/string.h>
+#include <linux/init.h>
+#include <linux/bootmem.h>
 
-#include <asm/system.h>
-#include <asm/atomic.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
+#include <asm/machdep.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
-#include "../platforms/86xx/mpc86xx.h"
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
+/* atmu setup for fsl pci/pcie controller */
+void __init setup_pci_atmu(struct pci_controller *hose, struct resource *rsrc)
 {
-	volatile struct ccsr_pex *pcie;
-	volatile struct pcie_outbound_window_regs *pcieow;
-	volatile struct pcie_inbound_window_regs *pcieiw;
-	int i = 0;
+	struct ccsr_pci __iomem *pci;
+	int i;
 
-	DBG("PCIE memory map start 0x%x, size 0x%x\n", rsrc->start,
+	pr_debug("PCI memory map start 0x%x, size 0x%x\n", rsrc->start,
 			rsrc->end - rsrc->start + 1);
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
+	pci = ioremap(rsrc->start, rsrc->end - rsrc->start + 1);
+
+	/* Disable all windows (except powar0 since its ignored) */
+	for(i = 1; i < 5; i++)
+		out_be32(&pci->pow[i].powar, 0);
+	for(i = 0; i < 3; i++)
+		out_be32(&pci->piw[i].piwar, 0);
+
+	/* Setup outbound MEM window */
+	for(i = 0; i < 3; i++)
+		if (hose->mem_resources[i].flags & IORESOURCE_MEM){
+			pr_debug("PCI MEM resource start 0x%08x, size 0x%08x.\n",
+				hose->mem_resources[i].start,
+				hose->mem_resources[i].end
+				  - hose->mem_resources[i].start + 1);
+			out_be32(&pci->pow[i+1].potar,
+				(hose->mem_resources[i].start >> 12)
+				& 0x000fffff);
+			out_be32(&pci->pow[i+1].potear, 0);
+			out_be32(&pci->pow[i+1].powbar,
+				(hose->mem_resources[i].start >> 12)
+				& 0x000fffff);
+			/* Enable, Mem R/W */
+			out_be32(&pci->pow[i+1].powar, 0x80044000
+				| (__ilog2(hose->mem_resources[i].end
+				- hose->mem_resources[i].start + 1) - 1));
+		}
+
+	/* Setup outbound IO window */
+	if (hose->io_resource.flags & IORESOURCE_IO){
+		pr_debug("PCI IO resource start 0x%08x, size 0x%08x, phy base 0x%08x.\n",
+			hose->io_resource.start,
+			hose->io_resource.end - hose->io_resource.start + 1,
+			hose->io_base_phys);
+		out_be32(&pci->pow[i+1].potar, (hose->io_resource.start >> 12)
+				& 0x000fffff);
+		out_be32(&pci->pow[i+1].potear, 0);
+		out_be32(&pci->pow[i+1].powbar, (hose->io_base_phys >> 12)
+				& 0x000fffff);
+		/* Enable, IO R/W */
+		out_be32(&pci->pow[i+1].powar, 0x80088000
+			| (__ilog2(hose->io_resource.end
+			- hose->io_resource.start + 1) - 1));
+	}
+
+	/* Setup 2G inbound Memory Window @ 1 */
+	out_be32(&pci->piw[2].pitar, 0x00000000);
+	out_be32(&pci->piw[2].piwbar,0x00000000);
+	out_be32(&pci->piw[2].piwar, PIWAR_2G);
 }
 
-static void __init
-mpc86xx_setup_pcie(struct pci_controller *hose, u32 pcie_offset, u32 pcie_size)
+void __init setup_pci_cmd(struct pci_controller *hose)
 {
 	u16 cmd;
-
-	DBG("PCIE host controller register offset 0x%08x, size 0x%08x.\n",
-			pcie_offset, pcie_size);
-
 	early_read_config_word(hose, 0, 0, PCI_COMMAND, &cmd);
 	cmd |= PCI_COMMAND_SERR | PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY
-	    | PCI_COMMAND_IO;
+		| PCI_COMMAND_IO;
 	early_write_config_word(hose, 0, 0, PCI_COMMAND, cmd);
-
 	early_write_config_byte(hose, 0, 0, PCI_LATENCY_TIMER, 0x80);
 }
 
@@ -167,72 +129,76 @@ static void __devinit quirk_fsl_pcie_transparent(struct pci_dev *dev)
 	}
 }
 
+int __init fsl_pcie_check_link(struct pci_controller *hose)
+{
+	u16 val;
+	early_read_config_word(hose, 0, 0, PCIE_LTSSM, &val);
+	if (val < PCIE_LTSSM_L0)
+		return 1;
+	return 0;
+}
 
-DECLARE_PCI_FIXUP_EARLY(0x1957, 0x7010, quirk_fsl_pcie_transparent);
-DECLARE_PCI_FIXUP_EARLY(0x1957, 0x7011, quirk_fsl_pcie_transparent);
-
-#define PCIE_LTSSM	0x404	/* PCIe Link Training and Status */
-#define PCIE_LTSSM_L0	0x16	/* L0 state */
-
-int __init mpc86xx_add_bridge(struct device_node *dev)
+int __init fsl_add_bridge(struct device_node *dev, int is_primary)
 {
 	int len;
 	struct pci_controller *hose;
 	struct resource rsrc;
 	const int *bus_range;
-	int has_address = 0;
-	int primary = 0;
-	u16 val;
 
-	DBG("Adding PCIE host bridge %s\n", dev->full_name);
+	pr_debug("Adding PCI host bridge %s\n", dev->full_name);
 
 	/* Fetch host bridge registers address */
-	has_address = (of_address_to_resource(dev, 0, &rsrc) == 0);
+	if (of_address_to_resource(dev, 0, &rsrc)) {
+		printk(KERN_WARNING "Can't get pci register base!");
+		return -ENOMEM;
+	}
 
 	/* Get bus range if any */
 	bus_range = of_get_property(dev, "bus-range", &len);
 	if (bus_range == NULL || len < 2 * sizeof(int))
 		printk(KERN_WARNING "Can't get bus-range for %s, assume"
-		       " bus 0\n", dev->full_name);
+			" bus 0\n", dev->full_name);
 
 	pci_assign_all_buses = 1;
 	hose = pcibios_alloc_controller(dev);
 	if (!hose)
 		return -ENOMEM;
 
-	hose->indirect_type = PPC_INDIRECT_TYPE_EXT_REG |
-				PPC_INDIRECT_TYPE_SURPRESS_PRIMARY_BUS;
-
 	hose->first_busno = bus_range ? bus_range[0] : 0x0;
 	hose->last_busno = bus_range ? bus_range[1] : 0xff;
 
-	setup_indirect_pci(hose, rsrc.start, rsrc.start + 0x4);
-
-	/* Probe the hose link training status */
-	early_read_config_word(hose, 0, 0, PCIE_LTSSM, &val);
-	if (val < PCIE_LTSSM_L0)
-		return -ENXIO;
+	/* check PCI express bridge */
+	if (of_device_is_compatible(dev, "fsl,mpc85xx-pciex") ||
+		of_device_is_compatible(dev, "fsl,mpc86xx-pciex"))
+		hose->indirect_type = PPC_INDIRECT_TYPE_EXT_REG |
+			PPC_INDIRECT_TYPE_SURPRESS_PRIMARY_BUS;
 
-	/* Setup the PCIE host controller. */
-	mpc86xx_setup_pcie(hose, rsrc.start, rsrc.end - rsrc.start + 1);
+	setup_indirect_pci(hose, rsrc.start, rsrc.start + 0x4);
+	setup_pci_cmd(hose);
 
-	if ((rsrc.start & 0xfffff) == 0x8000)
-		primary = 1;
+	/* check PCI express link status */
+	if (of_device_is_compatible(dev, "fsl,mpc85xx-pciex") ||
+		of_device_is_compatible(dev, "fsl,mpc86xx-pciex"))
+		if (fsl_pcie_check_link(hose))
+			return -ENXIO;
 
-	printk(KERN_INFO "Found MPC86xx PCIE host bridge at 0x%08lx. "
-	       "Firmware bus number: %d->%d\n",
-	       (unsigned long) rsrc.start,
-	       hose->first_busno, hose->last_busno);
+	printk(KERN_INFO "Found FSL PCI host bridge at 0x%016llx."
+		"Firmware bus number: %d->%d\n",
+		(unsigned long long)rsrc.start, hose->first_busno,
+		hose->last_busno);
 
-	DBG(" ->Hose at 0x%p, cfg_addr=0x%p,cfg_data=0x%p\n",
+	pr_debug(" ->Hose at 0x%p, cfg_addr=0x%p,cfg_data=0x%p\n",
 		hose, hose->cfg_addr, hose->cfg_data);
 
 	/* Interpret the "ranges" property */
 	/* This also maps the I/O region and sets isa_io/mem_base */
-	pci_process_bridge_OF_ranges(hose, dev, primary);
+	pci_process_bridge_OF_ranges(hose, dev, is_primary);
 
 	/* Setup PEX window registers */
-	setup_pcie_atmu(hose, &rsrc);
+	setup_pci_atmu(hose, &rsrc);
 
 	return 0;
 }
+
+DECLARE_PCI_FIXUP_EARLY(0x1957, 0x7010, quirk_fsl_pcie_transparent);
+DECLARE_PCI_FIXUP_EARLY(0x1957, 0x7011, quirk_fsl_pcie_transparent);
diff --git a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h
index 8d9779c..91f94de 100644
--- a/arch/powerpc/sysdev/fsl_pci.h
+++ b/arch/powerpc/sysdev/fsl_pci.h
@@ -11,84 +11,75 @@
  */
 
 #ifdef __KERNEL__
-#ifndef __POWERPC_FSL_PCIE_H
-#define __POWERPC_FSL_PCIE_H
+#ifndef __POWERPC_FSL_PCI_H
+#define __POWERPC_FSL_PCI_H
 
-/* PCIE Express IO block registers in 85xx/86xx */
+#define PCIE_LTSSM	0x04000004	/* PCIE Link Training and Status */
+#define PCIE_LTSSM_L0	0x16		/* L0 state */
+#define PIWAR_2G	0xa0f5501e	/* Enable, Prefetch, Local Mem, Snoop R/W, 2G */
 
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
+/* PCI/PCI Express outbound window reg */
+struct pci_outbound_window_regs {
+	__be32	potar;	/* 0x.0 - Outbound translation address register */
+	__be32	potear;	/* 0x.4 - Outbound translation extended address register */
+	__be32	powbar;	/* 0x.8 - Outbound window base address register */
+	u8	res1[4];
+	__be32	powar;	/* 0x.10 - Outbound window attributes register */
+	u8	res2[12];
 };
 
-#endif /* __POWERPC_FSL_PCIE_H */
+/* PCI/PCI Express inbound window reg */
+struct pci_inbound_window_regs {
+	__be32	pitar;	/* 0x.0 - Inbound translation address register */
+	u8	res1[4];
+	__be32	piwbar;	/* 0x.8 - Inbound window base address register */
+	__be32	piwbear;	/* 0x.c - Inbound window base extended address register */
+	__be32	piwar;	/* 0x.10 - Inbound window attributes register */
+	u8	res2[12];
+};
+
+/* PCI/PCI Express IO block registers for 85xx/86xx */
+struct ccsr_pci {
+	__be32	config_addr;		/* 0x.000 - PCI/PCIE Configuration Address Register */
+	__be32	config_data;		/* 0x.004 - PCI/PCIE Configuration Data Register */
+	__be32	int_ack;		/* 0x.008 - PCI Interrupt Acknowledge Register */
+	__be32	pex_otb_cpl_tor;	/* 0x.00c - PCIE Outbound completion timeout register */
+	__be32	pex_conf_tor;		/* 0x.010 - PCIE configuration timeout register */
+	u8	res2[12];
+	__be32	pex_pme_mes_dr;		/* 0x.020 - PCIE PME and message detect register */
+	__be32	pex_pme_mes_disr;	/* 0x.024 - PCIE PME and message disable register */
+	__be32	pex_pme_mes_ier;	/* 0x.028 - PCIE PME and message interrupt enable register */
+	__be32	pex_pmcr;		/* 0x.02c - PCIE power management command register */
+	u8	res3[3024];
+/* PCI/PCI Express outbound window 0-4
+ * Window 0 is the default window and is the only window enabled upon reset.
+ * The default outbound register set is used when a transaction misses
+ * in all of the other outbound windows.
+ */
+	struct pci_outbound_window_regs pow[5];
+
+	u8	res14[256];
+
+/* PCI/PCI Express inbound window 3-1
+ * inbound window 1 supports only a 32-bit base address and does not
+ * define an inbound window base extended address register.
+ */
+	struct pci_inbound_window_regs piw[3];
+
+	__be32	pex_err_dr;		/* 0x.e00 - PCI/PCIE error detect register */
+	u8	res21[4];
+	__be32	pex_err_en;		/* 0x.e08 - PCI/PCIE error interrupt enable register */
+	u8	res22[4];
+	__be32	pex_err_disr;		/* 0x.e10 - PCI/PCIE error disable register */
+	u8	res23[12];
+	__be32	pex_err_cap_stat;	/* 0x.e20 - PCI/PCIE error capture status register */
+	u8	res24[4];
+	__be32	pex_err_cap_r0;		/* 0x.e28 - PCIE error capture register 0 */
+	__be32	pex_err_cap_r1;		/* 0x.e2c - PCIE error capture register 0 */
+	__be32	pex_err_cap_r2;		/* 0x.e30 - PCIE error capture register 0 */
+	__be32	pex_err_cap_r3;		/* 0x.e34 - PCIE error capture register 0 */
+};
+
+int __init fsl_add_bridge(struct device_node *dev, int is_primary);
+#endif /* __POWERPC_FSL_PCI_H */
 #endif /* __KERNEL__ */
-- 
1.5.1
