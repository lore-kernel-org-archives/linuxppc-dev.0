Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B00C22C020F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2013 19:33:01 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 19 Apr 2013 03:32:56 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 0F4821FF003C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2013 03:27:51 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3J9Wq8j348822
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2013 03:32:52 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3J9WqeD022679
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2013 03:32:52 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] powerpc/powernv: Patch MSI EOI handler on P8
Date: Fri, 19 Apr 2013 17:32:45 +0800
Message-Id: <1366363965-23281-3-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1366363965-23281-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1366363965-23281-1-git-send-email-shangw@linux.vnet.ibm.com>
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
 arch/powerpc/platforms/powernv/pci-ioda.c |   33 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/pci.c      |   19 ++++++++++++++++
 arch/powerpc/platforms/powernv/pci.h      |    1 +
 arch/powerpc/sysdev/xics/icp-native.c     |   33 ++++++++++++++++++++++++++++-
 4 files changed, 85 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index d8d5baa..de4a4a9 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -645,6 +645,37 @@ static int pnv_pci_ioda_msi_setup(struct pnv_phb *phb, struct pci_dev *dev,
 	return 0;
 }
 
+static int pnv_pci_ioda_msi_eoi(struct pnv_phb *phb, unsigned int hw_irq)
+{
+	u8 p_bit = 1, q_bit = 1;
+	long rc;
+
+	while (p_bit || q_bit) {
+		rc = opal_pci_get_xive_reissue(phb->opal_id,
+				hw_irq - phb->msi_base, &p_bit, &q_bit);
+		if (rc) {
+			pr_warning("%s: Failed to get P/Q bits of IRQ#%d "
+				   "on PHB#%d, rc=%ld\n", __func__, hw_irq,
+				   phb->hose->global_number, rc);
+			return -EIO;
+		}
+		if (!p_bit && !q_bit)
+			break;
+
+		rc = opal_pci_set_xive_reissue(phb->opal_id,
+				hw_irq - phb->msi_base, p_bit, q_bit);
+		if (rc) {
+			pr_warning("%s: Failed to clear P/Q (%01d/%01d) of "
+				   "IRQ#%d on PHB#%d, rc=%ld\n", __func__,
+				   p_bit, q_bit, hw_irq,
+				   phb->hose->global_number, rc);
+			return -EIO;
+		}
+	}
+
+	return 0;
+}
+
 static void pnv_pci_init_ioda_msis(struct pnv_phb *phb)
 {
 	unsigned int bmap_size;
@@ -667,6 +698,8 @@ static void pnv_pci_init_ioda_msis(struct pnv_phb *phb)
 		return;
 	}
 	phb->msi_setup = pnv_pci_ioda_msi_setup;
+	if (phb->type == PNV_PHB_IODA2)
+		phb->msi_eoi = pnv_pci_ioda_msi_eoi;
 	phb->msi32_support = 1;
 	pr_info("  Allocated bitmap for %d MSIs (base IRQ 0x%x)\n",
 		phb->msi_count, phb->msi_base);
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index e088dc7..439dfc5 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -148,6 +148,25 @@ static void pnv_teardown_msi_irqs(struct pci_dev *pdev)
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
+		    hw_irq < phb->msi_base + phb->msi_count) {
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
index fcd5135..4ae015b 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -101,6 +101,7 @@ struct pnv_phb {
 	int (*msi_setup)(struct pnv_phb *phb, struct pci_dev *dev,
 			 unsigned int hwirq, unsigned int is_64,
 			 struct msi_msg *msg);
+	int (*msi_eoi)(struct pnv_phb *phb, unsigned int hw_irq);
 	void (*dma_dev_setup)(struct pnv_phb *phb, struct pci_dev *pdev);
 	void (*fixup_phb)(struct pci_controller *hose);
 	u32 (*bdfn_to_pe)(struct pnv_phb *phb, struct pci_bus *bus, u32 devfn);
diff --git a/arch/powerpc/sysdev/xics/icp-native.c b/arch/powerpc/sysdev/xics/icp-native.c
index 48861d3..289355e 100644
--- a/arch/powerpc/sysdev/xics/icp-native.c
+++ b/arch/powerpc/sysdev/xics/icp-native.c
@@ -27,6 +27,10 @@
 #include <asm/xics.h>
 #include <asm/kvm_ppc.h>
 
+#if defined(CONFIG_PPC_POWERNV) && defined(CONFIG_PCI_MSI)
+extern int pnv_pci_msi_eoi(unsigned int hw_irq);
+#endif
+
 struct icp_ipl {
 	union {
 		u32 word;
@@ -89,6 +93,24 @@ static void icp_native_eoi(struct irq_data *d)
 	icp_native_set_xirr((xics_pop_cppr() << 24) | hw_irq);
 }
 
+static void icp_p8_native_eoi(struct irq_data *d)
+{
+	unsigned int hw_irq = (unsigned int)irqd_to_hwirq(d);
+	int ret;
+
+	/* Let firmware handle P/Q bits */
+#if defined(CONFIG_PPC_POWERNV) && defined(CONFIG_PCI_MSI)
+	if (hw_irq != XICS_IPI) {
+		ret = pnv_pci_msi_eoi(hw_irq);
+		WARN_ON_ONCE(ret);
+	}
+#endif
+
+	/* EOI on ICP */
+	iosync();
+	icp_native_set_xirr((xics_pop_cppr() << 24) | hw_irq);
+}
+
 static void icp_native_teardown_cpu(void)
 {
 	int cpu = smp_processor_id();
@@ -264,7 +286,7 @@ static int __init icp_native_init_one_node(struct device_node *np,
 	return 0;
 }
 
-static const struct icp_ops icp_native_ops = {
+static struct icp_ops icp_native_ops = {
 	.get_irq	= icp_native_get_irq,
 	.eoi		= icp_native_eoi,
 	.set_priority	= icp_native_set_cpu_priority,
@@ -296,6 +318,15 @@ int __init icp_native_init(void)
 	if (found == 0)
 		return -ENODEV;
 
+	/* Change the EOI handler for P8 */
+#if defined(CONFIG_PPC_POWERNV) && defined(CONFIG_PCI_MSI)
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
