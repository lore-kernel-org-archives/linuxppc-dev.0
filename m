Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e37.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EAEEE1007D2
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2012 02:20:03 +1000 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 27 Jun 2012 10:20:01 -0600
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id A2AB63C61D82
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 12:04:07 -0400 (EDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5RG45t6138016
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 12:04:06 -0400
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5RG27qB022286
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 10:02:08 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 16/21] ppc/eeh: do reset based on PE
Date: Thu, 28 Jun 2012 00:01:46 +0800
Message-Id: <1340812911-6793-17-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1340812911-6793-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1340812911-6793-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch implements reset based on PE instead of eeh device. Also,
The functions used to retrieve the reset type, either hot or fundamental
reset, have been reworked for a little bit. More specificly, it's
implemented based the the eeh device traverse function.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/ppc-pci.h   |    2 +-
 arch/powerpc/platforms/pseries/eeh.c |   91 +++++++++++++---------------------
 2 files changed, 35 insertions(+), 58 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
index 5e34b10..2a80f08 100644
--- a/arch/powerpc/include/asm/ppc-pci.h
+++ b/arch/powerpc/include/asm/ppc-pci.h
@@ -53,7 +53,7 @@ void pci_addr_cache_remove_device(struct pci_dev *dev);
 struct pci_dev *pci_addr_cache_get_device(unsigned long addr);
 void eeh_slot_error_detail(struct eeh_pe *pe, int severity);
 int eeh_pci_enable(struct eeh_pe *pe, int function);
-int eeh_reset_pe(struct eeh_dev *);
+int eeh_reset_pe(struct eeh_pe *);
 int rtas_write_config(struct pci_dn *, int where, int size, u32 val);
 int rtas_read_config(struct pci_dn *, int where, int size, u32 *val);
 void eeh_pe_state_mark(struct eeh_pe *pe, int state);
diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index 031935d..d855c20 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -455,17 +455,24 @@ int eeh_pci_enable(struct eeh_pe *pe, int function)
  */
 int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state state)
 {
-	struct device_node *dn = pci_device_to_OF_node(dev);
+	struct eeh_dev *edev = pci_dev_to_eeh_dev(dev);
+	struct eeh_pe *pe = edev->pe;
+
+	if (!pe) {
+		pr_err("%s: No PE found on PCI device %s\n",
+			__func__, pci_name(dev));
+		return -EINVAL;
+	}
 
 	switch (state) {
 	case pcie_deassert_reset:
-		eeh_ops->reset(dn, EEH_RESET_DEACTIVATE);
+		eeh_ops->reset(pe, EEH_RESET_DEACTIVATE);
 		break;
 	case pcie_hot_reset:
-		eeh_ops->reset(dn, EEH_RESET_HOT);
+		eeh_ops->reset(pe, EEH_RESET_HOT);
 		break;
 	case pcie_warm_reset:
-		eeh_ops->reset(dn, EEH_RESET_FUNDAMENTAL);
+		eeh_ops->reset(pe, EEH_RESET_FUNDAMENTAL);
 		break;
 	default:
 		return -EINVAL;
@@ -475,66 +482,37 @@ int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state stat
 }
 
 /**
- * __eeh_set_pe_freset - Check the required reset for child devices
- * @parent: parent device
- * @freset: return value
- *
- * Each device might have its preferred reset type: fundamental or
- * hot reset. The routine is used to collect the information from
- * the child devices so that they could be reset accordingly.
- */
-void __eeh_set_pe_freset(struct device_node *parent, unsigned int *freset)
-{
-	struct device_node *dn;
-
-	for_each_child_of_node(parent, dn) {
-		if (of_node_to_eeh_dev(dn)) {
-			struct pci_dev *dev = of_node_to_eeh_dev(dn)->pdev;
-
-			if (dev && dev->driver)
-				*freset |= dev->needs_freset;
-
-			__eeh_set_pe_freset(dn, freset);
-		}
-	}
-}
-
-/**
- * eeh_set_pe_freset - Check the required reset for the indicated device and its children
- * @dn: parent device
- * @freset: return value
+ * eeh_set_pe_freset - Check the required reset for the indicated device
+ * @data: EEH device
+ * @flag: return value
  *
  * Each device might have its preferred reset type: fundamental or
  * hot reset. The routine is used to collected the information for
  * the indicated device and its children so that the bunch of the
  * devices could be reset properly.
  */
-void eeh_set_pe_freset(struct device_node *dn, unsigned int *freset)
+static void *eeh_set_dev_freset(void *data, void *flag)
 {
 	struct pci_dev *dev;
-	dn = eeh_find_device_pe(dn);
-
-	/* Back up one, since config addrs might be shared */
-	if (!pcibios_find_pci_bus(dn) && of_node_to_eeh_dev(dn->parent))
-		dn = dn->parent;
+	unsigned int *freset = (unsigned int *)flag;
+	struct eeh_dev *edev = (struct eeh_dev *)data;
 
-	dev = of_node_to_eeh_dev(dn)->pdev;
+	dev = eeh_dev_to_pci_dev(edev);
 	if (dev)
 		*freset |= dev->needs_freset;
 
-	__eeh_set_pe_freset(dn, freset);
+	return NULL;
 }
 
 /**
  * eeh_reset_pe_once - Assert the pci #RST line for 1/4 second
- * @edev: pci device node to be reset.
+ * @pe: EEH PE
  *
  * Assert the PCI #RST line for 1/4 second.
  */
-static void eeh_reset_pe_once(struct eeh_dev *edev)
+static void eeh_reset_pe_once(struct eeh_pe *pe)
 {
 	unsigned int freset = 0;
-	struct device_node *dn = eeh_dev_to_of_node(edev);
 
 	/* Determine type of EEH reset required for
 	 * Partitionable Endpoint, a hot-reset (1)
@@ -542,12 +520,12 @@ static void eeh_reset_pe_once(struct eeh_dev *edev)
 	 * A fundamental reset required by any device under
 	 * Partitionable Endpoint trumps hot-reset.
   	 */
-	eeh_set_pe_freset(dn, &freset);
+	eeh_pe_dev_traverse(pe, eeh_set_dev_freset, &freset);
 
 	if (freset)
-		eeh_ops->reset(dn, EEH_RESET_FUNDAMENTAL);
+		eeh_ops->reset(pe, EEH_RESET_FUNDAMENTAL);
 	else
-		eeh_ops->reset(dn, EEH_RESET_HOT);
+		eeh_ops->reset(pe, EEH_RESET_HOT);
 
 	/* The PCI bus requires that the reset be held high for at least
 	 * a 100 milliseconds. We wait a bit longer 'just in case'.
@@ -559,9 +537,9 @@ static void eeh_reset_pe_once(struct eeh_dev *edev)
 	 * pci slot reset line is dropped. Make sure we don't miss
 	 * these, and clear the flag now.
 	 */
-	eeh_clear_slot(dn, EEH_MODE_ISOLATED);
+	eeh_pe_state_clear(pe, EEH_MODE_ISOLATED);
 
-	eeh_ops->reset(dn, EEH_RESET_DEACTIVATE);
+	eeh_ops->reset(pe, EEH_RESET_DEACTIVATE);
 
 	/* After a PCI slot has been reset, the PCI Express spec requires
 	 * a 1.5 second idle time for the bus to stabilize, before starting
@@ -573,32 +551,31 @@ static void eeh_reset_pe_once(struct eeh_dev *edev)
 
 /**
  * eeh_reset_pe - Reset the indicated PE
- * @edev: PCI device associated EEH device
+ * @pe: EEH PE
  *
  * This routine should be called to reset indicated device, including
  * PE. A PE might include multiple PCI devices and sometimes PCI bridges
  * might be involved as well.
  */
-int eeh_reset_pe(struct eeh_dev *edev)
+int eeh_reset_pe(struct eeh_pe *pe)
 {
 	int i, rc;
-	struct device_node *dn = eeh_dev_to_of_node(edev);
 
 	/* Take three shots at resetting the bus */
 	for (i=0; i<3; i++) {
-		eeh_reset_pe_once(edev);
+		eeh_reset_pe_once(pe);
 
-		rc = eeh_ops->wait_state(dn, PCI_BUS_RESET_WAIT_MSEC);
+		rc = eeh_ops->wait_state(pe, PCI_BUS_RESET_WAIT_MSEC);
 		if (rc == (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE))
 			return 0;
 
 		if (rc < 0) {
-			printk(KERN_ERR "EEH: unrecoverable slot failure %s\n",
-			       dn->full_name);
+			pr_err("%s: Unrecoverable slot failure on PHB#%d-PE#%x",
+				__func__, pe->phb->global_number, pe->addr);
 			return -1;
 		}
-		printk(KERN_ERR "EEH: bus reset %d failed on slot %s, rc=%d\n",
-		       i+1, dn->full_name, rc);
+		pr_err("EEH: bus reset %d failed on PHB#%d-PE#%x, rc=%d\n",
+			i+1, pe->phb->global_number, pe->addr, rc);
 	}
 
 	return -1;
-- 
1.7.9.5
