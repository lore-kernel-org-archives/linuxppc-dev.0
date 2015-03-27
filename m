Return-Path: <aik@ozlabs.ru>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 049581A0A1C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 01:57:20 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Sat, 28 Mar 2015 00:57:19 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id DC4632BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 01:57:16 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2REv82g34799712
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 01:57:16 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2REuh5I028115
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 01:56:43 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v7 26/31] powerpc/iommu: Add userspace view of TCE table
Date: Sat, 28 Mar 2015 01:55:10 +1100
Message-Id: <1427468115-2224-27-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1427468115-2224-1-git-send-email-aik@ozlabs.ru>
References: <1427468115-2224-1-git-send-email-aik@ozlabs.ru>
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
 arch/powerpc/include/asm/iommu.h          |  6 ++++++
 arch/powerpc/kernel/iommu.c               |  7 +++++++
 arch/powerpc/platforms/powernv/pci-ioda.c | 23 ++++++++++++++++++++++-
 3 files changed, 35 insertions(+), 1 deletion(-)

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
index 0bcd988..82102d1 100644
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
@@ -1069,6 +1070,9 @@ static int iommu_table_take_ownership(struct iommu_table *tbl)
 		spin_unlock(&tbl->pools[i].lock);
 	spin_unlock_irqrestore(&tbl->large_pool.lock, flags);
 
+	BUG_ON(tbl->it_userspace);
+	tbl->it_userspace = vzalloc(sizeof(*tbl->it_userspace) * tbl->it_size);
+
 	return 0;
 }
 
@@ -1102,6 +1106,9 @@ static void iommu_table_release_ownership(struct iommu_table *tbl)
 {
 	unsigned long flags, i, sz = (tbl->it_size + 7) >> 3;
 
+	vfree(tbl->it_userspace);
+	tbl->it_userspace = NULL;
+
 	spin_lock_irqsave(&tbl->large_pool.lock, flags);
 	for (i = 0; i < tbl->nr_pools; i++)
 		spin_lock(&tbl->pools[i].lock);
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index bc36cf1..036f3c1 100644
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
 
+	if (tbl->it_userspace)
+		vfree(tbl->it_userspace);
+
 	pnv_free_tce_table(tbl->it_base, size, tbl->it_indirect_levels);
 	iommu_reset_table(tbl, "ioda2");
 }
@@ -1656,9 +1660,26 @@ static void pnv_ioda2_set_ownership(struct iommu_table_group *table_group,
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
