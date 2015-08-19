Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BBF651A19F1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2015 12:02:50 +1000 (AEST)
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 51A2D140562
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2015 12:02:49 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Wed, 19 Aug 2015 12:02:48 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 474AF2CE8055
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2015 12:02:45 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7J22ZB241680912
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2015 12:02:43 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7J22C7t021459
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2015 12:02:12 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: aik@ozlabs.ru, gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org, Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V4 5/6] powerpc/powernv: boundary the total VF BAR size
 instead of the individual one
Date: Wed, 19 Aug 2015 10:01:43 +0800
Message-Id: <1439949704-8023-6-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1439949704-8023-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1439949704-8023-1-git-send-email-weiyang@linux.vnet.ibm.com>
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
---
 arch/powerpc/platforms/powernv/pci-ioda.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index b8bc51f..4bc83b8 100644
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
1.7.9.5
