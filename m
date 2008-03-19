Return-Path: <michael@ellerman.id.au>
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by ozlabs.org (Postfix) with ESMTP id 961ADDDE0A
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 17:10:06 +1100 (EST)
Subject: [Fwd: [Cbe-oss-dev] [PATCH] Fix cell IOMMU code to cope with empty
	dma-ranges, and non-PCI devices]
From: Michael Ellerman <michael@ellerman.id.au>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Wed, 19 Mar 2008 17:10:07 +1100
Message-Id: <1205907007.17716.5.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

-------- Forwarded Message --------
From: Michael Ellerman <michael@ellerman.id.au>
To: Paul Mackerras <paulus@samba.org>
Cc: cbe-oss-dev@ozlabs.org
Subject: [Cbe-oss-dev] [PATCH] Fix cell IOMMU code to cope with empty
dma-ranges, and non-PCI devices
Date: Fri, 14 Mar 2008 16:47:39 +1100 (EST)

The cell IOMMU code to parse the dma-ranges properties, used for the fixed
mapping, was broken in two ways for some devices.

Firstly it didn't cope with empty dma-ranges properties. An empty property
implies no translation so can be safely skipped.

The code also wrongly assumed it would be looking at PCI devices, and hard
coded the address cells and size cells.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/iommu.c |   41 +++++++++++++++++++++-------------
 1 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 20ea0e1..d75ccde 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -802,17 +802,24 @@ static int __init cell_iommu_init_disabled(void)
 
 static u64 cell_iommu_get_fixed_address(struct device *dev)
 {
-	u64 cpu_addr, size, best_size, pci_addr = OF_BAD_ADDR;
+	u64 cpu_addr, size, best_size, dev_addr = OF_BAD_ADDR;
 	struct device_node *np;
 	const u32 *ranges = NULL;
-	int i, len, best;
+	int i, len, best, naddr, nsize, pna, range_size;
 
 	np = of_node_get(dev->archdata.of_node);
-	while (np) {
+	while (1) {
+		naddr = of_n_addr_cells(np);
+		nsize = of_n_size_cells(np);
+		np = of_get_next_parent(np);
+		if (!np)
+			break;
+
 		ranges = of_get_property(np, "dma-ranges", &len);
-		if (ranges)
+
+		/* Ignore empty ranges, they imply no translation required */
+		if (ranges && len > 0)
 			break;
-		np = of_get_next_parent(np);
 	}
 
 	if (!ranges) {
@@ -822,15 +829,17 @@ static u64 cell_iommu_get_fixed_address(struct device *dev)
 
 	len /= sizeof(u32);
 
+	pna = of_n_addr_cells(np);
+	range_size = naddr + nsize + pna;
+
 	/* dma-ranges format:
-	 * 1 cell:  pci space
-	 * 2 cells: pci address
-	 * 2 cells: parent address
-	 * 2 cells: size
+	 * child addr	: naddr cells
+	 * parent addr	: pna cells
+	 * size		: nsize cells
 	 */
-	for (i = 0, best = -1, best_size = 0; i < len; i += 7) {
-		cpu_addr = of_translate_dma_address(np, ranges +i + 3);
-		size = of_read_number(ranges + i + 5, 2);
+	for (i = 0, best = -1, best_size = 0; i < len; i += range_size) {
+		cpu_addr = of_translate_dma_address(np, ranges + i + naddr);
+		size = of_read_number(ranges + i + naddr + pna, nsize);
 
 		if (cpu_addr == 0 && size > best_size) {
 			best = i;
@@ -838,15 +847,15 @@ static u64 cell_iommu_get_fixed_address(struct device *dev)
 		}
 	}
 
-	if (best >= 0)
-		pci_addr = of_read_number(ranges + best + 1, 2);
-	else
+	if (best >= 0) {
+		dev_addr = of_read_number(ranges + best, naddr);
+	} else
 		dev_dbg(dev, "iommu: no suitable range found!\n");
 
 out:
 	of_node_put(np);
 
-	return pci_addr;
+	return dev_addr;
 }
 
 static int dma_set_mask_and_switch(struct device *dev, u64 dma_mask)
