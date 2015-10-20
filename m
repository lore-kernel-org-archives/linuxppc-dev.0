Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E300F1A0BC6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2015 20:05:21 +1100 (AEDT)
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 09A431401F0
 for <linuxppc-dev@ozlabs.org>; Tue, 20 Oct 2015 20:05:20 +1100 (AEDT)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Tue, 20 Oct 2015 14:35:18 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 77CE9E005B
 for <linuxppc-dev@ozlabs.org>; Tue, 20 Oct 2015 14:35:19 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9K94W2U6815828
 for <linuxppc-dev@ozlabs.org>; Tue, 20 Oct 2015 14:34:32 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9K94W9l004314
 for <linuxppc-dev@ozlabs.org>; Tue, 20 Oct 2015 14:34:32 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, aik@ozlabs.ru, benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au,
 Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V6 4/6] powerpc/powernv: replace the hard coded boundary with
 gate
Date: Tue, 20 Oct 2015 17:03:03 +0800
Message-Id: <1445331785-4645-5-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1445331785-4645-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1445331785-4645-1-git-send-email-weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At the moment 64bit-prefetchable window can be maximum 64GB, which is
currently got from device tree. This means that in shared mode the maximum
supported VF BAR size is 64GB/256=256MB. While this size could exhaust the
whole 64bit-prefetchable window. This is a design decision to set a
boundary to 64MB of the VF BAR size. Since VF BAR size with 64MB would
occupy a quarter of the 64bit-prefetchable window, this is affordable.

This patch replaces magic limit of 64MB with "gate", which is 1/4 of the
M64 Segment Size(m64_segsize >> 2) and adds comment to explain the reason
for it.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Reviewed-by: Gavin Shan <gwshan@linux.vent.ibm.com>
Acked-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index dc64026..de5a194 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2696,8 +2696,9 @@ static void pnv_pci_init_ioda_msis(struct pnv_phb *phb) { }
 #ifdef CONFIG_PCI_IOV
 static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
 {
-	struct pci_controller *hose;
-	struct pnv_phb *phb;
+	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
+	struct pnv_phb *phb = hose->private_data;
+	const resource_size_t gate = phb->ioda.m64_segsize >> 2;
 	struct resource *res;
 	int i;
 	resource_size_t size;
@@ -2707,9 +2708,6 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
 	if (!pdev->is_physfn || pdev->is_added)
 		return;
 
-	hose = pci_bus_to_host(pdev->bus);
-	phb = hose->private_data;
-
 	pdn = pci_get_pdn(pdev);
 	pdn->vfs_expanded = 0;
 	pdn->m64_single_mode = false;
@@ -2730,10 +2728,22 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
 
 		size = pci_iov_resource_size(pdev, i + PCI_IOV_RESOURCES);
 
-		/* bigger than 64M */
-		if (size > (1 << 26)) {
-			dev_info(&pdev->dev, "PowerNV: VF BAR%d: %pR IOV size is bigger than 64M, roundup power2\n",
-				 i, res);
+		/*
+		 * If bigger than quarter of M64 segment size, just round up
+		 * power of two.
+		 *
+		 * Generally, one M64 BAR maps one IOV BAR. To avoid conflict
+		 * with other devices, IOV BAR size is expanded to be
+		 * (total_pe * VF_BAR_size).  When VF_BAR_size is half of M64
+		 * segment size , the expanded size would equal to half of the
+		 * whole M64 space size, which will exhaust the M64 Space and
+		 * limit the system flexibility.  This is a design decision to
+		 * set the boundary to quarter of the M64 segment size.
+		 */
+		if (size > gate) {
+			dev_info(&pdev->dev, "PowerNV: VF BAR%d: %pR IOV size "
+				"is bigger than %lld, roundup power2\n",
+				 i, res, gate);
 			mul = roundup_pow_of_two(total_vfs);
 			pdn->m64_single_mode = true;
 			break;
-- 
2.5.0
