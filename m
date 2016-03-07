Return-Path: <aik@ozlabs.ru>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7C8801A01EC
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 14:42:23 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Mon, 7 Mar 2016 13:42:21 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 4719C2BB005B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 14:42:15 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u273g7bw22675642
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 14:42:15 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u273fg2X020858
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 14:41:43 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel 4/9] powerpc/powernv/iommu: Add real mode version of
 xchg()
Date: Mon,  7 Mar 2016 14:41:12 +1100
Message-Id: <1457322077-26640-5-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1457322077-26640-1-git-send-email-aik@ozlabs.ru>
References: <1457322077-26640-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In real mode, TCE tables are invalidated using different
cache-inhibited store instructions which is different from
the virtual mode.

This defines and implements exchange_rm() callback. This does not
define set_rm/clear_rm/flush_rm callbacks as there is no user for those -
exchange/exchange_rm are only to be used by KVM for VFIO.

The exchange_rm callback is defined for IODA1/IODA2 powernv platforms.

This replaces list_for_each_entry_rcu with its lockless version as
from now on pnv_pci_ioda2_tce_invalidate() can be called in
the real mode too.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/iommu.h          |  7 +++++++
 arch/powerpc/kernel/iommu.c               | 15 +++++++++++++++
 arch/powerpc/platforms/powernv/pci-ioda.c | 28 +++++++++++++++++++++++++++-
 3 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 7b87bab..3ca877a 100644
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
index a8e3490..2fcc48b 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -1062,6 +1062,21 @@ void iommu_release_ownership(struct iommu_table *tbl)
 }
 EXPORT_SYMBOL_GPL(iommu_release_ownership);
 
+long iommu_tce_xchg_rm(struct iommu_table *tbl, unsigned long entry,
+		unsigned long *hpa, enum dma_data_direction *direction)
+{
+	long ret;
+
+	ret = tbl->it_ops->exchange_rm(tbl, entry, hpa, direction);
+
+	if (!ret && ((*direction == DMA_FROM_DEVICE) ||
+			(*direction == DMA_BIDIRECTIONAL)))
+		SetPageDirty(realmode_pfn_to_page(*hpa >> PAGE_SHIFT));
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_tce_xchg_rm);
+
 int iommu_add_device(struct device *dev)
 {
 	struct iommu_table *tbl;
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index c5baaf3..bed1944 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1791,6 +1791,18 @@ static int pnv_ioda1_tce_xchg(struct iommu_table *tbl, long index,
 
 	return ret;
 }
+
+static int pnv_ioda1_tce_xchg_rm(struct iommu_table *tbl, long index,
+		unsigned long *hpa, enum dma_data_direction *direction)
+{
+	long ret = pnv_tce_xchg(tbl, index, hpa, direction);
+
+	if (!ret && (tbl->it_type &
+			(TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE)))
+		pnv_pci_ioda1_tce_invalidate(tbl, index, 1, true);
+
+	return ret;
+}
 #endif
 
 static void pnv_ioda1_tce_free(struct iommu_table *tbl, long index,
@@ -1806,6 +1818,7 @@ static struct iommu_table_ops pnv_ioda1_iommu_ops = {
 	.set = pnv_ioda1_tce_build,
 #ifdef CONFIG_IOMMU_API
 	.exchange = pnv_ioda1_tce_xchg,
+	.exchange_rm = pnv_ioda1_tce_xchg_rm,
 #endif
 	.clear = pnv_ioda1_tce_free,
 	.get = pnv_tce_get,
@@ -1866,7 +1879,7 @@ static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
 {
 	struct iommu_table_group_link *tgl;
 
-	list_for_each_entry_rcu(tgl, &tbl->it_group_list, next) {
+	list_for_each_entry_lockless(tgl, &tbl->it_group_list, next) {
 		struct pnv_ioda_pe *npe;
 		struct pnv_ioda_pe *pe = container_of(tgl->table_group,
 				struct pnv_ioda_pe, table_group);
@@ -1918,6 +1931,18 @@ static int pnv_ioda2_tce_xchg(struct iommu_table *tbl, long index,
 
 	return ret;
 }
+
+static int pnv_ioda2_tce_xchg_rm(struct iommu_table *tbl, long index,
+		unsigned long *hpa, enum dma_data_direction *direction)
+{
+	long ret = pnv_tce_xchg(tbl, index, hpa, direction);
+
+	if (!ret && (tbl->it_type &
+			(TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE)))
+		pnv_pci_ioda2_tce_invalidate(tbl, index, 1, true);
+
+	return ret;
+}
 #endif
 
 static void pnv_ioda2_tce_free(struct iommu_table *tbl, long index,
@@ -1939,6 +1964,7 @@ static struct iommu_table_ops pnv_ioda2_iommu_ops = {
 	.set = pnv_ioda2_tce_build,
 #ifdef CONFIG_IOMMU_API
 	.exchange = pnv_ioda2_tce_xchg,
+	.exchange_rm = pnv_ioda2_tce_xchg_rm,
 #endif
 	.clear = pnv_ioda2_tce_free,
 	.get = pnv_tce_get,
-- 
2.5.0.rc3
