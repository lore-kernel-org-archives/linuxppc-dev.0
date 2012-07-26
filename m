Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 05/18] powerpc/pasemi: Remove uses of virt_to_abs() and
 abs_to_virt()
Date: Thu, 26 Jul 2012 17:19:51 +1000
Message-Id: <1343287204-7700-5-git-send-email-michael@ellerman.id.au>
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

These days they are just wrappers around __pa() and __va() respectively.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pasemi/iommu.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pasemi/iommu.c b/arch/powerpc/platforms/pasemi/iommu.c
index 14943ef..f03fbc2 100644
--- a/arch/powerpc/platforms/pasemi/iommu.c
+++ b/arch/powerpc/platforms/pasemi/iommu.c
@@ -24,7 +24,6 @@
 #include <linux/pci.h>
 #include <asm/iommu.h>
 #include <asm/machdep.h>
-#include <asm/abs_addr.h>
 #include <asm/firmware.h>
 
 #define IOBMAP_PAGE_SHIFT	12
@@ -99,7 +98,7 @@ static int iobmap_build(struct iommu_table *tbl, long index,
 	ip = ((u32 *)tbl->it_base) + index;
 
 	while (npages--) {
-		rpn = virt_to_abs(uaddr) >> IOBMAP_PAGE_SHIFT;
+		rpn = __pa(uaddr) >> IOBMAP_PAGE_SHIFT;
 
 		*(ip++) = IOBMAP_L2E_V | rpn;
 		/* invalidate tlb, can be optimized more */
@@ -258,7 +257,7 @@ void __init alloc_iobmap_l2(void)
 	return;
 #endif
 	/* For 2G space, 8x64 pages (2^21 bytes) is max total l2 size */
-	iob_l2_base = (u32 *)abs_to_virt(memblock_alloc_base(1UL<<21, 1UL<<21, 0x80000000));
+	iob_l2_base = (u32 *)__va(memblock_alloc_base(1UL<<21, 1UL<<21, 0x80000000));
 
 	printk(KERN_INFO "IOBMAP L2 allocated at: %p\n", iob_l2_base);
 }
-- 
1.7.9.5
