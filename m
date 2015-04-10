Return-Path: <aik@ozlabs.ru>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AC8D61A074E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:32:46 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 10 Apr 2015 16:32:46 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id DFEE32CE804E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:32:43 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3A6WZP430408954
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:32:43 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3A6WA6j010131
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:32:10 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v8 13/31] vfio: powerpc/spapr: powerpc/iommu: Rework
 IOMMU ownership control
Date: Fri, 10 Apr 2015 16:30:55 +1000
Message-Id: <1428647473-11738-14-git-send-email-aik@ozlabs.ru>
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

This replaces iommu_take_ownership()/iommu_release_ownership() calls
with the callback calls and it is up to the platform code to call
iommu_take_ownership()/iommu_release_ownership() if needed.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/iommu.h    |  4 +--
 arch/powerpc/kernel/iommu.c         | 50 ++++++++++++++++++++++++++++---------
 drivers/vfio/vfio_iommu_spapr_tce.c |  4 +--
 3 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 667aa1a..b9e50d3 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -225,8 +225,8 @@ extern unsigned long iommu_clear_tce(struct iommu_table *tbl,
 		unsigned long entry);
 
 extern void iommu_flush_tce(struct iommu_table *tbl);
-extern int iommu_take_ownership(struct iommu_table *tbl);
-extern void iommu_release_ownership(struct iommu_table *tbl);
+extern int iommu_take_ownership(struct iommu_table_group *table_group);
+extern void iommu_release_ownership(struct iommu_table_group *table_group);
 
 extern enum dma_data_direction iommu_tce_direction(unsigned long tce);
 extern unsigned long iommu_direction_to_tce_perm(enum dma_data_direction dir);
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index fd49c8e..7d6089b 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -1050,7 +1050,7 @@ int iommu_tce_build(struct iommu_table *tbl, unsigned long entry,
 }
 EXPORT_SYMBOL_GPL(iommu_tce_build);
 
-int iommu_take_ownership(struct iommu_table *tbl)
+static int iommu_table_take_ownership(struct iommu_table *tbl)
 {
 	unsigned long sz = (tbl->it_size + 7) >> 3;
 
@@ -1064,19 +1064,36 @@ int iommu_take_ownership(struct iommu_table *tbl)
 
 	memset(tbl->it_map, 0xff, sz);
 
-	/*
-	 * Disable iommu bypass, otherwise the user can DMA to all of
-	 * our physical memory via the bypass window instead of just
-	 * the pages that has been explicitly mapped into the iommu
-	 */
-	if (tbl->set_bypass)
-		tbl->set_bypass(tbl, false);
+	return 0;
+}
+
+static void iommu_table_release_ownership(struct iommu_table *tbl);
+
+int iommu_take_ownership(struct iommu_table_group *table_group)
+{
+	int i, j, rc = 0;
+
+	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
+		struct iommu_table *tbl = &table_group->tables[i];
+
+		if (!tbl->it_map)
+			continue;
+
+		rc = iommu_table_take_ownership(tbl);
+		if (rc) {
+			for (j = 0; j < i; ++j)
+				iommu_table_release_ownership(
+						&table_group->tables[j]);
+
+			return rc;
+		}
+	}
 
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iommu_take_ownership);
 
-void iommu_release_ownership(struct iommu_table *tbl)
+static void iommu_table_release_ownership(struct iommu_table *tbl)
 {
 	unsigned long sz = (tbl->it_size + 7) >> 3;
 
@@ -1086,9 +1103,18 @@ void iommu_release_ownership(struct iommu_table *tbl)
 	if (tbl->it_offset == 0)
 		set_bit(0, tbl->it_map);
 
-	/* The kernel owns the device now, we can restore the iommu bypass */
-	if (tbl->set_bypass)
-		tbl->set_bypass(tbl, true);
+}
+
+extern void iommu_release_ownership(struct iommu_table_group *table_group)
+{
+	int i;
+
+	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
+		struct iommu_table *tbl = &table_group->tables[i];
+
+		if (tbl->it_map)
+			iommu_table_release_ownership(tbl);
+	}
 }
 EXPORT_SYMBOL_GPL(iommu_release_ownership);
 
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index d61aad2..9f38351 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -535,7 +535,7 @@ static int tce_iommu_attach_group(void *iommu_data,
 		goto unlock_exit;
 	}
 
-	ret = iommu_take_ownership(&table_group->tables[0]);
+	ret = iommu_take_ownership(table_group);
 	if (!ret)
 		container->grp = iommu_group;
 
@@ -572,7 +572,7 @@ static void tce_iommu_detach_group(void *iommu_data,
 	table_group = iommu_group_get_iommudata(iommu_group);
 	BUG_ON(!table_group);
 
-	iommu_release_ownership(&table_group->tables[0]);
+	iommu_release_ownership(table_group);
 
 unlock_exit:
 	mutex_unlock(&container->lock);
-- 
2.0.0
