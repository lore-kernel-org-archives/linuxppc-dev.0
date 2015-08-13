Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D66EE1A1DFA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 00:12:40 +1000 (AEST)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B2F9A1401B5
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 00:12:40 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Fri, 14 Aug 2015 00:12:39 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id A5C4B3578057
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 00:12:37 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7DECNbo59375824
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 00:12:32 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7DEC5fV001804
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 00:12:05 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: aik@ozlabs.ru, gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org, Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH v3 3/6] powerpc/powernv: use one M64 BAR in Single PE mode for
 one VF BAR
Date: Thu, 13 Aug 2015 22:11:08 +0800
Message-Id: <1439475071-7001-4-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1439475071-7001-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1439475071-7001-1-git-send-email-weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In current implementation, when VF BAR is bigger than 64MB, it uses 4 M64
BARs in Single PE mode to cover the number of VFs required to be enabled.
By doing so, several VFs would be in one VF Group and leads to interference
between VFs in the same group.

This patch changes the design by using one M64 BAR in Single PE mode for
one VF BAR. This gives absolute isolation for VFs.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pci-bridge.h     |    6 +-
 arch/powerpc/platforms/powernv/pci-ioda.c |  163 +++++++++++------------------
 2 files changed, 62 insertions(+), 107 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 712add5..9d33ada 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -187,6 +187,7 @@ static inline int isa_vaddr_is_ioport(void __iomem *address)
  */
 struct iommu_table;
 
+#define MAX_M64_BAR  16
 struct pci_dn {
 	int     flags;
 #define PCI_DN_FLAG_IOV_VF	0x01
@@ -214,10 +215,9 @@ struct pci_dn {
 	u16     vfs_expanded;		/* number of VFs IOV BAR expanded */
 	u16     num_vfs;		/* number of VFs enabled*/
 	int     offset;			/* PE# for the first VF PE */
-#define M64_PER_IOV 4
-	int     m64_per_iov;
+	bool    m64_single_mode;	/* Use M64 BAR in Single Mode */
 #define IODA_INVALID_M64        (-1)
-	int     m64_wins[PCI_SRIOV_NUM_BARS][M64_PER_IOV];
+	int      m64_map[PCI_SRIOV_NUM_BARS][MAX_M64_BAR];
 #endif /* CONFIG_PCI_IOV */
 #endif
 	struct list_head child_list;
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 67b8f72..4da0f50 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1162,15 +1162,14 @@ static int pnv_pci_vf_release_m64(struct pci_dev *pdev)
 	pdn = pci_get_pdn(pdev);
 
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++)
-		for (j = 0; j < M64_PER_IOV; j++) {
-			if (pdn->m64_wins[i][j] == IODA_INVALID_M64)
+		for (j = 0; j < MAX_M64_BAR; j++) {
+			if (pdn->m64_map[i][j] == IODA_INVALID_M64)
 				continue;
 			opal_pci_phb_mmio_enable(phb->opal_id,
-				OPAL_M64_WINDOW_TYPE, pdn->m64_wins[i][j], 0);
-			clear_bit(pdn->m64_wins[i][j], &phb->ioda.m64_bar_alloc);
-			pdn->m64_wins[i][j] = IODA_INVALID_M64;
+				OPAL_M64_WINDOW_TYPE, pdn->m64_map[i][j], 0);
+			clear_bit(pdn->m64_map[i][j], &phb->ioda.m64_bar_alloc);
+			pdn->m64_map[i][j] = IODA_INVALID_M64;
 		}
-
 	return 0;
 }
 
@@ -1187,8 +1186,7 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev, u16 num_vfs)
 	int                    total_vfs;
 	resource_size_t        size, start;
 	int                    pe_num;
-	int                    vf_groups;
-	int                    vf_per_group;
+	int                    m64_bars;
 
 	bus = pdev->bus;
 	hose = pci_bus_to_host(bus);
@@ -1196,26 +1194,23 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev, u16 num_vfs)
 	pdn = pci_get_pdn(pdev);
 	total_vfs = pci_sriov_get_totalvfs(pdev);
 
-	/* Initialize the m64_wins to IODA_INVALID_M64 */
-	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++)
-		for (j = 0; j < M64_PER_IOV; j++)
-			pdn->m64_wins[i][j] = IODA_INVALID_M64;
+	if (pdn->m64_single_mode)
+		m64_bars = num_vfs;
+	else
+		m64_bars = 1;
+
+	/* Initialize the m64_map to IODA_INVALID_M64 */
+	for (i = 0; i < PCI_SRIOV_NUM_BARS ; i++)
+		for (j = 0; j < MAX_M64_BAR; j++)
+			pdn->m64_map[i][j] = IODA_INVALID_M64;
 
-	if (pdn->m64_per_iov == M64_PER_IOV) {
-		vf_groups = (num_vfs <= M64_PER_IOV) ? num_vfs: M64_PER_IOV;
-		vf_per_group = (num_vfs <= M64_PER_IOV)? 1:
-			roundup_pow_of_two(num_vfs) / pdn->m64_per_iov;
-	} else {
-		vf_groups = 1;
-		vf_per_group = 1;
-	}
 
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
 		res = &pdev->resource[i + PCI_IOV_RESOURCES];
 		if (!res->flags || !res->parent)
 			continue;
 
-		for (j = 0; j < vf_groups; j++) {
+		for (j = 0; j < m64_bars; j++) {
 			do {
 				win = find_next_zero_bit(&phb->ioda.m64_bar_alloc,
 						phb->ioda.m64_bar_idx + 1, 0);
@@ -1224,12 +1219,11 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev, u16 num_vfs)
 					goto m64_failed;
 			} while (test_and_set_bit(win, &phb->ioda.m64_bar_alloc));
 
-			pdn->m64_wins[i][j] = win;
+			pdn->m64_map[i][j] = win;
 
-			if (pdn->m64_per_iov == M64_PER_IOV) {
+			if (pdn->m64_single_mode) {
 				size = pci_iov_resource_size(pdev,
 							PCI_IOV_RESOURCES + i);
-				size = size * vf_per_group;
 				start = res->start + size * j;
 			} else {
 				size = resource_size(res);
@@ -1237,16 +1231,16 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev, u16 num_vfs)
 			}
 
 			/* Map the M64 here */
-			if (pdn->m64_per_iov == M64_PER_IOV) {
+			if (pdn->m64_single_mode) {
 				pe_num = pdn->offset + j;
 				rc = opal_pci_map_pe_mmio_window(phb->opal_id,
 						pe_num, OPAL_M64_WINDOW_TYPE,
-						pdn->m64_wins[i][j], 0);
+						pdn->m64_map[i][j], 0);
 			}
 
 			rc = opal_pci_set_phb_mem_window(phb->opal_id,
 						 OPAL_M64_WINDOW_TYPE,
-						 pdn->m64_wins[i][j],
+						 pdn->m64_map[i][j],
 						 start,
 						 0, /* unused */
 						 size);
@@ -1258,12 +1252,12 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev, u16 num_vfs)
 				goto m64_failed;
 			}
 
-			if (pdn->m64_per_iov == M64_PER_IOV)
+			if (pdn->m64_single_mode)
 				rc = opal_pci_phb_mmio_enable(phb->opal_id,
-				     OPAL_M64_WINDOW_TYPE, pdn->m64_wins[i][j], 2);
+				     OPAL_M64_WINDOW_TYPE, pdn->m64_map[i][j], 2);
 			else
 				rc = opal_pci_phb_mmio_enable(phb->opal_id,
-				     OPAL_M64_WINDOW_TYPE, pdn->m64_wins[i][j], 1);
+				     OPAL_M64_WINDOW_TYPE, pdn->m64_map[i][j], 1);
 
 			if (rc != OPAL_SUCCESS) {
 				dev_err(&pdev->dev, "Failed to enable M64 window #%d: %llx\n",
@@ -1302,15 +1296,13 @@ static void pnv_pci_ioda2_release_dma_pe(struct pci_dev *dev, struct pnv_ioda_pe
 	iommu_free_table(tbl, of_node_full_name(dev->dev.of_node));
 }
 
-static void pnv_ioda_release_vf_PE(struct pci_dev *pdev, u16 num_vfs)
+static void pnv_ioda_release_vf_PE(struct pci_dev *pdev)
 {
 	struct pci_bus        *bus;
 	struct pci_controller *hose;
 	struct pnv_phb        *phb;
 	struct pnv_ioda_pe    *pe, *pe_n;
 	struct pci_dn         *pdn;
-	u16                    vf_index;
-	int64_t                rc;
 
 	bus = pdev->bus;
 	hose = pci_bus_to_host(bus);
@@ -1320,35 +1312,6 @@ static void pnv_ioda_release_vf_PE(struct pci_dev *pdev, u16 num_vfs)
 	if (!pdev->is_physfn)
 		return;
 
-	if (pdn->m64_per_iov == M64_PER_IOV && num_vfs > M64_PER_IOV) {
-		int   vf_group;
-		int   vf_per_group;
-		int   vf_index1;
-
-		vf_per_group = roundup_pow_of_two(num_vfs) / pdn->m64_per_iov;
-
-		for (vf_group = 0; vf_group < M64_PER_IOV; vf_group++)
-			for (vf_index = vf_group * vf_per_group;
-				vf_index < (vf_group + 1) * vf_per_group &&
-				vf_index < num_vfs;
-				vf_index++)
-				for (vf_index1 = vf_group * vf_per_group;
-					vf_index1 < (vf_group + 1) * vf_per_group &&
-					vf_index1 < num_vfs;
-					vf_index1++){
-
-					rc = opal_pci_set_peltv(phb->opal_id,
-						pdn->offset + vf_index,
-						pdn->offset + vf_index1,
-						OPAL_REMOVE_PE_FROM_DOMAIN);
-
-					if (rc)
-					    dev_warn(&pdev->dev, "%s: Failed to unlink same group PE#%d(%lld)\n",
-						__func__,
-						pdn->offset + vf_index1, rc);
-				}
-	}
-
 	list_for_each_entry_safe(pe, pe_n, &phb->ioda.pe_list, list) {
 		if (pe->parent_dev != pdev)
 			continue;
@@ -1383,10 +1346,10 @@ void pnv_pci_sriov_disable(struct pci_dev *pdev)
 	num_vfs = pdn->num_vfs;
 
 	/* Release VF PEs */
-	pnv_ioda_release_vf_PE(pdev, num_vfs);
+	pnv_ioda_release_vf_PE(pdev);
 
 	if (phb->type == PNV_PHB_IODA2) {
-		if (pdn->m64_per_iov == 1)
+		if (!pdn->m64_single_mode)
 			pnv_pci_vf_resource_shift(pdev, -pdn->offset);
 
 		/* Release M64 windows */
@@ -1409,7 +1372,6 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
 	int                    pe_num;
 	u16                    vf_index;
 	struct pci_dn         *pdn;
-	int64_t                rc;
 
 	bus = pdev->bus;
 	hose = pci_bus_to_host(bus);
@@ -1454,37 +1416,6 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
 
 		pnv_pci_ioda2_setup_dma_pe(phb, pe);
 	}
-
-	if (pdn->m64_per_iov == M64_PER_IOV && num_vfs > M64_PER_IOV) {
-		int   vf_group;
-		int   vf_per_group;
-		int   vf_index1;
-
-		vf_per_group = roundup_pow_of_two(num_vfs) / pdn->m64_per_iov;
-
-		for (vf_group = 0; vf_group < M64_PER_IOV; vf_group++) {
-			for (vf_index = vf_group * vf_per_group;
-			     vf_index < (vf_group + 1) * vf_per_group &&
-			     vf_index < num_vfs;
-			     vf_index++) {
-				for (vf_index1 = vf_group * vf_per_group;
-				     vf_index1 < (vf_group + 1) * vf_per_group &&
-				     vf_index1 < num_vfs;
-				     vf_index1++) {
-
-					rc = opal_pci_set_peltv(phb->opal_id,
-						pdn->offset + vf_index,
-						pdn->offset + vf_index1,
-						OPAL_ADD_PE_TO_DOMAIN);
-
-					if (rc)
-					    dev_warn(&pdev->dev, "%s: Failed to link same group PE#%d(%lld)\n",
-						__func__,
-						pdn->offset + vf_index1, rc);
-				}
-			}
-		}
-	}
 }
 
 int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
@@ -1507,6 +1438,15 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
 			return -ENOSPC;
 		}
 
+		/*
+		 * When M64 BAR functions in Single PE mode, the number of VFs
+		 * could be enabled must be less than the number of M64 BARs.
+		 */
+		if (pdn->m64_single_mode && num_vfs > phb->ioda.m64_bar_idx) {
+			dev_info(&pdev->dev, "Not enough M64 BAR for VFs\n");
+			return -EBUSY;
+		}
+
 		/* Calculate available PE for required VFs */
 		mutex_lock(&phb->ioda.pe_alloc_mutex);
 		pdn->offset = bitmap_find_next_zero_area(
@@ -1534,7 +1474,7 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
 		 * the IOV BAR according to the PE# allocated to the VFs.
 		 * Otherwise, the PE# for the VF will conflict with others.
 		 */
-		if (pdn->m64_per_iov == 1) {
+		if (!pdn->m64_single_mode) {
 			ret = pnv_pci_vf_resource_shift(pdev, pdn->offset);
 			if (ret)
 				goto m64_failed;
@@ -1567,8 +1507,7 @@ int pcibios_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
 	/* Allocate PCI data */
 	add_dev_pci_data(pdev);
 
-	pnv_pci_sriov_enable(pdev, num_vfs);
-	return 0;
+	return pnv_pci_sriov_enable(pdev, num_vfs);
 }
 #endif /* CONFIG_PCI_IOV */
 
@@ -2761,9 +2700,9 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
 
 	pdn = pci_get_pdn(pdev);
 	pdn->vfs_expanded = 0;
+	pdn->m64_single_mode = false;
 
 	total_vfs = pci_sriov_get_totalvfs(pdev);
-	pdn->m64_per_iov = 1;
 	mul = phb->ioda.total_pe;
 
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
@@ -2783,8 +2722,8 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
 		if (size > (1 << 26)) {
 			dev_info(&pdev->dev, "PowerNV: VF BAR%d: %pR IOV size is bigger than 64M, roundup power2\n",
 				 i, res);
-			pdn->m64_per_iov = M64_PER_IOV;
 			mul = roundup_pow_of_two(total_vfs);
+			pdn->m64_single_mode = true;
 			break;
 		}
 	}
@@ -2986,6 +2925,8 @@ static resource_size_t pnv_pci_window_alignment(struct pci_bus *bus,
 static resource_size_t pnv_pci_iov_resource_alignment(struct pci_dev *pdev,
 						      int resno)
 {
+	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
+	struct pnv_phb *phb = hose->private_data;
 	struct pci_dn *pdn = pci_get_pdn(pdev);
 	resource_size_t align;
 
@@ -2994,12 +2935,26 @@ static resource_size_t pnv_pci_iov_resource_alignment(struct pci_dev *pdev,
 	 * SR-IOV. While from hardware perspective, the range mapped by M64
 	 * BAR should be size aligned.
 	 *
+	 * When IOV BAR is mapped with M64 BAR in Single PE mode, the extra
+	 * powernv-specific hardware restriction is gone. But if just use the
+	 * VF BAR size as the alignment, PF BAR / VF BAR may be allocated with
+	 * in one segment of M64 #15, which introduces the PE conflict between
+	 * PF and VF. Based on this, the minimum alignment of an IOV BAR is
+	 * m64_segsize.
+	 *
 	 * This function return the total IOV BAR size if expanded or just the
-	 * individual size if not.
+	 * individual size if not, when M64 BAR is in Shared PE mode.
+	 * If the M64 BAR is in Single PE mode, return the VF BAR size or
+	 * m64_size if IOV BAR size is less.
 	 */
 	align = pci_iov_resource_size(pdev, resno);
-	if (pdn->vfs_expanded)
-		return pdn->vfs_expanded * align;
+	if (pdn->vfs_expanded) {
+		if (pdn->m64_single_mode)
+			return max(align,
+				(resource_size_t)phb->ioda.m64_segsize);
+		else
+			return pdn->vfs_expanded * align;
+	}
 
 	return align;
 }
-- 
1.7.9.5
