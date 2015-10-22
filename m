Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 553B61A0AFB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2015 12:23:46 +1100 (AEDT)
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9BB9F141319
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2015 12:23:45 +1100 (AEDT)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Thu, 22 Oct 2015 06:53:44 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 3CFB43940049
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2015 06:53:41 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9M1NeHa7077986
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2015 06:53:40 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9M1NepM002168
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2015 06:53:40 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, aik@ozlabs.ru, benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au,
 Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V7 6/6] powerpc/powernv: allocate sparse PE# when using M64
 BAR in Single PE mode
Date: Thu, 22 Oct 2015 09:22:19 +0800
Message-Id: <1445476939-2995-7-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1445476939-2995-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1445476939-2995-1-git-send-email-weiyang@linux.vnet.ibm.com>
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

This patch restructures the code to allocate sparse PE# for VFs when M64
BAR is set to Single PE mode. Also it rename the offset to pe_num_map to
reflect the content is the PE number.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Acked-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/pci-bridge.h     |  2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c | 81 +++++++++++++++++++++++--------
 2 files changed, 63 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 8aeba4c..b3a226b 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -213,7 +213,7 @@ struct pci_dn {
 #ifdef CONFIG_PCI_IOV
 	u16     vfs_expanded;		/* number of VFs IOV BAR expanded */
 	u16     num_vfs;		/* number of VFs enabled*/
-	int     offset;			/* PE# for the first VF PE */
+	int     *pe_num_map;		/* PE# for the first VF PE or array */
 	bool    m64_single_mode;	/* Use M64 BAR in Single Mode */
 #define IODA_INVALID_M64        (-1)
 	int     (*m64_map)[PCI_SRIOV_NUM_BARS];
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 1c11b1a..91be853 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1243,7 +1243,7 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev, u16 num_vfs)
 
 			/* Map the M64 here */
 			if (pdn->m64_single_mode) {
-				pe_num = pdn->offset + j;
+				pe_num = pdn->pe_num_map[j];
 				rc = opal_pci_map_pe_mmio_window(phb->opal_id,
 						pe_num, OPAL_M64_WINDOW_TYPE,
 						pdn->m64_map[j][i], 0);
@@ -1347,7 +1347,7 @@ void pnv_pci_sriov_disable(struct pci_dev *pdev)
 	struct pnv_phb        *phb;
 	struct pci_dn         *pdn;
 	struct pci_sriov      *iov;
-	u16 num_vfs;
+	u16                    num_vfs, i;
 
 	bus = pdev->bus;
 	hose = pci_bus_to_host(bus);
@@ -1361,14 +1361,21 @@ void pnv_pci_sriov_disable(struct pci_dev *pdev)
 
 	if (phb->type == PNV_PHB_IODA2) {
 		if (!pdn->m64_single_mode)
-			pnv_pci_vf_resource_shift(pdev, -pdn->offset);
+			pnv_pci_vf_resource_shift(pdev, -*pdn->pe_num_map);
 
 		/* Release M64 windows */
 		pnv_pci_vf_release_m64(pdev, num_vfs);
 
 		/* Release PE numbers */
-		bitmap_clear(phb->ioda.pe_alloc, pdn->offset, num_vfs);
-		pdn->offset = 0;
+		if (pdn->m64_single_mode) {
+			for (i = 0; i < num_vfs; i++) {
+				if (pdn->pe_num_map[i] != IODA_INVALID_PE)
+					pnv_ioda_free_pe(phb, pdn->pe_num_map[i]);
+			}
+		} else
+			bitmap_clear(phb->ioda.pe_alloc, *pdn->pe_num_map, num_vfs);
+		/* Releasing pe_num_map */
+		kfree(pdn->pe_num_map);
 	}
 }
 
@@ -1394,7 +1401,10 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
 
 	/* Reserve PE for each VF */
 	for (vf_index = 0; vf_index < num_vfs; vf_index++) {
-		pe_num = pdn->offset + vf_index;
+		if (pdn->m64_single_mode)
+			pe_num = pdn->pe_num_map[vf_index];
+		else
+			pe_num = *pdn->pe_num_map + vf_index;
 
 		pe = &phb->ioda.pe_array[pe_num];
 		pe->pe_number = pe_num;
@@ -1436,6 +1446,7 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
 	struct pnv_phb        *phb;
 	struct pci_dn         *pdn;
 	int                    ret;
+	u16                    i;
 
 	bus = pdev->bus;
 	hose = pci_bus_to_host(bus);
@@ -1458,20 +1469,44 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
 			return -EBUSY;
 		}
 
+		/* Allocating pe_num_map */
+		if (pdn->m64_single_mode)
+			pdn->pe_num_map = kmalloc(sizeof(*pdn->pe_num_map) * num_vfs,
+					GFP_KERNEL);
+		else
+			pdn->pe_num_map = kmalloc(sizeof(*pdn->pe_num_map), GFP_KERNEL);
+
+		if (!pdn->pe_num_map)
+			return -ENOMEM;
+
+		if (pdn->m64_single_mode)
+			for (i = 0; i < num_vfs; i++)
+				pdn->pe_num_map[i] = IODA_INVALID_PE;
+
 		/* Calculate available PE for required VFs */
-		mutex_lock(&phb->ioda.pe_alloc_mutex);
-		pdn->offset = bitmap_find_next_zero_area(
-			phb->ioda.pe_alloc, phb->ioda.total_pe,
-			0, num_vfs, 0);
-		if (pdn->offset >= phb->ioda.total_pe) {
+		if (pdn->m64_single_mode) {
+			for (i = 0; i < num_vfs; i++) {
+				pdn->pe_num_map[i] = pnv_ioda_alloc_pe(phb);
+				if (pdn->pe_num_map[i] == IODA_INVALID_PE) {
+					ret = -EBUSY;
+					goto m64_failed;
+				}
+			}
+		} else {
+			mutex_lock(&phb->ioda.pe_alloc_mutex);
+			*pdn->pe_num_map = bitmap_find_next_zero_area(
+				phb->ioda.pe_alloc, phb->ioda.total_pe,
+				0, num_vfs, 0);
+			if (*pdn->pe_num_map >= phb->ioda.total_pe) {
+				mutex_unlock(&phb->ioda.pe_alloc_mutex);
+				dev_info(&pdev->dev, "Failed to enable VF%d\n", num_vfs);
+				kfree(pdn->pe_num_map);
+				return -EBUSY;
+			}
+			bitmap_set(phb->ioda.pe_alloc, *pdn->pe_num_map, num_vfs);
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
@@ -1486,7 +1521,7 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
 		 * Otherwise, the PE# for the VF will conflict with others.
 		 */
 		if (!pdn->m64_single_mode) {
-			ret = pnv_pci_vf_resource_shift(pdev, pdn->offset);
+			ret = pnv_pci_vf_resource_shift(pdev, *pdn->pe_num_map);
 			if (ret)
 				goto m64_failed;
 		}
@@ -1498,8 +1533,16 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
 	return 0;
 
 m64_failed:
-	bitmap_clear(phb->ioda.pe_alloc, pdn->offset, num_vfs);
-	pdn->offset = 0;
+	if (pdn->m64_single_mode) {
+		for (i = 0; i < num_vfs; i++) {
+			if (pdn->pe_num_map[i] != IODA_INVALID_PE)
+				pnv_ioda_free_pe(phb, pdn->pe_num_map[i]);
+		}
+	} else
+		bitmap_clear(phb->ioda.pe_alloc, *pdn->pe_num_map, num_vfs);
+
+	/* Releasing pe_num_map */
+	kfree(pdn->pe_num_map);
 
 	return ret;
 }
-- 
2.5.0
