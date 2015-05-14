Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42AE31A0015
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 12:02:35 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 14 May 2015 12:02:33 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 80BCB2BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 12:02:30 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4E22MRr23724144
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 12:02:30 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4E21uDb005483
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 12:01:57 +1000
Date: Thu, 14 May 2015 12:01:30 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v10 18/34] vfio:
 powerpc/spapr/iommu/powernv/ioda2: Rework IOMMU ownership control
Message-ID: <20150514020130.GB27410@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1431358763-24371-1-git-send-email-aik@ozlabs.ru>
 <1431358763-24371-19-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1431358763-24371-19-git-send-email-aik@ozlabs.ru>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 12, 2015 at 01:39:07AM +1000, Alexey Kardashevskiy wrote:
>This adds tce_iommu_take_ownership() and tce_iommu_release_ownership
>which call in a loop iommu_take_ownership()/iommu_release_ownership()
>for every table on the group. As there is just one now, no change in
>behaviour is expected.
>
>At the moment the iommu_table struct has a set_bypass() which enables/
>disables DMA bypass on IODA2 PHB. This is exposed to POWERPC IOMMU code
>which calls this callback when external IOMMU users such as VFIO are
>about to get over a PHB.
>
>The set_bypass() callback is not really an iommu_table function but
>IOMMU/PE function. This introduces a iommu_table_group_ops struct and
>adds take_ownership()/release_ownership() callbacks to it which are
>called when an external user takes/releases control over the IOMMU.
>
>This replaces set_bypass() with ownership callbacks as it is not
>necessarily just bypass enabling, it can be something else/more
>so let's give it more generic name.
>
>The callbacks is implemented for IODA2 only. Other platforms (P5IOC2,
>IODA1) will use the old iommu_take_ownership/iommu_release_ownership API.
>The following patches will replace iommu_take_ownership/
>iommu_release_ownership calls in IODA2 with full IOMMU table release/
>create.
>
>As we here and touching bypass control, this removes
>pnv_pci_ioda2_setup_bypass_pe() as it does not do much
>more compared to pnv_pci_ioda2_set_bypass. This moves tce_bypass_base
>initialization to pnv_pci_ioda2_setup_dma_pe.
>
>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>[aw: for the vfio related changes]
>Acked-by: Alex Williamson <alex.williamson@redhat.com>

Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Thanks,
Gavin

>---
>Changes:
>v10:
>* fixed comments around take_ownership/release_ownership in iommu_table_group_ops
>
>v9:
>* squashed "vfio: powerpc/spapr: powerpc/iommu: Rework IOMMU ownership control"
>and "vfio: powerpc/spapr: powerpc/powernv/ioda2: Rework IOMMU ownership control"
>into a single patch
>* moved helpers with a loop through tables in a group
>to vfio_iommu_spapr_tce.c to keep the platform code free of IOMMU table
>groups as much as possible
>* added missing tce_iommu_clear() to tce_iommu_release_ownership()
>* replaced the set_ownership(enable) callback with take_ownership() and
>release_ownership()
>---
> arch/powerpc/include/asm/iommu.h          | 11 ++++-
> arch/powerpc/kernel/iommu.c               | 12 -----
> arch/powerpc/platforms/powernv/pci-ioda.c | 73 ++++++++++++++++++-------------
> drivers/vfio/vfio_iommu_spapr_tce.c       | 70 ++++++++++++++++++++++++++---
> 4 files changed, 116 insertions(+), 50 deletions(-)
>
>diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
>index 664beeb..c5375c5 100644
>--- a/arch/powerpc/include/asm/iommu.h
>+++ b/arch/powerpc/include/asm/iommu.h
>@@ -95,7 +95,6 @@ struct iommu_table {
> 	struct list_head it_group_list;/* List of iommu_table_group_link */
> #endif
> 	struct iommu_table_ops *it_ops;
>-	void (*set_bypass)(struct iommu_table *tbl, bool enable);
> };
>
> /* Pure 2^n version of get_order */
>@@ -130,6 +129,15 @@ extern struct iommu_table *iommu_init_table(struct iommu_table * tbl,
>
> #define IOMMU_TABLE_GROUP_MAX_TABLES	1
>
>+struct iommu_table_group;
>+
>+struct iommu_table_group_ops {
>+	/* Switch ownership from platform code to external user (e.g. VFIO) */
>+	void (*take_ownership)(struct iommu_table_group *table_group);
>+	/* Switch ownership from external user (e.g. VFIO) back to core */
>+	void (*release_ownership)(struct iommu_table_group *table_group);
>+};
>+
> struct iommu_table_group_link {
> 	struct list_head next;
> 	struct rcu_head rcu;
>@@ -139,6 +147,7 @@ struct iommu_table_group_link {
> struct iommu_table_group {
> 	struct iommu_group *group;
> 	struct iommu_table *tables[IOMMU_TABLE_GROUP_MAX_TABLES];
>+	struct iommu_table_group_ops *ops;
> };
>
> extern void iommu_register_group(struct iommu_table_group *table_group,
>diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
>index bdf19c6..7e54714 100644
>--- a/arch/powerpc/kernel/iommu.c
>+++ b/arch/powerpc/kernel/iommu.c
>@@ -1044,14 +1044,6 @@ int iommu_take_ownership(struct iommu_table *tbl)
>
> 	memset(tbl->it_map, 0xff, sz);
>
>-	/*
>-	 * Disable iommu bypass, otherwise the user can DMA to all of
>-	 * our physical memory via the bypass window instead of just
>-	 * the pages that has been explicitly mapped into the iommu
>-	 */
>-	if (tbl->set_bypass)
>-		tbl->set_bypass(tbl, false);
>-
> 	return 0;
> }
> EXPORT_SYMBOL_GPL(iommu_take_ownership);
>@@ -1065,10 +1057,6 @@ void iommu_release_ownership(struct iommu_table *tbl)
> 	/* Restore bit#0 set by iommu_init_table() */
> 	if (tbl->it_offset == 0)
> 		set_bit(0, tbl->it_map);
>-
>-	/* The kernel owns the device now, we can restore the iommu bypass */
>-	if (tbl->set_bypass)
>-		tbl->set_bypass(tbl, true);
> }
> EXPORT_SYMBOL_GPL(iommu_release_ownership);
>
>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>index 53bf242b..35ab19c8 100644
>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>@@ -1918,13 +1918,8 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
> 	}
> }
>
>-static void pnv_pci_ioda2_set_bypass(struct iommu_table *tbl, bool enable)
>+static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable)
> {
>-	struct iommu_table_group_link *tgl = list_first_entry_or_null(
>-			&tbl->it_group_list, struct iommu_table_group_link,
>-			next);
>-	struct pnv_ioda_pe *pe = container_of(tgl->table_group,
>-			struct pnv_ioda_pe, table_group);
> 	uint16_t window_id = (pe->pe_number << 1 ) + 1;
> 	int64_t rc;
>
>@@ -1951,33 +1946,48 @@ static void pnv_pci_ioda2_set_bypass(struct iommu_table *tbl, bool enable)
> 		pe->tce_bypass_enabled = enable;
> }
>
>-static void pnv_pci_ioda2_setup_bypass_pe(struct pnv_phb *phb,
>-					  struct pnv_ioda_pe *pe)
>+#ifdef CONFIG_IOMMU_API
>+static void pnv_ioda2_take_ownership(struct iommu_table_group *table_group)
> {
>+	struct pnv_ioda_pe *pe = container_of(table_group, struct pnv_ioda_pe,
>+						table_group);
>+
>+	iommu_take_ownership(table_group->tables[0]);
>+	pnv_pci_ioda2_set_bypass(pe, false);
>+}
>+
>+static void pnv_ioda2_release_ownership(struct iommu_table_group *table_group)
>+{
>+	struct pnv_ioda_pe *pe = container_of(table_group, struct pnv_ioda_pe,
>+						table_group);
>+
>+	iommu_release_ownership(table_group->tables[0]);
>+	pnv_pci_ioda2_set_bypass(pe, true);
>+}
>+
>+static struct iommu_table_group_ops pnv_pci_ioda2_ops = {
>+	.take_ownership = pnv_ioda2_take_ownership,
>+	.release_ownership = pnv_ioda2_release_ownership,
>+};
>+#endif
>+
>+static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>+				       struct pnv_ioda_pe *pe)
>+{
>+	struct page *tce_mem = NULL;
>+	void *addr;
>+	const __be64 *swinvp;
>+	struct iommu_table *tbl;
>+	unsigned int tce_table_size, end;
>+	int64_t rc;
>+
>+	/* We shouldn't already have a 32-bit DMA associated */
>+	if (WARN_ON(pe->tce32_seg >= 0))
>+		return;
>+
> 	/* TVE #1 is selected by PCI address bit 59 */
> 	pe->tce_bypass_base = 1ull << 59;
>
>-	/* Install set_bypass callback for VFIO */
>-	pe->table_group.tables[0]->set_bypass = pnv_pci_ioda2_set_bypass;
>-
>-	/* Enable bypass by default */
>-	pnv_pci_ioda2_set_bypass(pe->table_group.tables[0], true);
>-}
>-
>-static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>-				       struct pnv_ioda_pe *pe)
>-{
>-	struct page *tce_mem = NULL;
>-	void *addr;
>-	const __be64 *swinvp;
>-	struct iommu_table *tbl;
>-	unsigned int tce_table_size, end;
>-	int64_t rc;
>-
>-	/* We shouldn't already have a 32-bit DMA associated */
>-	if (WARN_ON(pe->tce32_seg >= 0))
>-		return;
>-
> 	tbl = pnv_pci_table_alloc(phb->hose->node);
> 	iommu_register_group(&pe->table_group, phb->hose->global_number,
> 			pe->pe_number);
>@@ -2032,6 +2042,9 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
> 	}
> 	tbl->it_ops = &pnv_ioda2_iommu_ops;
> 	iommu_init_table(tbl, phb->hose->node);
>+#ifdef CONFIG_IOMMU_API
>+	pe->table_group.ops = &pnv_pci_ioda2_ops;
>+#endif
>
> 	if (pe->flags & PNV_IODA_PE_DEV) {
> 		/*
>@@ -2046,7 +2059,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>
> 	/* Also create a bypass window */
> 	if (!pnv_iommu_bypass_disabled)
>-		pnv_pci_ioda2_setup_bypass_pe(phb, pe);
>+		pnv_pci_ioda2_set_bypass(pe, true);
>
> 	return;
> fail:
>diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
>index ed3310b..2ead291 100644
>--- a/drivers/vfio/vfio_iommu_spapr_tce.c
>+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
>@@ -486,6 +486,47 @@ static long tce_iommu_ioctl(void *iommu_data,
> 	return -ENOTTY;
> }
>
>+static void tce_iommu_release_ownership(struct tce_container *container,
>+		struct iommu_table_group *table_group)
>+{
>+	int i;
>+
>+	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
>+		struct iommu_table *tbl = table_group->tables[i];
>+
>+		if (!tbl)
>+			continue;
>+
>+		tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
>+		if (tbl->it_map)
>+			iommu_release_ownership(tbl);
>+	}
>+}
>+
>+static int tce_iommu_take_ownership(struct tce_container *container,
>+		struct iommu_table_group *table_group)
>+{
>+	int i, j, rc = 0;
>+
>+	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
>+		struct iommu_table *tbl = table_group->tables[i];
>+
>+		if (!tbl || !tbl->it_map)
>+			continue;
>+
>+		rc = iommu_take_ownership(tbl);
>+		if (rc) {
>+			for (j = 0; j < i; ++j)
>+				iommu_release_ownership(
>+						table_group->tables[j]);
>+
>+			return rc;
>+		}
>+	}
>+
>+	return 0;
>+}
>+
> static int tce_iommu_attach_group(void *iommu_data,
> 		struct iommu_group *iommu_group)
> {
>@@ -518,9 +559,23 @@ static int tce_iommu_attach_group(void *iommu_data,
> 		goto unlock_exit;
> 	}
>
>-	ret = iommu_take_ownership(table_group->tables[0]);
>-	if (!ret)
>-		container->grp = iommu_group;
>+	if (!table_group->ops || !table_group->ops->take_ownership ||
>+			!table_group->ops->release_ownership) {
>+		ret = tce_iommu_take_ownership(container, table_group);
>+	} else {
>+		/*
>+		 * Disable iommu bypass, otherwise the user can DMA to all of
>+		 * our physical memory via the bypass window instead of just
>+		 * the pages that has been explicitly mapped into the iommu
>+		 */
>+		table_group->ops->take_ownership(table_group);
>+		ret = 0;
>+	}
>+
>+	if (ret)
>+		goto unlock_exit;
>+
>+	container->grp = iommu_group;
>
> unlock_exit:
> 	mutex_unlock(&container->lock);
>@@ -533,7 +588,6 @@ static void tce_iommu_detach_group(void *iommu_data,
> {
> 	struct tce_container *container = iommu_data;
> 	struct iommu_table_group *table_group;
>-	struct iommu_table *tbl;
>
> 	mutex_lock(&container->lock);
> 	if (iommu_group != container->grp) {
>@@ -556,9 +610,11 @@ static void tce_iommu_detach_group(void *iommu_data,
> 	table_group = iommu_group_get_iommudata(iommu_group);
> 	BUG_ON(!table_group);
>
>-	tbl = table_group->tables[0];
>-	tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
>-	iommu_release_ownership(tbl);
>+	/* Kernel owns the device now, we can restore bypass */
>+	if (!table_group->ops || !table_group->ops->release_ownership)
>+		tce_iommu_release_ownership(container, table_group);
>+	else
>+		table_group->ops->release_ownership(table_group);
>
> unlock_exit:
> 	mutex_unlock(&container->lock);
>-- 
>2.4.0.rc3.8.gfb3e7d5
>
