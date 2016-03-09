Return-Path: <aik@ozlabs.ru>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BE2AE1A0145
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 17:30:32 +1100 (AEDT)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Wed, 9 Mar 2016 16:30:32 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D57A72CE8059
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 17:30:29 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u296UL7a23068844
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2016 17:30:29 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u296Tvsr021177
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2016 17:29:57 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Daniel Axtens <dja@axtens.net>, David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Russell Currey <ruscur@russell.cc>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH kernel 10/10] powerpc/powernv/npu: Enable passing through via
 VFIO
Date: Wed,  9 Mar 2016 17:29:06 +1100
Message-Id: <1457504946-40649-11-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1457504946-40649-1-git-send-email-aik@ozlabs.ru>
References: <1457504946-40649-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

IBM POWER8 NVlink systems contain usual Tesla K40-ish GPUs but also
contain a couple of really fast links between GPU and CPU. These links
are exposed to the userspace by the OPAL firmware as bridges.
The device tree has references from GPU to NPU and vice versa via
"ibm,npu" and "ibm,gpu" properties which are "linux,phandle" of
the counterparts. The typical GPU looks like:

0003:01:00.0 3D controller: NVIDIA Corporation Device 15ff (rev a1)
0008:00:00.0 Bridge: IBM Device 04ea (prog-if 01)
0008:00:00.1 Bridge: IBM Device 04ea (prog-if 01)

In the host kernel, couple of links of the same GPU make a new PE.
A PHB with these links has a different type - PNV_PHB_NPU (the standard
IODA2 bridge type is PNV_PHB_IODA2). The previos patch added these links
to a new IOMMU group.

In order to make these links work when GPU is passed to the guest,
these bridges need to be passed as well; otherwise performance will
degrade. The previous patch adds these bridges to a new IOMMU group,
this patch adds the bits required by VFIO SPAPR TCE driver to pass it
to the userspace.

This defines pnv_pci_npu_ops and initializes it. It reuses
pnv_pci_ioda2_get_table_size() and pnv_pci_ioda2_create_table() as
the table will be programmed to both NPU and IODA2 bridge types so
it needs to be compatible with both bridge types.

As it is not known in what order the userspace will be adding IOMMU
groups to a VFIO container, we need to maintain PHB type compatibility.
This sets up table_group properties from the linked GPU. This initializes
@tce_bypass_base from GPU as well as this is used by
pnv_pci_ioda2_create_table(). This is a bit ugly but the only place
it is actually used in the NPU PHB is enabling bypass mode and there
we can safely use plain zero.

NPU PHB has just a single TVE per NVLink so it can have either 32bit or
64bit window but never both. Nevertheless the NPU table_group is added
to both iommu_table in the VFIO container for simpler design.

Note that the userspace should pass GPU with corresponding NPUs,
otherwise isolation is not guaranteed.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/npu-dma.c | 128 ++++++++++++++++++++++++++++++-
 1 file changed, 126 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index e5a5feb..283cd73 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -216,13 +216,12 @@ static int pnv_npu_dma_set_bypass(struct pnv_ioda_pe *npe)
 			&npe->table_group);
 	npe->table_group.tables[0] = NULL;
 
-	npe->tce_bypass_base = 0;
 	top = roundup_pow_of_two(top);
 	dev_info(&npe->pdev->dev, "Enabling bypass for PE %d\n",
 			npe->pe_number);
 	rc = opal_pci_map_pe_dma_window_real(phb->opal_id,
 			npe->pe_number, npe->pe_number,
-			npe->tce_bypass_base, top);
+			0 /* bypass base */, top);
 
 	if (rc == OPAL_SUCCESS)
 		pnv_pci_ioda2_tce_invalidate_entire(phb, false);
@@ -264,6 +263,120 @@ void pnv_npu_try_dma_set_bypass(struct pci_dev *gpdev, bool bypass)
 	}
 }
 
+static long pnv_pci_npu_set_window(struct iommu_table_group *table_group,
+		int num, struct iommu_table *tbl)
+{
+	struct pnv_ioda_pe *npe = container_of(table_group, struct pnv_ioda_pe,
+			table_group);
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
+static long pnv_pci_npu_unset_window(struct iommu_table_group *table_group,
+		int num)
+{
+	struct pnv_ioda_pe *npe = container_of(table_group, struct pnv_ioda_pe,
+			table_group);
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
+	pnv_pci_unlink_table_and_group(table_group->tables[num], table_group);
+
+	return ret;
+}
+
+/* Switch ownership from platform code to external user (e.g. VFIO) */
+static void pnv_pci_npu_take_ownership(struct iommu_table_group *table_group)
+{
+	struct pnv_ioda_pe *npe = container_of(table_group, struct pnv_ioda_pe,
+			table_group);
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
+static void pnv_pci_npu_release_ownership(struct iommu_table_group *table_group)
+{
+	struct pnv_ioda_pe *npe = container_of(table_group, struct pnv_ioda_pe,
+			table_group);
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
+static struct iommu_table_group_ops pnv_pci_npu_ops = {
+	.get_table_size = pnv_pci_ioda2_get_table_size,
+	.create_table = pnv_pci_ioda2_create_table,
+	.set_window = pnv_pci_npu_set_window,
+	.unset_window = pnv_pci_npu_unset_window,
+	.take_ownership = pnv_pci_npu_take_ownership,
+	.release_ownership = pnv_pci_npu_release_ownership,
+};
+
 void pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe)
 {
 	struct iommu_table *tbl;
@@ -275,6 +388,17 @@ void pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe)
 	if (!gpe || !gpdev)
 		return;
 
+	npe->table_group.tce32_start = gpe->table_group.tce32_start;
+	npe->table_group.tce32_size = gpe->table_group.tce32_size;
+	npe->table_group.max_dynamic_windows_supported =
+			gpe->table_group.max_dynamic_windows_supported;
+	npe->table_group.max_levels = gpe->table_group.max_levels;
+	npe->table_group.pgsizes = gpe->table_group.pgsizes;
+	npe->tce_bypass_base = gpe->tce_bypass_base;
+#ifdef CONFIG_IOMMU_API
+	npe->table_group.ops = &pnv_pci_npu_ops;
+#endif
+
 	iommu_register_group(&npe->table_group, phb->hose->global_number,
 			npe->pe_number);
 
-- 
2.5.0.rc3
