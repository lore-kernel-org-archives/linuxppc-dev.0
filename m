Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vYmR74YQ2zDqJC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 19:57:23 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel v6 02/10] powerpc/powernv/iommu: Add real mode version
 of iommu_table_ops::exchange()
Date: Thu,  2 Mar 2017 19:56:36 +1100
Message-Id: <20170302085644.41828-3-aik@ozlabs.ru>
In-Reply-To: <20170302085644.41828-1-aik@ozlabs.ru>
References: <20170302085644.41828-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In real mode, TCE tables are invalidated using special
cache-inhibited store instructions which are not available in
virtual mode

This defines and implements exchange_rm() callback. This does not
define set_rm/clear_rm/flush_rm callbacks as there is no user for those -
exchange/exchange_rm are only to be used by KVM for VFIO.

The exchange_rm callback is defined for IODA1/IODA2 powernv platforms.

This replaces list_for_each_entry_rcu with its lockless version as
from now on pnv_pci_ioda2_tce_invalidate() can be called in
the real mode too.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/include/asm/iommu.h          |  7 +++++++
 arch/powerpc/kernel/iommu.c               | 23 +++++++++++++++++++++++
 arch/powerpc/platforms/powernv/pci-ioda.c | 26 +++++++++++++++++++++++++-
 3 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 2c1d50792944..4554699aec02 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -64,6 +64,11 @@ struct iommu_table_ops {
 			long index,
 			unsigned long *hpa,
 			enum dma_data_direction *direction);
+	/* Real mode */
+	int (*exchange_rm)(struct iommu_table *tbl,
+			long index,
+			unsigned long *hpa,
+			enum dma_data_direction *direction);
 #endif
 	void (*clear)(struct iommu_table *tbl,
 			long index, long npages);
@@ -208,6 +213,8 @@ extern void iommu_del_device(struct device *dev);
 extern int __init tce_iommu_bus_notifier_init(void);
 extern long iommu_tce_xchg(struct iommu_table *tbl, unsigned long entry,
 		unsigned long *hpa, enum dma_data_direction *direction);
+extern long iommu_tce_xchg_rm(struct iommu_table *tbl, unsigned long entry,
+		unsigned long *hpa, enum dma_data_direction *direction);
 #else
 static inline void iommu_register_group(struct iommu_table_group *table_group,
 					int pci_domain_number,
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 5f202a566ec5..9bace5df05d5 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -1004,6 +1004,29 @@ long iommu_tce_xchg(struct iommu_table *tbl, unsigned long entry,
 }
 EXPORT_SYMBOL_GPL(iommu_tce_xchg);
 
+long iommu_tce_xchg_rm(struct iommu_table *tbl, unsigned long entry,
+		unsigned long *hpa, enum dma_data_direction *direction)
+{
+	long ret;
+
+	ret = tbl->it_ops->exchange_rm(tbl, entry, hpa, direction);
+
+	if (!ret && ((*direction == DMA_FROM_DEVICE) ||
+			(*direction == DMA_BIDIRECTIONAL))) {
+		struct page *pg = realmode_pfn_to_page(*hpa >> PAGE_SHIFT);
+
+		if (likely(pg)) {
+			SetPageDirty(pg);
+		} else {
+			tbl->it_ops->exchange_rm(tbl, entry, hpa, direction);
+			ret = -EFAULT;
+		}
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_tce_xchg_rm);
+
 int iommu_take_ownership(struct iommu_table *tbl)
 {
 	unsigned long flags, i, sz = (tbl->it_size + 7) >> 3;
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index ec58b7f6b6cf..69c40b43daa3 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1861,6 +1861,17 @@ static int pnv_ioda1_tce_xchg(struct iommu_table *tbl, long index,
 
 	return ret;
 }
+
+static int pnv_ioda1_tce_xchg_rm(struct iommu_table *tbl, long index,
+		unsigned long *hpa, enum dma_data_direction *direction)
+{
+	long ret = pnv_tce_xchg(tbl, index, hpa, direction);
+
+	if (!ret)
+		pnv_pci_p7ioc_tce_invalidate(tbl, index, 1, true);
+
+	return ret;
+}
 #endif
 
 static void pnv_ioda1_tce_free(struct iommu_table *tbl, long index,
@@ -1875,6 +1886,7 @@ static struct iommu_table_ops pnv_ioda1_iommu_ops = {
 	.set = pnv_ioda1_tce_build,
 #ifdef CONFIG_IOMMU_API
 	.exchange = pnv_ioda1_tce_xchg,
+	.exchange_rm = pnv_ioda1_tce_xchg_rm,
 #endif
 	.clear = pnv_ioda1_tce_free,
 	.get = pnv_tce_get,
@@ -1949,7 +1961,7 @@ static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
 {
 	struct iommu_table_group_link *tgl;
 
-	list_for_each_entry_rcu(tgl, &tbl->it_group_list, next) {
+	list_for_each_entry_lockless(tgl, &tbl->it_group_list, next) {
 		struct pnv_ioda_pe *pe = container_of(tgl->table_group,
 				struct pnv_ioda_pe, table_group);
 		struct pnv_phb *phb = pe->phb;
@@ -2005,6 +2017,17 @@ static int pnv_ioda2_tce_xchg(struct iommu_table *tbl, long index,
 
 	return ret;
 }
+
+static int pnv_ioda2_tce_xchg_rm(struct iommu_table *tbl, long index,
+		unsigned long *hpa, enum dma_data_direction *direction)
+{
+	long ret = pnv_tce_xchg(tbl, index, hpa, direction);
+
+	if (!ret)
+		pnv_pci_ioda2_tce_invalidate(tbl, index, 1, true);
+
+	return ret;
+}
 #endif
 
 static void pnv_ioda2_tce_free(struct iommu_table *tbl, long index,
@@ -2025,6 +2048,7 @@ static struct iommu_table_ops pnv_ioda2_iommu_ops = {
 	.set = pnv_ioda2_tce_build,
 #ifdef CONFIG_IOMMU_API
 	.exchange = pnv_ioda2_tce_xchg,
+	.exchange_rm = pnv_ioda2_tce_xchg_rm,
 #endif
 	.clear = pnv_ioda2_tce_free,
 	.get = pnv_tce_get,
-- 
2.11.0
