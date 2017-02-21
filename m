Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vS4fD4PGJzDqBv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 13:47:16 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH kernel] powerpc/powernv: Fix it_ops::get() callback to return
 in cpu endian
Date: Tue, 21 Feb 2017 13:38:54 +1100
Message-Id: <20170221023854.47493-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The iommu_table_ops callbacks are declared CPU endian as they take and
return "unsigned long"; underlying hardware tables are big-endian.

However get() was missing be64_to_cpu(), this adds the missing conversion.

The only caller of this is crash dump at arch/powerpc/kernel/iommu.c,
iommu_table_clear() which only compares TCE to zero so this change
should not cause behavioral change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index c6d554fe585c..3f7f267a3d04 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -758,7 +758,7 @@ void pnv_tce_free(struct iommu_table *tbl, long index, long npages)
 
 unsigned long pnv_tce_get(struct iommu_table *tbl, long index)
 {
-	return *(pnv_tce(tbl, index - tbl->it_offset));
+	return be64_to_cpu(*(pnv_tce(tbl, index - tbl->it_offset)));
 }
 
 struct iommu_table *pnv_pci_table_alloc(int nid)
-- 
2.11.0
