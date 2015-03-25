Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CB4CA1A3078
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 19:31:35 +1100 (AEDT)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Wed, 25 Mar 2015 18:31:35 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 9F64D3578047
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 19:31:33 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2P8VOPu43188438
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 19:31:32 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2P8Uwa9028952
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 19:30:58 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com
Subject: [PATCH V16 18/20] powerpc/powernv: Group VF PE when IOV BAR is big on
 PHB3
Date: Wed, 25 Mar 2015 16:23:59 +0800
Message-Id: <1427271841-28749-19-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1427271841-28749-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1427271841-28749-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, Wei Yang <weiyang@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When IOV BAR is big, each is covered by 4 M64 windows.  This leads to
several VF PE sits in one PE in terms of M64.

Group VF PEs according to the M64 allocation.

[bhelgaas: use dev_printk() when possible]
Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pci-bridge.h     |    2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c |  197 ++++++++++++++++++++++-------
 2 files changed, 154 insertions(+), 45 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 415df85..560c739 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -185,7 +185,7 @@ struct pci_dn {
 #define M64_PER_IOV 4
 	int     m64_per_iov;
 #define IODA_INVALID_M64        (-1)
-	int     m64_wins[PCI_SRIOV_NUM_BARS];
+	int     m64_wins[PCI_SRIOV_NUM_BARS][M64_PER_IOV];
 #endif /* CONFIG_PCI_IOV */
 #endif
 	struct list_head child_list;
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index b63925f..33088f6 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1156,26 +1156,27 @@ static int pnv_pci_vf_release_m64(struct pci_dev *pdev)
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
-		if (pdn->m64_wins[i] == IODA_INVALID_M64)
-			continue;
-		opal_pci_phb_mmio_enable(phb->opal_id,
-				OPAL_M64_WINDOW_TYPE, pdn->m64_wins[i], 0);
-		clear_bit(pdn->m64_wins[i], &phb->ioda.m64_bar_alloc);
-		pdn->m64_wins[i] = IODA_INVALID_M64;
-	}
+	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++)
+		for (j = 0; j < M64_PER_IOV; j++) {
+			if (pdn->m64_wins[i][j] == IODA_INVALID_M64)
+				continue;
+			opal_pci_phb_mmio_enable(phb->opal_id,
+				OPAL_M64_WINDOW_TYPE, pdn->m64_wins[i][j], 0);
+			clear_bit(pdn->m64_wins[i][j], &phb->ioda.m64_bar_alloc);
+			pdn->m64_wins[i][j] = IODA_INVALID_M64;
+		}
 
 	return 0;
 }
 
-static int pnv_pci_vf_assign_m64(struct pci_dev *pdev)
+static int pnv_pci_vf_assign_m64(struct pci_dev *pdev, u16 num_vfs)
 {
 	struct pci_bus        *bus;
 	struct pci_controller *hose;
@@ -1183,17 +1184,33 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev)
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
 
 	/* Initialize the m64_wins to IODA_INVALID_M64 */
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++)
-		pdn->m64_wins[i] = IODA_INVALID_M64;
+		for (j = 0; j < M64_PER_IOV; j++)
+			pdn->m64_wins[i][j] = IODA_INVALID_M64;
+
+	if (pdn->m64_per_iov == M64_PER_IOV) {
+		vf_groups = (num_vfs <= M64_PER_IOV) ? num_vfs: M64_PER_IOV;
+		vf_per_group = (num_vfs <= M64_PER_IOV)? 1:
+			roundup_pow_of_two(num_vfs) / pdn->m64_per_iov;
+	} else {
+		vf_groups = 1;
+		vf_per_group = 1;
+	}
 
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
 		res = &pdev->resource[i + PCI_IOV_RESOURCES];
@@ -1203,35 +1220,61 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev)
 		if (!pnv_pci_is_mem_pref_64(res->flags))
 			continue;
 
-		do {
-			win = find_next_zero_bit(&phb->ioda.m64_bar_alloc,
-					phb->ioda.m64_bar_idx + 1, 0);
-
-			if (win >= phb->ioda.m64_bar_idx + 1)
-				goto m64_failed;
-		} while (test_and_set_bit(win, &phb->ioda.m64_bar_alloc));
+		for (j = 0; j < vf_groups; j++) {
+			do {
+				win = find_next_zero_bit(&phb->ioda.m64_bar_alloc,
+						phb->ioda.m64_bar_idx + 1, 0);
+
+				if (win >= phb->ioda.m64_bar_idx + 1)
+					goto m64_failed;
+			} while (test_and_set_bit(win, &phb->ioda.m64_bar_alloc));
+
+			pdn->m64_wins[i][j] = win;
+
+			if (pdn->m64_per_iov == M64_PER_IOV) {
+				size = pci_iov_resource_size(pdev,
+							PCI_IOV_RESOURCES + i);
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
-			dev_err(&pdev->dev, "Failed to map M64 window #%d: %lld\n",
-				win, rc);
-			goto m64_failed;
-		}
+						 size);
 
-		rc = opal_pci_phb_mmio_enable(phb->opal_id,
-				OPAL_M64_WINDOW_TYPE, pdn->m64_wins[i], 1);
-		if (rc != OPAL_SUCCESS) {
-			dev_err(&pdev->dev, "Failed to enable M64 window #%d: %llx\n",
-				win, rc);
-			goto m64_failed;
+
+			if (rc != OPAL_SUCCESS) {
+				dev_err(&pdev->dev, "Failed to map M64 window #%d: %lld\n",
+					win, rc);
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
+				dev_err(&pdev->dev, "Failed to enable M64 window #%d: %llx\n",
+					win, rc);
+				goto m64_failed;
+			}
 		}
 	}
 	return 0;
@@ -1273,22 +1316,53 @@ static void pnv_pci_ioda2_release_dma_pe(struct pci_dev *dev, struct pnv_ioda_pe
 	pe->tce32_table = NULL;
 }
 
-static void pnv_ioda_release_vf_PE(struct pci_dev *pdev)
+static void pnv_ioda_release_vf_PE(struct pci_dev *pdev, u16 num_vfs)
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
 
-	pdn = pci_get_pdn(pdev);
+	if (pdn->m64_per_iov == M64_PER_IOV && num_vfs > M64_PER_IOV) {
+		int   vf_group;
+		int   vf_per_group;
+		int   vf_index1;
+
+		vf_per_group = roundup_pow_of_two(num_vfs) / pdn->m64_per_iov;
+
+		for (vf_group = 0; vf_group < M64_PER_IOV; vf_group++)
+			for (vf_index = vf_group * vf_per_group;
+				vf_index < (vf_group + 1) * vf_per_group &&
+				vf_index < num_vfs;
+				vf_index++)
+				for (vf_index1 = vf_group * vf_per_group;
+					vf_index1 < (vf_group + 1) * vf_per_group &&
+					vf_index1 < num_vfs;
+					vf_index1++){
+
+					rc = opal_pci_set_peltv(phb->opal_id,
+						pdn->offset + vf_index,
+						pdn->offset + vf_index1,
+						OPAL_REMOVE_PE_FROM_DOMAIN);
+
+					if (rc)
+					    dev_warn(&pdev->dev, "%s: Failed to unlink same group PE#%d(%lld)\n",
+						__func__,
+						pdn->offset + vf_index1, rc);
+				}
+	}
+
 	list_for_each_entry_safe(pe, pe_n, &phb->ioda.pe_list, list) {
 		if (pe->parent_dev != pdev)
 			continue;
@@ -1323,10 +1397,11 @@ void pnv_pci_sriov_disable(struct pci_dev *pdev)
 	num_vfs = pdn->num_vfs;
 
 	/* Release VF PEs */
-	pnv_ioda_release_vf_PE(pdev);
+	pnv_ioda_release_vf_PE(pdev, num_vfs);
 
 	if (phb->type == PNV_PHB_IODA2) {
-		pnv_pci_vf_resource_shift(pdev, -pdn->offset);
+		if (pdn->m64_per_iov == 1)
+			pnv_pci_vf_resource_shift(pdev, -pdn->offset);
 
 		/* Release M64 windows */
 		pnv_pci_vf_release_m64(pdev);
@@ -1348,6 +1423,7 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
 	int                    pe_num;
 	u16                    vf_index;
 	struct pci_dn         *pdn;
+	int64_t                rc;
 
 	bus = pdev->bus;
 	hose = pci_bus_to_host(bus);
@@ -1396,6 +1472,37 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
 
 		pnv_pci_ioda2_setup_dma_pe(phb, pe);
 	}
+
+	if (pdn->m64_per_iov == M64_PER_IOV && num_vfs > M64_PER_IOV) {
+		int   vf_group;
+		int   vf_per_group;
+		int   vf_index1;
+
+		vf_per_group = roundup_pow_of_two(num_vfs) / pdn->m64_per_iov;
+
+		for (vf_group = 0; vf_group < M64_PER_IOV; vf_group++) {
+			for (vf_index = vf_group * vf_per_group;
+			     vf_index < (vf_group + 1) * vf_per_group &&
+			     vf_index < num_vfs;
+			     vf_index++) {
+				for (vf_index1 = vf_group * vf_per_group;
+				     vf_index1 < (vf_group + 1) * vf_per_group &&
+				     vf_index1 < num_vfs;
+				     vf_index1++) {
+
+					rc = opal_pci_set_peltv(phb->opal_id,
+						pdn->offset + vf_index,
+						pdn->offset + vf_index1,
+						OPAL_ADD_PE_TO_DOMAIN);
+
+					if (rc)
+					    dev_warn(&pdev->dev, "%s: Failed to link same group PE#%d(%lld)\n",
+						__func__,
+						pdn->offset + vf_index1, rc);
+				}
+			}
+		}
+	}
 }
 
 int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
@@ -1428,7 +1535,7 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
 		mutex_unlock(&phb->ioda.pe_alloc_mutex);
 
 		/* Assign M64 window accordingly */
-		ret = pnv_pci_vf_assign_m64(pdev);
+		ret = pnv_pci_vf_assign_m64(pdev, num_vfs);
 		if (ret) {
 			dev_info(&pdev->dev, "Not enough M64 window resources\n");
 			goto m64_failed;
@@ -1439,9 +1546,11 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
 		 * the IOV BAR according to the PE# allocated to the VFs.
 		 * Otherwise, the PE# for the VF will conflict with others.
 		 */
-		ret = pnv_pci_vf_resource_shift(pdev, pdn->offset);
-		if (ret)
-			goto m64_failed;
+		if (pdn->m64_per_iov == 1) {
+			ret = pnv_pci_vf_resource_shift(pdev, pdn->offset);
+			if (ret)
+				goto m64_failed;
+		}
 	}
 
 	/* Setup VF PEs */
-- 
1.7.9.5
