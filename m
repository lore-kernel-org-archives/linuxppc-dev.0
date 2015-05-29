Return-Path: <aik@ozlabs.ru>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 076941A0CCD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:46:27 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 29 May 2015 18:46:26 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id A26EF2BB004D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:46:23 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4T8kFJJ31195360
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:46:23 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4T8jnaR004897
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:45:50 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH kernel v11 28/34] vfio: powerpc/spapr: powerpc/powernv/ioda:
 Define and implement DMA windows API
Date: Fri, 29 May 2015 18:44:52 +1000
Message-Id: <1432889098-22924-29-git-send-email-aik@ozlabs.ru>
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

This extends iommu_table_group_ops by a set of callbacks to support
dynamic DMA windows management.

create_table() creates a TCE table with specific parameters.
it receives iommu_table_group to know nodeid in order to allocate
TCE table memory closer to the PHB. The exact format of allocated
multi-level table might be also specific to the PHB model (not
the case now though).
This callback calculated the DMA window offset on a PCI bus from @num
and stores it in a just created table.

set_window() sets the window at specified TVT index + @num on PHB.

unset_window() unsets the window from specified TVT.

This adds a free() callback to iommu_table_ops to free the memory
(potentially a tree of tables) allocated for the TCE table.

create_table() and free() are supposed to be called once per
VFIO container and set_window()/unset_window() are supposed to be
called for every group in a container.

This adds IOMMU capabilities to iommu_table_group such as default
32bit window parameters and others. This makes use of new values in
vfio_iommu_spapr_tce. IODA1/P5IOC2 do not support DDW so they do not
advertise pagemasks to the userspace.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
---
Changes:
v10:
* squashed "vfio: powerpc/spapr: Use 32bit DMA window properties from table_group"
into this
* shortened the subject

v9:
* new in the series - to make the next patch simpler
---
 arch/powerpc/include/asm/iommu.h            | 19 ++++++
 arch/powerpc/platforms/powernv/pci-ioda.c   | 96 ++++++++++++++++++++++++++---
 arch/powerpc/platforms/powernv/pci-p5ioc2.c |  7 ++-
 drivers/vfio/vfio_iommu_spapr_tce.c         | 19 +++---
 4 files changed, 124 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 706cfc0..e554175 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -70,6 +70,7 @@ struct iommu_table_ops {
 	/* get() returns a physical address */
 	unsigned long (*get)(struct iommu_table *tbl, long index);
 	void (*flush)(struct iommu_table *tbl);
+	void (*free)(struct iommu_table *tbl);
 };
 
 /* These are used by VIO */
@@ -146,6 +147,17 @@ extern struct iommu_table *iommu_init_table(struct iommu_table * tbl,
 struct iommu_table_group;
 
 struct iommu_table_group_ops {
+	long (*create_table)(struct iommu_table_group *table_group,
+			int num,
+			__u32 page_shift,
+			__u64 window_size,
+			__u32 levels,
+			struct iommu_table **ptbl);
+	long (*set_window)(struct iommu_table_group *table_group,
+			int num,
+			struct iommu_table *tblnew);
+	long (*unset_window)(struct iommu_table_group *table_group,
+			int num);
 	/* Switch ownership from platform code to external user (e.g. VFIO) */
 	void (*take_ownership)(struct iommu_table_group *table_group);
 	/* Switch ownership from external user (e.g. VFIO) back to core */
@@ -159,6 +171,13 @@ struct iommu_table_group_link {
 };
 
 struct iommu_table_group {
+	/* IOMMU properties */
+	__u32 tce32_start;
+	__u32 tce32_size;
+	__u64 pgsizes; /* Bitmap of supported page sizes */
+	__u32 max_dynamic_windows_supported;
+	__u32 max_levels;
+
 	struct iommu_group *group;
 	struct iommu_table *tables[IOMMU_TABLE_GROUP_MAX_TABLES];
 	struct iommu_table_group_ops *ops;
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 68ffc7a..1059bf6 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -25,6 +25,7 @@
 #include <linux/memblock.h>
 #include <linux/iommu.h>
 #include <linux/rculist.h>
+#include <linux/sizes.h>
 
 #include <asm/sections.h>
 #include <asm/io.h>
@@ -1868,6 +1869,12 @@ static void pnv_ioda2_tce_free(struct iommu_table *tbl, long index,
 		pnv_pci_ioda2_tce_invalidate(tbl, index, npages, false);
 }
 
+static void pnv_ioda2_table_free(struct iommu_table *tbl)
+{
+	pnv_pci_ioda2_table_free_pages(tbl);
+	iommu_free_table(tbl, "pnv");
+}
+
 static struct iommu_table_ops pnv_ioda2_iommu_ops = {
 	.set = pnv_ioda2_tce_build,
 #ifdef CONFIG_IOMMU_API
@@ -1875,6 +1882,7 @@ static struct iommu_table_ops pnv_ioda2_iommu_ops = {
 #endif
 	.clear = pnv_ioda2_tce_free,
 	.get = pnv_tce_get,
+	.free = pnv_ioda2_table_free,
 };
 
 static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
@@ -1945,6 +1953,8 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 				 TCE_PCI_SWINV_PAIR);
 
 	tbl->it_ops = &pnv_ioda1_iommu_ops;
+	pe->table_group.tce32_start = tbl->it_offset << tbl->it_page_shift;
+	pe->table_group.tce32_size = tbl->it_size << tbl->it_page_shift;
 	iommu_init_table(tbl, phb->hose->node);
 
 	if (pe->flags & PNV_IODA_PE_DEV) {
@@ -1983,7 +1993,7 @@ static long pnv_pci_ioda2_set_window(struct iommu_table_group *table_group,
 	const __u64 start_addr = tbl->it_offset << tbl->it_page_shift;
 	const __u64 win_size = tbl->it_size << tbl->it_page_shift;
 
-	pe_info(pe, "Setting up window %llx..%llx pg=%x\n",
+	pe_info(pe, "Setting up window#%d %llx..%llx pg=%x\n", num,
 			start_addr, start_addr + win_size - 1,
 			IOMMU_PAGE_SIZE(tbl));
 
@@ -1993,7 +2003,7 @@ static long pnv_pci_ioda2_set_window(struct iommu_table_group *table_group,
 	 */
 	rc = opal_pci_map_pe_dma_window(phb->opal_id,
 			pe->pe_number,
-			pe->pe_number << 1,
+			(pe->pe_number << 1) + num,
 			tbl->it_indirect_levels + 1,
 			__pa(tbl->it_base),
 			size << 3,
@@ -2038,7 +2048,67 @@ static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable)
 		pe->tce_bypass_enabled = enable;
 }
 
+static long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
+		__u32 page_shift, __u64 window_size, __u32 levels,
+		struct iommu_table *tbl);
+
+static long pnv_pci_ioda2_create_table(struct iommu_table_group *table_group,
+		int num, __u32 page_shift, __u64 window_size, __u32 levels,
+		struct iommu_table **ptbl)
+{
+	struct pnv_ioda_pe *pe = container_of(table_group, struct pnv_ioda_pe,
+			table_group);
+	int nid = pe->phb->hose->node;
+	__u64 bus_offset = num ? pe->tce_bypass_base : table_group->tce32_start;
+	long ret;
+	struct iommu_table *tbl;
+
+	tbl = pnv_pci_table_alloc(nid);
+	if (!tbl)
+		return -ENOMEM;
+
+	ret = pnv_pci_ioda2_table_alloc_pages(nid,
+			bus_offset, page_shift, window_size,
+			levels, tbl);
+	if (ret) {
+		iommu_free_table(tbl, "pnv");
+		return ret;
+	}
+
+	tbl->it_ops = &pnv_ioda2_iommu_ops;
+	if (pe->phb->ioda.tce_inval_reg)
+		tbl->it_type |= (TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE);
+
+	*ptbl = tbl;
+
+	return 0;
+}
+
 #ifdef CONFIG_IOMMU_API
+static long pnv_pci_ioda2_unset_window(struct iommu_table_group *table_group,
+		int num)
+{
+	struct pnv_ioda_pe *pe = container_of(table_group, struct pnv_ioda_pe,
+			table_group);
+	struct pnv_phb *phb = pe->phb;
+	long ret;
+
+	pe_info(pe, "Removing DMA window #%d\n", num);
+
+	ret = opal_pci_map_pe_dma_window(phb->opal_id, pe->pe_number,
+			(pe->pe_number << 1) + num,
+			0/* levels */, 0/* table address */,
+			0/* table size */, 0/* page size */);
+	if (ret)
+		pe_warn(pe, "Unmapping failed, ret = %ld\n", ret);
+	else
+		pnv_pci_ioda2_tce_invalidate_entire(pe);
+
+	pnv_pci_unlink_table_and_group(table_group->tables[num], table_group);
+
+	return ret;
+}
+
 static void pnv_ioda2_take_ownership(struct iommu_table_group *table_group)
 {
 	struct pnv_ioda_pe *pe = container_of(table_group, struct pnv_ioda_pe,
@@ -2058,6 +2128,9 @@ static void pnv_ioda2_release_ownership(struct iommu_table_group *table_group)
 }
 
 static struct iommu_table_group_ops pnv_pci_ioda2_ops = {
+	.create_table = pnv_pci_ioda2_create_table,
+	.set_window = pnv_pci_ioda2_set_window,
+	.unset_window = pnv_pci_ioda2_unset_window,
 	.take_ownership = pnv_ioda2_take_ownership,
 	.release_ownership = pnv_ioda2_release_ownership,
 };
@@ -2205,7 +2278,7 @@ static void pnv_pci_ioda2_table_free_pages(struct iommu_table *tbl)
 static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 				       struct pnv_ioda_pe *pe)
 {
-	struct iommu_table *tbl;
+	struct iommu_table *tbl = NULL;
 	int64_t rc;
 
 	/* We shouldn't already have a 32-bit DMA associated */
@@ -2215,10 +2288,8 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 	/* TVE #1 is selected by PCI address bit 59 */
 	pe->tce_bypass_base = 1ull << 59;
 
-	tbl = pnv_pci_table_alloc(phb->hose->node);
 	iommu_register_group(&pe->table_group, phb->hose->global_number,
 			pe->pe_number);
-	pnv_pci_link_table_and_group(phb->hose->node, 0, tbl, &pe->table_group);
 
 	/* The PE will reserve all possible 32-bits space */
 	pe->tce32_seg = 0;
@@ -2226,13 +2297,22 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 		phb->ioda.m32_pci_base);
 
 	/* Setup linux iommu table */
-	rc = pnv_pci_ioda2_table_alloc_pages(pe->phb->hose->node,
-			0, IOMMU_PAGE_SHIFT_4K, phb->ioda.m32_pci_base,
-			POWERNV_IOMMU_DEFAULT_LEVELS, tbl);
+	pe->table_group.tce32_start = 0;
+	pe->table_group.tce32_size = phb->ioda.m32_pci_base;
+	pe->table_group.max_dynamic_windows_supported =
+			IOMMU_TABLE_GROUP_MAX_TABLES;
+	pe->table_group.max_levels = POWERNV_IOMMU_MAX_LEVELS;
+	pe->table_group.pgsizes = SZ_4K | SZ_64K | SZ_16M;
+
+	rc = pnv_pci_ioda2_create_table(&pe->table_group, 0,
+			IOMMU_PAGE_SHIFT_4K,
+			pe->table_group.tce32_size,
+			POWERNV_IOMMU_DEFAULT_LEVELS, &tbl);
 	if (rc) {
 		pe_err(pe, "Failed to create 32-bit TCE table, err %ld", rc);
 		goto fail;
 	}
+	pnv_pci_link_table_and_group(phb->hose->node, 0, tbl, &pe->table_group);
 
 	tbl->it_ops = &pnv_ioda2_iommu_ops;
 	iommu_init_table(tbl, phb->hose->node);
diff --git a/arch/powerpc/platforms/powernv/pci-p5ioc2.c b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
index 94c880c..a295660 100644
--- a/arch/powerpc/platforms/powernv/pci-p5ioc2.c
+++ b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
@@ -119,6 +119,8 @@ static void __init pnv_pci_init_p5ioc2_phb(struct device_node *np, u64 hub_id,
 	u64 phb_id;
 	int64_t rc;
 	static int primary = 1;
+	struct iommu_table_group *table_group;
+	struct iommu_table *tbl;
 
 	pr_info(" Initializing p5ioc2 PHB %s\n", np->full_name);
 
@@ -193,7 +195,10 @@ static void __init pnv_pci_init_p5ioc2_phb(struct device_node *np, u64 hub_id,
 	 * hotplug or SRIOV on P5IOC2 and therefore iommu_free_table()
 	 * should not be called for phb->p5ioc2.table_group.tables[0] ever.
 	 */
-	phb->p5ioc2.table_group.tables[0] = &phb->p5ioc2.iommu_table;
+	tbl = phb->p5ioc2.table_group.tables[0] = &phb->p5ioc2.iommu_table;
+	table_group = &phb->p5ioc2.table_group;
+	table_group->tce32_start = tbl->it_offset << tbl->it_page_shift;
+	table_group->tce32_size = tbl->it_size << tbl->it_page_shift;
 }
 
 void __init pnv_pci_init_p5ioc2_hub(struct device_node *np)
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 651c4ae..c988bdd 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -135,7 +135,6 @@ static int tce_iommu_enable(struct tce_container *container)
 {
 	int ret = 0;
 	unsigned long locked;
-	struct iommu_table *tbl;
 	struct iommu_table_group *table_group;
 
 	if (!container->grp)
@@ -171,13 +170,19 @@ static int tce_iommu_enable(struct tce_container *container)
 	 * this is that we cannot tell here the amount of RAM used by the guest
 	 * as this information is only available from KVM and VFIO is
 	 * KVM agnostic.
+	 *
+	 * So we do not allow enabling a container without a group attached
+	 * as there is no way to know how much we should increment
+	 * the locked_vm counter.
 	 */
 	table_group = iommu_group_get_iommudata(container->grp);
 	if (!table_group)
 		return -ENODEV;
 
-	tbl = table_group->tables[0];
-	locked = (tbl->it_size << tbl->it_page_shift) >> PAGE_SHIFT;
+	if (!table_group->tce32_size)
+		return -EPERM;
+
+	locked = table_group->tce32_size >> PAGE_SHIFT;
 	ret = try_increment_locked_vm(locked);
 	if (ret)
 		return ret;
@@ -350,7 +355,6 @@ static long tce_iommu_ioctl(void *iommu_data,
 
 	case VFIO_IOMMU_SPAPR_TCE_GET_INFO: {
 		struct vfio_iommu_spapr_tce_info info;
-		struct iommu_table *tbl;
 		struct iommu_table_group *table_group;
 
 		if (WARN_ON(!container->grp))
@@ -358,8 +362,7 @@ static long tce_iommu_ioctl(void *iommu_data,
 
 		table_group = iommu_group_get_iommudata(container->grp);
 
-		tbl = table_group->tables[0];
-		if (WARN_ON_ONCE(!tbl))
+		if (!table_group)
 			return -ENXIO;
 
 		minsz = offsetofend(struct vfio_iommu_spapr_tce_info,
@@ -371,8 +374,8 @@ static long tce_iommu_ioctl(void *iommu_data,
 		if (info.argsz < minsz)
 			return -EINVAL;
 
-		info.dma32_window_start = tbl->it_offset << tbl->it_page_shift;
-		info.dma32_window_size = tbl->it_size << tbl->it_page_shift;
+		info.dma32_window_start = table_group->tce32_start;
+		info.dma32_window_size = table_group->tce32_size;
 		info.flags = 0;
 
 		if (copy_to_user((void __user *)arg, &info, minsz))
-- 
2.4.0.rc3.8.gfb3e7d5
