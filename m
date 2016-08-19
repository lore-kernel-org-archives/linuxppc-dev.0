Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFsBw3x29zDr8p
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 15:36:08 +1000 (AEST)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Cc: kvm-ppc@vger.kernel.org
Subject: [PATCH 05/13] powerpc/powernv: Provide facilities for EOI,
 usable from real mode
Date: Fri, 19 Aug 2016 15:35:49 +1000
Message-Id: <1471584957-21484-6-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1471584957-21484-1-git-send-email-paulus@ozlabs.org>
References: <1471584957-21484-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Suresh Warrier <warrier@linux.vnet.ibm.com>

This adds a new function pnv_opal_pci_msi_eoi() which does the part of
end-of-interrupt (EOI) handling of an MSI which involves doing an
OPAL call.  This function can be called in real mode.  This doesn't
just export pnv_ioda2_msi_eoi() because that does a call to
icp_native_eoi(), which does not work in real mode.

This also adds a function, is_pnv_opal_msi(), which KVM can call to
check whether an interrupt is one for which we should be calling
pnv_opal_pci_msi_eoi() when we need to do an EOI.

[paulus@ozlabs.org - split out the addition of pnv_opal_pci_msi_eoi()
 from Suresh's patch "KVM: PPC: Book3S HV: Handle passthrough
 interrupts in guest"; added is_pnv_opal_msi(); wrote description.]

Signed-off-by: Suresh Warrier <warrier@linux.vnet.ibm.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/pnv-pci.h        |  3 +++
 arch/powerpc/platforms/powernv/pci-ioda.c | 24 ++++++++++++++++++++----
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/pnv-pci.h b/arch/powerpc/include/asm/pnv-pci.h
index 0cbd813..1b46b52 100644
--- a/arch/powerpc/include/asm/pnv-pci.h
+++ b/arch/powerpc/include/asm/pnv-pci.h
@@ -12,6 +12,7 @@
 
 #include <linux/pci.h>
 #include <linux/pci_hotplug.h>
+#include <linux/irq.h>
 #include <misc/cxl-base.h>
 #include <asm/opal-api.h>
 
@@ -33,6 +34,8 @@ int pnv_cxl_alloc_hwirqs(struct pci_dev *dev, int num);
 void pnv_cxl_release_hwirqs(struct pci_dev *dev, int hwirq, int num);
 int pnv_cxl_get_irq_count(struct pci_dev *dev);
 struct device_node *pnv_pci_get_phb_node(struct pci_dev *dev);
+int64_t pnv_opal_pci_msi_eoi(struct irq_chip *chip, unsigned int hw_irq);
+bool is_pnv_opal_msi(struct irq_chip *chip);
 
 #ifdef CONFIG_CXL_BASE
 int pnv_cxl_alloc_hwirq_ranges(struct cxl_irq_ranges *irqs,
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index fd9444f..9ce48ae 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2710,15 +2710,21 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 }
 
 #ifdef CONFIG_PCI_MSI
-static void pnv_ioda2_msi_eoi(struct irq_data *d)
+int64_t pnv_opal_pci_msi_eoi(struct irq_chip *chip, unsigned int hw_irq)
 {
-	unsigned int hw_irq = (unsigned int)irqd_to_hwirq(d);
-	struct irq_chip *chip = irq_data_get_irq_chip(d);
 	struct pnv_phb *phb = container_of(chip, struct pnv_phb,
 					   ioda.irq_chip);
+
+	return opal_pci_msi_eoi(phb->opal_id, hw_irq);
+}
+
+static void pnv_ioda2_msi_eoi(struct irq_data *d)
+{
 	int64_t rc;
+	unsigned int hw_irq = (unsigned int)irqd_to_hwirq(d);
+	struct irq_chip *chip = irq_data_get_irq_chip(d);
 
-	rc = opal_pci_msi_eoi(phb->opal_id, hw_irq);
+	rc = pnv_opal_pci_msi_eoi(chip, hw_irq);
 	WARN_ON_ONCE(rc);
 
 	icp_native_eoi(d);
@@ -2748,6 +2754,16 @@ void pnv_set_msi_irq_chip(struct pnv_phb *phb, unsigned int virq)
 	irq_set_chip(virq, &phb->ioda.irq_chip);
 }
 
+/*
+ * Returns true iff chip is something that we could call
+ * pnv_opal_pci_msi_eoi for.
+ */
+bool is_pnv_opal_msi(struct irq_chip *chip)
+{
+	return chip->irq_eoi == pnv_ioda2_msi_eoi;
+}
+EXPORT_SYMBOL_GPL(is_pnv_opal_msi);
+
 static int pnv_pci_ioda_msi_setup(struct pnv_phb *phb, struct pci_dev *dev,
 				  unsigned int hwirq, unsigned int virq,
 				  unsigned int is_64, struct msi_msg *msg)
-- 
2.8.1
