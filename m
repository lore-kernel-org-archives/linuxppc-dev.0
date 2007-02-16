Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 3EB10DDDEB
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 13:45:22 +1100 (EST)
Date: Thu, 15 Feb 2007 20:44:45 -0600 (CST)
From: Andy Fleming <afleming@freescale.com>
To: linuxppc-dev@ozlabs.org, Kumar Gala <galak@kernel.crashing.org>,
	jdl@jdl.com
Subject: [RFC 3/7] Unite all PCI-e on 85xx and 86xx under one codebase
Message-ID: <Pine.LNX.4.61.0702152044060.9034@ld0175-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add 8548 CDS PCI express host bridge support

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
Acked-by: Andy Fleming <afleming@freescale.com>
---
 arch/powerpc/platforms/85xx/mpc85xx_cds.c |   11 +--
 arch/powerpc/platforms/85xx/pci.c         |  108 ++++++++++++++++++++++++++++-
 2 files changed, 110 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index abc0aca..2027855 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -79,9 +79,9 @@ static int mpc85xx_exclude_device(u_char
 		return PCIBIOS_SUCCESSFUL;
 }
 
-static void __init mpc85xx_cds_pcibios_fixup(void)
+void __init
+mpc85xx_cds_pci_irq_fixup(struct pci_dev *dev)
 {
-	struct pci_dev *dev;
 	u_char		c;
 
 	if ((dev = pci_get_device(PCI_VENDOR_ID_VIA,
@@ -120,11 +120,6 @@ static void __init mpc85xx_cds_pcibios_f
 		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 11);
 		pci_dev_put(dev);
 	}
-
-	/* Now map all the PCI irqs */
-	dev = NULL;
-	for_each_pci_dev(dev)
-		pci_read_irq_line(dev);
 }
 
 #ifdef CONFIG_PPC_I8259
@@ -260,7 +255,7 @@ static void __init mpc85xx_cds_setup_arc
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
 		add_bridge(np);
 
-	ppc_md.pcibios_fixup = mpc85xx_cds_pcibios_fixup;
+	ppc_md.pci_irq_fixup = mpc85xx_cds_pci_irq_fixup;
 	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
 #endif
 
diff --git a/arch/powerpc/platforms/85xx/pci.c b/arch/powerpc/platforms/85xx/pci.c
index 05930ee..5c70797 100644
--- a/arch/powerpc/platforms/85xx/pci.c
+++ b/arch/powerpc/platforms/85xx/pci.c
@@ -24,6 +24,7 @@
 #include <asm/pci-bridge.h>
 #include <asm/prom.h>
 #include <sysdev/fsl_soc.h>
+#include <asm/immap_85xx.h>
 
 #undef DEBUG
 
@@ -35,13 +36,108 @@
 
 int mpc85xx_pci2_busno = 0;
 
+extern void
+setup_indirect_pcie(struct pci_controller* hose, u32 cfg_addr, u32 cfg_data);
+
 #ifdef CONFIG_PCI
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
+	pcie->pexowar3 = 0;
+	pcie->pexowar4 = 0;
+	pcie->pexiwar1 = 0;
+	pcie->pexiwar2 = 0;
+	pcie->pexiwar3 = 0;
+
+	pcieow = (struct pcie_outbound_window_regs *)&pcie->pexotar1;
+	pcieiw = (struct pcie_inbound_window_regs *)&pcie->pexitar1;
+
+	/* Setup outbound MEM window */
+	for(i = 0; i < 3; i++)
+		if (hose->mem_resources[i].flags & IORESOURCE_MEM){
+			DBG("PCIE MEM resource start 0x%08x, size 0x%08x.\n",
+				hose->mem_resources[i].start,
+				hose->mem_resources[i].end
+				  - hose->mem_resources[i].start + 1);
+			pcieow->pexotar = (hose->mem_resources[i].start) >> 12
+				& 0x000fffff;
+			pcieow->pexotear = 0;
+			pcieow->pexowbar = (hose->mem_resources[i].start) >> 12
+				& 0x000fffff;
+			/* Enable, Mem R/W */
+			pcieow->pexowar = 0x80044000 |
+				(__ilog2(hose->mem_resources[i].end
+					 - hose->mem_resources[i].start + 1)
+				 - 1);
+			pcieow++;
+		}
+
+	/* Setup outbound IO window */
+	if (hose->io_resource.flags & IORESOURCE_IO){
+		DBG("PCIE IO resource start 0x%08x, size 0x%08x, phy base 0x%08x.\n",
+			hose->io_resource.start,
+			hose->io_resource.end - hose->io_resource.start + 1,
+			hose->io_base_phys);
+		pcieow->pexotar = (hose->io_resource.start) >> 12 & 0x000fffff;
+		pcieow->pexotear = 0;
+		pcieow->pexowbar = (hose->io_base_phys) >> 12 & 0x000fffff;
+		/* Enable, IO R/W */
+		pcieow->pexowar = 0x80088000 | (__ilog2(hose->io_resource.end
+					- hose->io_resource.start + 1) - 1);
+	}
+
+	/* Setup 2G inbound Memory Window @ 0 */
+	pcieiw->pexitar = 0x00000000;
+	pcieiw->pexiwbar = 0x00000000;
+	/* Enable, Prefetch, Local Mem, Snoop R/W, 2G */
+	pcieiw->pexiwar = 0xa0f5501e;
+}
+static void __init
+mpc85xx_setup_pcie(struct pci_controller *hose)
+{
+	u16 temps;
+	early_read_config_word(hose, 0, 0, PCI_COMMAND, &temps);
+	temps |= PCI_COMMAND_SERR | PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY;
+	early_write_config_word(hose, 0, 0, PCI_COMMAND, temps);
+	early_write_config_byte(hose, 0, 0, PCI_LATENCY_TIMER, 0x80);
+}
+
 int __init add_bridge(struct device_node *dev)
 {
 	int len;
 	struct pci_controller *hose;
 	struct resource rsrc;
 	const int *bus_range;
+	unsigned int temp;
 	int primary = 1, has_address = 0;
 	phys_addr_t immr = get_immrbase();
 
@@ -77,6 +173,17 @@ int __init add_bridge(struct device_node
 		hose->bus_offset = hose->first_busno;
 		mpc85xx_pci2_busno = hose->first_busno;
 	}
+	/* PEX */
+	if ((rsrc.start & 0xfffff) == 0xa000) {
+		setup_indirect_pcie(hose, immr + 0xa000, immr + 0xa004);
+		mpc85xx_setup_pcie(hose);
+		primary = 1;
+		hose->bus_offset = hose->first_busno;
+		/* Setup PEX window registers */
+		setup_pcie_atmu(hose, &rsrc);
+		early_read_config_dword(hose, 0, 0, 0x404, &temp);
+		printk("Reg 0x404 is 0x%x\n",temp);
+	}
 
 	printk(KERN_INFO "Found MPC85xx PCI host bridge at 0x%016llx. "
 	       "Firmware bus number: %d->%d\n",
@@ -92,5 +199,4 @@ int __init add_bridge(struct device_node
 
 	return 0;
 }
-
 #endif
-- 
1.4.4
