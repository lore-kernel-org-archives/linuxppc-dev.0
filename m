Return-Path: <aik@ozlabs.ru>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 588C81A0C57
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:47 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Sat, 25 Apr 2015 22:16:46 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 62E523578056
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:44 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3PCGa4o39780540
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:44 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3PCGAT1027879
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:11 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v9 25/32] vfio: powerpc/spapr: powerpc/powernv/ioda2:
 Rework ownership
Date: Sat, 25 Apr 2015 22:14:49 +1000
Message-Id: <1429964096-11524-26-git-send-email-aik@ozlabs.ru>
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

Before the IOMMU user (VFIO) would take control over the IOMMU table
belonging to a specific IOMMU group. This approach did not allow sharing
tables between IOMMU groups attached to the same container.

This introduces a new IOMMU ownership flavour when the user can not
just control the existing IOMMU table but remove/create tables on demand.
If an IOMMU implements take/release_ownership() callbacks, this lets
the user have full control over the IOMMU group. When the ownership is taken,
the platform code removes all the windows so the caller must create them.
Before returning the ownership back to the platform code, VFIO
unprograms and removes all the tables it created.

This changes IODA2's onwership handler to remove the existing table
rather than manipulating with the existing one. From now on,
iommu_take_ownership() and iommu_release_ownership() are only called
from the vfio_iommu_spapr_tce driver.

In tce_iommu_detach_group(), this copies a iommu_table descriptor on stack
as IODA2's unset_window() will clear the descriptor embedded into PE
and we will not be able to free the table afterwards.
This is a transitional hack and following patches will replace this code
anyway.

Old-style ownership is still supported allowing VFIO to run on older
P5IOC2 and IODA IO controllers.

No change in userspace-visible behaviour is expected. Since it recreates
TCE tables on each ownership change, related kernel traces will appear
more often.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
[aw: for the vfio related changes]
Acked-by: Alex Williamson <alex.williamson@redhat.com>
---
Changes:
v9:
* fixed crash in tce_iommu_detach_group() on tbl->it_ops->free as
tce_iommu_attach_group() used to initialize the table from a descriptor
on stack (it does not matter for the series as this bit is changed later anyway
but it ruing bisectability)

v6:
* fixed commit log that VFIO removes tables before passing ownership
back to the platform code, not userspace

1
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 27 +++++++++++++++++++++++--
 drivers/vfio/vfio_iommu_spapr_tce.c       | 33 +++++++++++++++++++++++++++++--
 2 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 2a4b2b2..45bc131 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2105,16 +2105,39 @@ static void pnv_ioda2_take_ownership(struct iommu_table_group *table_group)
 	struct pnv_ioda_pe *pe = container_of(table_group, struct pnv_ioda_pe,
 						table_group);
 
-	iommu_take_ownership(&table_group->tables[0]);
 	pnv_pci_ioda2_set_bypass(pe, false);
+	pnv_pci_ioda2_unset_window(&pe->table_group, 0);
+	pnv_pci_free_table(&pe->table_group.tables[0]);
 }
 
 static void pnv_ioda2_release_ownership(struct iommu_table_group *table_group)
 {
 	struct pnv_ioda_pe *pe = container_of(table_group, struct pnv_ioda_pe,
 						table_group);
+	struct iommu_table *tbl = &pe->table_group.tables[0];
+	int64_t rc;
+
+	rc = pnv_pci_ioda2_create_table(&pe->table_group, 0,
+			IOMMU_PAGE_SHIFT_4K,
+			pe->phb->ioda.m32_pci_base,
+			POWERNV_IOMMU_DEFAULT_LEVELS, tbl);
+	if (rc) {
+		pe_err(pe, "Failed to create 32-bit TCE table, err %ld",
+				rc);
+		return;
+	}
+
+	tbl->it_table_group = &pe->table_group;
+	iommu_init_table(tbl, pe->phb->hose->node);
+
+	rc = pnv_pci_ioda2_set_window(&pe->table_group, 0, tbl);
+	if (rc) {
+		pe_err(pe, "Failed to configure 32-bit TCE table, err %ld\n",
+				rc);
+		pnv_pci_free_table(tbl);
+		return;
+	}
 
-	iommu_release_ownership(&table_group->tables[0]);
 	pnv_pci_ioda2_set_bypass(pe, true);
 }
 
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 2d51bbf..892a584 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -569,6 +569,10 @@ static int tce_iommu_attach_group(void *iommu_data,
 	if (!table_group->ops || !table_group->ops->take_ownership ||
 			!table_group->ops->release_ownership) {
 		ret = tce_iommu_take_ownership(table_group);
+	} else if (!table_group->ops->create_table ||
+			!table_group->ops->set_window) {
+		WARN_ON_ONCE(1);
+		ret = -EFAULT;
 	} else {
 		/*
 		 * Disable iommu bypass, otherwise the user can DMA to all of
@@ -576,7 +580,15 @@ static int tce_iommu_attach_group(void *iommu_data,
 		 * the pages that has been explicitly mapped into the iommu
 		 */
 		table_group->ops->take_ownership(table_group);
-		ret = 0;
+		ret = table_group->ops->create_table(table_group,
+				0, /* window number */
+				IOMMU_PAGE_SHIFT_4K,
+				table_group->tce32_size,
+				1, /* default levels */
+				&table_group->tables[0]);
+		if (!ret)
+			ret = table_group->ops->set_window(table_group, 0,
+					&table_group->tables[0]);
 	}
 
 	if (ret)
@@ -595,6 +607,7 @@ static void tce_iommu_detach_group(void *iommu_data,
 {
 	struct tce_container *container = iommu_data;
 	struct iommu_table_group *table_group;
+	long i;
 
 	mutex_lock(&container->lock);
 	if (iommu_group != container->grp) {
@@ -620,8 +633,24 @@ static void tce_iommu_detach_group(void *iommu_data,
 	/* Kernel owns the device now, we can restore bypass */
 	if (!table_group->ops || !table_group->ops->release_ownership)
 		tce_iommu_release_ownership(container, table_group);
-	else
+	else if (!table_group->ops->unset_window)
+		WARN_ON_ONCE(1);
+	else {
+		for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
+			struct iommu_table tbl = table_group->tables[i];
+
+			if (!tbl.it_size)
+				continue;
+
+			table_group->ops->unset_window(table_group, i);
+			tce_iommu_clear(container, &tbl,
+					tbl.it_offset, tbl.it_size);
+			if (tbl.it_ops->free)
+				tbl.it_ops->free(&tbl);
+		}
+
 		table_group->ops->release_ownership(table_group);
+	}
 
 unlock_exit:
 	mutex_unlock(&container->lock);
-- 
2.0.0
