Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8C4AF1A03A1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Oct 2015 13:48:20 +1100 (AEDT)
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7FE13140DA3
 for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2015 13:48:19 +1100 (AEDT)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Fri, 9 Oct 2015 08:18:17 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id D9C3F1258019
 for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2015 08:17:55 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t992mCoJ3211746
 for <linuxppc-dev@ozlabs.org>; Fri, 9 Oct 2015 08:18:13 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t992mC1M026347
 for <linuxppc-dev@ozlabs.org>; Fri, 9 Oct 2015 08:18:12 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, aik@ozlabs.ru, benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au,
 Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V5 5/6] powerpc/powernv: boundary the total VF BAR size
 instead of the individual one
Date: Fri,  9 Oct 2015 10:46:55 +0800
Message-Id: <1444358816-8163-6-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1444358816-8163-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1444358816-8163-1-git-send-email-weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Each VF could have 6 BARs at most. When the total BAR size exceeds the
gate, after expanding it will also exhaust the M64 Window.

This patch limits the boundary by checking the total VF BAR size instead of
the individual BAR.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Acked-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 71c5371..ba77fc0 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2701,7 +2701,7 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
 	const resource_size_t gate = phb->ioda.m64_segsize >> 2;
 	struct resource *res;
 	int i;
-	resource_size_t size;
+	resource_size_t size, total_vf_bar_sz;
 	struct pci_dn *pdn;
 	int mul, total_vfs;
 
@@ -2714,6 +2714,7 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
 
 	total_vfs = pci_sriov_get_totalvfs(pdev);
 	mul = phb->ioda.total_pe;
+	total_vf_bar_sz = 0;
 
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
 		res = &pdev->resource[i + PCI_IOV_RESOURCES];
@@ -2726,7 +2727,8 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
 			return;
 		}
 
-		size = pci_iov_resource_size(pdev, i + PCI_IOV_RESOURCES);
+		total_vf_bar_sz += pci_iov_resource_size(pdev,
+				i + PCI_IOV_RESOURCES);
 
 		/*
 		 * If bigger than quarter of M64 segment size, just round up
@@ -2740,11 +2742,11 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
 		 * limit the system flexibility.  This is a design decision to
 		 * set the boundary to quarter of the M64 segment size.
 		 */
-		if (size > gate) {
-			dev_info(&pdev->dev, "PowerNV: VF BAR%d: %pR IOV size "
-				"is bigger than %lld, roundup power2\n",
-				 i, res, gate);
+		if (total_vf_bar_sz > gate) {
 			mul = roundup_pow_of_two(total_vfs);
+			dev_info(&pdev->dev,
+				"VF BAR Total IOV size %llx > %llx, roundup to %d VFs\n",
+				total_vf_bar_sz, gate, mul);
 			pdn->m64_single_mode = true;
 			break;
 		}
-- 
2.5.0
