Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 978C3DE002
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 07:27:57 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n4CLRmcI015394
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 16:27:48 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/fsl: Setup PCI inbound window based on actual amount
	of memory
Date: Tue, 12 May 2009 16:27:35 -0500
Message-Id: <1242163655-880-3-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1242163655-880-2-git-send-email-galak@kernel.crashing.org>
References: <1242163655-880-1-git-send-email-galak@kernel.crashing.org>
	<1242163655-880-2-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Previouslly we just always set the inbound window to 2G.  This was
broken for systems with >2G.  If a system has >=4G we will need
SWIOTLB support to handle that case.

We now allocate PCICSRBAR/PEXCSRBAR right below the lowest PCI outbound
address for MMIO or the 4G boundary (if the lowest PCI address is above
4G).

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/sysdev/fsl_pci.c |  122 ++++++++++++++++++++++++++++++++++-------
 arch/powerpc/sysdev/fsl_pci.h |    6 ++-
 2 files changed, 107 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 94d8b3f..9b49ecc 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -23,6 +23,8 @@
 #include <linux/string.h>
 #include <linux/init.h>
 #include <linux/bootmem.h>
+#include <linux/lmb.h>
+#include <linux/log2.h>
 
 #include <asm/io.h>
 #include <asm/prom.h>
@@ -96,7 +98,13 @@ static void __init setup_pci_atmu(struct pci_controller *hose,
 				  struct resource *rsrc)
 {
 	struct ccsr_pci __iomem *pci;
-	int i, j, n;
+	int i, j, n, mem_log;
+	u64 mem, sz, paddr_hi = 0;
+	u64 paddr_lo = ULLONG_MAX;
+	u32 pcicsrbar = 0, pcicsrbar_sz;
+	u32 piwar = PIWAR_EN | PIWAR_PF | PIWAR_TGI_LOCAL |
+			PIWAR_READ_SNOOP | PIWAR_WRITE_SNOOP;
+	char *name = hose->dn->full_name;
 
 	pr_debug("PCI memory map start 0x%016llx, size 0x%016llx\n",
 		    (u64)rsrc->start, (u64)rsrc->end - (u64)rsrc->start + 1);
@@ -117,6 +125,9 @@ static void __init setup_pci_atmu(struct pci_controller *hose,
 		if (!(hose->mem_resources[i].flags & IORESOURCE_MEM))
 			continue;
 
+		paddr_lo = min(paddr_lo, (u64)hose->mem_resources[i].start);
+		paddr_hi = max(paddr_hi, (u64)hose->mem_resources[i].end);
+
 		n = setup_one_atmu(pci, j, &hose->mem_resources[i],
 				   hose->pci_mem_offset);
 
@@ -147,14 +158,97 @@ static void __init setup_pci_atmu(struct pci_controller *hose,
 		}
 	}
 
-	/* Setup 2G inbound Memory Window @ 1 */
-	out_be32(&pci->piw[2].pitar, 0x00000000);
-	out_be32(&pci->piw[2].piwbar,0x00000000);
-	out_be32(&pci->piw[2].piwar, PIWAR_2G);
+	/* convert to pci address space */
+	paddr_hi -= hose->pci_mem_offset;
+	paddr_lo -= hose->pci_mem_offset;
+
+	if (paddr_hi == paddr_lo) {
+		pr_err("%s: No outbound window space\n", name);
+		return ;
+	}
+
+	if (paddr_lo == 0) {
+		pr_err("%s: No space for inbound window\n", name);
+		return ;
+	}
+
+	/* setup PCSRBAR/PEXCSRBAR */
+	early_write_config_dword(hose, 0, 0, PCI_BASE_ADDRESS_0, 0xffffffff);
+	early_read_config_dword(hose, 0, 0, PCI_BASE_ADDRESS_0, &pcicsrbar_sz);
+	pcicsrbar_sz = ~pcicsrbar_sz + 1;
+
+	if (paddr_hi < (0x100000000ull - pcicsrbar_sz) ||
+		(paddr_lo > 0x100000000ull))
+		pcicsrbar = 0x100000000ull - pcicsrbar_sz;
+	else
+		pcicsrbar = (paddr_lo - pcicsrbar_sz) & -pcicsrbar_sz;
+	early_write_config_dword(hose, 0, 0, PCI_BASE_ADDRESS_0, pcicsrbar);
+
+	paddr_lo = min(paddr_lo, (u64)pcicsrbar);
+
+	pr_info("%s: PCICSRBAR @ 0x%x\n", name, pcicsrbar);
+
+	/* Setup inbound mem window */
+	mem = lmb_end_of_DRAM();
+	sz = min(mem, paddr_lo);
+	mem_log = __ilog2_u64(sz);
+
+	/* PCIe can overmap inbound & outbound since RX & TX are seperated */
+	if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
+		/* Size window to exact size if power-of-two or one size up */
+		if ((1ull << mem_log) != mem) {
+			pr_info("%s: Setting PCI inbound window greater "
+				"than memory size\n", name);
+			mem_log++;
+		}
+
+		piwar |= (mem_log - 1);
+
+		/* Setup inbound memory window */
+		out_be32(&pci->piw[2].pitar,  0x00000000);
+		out_be32(&pci->piw[2].piwbar, 0x00000000);
+		out_be32(&pci->piw[2].piwar,  piwar);
+
+		hose->dma_window_base_cur = 0x00000000;
+		hose->dma_window_size = (resource_size_t)sz;
+	} else {
+		u64 paddr = 0;
+
+		/* Setup inbound memory window */
+		out_be32(&pci->piw[2].pitar,  paddr >> 12);
+		out_be32(&pci->piw[2].piwbar, paddr >> 12);
+		out_be32(&pci->piw[2].piwar,  (piwar | (mem_log - 1)));
+
+		paddr += 1ull << mem_log;
+		sz -= 1ull << mem_log;
+
+		if (sz) {
+			mem_log = __ilog2_u64(sz);
+
+			out_be32(&pci->piw[1].pitar,  paddr >> 12);
+			out_be32(&pci->piw[1].piwbar, paddr >> 12);
+			out_be32(&pci->piw[1].piwar,  (piwar | (mem_log - 1)));
+
+			paddr += 1ull << mem_log;
+		}
+
+		hose->dma_window_base_cur = 0x00000000;
+		hose->dma_window_size = (resource_size_t)paddr;
+	}
+
+	if (hose->dma_window_size < mem) {
+#ifndef CONFIG_SWIOTLB
+		pr_warning("%s: Amount of memory exceeds our ability to map. "
+			   "Look at enabling CONFIG_SWIOTLB\n", name);
+#endif
+		/* adjusting outbound windows could reclaim space in mem map */
+		if (paddr_hi < 0x100000000ull)
+			pr_warning("%s: Outbound window cfg leaves gaps in "
+				   "memory map.\n", name);
 
-	/* Save the base address and size covered by inbound window mappings */
-	hose->dma_window_base_cur = 0x00000000;
-	hose->dma_window_size = 0x80000000;
+		pr_info("%s: DMA window size is 0x%llx\n", name,
+			(u64)hose->dma_window_size);
+	}
 
 	iounmap(pci);
 }
@@ -180,16 +274,6 @@ static void __init setup_pci_cmd(struct pci_controller *hose)
 	}
 }
 
-static void __init setup_pci_pcsrbar(struct pci_controller *hose)
-{
-#ifdef CONFIG_PCI_MSI
-	phys_addr_t immr_base;
-
-	immr_base = get_immrbase();
-	early_write_config_dword(hose, 0, 0, PCI_BASE_ADDRESS_0, immr_base);
-#endif
-}
-
 void fsl_pcibios_fixup_bus(struct pci_bus *bus)
 {
 	struct pci_controller *hose = (struct pci_controller *) bus->sysdata;
@@ -273,8 +357,6 @@ int __init fsl_add_bridge(struct device_node *dev, int is_primary)
 	/* Setup PEX window registers */
 	setup_pci_atmu(hose, &rsrc);
 
-	/* Setup PEXCSRBAR */
-	setup_pci_pcsrbar(hose);
 	return 0;
 }
 
diff --git a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h
index 13f30c2..a9d8bbe 100644
--- a/arch/powerpc/sysdev/fsl_pci.h
+++ b/arch/powerpc/sysdev/fsl_pci.h
@@ -16,7 +16,11 @@
 
 #define PCIE_LTSSM	0x0404		/* PCIE Link Training and Status */
 #define PCIE_LTSSM_L0	0x16		/* L0 state */
-#define PIWAR_2G	0xa0f5501e	/* Enable, Prefetch, Local Mem, Snoop R/W, 2G */
+#define PIWAR_EN		0x80000000	/* Enable */
+#define PIWAR_PF		0x20000000	/* prefetch */
+#define PIWAR_TGI_LOCAL		0x00f00000	/* target - local memory */
+#define PIWAR_READ_SNOOP	0x00050000
+#define PIWAR_WRITE_SNOOP	0x00005000
 
 /* PCI/PCI Express outbound window reg */
 struct pci_outbound_window_regs {
-- 
1.6.0.6
