Return-Path: <aik@ozlabs.ru>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qkgMy4zkdzDqGV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 18:39:26 +1000 (AEST)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 12 Apr 2016 18:39:26 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 35CCC3578057
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 18:39:20 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3C8d7TG62586982
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 18:39:20 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3C8cf4a026900
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 18:38:42 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Alistair Popple <alistair@popple.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Daniel Axtens <dja@axtens.net>, David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Russell Currey <ruscur@russell.cc>
Subject: [PATCH kernel v3 9/9] powerpc/powernv/npu: Enable NVLink pass through
Date: Tue, 12 Apr 2016 18:37:50 +1000
Message-Id: <1460450270-42354-10-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1460450270-42354-1-git-send-email-aik@ozlabs.ru>
References: <1460450270-42354-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

IBM POWER8 NVlink systems come with Tesla K40-ish GPUs each of which
also has a couple of fast speed links (NVLink). The interface to links
is exposed as an emulated PCI bridge which is included into the same
IOMMU group as the corresponding GPU.

In the kernel, NPUs get a separate PHB of the PNV_PHB_NPU type and a PE.

In order to make these links work when GPU is passed to the guest,
these bridges need to be passed as well; otherwise performance will
degrade.

This implements and exports API to manage NPU state in regard to VFIO;
it replicates iommu_table_group_ops.

This defines a new pnv_pci_ioda2_npu_ops which is assigned to
the IODA2 bridge if there are NPUs for a GPU on the bridge.
The new callbacks call the default IODA2 callbacks plus new NPU API.
This adds a gpe_table_group_to_npe() helper to find NPU PE for the IODA2
table_group, it is not expected to fail as the helper is only called
from the pnv_pci_ioda2_npu_ops.

This adds a pnv_pci_npu_setup_iommu() helper which adds NPUs to
the GPU group if any found. The helper uses helpers to look for
the "ibm,gpu" property in the device tree which is a phandle of
the corresponding GPU.

This adds an additional loop over PEs in pnv_ioda_setup_dma() as the main
loop skips NPU PEs as they do not have 32bit DMA segments.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v3:
* moved NPU-to-GPU IOMMU grouping later after all PHBs are discovered
* removed hack to make iommu_add_device() work, iommu_group_add_device()
is used instead
* cleanup in gpe_table_group_to_npe_cb()

v2:
* reimplemented to support NPU + GPU in the same group
* merged "powerpc/powernv/npu: Add NPU devices to IOMMU group" and
"powerpc/powernv/npu: Enable passing through via VFIO" into this patch
---
 arch/powerpc/platforms/powernv/npu-dma.c  | 126 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/pci-ioda.c | 105 +++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/pci.h      |   6 ++
 3 files changed, 237 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index 8e70221..7cb9f6a 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -12,6 +12,7 @@
 #include <linux/export.h>
 #include <linux/pci.h>
 #include <linux/memblock.h>
+#include <linux/iommu.h>
 
 #include <asm/iommu.h>
 #include <asm/pnv-pci.h>
@@ -262,3 +263,128 @@ void pnv_npu_try_dma_set_bypass(struct pci_dev *gpdev, bool bypass)
 		}
 	}
 }
+
+long pnv_npu_set_window(struct pnv_ioda_pe *npe, int num,
+		struct iommu_table *tbl)
+{
+	struct pnv_phb *phb = npe->phb;
+	int64_t rc;
+	const unsigned long size = tbl->it_indirect_levels ?
+		tbl->it_level_size : tbl->it_size;
+	const __u64 start_addr = tbl->it_offset << tbl->it_page_shift;
+	const __u64 win_size = tbl->it_size << tbl->it_page_shift;
+
+	pe_info(npe, "Setting up window#%d %llx..%llx pg=%lx\n", num,
+			start_addr, start_addr + win_size - 1,
+			IOMMU_PAGE_SIZE(tbl));
+
+	/* Ignore @num as there is just one window per NPU */
+	rc = opal_pci_map_pe_dma_window(phb->opal_id,
+			npe->pe_number,
+			npe->pe_number,
+			tbl->it_indirect_levels + 1,
+			__pa(tbl->it_base),
+			size << 3,
+			IOMMU_PAGE_SIZE(tbl));
+	if (rc) {
+		pe_err(npe, "Failed to configure TCE table, err %lld\n", rc);
+		return rc;
+	}
+
+	pnv_pci_link_table_and_group(phb->hose->node, num,
+			tbl, &npe->table_group);
+	pnv_pci_ioda2_tce_invalidate_entire(npe->phb, false);
+
+	return rc;
+}
+
+long pnv_npu_unset_window(struct pnv_ioda_pe *npe, int num)
+{
+	struct pnv_phb *phb = npe->phb;
+	long ret;
+
+	pe_info(npe, "Removing DMA window #%d\n", num);
+
+	/* Ignore @num as there is just one window per NPU */
+	ret = opal_pci_map_pe_dma_window(phb->opal_id, npe->pe_number,
+			npe->pe_number,
+			0/* levels */, 0/* table address */,
+			0/* table size */, 0/* page size */);
+	if (ret)
+		pe_warn(npe, "Unmapping failed, ret = %ld\n", ret);
+	else
+		pnv_pci_ioda2_tce_invalidate_entire(npe->phb, false);
+
+	pnv_pci_unlink_table_and_group(npe->table_group.tables[num],
+			&npe->table_group);
+
+	return ret;
+}
+
+/* Switch ownership from platform code to external user (e.g. VFIO) */
+void pnv_npu_take_ownership(struct pnv_ioda_pe *npe)
+{
+	struct pnv_phb *phb = npe->phb;
+	int64_t ret;
+
+	if (npe->table_group.tables[0]) {
+		/* Disable 32bit window */
+		pnv_pci_unlink_table_and_group(npe->table_group.tables[0],
+				&npe->table_group);
+		npe->table_group.tables[0] = NULL;
+		ret = opal_pci_map_pe_dma_window(phb->opal_id, npe->pe_number,
+				npe->pe_number,
+				0/* levels */, 0/* table address */,
+				0/* table size */, 0/* page size */);
+	} else {
+		/* Disable bypass */
+		ret = opal_pci_map_pe_dma_window_real(phb->opal_id,
+				npe->pe_number, npe->pe_number,
+				0 /* bypass base */, 0);
+	}
+
+	if (ret != OPAL_SUCCESS)
+		pe_err(npe, "Failed to remove DMA window");
+	else
+		pnv_pci_ioda2_tce_invalidate_entire(npe->phb, false);
+}
+
+/* Switch ownership from external user (e.g. VFIO) back to core */
+void pnv_npu_release_ownership(struct pnv_ioda_pe *npe)
+{
+	struct pnv_phb *phb = npe->phb;
+	int64_t ret;
+
+	/* Disable a window (not bypass) as external users do not use bypass */
+	ret = opal_pci_map_pe_dma_window(phb->opal_id, npe->pe_number,
+			npe->pe_number,
+			0/* levels */, 0/* table address */,
+			0/* table size */, 0/* page size */);
+	if (ret != OPAL_SUCCESS)
+		pe_err(npe, "Failed to remove DMA window");
+	else
+		pnv_pci_ioda2_tce_invalidate_entire(npe->phb, false);
+}
+
+struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe)
+{
+	struct pnv_phb *phb = npe->phb;
+	struct pci_bus *pbus = phb->hose->bus;
+	struct pci_dev *npdev, *gpdev = NULL, *gptmp;
+	struct pnv_ioda_pe *gpe = get_gpu_pci_dev_and_pe(npe, &gpdev);
+
+	if (!gpe || !gpdev)
+		return NULL;
+
+	list_for_each_entry(npdev, &pbus->devices, bus_list) {
+		gptmp = pnv_pci_get_gpu_dev(npdev);
+
+		if (gptmp != gpdev)
+			continue;
+
+		pe_info(gpe, "Attached NPU %s\n", dev_name(&npdev->dev));
+		iommu_group_add_device(gpe->table_group.group, &npdev->dev);
+	}
+
+	return gpe;
+}
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 922c74c..95f9e19 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2273,6 +2273,93 @@ static struct iommu_table_group_ops pnv_pci_ioda2_ops = {
 	.take_ownership = pnv_ioda2_take_ownership,
 	.release_ownership = pnv_ioda2_release_ownership,
 };
+
+static int gpe_table_group_to_npe_cb(struct device *dev, void *opaque)
+{
+	struct pci_controller *hose;
+	struct pnv_phb *phb;
+	struct pnv_ioda_pe **ptmppe = opaque;
+	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
+	struct pci_dn *pdn = pci_get_pdn(pdev);
+
+	if (!pdn || pdn->pe_number == IODA_INVALID_PE)
+		return 0;
+
+	hose = pci_bus_to_host(pdev->bus);
+	phb = hose->private_data;
+	if (phb->type != PNV_PHB_NPU)
+		return 0;
+
+	*ptmppe = &phb->ioda.pe_array[pdn->pe_number];
+
+	return 1;
+}
+
+/*
+ * This returns PE of associated NPU.
+ * This assumes that NPU is in the same IOMMU group with GPU and there is
+ * no other PEs.
+ */
+static struct pnv_ioda_pe *gpe_table_group_to_npe(
+		struct iommu_table_group *table_group)
+{
+	struct pnv_ioda_pe *npe = NULL;
+	int ret = iommu_group_for_each_dev(table_group->group, &npe,
+			gpe_table_group_to_npe_cb);
+
+	BUG_ON(!ret || !npe);
+
+	return npe;
+}
+
+static long pnv_pci_ioda2_npu_set_window(struct iommu_table_group *table_group,
+		int num, struct iommu_table *tbl)
+{
+	long ret = pnv_pci_ioda2_set_window(table_group, num, tbl);
+
+	if (ret)
+		return ret;
+
+	ret = pnv_npu_set_window(gpe_table_group_to_npe(table_group), num, tbl);
+	if (ret)
+		pnv_pci_ioda2_unset_window(table_group, num);
+
+	return ret;
+}
+
+static long pnv_pci_ioda2_npu_unset_window(
+		struct iommu_table_group *table_group,
+		int num)
+{
+	long ret = pnv_pci_ioda2_unset_window(table_group, num);
+
+	if (ret)
+		return ret;
+
+	return pnv_npu_unset_window(gpe_table_group_to_npe(table_group), num);
+}
+
+static void pnv_ioda2_npu_take_ownership(struct iommu_table_group *table_group)
+{
+	pnv_ioda2_take_ownership(table_group);
+	pnv_npu_take_ownership(gpe_table_group_to_npe(table_group));
+}
+
+static void pnv_ioda2_npu_release_ownership(
+		struct iommu_table_group *table_group)
+{
+	pnv_npu_release_ownership(gpe_table_group_to_npe(table_group));
+	pnv_ioda2_release_ownership(table_group);
+}
+
+static struct iommu_table_group_ops pnv_pci_ioda2_npu_ops = {
+	.get_table_size = pnv_pci_ioda2_get_table_size,
+	.create_table = pnv_pci_ioda2_create_table,
+	.set_window = pnv_pci_ioda2_npu_set_window,
+	.unset_window = pnv_pci_ioda2_npu_unset_window,
+	.take_ownership = pnv_ioda2_npu_take_ownership,
+	.release_ownership = pnv_ioda2_npu_release_ownership,
+};
 #endif
 
 static void pnv_pci_ioda_setup_opal_tce_kill(struct pnv_phb *phb)
@@ -3012,6 +3099,7 @@ static void pnv_pci_ioda_setup_DMA(void)
 {
 	struct pci_controller *hose, *tmp;
 	struct pnv_phb *phb;
+	struct pnv_ioda_pe *pe, *gpe;
 
 	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
 		pnv_ioda_setup_dma(hose->private_data);
@@ -3020,6 +3108,23 @@ static void pnv_pci_ioda_setup_DMA(void)
 		phb = hose->private_data;
 		phb->initialized = 1;
 	}
+
+	/*
+	 * Now we have all PHBs discovered, time to add NPU devices to
+	 * the corresponding IOMMU groups.
+	 */
+	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
+		phb = hose->private_data;
+
+		if (phb->type != PNV_PHB_NPU)
+			continue;
+
+		list_for_each_entry(pe, &phb->ioda.pe_dma_list, dma_link) {
+			gpe = pnv_pci_npu_setup_iommu(pe);
+			if (gpe)
+				gpe->table_group.ops = &pnv_pci_ioda2_npu_ops;
+		}
+	}
 }
 
 static void pnv_pci_ioda_create_dbgfs(void)
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index e117bd8..ebc6ee4 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -244,5 +244,11 @@ extern void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
 /* Nvlink functions */
 extern void pnv_npu_try_dma_set_bypass(struct pci_dev *gpdev, bool bypass);
 extern void pnv_pci_ioda2_tce_invalidate_entire(struct pnv_phb *phb, bool rm);
+extern struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe);
+extern long pnv_npu_set_window(struct pnv_ioda_pe *npe, int num,
+		struct iommu_table *tbl);
+extern long pnv_npu_unset_window(struct pnv_ioda_pe *npe, int num);
+extern void pnv_npu_take_ownership(struct pnv_ioda_pe *npe);
+extern void pnv_npu_release_ownership(struct pnv_ioda_pe *npe);
 
 #endif /* __POWERNV_PCI_H */
-- 
2.5.0.rc3
