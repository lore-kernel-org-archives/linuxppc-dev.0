Return-Path: <aik@ozlabs.ru>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E54B01A05C6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:46:01 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 29 May 2015 18:46:00 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 480032BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:45:57 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4T8jn5N52953150
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:45:57 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4T8jObs026968
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:45:25 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH kernel v11 04/34] powerpc/iommu: Put IOMMU group explicitly
Date: Fri, 29 May 2015 18:44:28 +1000
Message-Id: <1432889098-22924-5-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
References: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

So far an iommu_table lifetime was the same as PE. Dynamic DMA windows
will change this and iommu_free_table() will not always require
the group to be released.

This moves iommu_group_put() out of iommu_free_table().

This adds a iommu_pseries_free_table() helper which does
iommu_group_put() and iommu_free_table(). Later it will be
changed to receive a table_group and we will have to change less
lines then.

This should cause no behavioural change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/iommu.c               |  7 -------
 arch/powerpc/platforms/powernv/pci-ioda.c |  5 +++++
 arch/powerpc/platforms/pseries/iommu.c    | 16 +++++++++++++++-
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index b054f33..3d47eb3 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -726,13 +726,6 @@ void iommu_free_table(struct iommu_table *tbl, const char *node_name)
 	if (tbl->it_offset == 0)
 		clear_bit(0, tbl->it_map);
 
-#ifdef CONFIG_IOMMU_API
-	if (tbl->it_group) {
-		iommu_group_put(tbl->it_group);
-		BUG_ON(tbl->it_group);
-	}
-#endif
-
 	/* verify that table contains no entries */
 	if (!bitmap_empty(tbl->it_map, tbl->it_size))
 		pr_warn("%s: Unexpected TCEs for %s\n", __func__, node_name);
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 8ca7abd..8c3c4bf 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -23,6 +23,7 @@
 #include <linux/io.h>
 #include <linux/msi.h>
 #include <linux/memblock.h>
+#include <linux/iommu.h>
 
 #include <asm/sections.h>
 #include <asm/io.h>
@@ -1310,6 +1311,10 @@ static void pnv_pci_ioda2_release_dma_pe(struct pci_dev *dev, struct pnv_ioda_pe
 	if (rc)
 		pe_warn(pe, "OPAL error %ld release DMA window\n", rc);
 
+	if (tbl->it_group) {
+		iommu_group_put(tbl->it_group);
+		BUG_ON(tbl->it_group);
+	}
 	iommu_free_table(tbl, of_node_full_name(dev->dev.of_node));
 	free_pages(addr, get_order(TCE32_TABLE_SIZE));
 	pe->tce32_table = NULL;
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 05ab06d..fe5117b 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -36,6 +36,7 @@
 #include <linux/crash_dump.h>
 #include <linux/memory.h>
 #include <linux/of.h>
+#include <linux/iommu.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/rtas.h>
@@ -51,6 +52,18 @@
 
 #include "pseries.h"
 
+static void iommu_pseries_free_table(struct iommu_table *tbl,
+		const char *node_name)
+{
+#ifdef CONFIG_IOMMU_API
+	if (tbl->it_group) {
+		iommu_group_put(tbl->it_group);
+		BUG_ON(tbl->it_group);
+	}
+#endif
+	iommu_free_table(tbl, node_name);
+}
+
 static void tce_invalidate_pSeries_sw(struct iommu_table *tbl,
 				      __be64 *startp, __be64 *endp)
 {
@@ -1271,7 +1284,8 @@ static int iommu_reconfig_notifier(struct notifier_block *nb, unsigned long acti
 		 */
 		remove_ddw(np, false);
 		if (pci && pci->iommu_table)
-			iommu_free_table(pci->iommu_table, np->full_name);
+			iommu_pseries_free_table(pci->iommu_table,
+					np->full_name);
 
 		spin_lock(&direct_window_list_lock);
 		list_for_each_entry(window, &direct_window_list, list) {
-- 
2.4.0.rc3.8.gfb3e7d5
