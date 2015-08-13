Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C3E691A2AAA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 00:14:00 +1000 (AEST)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9C1A51401B5
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 00:14:00 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Fri, 14 Aug 2015 00:13:59 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E82393578055
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 00:13:57 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7DEDmDh327996
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 00:13:56 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7DEDPVU024495
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 00:13:25 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: aik@ozlabs.ru, gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org, Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH v3 6/6] powerpc/powernv: allocate sparse PE# when using M64
 BAR in Single PE mode
Date: Thu, 13 Aug 2015 22:11:11 +0800
Message-Id: <1439475071-7001-7-git-send-email-weiyang@linux.vnet.ibm.com>
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

When M64 BAR is set to Single PE mode, the PE# assigned to VF could be
sparse.

This patch restructures the patch to allocate sparse PE# for VFs when M64
BAR is set to Single PE mode.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pci-bridge.h     |    2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c |   59 +++++++++++++++++++----------
 2 files changed, 41 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 9d33ada..b026ef8 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -214,7 +214,7 @@ struct pci_dn {
 #ifdef CONFIG_PCI_IOV
 	u16     vfs_expanded;		/* number of VFs IOV BAR expanded */
 	u16     num_vfs;		/* number of VFs enabled*/
-	int     offset;			/* PE# for the first VF PE */
+	int     pe_num_map[MAX_M64_BAR];/* PE# for the first VF PE or array */
 	bool    m64_single_mode;	/* Use M64 BAR in Single Mode */
 #define IODA_INVALID_M64        (-1)
 	int      m64_map[PCI_SRIOV_NUM_BARS][MAX_M64_BAR];
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 1e6ac86..7633538 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1232,7 +1232,7 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev, u16 num_vfs)
 
 			/* Map the M64 here */
 			if (pdn->m64_single_mode) {
-				pe_num = pdn->offset + j;
+				pe_num = pdn->pe_num_map[j];
 				rc = opal_pci_map_pe_mmio_window(phb->opal_id,
 						pe_num, OPAL_M64_WINDOW_TYPE,
 						pdn->m64_map[i][j], 0);
@@ -1336,7 +1336,7 @@ void pnv_pci_sriov_disable(struct pci_dev *pdev)
 	struct pnv_phb        *phb;
 	struct pci_dn         *pdn;
 	struct pci_sriov      *iov;
-	u16 num_vfs;
+	u16 num_vfs, i;
 
 	bus = pdev->bus;
 	hose = pci_bus_to_host(bus);
@@ -1350,14 +1350,17 @@ void pnv_pci_sriov_disable(struct pci_dev *pdev)
 
 	if (phb->type == PNV_PHB_IODA2) {
 		if (!pdn->m64_single_mode)
-			pnv_pci_vf_resource_shift(pdev, -pdn->offset);
+			pnv_pci_vf_resource_shift(pdev, -pdn->pe_num_map[0]);
 
 		/* Release M64 windows */
 		pnv_pci_vf_release_m64(pdev);
 
 		/* Release PE numbers */
-		bitmap_clear(phb->ioda.pe_alloc, pdn->offset, num_vfs);
-		pdn->offset = 0;
+		if (pdn->m64_single_mode) {
+			for (i = 0; i < num_vfs; i++)
+				pnv_ioda_free_pe(phb, pdn->pe_num_map[i]);
+		} else
+			bitmap_clear(phb->ioda.pe_alloc, pdn->pe_num_map[0], num_vfs);
 	}
 }
 
@@ -1383,7 +1386,10 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
 
 	/* Reserve PE for each VF */
 	for (vf_index = 0; vf_index < num_vfs; vf_index++) {
-		pe_num = pdn->offset + vf_index;
+		if (pdn->m64_single_mode)
+			pe_num = pdn->pe_num_map[vf_index];
+		else
+			pe_num = pdn->pe_num_map[0] + vf_index;
 
 		pe = &phb->ioda.pe_array[pe_num];
 		pe->pe_number = pe_num;
@@ -1425,6 +1431,7 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
 	struct pnv_phb        *phb;
 	struct pci_dn         *pdn;
 	int                    ret;
+	u16                    i;
 
 	bus = pdev->bus;
 	hose = pci_bus_to_host(bus);
@@ -1448,19 +1455,30 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
 		}
 
 		/* Calculate available PE for required VFs */
-		mutex_lock(&phb->ioda.pe_alloc_mutex);
-		pdn->offset = bitmap_find_next_zero_area(
-			phb->ioda.pe_alloc, phb->ioda.total_pe,
-			0, num_vfs, 0);
-		if (pdn->offset >= phb->ioda.total_pe) {
+		if (pdn->m64_single_mode) {
+			for (i = 0; i < num_vfs; i++)
+				pdn->pe_num_map[i] = IODA_INVALID_PE;
+			for (i = 0; i < num_vfs; i++) {
+				pdn->pe_num_map[i] = pnv_ioda_alloc_pe(phb);
+				if (pdn->pe_num_map[i] == IODA_INVALID_PE) {
+					ret = -EBUSY;
+					goto m64_failed;
+				}
+			}
+		} else {
+			mutex_lock(&phb->ioda.pe_alloc_mutex);
+			pdn->pe_num_map[0] = bitmap_find_next_zero_area(
+				phb->ioda.pe_alloc, phb->ioda.total_pe,
+				0, num_vfs, 0);
+			if (pdn->pe_num_map[0] >= phb->ioda.total_pe) {
+				mutex_unlock(&phb->ioda.pe_alloc_mutex);
+				dev_info(&pdev->dev, "Failed to enable VF%d\n", num_vfs);
+				return -EBUSY;
+			}
+			bitmap_set(phb->ioda.pe_alloc, pdn->pe_num_map[0], num_vfs);
 			mutex_unlock(&phb->ioda.pe_alloc_mutex);
-			dev_info(&pdev->dev, "Failed to enable VF%d\n", num_vfs);
-			pdn->offset = 0;
-			return -EBUSY;
 		}
-		bitmap_set(phb->ioda.pe_alloc, pdn->offset, num_vfs);
 		pdn->num_vfs = num_vfs;
-		mutex_unlock(&phb->ioda.pe_alloc_mutex);
 
 		/* Assign M64 window accordingly */
 		ret = pnv_pci_vf_assign_m64(pdev, num_vfs);
@@ -1475,7 +1493,7 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
 		 * Otherwise, the PE# for the VF will conflict with others.
 		 */
 		if (!pdn->m64_single_mode) {
-			ret = pnv_pci_vf_resource_shift(pdev, pdn->offset);
+			ret = pnv_pci_vf_resource_shift(pdev, pdn->pe_num_map[0]);
 			if (ret)
 				goto m64_failed;
 		}
@@ -1487,8 +1505,11 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
 	return 0;
 
 m64_failed:
-	bitmap_clear(phb->ioda.pe_alloc, pdn->offset, num_vfs);
-	pdn->offset = 0;
+	if (pdn->m64_single_mode) {
+		for (i = 0; i < num_vfs; i++)
+			pnv_ioda_free_pe(phb, pdn->pe_num_map[i]);
+	} else
+		bitmap_clear(phb->ioda.pe_alloc, pdn->pe_num_map[0], num_vfs);
 
 	return ret;
 }
-- 
1.7.9.5
