Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F33281A075D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 10:15:45 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 17 Jul 2015 10:15:45 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 834332BB004D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 10:15:42 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6H0FZmV41615580
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 10:15:43 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6H0F94J008419
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 10:15:09 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, aik@ozlabs.ru,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 2/2] powerpc/powernv: Double VF BAR size for compound PE
Date: Fri, 17 Jul 2015 10:14:43 +1000
Message-Id: <1437092083-20672-3-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1437092083-20672-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1437092083-20672-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When VF BAR size is equal to 128MB or bigger than that, we extend
the corresponding PF's IOV BAR to cover number of total VFs supported
by the PF. Otherwise, we extend the PF's IOV BAR to cover 256 VFs.
For the former case, we have to create compound PE, which includes
4 VFs. Those 4 VFs included in the compound PE can't be passed through
to different guests, which isn't good.

The gate (128MB) was choosen based on the assumption that each PHB
supports 64GB M64 space and one PF's IOV BAR can be extended to be
as huge as 1/4 of that, which is 16GB. However, the IOV BAR can be
extended to half of PHB's M64 window when the PF seats behind the
root port. In that case, the gate can be enlarged to be 256MB to
avoid compound PE as we can.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 6ec62b9..5b2e88f 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2721,6 +2721,7 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
 	struct resource *res;
 	int i;
 	resource_size_t size;
+	resource_size_t limit;
 	struct pci_dn *pdn;
 	int mul, total_vfs;
 
@@ -2730,6 +2731,18 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
 	hose = pci_bus_to_host(pdev->bus);
 	phb = hose->private_data;
 
+	/*
+	 * When the PF seats behind root port, the IOV BAR can
+	 * consume half of the PHB's M64 window. Otherwise,
+	 * 1/4 of the PHB's M64 window can be consumed to the
+	 * maximal degree.
+	 */
+	if (!pci_is_root_bus(pdev->bus) &&
+	    pci_is_root_bus(pdev->bus->self->bus))
+		limit = 128;
+	else
+		limit = 256;
+
 	pdn = pci_get_pdn(pdev);
 	pdn->vfs_expanded = 0;
 
@@ -2748,11 +2761,9 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
 		}
 
 		size = pci_iov_resource_size(pdev, i + PCI_IOV_RESOURCES);
-
-		/* bigger than 64M */
-		if (size > (1 << 26)) {
-			dev_info(&pdev->dev, "PowerNV: VF BAR%d: %pR IOV size is bigger than 64M, roundup power2\n",
-				 i, res);
+		if (size >= (limit * 0x100000)) {
+			dev_info(&pdev->dev, "PowerNV: VF BAR%d: %pR IOV size is bigger than %lldMB, roundup power2\n",
+				 i, res, limit);
 			pdn->m64_per_iov = M64_PER_IOV;
 			mul = roundup_pow_of_two(total_vfs);
 			break;
-- 
2.1.0
