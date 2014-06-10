Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401EA1A02B3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 11:57:25 +1000 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Tue, 10 Jun 2014 07:27:23 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id CF1F43940048
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 07:27:20 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5A1vYuA8716776
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 07:27:34 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5A1vKgP009642
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 07:27:20 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: benh@au1.ibm.com
Subject: [RFC PATCH V3 17/17] ppc/pnv: Group VF PE when IOV BAR is big on PHB3
Date: Tue, 10 Jun 2014 09:56:39 +0800
Message-Id: <1402365399-5121-18-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
 gwshan@linux.vnet.ibm.com, qiudayu@linux.vnet.ibm.com, bhelgaas@google.com,
 yan@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When IOV BAR is big, each of it is covered by 4 M64 window. This leads to
several VF PE sits in one PE in terms of M64.

This patch group VF PEs according to the M64 allocation.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pci-bridge.h     |    2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c |  183 +++++++++++++++++++++++------
 2 files changed, 145 insertions(+), 40 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 36b88e4..f0a21f5 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -173,7 +173,7 @@ struct pci_dn {
 	int     offset;
 #define M64_PER_IOV 4
 	int     m64_per_iov;
-	int     m64_wins[PCI_SRIOV_NUM_BARS];
+	int     m64_wins[PCI_SRIOV_NUM_BARS][M64_PER_IOV];
 #endif /* CONFIG_PCI_IOV */
 #endif
 };
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 98fc163..86688cd 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -804,26 +804,27 @@ static int pnv_pci_vf_release_m64(struct pci_dev *pdev)
 	struct pci_controller *hose;
 	struct pnv_phb        *phb;
 	struct pci_dn         *pdn;
-	int                    i;
+	int                    i, j;
 
 	bus = pdev->bus;
 	hose = pci_bus_to_host(bus);
 	phb = hose->private_data;
 	pdn = pci_get_pdn(pdev);
 
-	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
-		if (pdn->m64_wins[i] == -1)
-			continue;
-		opal_pci_phb_mmio_enable(phb->opal_id,
-				OPAL_M64_WINDOW_TYPE, pdn->m64_wins[i], 0);
-		clear_bit(pdn->m64_wins[i], &phb->ioda.m64win_alloc);
-		pdn->m64_wins[i] = -1;
-	}
+	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++)
+		for (j = 0; j < M64_PER_IOV; j++) {
+			if (pdn->m64_wins[i][j] == -1)
+				continue;
+			opal_pci_phb_mmio_enable(phb->opal_id,
+				OPAL_M64_WINDOW_TYPE, pdn->m64_wins[i][j], 0);
+			clear_bit(pdn->m64_wins[i][j], &phb->ioda.m64win_alloc);
+			pdn->m64_wins[i][j] = -1;
+		}
 
 	return 0;
 }
 
-static int pnv_pci_vf_assign_m64(struct pci_dev *pdev)
+static int pnv_pci_vf_assign_m64(struct pci_dev *pdev, u16 vf_num)
 {
 	struct pci_bus        *bus;
 	struct pci_controller *hose;
@@ -831,17 +832,33 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev)
 	struct pci_dn         *pdn;
 	unsigned int           win;
 	struct resource       *res;
-	int                    i;
+	int                    i, j;
 	int64_t                rc;
+	int                    total_vfs;
+	resource_size_t        size, start;
+	int                    pe_num;
+	int                    vf_groups;
+	int                    vf_per_group;
 
 	bus = pdev->bus;
 	hose = pci_bus_to_host(bus);
 	phb = hose->private_data;
 	pdn = pci_get_pdn(pdev);
+	total_vfs = pci_sriov_get_totalvfs(pdev);
 
 	/* Initialize the m64_wins to -1 */
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++)
-		pdn->m64_wins[i] = -1;
+		for (j = 0; j < 4; j++)
+			pdn->m64_wins[i][j] = -1;
+
+	if (pdn->m64_per_iov == M64_PER_IOV) {
+		vf_groups = (vf_num <= M64_PER_IOV) ? vf_num: M64_PER_IOV;
+		vf_per_group = (vf_num <= M64_PER_IOV)? 1:
+			__roundup_pow_of_two(vf_num) / pdn->m64_per_iov;
+	} else {
+		vf_groups = 1;
+		vf_per_group = 1;
+	}
 
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
 		res = pdev->resource + PCI_IOV_RESOURCES + i;
@@ -851,33 +868,61 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev)
 		if (!is_mem_pref_64_type(res->flags))
 			continue;
 
-		do {
-			win = find_next_zero_bit(&phb->ioda.m64win_alloc,
-					phb->ioda.m64_bars, 0);
-
-			if (win >= phb->ioda.m64_bars)
-				goto m64_failed;
-		} while (test_and_set_bit(win, &phb->ioda.m64win_alloc));
+		for (j = 0; j < vf_groups; j++) {
+			do {
+				win = find_next_zero_bit(&phb->ioda.m64win_alloc,
+						phb->ioda.m64_bars, 0);
+
+				if (win >= phb->ioda.m64_bars)
+					goto m64_failed;
+			} while (test_and_set_bit(win, &phb->ioda.m64win_alloc));
+
+			pdn->m64_wins[i][j] = win;
+
+			if (pdn->m64_per_iov == M64_PER_IOV) {
+				size = pci_sriov_resource_size(pdev,
+						PCI_IOV_RESOURCES + i);
+				size = size * vf_per_group;
+				start = res->start + size * j;
+			} else {
+				size = resource_size(res);
+				start = res->start;
+			}
 
-		pdn->m64_wins[i] = win;
+			/* Map the M64 here */
+			if (pdn->m64_per_iov == M64_PER_IOV) {
+				pe_num = pdn->offset + j;
+				rc = opal_pci_map_pe_mmio_window(phb->opal_id,
+						pe_num, OPAL_M64_WINDOW_TYPE,
+						pdn->m64_wins[i][j], 0);
+			}
 
-		/* Map the M64 here */
-		rc = opal_pci_set_phb_mem_window(phb->opal_id,
+			rc = opal_pci_set_phb_mem_window(phb->opal_id,
 						 OPAL_M64_WINDOW_TYPE,
-						 pdn->m64_wins[i],
-						 res->start,
+						 pdn->m64_wins[i][j],
+						 start,
 						 0, /* unused */
-						 resource_size(res));
-		if (rc != OPAL_SUCCESS) {
-			pr_err("Failed to map M64 BAR #%d: %lld\n", win, rc);
-			goto m64_failed;
-		}
+						 size);
 
-		rc = opal_pci_phb_mmio_enable(phb->opal_id,
-				OPAL_M64_WINDOW_TYPE, pdn->m64_wins[i], 1);
-		if (rc != OPAL_SUCCESS) {
-			pr_err("Failed to enable M64 BAR #%d: %llx\n", win, rc);
-			goto m64_failed;
+
+			if (rc != OPAL_SUCCESS) {
+				pr_err("Failed to set M64 BAR #%d: %lld\n",
+						win, rc);
+				goto m64_failed;
+			}
+
+			if (pdn->m64_per_iov == M64_PER_IOV)
+				rc = opal_pci_phb_mmio_enable(phb->opal_id,
+				     OPAL_M64_WINDOW_TYPE, pdn->m64_wins[i][j], 2);
+			else
+				rc = opal_pci_phb_mmio_enable(phb->opal_id,
+				     OPAL_M64_WINDOW_TYPE, pdn->m64_wins[i][j], 1);
+
+			if (rc != OPAL_SUCCESS) {
+				pr_err("Failed to enable M64 BAR #%d: %llx\n",
+						win, rc);
+				goto m64_failed;
+			}
 		}
 	}
 	return 0;
@@ -987,21 +1032,51 @@ static void pnv_pci_release_vf_node(struct pci_dev *dev, u16 vf_num)
 	}
 }
 
-static void pnv_ioda_release_vf_PE(struct pci_dev *pdev)
+static void pnv_ioda_release_vf_PE(struct pci_dev *pdev, u16 vf_num)
 {
 	struct pci_bus        *bus;
 	struct pci_controller *hose;
 	struct pnv_phb        *phb;
 	struct pnv_ioda_pe    *pe, *pe_n;
 	struct pci_dn         *pdn;
+	u16                    vf_index;
+	int64_t                rc;
 
 	bus = pdev->bus;
 	hose = pci_bus_to_host(bus);
 	phb = hose->private_data;
+	pdn = pci_get_pdn(pdev);
 
 	if (!pdev->is_physfn)
 		return;
 
+	if (pdn->m64_per_iov == M64_PER_IOV && vf_num > M64_PER_IOV) {
+		int   vf_group;
+		int   vf_per_group;
+		int   vf_index1;
+
+		vf_per_group = __roundup_pow_of_two(vf_num) / pdn->m64_per_iov;
+
+		for (vf_group = 0; vf_group < M64_PER_IOV; vf_group++)
+			for (vf_index = vf_group * vf_per_group;
+				vf_index < (vf_group + 1) * vf_per_group;
+				vf_index++)
+				for (vf_index1 = vf_group * vf_per_group;
+					vf_index1 < (vf_group + 1) * vf_per_group;
+					vf_index1++){
+
+					rc = opal_pci_set_peltv(phb->opal_id,
+						pdn->offset + vf_index,
+						pdn->offset + vf_index1,
+						OPAL_REMOVE_PE_FROM_DOMAIN);
+
+					if (rc)
+					    pr_warn("%s: Failed to unlink same"
+						" group PE#%d(%lld)\n", __func__,
+						pdn->offset + vf_index1, rc);
+				}
+	}
+
 	pdn = pci_get_pdn(pdev);
 	list_for_each_entry_safe(pe, pe_n, &phb->ioda.pe_list, list) {
 		if (pe->parent_dev != pdev)
@@ -1037,11 +1112,12 @@ int pcibios_sriov_disable(struct pci_dev *pdev)
 	vf_num = iov->num_VFs;
 
 	/* Release VF PEs */
-	pnv_ioda_release_vf_PE(pdev);
+	pnv_ioda_release_vf_PE(pdev, vf_num);
 	pnv_pci_release_vf_node(pdev, vf_num);
 
 	if (phb->type == PNV_PHB_IODA2) {
-		pnv_pci_vf_resource_shift(pdev, -pdn->offset);
+		if (pdn->m64_per_iov == 1)
+			pnv_pci_vf_resource_shift(pdev, -pdn->offset);
 
 		/* Release M64 BARs */
 		pnv_pci_vf_release_m64(pdev);
@@ -1065,6 +1141,7 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 vf_num)
 	int                    pe_num;
 	u16                    vf_index;
 	struct pci_dn         *pdn;
+	int64_t                rc;
 
 	bus = pdev->bus;
 	hose = pci_bus_to_host(bus);
@@ -1112,7 +1189,34 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 vf_num)
 		mutex_unlock(&phb->ioda.pe_list_mutex);
 
 		pnv_pci_ioda2_setup_dma_pe(phb, pe);
+	}
 
+	if (pdn->m64_per_iov == M64_PER_IOV && vf_num > M64_PER_IOV) {
+		int   vf_group;
+		int   vf_per_group;
+		int   vf_index1;
+
+		vf_per_group = __roundup_pow_of_two(vf_num) / pdn->m64_per_iov;
+
+		for (vf_group = 0; vf_group < M64_PER_IOV; vf_group++)
+			for (vf_index = vf_group * vf_per_group;
+				vf_index < (vf_group + 1) * vf_per_group;
+				vf_index++)
+				for (vf_index1 = vf_group * vf_per_group;
+					vf_index1 < (vf_group + 1) * vf_per_group;
+					vf_index1++) {
+
+					rc = opal_pci_set_peltv(phb->opal_id,
+						pdn->offset + vf_index,
+						pdn->offset + vf_index1,
+						OPAL_ADD_PE_TO_DOMAIN);
+
+					if (rc)
+					    pr_warn("%s: Failed to link same "
+						"group PE#%d(%lld)\n",
+						__func__,
+						pdn->offset + vf_index1, rc);
+			}
 	}
 }
 
@@ -1146,14 +1250,15 @@ int pcibios_sriov_enable(struct pci_dev *pdev, u16 vf_num)
 		mutex_unlock(&phb->ioda.pe_alloc_mutex);
 
 		/* Assign M64 BAR accordingly */
-		ret = pnv_pci_vf_assign_m64(pdev);
+		ret = pnv_pci_vf_assign_m64(pdev, vf_num);
 		if (ret) {
 			pr_info("No enough M64 resource\n");
 			goto m64_failed;
 		}
 
 		/* Do some magic shift */
-		pnv_pci_vf_resource_shift(pdev, pdn->offset);
+		if (pdn->m64_per_iov == 1)
+			pnv_pci_vf_resource_shift(pdev, pdn->offset);
 	}
 
 	/* Setup VF PEs */
-- 
1.7.9.5
