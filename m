Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6D2D22C013F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 19:37:56 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 24 Apr 2013 05:37:53 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 39EA16E803A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 05:37:46 -0400 (EDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3O9bmvP330250
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 05:37:48 -0400
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3O9bkkd019561
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 03:37:48 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/7] powerpc/powernv: Patch MSI EOI handler on P8
Date: Wed, 24 Apr 2013 17:37:36 +0800
Message-Id: <1366796259-29412-5-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1366796259-29412-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1366796259-29412-1-git-send-email-shangw@linux.vnet.ibm.com>
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
interrupt. The patch changes the EOI handler to cover that.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h                |    2 +
 arch/powerpc/include/asm/xics.h                |    3 ++
 arch/powerpc/platforms/powernv/opal-wrappers.S |    1 +
 arch/powerpc/platforms/powernv/pci-ioda.c      |   16 ++++++++++++++
 arch/powerpc/platforms/powernv/pci.c           |   19 ++++++++++++++++
 arch/powerpc/platforms/powernv/pci.h           |    1 +
 arch/powerpc/sysdev/xics/icp-native.c          |   27 +++++++++++++++++++++++-
 7 files changed, 68 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 0af7ba0..93dad52 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -117,6 +117,7 @@ extern int opal_enter_rtas(struct rtas_args *args,
 #define OPAL_SET_SLOT_LED_STATUS		55
 #define OPAL_GET_EPOW_STATUS			56
 #define OPAL_SET_SYSTEM_ATTENTION_LED		57
+#define OPAL_PCI_MSI_EOI			63
 
 #ifndef __ASSEMBLY__
 
@@ -505,6 +506,7 @@ int64_t opal_pci_get_xive_reissue(uint64_t phb_id, uint32_t xive_number,
 				  uint8_t *p_bit, uint8_t *q_bit);
 int64_t opal_pci_set_xive_reissue(uint64_t phb_id, uint32_t xive_number,
 				  uint8_t p_bit, uint8_t q_bit);
+int64_t opal_pci_msi_eoi(uint64_t phb_id, uint32_t ive_number);
 int64_t opal_pci_set_xive_pe(uint64_t phb_id, uint32_t pe_number,
 			     uint32_t xive_num);
 int64_t opal_get_xive_source(uint64_t phb_id, uint32_t xive_num,
diff --git a/arch/powerpc/include/asm/xics.h b/arch/powerpc/include/asm/xics.h
index 4ae9a09..c4b364b 100644
--- a/arch/powerpc/include/asm/xics.h
+++ b/arch/powerpc/include/asm/xics.h
@@ -72,6 +72,9 @@ extern int ics_opal_init(void);
 static inline int ics_opal_init(void) { return -ENODEV; }
 #endif
 
+/* Extra EOI handler for PHB3 */
+extern int pnv_pci_msi_eoi(unsigned int hw_irq);
+
 /* ICS instance, hooked up to chip_data of an irq */
 struct ics {
 	struct list_head link;
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
index 0c15870..32197af 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -646,6 +646,20 @@ static int pnv_pci_ioda_msi_setup(struct pnv_phb *phb, struct pci_dev *dev,
 	return 0;
 }
 
+static int pnv_pci_ioda_msi_eoi(struct pnv_phb *phb, unsigned int hw_irq)
+{
+	long rc;
+
+	rc = opal_pci_msi_eoi(phb->opal_id, hw_irq - phb->msi_base);
+	if (rc) {
+		pr_warning("%s: Failed to EOI IRQ#%d on PHB#%d, rc=%ld\n",
+			   __func__, hw_irq, phb->hose->global_number, rc);
+		return -EIO;
+	}
+
+	return 0;
+}
+
 static void pnv_pci_init_ioda_msis(struct pnv_phb *phb)
 {
 	unsigned int count;
@@ -667,6 +681,8 @@ static void pnv_pci_init_ioda_msis(struct pnv_phb *phb)
 	}
 
 	phb->msi_setup = pnv_pci_ioda_msi_setup;
+	if (phb->type == PNV_PHB_IODA2)
+		phb->msi_eoi = pnv_pci_ioda_msi_eoi;
 	phb->msi32_support = 1;
 	pr_info("  Allocated bitmap for %d MSIs (base IRQ 0x%x)\n",
 		count, phb->msi_base);
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index a11b5a6..ea6a93d 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -115,6 +115,25 @@ static void pnv_teardown_msi_irqs(struct pci_dev *pdev)
 		irq_dispose_mapping(entry->irq);
 	}
 }
+
+int pnv_pci_msi_eoi(unsigned int hw_irq)
+{
+	struct pci_controller *hose, *tmp;
+	struct pnv_phb *phb = NULL;
+
+	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
+		phb = hose->private_data;
+		if (hw_irq >= phb->msi_base &&
+		    hw_irq < phb->msi_base + phb->msi_bmp.irq_count) {
+			if (!phb->msi_eoi)
+				return -EEXIST;
+			return phb->msi_eoi(phb, hw_irq);
+		}
+	}
+
+	/* For LSI interrupts, we needn't do it */
+	return 0;
+}
 #endif /* CONFIG_PCI_MSI */
 
 static void pnv_pci_dump_p7ioc_diag_data(struct pnv_phb *phb)
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index c048c29..c6690b3 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -81,6 +81,7 @@ struct pnv_phb {
 	int (*msi_setup)(struct pnv_phb *phb, struct pci_dev *dev,
 			 unsigned int hwirq, unsigned int is_64,
 			 struct msi_msg *msg);
+	int (*msi_eoi)(struct pnv_phb *phb, unsigned int hw_irq);
 	void (*dma_dev_setup)(struct pnv_phb *phb, struct pci_dev *pdev);
 	void (*fixup_phb)(struct pci_controller *hose);
 	u32 (*bdfn_to_pe)(struct pnv_phb *phb, struct pci_bus *bus, u32 devfn);
diff --git a/arch/powerpc/sysdev/xics/icp-native.c b/arch/powerpc/sysdev/xics/icp-native.c
index 48861d3..38dd2b1 100644
--- a/arch/powerpc/sysdev/xics/icp-native.c
+++ b/arch/powerpc/sysdev/xics/icp-native.c
@@ -89,6 +89,22 @@ static void icp_native_eoi(struct irq_data *d)
 	icp_native_set_xirr((xics_pop_cppr() << 24) | hw_irq);
 }
 
+static void icp_p8_native_eoi(struct irq_data *d)
+{
+	unsigned int hw_irq = (unsigned int)irqd_to_hwirq(d);
+	int ret;
+
+	/* Let firmware handle P/Q bits */
+	if (hw_irq != XICS_IPI) {
+		ret = pnv_pci_msi_eoi(hw_irq);
+		WARN_ON_ONCE(ret);
+	}
+
+	/* EOI on ICP */
+	iosync();
+	icp_native_set_xirr((xics_pop_cppr() << 24) | hw_irq);
+}
+
 static void icp_native_teardown_cpu(void)
 {
 	int cpu = smp_processor_id();
@@ -264,7 +280,7 @@ static int __init icp_native_init_one_node(struct device_node *np,
 	return 0;
 }
 
-static const struct icp_ops icp_native_ops = {
+static struct icp_ops icp_native_ops = {
 	.get_irq	= icp_native_get_irq,
 	.eoi		= icp_native_eoi,
 	.set_priority	= icp_native_set_cpu_priority,
@@ -296,6 +312,15 @@ int __init icp_native_init(void)
 	if (found == 0)
 		return -ENODEV;
 
+	/* Change the EOI handler for P8 */
+#ifdef CONFIG_POWERNV_MSI
+	np = of_find_compatible_node(NULL, NULL, "ibm,power8-xicp");
+	if (np) {
+		icp_native_ops.eoi = icp_p8_native_eoi;
+		of_node_put(np);
+	}
+#endif
+
 	icp_ops = &icp_native_ops;
 
 	return 0;
-- 
1.7.5.4
