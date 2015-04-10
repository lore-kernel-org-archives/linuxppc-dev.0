Return-Path: <aik@ozlabs.ru>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CB0B11A0B87
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:32:44 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 10 Apr 2015 16:32:44 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id A142C2BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:32:42 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3A6WY1A29032642
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:32:42 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3A6W8Re027890
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:32:09 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v8 25/31] vfio: powerpc/spapr: powerpc/powernv/ioda2:
 Rework ownership
Date: Fri, 10 Apr 2015 16:31:07 +1000
Message-Id: <1428647473-11738-26-git-send-email-aik@ozlabs.ru>
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

Before the IOMMU user (VFIO) would take control over the IOMMU table
belonging to a specific IOMMU group. This approach did not allow sharing
tables between IOMMU groups attached to the same container.

This introduces a new IOMMU ownership flavour when the user can not
just control the existing IOMMU table but remove/create tables on demand.
If an IOMMU implements a set_ownership() callback, this lets the user have
full control over the IOMMU group. When the ownership is taken,
the platform code removes all the windows so the caller must create them.
Before returning the ownership back to the platform code, VFIO
unprograms and removes all the tables it created.

Old-style ownership is still supported allowing VFIO to run on older
P5IOC2 and IODA IO controllers.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v6:
* fixed commit log that VFIO removes tables before passing ownership
back to the platform code, not userspace
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 30 +++++++++++++++---
 drivers/vfio/vfio_iommu_spapr_tce.c       | 51 ++++++++++++++++++++++++-------
 2 files changed, 66 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index ab0cfb7..751aeab 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1626,11 +1626,33 @@ static void pnv_ioda2_set_ownership(struct iommu_table_group *table_group,
 {
 	struct pnv_ioda_pe *pe = container_of(table_group, struct pnv_ioda_pe,
 						table_group);
-	if (enable)
-		iommu_take_ownership(table_group);
-	else
-		iommu_release_ownership(table_group);
+	if (enable) {
+		pnv_pci_ioda2_unset_window(&pe->table_group, 0);
+		pnv_pci_free_table(&pe->table_group.tables[0]);
+	} else {
+		struct iommu_table *tbl = &pe->table_group.tables[0];
+		int64_t rc;
 
+		rc = pnv_pci_ioda2_create_table(&pe->table_group, 0,
+				IOMMU_PAGE_SHIFT_4K,
+				pe->phb->ioda.m32_pci_base,
+				POWERNV_IOMMU_DEFAULT_LEVELS, tbl);
+		if (rc) {
+			pe_err(pe, "Failed to create 32-bit TCE table, err %ld",
+					rc);
+			return;
+		}
+
+		iommu_init_table(tbl, pe->phb->hose->node);
+
+		rc = pnv_pci_ioda2_set_window(&pe->table_group, 0, tbl);
+		if (rc) {
+			pe_err(pe, "Failed to configure 32-bit TCE table, err %ld\n",
+					rc);
+			pnv_pci_free_table(tbl);
+			return;
+		}
+	}
 	pnv_pci_ioda2_set_bypass(pe, !enable);
 }
 
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 7c3c215..9aeaed6 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -226,18 +226,11 @@ static int tce_iommu_clear(struct tce_container *container,
 static void tce_iommu_release(void *iommu_data)
 {
 	struct tce_container *container = iommu_data;
-	struct iommu_table *tbl;
-	struct iommu_table_group *table_group;
 
 	WARN_ON(container->grp);
 
-	if (container->grp) {
-		table_group = iommu_group_get_iommudata(container->grp);
-		tbl = &table_group->tables[0];
-		tce_iommu_clear(container, tbl,	tbl->it_offset, tbl->it_size);
-
+	if (container->grp)
 		tce_iommu_detach_group(iommu_data, container->grp);
-	}
 
 	tce_iommu_disable(container);
 
@@ -553,14 +546,24 @@ static int tce_iommu_attach_group(void *iommu_data,
 
 	if (!table_group->ops || !table_group->ops->set_ownership) {
 		ret = iommu_take_ownership(table_group);
+	} else if (!table_group->ops->create_table ||
+			!table_group->ops->set_window) {
+		WARN_ON_ONCE(1);
+		ret = -EFAULT;
 	} else {
 		/*
 		 * Disable iommu bypass, otherwise the user can DMA to all of
 		 * our physical memory via the bypass window instead of just
 		 * the pages that has been explicitly mapped into the iommu
 		 */
+		struct iommu_table tbltmp = { 0 }, *tbl = &tbltmp;
+
 		table_group->ops->set_ownership(table_group, true);
-		ret = 0;
+		ret = table_group->ops->create_table(table_group, 0,
+				IOMMU_PAGE_SHIFT_4K,
+				table_group->tce32_size, 1, tbl);
+		if (!ret)
+			ret = table_group->ops->set_window(table_group, 0, tbl);
 	}
 
 	if (ret)
@@ -579,6 +582,7 @@ static void tce_iommu_detach_group(void *iommu_data,
 {
 	struct tce_container *container = iommu_data;
 	struct iommu_table_group *table_group;
+	long i;
 
 	mutex_lock(&container->lock);
 	if (iommu_group != container->grp) {
@@ -602,10 +606,35 @@ static void tce_iommu_detach_group(void *iommu_data,
 	BUG_ON(!table_group);
 
 	/* Kernel owns the device now, we can restore bypass */
-	if (!table_group->ops || !table_group->ops->set_ownership)
+	if (!table_group->ops || !table_group->ops->set_ownership) {
+		for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
+			struct iommu_table *tbl = &table_group->tables[i];
+
+			if (!tbl->it_size)
+				continue;
+
+			if (!tbl->it_ops)
+				goto unlock_exit;
+			tce_iommu_clear(container, tbl,
+					tbl->it_offset, tbl->it_size);
+		}
 		iommu_release_ownership(table_group);
-	else
+	} else if (!table_group->ops->unset_window) {
+		WARN_ON_ONCE(1);
+	} else {
+		for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
+			struct iommu_table *tbl = &table_group->tables[i];
+
+			table_group->ops->unset_window(table_group, i);
+			tce_iommu_clear(container, tbl,
+					tbl->it_offset, tbl->it_size);
+
+			if (tbl->it_ops->free)
+				tbl->it_ops->free(tbl);
+		}
+
 		table_group->ops->set_ownership(table_group, false);
+	}
 
 unlock_exit:
 	mutex_unlock(&container->lock);
-- 
2.0.0
