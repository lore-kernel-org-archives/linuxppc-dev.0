Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdSpp2h0KzDr1T
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 22:26:26 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rdSpn4hMkz9t1M
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Jun 2016 22:26:25 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, stable@vger.kernel.org
Subject: [PATCH 17/17] powerpc/pnv/pci: Fix incorrect PE reservation attempt
 on some 64-bit BARs
Date: Mon, 27 Jun 2016 22:25:33 +1000
Message-Id: <1467030333-31435-18-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467030333-31435-1-git-send-email-benh@kernel.crashing.org>
References: <1467030333-31435-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The generic allocation code may sometimes decide to assign a prefetchable
64-bit BAR to the M32 window. In fact it may also decide to allocate
a 64-bit non-prefetchable BAR to the M64 one ! So using the resource
flags as a test to decide which window was used for PE allocation is
just wrong and leads to insane PE numbers.

Instead, compare the addresses to figure it out.

CC: stable@vger.kernel.org
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 9d59eeb..4cbd706 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -110,10 +110,16 @@ static int __init iommu_setup(char *str)
 }
 early_param("iommu", iommu_setup);
 
-static inline bool pnv_pci_is_mem_pref_64(unsigned long flags)
+static inline bool pnv_pci_is_mem_pref_64(struct pnv_phb *phb, struct resource *r)
 {
-	return ((flags & (IORESOURCE_MEM_64 | IORESOURCE_PREFETCH)) ==
-		(IORESOURCE_MEM_64 | IORESOURCE_PREFETCH));
+	/* WARNING: We cannot rely on the resource flags. The Linux PCI
+	 * allocation code sometimes decides to put a 64-bit prefetchable
+	 * BAR in the 32-bit window, so we have to compare the addresses.
+	 *
+	 * For simplicity we only test resource start.
+	 */
+	return (r->start >= phb->ioda.m64_base &&
+		r->start < (phb->ioda.m64_base + phb->ioda.m64_size));
 }
 
 static struct pnv_ioda_pe *pnv_ioda_init_pe(struct pnv_phb *phb, int pe_no)
@@ -230,7 +236,7 @@ static void pnv_ioda_reserve_dev_m64_pe(struct pci_dev *pdev,
 	sgsz = phb->ioda.m64_segsize;
 	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
 		r = &pdev->resource[i];
-		if (!r->parent || !pnv_pci_is_mem_pref_64(r->flags))
+		if (!r->parent || !pnv_pci_is_mem_pref_64(phb, r))
 			continue;
 
 		start = _ALIGN_DOWN(r->start - base, sgsz);
@@ -3058,7 +3064,7 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
 		res = &pdev->resource[i + PCI_IOV_RESOURCES];
 		if (!res->flags || res->parent)
 			continue;
-		if (!pnv_pci_is_mem_pref_64(res->flags)) {
+		if (!pnv_pci_is_mem_pref_64(phb, res)) {
 			dev_warn(&pdev->dev, "Don't support SR-IOV with"
 					" non M64 VF BAR%d: %pR. \n",
 				 i, res);
@@ -3152,8 +3158,7 @@ static void pnv_ioda_setup_pe_res(struct pnv_ioda_pe *pe,
 			region.start += phb->ioda.io_segsize;
 			index++;
 		}
-	} else if ((res->flags & IORESOURCE_MEM) &&
-		   !pnv_pci_is_mem_pref_64(res->flags)) {
+	} else if ((res->flags & IORESOURCE_MEM) && !pnv_pci_is_mem_pref_64(phb, res)) {
 		region.start = res->start -
 			       phb->hose->mem_offset[0] -
 			       phb->ioda.m32_pci_base;
@@ -3312,9 +3317,11 @@ static resource_size_t pnv_pci_window_alignment(struct pci_bus *bus,
 		bridge = bridge->bus->self;
 	}
 
-	/* We fail back to M32 if M64 isn't supported */
-	if (phb->ioda.m64_segsize &&
-	    pnv_pci_is_mem_pref_64(type))
+	/* We fail back to M32 if M64 isn't supported. We enforce the M64
+	 * alignment for any 64-bit resource, PCIe doesn't care and
+	 * bridges only do 64-bit prefetchable anyway
+	 */
+	if (phb->ioda.m64_segsize && (type & IORESOURCE_MEM_64))
 		return phb->ioda.m64_segsize;
 	if (type & IORESOURCE_MEM)
 		return phb->ioda.m32_segsize;
-- 
2.7.4
