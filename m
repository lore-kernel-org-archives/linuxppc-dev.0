Return-Path: <bhelgaas@google.com>
Received: from mail-pd0-x233.google.com (mail-pd0-x233.google.com
 [IPv6:2607:f8b0:400e:c02::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EB8B21A1236
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 19:35:15 +1100 (AEDT)
Received: by pdbnh10 with SMTP id nh10so31800735pdb.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 00:35:14 -0800 (PST)
Subject: [PATCH v12 19/21] powerpc/powernv: Group VF PE when IOV BAR is big
 on PHB3
To: Wei Yang <weiyang@linux.vnet.ibm.com>, benh@au1.ibm.com,
 gwshan@linux.vnet.ibm.com
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 24 Feb 2015 02:35:12 -0600
Message-ID: <20150224083512.32124.68785.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150224082939.32124.45744.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150224082939.32124.45744.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wei Yang <weiyang@linux.vnet.ibm.com>

When IOV BAR is big, each is covered by 4 M64 windows.  This leads to
several VF PE sits in one PE in terms of M64.

Group VF PEs according to the M64 allocation.

[bhelgaas: use dev_printk() when possible]
Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/powerpc/include/asm/pci-bridge.h     |    2 
 arch/powerpc/platforms/powernv/pci-ioda.c |  197 +++++++++++++++++++++++------
 2 files changed, 154 insertions(+), 45 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index d824bb184ab8..958ea8675691 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -182,7 +182,7 @@ struct pci_dn {
 #define M64_PER_IOV 4
 	int     m64_per_iov;
 #define IODA_INVALID_M64        (-1)
-	int     m64_wins[PCI_SRIOV_NUM_BARS];
+	int     m64_wins[PCI_SRIOV_NUM_BARS][M64_PER_IOV];
 #endif /* CONFIG_PCI_IOV */
 #endif
 	struct list_head child_list;
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 30b7c3909746..b265d5da601b 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1152,26 +1152,27 @@ static int pnv_pci_vf_release_m64(struct pci_dev *pdev)
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
+static int pnv_pci_vf_assign_m64(struct pci_dev *pdev, u16 vf_num)
 {
 	struct pci_bus        *bus;
 	struct pci_controller *hose;
@@ -1179,17 +1180,33 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev)
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
+		vf_groups = (vf_num <= M64_PER_IOV) ? vf_num: M64_PER_IOV;
+		vf_per_group = (vf_num <= M64_PER_IOV)? 1:
+			__roundup_pow_of_two(vf_num) / pdn->m64_per_iov;
+	} else {
+		vf_groups = 1;
+		vf_per_group = 1;
+	}
 
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
 		res = &pdev->resource[i + PCI_IOV_RESOURCES];
@@ -1199,35 +1216,61 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev)
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
@@ -1269,22 +1312,53 @@ static void pnv_pci_ioda2_release_dma_pe(struct pci_dev *dev, struct pnv_ioda_pe
 	pe->tce32_table = NULL;
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
 
-	pdn = pci_get_pdn(pdev);
+	if (pdn->m64_per_iov == M64_PER_IOV && vf_num > M64_PER_IOV) {
+		int   vf_group;
+		int   vf_per_group;
+		int   vf_index1;
+
+		vf_per_group = __roundup_pow_of_two(vf_num) / pdn->m64_per_iov;
+
+		for (vf_group = 0; vf_group < M64_PER_IOV; vf_group++)
+			for (vf_index = vf_group * vf_per_group;
+				vf_index < (vf_group + 1) * vf_per_group &&
+				vf_index < vf_num;
+				vf_index++)
+				for (vf_index1 = vf_group * vf_per_group;
+					vf_index1 < (vf_group + 1) * vf_per_group &&
+					vf_index1 < vf_num;
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
@@ -1319,10 +1393,11 @@ void pnv_pci_sriov_disable(struct pci_dev *pdev)
 	vf_num = pdn->vf_pes;
 
 	/* Release VF PEs */
-	pnv_ioda_release_vf_PE(pdev);
+	pnv_ioda_release_vf_PE(pdev, vf_num);
 
 	if (phb->type == PNV_PHB_IODA2) {
-		pnv_pci_vf_resource_shift(pdev, -pdn->offset);
+		if (pdn->m64_per_iov == 1)
+			pnv_pci_vf_resource_shift(pdev, -pdn->offset);
 
 		/* Release M64 windows */
 		pnv_pci_vf_release_m64(pdev);
@@ -1344,6 +1419,7 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 vf_num)
 	int                    pe_num;
 	u16                    vf_index;
 	struct pci_dn         *pdn;
+	int64_t                rc;
 
 	bus = pdev->bus;
 	hose = pci_bus_to_host(bus);
@@ -1392,6 +1468,37 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 vf_num)
 
 		pnv_pci_ioda2_setup_dma_pe(phb, pe);
 	}
+
+	if (pdn->m64_per_iov == M64_PER_IOV && vf_num > M64_PER_IOV) {
+		int   vf_group;
+		int   vf_per_group;
+		int   vf_index1;
+
+		vf_per_group = __roundup_pow_of_two(vf_num) / pdn->m64_per_iov;
+
+		for (vf_group = 0; vf_group < M64_PER_IOV; vf_group++) {
+			for (vf_index = vf_group * vf_per_group;
+			     vf_index < (vf_group + 1) * vf_per_group &&
+			     vf_index < vf_num;
+			     vf_index++) {
+				for (vf_index1 = vf_group * vf_per_group;
+				     vf_index1 < (vf_group + 1) * vf_per_group &&
+				     vf_index1 < vf_num;
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
 
 int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 vf_num)
@@ -1424,16 +1531,18 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 vf_num)
 		mutex_unlock(&phb->ioda.pe_alloc_mutex);
 
 		/* Assign M64 window accordingly */
-		ret = pnv_pci_vf_assign_m64(pdev);
+		ret = pnv_pci_vf_assign_m64(pdev, vf_num);
 		if (ret) {
 			dev_info(&pdev->dev, "Not enough M64 window resources\n");
 			goto m64_failed;
 		}
 
 		/* Do some magic shift */
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
