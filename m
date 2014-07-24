Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DBD5D1A078F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 16:23:03 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Thu, 24 Jul 2014 16:23:03 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id A2E612BB0023
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 16:23:00 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6O6Mi708716766
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 16:22:44 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6O6MxGG001354
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 16:23:00 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com,
 yan@linux.vnet.ibm.com, qiudayu@linux.vnet.ibm.com
Subject: [PATCH V7 17/17] powerpc/powernv: Group VF PE when IOV BAR is big on
 PHB3
Date: Thu, 24 Jul 2014 14:22:27 +0800
Message-Id: <1406182947-11302-18-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1406182947-11302-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1406182947-11302-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
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
 arch/powerpc/platforms/powernv/pci-ioda.c |  187 +++++++++++++++++++++++------
 2 files changed, 149 insertions(+), 40 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 9c2c826..41e52e3 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -180,7 +180,7 @@ struct pci_dn {
 #define M64_PER_IOV 4
 	int     m64_per_iov;
 #define IODA_INVALID_M64        (-1)
-	int     m64_wins[PCI_SRIOV_NUM_BARS];
+	int     m64_wins[PCI_SRIOV_NUM_BARS][M64_PER_IOV];
 #endif /* CONFIG_PCI_IOV */
 #endif
 	struct list_head child_list;
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 98fa01d..88aa14f 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -997,26 +997,27 @@ static int pnv_pci_vf_release_m64(struct pci_dev *pdev)
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
@@ -1024,17 +1025,33 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev)
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
 		res = pdev->resource + PCI_IOV_RESOURCES + i;
@@ -1044,33 +1061,61 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev)
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
+				size = pnv_pci_sriov_resource_size(pdev,
+								   PCI_IOV_RESOURCES + i);
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
@@ -1111,21 +1156,53 @@ static void pnv_pci_ioda2_release_dma_pe(struct pci_dev *dev, struct pnv_ioda_pe
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
+					    pr_warn("%s: Failed to unlink same"
+						" group PE#%d(%lld)\n", __func__,
+						pdn->offset + vf_index1, rc);
+				}
+	}
+
 	pdn = pci_get_pdn(pdev);
 	list_for_each_entry_safe(pe, pe_n, &phb->ioda.pe_list, list) {
 		if (pe->parent_dev != pdev)
@@ -1161,10 +1238,11 @@ void pnv_pci_sriov_disable(struct pci_dev *pdev)
 	vf_num = pdn->vf_pes;
 
 	/* Release VF PEs */
-	pnv_ioda_release_vf_PE(pdev);
+	pnv_ioda_release_vf_PE(pdev, vf_num);
 
 	if (phb->type == PNV_PHB_IODA2) {
-		pnv_pci_vf_resource_shift(pdev, -pdn->offset);
+		if (pdn->m64_per_iov == 1)
+			pnv_pci_vf_resource_shift(pdev, -pdn->offset);
 
 		/* Release M64 BARs */
 		pnv_pci_vf_release_m64(pdev);
@@ -1188,6 +1266,7 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 vf_num)
 	int                    pe_num;
 	u16                    vf_index;
 	struct pci_dn         *pdn;
+	int64_t                rc;
 
 	bus = pdev->bus;
 	hose = pci_bus_to_host(bus);
@@ -1235,7 +1314,36 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 vf_num)
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
+				vf_index < (vf_group + 1) * vf_per_group &&
+				vf_index < vf_num;
+				vf_index++)
+				for (vf_index1 = vf_group * vf_per_group;
+					vf_index1 < (vf_group + 1) * vf_per_group &&
+					vf_index1 < vf_num;
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
 
@@ -1274,14 +1382,15 @@ try_again:
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
