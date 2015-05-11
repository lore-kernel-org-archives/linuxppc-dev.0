Return-Path: <aik@ozlabs.ru>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 174871A038D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:40:50 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 12 May 2015 01:40:49 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 34F1C2CE8069
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:40:47 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4BFedB241615410
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:40:47 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4BFeEuq002088
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:40:14 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v10 31/34] vfio: powerpc/spapr: powerpc/powernv/ioda2:
 Use DMA windows API in ownership control
Date: Tue, 12 May 2015 01:39:20 +1000
Message-Id: <1431358763-24371-32-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1431358763-24371-1-git-send-email-aik@ozlabs.ru>
References: <1431358763-24371-1-git-send-email-aik@ozlabs.ru>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
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
the user have full control over the IOMMU group. When the ownership
is taken, the platform code removes all the windows so the caller must
create them.
Before returning the ownership back to the platform code, VFIO
unprograms and removes all the tables it created.

This changes IODA2's onwership handler to remove the existing table
rather than manipulating with the existing one. From now on,
iommu_take_ownership() and iommu_release_ownership() are only called
from the vfio_iommu_spapr_tce driver.

Old-style ownership is still supported allowing VFIO to run on older
P5IOC2 and IODA IO controllers.

No change in userspace-visible behaviour is expected. Since it recreates
TCE tables on each ownership change, related kernel traces will appear
more often.

This adds a pnv_pci_ioda2_setup_default_config() which is called
when PE is being configured at boot time and when the ownership is
passed from VFIO to the platform code.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
[aw: for the vfio related changes]
Acked-by: Alex Williamson <alex.williamson@redhat.com>
---
Changes:
v10:
* created pnv_pci_ioda2_setup_default_config() helper

v9:
* fixed crash in tce_iommu_detach_group() on tbl->it_ops->free as
tce_iommu_attach_group() used to initialize the table from a descriptor
on stack (it does not matter for the series as this bit is changed later anyway
but it ruing bisectability)

v6:
* fixed commit log that VFIO removes tables before passing ownership
back to the platform code, not userspace
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 101 ++++++++++++++++--------------
 drivers/vfio/vfio_iommu_spapr_tce.c       |  78 ++++++++++++++++++++++-
 2 files changed, 130 insertions(+), 49 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 48aee99..1312190 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2145,13 +2145,59 @@ static long pnv_pci_ioda2_unset_window(struct iommu_table_group *table_group,
 	return ret;
 }
 
+static long pnv_pci_ioda2_setup_default_config(struct pnv_ioda_pe *pe)
+{
+	struct iommu_table *tbl = NULL;
+	long rc;
+
+	rc = pnv_pci_ioda2_create_table(&pe->table_group, 0,
+			IOMMU_PAGE_SHIFT_4K,
+			pe->table_group.tce32_size,
+			POWERNV_IOMMU_DEFAULT_LEVELS, &tbl);
+	if (rc) {
+		pe_err(pe, "Failed to create 32-bit TCE table, err %ld",
+				rc);
+		return rc;
+	}
+
+	iommu_init_table(tbl, pe->phb->hose->node);
+
+	rc = pnv_pci_ioda2_set_window(&pe->table_group, 0, tbl);
+	if (rc) {
+		pe_err(pe, "Failed to configure 32-bit TCE table, err %ld\n",
+				rc);
+		pnv_ioda2_table_free(tbl);
+		return rc;
+	}
+
+	if (!pnv_iommu_bypass_disabled)
+		pnv_pci_ioda2_set_bypass(pe, true);
+
+	/* OPAL variant of PHB3 invalidated TCEs */
+	if (pe->tce_inval_reg)
+		tbl->it_type |= (TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE);
+
+	/*
+	 * Setting table base here only for carrying iommu_group
+	 * further down to let iommu_add_device() do the job.
+	 * pnv_pci_ioda_dma_dev_setup will override it later anyway.
+	 */
+	if (pe->flags & PNV_IODA_PE_DEV)
+		set_iommu_table_base(&pe->pdev->dev, tbl);
+
+	return 0;
+}
+
 static void pnv_ioda2_take_ownership(struct iommu_table_group *table_group)
 {
 	struct pnv_ioda_pe *pe = container_of(table_group, struct pnv_ioda_pe,
 						table_group);
+	/* Store @tbl as pnv_pci_ioda2_unset_window() resets it */
+	struct iommu_table *tbl = pe->table_group.tables[0];
 
-	iommu_take_ownership(table_group->tables[0]);
 	pnv_pci_ioda2_set_bypass(pe, false);
+	pnv_pci_ioda2_unset_window(&pe->table_group, 0);
+	pnv_ioda2_table_free(tbl);
 }
 
 static void pnv_ioda2_release_ownership(struct iommu_table_group *table_group)
@@ -2159,8 +2205,7 @@ static void pnv_ioda2_release_ownership(struct iommu_table_group *table_group)
 	struct pnv_ioda_pe *pe = container_of(table_group, struct pnv_ioda_pe,
 						table_group);
 
-	iommu_release_ownership(table_group->tables[0]);
-	pnv_pci_ioda2_set_bypass(pe, true);
+	pnv_pci_ioda2_setup_default_config(pe);
 }
 
 static struct iommu_table_group_ops pnv_pci_ioda2_ops = {
@@ -2303,7 +2348,6 @@ static void pnv_pci_ioda2_table_free_pages(struct iommu_table *tbl)
 static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 				       struct pnv_ioda_pe *pe)
 {
-	struct iommu_table *tbl = NULL;
 	int64_t rc;
 
 	/* We shouldn't already have a 32-bit DMA associated */
@@ -2330,58 +2374,21 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 			IOMMU_TABLE_GROUP_MAX_TABLES;
 	pe->table_group.max_levels = POWERNV_IOMMU_MAX_LEVELS;
 	pe->table_group.pgsizes = SZ_4K | SZ_64K | SZ_16M;
-
-	rc = pnv_pci_ioda2_create_table(&pe->table_group, 0,
-			IOMMU_PAGE_SHIFT_4K,
-			pe->table_group.tce32_size,
-			POWERNV_IOMMU_DEFAULT_LEVELS, &tbl);
-	if (rc) {
-		pe_err(pe, "Failed to create 32-bit TCE table, err %ld", rc);
-		goto fail;
-	}
-	pnv_pci_link_table_and_group(phb->hose->node, 0, tbl, &pe->table_group);
-
-	tbl->it_ops = &pnv_ioda2_iommu_ops;
-	iommu_init_table(tbl, phb->hose->node);
 #ifdef CONFIG_IOMMU_API
 	pe->table_group.ops = &pnv_pci_ioda2_ops;
 #endif
 
-	rc = pnv_pci_ioda2_set_window(&pe->table_group, 0, tbl);
+	rc = pnv_pci_ioda2_setup_default_config(pe);
 	if (rc) {
-		pe_err(pe, "Failed to configure 32-bit TCE table,"
-		       " err %ld\n", rc);
-		goto fail;
+		if (pe->tce32_seg >= 0)
+			pe->tce32_seg = -1;
+		return;
 	}
 
-	/* OPAL variant of PHB3 invalidated TCEs */
-	if (pe->tce_inval_reg)
-		tbl->it_type |= (TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE);
-
-	if (pe->flags & PNV_IODA_PE_DEV) {
-		/*
-		 * Setting table base here only for carrying iommu_group
-		 * further down to let iommu_add_device() do the job.
-		 * pnv_pci_ioda_dma_dev_setup will override it later anyway.
-		 */
-		set_iommu_table_base(&pe->pdev->dev, tbl);
+	if (pe->flags & PNV_IODA_PE_DEV)
 		iommu_add_device(&pe->pdev->dev);
-	} else if (pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL))
+	else if (pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL))
 		pnv_ioda_setup_bus_dma(pe, pe->pbus);
-
-	/* Also create a bypass window */
-	if (!pnv_iommu_bypass_disabled)
-		pnv_pci_ioda2_set_bypass(pe, true);
-
-	return;
-fail:
-	if (pe->tce32_seg >= 0)
-		pe->tce32_seg = -1;
-	if (tbl) {
-		pnv_pci_ioda2_table_free_pages(tbl);
-		pnv_pci_unlink_table_and_group(tbl, &pe->table_group);
-		iommu_free_table(tbl, "pnv");
-	}
 }
 
 static void pnv_ioda_setup_dma(struct pnv_phb *phb)
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index bc4956d..8943b29 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -333,6 +333,45 @@ static long tce_iommu_build(struct tce_container *container,
 	return ret;
 }
 
+static long tce_iommu_create_table(struct tce_container *container,
+			struct iommu_table_group *table_group,
+			int num,
+			__u32 page_shift,
+			__u64 window_size,
+			__u32 levels,
+			struct iommu_table **ptbl)
+{
+	long ret, table_size;
+
+	table_size = table_group->ops->get_table_size(page_shift, window_size,
+			levels);
+	if (!table_size)
+		return -EINVAL;
+
+	ret = try_increment_locked_vm(table_size >> PAGE_SHIFT);
+	if (ret)
+		return ret;
+
+	ret = table_group->ops->create_table(table_group, num,
+			page_shift, window_size, levels, ptbl);
+
+	WARN_ON(!ret && !(*ptbl)->it_ops->free);
+	WARN_ON(!ret && ((*ptbl)->it_allocated_size != table_size));
+
+	if (ret)
+		decrement_locked_vm(table_size >> PAGE_SHIFT);
+
+	return ret;
+}
+
+static void tce_iommu_free_table(struct iommu_table *tbl)
+{
+	unsigned long pages = tbl->it_allocated_size >> PAGE_SHIFT;
+
+	tbl->it_ops->free(tbl);
+	decrement_locked_vm(pages);
+}
+
 static long tce_iommu_ioctl(void *iommu_data,
 				 unsigned int cmd, unsigned long arg)
 {
@@ -577,14 +616,32 @@ static int tce_iommu_attach_group(void *iommu_data,
 	if (!table_group->ops || !table_group->ops->take_ownership ||
 			!table_group->ops->release_ownership) {
 		ret = tce_iommu_take_ownership(container, table_group);
+	} else if (!table_group->ops->create_table ||
+			!table_group->ops->set_window) {
+		WARN_ON_ONCE(1);
+		ret = -EFAULT;
 	} else {
+		struct iommu_table *tbl = NULL;
 		/*
 		 * Disable iommu bypass, otherwise the user can DMA to all of
 		 * our physical memory via the bypass window instead of just
 		 * the pages that has been explicitly mapped into the iommu
 		 */
 		table_group->ops->take_ownership(table_group);
-		ret = 0;
+		ret = tce_iommu_create_table(container,
+				table_group,
+				0, /* window number */
+				IOMMU_PAGE_SHIFT_4K,
+				table_group->tce32_size,
+				1, /* default levels */
+				&tbl);
+		if (!ret) {
+			ret = table_group->ops->set_window(table_group, 0, tbl);
+			if (ret)
+				tce_iommu_free_table(tbl);
+			else
+				table_group->tables[0] = tbl;
+		}
 	}
 
 	if (ret)
@@ -603,6 +660,7 @@ static void tce_iommu_detach_group(void *iommu_data,
 {
 	struct tce_container *container = iommu_data;
 	struct iommu_table_group *table_group;
+	long i;
 
 	mutex_lock(&container->lock);
 	if (iommu_group != container->grp) {
@@ -628,8 +686,24 @@ static void tce_iommu_detach_group(void *iommu_data,
 	/* Kernel owns the device now, we can restore bypass */
 	if (!table_group->ops || !table_group->ops->release_ownership)
 		tce_iommu_release_ownership(container, table_group);
-	else
+	else if (!table_group->ops->unset_window)
+		WARN_ON_ONCE(1);
+	else {
+		for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
+			/* Store table pointer as unset_window resets it */
+			struct iommu_table *tbl = table_group->tables[i];
+
+			if (!tbl)
+				continue;
+
+			table_group->ops->unset_window(table_group, i);
+			tce_iommu_clear(container, tbl,
+					tbl->it_offset, tbl->it_size);
+			tce_iommu_free_table(tbl);
+		}
+
 		table_group->ops->release_ownership(table_group);
+	}
 
 unlock_exit:
 	mutex_unlock(&container->lock);
-- 
2.4.0.rc3.8.gfb3e7d5
