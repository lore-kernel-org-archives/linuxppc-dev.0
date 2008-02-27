Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <2491f145eabee7d2e2f0f489bc42156e7aec8952.1204097262.git.michael@ellerman.id.au>
In-Reply-To: <4108415683edeb799fd4880a8dba3e9f27a34415.1204097262.git.michael@ellerman.id.au>
References: <4108415683edeb799fd4880a8dba3e9f27a34415.1204097262.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 4/8] Move allocation of cell IOMMU pad page
Date: Wed, 27 Feb 2008 18:28:16 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There's no need to allocate the pad page unless we're going to actually
use it - so move the allocation to where we know we're going to use it.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/iommu.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 555d264..8e57e1a 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -344,12 +344,6 @@ static void cell_iommu_setup_page_tables(struct cbe_iommu *iommu,
 	iommu->ptab = page_address(page);
 	memset(iommu->ptab, 0, ptab_size);
 
-	/* allocate a bogus page for the end of each mapping */
-	page = alloc_pages_node(iommu->nid, GFP_KERNEL, 0);
-	BUG_ON(!page);
-	iommu->pad_page = page_address(page);
-	clear_page(iommu->pad_page);
-
 	/* number of pages needed for a page table */
 	n_pte_pages = (pages_per_segment *
 		       sizeof(unsigned long)) >> IOMMU_PAGE_SHIFT;
@@ -463,6 +457,7 @@ cell_iommu_setup_window(struct cbe_iommu *iommu, struct device_node *np,
 			unsigned long pte_offset)
 {
 	struct iommu_window *window;
+	struct page *page;
 	u32 ioid;
 
 	ioid = cell_iommu_get_ioid(np);
@@ -501,6 +496,11 @@ cell_iommu_setup_window(struct cbe_iommu *iommu, struct device_node *np,
 	 * This code also assumes that we have a window that starts at 0,
 	 * which is the case on all spider based blades.
 	 */
+	page = alloc_pages_node(iommu->nid, GFP_KERNEL, 0);
+	BUG_ON(!page);
+	iommu->pad_page = page_address(page);
+	clear_page(iommu->pad_page);
+
 	__set_bit(0, window->table.it_map);
 	tce_build_cell(&window->table, window->table.it_offset, 1,
 		       (unsigned long)iommu->pad_page, DMA_TO_DEVICE);
-- 
1.5.2.rc1.1884.g59b20
