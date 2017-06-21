Return-Path: <ruscur@russell.cc>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsx8Q62SNzDqhq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 17:25:58 +1000 (AEST)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Cc: alistair@popple.id.au, benh@kernel.crashing.org,
 Russell Currey <ruscur@russell.cc>
Subject: [PATCH 1/2] powerpc/powernv/pci: Add helper to check if a PE has a
 single vendor
Date: Wed, 21 Jun 2017 17:18:03 +1000
Message-Id: <20170621071804.11660-1-ruscur@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a helper that determines if all the devices contained in a given PE
are all from the same vendor or not.  This can be useful in determining
if it's okay to make PE-wide changes that may be suitable for some
devices but not for others.

This is used later in the series.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 283caf1070c9..13835ac30795 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1718,6 +1718,31 @@ static void pnv_pci_ioda_dma_dev_setup(struct pnv_phb *phb, struct pci_dev *pdev
 	 */
 }
 
+static bool pnv_pci_ioda_pe_single_vendor(struct pnv_ioda_pe *pe)
+{
+	unsigned short vendor = 0;
+	struct pci_dev *pdev;
+
+	if (pe->device_count == 1)
+		return true;
+
+	/* pe->pdev should be set if it's a single device, pe->pbus if not */
+	if (!pe->pbus)
+		return true;
+
+	list_for_each_entry(pdev, &pe->pbus->devices, bus_list) {
+		if (!vendor) {
+			vendor = pdev->vendor;
+			continue;
+		}
+
+		if (pdev->vendor != vendor)
+			return false;
+	}
+
+	return true;
+}
+
 static int pnv_pci_ioda_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
 {
 	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
-- 
2.13.1
