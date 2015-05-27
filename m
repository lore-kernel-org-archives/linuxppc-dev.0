Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8AFA81A0D68
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 16:07:35 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org
Cc: imunsie@au.ibm.com, linuxppc-dev@ozlabs.org, mikey@neuling.org,
 Daniel Axtens <dja@axtens.net>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, brking@linux.vnet.ibm.com
Subject: [PATCH v3 05/24] powerpc/pci: Add shutdown hook to pci_controller_ops
Date: Wed, 27 May 2015 16:06:59 +1000
Message-Id: <1432706838-20794-6-git-send-email-mikey@neuling.org>
In-Reply-To: <1432706838-20794-1-git-send-email-mikey@neuling.org>
References: <1432706838-20794-1-git-send-email-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently pnv_pci_shutdown() calls the PHB shutdown code for all PHBs in the
system.  It dereferences the private_data assuming it's a powernv PHB, which
won't be the case when we have different PHB in the systems (like when we add
vPHBs for CXL).

This moves the shutdown hook to the pci_controller_ops and fixes the call site
to use that instead.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/pci-bridge.h     | 2 ++
 arch/powerpc/platforms/powernv/pci-ioda.c | 8 ++++----
 arch/powerpc/platforms/powernv/pci.c      | 9 +++------
 arch/powerpc/platforms/powernv/pci.h      | 1 -
 4 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 4cf0caa..3947749 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -40,6 +40,8 @@ struct pci_controller_ops {
 #endif
 
 	int             (*dma_set_mask)(struct pci_dev *dev, u64 dma_mask);
+
+	void		(*shutdown)(struct pci_controller *);
 };
 
 /*
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index bb3c0c4..2eaf6f7 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2645,8 +2645,10 @@ static u32 pnv_ioda_bdfn_to_pe(struct pnv_phb *phb, struct pci_bus *bus,
 	return phb->ioda.pe_rmap[(bus->number << 8) | devfn];
 }
 
-static void pnv_pci_ioda_shutdown(struct pnv_phb *phb)
+static void pnv_pci_ioda_shutdown(struct pci_controller *hose)
 {
+	struct pnv_phb *phb = hose->private_data;
+
 	opal_pci_reset(phb->opal_id, OPAL_RESET_PCI_IODA_TABLE,
 		       OPAL_ASSERT_RESET);
 }
@@ -2796,9 +2798,6 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	phb->dma_dev_setup = pnv_pci_ioda_dma_dev_setup;
 	phb->dma_get_required_mask = pnv_pci_ioda_dma_get_required_mask;
 
-	/* Setup shutdown function for kexec */
-	phb->shutdown = pnv_pci_ioda_shutdown;
-
 	/* Setup MSI support */
 	pnv_pci_init_ioda_msis(phb);
 
@@ -2879,4 +2878,5 @@ static const struct pci_controller_ops pnv_pci_ioda_controller_ops = {
        .window_alignment = pnv_pci_window_alignment,
        .reset_secondary_bus = pnv_pci_reset_secondary_bus,
        .dma_set_mask = pnv_pci_ioda_dma_set_mask,
+       .shutdown = pnv_pci_ioda_shutdown,
 };
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index acc0ced..1614d79 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -704,12 +704,9 @@ void pnv_pci_shutdown(void)
 {
 	struct pci_controller *hose;
 
-	list_for_each_entry(hose, &hose_list, list_node) {
-		struct pnv_phb *phb = hose->private_data;
-
-		if (phb && phb->shutdown)
-			phb->shutdown(phb);
-	}
+	list_for_each_entry(hose, &hose_list, list_node)
+		if (hose->controller_ops.shutdown)
+			hose->controller_ops.shutdown(hose);
 }
 
 /* Fixup wrong class code in p7ioc and p8 root complex */
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 60bb935..7edb54f5 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -110,7 +110,6 @@ struct pnv_phb {
 				     struct pci_dev *pdev);
 	void (*fixup_phb)(struct pci_controller *hose);
 	u32 (*bdfn_to_pe)(struct pnv_phb *phb, struct pci_bus *bus, u32 devfn);
-	void (*shutdown)(struct pnv_phb *phb);
 	int (*init_m64)(struct pnv_phb *phb);
 	void (*reserve_m64_pe)(struct pnv_phb *phb);
 	int (*pick_m64_pe)(struct pnv_phb *phb, struct pci_bus *bus, int all);
-- 
2.1.0
