Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7819F1A03B6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 10:21:55 +1100 (AEDT)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4D2DE14018C
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2015 10:21:55 +1100 (AEDT)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 11 Feb 2015 09:21:50 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C2348357804C
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2015 10:21:48 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1ANLe6O46006354
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2015 10:21:48 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1ANLEHt012079
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2015 10:21:14 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/eeh: Enhance pcibios_set_pcie_reset_state()
Date: Wed, 11 Feb 2015 10:20:49 +1100
Message-Id: <1423610449-14195-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Function pcibios_set_pcie_reset_state() is possibly called by
pci_reset_function(), on which VFIO infrastructure depends to
issue reset. pcibios_set_pcie_reset_state() is issuing reset
on the parent PE of the indicated PCI device. The reset causes
state lost on all PCI devices except the indicated one as the
argument to pcibios_set_pcie_reset_state(). Also, sideband
MMIO access from guest when issuing reset would cause unexpected
EEH error.

For above two issues, the patch applies following enhancements
to pcibios_set_pcie_reset_state():

   * For all PCI devices except the indicated one, save their
     state prior to reset and restore state after that.
   * Explicitly freeze PE prior to reset and unfreeze it after
     that, in order to avoid unexpected EEH error.

Tested-by: Priya M. A <priyama2@in.ibm.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index e1b6d8e..9c67538 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -660,6 +660,55 @@ int eeh_pci_enable(struct eeh_pe *pe, int function)
 	return rc;
 }
 
+static void *eeh_disable_and_save_dev_state(void *data, void *userdata)
+{
+	struct eeh_dev *edev = data;
+	struct pci_dev *pdev = eeh_dev_to_pci_dev(edev);
+	struct pci_dev *dev = userdata;
+
+	/*
+	 * The caller should have disabled and saved the
+	 * state for the specified device
+	 */
+	if (!pdev || pdev == dev)
+		return NULL;
+
+	/* Ensure we have D0 power state */
+	pci_set_power_state(pdev, PCI_D0);
+
+	/* Save device state */
+	pci_save_state(pdev);
+
+	/*
+	 * Disable device to avoid any DMA traffic and
+	 * interrupt from the device
+	 */
+	pci_write_config_word(pdev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE);
+
+	return NULL;
+}
+
+static void *eeh_restore_dev_state(void *data, void *userdata)
+{
+	struct eeh_dev *edev = data;
+	struct device_node *dn = eeh_dev_to_of_node(edev);
+	struct pci_dev *pdev = eeh_dev_to_pci_dev(edev);
+	struct pci_dev *dev = userdata;
+
+	if (!pdev)
+		return NULL;
+
+	/* Apply customization from firmware */
+	if (dn && eeh_ops->restore_config)
+		eeh_ops->restore_config(dn);
+
+	/* The caller should restore state for the specified device */
+	if (pdev != dev)
+		pci_save_state(pdev);
+
+	return NULL;
+}
+
 /**
  * pcibios_set_pcie_slot_reset - Set PCI-E reset state
  * @dev: pci device struct
@@ -682,13 +731,19 @@ int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state stat
 	switch (state) {
 	case pcie_deassert_reset:
 		eeh_ops->reset(pe, EEH_RESET_DEACTIVATE);
+		eeh_unfreeze_pe(pe, false);
 		eeh_pe_state_clear(pe, EEH_PE_CFG_BLOCKED);
+		eeh_pe_dev_traverse(pe, eeh_restore_dev_state, dev);
 		break;
 	case pcie_hot_reset:
+		eeh_ops->set_option(pe, EEH_OPT_FREEZE_PE);
+		eeh_pe_dev_traverse(pe, eeh_disable_and_save_dev_state, dev);
 		eeh_pe_state_mark(pe, EEH_PE_CFG_BLOCKED);
 		eeh_ops->reset(pe, EEH_RESET_HOT);
 		break;
 	case pcie_warm_reset:
+		eeh_ops->set_option(pe, EEH_OPT_FREEZE_PE);
+		eeh_pe_dev_traverse(pe, eeh_disable_and_save_dev_state, dev);
 		eeh_pe_state_mark(pe, EEH_PE_CFG_BLOCKED);
 		eeh_ops->reset(pe, EEH_RESET_FUNDAMENTAL);
 		break;
-- 
1.8.3.2
