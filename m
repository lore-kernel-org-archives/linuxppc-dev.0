Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D2FEF1A0BD6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 14:47:26 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5DF8B140271
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 14:47:26 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 16 Feb 2015 13:47:26 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 333D6357804C
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 14:47:24 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1G3lGrS38797414
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 14:47:24 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1G3kou8021594
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 14:46:50 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 09/10] powerpc/powernv: Drop PHB operation reset()
Date: Mon, 16 Feb 2015 14:45:47 +1100
Message-Id: <1424058348-28951-10-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1424058348-28951-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1424058348-28951-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch drops PHB EEH operation reset() and merges its logic to
eeh_ops::reset().

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c    | 235 ---------------------------
 arch/powerpc/platforms/powernv/eeh-powernv.c | 225 ++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/pci-ioda.c    |   4 +-
 arch/powerpc/platforms/powernv/pci.h         |   3 +-
 4 files changed, 223 insertions(+), 244 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 94d94b4..9fcfc45 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -34,240 +34,5 @@
 #include "powernv.h"
 #include "pci.h"
 
-static s64 ioda_eeh_phb_poll(struct pnv_phb *phb)
-{
-	s64 rc = OPAL_HARDWARE;
-
-	while (1) {
-		rc = opal_pci_poll(phb->opal_id);
-		if (rc <= 0)
-			break;
-
-		if (system_state < SYSTEM_RUNNING)
-			udelay(1000 * rc);
-		else
-			msleep(rc);
-	}
-
-	return rc;
-}
-
-int ioda_eeh_phb_reset(struct pci_controller *hose, int option)
-{
-	struct pnv_phb *phb = hose->private_data;
-	s64 rc = OPAL_HARDWARE;
-
-	pr_debug("%s: Reset PHB#%x, option=%d\n",
-		 __func__, hose->global_number, option);
-
-	/* Issue PHB complete reset request */
-	if (option == EEH_RESET_FUNDAMENTAL ||
-	    option == EEH_RESET_HOT)
-		rc = opal_pci_reset(phb->opal_id,
-				OPAL_RESET_PHB_COMPLETE,
-				OPAL_ASSERT_RESET);
-	else if (option == EEH_RESET_DEACTIVATE)
-		rc = opal_pci_reset(phb->opal_id,
-				OPAL_RESET_PHB_COMPLETE,
-				OPAL_DEASSERT_RESET);
-	if (rc < 0)
-		goto out;
-
-	/*
-	 * Poll state of the PHB until the request is done
-	 * successfully. The PHB reset is usually PHB complete
-	 * reset followed by hot reset on root bus. So we also
-	 * need the PCI bus settlement delay.
-	 */
-	rc = ioda_eeh_phb_poll(phb);
-	if (option == EEH_RESET_DEACTIVATE) {
-		if (system_state < SYSTEM_RUNNING)
-			udelay(1000 * EEH_PE_RST_SETTLE_TIME);
-		else
-			msleep(EEH_PE_RST_SETTLE_TIME);
-	}
-out:
-	if (rc != OPAL_SUCCESS)
-		return -EIO;
-
-	return 0;
-}
-
-static int ioda_eeh_root_reset(struct pci_controller *hose, int option)
-{
-	struct pnv_phb *phb = hose->private_data;
-	s64 rc = OPAL_SUCCESS;
-
-	pr_debug("%s: Reset PHB#%x, option=%d\n",
-		 __func__, hose->global_number, option);
-
-	/*
-	 * During the reset deassert time, we needn't care
-	 * the reset scope because the firmware does nothing
-	 * for fundamental or hot reset during deassert phase.
-	 */
-	if (option == EEH_RESET_FUNDAMENTAL)
-		rc = opal_pci_reset(phb->opal_id,
-				OPAL_RESET_PCI_FUNDAMENTAL,
-				OPAL_ASSERT_RESET);
-	else if (option == EEH_RESET_HOT)
-		rc = opal_pci_reset(phb->opal_id,
-				OPAL_RESET_PCI_HOT,
-				OPAL_ASSERT_RESET);
-	else if (option == EEH_RESET_DEACTIVATE)
-		rc = opal_pci_reset(phb->opal_id,
-				OPAL_RESET_PCI_HOT,
-				OPAL_DEASSERT_RESET);
-	if (rc < 0)
-		goto out;
-
-	/* Poll state of the PHB until the request is done */
-	rc = ioda_eeh_phb_poll(phb);
-	if (option == EEH_RESET_DEACTIVATE)
-		msleep(EEH_PE_RST_SETTLE_TIME);
-out:
-	if (rc != OPAL_SUCCESS)
-		return -EIO;
-
-	return 0;
-}
-
-static int ioda_eeh_bridge_reset(struct pci_dev *dev, int option)
-
-{
-	struct device_node *dn = pci_device_to_OF_node(dev);
-	struct eeh_dev *edev = of_node_to_eeh_dev(dn);
-	int aer = edev ? edev->aer_cap : 0;
-	u32 ctrl;
-
-	pr_debug("%s: Reset PCI bus %04x:%02x with option %d\n",
-		 __func__, pci_domain_nr(dev->bus),
-		 dev->bus->number, option);
-
-	switch (option) {
-	case EEH_RESET_FUNDAMENTAL:
-	case EEH_RESET_HOT:
-		/* Don't report linkDown event */
-		if (aer) {
-			eeh_ops->read_config(dn, aer + PCI_ERR_UNCOR_MASK,
-					     4, &ctrl);
-			ctrl |= PCI_ERR_UNC_SURPDN;
-                        eeh_ops->write_config(dn, aer + PCI_ERR_UNCOR_MASK,
-					      4, ctrl);
-                }
-
-		eeh_ops->read_config(dn, PCI_BRIDGE_CONTROL, 2, &ctrl);
-		ctrl |= PCI_BRIDGE_CTL_BUS_RESET;
-		eeh_ops->write_config(dn, PCI_BRIDGE_CONTROL, 2, ctrl);
-		msleep(EEH_PE_RST_HOLD_TIME);
-
-		break;
-	case EEH_RESET_DEACTIVATE:
-		eeh_ops->read_config(dn, PCI_BRIDGE_CONTROL, 2, &ctrl);
-		ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
-		eeh_ops->write_config(dn, PCI_BRIDGE_CONTROL, 2, ctrl);
-		msleep(EEH_PE_RST_SETTLE_TIME);
-
-		/* Continue reporting linkDown event */
-		if (aer) {
-			eeh_ops->read_config(dn, aer + PCI_ERR_UNCOR_MASK,
-					     4, &ctrl);
-			ctrl &= ~PCI_ERR_UNC_SURPDN;
-			eeh_ops->write_config(dn, aer + PCI_ERR_UNCOR_MASK,
-					      4, ctrl);
-		}
-
-		break;
-	}
-
-	return 0;
-}
-
-void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
-{
-	struct pci_controller *hose;
-
-	if (pci_is_root_bus(dev->bus)) {
-		hose = pci_bus_to_host(dev->bus);
-		ioda_eeh_root_reset(hose, EEH_RESET_HOT);
-		ioda_eeh_root_reset(hose, EEH_RESET_DEACTIVATE);
-	} else {
-		ioda_eeh_bridge_reset(dev, EEH_RESET_HOT);
-		ioda_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE);
-	}
-}
-
-/**
- * ioda_eeh_reset - Reset the indicated PE
- * @pe: EEH PE
- * @option: reset option
- *
- * Do reset on the indicated PE. For PCI bus sensitive PE,
- * we need to reset the parent p2p bridge. The PHB has to
- * be reinitialized if the p2p bridge is root bridge. For
- * PCI device sensitive PE, we will try to reset the device
- * through FLR. For now, we don't have OPAL APIs to do HARD
- * reset yet, so all reset would be SOFT (HOT) reset.
- */
-static int ioda_eeh_reset(struct eeh_pe *pe, int option)
-{
-	struct pci_controller *hose = pe->phb;
-	struct pci_bus *bus;
-	int ret;
-
-	/*
-	 * For PHB reset, we always have complete reset. For those PEs whose
-	 * primary bus derived from root complex (root bus) or root port
-	 * (usually bus#1), we apply hot or fundamental reset on the root port.
-	 * For other PEs, we always have hot reset on the PE primary bus.
-	 *
-	 * Here, we have different design to pHyp, which always clear the
-	 * frozen state during PE reset. However, the good idea here from
-	 * benh is to keep frozen state before we get PE reset done completely
-	 * (until BAR restore). With the frozen state, HW drops illegal IO
-	 * or MMIO access, which can incur recrusive frozen PE during PE
-	 * reset. The side effect is that EEH core has to clear the frozen
-	 * state explicitly after BAR restore.
-	 */
-	if (pe->type & EEH_PE_PHB) {
-		ret = ioda_eeh_phb_reset(hose, option);
-	} else {
-		struct pnv_phb *phb;
-		s64 rc;
-
-		/*
-		 * The frozen PE might be caused by PAPR error injection
-		 * registers, which are expected to be cleared after hitting
-		 * frozen PE as stated in the hardware spec. Unfortunately,
-		 * that's not true on P7IOC. So we have to clear it manually
-		 * to avoid recursive EEH errors during recovery.
-		 */
-		phb = hose->private_data;
-		if (phb->model == PNV_PHB_MODEL_P7IOC &&
-		    (option == EEH_RESET_HOT ||
-		    option == EEH_RESET_FUNDAMENTAL)) {
-			rc = opal_pci_reset(phb->opal_id,
-					    OPAL_RESET_PHB_ERROR,
-					    OPAL_ASSERT_RESET);
-			if (rc != OPAL_SUCCESS) {
-				pr_warn("%s: Failure %lld clearing "
-					"error injection registers\n",
-					__func__, rc);
-				return -EIO;
-			}
-		}
-
-		bus = eeh_pe_bus_get(pe);
-		if (pci_is_root_bus(bus) ||
-		    pci_is_root_bus(bus->parent))
-			ret = ioda_eeh_root_reset(hose, option);
-		else
-			ret = ioda_eeh_bridge_reset(bus->self, option);
-	}
-
-	return ret;
-}
-
 struct pnv_eeh_ops ioda_eeh_ops = {
-	.reset			= ioda_eeh_reset,
 };
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index e51ac2d..ede6906 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -665,21 +665,236 @@ static int pnv_eeh_get_state(struct eeh_pe *pe, int *delay)
 	return ret;
 }
 
+static s64 pnv_eeh_phb_poll(struct pnv_phb *phb)
+{
+	s64 rc = OPAL_HARDWARE;
+
+	while (1) {
+		rc = opal_pci_poll(phb->opal_id);
+		if (rc <= 0)
+			break;
+
+		if (system_state < SYSTEM_RUNNING)
+			udelay(1000 * rc);
+		else
+			msleep(rc);
+	}
+
+	return rc;
+}
+
+int pnv_eeh_phb_reset(struct pci_controller *hose, int option)
+{
+	struct pnv_phb *phb = hose->private_data;
+	s64 rc = OPAL_HARDWARE;
+
+	pr_debug("%s: Reset PHB#%x, option=%d\n",
+		 __func__, hose->global_number, option);
+
+	/* Issue PHB complete reset request */
+	if (option == EEH_RESET_FUNDAMENTAL ||
+	    option == EEH_RESET_HOT)
+		rc = opal_pci_reset(phb->opal_id,
+				    OPAL_RESET_PHB_COMPLETE,
+				    OPAL_ASSERT_RESET);
+	else if (option == EEH_RESET_DEACTIVATE)
+		rc = opal_pci_reset(phb->opal_id,
+				    OPAL_RESET_PHB_COMPLETE,
+				    OPAL_DEASSERT_RESET);
+	if (rc < 0)
+		goto out;
+
+	/*
+	 * Poll state of the PHB until the request is done
+	 * successfully. The PHB reset is usually PHB complete
+	 * reset followed by hot reset on root bus. So we also
+	 * need the PCI bus settlement delay.
+	 */
+	rc = pnv_eeh_phb_poll(phb);
+	if (option == EEH_RESET_DEACTIVATE) {
+		if (system_state < SYSTEM_RUNNING)
+			udelay(1000 * EEH_PE_RST_SETTLE_TIME);
+		else
+			msleep(EEH_PE_RST_SETTLE_TIME);
+	}
+out:
+	if (rc != OPAL_SUCCESS)
+		return -EIO;
+
+	return 0;
+}
+
+static int pnv_eeh_root_reset(struct pci_controller *hose, int option)
+{
+	struct pnv_phb *phb = hose->private_data;
+	s64 rc = OPAL_HARDWARE;
+
+	pr_debug("%s: Reset PHB#%x, option=%d\n",
+		 __func__, hose->global_number, option);
+
+	/*
+	 * During the reset deassert time, we needn't care
+	 * the reset scope because the firmware does nothing
+	 * for fundamental or hot reset during deassert phase.
+	 */
+	if (option == EEH_RESET_FUNDAMENTAL)
+		rc = opal_pci_reset(phb->opal_id,
+				    OPAL_RESET_PCI_FUNDAMENTAL,
+				    OPAL_ASSERT_RESET);
+	else if (option == EEH_RESET_HOT)
+		rc = opal_pci_reset(phb->opal_id,
+				    OPAL_RESET_PCI_HOT,
+				    OPAL_ASSERT_RESET);
+	else if (option == EEH_RESET_DEACTIVATE)
+		rc = opal_pci_reset(phb->opal_id,
+				    OPAL_RESET_PCI_HOT,
+				    OPAL_DEASSERT_RESET);
+	if (rc < 0)
+		goto out;
+
+	/* Poll state of the PHB until the request is done */
+	rc = pnv_eeh_phb_poll(phb);
+	if (option == EEH_RESET_DEACTIVATE)
+		msleep(EEH_PE_RST_SETTLE_TIME);
+out:
+	if (rc != OPAL_SUCCESS)
+		return -EIO;
+
+	return 0;
+}
+
+static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
+{
+	struct device_node *dn = pci_device_to_OF_node(dev);
+	struct eeh_dev *edev = of_node_to_eeh_dev(dn);
+	int aer = edev ? edev->aer_cap : 0;
+	u32 ctrl;
+
+	pr_debug("%s: Reset PCI bus %04x:%02x with option %d\n",
+		 __func__, pci_domain_nr(dev->bus),
+		 dev->bus->number, option);
+
+	switch (option) {
+	case EEH_RESET_FUNDAMENTAL:
+	case EEH_RESET_HOT:
+		/* Don't report linkDown event */
+		if (aer) {
+			eeh_ops->read_config(dn, aer + PCI_ERR_UNCOR_MASK,
+					     4, &ctrl);
+			ctrl |= PCI_ERR_UNC_SURPDN;
+			eeh_ops->write_config(dn, aer + PCI_ERR_UNCOR_MASK,
+					      4, ctrl);
+		}
+
+		eeh_ops->read_config(dn, PCI_BRIDGE_CONTROL, 2, &ctrl);
+		ctrl |= PCI_BRIDGE_CTL_BUS_RESET;
+		eeh_ops->write_config(dn, PCI_BRIDGE_CONTROL, 2, ctrl);
+
+		msleep(EEH_PE_RST_HOLD_TIME);
+		break;
+	case EEH_RESET_DEACTIVATE:
+		eeh_ops->read_config(dn, PCI_BRIDGE_CONTROL, 2, &ctrl);
+		ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
+		eeh_ops->write_config(dn, PCI_BRIDGE_CONTROL, 2, ctrl);
+
+		msleep(EEH_PE_RST_SETTLE_TIME);
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
+		break;
+	}
+
+	return 0;
+}
+
+void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
+{
+	struct pci_controller *hose;
+
+	if (pci_is_root_bus(dev->bus)) {
+		hose = pci_bus_to_host(dev->bus);
+		pnv_eeh_root_reset(hose, EEH_RESET_HOT);
+		pnv_eeh_root_reset(hose, EEH_RESET_DEACTIVATE);
+	} else {
+		pnv_eeh_bridge_reset(dev, EEH_RESET_HOT);
+		pnv_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE);
+	}
+}
+
 /**
  * pnv_eeh_reset - Reset the specified PE
  * @pe: EEH PE
  * @option: reset option
  *
- * Reset the specified PE
+ * Do reset on the indicated PE. For PCI bus sensitive PE,
+ * we need to reset the parent p2p bridge. The PHB has to
+ * be reinitialized if the p2p bridge is root bridge. For
+ * PCI device sensitive PE, we will try to reset the device
+ * through FLR. For now, we don't have OPAL APIs to do HARD
+ * reset yet, so all reset would be SOFT (HOT) reset.
  */
 static int pnv_eeh_reset(struct eeh_pe *pe, int option)
 {
 	struct pci_controller *hose = pe->phb;
-	struct pnv_phb *phb = hose->private_data;
-	int ret = -EEXIST;
+	struct pci_bus *bus;
+	int ret;
+
+	/*
+	 * For PHB reset, we always have complete reset. For those PEs whose
+	 * primary bus derived from root complex (root bus) or root port
+	 * (usually bus#1), we apply hot or fundamental reset on the root port.
+	 * For other PEs, we always have hot reset on the PE primary bus.
+	 *
+	 * Here, we have different design to pHyp, which always clear the
+	 * frozen state during PE reset. However, the good idea here from
+	 * benh is to keep frozen state before we get PE reset done completely
+	 * (until BAR restore). With the frozen state, HW drops illegal IO
+	 * or MMIO access, which can incur recrusive frozen PE during PE
+	 * reset. The side effect is that EEH core has to clear the frozen
+	 * state explicitly after BAR restore.
+	 */
+	if (pe->type & EEH_PE_PHB) {
+		ret = pnv_eeh_phb_reset(hose, option);
+	} else {
+		struct pnv_phb *phb;
+		s64 rc;
 
-	if (phb->eeh_ops && phb->eeh_ops->reset)
-		ret = phb->eeh_ops->reset(pe, option);
+		/*
+		 * The frozen PE might be caused by PAPR error injection
+		 * registers, which are expected to be cleared after hitting
+		 * frozen PE as stated in the hardware spec. Unfortunately,
+		 * that's not true on P7IOC. So we have to clear it manually
+		 * to avoid recursive EEH errors during recovery.
+		 */
+		phb = hose->private_data;
+		if (phb->model == PNV_PHB_MODEL_P7IOC &&
+		    (option == EEH_RESET_HOT ||
+		    option == EEH_RESET_FUNDAMENTAL)) {
+			rc = opal_pci_reset(phb->opal_id,
+					    OPAL_RESET_PHB_ERROR,
+					    OPAL_ASSERT_RESET);
+			if (rc != OPAL_SUCCESS) {
+				pr_warn("%s: Failure %lld clearing "
+					"error injection registers\n",
+					__func__, rc);
+				return -EIO;
+			}
+		}
+
+		bus = eeh_pe_bus_get(pe);
+		if (pci_is_root_bus(bus) ||
+			pci_is_root_bus(bus->parent))
+			ret = pnv_eeh_root_reset(hose, option);
+		else
+			ret = pnv_eeh_bridge_reset(bus->self, option);
+	}
 
 	return ret;
 }
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 6c9ff2b..4e21596 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2121,8 +2121,8 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	 */
 	if (is_kdump_kernel()) {
 		pr_info("  Issue PHB reset ...\n");
-		ioda_eeh_phb_reset(hose, EEH_RESET_FUNDAMENTAL);
-		ioda_eeh_phb_reset(hose, EEH_RESET_DEACTIVATE);
+		pnv_eeh_phb_reset(hose, EEH_RESET_FUNDAMENTAL);
+		pnv_eeh_phb_reset(hose, EEH_RESET_DEACTIVATE);
 	}
 
 	/* Remove M64 resource if we can't configure it successfully */
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 5275d89..39f2ca3 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -78,7 +78,6 @@ struct pnv_ioda_pe {
 /* IOC dependent EEH operations */
 #ifdef CONFIG_EEH
 struct pnv_eeh_ops {
-	int (*reset)(struct eeh_pe *pe, int option);
 };
 #endif /* CONFIG_EEH */
 
@@ -223,6 +222,6 @@ extern void pnv_pci_init_ioda2_phb(struct device_node *np);
 extern void pnv_pci_ioda_tce_invalidate(struct iommu_table *tbl,
 					__be64 *startp, __be64 *endp, bool rm);
 extern void pnv_pci_reset_secondary_bus(struct pci_dev *dev);
-extern int ioda_eeh_phb_reset(struct pci_controller *hose, int option);
+extern int pnv_eeh_phb_reset(struct pci_controller *hose, int option);
 
 #endif /* __POWERNV_PCI_H */
-- 
1.8.3.2
