Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0130.outbound.protection.outlook.com [157.56.110.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BFDD1A0026
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2015 14:48:40 +1100 (AEDT)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Tiejun Chen <tiejun.chen@intel.com>, Michael Ellerman
 <mpe@ellerman.id.au>, <kexec@lists.infradead.org>, Scott Wood
 <scottwood@freescale.com>, Mingkai Hu <Mingkai.hu@freescale.com>
Subject: [PATCH v2 04/18] powerpc/fsl_pci: Don't set up inbound windows in
 kdump crash kernel
Date: Tue, 6 Oct 2015 22:48:08 -0500
Message-ID: <1444189702-17241-5-git-send-email-scottwood@freescale.com>
In-Reply-To: <1444189702-17241-1-git-send-email-scottwood@freescale.com>
References: <1444189702-17241-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Otherwise, because the top end of the crash kernel is treated as the
absolute top of memory rather than the beginning of a reserved region,
in-flight DMA from the previous kernel that targets areas above the
crash kernel can trigger a storm of PCI errors.  We only do this for
kdump, not normal kexec, in case kexec is being used to upgrade to a
kernel that wants a different inbound memory map.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Cc: Mingkai Hu <Mingkai.hu@freescale.com>
---
v2: new patch

 arch/powerpc/sysdev/fsl_pci.c | 84 +++++++++++++++++++++++++++++++------------
 1 file changed, 61 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index ebc1f412..98d671c 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -179,6 +179,19 @@ static int setup_one_atmu(struct ccsr_pci __iomem *pci,
 	return i;
 }
 
+static bool is_kdump(void)
+{
+	struct device_node *node;
+
+	node = of_find_node_by_type(NULL, "memory");
+	if (!node) {
+		WARN_ON_ONCE(1);
+		return false;
+	}
+
+	return of_property_read_bool(node, "linux,usable-memory");
+}
+
 /* atmu setup for fsl pci/pcie controller */
 static void setup_pci_atmu(struct pci_controller *hose)
 {
@@ -192,6 +205,16 @@ static void setup_pci_atmu(struct pci_controller *hose)
 	const char *name = hose->dn->full_name;
 	const u64 *reg;
 	int len;
+	bool setup_inbound;
+
+	/*
+	 * If this is kdump, we don't want to trigger a bunch of PCI
+	 * errors by closing the window on in-flight DMA.
+	 *
+	 * We still run most of the function's logic so that things like
+	 * hose->dma_window_size still get set.
+	 */
+	setup_inbound = !is_kdump();
 
 	if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
 		if (in_be32(&pci->block_rev1) >= PCIE_IP_REV_2_2) {
@@ -204,8 +227,11 @@ static void setup_pci_atmu(struct pci_controller *hose)
 	/* Disable all windows (except powar0 since it's ignored) */
 	for(i = 1; i < 5; i++)
 		out_be32(&pci->pow[i].powar, 0);
-	for (i = start_idx; i < end_idx; i++)
-		out_be32(&pci->piw[i].piwar, 0);
+
+	if (setup_inbound) {
+		for (i = start_idx; i < end_idx; i++)
+			out_be32(&pci->piw[i].piwar, 0);
+	}
 
 	/* Setup outbound MEM window */
 	for(i = 0, j = 1; i < 3; i++) {
@@ -278,6 +304,7 @@ static void setup_pci_atmu(struct pci_controller *hose)
 
 	/* Setup inbound mem window */
 	mem = memblock_end_of_DRAM();
+	pr_info("%s: end of DRAM %llx\n", __func__, mem);
 
 	/*
 	 * The msi-address-64 property, if it exists, indicates the physical
@@ -320,12 +347,14 @@ static void setup_pci_atmu(struct pci_controller *hose)
 
 		piwar |= ((mem_log - 1) & PIWAR_SZ_MASK);
 
-		/* Setup inbound memory window */
-		out_be32(&pci->piw[win_idx].pitar,  0x00000000);
-		out_be32(&pci->piw[win_idx].piwbar, 0x00000000);
-		out_be32(&pci->piw[win_idx].piwar,  piwar);
-		win_idx--;
+		if (setup_inbound) {
+			/* Setup inbound memory window */
+			out_be32(&pci->piw[win_idx].pitar,  0x00000000);
+			out_be32(&pci->piw[win_idx].piwbar, 0x00000000);
+			out_be32(&pci->piw[win_idx].piwar,  piwar);
+		}
 
+		win_idx--;
 		hose->dma_window_base_cur = 0x00000000;
 		hose->dma_window_size = (resource_size_t)sz;
 
@@ -343,13 +372,15 @@ static void setup_pci_atmu(struct pci_controller *hose)
 
 			piwar = (piwar & ~PIWAR_SZ_MASK) | (mem_log - 1);
 
-			/* Setup inbound memory window */
-			out_be32(&pci->piw[win_idx].pitar,  0x00000000);
-			out_be32(&pci->piw[win_idx].piwbear,
-					pci64_dma_offset >> 44);
-			out_be32(&pci->piw[win_idx].piwbar,
-					pci64_dma_offset >> 12);
-			out_be32(&pci->piw[win_idx].piwar,  piwar);
+			if (setup_inbound) {
+				/* Setup inbound memory window */
+				out_be32(&pci->piw[win_idx].pitar,  0x00000000);
+				out_be32(&pci->piw[win_idx].piwbear,
+						pci64_dma_offset >> 44);
+				out_be32(&pci->piw[win_idx].piwbar,
+						pci64_dma_offset >> 12);
+				out_be32(&pci->piw[win_idx].piwar,  piwar);
+			}
 
 			/*
 			 * install our own dma_set_mask handler to fixup dma_ops
@@ -362,12 +393,15 @@ static void setup_pci_atmu(struct pci_controller *hose)
 	} else {
 		u64 paddr = 0;
 
-		/* Setup inbound memory window */
-		out_be32(&pci->piw[win_idx].pitar,  paddr >> 12);
-		out_be32(&pci->piw[win_idx].piwbar, paddr >> 12);
-		out_be32(&pci->piw[win_idx].piwar,  (piwar | (mem_log - 1)));
-		win_idx--;
+		if (setup_inbound) {
+			/* Setup inbound memory window */
+			out_be32(&pci->piw[win_idx].pitar,  paddr >> 12);
+			out_be32(&pci->piw[win_idx].piwbar, paddr >> 12);
+			out_be32(&pci->piw[win_idx].piwar,
+				 (piwar | (mem_log - 1)));
+		}
 
+		win_idx--;
 		paddr += 1ull << mem_log;
 		sz -= 1ull << mem_log;
 
@@ -375,11 +409,15 @@ static void setup_pci_atmu(struct pci_controller *hose)
 			mem_log = ilog2(sz);
 			piwar |= (mem_log - 1);
 
-			out_be32(&pci->piw[win_idx].pitar,  paddr >> 12);
-			out_be32(&pci->piw[win_idx].piwbar, paddr >> 12);
-			out_be32(&pci->piw[win_idx].piwar,  piwar);
-			win_idx--;
+			if (setup_inbound) {
+				out_be32(&pci->piw[win_idx].pitar,
+					 paddr >> 12);
+				out_be32(&pci->piw[win_idx].piwbar,
+					 paddr >> 12);
+				out_be32(&pci->piw[win_idx].piwar, piwar);
+			}
 
+			win_idx--;
 			paddr += 1ull << mem_log;
 		}
 
-- 
2.1.4
