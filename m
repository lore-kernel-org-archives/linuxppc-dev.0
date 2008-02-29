Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <a6a40136dfd4f0d584113bd441bea2eeb89cf23e.1204270367.git.michael@ellerman.id.au>
In-Reply-To: <fdd3edc0f2f3d2d6cade5cd695b8080d0da95a7f.1204270367.git.michael@ellerman.id.au>
References: <fdd3edc0f2f3d2d6cade5cd695b8080d0da95a7f.1204270367.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 3/8] Remove unused pte_offset variable
Date: Fri, 29 Feb 2008 18:33:23 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The cell IOMMU code no longer needs to save the pte_offset variable
separately, it is incorporated into tbl->it_offset.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/iommu.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 4e75919..555d264 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -123,7 +123,6 @@ struct iommu_window {
 	struct cbe_iommu *iommu;
 	unsigned long offset;
 	unsigned long size;
-	unsigned long pte_offset;
 	unsigned int ioid;
 	struct iommu_table table;
 };
@@ -475,13 +474,11 @@ cell_iommu_setup_window(struct cbe_iommu *iommu, struct device_node *np,
 	window->size = size;
 	window->ioid = ioid;
 	window->iommu = iommu;
-	window->pte_offset = pte_offset;
 
 	window->table.it_blocksize = 16;
 	window->table.it_base = (unsigned long)iommu->ptab;
 	window->table.it_index = iommu->nid;
-	window->table.it_offset = (offset >> IOMMU_PAGE_SHIFT) +
-		window->pte_offset;
+	window->table.it_offset = (offset >> IOMMU_PAGE_SHIFT) + pte_offset;
 	window->table.it_size = size >> IOMMU_PAGE_SHIFT;
 
 	iommu_init_table(&window->table, iommu->nid);
-- 
1.5.2.rc1.1884.g59b20
