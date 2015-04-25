Return-Path: <aik@ozlabs.ru>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4A6A91A0C47
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:47 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Sat, 25 Apr 2015 22:16:46 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 5A2AD3578047
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:44 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3PCGaDM29425720
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:44 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3PCGAfv030212
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:11 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v9 26/32] powerpc/iommu: Add userspace view of TCE table
Date: Sat, 25 Apr 2015 22:14:50 +1000
Message-Id: <1429964096-11524-27-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In order to support memory pre-registration, we need a way to track
the use of every registered memory region and only allow unregistration
if a region is not in use anymore. So we need a way to tell from what
region the just cleared TCE was from.

This adds a userspace view of the TCE table into iommu_table struct.
It contains userspace address, one per TCE entry. The table is only
allocated when the ownership over an IOMMU group is taken which means
it is only used from outside of the powernv code (such as VFIO).

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v9:
* fixed code flow in error cases added in v8

v8:
* added ENOMEM on failed vzalloc()
---
 arch/powerpc/include/asm/iommu.h          |  6 ++++++
 arch/powerpc/kernel/iommu.c               | 18 ++++++++++++++++++
 arch/powerpc/platforms/powernv/pci-ioda.c | 22 ++++++++++++++++++++--
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 7694546..1472de3 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -111,9 +111,15 @@ struct iommu_table {
 	unsigned long *it_map;       /* A simple allocation bitmap for now */
 	unsigned long  it_page_shift;/* table iommu page size */
 	struct iommu_table_group *it_table_group;
+	unsigned long *it_userspace; /* userspace view of the table */
 	struct iommu_table_ops *it_ops;
 };
 
+#define IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry) \
+		((tbl)->it_userspace ? \
+			&((tbl)->it_userspace[(entry) - (tbl)->it_offset]) : \
+			NULL)
+
 /* Pure 2^n version of get_order */
 static inline __attribute_const__
 int get_iommu_order(unsigned long size, struct iommu_table *tbl)
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 2eaba0c..74a3f52 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -38,6 +38,7 @@
 #include <linux/pci.h>
 #include <linux/iommu.h>
 #include <linux/sched.h>
+#include <linux/vmalloc.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/iommu.h>
@@ -739,6 +740,8 @@ void iommu_reset_table(struct iommu_table *tbl, const char *node_name)
 		free_pages((unsigned long) tbl->it_map, order);
 	}
 
+	WARN_ON(tbl->it_userspace);
+
 	memset(tbl, 0, sizeof(*tbl));
 }
 
@@ -1016,6 +1019,7 @@ int iommu_take_ownership(struct iommu_table *tbl)
 {
 	unsigned long flags, i, sz = (tbl->it_size + 7) >> 3;
 	int ret = 0;
+	unsigned long *uas;
 
 	/*
 	 * VFIO does not control TCE entries allocation and the guest
@@ -1027,6 +1031,10 @@ int iommu_take_ownership(struct iommu_table *tbl)
 	if (!tbl->it_ops->exchange)
 		return -EINVAL;
 
+	uas = vzalloc(sizeof(*uas) * tbl->it_size);
+	if (!uas)
+		return -ENOMEM;
+
 	spin_lock_irqsave(&tbl->large_pool.lock, flags);
 	for (i = 0; i < tbl->nr_pools; i++)
 		spin_lock(&tbl->pools[i].lock);
@@ -1044,6 +1052,13 @@ int iommu_take_ownership(struct iommu_table *tbl)
 		memset(tbl->it_map, 0xff, sz);
 	}
 
+	if (ret) {
+		vfree(uas);
+	} else {
+		BUG_ON(tbl->it_userspace);
+		tbl->it_userspace = uas;
+	}
+
 	for (i = 0; i < tbl->nr_pools; i++)
 		spin_unlock(&tbl->pools[i].lock);
 	spin_unlock_irqrestore(&tbl->large_pool.lock, flags);
@@ -1056,6 +1071,9 @@ void iommu_release_ownership(struct iommu_table *tbl)
 {
 	unsigned long flags, i, sz = (tbl->it_size + 7) >> 3;
 
+	vfree(tbl->it_userspace);
+	tbl->it_userspace = NULL;
+
 	spin_lock_irqsave(&tbl->large_pool.lock, flags);
 	for (i = 0; i < tbl->nr_pools; i++)
 		spin_lock(&tbl->pools[i].lock);
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 45bc131..e0be556 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -25,6 +25,7 @@
 #include <linux/memblock.h>
 #include <linux/iommu.h>
 #include <linux/sizes.h>
+#include <linux/vmalloc.h>
 
 #include <asm/sections.h>
 #include <asm/io.h>
@@ -1827,6 +1828,14 @@ static void pnv_ioda2_tce_free(struct iommu_table *tbl, long index,
 		pnv_pci_ioda2_tce_invalidate(tbl, index, npages, false);
 }
 
+void pnv_pci_ioda2_free_table(struct iommu_table *tbl)
+{
+	vfree(tbl->it_userspace);
+	tbl->it_userspace = NULL;
+
+	pnv_pci_free_table(tbl);
+}
+
 static struct iommu_table_ops pnv_ioda2_iommu_ops = {
 	.set = pnv_ioda2_tce_build,
 #ifdef CONFIG_IOMMU_API
@@ -1834,7 +1843,7 @@ static struct iommu_table_ops pnv_ioda2_iommu_ops = {
 #endif
 	.clear = pnv_ioda2_tce_free,
 	.get = pnv_tce_get,
-	.free = pnv_pci_free_table,
+	.free = pnv_pci_ioda2_free_table,
 };
 
 static void pnv_pci_ioda_setup_opal_tce_kill(struct pnv_phb *phb,
@@ -2062,12 +2071,21 @@ static long pnv_pci_ioda2_create_table(struct iommu_table_group *table_group,
 	int nid = pe->phb->hose->node;
 	__u64 bus_offset = num ? pe->tce_bypass_base : 0;
 	long ret;
+	unsigned long *uas, uas_cb = sizeof(*uas) * (window_size >> page_shift);
+
+	uas = vzalloc(uas_cb);
+	if (!uas)
+		return -ENOMEM;
 
 	ret = pnv_pci_create_table(table_group, nid, bus_offset, page_shift,
 			window_size, levels, tbl);
-	if (ret)
+	if (ret) {
+		vfree(uas);
 		return ret;
+	}
 
+	BUG_ON(tbl->it_userspace);
+	tbl->it_userspace = uas;
 	tbl->it_ops = &pnv_ioda2_iommu_ops;
 	if (pe->tce_inval_reg)
 		tbl->it_type |= (TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE);
-- 
2.0.0
