Return-Path: <aik@ozlabs.ru>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4A41E1A0B87
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:32:45 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 10 Apr 2015 16:32:44 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 71FDE2BB005D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:32:42 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3A6WYh18257782
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:32:42 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3A6W8Ju023204
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:32:08 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v8 26/31] powerpc/iommu: Add userspace view of TCE table
Date: Fri, 10 Apr 2015 16:31:08 +1000
Message-Id: <1428647473-11738-27-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
References: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
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
v8:
* added ENOMEM on failed vzalloc()
---
 arch/powerpc/include/asm/iommu.h          |  6 ++++++
 arch/powerpc/kernel/iommu.c               |  9 +++++++++
 arch/powerpc/platforms/powernv/pci-ioda.c | 25 ++++++++++++++++++++++++-
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 2c08c91..a768a4d 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -106,9 +106,15 @@ struct iommu_table {
 	unsigned long *it_map;       /* A simple allocation bitmap for now */
 	unsigned long  it_page_shift;/* table iommu page size */
 	struct iommu_table_group *it_group;
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
index 0bcd988..833b396 100644
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
@@ -1069,6 +1070,11 @@ static int iommu_table_take_ownership(struct iommu_table *tbl)
 		spin_unlock(&tbl->pools[i].lock);
 	spin_unlock_irqrestore(&tbl->large_pool.lock, flags);
 
+	BUG_ON(tbl->it_userspace);
+	tbl->it_userspace = vzalloc(sizeof(*tbl->it_userspace) * tbl->it_size);
+	if (!tbl->it_userspace)
+		return -ENOMEM;
+
 	return 0;
 }
 
@@ -1102,6 +1108,9 @@ static void iommu_table_release_ownership(struct iommu_table *tbl)
 {
 	unsigned long flags, i, sz = (tbl->it_size + 7) >> 3;
 
+	vfree(tbl->it_userspace);
+	tbl->it_userspace = NULL;
+
 	spin_lock_irqsave(&tbl->large_pool.lock, flags);
 	for (i = 0; i < tbl->nr_pools; i++)
 		spin_lock(&tbl->pools[i].lock);
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 751aeab..3ac523d 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -26,6 +26,7 @@
 #include <linux/iommu.h>
 #include <linux/mmzone.h>
 #include <linux/sizes.h>
+#include <linux/vmalloc.h>
 
 #include <asm/mmzone.h>
 #include <asm/sections.h>
@@ -1469,6 +1470,9 @@ static void pnv_pci_free_table(struct iommu_table *tbl)
 	if (!tbl->it_size)
 		return;
 
+	vfree(tbl->it_userspace);
+	tbl->it_userspace = NULL;
+
 	pnv_free_tce_table(tbl->it_base, size, tbl->it_indirect_levels);
 	iommu_reset_table(tbl, "ioda2");
 }
@@ -1656,9 +1660,28 @@ static void pnv_ioda2_set_ownership(struct iommu_table_group *table_group,
 	pnv_pci_ioda2_set_bypass(pe, !enable);
 }
 
+static long pnv_pci_ioda2_create_table_with_uas(
+		struct iommu_table_group *table_group,
+		int num, __u32 page_shift, __u64 window_size, __u32 levels,
+		struct iommu_table *tbl)
+{
+	long ret = pnv_pci_ioda2_create_table(table_group, num,
+			page_shift, window_size, levels, tbl);
+
+	if (ret)
+		return ret;
+
+	BUG_ON(tbl->it_userspace);
+	tbl->it_userspace = vzalloc(sizeof(*tbl->it_userspace) * tbl->it_size);
+	if (!tbl->it_userspace)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static struct iommu_table_group_ops pnv_pci_ioda2_ops = {
 	.set_ownership = pnv_ioda2_set_ownership,
-	.create_table = pnv_pci_ioda2_create_table,
+	.create_table = pnv_pci_ioda2_create_table_with_uas,
 	.set_window = pnv_pci_ioda2_set_window,
 	.unset_window = pnv_pci_ioda2_unset_window,
 };
-- 
2.0.0
