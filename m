Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8325B1A0BC2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2015 12:24:14 +1100 (AEDT)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 252DE141316
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2015 12:24:14 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Thu, 22 Oct 2015 11:24:13 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id ACB9C2CE8052
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2015 12:24:10 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9M1NngD27656304
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2015 12:23:57 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9M1NbER013729
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2015 12:23:38 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, aik@ozlabs.ru, benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au,
 Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V7 5/6] powerpc/powernv: boundary the total VF BAR size
 instead of the individual one
Date: Thu, 22 Oct 2015 09:22:18 +0800
Message-Id: <1445476939-2995-6-git-send-email-weiyang@linux.vnet.ibm.com>
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
index 0add35f..1c11b1a 100644
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
 			goto truncate_iov;
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
