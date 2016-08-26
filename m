Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sLBFp0NSfzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 16:38:37 +1000 (AEST)
From: Scott Wood <oss@buserror.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: Scott Wood <oss@buserror.net>,
	Tillmann Heidsieck <theidsieck@leenox.de>
Date: Fri, 26 Aug 2016 01:38:25 -0500
Message-Id: <1472193505-13136-1-git-send-email-oss@buserror.net>
Subject: [PATCH] powerpc/fsl_pci: Size upper inbound window based on RAM size
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This allows PCI devices that can only address (e.g.) 36 or 40 bit DMA to
use direct DMA, at the cost of not being able to DMA to non-RAM addresses
(this doesn't affect MSIs as there is a separate dedicated window for
that) which we wouldn't have been able to do anyway if the RAM size didn't
trigger the creation of the second inbound window.

It also fixes an off-by-one error that set dma_direct_ops on PCI devices
whose dma mask could address all the space below the DMA offset
(previously 40 bits), but not the window that starts at the DMA offset.

Signed-off-by: Scott Wood <oss@buserror.net>
Cc: Tillmann Heidsieck <theidsieck@leenox.de>
---
 arch/powerpc/sysdev/fsl_pci.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 0ef9df4..d3a5974 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -111,8 +111,7 @@ static struct pci_ops fsl_indirect_pcie_ops =
 	.write = indirect_write_config,
 };
 
-#define MAX_PHYS_ADDR_BITS	40
-static u64 pci64_dma_offset = 1ull << MAX_PHYS_ADDR_BITS;
+static u64 pci64_dma_offset;
 
 #ifdef CONFIG_SWIOTLB
 static void setup_swiotlb_ops(struct pci_controller *hose)
@@ -132,12 +131,10 @@ static int fsl_pci_dma_set_mask(struct device *dev, u64 dma_mask)
 		return -EIO;
 
 	/*
-	 * Fixup PCI devices that are able to DMA to above the physical
-	 * address width of the SoC such that we can address any internal
-	 * SoC address from across PCI if needed
+	 * Fix up PCI devices that are able to DMA to the large inbound
+	 * mapping that allows addressing any RAM address from across PCI.
 	 */
-	if ((dev_is_pci(dev)) &&
-	    dma_mask >= DMA_BIT_MASK(MAX_PHYS_ADDR_BITS)) {
+	if (dev_is_pci(dev) && dma_mask >= pci64_dma_offset * 2 - 1) {
 		set_dma_ops(dev, &dma_direct_ops);
 		set_dma_offset(dev, pci64_dma_offset);
 	}
@@ -387,6 +384,7 @@ static void setup_pci_atmu(struct pci_controller *hose)
 				mem_log++;
 
 			piwar = (piwar & ~PIWAR_SZ_MASK) | (mem_log - 1);
+			pci64_dma_offset = 1ULL << mem_log;
 
 			if (setup_inbound) {
 				/* Setup inbound memory window */
-- 
2.7.4
