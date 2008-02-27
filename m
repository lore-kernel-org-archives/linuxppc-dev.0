Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <e96ccaf5ebb1f1f7908a2e54702fb10286fdb5b6.1204097262.git.michael@ellerman.id.au>
In-Reply-To: <4108415683edeb799fd4880a8dba3e9f27a34415.1204097262.git.michael@ellerman.id.au>
References: <4108415683edeb799fd4880a8dba3e9f27a34415.1204097262.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 2/8] Use it_offset not pte_offset in cell IOMMU code
Date: Wed, 27 Feb 2008 18:28:14 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The cell IOMMU tce build and free routines use pte_offset to convert
the index passed from the generic IOMMU code into a page table offset.

This takes into account the SPIDER_DMA_OFFSET which sets the top bit
of every DMA address.

However it doesn't cater for the IOMMU window starting at a non-zero
address, as the base of the window is not incorporated into pte_offset
at all.

As it turns out tbl->it_offset already contains the value we need, it
takes into account the base of the window and also pte_offset. So use
it instead!

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/iommu.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index bbe8389..4e75919 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -200,7 +200,7 @@ static void tce_build_cell(struct iommu_table *tbl, long index, long npages,
 		(window->ioid & IOPTE_IOID_Mask);
 #endif
 
-	io_pte = (unsigned long *)tbl->it_base + (index - window->pte_offset);
+	io_pte = (unsigned long *)tbl->it_base + (index - tbl->it_offset);
 
 	for (i = 0; i < npages; i++, uaddr += IOMMU_PAGE_SIZE)
 		io_pte[i] = base_pte | (__pa(uaddr) & IOPTE_RPN_Mask);
@@ -232,7 +232,7 @@ static void tce_free_cell(struct iommu_table *tbl, long index, long npages)
 		| (window->ioid & IOPTE_IOID_Mask);
 #endif
 
-	io_pte = (unsigned long *)tbl->it_base + (index - window->pte_offset);
+	io_pte = (unsigned long *)tbl->it_base + (index - tbl->it_offset);
 
 	for (i = 0; i < npages; i++)
 		io_pte[i] = pte;
-- 
1.5.2.rc1.1884.g59b20
