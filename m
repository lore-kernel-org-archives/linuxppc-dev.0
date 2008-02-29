Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <ff1e6c592b314ef94867a42ed85b1d3a2de8fdf9.1204270367.git.michael@ellerman.id.au>
In-Reply-To: <fdd3edc0f2f3d2d6cade5cd695b8080d0da95a7f.1204270367.git.michael@ellerman.id.au>
References: <fdd3edc0f2f3d2d6cade5cd695b8080d0da95a7f.1204270367.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 6/8] Cell IOMMU: n_pte_pages is in 4K page units,
	not IOMMU_PAGE_SIZE
Date: Fri, 29 Feb 2008 18:33:26 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We use n_pte_pages to calculate the stride through the page tables, but
we also use it to set the NPPT value in the segment table entry. That is
defined as the number of 4K pages per segment, so we should calculate
it as such regardless of the IOMMU page size.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/iommu.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 187a723..7a861cb 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -348,9 +348,8 @@ static unsigned long *cell_iommu_alloc_ptab(struct cbe_iommu *iommu,
 	ptab = page_address(page);
 	memset(ptab, 0, ptab_size);
 
-	/* number of pages needed for a page table */
-	n_pte_pages = (pages_per_segment *
-		       sizeof(unsigned long)) >> IOMMU_PAGE_SHIFT;
+	/* number of 4K pages needed for a page table */
+	n_pte_pages = (pages_per_segment * sizeof(unsigned long)) >> 12;
 
 	pr_debug("%s: iommu[%d]: stab at %p, ptab at %p, n_pte_pages: %lu\n",
 			__FUNCTION__, iommu->nid, iommu->stab, ptab,
@@ -377,8 +376,8 @@ static unsigned long *cell_iommu_alloc_ptab(struct cbe_iommu *iommu,
 			pr_debug("\toverlap at %d, skipping\n", i);
 			continue;
 		}
-		iommu->stab[i] = reg | (__pa(ptab) + n_pte_pages *
-					IOMMU_PAGE_SIZE * (i - start_seg));
+		iommu->stab[i] = reg | (__pa(ptab) + (n_pte_pages << 12) *
+					(i - start_seg));
 		pr_debug("\t[%d] 0x%016lx\n", i, iommu->stab[i]);
 	}
 
-- 
1.5.2.rc1.1884.g59b20
