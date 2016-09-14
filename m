Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYsKj3x0BzDsW3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 16:37:29 +1000 (AEST)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, aik@ozlabs.ru, Russell Currey <ruscur@russell.cc>
Subject: [PATCH] powernv/pci: Fix m64 checks for SR-IOV and window alignment
Date: Wed, 14 Sep 2016 16:37:17 +1000
Message-Id: <20160914063717.2673-1-ruscur@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 5958d19a143e checks for prefetchable m64 BARs by comparing the
addresses instead of using resource flags.  This broke SR-IOV as the m64
check in pnv_pci_ioda_fixup_iov_resources() fails.

The condition in pnv_pci_window_alignment() also changed to checking
only IORESOURCE_MEM_64 instead of both IORESOURCE_MEM_64 and
IORESOURCE_PREFETCH.

Revert these cases to the previous behaviour, adding a new helper function
to do so.  This is named pnv_pci_is_m64_flags() to make it clear this
function is only looking at resource flags and should not be relied on for
non-SRIOV resources.

Fixes: 5958d19a143e ("Fix incorrect PE reservation attempt on some 64-bit BARs")
Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index c16d790..2f25622 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -124,6 +124,13 @@ static inline bool pnv_pci_is_m64(struct pnv_phb *phb, struct resource *r)
 		r->start < (phb->ioda.m64_base + phb->ioda.m64_size));
 }
 
+static inline bool pnv_pci_is_m64_flags(unsigned long resource_flags)
+{
+	unsigned long flags = (IORESOURCE_MEM_64 | IORESOURCE_PREFETCH);
+
+	return (resource_flags & flags) == flags;
+}
+
 static struct pnv_ioda_pe *pnv_ioda_init_pe(struct pnv_phb *phb, int pe_no)
 {
 	phb->ioda.pe_array[pe_no].phb = phb;
@@ -2871,7 +2878,7 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
 		res = &pdev->resource[i + PCI_IOV_RESOURCES];
 		if (!res->flags || res->parent)
 			continue;
-		if (!pnv_pci_is_m64(phb, res)) {
+		if (!pnv_pci_is_m64_flags(res->flags)) {
 			dev_warn(&pdev->dev, "Don't support SR-IOV with"
 					" non M64 VF BAR%d: %pR. \n",
 				 i, res);
@@ -3096,7 +3103,7 @@ static resource_size_t pnv_pci_window_alignment(struct pci_bus *bus,
 	 * alignment for any 64-bit resource, PCIe doesn't care and
 	 * bridges only do 64-bit prefetchable anyway.
 	 */
-	if (phb->ioda.m64_segsize && (type & IORESOURCE_MEM_64))
+	if (phb->ioda.m64_segsize && pnv_pci_is_m64_flags(type))
 		return phb->ioda.m64_segsize;
 	if (type & IORESOURCE_MEM)
 		return phb->ioda.m32_segsize;
-- 
2.9.3
