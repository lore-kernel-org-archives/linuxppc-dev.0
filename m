Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 412BHQ3vg5zF36K
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 15:46:42 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH kernel 1/6] powerpc/powernv: Remove useless wrapper
Date: Fri,  8 Jun 2018 15:46:28 +1000
Message-Id: <20180608054633.18659-2-aik@ozlabs.ru>
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

This gets rid of a useless wrapper around
pnv_pci_ioda2_table_free_pages().

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 29f798c..d4c60b6 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2206,11 +2206,6 @@ static void pnv_ioda2_tce_free(struct iommu_table *tbl, long index,
 	pnv_pci_ioda2_tce_invalidate(tbl, index, npages, false);
 }
 
-static void pnv_ioda2_table_free(struct iommu_table *tbl)
-{
-	pnv_pci_ioda2_table_free_pages(tbl);
-}
-
 static struct iommu_table_ops pnv_ioda2_iommu_ops = {
 	.set = pnv_ioda2_tce_build,
 #ifdef CONFIG_IOMMU_API
@@ -2219,7 +2214,7 @@ static struct iommu_table_ops pnv_ioda2_iommu_ops = {
 #endif
 	.clear = pnv_ioda2_tce_free,
 	.get = pnv_tce_get,
-	.free = pnv_ioda2_table_free,
+	.free = pnv_pci_ioda2_table_free_pages,
 };
 
 static int pnv_pci_ioda_dev_dma_weight(struct pci_dev *dev, void *data)
-- 
2.11.0
