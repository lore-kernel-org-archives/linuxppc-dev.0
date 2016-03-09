Return-Path: <aik@ozlabs.ru>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8243F1A0060
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 20:48:54 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Wed, 9 Mar 2016 16:30:48 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E5833357805B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 17:30:29 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u296ULmx21364770
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2016 17:30:29 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u296TvPf024485
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2016 17:29:57 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Daniel Axtens <dja@axtens.net>, David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Russell Currey <ruscur@russell.cc>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH kernel 09/10] powerpc/powernv/ioda2: Export some helpers
Date: Wed,  9 Mar 2016 17:29:05 +1100
Message-Id: <1457504946-40649-10-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1457504946-40649-1-git-send-email-aik@ozlabs.ru>
References: <1457504946-40649-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We are going to support VFIO on NPU PHB type which will share some code
with the normal IODA2 PHB.

This exports pnv_pci_ioda2_create_table and pnv_pci_ioda2_get_table_size.

This exports debugging helper pe_level_printk() as well.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 13 +++----------
 arch/powerpc/platforms/powernv/pci.h      | 15 +++++++++++++++
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index becd168..1a96498 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -56,7 +56,7 @@
 
 static void pnv_pci_ioda2_table_free_pages(struct iommu_table *tbl);
 
-static void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
+void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
 			    const char *fmt, ...)
 {
 	struct va_format vaf;
@@ -87,13 +87,6 @@ static void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
 	va_end(args);
 }
 
-#define pe_err(pe, fmt, ...)					\
-	pe_level_printk(pe, KERN_ERR, fmt, ##__VA_ARGS__)
-#define pe_warn(pe, fmt, ...)					\
-	pe_level_printk(pe, KERN_WARNING, fmt, ##__VA_ARGS__)
-#define pe_info(pe, fmt, ...)					\
-	pe_level_printk(pe, KERN_INFO, fmt, ##__VA_ARGS__)
-
 static bool pnv_iommu_bypass_disabled __read_mostly;
 
 static int __init iommu_setup(char *str)
@@ -2130,7 +2123,7 @@ static long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
 		__u32 page_shift, __u64 window_size, __u32 levels,
 		struct iommu_table *tbl);
 
-static long pnv_pci_ioda2_create_table(struct iommu_table_group *table_group,
+long pnv_pci_ioda2_create_table(struct iommu_table_group *table_group,
 		int num, __u32 page_shift, __u64 window_size, __u32 levels,
 		struct iommu_table **ptbl)
 {
@@ -2246,7 +2239,7 @@ static long pnv_pci_ioda2_unset_window(struct iommu_table_group *table_group,
 #endif
 
 #ifdef CONFIG_IOMMU_API
-static unsigned long pnv_pci_ioda2_get_table_size(__u32 page_shift,
+unsigned long pnv_pci_ioda2_get_table_size(__u32 page_shift,
 		__u64 window_size, __u32 levels)
 {
 	unsigned long bytes = 0;
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 0c0083a..3017717d 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -232,6 +232,21 @@ extern void pnv_pci_dma_bus_setup(struct pci_bus *bus);
 extern int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type);
 extern void pnv_teardown_msi_irqs(struct pci_dev *pdev);
 
+extern unsigned long pnv_pci_ioda2_get_table_size(__u32 page_shift,
+		__u64 window_size, __u32 levels);
+extern long pnv_pci_ioda2_create_table(struct iommu_table_group *table_group,
+		int num, __u32 page_shift, __u64 window_size, __u32 levels,
+		struct iommu_table **ptbl);
+
+extern void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
+			    const char *fmt, ...);
+#define pe_err(pe, fmt, ...)					\
+	pe_level_printk(pe, KERN_ERR, fmt, ##__VA_ARGS__)
+#define pe_warn(pe, fmt, ...)					\
+	pe_level_printk(pe, KERN_WARNING, fmt, ##__VA_ARGS__)
+#define pe_info(pe, fmt, ...)					\
+	pe_level_printk(pe, KERN_INFO, fmt, ##__VA_ARGS__)
+
 /* Nvlink functions */
 extern void pnv_npu_try_dma_set_bypass(struct pci_dev *gpdev, bool bypass);
 extern void pnv_pci_ioda2_tce_invalidate_entire(struct pnv_phb *phb, bool rm);
-- 
2.5.0.rc3
