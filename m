Return-Path: <aik@ozlabs.ru>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 810581A0AC6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 19:09:03 +1100 (AEDT)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 13 Mar 2015 18:09:03 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 6D89F2CE8058
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 19:09:00 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2D88qeQ26935310
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 19:09:00 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2D88R43013906
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 19:08:27 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v6 22/29] powerpc/iommu: Split iommu_free_table into 2
 helpers
Date: Fri, 13 Mar 2015 19:07:30 +1100
Message-Id: <1426234057-16165-23-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1426234057-16165-1-git-send-email-aik@ozlabs.ru>
References: <1426234057-16165-1-git-send-email-aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The iommu_free_table helper release memory it is using (the TCE table and
@it_map) and release the iommu_table struct as well. We might not want
the very last step as we store iommu_table in parent structures.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/iommu.h |  1 +
 arch/powerpc/kernel/iommu.c      | 57 ++++++++++++++++++++++++----------------
 2 files changed, 35 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 6af22a4..fd118ea 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -125,6 +125,7 @@ static inline void *get_iommu_table_base(struct device *dev)
 
 extern struct iommu_table *iommu_table_alloc(int node);
 /* Frees table for an individual device node */
+extern void iommu_reset_table(struct iommu_table *tbl, const char *node_name);
 extern void iommu_free_table(struct iommu_table *tbl, const char *node_name);
 
 /* Initializes an iommu_table based in values set in the passed-in
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 2856a4a..3500bd0 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -721,24 +721,46 @@ struct iommu_table *iommu_table_alloc(int node)
 	return &table_group->tables[0];
 }
 
+void iommu_reset_table(struct iommu_table *tbl, const char *node_name)
+{
+	if (!tbl)
+		return;
+
+	if (tbl->it_map) {
+		unsigned long bitmap_sz;
+		unsigned int order;
+
+		/*
+		 * In case we have reserved the first bit, we should not emit
+		 * the warning below.
+		 */
+		if (tbl->it_offset == 0)
+			clear_bit(0, tbl->it_map);
+
+		/* verify that table contains no entries */
+		if (!bitmap_empty(tbl->it_map, tbl->it_size))
+			pr_warn("%s: Unexpected TCEs for %s\n", __func__,
+					node_name);
+
+		/* calculate bitmap size in bytes */
+		bitmap_sz = BITS_TO_LONGS(tbl->it_size) * sizeof(unsigned long);
+
+		/* free bitmap */
+		order = get_order(bitmap_sz);
+		free_pages((unsigned long) tbl->it_map, order);
+	}
+
+	memset(tbl, 0, sizeof(*tbl));
+}
+
 void iommu_free_table(struct iommu_table *tbl, const char *node_name)
 {
-	unsigned long bitmap_sz;
-	unsigned int order;
 	struct iommu_table_group *table_group = tbl->it_group;
 
-	if (!tbl || !tbl->it_map) {
-		printk(KERN_ERR "%s: expected TCE map for %s\n", __func__,
-				node_name);
+	if (!tbl)
 		return;
-	}
 
-	/*
-	 * In case we have reserved the first bit, we should not emit
-	 * the warning below.
-	 */
-	if (tbl->it_offset == 0)
-		clear_bit(0, tbl->it_map);
+	iommu_reset_table(tbl, node_name);
 
 #ifdef CONFIG_IOMMU_API
 	if (table_group->group) {
@@ -747,17 +769,6 @@ void iommu_free_table(struct iommu_table *tbl, const char *node_name)
 	}
 #endif
 
-	/* verify that table contains no entries */
-	if (!bitmap_empty(tbl->it_map, tbl->it_size))
-		pr_warn("%s: Unexpected TCEs for %s\n", __func__, node_name);
-
-	/* calculate bitmap size in bytes */
-	bitmap_sz = BITS_TO_LONGS(tbl->it_size) * sizeof(unsigned long);
-
-	/* free bitmap */
-	order = get_order(bitmap_sz);
-	free_pages((unsigned long) tbl->it_map, order);
-
 	/* free table */
 	kfree(table_group);
 }
-- 
2.0.0
