Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 421561A1760
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2015 17:23:07 +1000 (AEST)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 19FB21402AB
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 17:23:07 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Wed, 29 Jul 2015 17:23:06 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 850BE3578054
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 17:23:01 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6T7MpMM61603904
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 17:23:01 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6T7MRiS010660
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 17:22:27 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: aik@ozlabs.ru, gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org, Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/powernv: use one M64 BAR in Single PE mode for one VF
 BAR
Date: Wed, 29 Jul 2015 15:22:07 +0800
Message-Id: <1438154528-19608-1-git-send-email-weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In current implementation, when VF BAR is bigger than 64MB, it uses 4 M64
BAR in Single PE mode to cover the number of VFs required to be enabled.
By doing so, several VFs would be in one VF Group and leads to interference
between VFs in the same group.

This patch changes the design by using one M64 BAR in Single PE mode for
one VF BAR. This gives absolute isolation for VFs.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pci-bridge.h     |    5 +-
 arch/powerpc/platforms/powernv/pci-ioda.c |  104 +++++------------------------
 2 files changed, 18 insertions(+), 91 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 712add5..1997e5d 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -214,10 +214,9 @@ struct pci_dn {
 	u16     vfs_expanded;		/* number of VFs IOV BAR expanded */
 	u16     num_vfs;		/* number of VFs enabled*/
 	int     offset;			/* PE# for the first VF PE */
-#define M64_PER_IOV 4
-	int     m64_per_iov;
+#define MAX_M64_WINDOW  16
 #define IODA_INVALID_M64        (-1)
-	int     m64_wins[PCI_SRIOV_NUM_BARS][M64_PER_IOV];
+	int     m64_wins[PCI_SRIOV_NUM_BARS][MAX_M64_WINDOW];
 #endif /* CONFIG_PCI_IOV */
 #endif
 	struct list_head child_list;
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 5738d31..b3e7909 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1168,7 +1168,7 @@ static int pnv_pci_vf_release_m64(struct pci_dev *pdev)
 	pdn = pci_get_pdn(pdev);
 
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++)
-		for (j = 0; j < M64_PER_IOV; j++) {
+		for (j = 0; j < MAX_M64_WINDOW; j++) {
 			if (pdn->m64_wins[i][j] == IODA_INVALID_M64)
 				continue;
 			opal_pci_phb_mmio_enable(phb->opal_id,
@@ -1193,8 +1193,7 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev, u16 num_vfs)
 	int                    total_vfs;
 	resource_size_t        size, start;
 	int                    pe_num;
-	int                    vf_groups;
-	int                    vf_per_group;
+	int                    m64s;
 
 	bus = pdev->bus;
 	hose = pci_bus_to_host(bus);
@@ -1204,17 +1203,13 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev, u16 num_vfs)
 
 	/* Initialize the m64_wins to IODA_INVALID_M64 */
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++)
-		for (j = 0; j < M64_PER_IOV; j++)
+		for (j = 0; j < MAX_M64_WINDOW; j++)
 			pdn->m64_wins[i][j] = IODA_INVALID_M64;
 
-	if (pdn->m64_per_iov == M64_PER_IOV) {
-		vf_groups = (num_vfs <= M64_PER_IOV) ? num_vfs: M64_PER_IOV;
-		vf_per_group = (num_vfs <= M64_PER_IOV)? 1:
-			roundup_pow_of_two(num_vfs) / pdn->m64_per_iov;
-	} else {
-		vf_groups = 1;
-		vf_per_group = 1;
-	}
+	if (pdn->vfs_expanded != phb->ioda.total_pe)
+		m64s = num_vfs;
+	else
+		m64s = 1;
 
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
 		res = &pdev->resource[i + PCI_IOV_RESOURCES];
@@ -1224,7 +1219,7 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev, u16 num_vfs)
 		if (!pnv_pci_is_mem_pref_64(res->flags))
 			continue;
 
-		for (j = 0; j < vf_groups; j++) {
+		for (j = 0; j < m64s; j++) {
 			do {
 				win = find_next_zero_bit(&phb->ioda.m64_bar_alloc,
 						phb->ioda.m64_bar_idx + 1, 0);
@@ -1235,10 +1230,9 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev, u16 num_vfs)
 
 			pdn->m64_wins[i][j] = win;
 
-			if (pdn->m64_per_iov == M64_PER_IOV) {
+			if (pdn->vfs_expanded != phb->ioda.total_pe) {
 				size = pci_iov_resource_size(pdev,
 							PCI_IOV_RESOURCES + i);
-				size = size * vf_per_group;
 				start = res->start + size * j;
 			} else {
 				size = resource_size(res);
@@ -1246,7 +1240,7 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev, u16 num_vfs)
 			}
 
 			/* Map the M64 here */
-			if (pdn->m64_per_iov == M64_PER_IOV) {
+			if (pdn->vfs_expanded != phb->ioda.total_pe) {
 				pe_num = pdn->offset + j;
 				rc = opal_pci_map_pe_mmio_window(phb->opal_id,
 						pe_num, OPAL_M64_WINDOW_TYPE,
@@ -1267,7 +1261,7 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev, u16 num_vfs)
 				goto m64_failed;
 			}
 
-			if (pdn->m64_per_iov == M64_PER_IOV)
+			if (pdn->vfs_expanded != phb->ioda.total_pe)
 				rc = opal_pci_phb_mmio_enable(phb->opal_id,
 				     OPAL_M64_WINDOW_TYPE, pdn->m64_wins[i][j], 2);
 			else
@@ -1311,15 +1305,13 @@ static void pnv_pci_ioda2_release_dma_pe(struct pci_dev *dev, struct pnv_ioda_pe
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
@@ -1329,35 +1321,6 @@ static void pnv_ioda_release_vf_PE(struct pci_dev *pdev, u16 num_vfs)
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
@@ -1392,10 +1355,10 @@ void pnv_pci_sriov_disable(struct pci_dev *pdev)
 	num_vfs = pdn->num_vfs;
 
 	/* Release VF PEs */
-	pnv_ioda_release_vf_PE(pdev, num_vfs);
+	pnv_ioda_release_vf_PE(pdev);
 
 	if (phb->type == PNV_PHB_IODA2) {
-		if (pdn->m64_per_iov == 1)
+		if (pdn->vfs_expanded == phb->ioda.total_pe)
 			pnv_pci_vf_resource_shift(pdev, -pdn->offset);
 
 		/* Release M64 windows */
@@ -1418,7 +1381,6 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
 	int                    pe_num;
 	u16                    vf_index;
 	struct pci_dn         *pdn;
-	int64_t                rc;
 
 	bus = pdev->bus;
 	hose = pci_bus_to_host(bus);
@@ -1463,37 +1425,6 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
 
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
@@ -1537,7 +1468,7 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
 		 * the IOV BAR according to the PE# allocated to the VFs.
 		 * Otherwise, the PE# for the VF will conflict with others.
 		 */
-		if (pdn->m64_per_iov == 1) {
+		if (pdn->vfs_expanded == phb->ioda.total_pe) {
 			ret = pnv_pci_vf_resource_shift(pdev, pdn->offset);
 			if (ret)
 				goto m64_failed;
@@ -1570,8 +1501,7 @@ int pcibios_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
 	/* Allocate PCI data */
 	add_dev_pci_data(pdev);
 
-	pnv_pci_sriov_enable(pdev, num_vfs);
-	return 0;
+	return pnv_pci_sriov_enable(pdev, num_vfs);
 }
 #endif /* CONFIG_PCI_IOV */
 
@@ -2766,7 +2696,6 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
 	pdn->vfs_expanded = 0;
 
 	total_vfs = pci_sriov_get_totalvfs(pdev);
-	pdn->m64_per_iov = 1;
 	mul = phb->ioda.total_pe;
 
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
@@ -2785,7 +2714,6 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
 		if (size > (1 << 26)) {
 			dev_info(&pdev->dev, "PowerNV: VF BAR%d: %pR IOV size is bigger than 64M, roundup power2\n",
 				 i, res);
-			pdn->m64_per_iov = M64_PER_IOV;
 			mul = roundup_pow_of_two(total_vfs);
 			break;
 		}
-- 
1.7.9.5
