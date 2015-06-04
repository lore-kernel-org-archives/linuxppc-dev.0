Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 21E721A08B2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 16:44:02 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 4 Jun 2015 16:44:02 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 624AB2BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 16:43:59 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t546hplK47317224
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 16:43:59 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t546hPfF003262
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 16:43:27 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, bhelgaas@google.com, aik@ozlabs.ru,
 panto@antoniou-consulting.com, robherring2@gmail.com,
 grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v5 24/42] powerpc/powernv: Release PEs dynamically
Date: Thu,  4 Jun 2015 16:41:53 +1000
Message-Id: <1433400131-18429-25-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch adds refcount to PE, which counts number of PCI devices
included in the PE. When last device leaves from the PE, the PE
together with its consumed resources (IO, DMA, PELTM/PELTV) are
released, in order to support PCI hotplug.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
v5:
  * Derived from PATCH[v4 07/21]
---
 arch/powerpc/include/asm/pci-bridge.h     |   1 +
 arch/powerpc/kernel/pci-hotplug.c         |   5 +
 arch/powerpc/platforms/powernv/pci-ioda.c | 181 +++++++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/pci.h      |   2 +
 4 files changed, 183 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 1f39ca7..9a83cdb 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -26,6 +26,7 @@ struct pci_controller_ops {
 	/* Called when pci_enable_device() is called. Returns true to
 	 * allow assignment/enabling of the device. */
 	bool		(*enable_device_hook)(struct pci_dev *);
+	void		(*release_device)(struct pci_dev *);
 
 	/* Called during PCI resource reassignment */
 	resource_size_t (*window_alignment)(struct pci_bus *, unsigned long);
diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
index 98f84ed..21973e7 100644
--- a/arch/powerpc/kernel/pci-hotplug.c
+++ b/arch/powerpc/kernel/pci-hotplug.c
@@ -29,6 +29,11 @@
  */
 void pcibios_release_device(struct pci_dev *dev)
 {
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+
+	if (hose->controller_ops.release_device)
+		hose->controller_ops.release_device(dev);
+
 	eeh_remove_device(dev);
 }
 
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 2e31472..17ba55c 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -132,6 +132,50 @@ static inline bool pnv_pci_is_mem_pref_64(unsigned long flags)
 		(IORESOURCE_MEM_64 | IORESOURCE_PREFETCH));
 }
 
+static void pnv_pci_ioda_release_pe_dma(struct pnv_ioda_pe *pe)
+{
+	struct pnv_phb *phb = pe->phb;
+	struct iommu_table *tbl;
+	int seg;
+	int64_t rc;
+
+	/* No DMA32 segments allocated */
+	if (pe->dma32_seg < 0 ||
+	    pe->dma32_segcount <= 0)
+		return;
+
+	/* Unlink IOMMU table from group */
+	tbl = pe->table_group.tables[0];
+	pnv_pci_unlink_table_and_group(tbl, &pe->table_group);
+	if (pe->table_group.group) {
+		iommu_group_put(pe->table_group.group);
+		BUG_ON(pe->table_group.group);
+	}
+
+	/* Release IOMMU table */
+	free_pages(tbl->it_base,
+		get_order(TCE32_TABLE_SIZE * pe->dma32_segcount));
+	iommu_free_table(tbl,
+		of_node_full_name(pci_bus_to_OF_node(pe->pbus)));
+
+	/* Disable TVE */
+	for (seg = pe->dma32_seg;
+	     seg < pe->dma32_seg + pe->dma32_segcount;
+	     seg++) {
+		rc = opal_pci_map_pe_dma_window(phb->opal_id, pe->pe_number,
+				seg, 0, 0ul, 0ul, 0ul);
+		if (rc)
+			pe_warn(pe, "Error %ld unmapping DMA32 seg#%d\n",
+				rc, seg);
+	}
+
+	/* Free the DMA32 segments */
+	bitmap_clear(phb->ioda.dma32_segmap,
+		pe->dma32_seg, pe->dma32_segcount);
+	pe->dma32_seg = -1;
+	pe->dma32_segcount = 0;
+}
+
 static inline void pnv_pci_ioda2_tce_invalidate_entire(struct pnv_ioda_pe *pe)
 {
 	/* 01xb - invalidate TCEs that match the specified PE# */
@@ -203,6 +247,10 @@ static void pnv_pci_ioda2_release_pe_dma(struct pnv_ioda_pe *pe)
 	struct device_node *dn;
 	int64_t rc;
 
+	if (pe->dma32_seg < 0 ||
+	    pe->dma32_segcount <= 0)
+		return;
+
 	tbl = pe->table_group.tables[0];
 	rc = pnv_pci_ioda2_unset_window(&pe->table_group, 0);
 	if (rc)
@@ -227,6 +275,61 @@ static void pnv_pci_ioda2_release_pe_dma(struct pnv_ioda_pe *pe)
 
 	pnv_pci_ioda2_table_free_pages(tbl);
 	iommu_free_table(tbl, of_node_full_name(dn));
+	pe->dma32_seg = -1;
+	pe->dma32_segcount = 0;
+}
+
+static void pnv_ioda_release_pe_dma(struct pnv_ioda_pe *pe)
+{
+	struct pnv_phb *phb = pe->phb;
+
+	if (phb->type == PNV_PHB_IODA1)
+		pnv_pci_ioda_release_pe_dma(pe);
+	else if (phb->type == PNV_PHB_IODA2)
+		pnv_pci_ioda2_release_pe_dma(pe);
+}
+
+static void pnv_ioda_release_pe_seg(struct pnv_ioda_pe *pe)
+{
+	struct pnv_phb *phb = pe->phb;
+	unsigned long *segmap = NULL;
+	unsigned long *pe_segmap = NULL;
+	uint16_t win;
+	int segno;
+
+	for (win = OPAL_M32_WINDOW_TYPE; win <= OPAL_IO_WINDOW_TYPE; win++) {
+		switch (win) {
+		case OPAL_IO_WINDOW_TYPE:
+			segmap = phb->ioda.io_segmap;
+			pe_segmap = pe->io_segmap;
+			break;
+		case OPAL_M32_WINDOW_TYPE:
+			segmap = phb->ioda.m32_segmap;
+			pe_segmap = pe->m32_segmap;
+			break;
+		case OPAL_M64_WINDOW_TYPE:
+			segmap = phb->ioda.m64_segmap;
+			pe_segmap = pe->m64_segmap;
+			break;
+		}
+
+		segno = -1;
+		while ((segno = find_next_bit(pe_segmap,
+			phb->ioda.total_pe, segno + 1))
+			< phb->ioda.total_pe) {
+			if (win == OPAL_IO_WINDOW_TYPE ||
+			    win == OPAL_M32_WINDOW_TYPE)
+				opal_pci_map_pe_mmio_window(phb->opal_id,
+					phb->ioda.reserved_pe, win, 0, segno);
+			else if (phb->type == PNV_PHB_IODA1)
+				opal_pci_map_pe_mmio_window(phb->opal_id,
+					phb->ioda.reserved_pe, win,
+					segno / 8, segno % 8);
+
+			clear_bit(segno, pe_segmap);
+			clear_bit(segno, segmap);
+		}
+	}
 }
 
 static int pnv_ioda_set_one_peltv(struct pnv_phb *phb,
@@ -333,7 +436,6 @@ static int pnv_ioda_set_peltv(struct pnv_phb *phb,
 	return 0;
 }
 
-#ifdef CONFIG_PCI_IOV
 static int pnv_ioda_deconfigure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
 {
 	struct pci_dev *parent;
@@ -421,7 +523,74 @@ static int pnv_ioda_deconfigure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
 
 	return 0;
 }
-#endif /* CONFIG_PCI_IOV */
+
+static void pnv_ioda_release_pe(struct pnv_ioda_pe *pe)
+{
+	struct pnv_phb *phb = pe->phb;
+	struct pnv_ioda_pe *tmp, *slave;
+
+	/* Release slave PEs in compound PE */
+	if (pe->flags & PNV_IODA_PE_MASTER) {
+		list_for_each_entry_safe(slave, tmp, &pe->slaves, list)
+			pnv_ioda_release_pe(pe);
+	}
+
+	/* Remove the PE from the list */
+	list_del(&pe->list);
+
+	/* Release resources */
+	pnv_ioda_release_pe_dma(pe);
+	pnv_ioda_release_pe_seg(pe);
+	pnv_ioda_deconfigure_pe(pe->phb, pe);
+
+	/* Release PE number */
+	clear_bit(pe->pe_number, phb->ioda.pe_alloc);
+}
+
+static void pnv_ioda_destroy_pe(struct kref *kref)
+{
+	struct pnv_ioda_pe *pe = container_of(kref, struct pnv_ioda_pe, kref);
+
+	pnv_ioda_release_pe(pe);
+}
+
+static inline struct pnv_ioda_pe *pnv_ioda_get_pe(struct pnv_ioda_pe *pe)
+{
+	if (!pe)
+		return NULL;
+
+	if (!pe->kref_init) {
+		pe->kref_init = true;
+		kref_init(&pe->kref);
+	} else {
+		kref_get(&pe->kref);
+	}
+
+	return pe;
+}
+
+static inline void pnv_ioda_put_pe(struct pnv_ioda_pe *pe)
+{
+	if (pe)
+		kref_put(&pe->kref, pnv_ioda_destroy_pe);
+}
+
+static void pnv_pci_release_device(struct pci_dev *pdev)
+{
+	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
+	struct pnv_phb *phb = hose->private_data;
+	struct pci_dn *pdn = pci_get_pdn(pdev);
+	struct pnv_ioda_pe *pe;
+
+	if (pdev->is_virtfn)
+		return;
+
+	if (!pdn || pdn->pe_number == IODA_INVALID_PE)
+		return;
+
+	pe = &phb->ioda.pe_array[pdn->pe_number];
+	pnv_ioda_put_pe(pe);
+}
 
 static struct pnv_ioda_pe *pnv_ioda_init_pe(struct pnv_phb *phb, int pe_no)
 {
@@ -429,6 +598,7 @@ static struct pnv_ioda_pe *pnv_ioda_init_pe(struct pnv_phb *phb, int pe_no)
 
 	pe->phb = phb;
 	pe->pe_number = pe_no;
+	pe->kref_init = false;
 	INIT_LIST_HEAD(&pe->list);
 
 	return pe;
@@ -1233,6 +1403,7 @@ static void pnv_ioda_setup_same_PE(struct pci_bus *bus, struct pnv_ioda_pe *pe)
 		if (pdn->pe_number != IODA_INVALID_PE)
 			continue;
 
+		pnv_ioda_get_pe(pe);
 		pdn->pe_number = pe->pe_number;
 		pe->dma32_weight += pnv_ioda_dev_dma_weight(dev);
 		if ((pe->flags & PNV_IODA_PE_BUS_ALL) && dev->subordinate)
@@ -1301,10 +1472,7 @@ static struct pnv_ioda_pe *pnv_ioda_setup_bus_PE(struct pci_bus *bus, int all)
 			bus->busn_res.start, pe_num);
 
 	if (pnv_ioda_configure_pe(phb, pe)) {
-		/* XXX What do we do here ? */
-		if (pe_num)
-			pnv_ioda_free_pe(phb, pe_num);
-		pe->pbus = NULL;
+		pnv_ioda_release_pe(pe);
 		return NULL;
 	}
 
@@ -3403,6 +3571,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	 */
 	ppc_md.pcibios_fixup = pnv_pci_ioda_fixup;
 	pnv_pci_controller_ops.enable_device_hook = pnv_pci_enable_device_hook;
+	pnv_pci_controller_ops.release_device = pnv_pci_release_device;
 	pnv_pci_controller_ops.window_alignment = pnv_pci_window_alignment;
 	pnv_pci_controller_ops.setup_bridge = pnv_pci_setup_bridge;
 	pnv_pci_controller_ops.reset_secondary_bus = pnv_pci_reset_secondary_bus;
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index bf63481..f68e036 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -30,6 +30,8 @@ struct pnv_phb;
 struct pnv_ioda_pe {
 	unsigned long		flags;
 	struct pnv_phb		*phb;
+	struct kref		kref;
+	bool			kref_init;
 
 	/* A PE can be associated with a single device or an
 	 * entire bus (& children). In the former case, pdev
-- 
2.1.0
