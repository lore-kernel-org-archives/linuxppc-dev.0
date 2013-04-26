Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e35.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 19BF42C0123
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2013 15:21:16 +1000 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 25 Apr 2013 23:21:14 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 881BC3E40042
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 23:20:57 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3Q5LBVm115598
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 23:21:11 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3Q5L9vN022674
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 23:21:10 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/6] powerpc/powernv: Patch MSI EOI handler on P8
Date: Fri, 26 Apr 2013 13:20:59 +0800
Message-Id: <1366953662-9473-4-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1366953662-9473-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1366953662-9473-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The EOI handler of MSI/MSI-X interrupts for P8 (PHB3) need additional
steps to handle the P/Q bits in IVE before EOIing the corresponding
interrupt. The patch changes the EOI handler to cover that. we have
individual IRQ chip in each PHB instance. During the MSI IRQ setup
time, the IRQ chip is copied over from the original one for that IRQ,
and the EOI handler is patched with the one that will handle the P/Q
bits (As Ben suggested).

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h                |    2 +
 arch/powerpc/include/asm/xics.h                |    1 +
 arch/powerpc/platforms/powernv/opal-wrappers.S |    1 +
 arch/powerpc/platforms/powernv/pci-ioda.c      |   38 ++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/pci-p5ioc2.c    |    4 +-
 arch/powerpc/platforms/powernv/pci.c           |    2 +-
 arch/powerpc/platforms/powernv/pci.h           |    8 ++++-
 arch/powerpc/sysdev/xics/icp-native.c          |    2 +-
 8 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index a4b28f1..b6c8b58 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -117,6 +117,7 @@ extern int opal_enter_rtas(struct rtas_args *args,
 #define OPAL_SET_SLOT_LED_STATUS		55
 #define OPAL_GET_EPOW_STATUS			56
 #define OPAL_SET_SYSTEM_ATTENTION_LED		57
+#define OPAL_PCI_MSI_EOI			63
 
 #ifndef __ASSEMBLY__
 
@@ -506,6 +507,7 @@ int64_t opal_pci_get_xive_reissue(uint64_t phb_id, uint32_t xive_number,
 				  uint8_t *p_bit, uint8_t *q_bit);
 int64_t opal_pci_set_xive_reissue(uint64_t phb_id, uint32_t xive_number,
 				  uint8_t p_bit, uint8_t q_bit);
+int64_t opal_pci_msi_eoi(uint64_t phb_id, uint32_t hw_irq);
 int64_t opal_pci_set_xive_pe(uint64_t phb_id, uint32_t pe_number,
 			     uint32_t xive_num);
 int64_t opal_get_xive_source(uint64_t phb_id, uint32_t xive_num,
diff --git a/arch/powerpc/include/asm/xics.h b/arch/powerpc/include/asm/xics.h
index 4ae9a09..282d43a 100644
--- a/arch/powerpc/include/asm/xics.h
+++ b/arch/powerpc/include/asm/xics.h
@@ -150,6 +150,7 @@ extern void xics_register_ics(struct ics *ics);
 extern void xics_teardown_cpu(void);
 extern void xics_kexec_teardown_cpu(int secondary);
 extern void xics_migrate_irqs_away(void);
+extern void icp_native_eoi(struct irq_data *d);
 #ifdef CONFIG_SMP
 extern int xics_get_irq_server(unsigned int virq, const struct cpumask *cpumask,
 			       unsigned int strict_check);
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 3bb07e5..6fabe92 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -107,3 +107,4 @@ OPAL_CALL(opal_pci_mask_pe_error,		OPAL_PCI_MASK_PE_ERROR);
 OPAL_CALL(opal_set_slot_led_status,		OPAL_SET_SLOT_LED_STATUS);
 OPAL_CALL(opal_get_epow_status,			OPAL_GET_EPOW_STATUS);
 OPAL_CALL(opal_set_system_attention_led,	OPAL_SET_SYSTEM_ATTENTION_LED);
+OPAL_CALL(opal_pci_msi_eoi,			OPAL_PCI_MSI_EOI);
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 3d4e958..3f88c51 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -31,6 +31,7 @@
 #include <asm/opal.h>
 #include <asm/iommu.h>
 #include <asm/tce.h>
+#include <asm/xics.h>
 
 #include "powernv.h"
 #include "pci.h"
@@ -589,11 +590,27 @@ static void pnv_ioda_setup_dma(struct pnv_phb *phb)
 }
 
 #ifdef CONFIG_PCI_MSI
+static void pnv_ioda2_msi_eoi(struct irq_data *d)
+{
+	unsigned int hw_irq = (unsigned int)irqd_to_hwirq(d);
+	struct irq_chip *chip = irq_data_get_irq_chip(d);
+	struct pnv_phb *phb = container_of(chip, struct pnv_phb,
+					   ioda.irq_chip);
+	int64_t rc;
+
+	rc = opal_pci_msi_eoi(phb->opal_id, hw_irq);
+	WARN_ON_ONCE(rc);
+
+	icp_native_eoi(d);
+}
+
 static int pnv_pci_ioda_msi_setup(struct pnv_phb *phb, struct pci_dev *dev,
-				  unsigned int hwirq, unsigned int is_64,
-				  struct msi_msg *msg)
+				  unsigned int hwirq, unsigned int virq,
+				  unsigned int is_64, struct msi_msg *msg)
 {
 	struct pnv_ioda_pe *pe = pnv_ioda_get_pe(dev);
+	struct irq_data *idata;
+	struct irq_chip *ichip;
 	unsigned int xive_num = hwirq - phb->msi_base;
 	uint64_t addr64;
 	uint32_t addr32, data;
@@ -638,6 +655,23 @@ static int pnv_pci_ioda_msi_setup(struct pnv_phb *phb, struct pci_dev *dev,
 	}
 	msg->data = data;
 
+	/*
+	 * Change the IRQ chip for the MSI interrupts on PHB3.
+	 * The corresponding IRQ chip should be populated for
+	 * the first time.
+	 */
+	if (phb->type == PNV_PHB_IODA2) {
+		if (!phb->ioda.irq_chip_init) {
+			idata = irq_get_irq_data(virq);
+			ichip = irq_data_get_irq_chip(idata);
+			phb->ioda.irq_chip_init = 1;
+			phb->ioda.irq_chip = *ichip;
+			phb->ioda.irq_chip.irq_eoi = pnv_ioda2_msi_eoi;
+		}
+
+		irq_set_chip(virq, &phb->ioda.irq_chip);
+	}
+
 	pr_devel("%s: %s-bit MSI on hwirq %x (xive #%d),"
 		 " address=%x_%08x data=%x PE# %d\n",
 		 pci_name(dev), is_64 ? "64" : "32", hwirq, xive_num,
diff --git a/arch/powerpc/platforms/powernv/pci-p5ioc2.c b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
index d5c066e..92b37a0 100644
--- a/arch/powerpc/platforms/powernv/pci-p5ioc2.c
+++ b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
@@ -42,8 +42,8 @@
 
 #ifdef CONFIG_PCI_MSI
 static int pnv_pci_p5ioc2_msi_setup(struct pnv_phb *phb, struct pci_dev *dev,
-				    unsigned int hwirq, unsigned int is_64,
-				    struct msi_msg *msg)
+				    unsigned int hwirq, unsigned int virq,
+				    unsigned int is_64, struct msi_msg *msg)
 {
 	if (WARN_ON(!is_64))
 		return -ENXIO;
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index a11b5a6..861e185 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -84,7 +84,7 @@ static int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 			return -ENOMEM;
 		}
 		rc = phb->msi_setup(phb, pdev, phb->msi_base + hwirq,
-				    entry->msi_attrib.is_64, &msg);
+				    virq, entry->msi_attrib.is_64, &msg);
 		if (rc) {
 			pr_warn("%s: Failed to setup MSI\n", pci_name(pdev));
 			irq_dispose_mapping(virq);
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index f6314d6..3c552b3 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -79,8 +79,8 @@ struct pnv_phb {
 	struct msi_bitmap	msi_bmp;
 #endif
 	int (*msi_setup)(struct pnv_phb *phb, struct pci_dev *dev,
-			 unsigned int hwirq, unsigned int is_64,
-			 struct msi_msg *msg);
+			 unsigned int hwirq, unsigned int virq,
+			 unsigned int is_64, struct msi_msg *msg);
 	void (*dma_dev_setup)(struct pnv_phb *phb, struct pci_dev *pdev);
 	void (*fixup_phb)(struct pci_controller *hose);
 	u32 (*bdfn_to_pe)(struct pnv_phb *phb, struct pci_bus *bus, u32 devfn);
@@ -108,6 +108,10 @@ struct pnv_phb {
 			unsigned int		*io_segmap;
 			struct pnv_ioda_pe	*pe_array;
 
+			/* IRQ chip */
+			int			irq_chip_init;
+			struct irq_chip		irq_chip;
+
 			/* Sorted list of used PE's based
 			 * on the sequence of creation
 			 */
diff --git a/arch/powerpc/sysdev/xics/icp-native.c b/arch/powerpc/sysdev/xics/icp-native.c
index 48861d3..89db29d 100644
--- a/arch/powerpc/sysdev/xics/icp-native.c
+++ b/arch/powerpc/sysdev/xics/icp-native.c
@@ -81,7 +81,7 @@ static void icp_native_set_cpu_priority(unsigned char cppr)
 	iosync();
 }
 
-static void icp_native_eoi(struct irq_data *d)
+void icp_native_eoi(struct irq_data *d)
 {
 	unsigned int hw_irq = (unsigned int)irqd_to_hwirq(d);
 
-- 
1.7.5.4
