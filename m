Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 412BHc0wJ1zF36K
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 15:46:50 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH kernel 5/6] powerpc/powernv: Rework TCE level allocation
Date: Fri,  8 Jun 2018 15:46:32 +1000
Message-Id: <20180608054633.18659-6-aik@ozlabs.ru>
In-Reply-To: <20180608054633.18659-1-aik@ozlabs.ru>
References: <20180608054633.18659-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This moves actual pages allocation to a separate function which is going
to be reused later in on-demand TCE allocation.

While we are at it, remove unnecessary level size round up as the caller
does this already.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci-ioda-tce.c | 30 +++++++++++++++++----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda-tce.c b/arch/powerpc/platforms/powernv/pci-ioda-tce.c
index f14b282..36c2eb0 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda-tce.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda-tce.c
@@ -31,6 +31,23 @@ void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
 	tbl->it_type = TCE_PCI;
 }
 
+static __be64 *pnv_alloc_tce_level(int nid, unsigned int shift)
+{
+	struct page *tce_mem = NULL;
+	__be64 *addr;
+
+	tce_mem = alloc_pages_node(nid, GFP_KERNEL, shift - PAGE_SHIFT);
+	if (!tce_mem) {
+		pr_err("Failed to allocate a TCE memory, level shift=%d\n",
+				shift);
+		return NULL;
+	}
+	addr = page_address(tce_mem);
+	memset(addr, 0, 1UL << shift);
+
+	return addr;
+}
+
 static __be64 *pnv_tce(struct iommu_table *tbl, bool user, long idx)
 {
 	__be64 *tmp = user ? tbl->it_userspace : (__be64 *) tbl->it_base;
@@ -165,21 +182,12 @@ static __be64 *pnv_pci_ioda2_table_do_alloc_pages(int nid, unsigned int shift,
 		unsigned int levels, unsigned long limit,
 		unsigned long *current_offset, unsigned long *total_allocated)
 {
-	struct page *tce_mem = NULL;
 	__be64 *addr, *tmp;
-	unsigned int order = max_t(unsigned int, shift, PAGE_SHIFT) -
-			PAGE_SHIFT;
-	unsigned long allocated = 1UL << (order + PAGE_SHIFT);
+	unsigned long allocated = 1UL << shift;
 	unsigned int entries = 1UL << (shift - 3);
 	long i;
 
-	tce_mem = alloc_pages_node(nid, GFP_KERNEL, order);
-	if (!tce_mem) {
-		pr_err("Failed to allocate a TCE memory, order=%d\n", order);
-		return NULL;
-	}
-	addr = page_address(tce_mem);
-	memset(addr, 0, allocated);
+	addr = pnv_alloc_tce_level(nid, shift);
 	*total_allocated += allocated;
 
 	--levels;
-- 
2.11.0
