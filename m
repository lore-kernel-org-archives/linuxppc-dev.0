Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <259a1d6aca476af7c572bdfea564a8a17aca3244.1200898886.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] Make IOMMU code safe for > 132 GB of memory
Date: Mon, 21 Jan 2008 18:01:43 +1100 (EST)
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently the IOMMU code allocates one page for the segment table, that
isn't safe if we have more than 132 GB of RAM.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/iommu.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 7f45d59..eb2a94b 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -310,8 +310,8 @@ static void cell_iommu_setup_hardware(struct cbe_iommu *iommu, unsigned long siz
 {
 	struct page *page;
 	int ret, i;
-	unsigned long reg, segments, pages_per_segment, ptab_size, n_pte_pages;
-	unsigned long xlate_base;
+	unsigned long reg, segments, pages_per_segment, ptab_size, stab_size,
+		      n_pte_pages, xlate_base;
 	unsigned int virq;
 
 	if (cell_iommu_find_ioc(iommu->nid, &xlate_base))
@@ -328,7 +328,8 @@ static void cell_iommu_setup_hardware(struct cbe_iommu *iommu, unsigned long siz
 			__FUNCTION__, iommu->nid, segments, pages_per_segment);
 
 	/* set up the segment table */
-	page = alloc_pages_node(iommu->nid, GFP_KERNEL, 0);
+	stab_size = segments * sizeof(unsigned long);
+	page = alloc_pages_node(iommu->nid, GFP_KERNEL, get_order(stab_size));
 	BUG_ON(!page);
 	iommu->stab = page_address(page);
 	clear_page(iommu->stab);
-- 
1.5.2.rc1.1884.g59b20
