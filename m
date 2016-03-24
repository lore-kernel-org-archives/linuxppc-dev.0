Return-Path: <aik@ozlabs.ru>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qVq2l0zt4zDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Mar 2016 12:43:26 +1100 (AEDT)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Thu, 24 Mar 2016 11:43:24 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 2DD993578052
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Mar 2016 12:43:19 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2O1hBDi6816084
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Mar 2016 12:43:19 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2O1gkSM013510
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Mar 2016 12:42:46 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Alistair Popple <alistair@popple.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Daniel Axtens <dja@axtens.net>, David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Russell Currey <ruscur@russell.cc>
Subject: [PATCH kernel v2] powerpc/powernv/npu: Enable NVLink pass through
Date: Thu, 24 Mar 2016 12:42:15 +1100
Message-Id: <1458783735-29658-1-git-send-email-aik@ozlabs.ru>
In-Reply-To: <20160323024518.GR23586@voom.redhat.com>
References: <20160323024518.GR23586@voom.redhat.com>
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
v2:
* reimplemented to support NPU + GPU in the same group
* merged "powerpc/powernv/npu: Add NPU devices to IOMMU group" and
"powerpc/powernv/npu: Enable passing through via VFIO" into this patch

---

The rest of the series is the same, I only merged 2 patches into one and
reworked it to have GPU and NPU in the same IOMMU group like:

aik@g86L:~$ lspci | grep -e '\(NVIDIA\|IBM Device 04ea\)'
0002:01:00.0 3D controller: NVIDIA Corporation Device 15ff (rev a1)
0003:01:00.0 3D controller: NVIDIA Corporation Device 15ff (rev a1)
0006:01:00.0 3D controller: NVIDIA Corporation Device 15ff (rev a1)
0007:01:00.0 3D controller: NVIDIA Corporation Device 15ff (rev a1)
0008:00:00.0 Bridge: IBM Device 04ea
0008:00:00.1 Bridge: IBM Device 04ea
0008:00:01.0 Bridge: IBM Device 04ea
0008:00:01.1 Bridge: IBM Device 04ea
0009:00:00.0 Bridge: IBM Device 04ea
0009:00:00.1 Bridge: IBM Device 04ea
0009:00:01.0 Bridge: IBM Device 04ea
0009:00:01.1 Bridge: IBM Device 04ea
aik@g86L:~$ ls /sys/bus/pci/devices/0002\:01\:00.0/iommu_group/devices/
0002:01:00.0  0008:00:01.0  0008:00:01.1
aik@g86L:~$ ls /sys/bus/pci/devices/0003\:01\:00.0/iommu_group/devices/
0003:01:00.0  0008:00:00.0  0008:00:00.1
aik@g86L:~$ ls /sys/bus/pci/devices/0006\:01\:00.0/iommu_group/devices/
0006:01:00.0  0009:00:01.0  0009:00:01.1
aik@g86L:~$ ls /sys/bus/pci/devices/0007\:01\:00.0/iommu_group/devices/
0007:01:00.0  0009:00:00.0  0009:00:00.1


Please comment. If this one is ok, I'll repost the whole thing. Thanks!


---
 arch/powerpc/platforms/powernv/npu-dma.c  | 129 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/pci-ioda.c | 101 +++++++++++++++++++++++
 arch/powerpc/platforms/powernv/pci.h      |   6 ++
 3 files changed, 236 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index 8e70221..d048e0e 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -262,3 +262,132 @@ void pnv_npu_try_dma_set_bypass(struct pci_dev *gpdev, bool bypass)
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
+		pnv_pci_unlink_table_and_group(npe->table_group.tables[0],
+				&npe->table_group);
+		npe->table_group.tables[0] = NULL;
+		ret = opal_pci_map_pe_dma_window(phb->opal_id, npe->pe_number,
+				npe->pe_number,
+				0/* levels */, 0/* table address */,
+				0/* table size */, 0/* page size */);
+	} else {
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
+	struct iommu_table *tbl;
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
+		/*
+		 * The iommu_add_device() picks an IOMMU group from
+		 * the first IOMMU group attached to the iommu_table
+		 * so we need to pretend that there is a table so
+		 * iommu_add_device() can complete the job.
+		 * We unlink the tempopary table from the group afterwards.
+		 */
+		tbl = get_iommu_table_base(&gpdev->dev);
+		set_iommu_table_base(&npdev->dev, tbl);
+		iommu_add_device(&npdev->dev);
+		set_iommu_table_base(&npdev->dev, NULL);
+	}
+
+	return gpe;
+}
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index e765870..fa6278b 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2299,6 +2299,96 @@ static struct iommu_table_group_ops pnv_pci_ioda2_ops = {
 	.take_ownership = pnv_ioda2_take_ownership,
 	.release_ownership = pnv_ioda2_release_ownership,
 };
+
+static int gpe_table_group_to_npe_cb(struct device *dev, void *opaque)
+{
+	struct pnv_ioda_pe **ptmppe = opaque;
+	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
+	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
+	struct pnv_phb *phb = hose->private_data;
+	struct pci_dn *pdn = pci_get_pdn(pdev);
+	struct pnv_ioda_pe *pe;
+
+	if (!pdn || pdn->pe_number == IODA_INVALID_PE)
+		return 0;
+
+	pe = &phb->ioda.pe_array[pdn->pe_number];
+	if (pe == *ptmppe)
+		return 0;
+
+	if (phb->type != PNV_PHB_NPU)
+		return 0;
+
+	*ptmppe = pe;
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
+	struct pnv_ioda_pe *npe = container_of(table_group, struct pnv_ioda_pe,
+			table_group);
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
@@ -2563,6 +2653,17 @@ static void pnv_ioda_setup_dma(struct pnv_phb *phb)
 		remaining -= segs;
 		base += segs;
 	}
+	/*
+	 * Create an IOMMU group and add devices to it.
+	 * DMA setup is done via GPU's dma_set_mask().
+	 */
+	if (phb->type == PNV_PHB_NPU) {
+		list_for_each_entry(pe, &phb->ioda.pe_dma_list, dma_link) {
+			struct pnv_ioda_pe *gpe = pnv_pci_npu_setup_iommu(pe);
+			if (gpe)
+				gpe->table_group.ops = &pnv_pci_ioda2_npu_ops;
+		}
+	}
 }
 
 #ifdef CONFIG_PCI_MSI
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index f9c3aca..4200bb9 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -250,5 +250,11 @@ extern void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
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
