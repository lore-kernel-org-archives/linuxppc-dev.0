Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9EEA4140179
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:33 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 24 Apr 2014 18:00:33 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id ED4052CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:30 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3O7dRVc22085786
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 17:39:27 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3O80Tev015011
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:30 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH 18/25] powerpc/pci: Mask linkDown on resetting PCI bus
Date: Thu, 24 Apr 2014 18:00:24 +1000
Message-Id: <1398326431-24305-19-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1398326431-24305-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1398326431-24305-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The problem was initially reported by Wendy who tried pass through
IPR adapter, which was connected to PHB root port directly, to KVM
based guest. When doing that, pci_reset_bridge_secondary_bus() was
called by VFIO driver and linkDown was detected by the root port.
That caused all PEs to be frozen.

The patch fixes the issue by routing the reset for the secondary bus
of root port to underly firmware. For that, one more weak function
pci_reset_secondary_bus() is introduced so that the individual platforms
can override that and do specific reset for bridge's secondary bus.

Reported-by: Wendy Xiong <wenxiong@linux.vnet.ibm.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/machdep.h        |  3 +++
 arch/powerpc/kernel/pci-common.c          | 20 ++++++++++++++++
 arch/powerpc/platforms/powernv/eeh-ioda.c | 38 +++++++++++++++++++++++++++++--
 arch/powerpc/platforms/powernv/pci-ioda.c |  1 +
 arch/powerpc/platforms/powernv/pci.h      |  1 +
 drivers/pci/pci.c                         | 21 ++++++++++-------
 6 files changed, 74 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 5b6c03f..240b137 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -241,6 +241,9 @@ struct machdep_calls {
 	/* Called during PCI resource reassignment */
 	resource_size_t (*pcibios_window_alignment)(struct pci_bus *, unsigned long type);
 
+	/* Reset the secondary bus of bridge */
+	void  (*pcibios_reset_secondary_bus)(struct pci_dev *dev);
+
 	/* Called to shutdown machine specific hardware not already controlled
 	 * by other drivers.
 	 */
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index d9476c1..f9ca509 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -21,6 +21,7 @@
 #include <linux/string.h>
 #include <linux/init.h>
 #include <linux/bootmem.h>
+#include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
@@ -120,6 +121,25 @@ resource_size_t pcibios_window_alignment(struct pci_bus *bus,
 	return 1;
 }
 
+void pcibios_reset_secondary_bus(struct pci_dev *dev)
+{
+	u16 ctrl;
+
+	if (ppc_md.pcibios_reset_secondary_bus) {
+		ppc_md.pcibios_reset_secondary_bus(dev);
+		return;
+	}
+
+	pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &ctrl);
+	ctrl |= PCI_BRIDGE_CTL_BUS_RESET;
+	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
+	msleep(2);
+
+	ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
+	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
+	ssleep(1);
+}
+
 static resource_size_t pcibios_io_size(const struct pci_controller *hose)
 {
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 268cd46..58ef809 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -474,6 +474,8 @@ static int ioda_eeh_bridge_reset(struct pci_dev *dev, int option)
 
 {
 	struct device_node *dn = pci_device_to_OF_node(dev);
+	struct eeh_dev *edev = of_node_to_eeh_dev(dn);
+	int aer = edev ? edev->aer_cap : 0;
 	u32 ctrl;
 
 	pr_debug("%s: Reset PCI bus %04x:%02x with option %d\n",
@@ -483,24 +485,56 @@ static int ioda_eeh_bridge_reset(struct pci_dev *dev, int option)
 	switch (option) {
 	case EEH_RESET_FUNDAMENTAL:
 	case EEH_RESET_HOT:
+		/* Don't report linkDown event */
+		if (aer) {
+			eeh_ops->read_config(dn, aer + PCI_ERR_UNCOR_MASK,
+					     4, &ctrl);
+			ctrl |= PCI_ERR_UNC_SURPDN;
+                        eeh_ops->write_config(dn, aer + PCI_ERR_UNCOR_MASK,
+					      4, ctrl);
+                }
+
 		eeh_ops->read_config(dn, PCI_BRIDGE_CONTROL, 2, &ctrl);
 		ctrl |= PCI_BRIDGE_CTL_BUS_RESET;
 		eeh_ops->write_config(dn, PCI_BRIDGE_CONTROL, 2, ctrl);
-
 		msleep(EEH_PE_RST_HOLD_TIME);
+
 		break;
 	case EEH_RESET_DEACTIVATE:
 		eeh_ops->read_config(dn, PCI_BRIDGE_CONTROL, 2, &ctrl);
 		ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
 		eeh_ops->write_config(dn, PCI_BRIDGE_CONTROL, 2, ctrl);
-
 		msleep(EEH_PE_RST_SETTLE_TIME);
+
+		/* Continue reporting linkDown event */
+		if (aer) {
+			eeh_ops->read_config(dn, aer + PCI_ERR_UNCOR_MASK,
+					     4, &ctrl);
+			ctrl &= ~PCI_ERR_UNC_SURPDN;
+			eeh_ops->write_config(dn, aer + PCI_ERR_UNCOR_MASK,
+					      4, ctrl);
+		}
+
 		break;
 	}
 
 	return 0;
 }
 
+void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
+{
+	struct pci_controller *hose;
+
+	if (pci_is_root_bus(dev->bus)) {
+		hose = pci_bus_to_host(dev->bus);
+		ioda_eeh_root_reset(hose, EEH_RESET_HOT);
+		ioda_eeh_root_reset(hose, EEH_RESET_DEACTIVATE);
+	} else {
+		ioda_eeh_bridge_reset(dev, EEH_RESET_HOT);
+		ioda_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE);
+	}
+}
+
 /**
  * ioda_eeh_reset - Reset the indicated PE
  * @pe: EEH PE
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 3b2b4fb..0bfc4d1 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1387,6 +1387,7 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	ppc_md.pcibios_fixup = pnv_pci_ioda_fixup;
 	ppc_md.pcibios_enable_device_hook = pnv_pci_enable_device_hook;
 	ppc_md.pcibios_window_alignment = pnv_pci_window_alignment;
+	ppc_md.pcibios_reset_secondary_bus = pnv_pci_reset_secondary_bus;
 	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
 
 	/* Reset IODA tables to a clean state */
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 39ec697..34a0974 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -204,5 +204,6 @@ extern void pnv_pci_init_ioda_hub(struct device_node *np);
 extern void pnv_pci_init_ioda2_phb(struct device_node *np);
 extern void pnv_pci_ioda_tce_invalidate(struct iommu_table *tbl,
 					__be64 *startp, __be64 *endp, bool rm);
+extern void pnv_pci_reset_secondary_bus(struct pci_dev *dev);
 
 #endif /* __POWERNV_PCI_H */
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7325d43..633382d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3167,14 +3167,7 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
 	return 0;
 }
 
-/**
- * pci_reset_bridge_secondary_bus - Reset the secondary bus on a PCI bridge.
- * @dev: Bridge device
- *
- * Use the bridge control register to assert reset on the secondary bus.
- * Devices on the secondary bus are left in power-on state.
- */
-void pci_reset_bridge_secondary_bus(struct pci_dev *dev)
+void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
 {
 	u16 ctrl;
 
@@ -3199,6 +3192,18 @@ void pci_reset_bridge_secondary_bus(struct pci_dev *dev)
 	 */
 	ssleep(1);
 }
+
+/**
+ * pci_reset_bridge_secondary_bus - Reset the secondary bus on a PCI bridge.
+ * @dev: Bridge device
+ *
+ * Use the bridge control register to assert reset on the secondary bus.
+ * Devices on the secondary bus are left in power-on state.
+ */
+void pci_reset_bridge_secondary_bus(struct pci_dev *dev)
+{
+	pcibios_reset_secondary_bus(dev);
+}
 EXPORT_SYMBOL_GPL(pci_reset_bridge_secondary_bus);
 
 static int pci_parent_bus_reset(struct pci_dev *dev, int probe)
-- 
1.8.3.2
