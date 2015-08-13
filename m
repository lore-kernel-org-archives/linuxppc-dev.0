Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B4FDB1A1D88
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 00:12:27 +1000 (AEST)
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 20F621401B5
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 00:12:26 +1000 (AEST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Thu, 13 Aug 2015 19:42:25 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 8B57D3940061
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2015 19:42:22 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7DECLbK60358800
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2015 19:42:21 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7DEBHiA003946
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2015 19:41:18 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: aik@ozlabs.ru, gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org, Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH v3 1/6] powerpc/powernv: don't enable SRIOV when VF BAR has
 non 64bit-prefetchable BAR
Date: Thu, 13 Aug 2015 22:11:06 +0800
Message-Id: <1439475071-7001-2-git-send-email-weiyang@linux.vnet.ibm.com>
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

On PHB_IODA2, we enable SRIOV devices by mapping IOV BAR with M64 BARs. If
a SRIOV device's IOV BAR is not 64bit-prefetchable, this is not assigned
from 64bit prefetchable window, which means M64 BAR can't work on it.

This patch makes this explicit.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |   25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 5738d31..9ac324e 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -908,9 +908,6 @@ static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
 		if (!res->flags || !res->parent)
 			continue;
 
-		if (!pnv_pci_is_mem_pref_64(res->flags))
-			continue;
-
 		/*
 		 * The actual IOV BAR range is determined by the start address
 		 * and the actual size for num_vfs VFs BAR.  This check is to
@@ -939,9 +936,6 @@ static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
 		if (!res->flags || !res->parent)
 			continue;
 
-		if (!pnv_pci_is_mem_pref_64(res->flags))
-			continue;
-
 		size = pci_iov_resource_size(dev, i + PCI_IOV_RESOURCES);
 		res2 = *res;
 		res->start += size * offset;
@@ -1221,9 +1215,6 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev, u16 num_vfs)
 		if (!res->flags || !res->parent)
 			continue;
 
-		if (!pnv_pci_is_mem_pref_64(res->flags))
-			continue;
-
 		for (j = 0; j < vf_groups; j++) {
 			do {
 				win = find_next_zero_bit(&phb->ioda.m64_bar_alloc,
@@ -1510,6 +1501,12 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
 	pdn = pci_get_pdn(pdev);
 
 	if (phb->type == PNV_PHB_IODA2) {
+		if (!pdn->vfs_expanded) {
+			dev_info(&pdev->dev, "don't support this SRIOV device"
+				" with non 64bit-prefetchable IOV BAR\n");
+			return -ENOSPC;
+		}
+
 		/* Calculate available PE for required VFs */
 		mutex_lock(&phb->ioda.pe_alloc_mutex);
 		pdn->offset = bitmap_find_next_zero_area(
@@ -2774,9 +2771,10 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
 		if (!res->flags || res->parent)
 			continue;
 		if (!pnv_pci_is_mem_pref_64(res->flags)) {
-			dev_warn(&pdev->dev, " non M64 VF BAR%d: %pR\n",
+			dev_warn(&pdev->dev, "Don't support SR-IOV with"
+					" non M64 VF BAR%d: %pR. \n",
 				 i, res);
-			continue;
+			return;
 		}
 
 		size = pci_iov_resource_size(pdev, i + PCI_IOV_RESOURCES);
@@ -2795,11 +2793,6 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
 		res = &pdev->resource[i + PCI_IOV_RESOURCES];
 		if (!res->flags || res->parent)
 			continue;
-		if (!pnv_pci_is_mem_pref_64(res->flags)) {
-			dev_warn(&pdev->dev, "Skipping expanding VF BAR%d: %pR\n",
-				 i, res);
-			continue;
-		}
 
 		dev_dbg(&pdev->dev, " Fixing VF BAR%d: %pR to\n", i, res);
 		size = pci_iov_resource_size(pdev, i + PCI_IOV_RESOURCES);
-- 
1.7.9.5
