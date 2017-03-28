Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vsdl46RtYzDqb9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 15:51:12 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH kernel] powerpc/powernv/iommu: Fix compile breakage in
 iommu_tce_xchg_rm
Date: Tue, 28 Mar 2017 15:51:07 +1100
Message-Id: <20170328045107.45863-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

Please squash it into:
[02/10] powerpc/powernv/iommu: Add real mode version of iommu_table_ops::exchange()
---
 arch/powerpc/kernel/iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 9bace5df05d5..685a4767b722 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -1004,6 +1004,7 @@ long iommu_tce_xchg(struct iommu_table *tbl, unsigned long entry,
 }
 EXPORT_SYMBOL_GPL(iommu_tce_xchg);
 
+#ifdef CONFIG_PPC_BOOK3S_64
 long iommu_tce_xchg_rm(struct iommu_table *tbl, unsigned long entry,
 		unsigned long *hpa, enum dma_data_direction *direction)
 {
@@ -1026,6 +1027,7 @@ long iommu_tce_xchg_rm(struct iommu_table *tbl, unsigned long entry,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_tce_xchg_rm);
+#endif
 
 int iommu_take_ownership(struct iommu_table *tbl)
 {
-- 
2.11.0
