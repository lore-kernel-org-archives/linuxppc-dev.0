Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C23C1A0220
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 15:51:37 +1100 (AEDT)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 9 Feb 2016 14:51:35 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 27B732CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 15:51:32 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u194pMhv43253798
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Feb 2016 15:51:30 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u194ox3C030593
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Feb 2016 15:50:59 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v2 2/4] powerpc/powernv: Fix stale PE primary bus
Date: Tue,  9 Feb 2016 15:50:22 +1100
Message-Id: <1454993431-17068-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1454993431-17068-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1454993431-17068-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When PCI bus is unplugged during full hotplug for EEH recovery,
the platform PE instance (struct pnv_ioda_pe) isn't released and
it dereferences the stale PCI bus that has been released. It leads
to kernel crash when referring to the stale PCI bus.

This fixes the issue by correcting the PE's primary bus when it's
oneline at plugging time, in pnv_pci_dma_bus_setup() which is to
be called by pcibios_fixup_bus().

Reported-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Reported-by: Pradipta Ghosh <pradghos@in.ibm.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Tested-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |  1 +
 arch/powerpc/platforms/powernv/pci.c      | 20 ++++++++++++++++++++
 arch/powerpc/platforms/powernv/pci.h      |  1 +
 3 files changed, 22 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 573ae19..f90dc04 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3180,6 +3180,7 @@ static void pnv_pci_ioda_shutdown(struct pci_controller *hose)
 
 static const struct pci_controller_ops pnv_pci_ioda_controller_ops = {
        .dma_dev_setup = pnv_pci_dma_dev_setup,
+       .dma_bus_setup = pnv_pci_dma_bus_setup,
 #ifdef CONFIG_PCI_MSI
        .setup_msi_irqs = pnv_setup_msi_irqs,
        .teardown_msi_irqs = pnv_teardown_msi_irqs,
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 8de0140..2441dec 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -757,6 +757,26 @@ void pnv_pci_dma_dev_setup(struct pci_dev *pdev)
 		phb->dma_dev_setup(phb, pdev);
 }
 
+void pnv_pci_dma_bus_setup(struct pci_bus *bus)
+{
+	struct pci_controller *hose = bus->sysdata;
+	struct pnv_phb *phb = hose->private_data;
+	struct pnv_ioda_pe *pe;
+
+	list_for_each_entry(pe, &phb->ioda.pe_list, list) {
+		if (!(pe->flags | (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL)))
+			continue;
+
+		if (!pe->pbus)
+			continue;
+
+		if (bus->number == ((pe->rid >> 8) & 0xFF)) {
+			pe->pbus = bus;
+			break;
+		}
+	}
+}
+
 void pnv_pci_shutdown(void)
 {
 	struct pci_controller *hose;
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 32cae3d..3f814f3 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -232,6 +232,7 @@ extern void pnv_pci_reset_secondary_bus(struct pci_dev *dev);
 extern int pnv_eeh_phb_reset(struct pci_controller *hose, int option);
 
 extern void pnv_pci_dma_dev_setup(struct pci_dev *pdev);
+extern void pnv_pci_dma_bus_setup(struct pci_bus *bus);
 extern int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type);
 extern void pnv_teardown_msi_irqs(struct pci_dev *pdev);
 
-- 
2.1.0
