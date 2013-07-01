Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CF46C2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jul 2013 17:54:18 +1000 (EST)
Message-ID: <1372665249.18612.146.camel@pasglop>
Subject: [PATCH] powerpc/powernv: Fix iommu initialization again
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 01 Jul 2013 17:54:09 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>, Guenter Roeck <linux@roeck-us.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

So because those things always end up in trainwrecks... In 7846de406
we moved back the iommu initialization earlier, essentially undoing
37f02195b which was causing us endless trouble... except that in the
meantime we had merged 959c9bdd58 (to workaround the original breakage)
which is now ... broken :-)

This fixes it by doing a partial revert of the latter (we keep the
ppc_md. path which will be needed in the hotplug case, which happens
also during some EEH error recovery situations).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Yes, that means that we broke 3.10 on powernv at the last minute in
order to fix eeh on pseries. This is not a huge deal at this point
because nobody outside of IBM cares about powernv yet (with a few
exceptions), and we'll fix it in 3.10.1

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 9c9d15e..8e6b278 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -441,6 +441,17 @@ static void pnv_pci_ioda_dma_dev_setup(struct pnv_phb *phb, struct pci_dev *pdev
 	set_iommu_table_base(&pdev->dev, &pe->tce32_table);
 }
 
+static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe, struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+ 	list_for_each_entry(dev, &bus->devices, bus_list) {
+		set_iommu_table_base(&dev->dev, &pe->tce32_table);
+		if (dev->subordinate)
+			pnv_ioda_setup_bus_dma(pe, dev->subordinate);
+	}
+}
+
 static void pnv_pci_ioda1_tce_invalidate(struct iommu_table *tbl,
 					 u64 *startp, u64 *endp)
 {
@@ -596,6 +607,11 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 	}
 	iommu_init_table(tbl, phb->hose->node);
 
+	if (pe->pdev)
+		set_iommu_table_base(&pe->pdev->dev, tbl);
+	else
+		pnv_ioda_setup_bus_dma(pe, pe->pbus);
+
 	return;
  fail:
 	/* XXX Failure: Try to fallback to 64-bit only ? */
@@ -667,6 +683,11 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 	}
 	iommu_init_table(tbl, phb->hose->node);
 
+	if (pe->pdev)
+		set_iommu_table_base(&pe->pdev->dev, tbl);
+	else
+		pnv_ioda_setup_bus_dma(pe, pe->pbus);
+
 	return;
 fail:
 	if (pe->tce32_seg >= 0)
