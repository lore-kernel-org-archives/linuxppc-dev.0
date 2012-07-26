Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 11/18] powerpc/pseries: Remove uses of abs_to_virt() and
 virt_to_abs()
Date: Thu, 26 Jul 2012 17:19:57 +1000
Message-Id: <1343287204-7700-11-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1343287204-7700-1-git-send-email-michael@ellerman.id.au>
References: <1343287204-7700-1-git-send-email-michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These days they are just __va() and __pa() respectively.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/iommu.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 2d311c0..7393118 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -41,7 +41,6 @@
 #include <asm/iommu.h>
 #include <asm/pci-bridge.h>
 #include <asm/machdep.h>
-#include <asm/abs_addr.h>
 #include <asm/pSeries_reconfig.h>
 #include <asm/firmware.h>
 #include <asm/tce.h>
@@ -99,7 +98,7 @@ static int tce_build_pSeries(struct iommu_table *tbl, long index,
 
 	while (npages--) {
 		/* can't move this out since we might cross MEMBLOCK boundary */
-		rpn = (virt_to_abs(uaddr)) >> TCE_SHIFT;
+		rpn = __pa(uaddr) >> TCE_SHIFT;
 		*tcep = proto_tce | (rpn & TCE_RPN_MASK) << TCE_RPN_SHIFT;
 
 		uaddr += TCE_PAGE_SIZE;
@@ -148,7 +147,7 @@ static int tce_build_pSeriesLP(struct iommu_table *tbl, long tcenum,
 	int ret = 0;
 	long tcenum_start = tcenum, npages_start = npages;
 
-	rpn = (virt_to_abs(uaddr)) >> TCE_SHIFT;
+	rpn = __pa(uaddr) >> TCE_SHIFT;
 	proto_tce = TCE_PCI_READ;
 	if (direction != DMA_TO_DEVICE)
 		proto_tce |= TCE_PCI_WRITE;
@@ -213,7 +212,7 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 		__get_cpu_var(tce_page) = tcep;
 	}
 
-	rpn = (virt_to_abs(uaddr)) >> TCE_SHIFT;
+	rpn = __pa(uaddr) >> TCE_SHIFT;
 	proto_tce = TCE_PCI_READ;
 	if (direction != DMA_TO_DEVICE)
 		proto_tce |= TCE_PCI_WRITE;
@@ -233,7 +232,7 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 
 		rc = plpar_tce_put_indirect((u64)tbl->it_index,
 					    (u64)tcenum << 12,
-					    (u64)virt_to_abs(tcep),
+					    (u64)__pa(tcep),
 					    limit);
 
 		npages -= limit;
@@ -435,7 +434,7 @@ static int tce_setrange_multi_pSeriesLP(unsigned long start_pfn,
 
 		rc = plpar_tce_put_indirect(liobn,
 					    dma_offset,
-					    (u64)virt_to_abs(tcep),
+					    (u64)__pa(tcep),
 					    limit);
 
 		num_tce -= limit;
-- 
1.7.9.5
