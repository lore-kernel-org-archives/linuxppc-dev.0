Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e36.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9B7B52C042B
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Mar 2013 01:18:23 +1100 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 1 Mar 2013 07:18:17 -0700
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 11A7C3E40055
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2013 07:18:04 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r21EHxTi007194
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Mar 2013 07:18:00 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r21EHt9O002813
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Mar 2013 07:17:59 -0700
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 16/22] powerpc/eeh: I/O chip PE reset
Date: Fri,  1 Mar 2013 22:17:14 +0800
Message-Id: <1362147440-14096-17-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1362147440-14096-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1362147440-14096-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch adds the I/O chip backend to do PE reset. For now, we
focus on PCI bus dependent PE. If PHB PE has been put into error
state, the PHB will take complete reset. Besides, the root bridge
will take fundamental or hot reset accordingly if the indicated
PE locates at the toppest of PCI hierarchy tree. Otherwise, the
upstream p2p bridge will take hot reset.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c |  231 ++++++++++++++++++++++++++++-
 1 files changed, 230 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index cf7bb3d..8e29113 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -224,11 +224,240 @@ static int ioda_eeh_get_state(struct eeh_pe *pe, int *state)
 	return result;
 }
 
+static int ioda_eeh_pe_clear(struct eeh_pe *pe)
+{
+	struct pci_controller *hose;
+	struct pnv_phb *phb;
+	u32 pe_no;
+	u8 fstate;
+	u16 pcierr;
+	s64 ret;
+
+	pe_no = pe->addr;
+	hose = pe->phb;
+	phb = pe->phb->private_data;
+
+	/* Clear the EEH error on the PE */
+	ret = opal_pci_eeh_freeze_clear(phb->opal_id,
+			pe_no, OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
+	if (ret) {
+		pr_err("%s: Failed to clear EEH error for "
+		       "PHB#%x-PE#%x, err=%lld\n",
+			__func__, hose->global_number, pe_no, ret);
+		return -EIO;
+	}
+
+	/*
+	 * Read the PE state back and verify that the frozen
+	 * state has been removed.
+	 */
+	ret = opal_pci_eeh_freeze_status(phb->opal_id, pe_no,
+			&fstate, &pcierr, NULL);
+	if (ret) {
+		pr_err("%s: Failed to get EEH status on "
+		       "PHB#%x-PE#%x\n, err=%lld\n",
+			__func__, hose->global_number, pe_no, ret);
+		return -EIO;
+	}
+	if (fstate != OPAL_EEH_STOPPED_NOT_FROZEN) {
+		pr_err("%s: Frozen state not cleared on "
+		       "PHB#%x-PE#%x, sts=%x\n",
+			__func__, hose->global_number, pe_no, fstate);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static s64 ioda_eeh_phb_poll(struct pnv_phb *phb)
+{
+	s64 rc = OPAL_HARDWARE;
+
+	while (1) {
+		rc = opal_pci_poll(phb->opal_id);
+		if (rc <= 0)
+			break;
+	}
+
+	return rc;
+}
+
+static int ioda_eeh_phb_reset(struct pci_controller *hose, int option)
+{
+	struct pnv_phb *phb = hose->private_data;
+	s64 rc = OPAL_HARDWARE;
+
+	pr_debug("%s: Reset PHB#%x, option=%d\n",
+		__func__, hose->global_number, option);
+
+	/* Issue PHB complete reset request */
+	if (option == EEH_RESET_FUNDAMENTAL ||
+	    option == EEH_RESET_HOT)
+		rc = opal_pci_reset(phb->opal_id,
+				OPAL_PHB_COMPLETE,
+				OPAL_ASSERT_RESET);
+	else if (option == EEH_RESET_DEACTIVATE)
+		rc = opal_pci_reset(phb->opal_id,
+				OPAL_PHB_COMPLETE,
+				OPAL_DEASSERT_RESET);
+	if (rc < 0)
+		goto out;
+
+	/*
+	 * Poll state of the PHB until the request is done
+	 * successfully.
+	 */
+	rc = ioda_eeh_phb_poll(phb);
+out:
+	if (rc != OPAL_SUCCESS)
+		return -EIO;
+
+	return 0;
+}
+
+static int ioda_eeh_root_reset(struct pci_controller *hose, int option)
+{
+	struct pnv_phb *phb = hose->private_data;
+	s64 rc = OPAL_SUCCESS;
+
+	pr_debug("%s: Reset PHB#%x, option=%d\n",
+		__func__, hose->global_number, option);
+
+	/*
+	 * During the reset deassert time, we needn't care
+	 * the reset scope because the firmware does nothing
+	 * for fundamental or hot reset during deassert phase.
+	 */
+	if (option == EEH_RESET_FUNDAMENTAL)
+		rc = opal_pci_reset(phb->opal_id,
+				OPAL_PCI_FUNDAMENTAL_RESET,
+				OPAL_ASSERT_RESET);
+	else if (option == EEH_RESET_HOT)
+		rc = opal_pci_reset(phb->opal_id,
+				OPAL_PCI_HOT_RESET,
+				OPAL_ASSERT_RESET);
+	else if (option == EEH_RESET_DEACTIVATE)
+		rc = opal_pci_reset(phb->opal_id,
+				OPAL_PCI_HOT_RESET,
+				OPAL_DEASSERT_RESET);
+	if (rc < 0)
+		goto out;
+
+	/* Poll state of the PHB until the request is done */
+	rc = ioda_eeh_phb_poll(phb);
+out:
+	if (rc != OPAL_SUCCESS)
+		return -EIO;
+
+	return 0;
+}
+
+static int ioda_eeh_bridge_reset(struct pci_controller *hose,
+		struct pci_dev *dev, int option)
+{
+	u16 ctrl;
+
+	pr_debug("%s: Reset device %04x:%02x:%02x.%01x with option %d\n",
+		__func__, hose->global_number, dev->bus->number,
+		PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn), option);
+
+	switch (option) {
+	case EEH_RESET_FUNDAMENTAL:
+	case EEH_RESET_HOT:
+		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &ctrl);
+		ctrl |= PCI_BRIDGE_CTL_BUS_RESET;
+		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
+		break;
+	case EEH_RESET_DEACTIVATE:
+		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &ctrl);
+		ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
+		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
+		break;
+	}
+
+	return 0;
+}
+
+/**
+ * ioda_eeh_reset - Reset the indicated PE
+ * @pe: EEH PE
+ * @option: reset option
+ *
+ * Do reset on the indicated PE. For PCI bus sensitive PE,
+ * we need to reset the parent p2p bridge. The PHB has to
+ * be reinitialized if the p2p bridge is root bridge. For
+ * PCI device sensitive PE, we will try to reset the device
+ * through FLR. For now, we don't have OPAL APIs to do HARD
+ * reset yet, so all reset would be SOFT (HOT) reset.
+ */
+static int ioda_eeh_reset(struct eeh_pe *pe, int option)
+{
+	struct pci_controller *hose = pe->phb;
+	struct eeh_dev *edev;
+	struct pci_dev *dev;
+	int ret;
+
+	/*
+	 * Anyway, we have to clear the problematic state for the
+	 * corresponding PE. However, we needn't do it if the PE
+	 * is PHB associated. That means the PHB is having fatal
+	 * errors and it needs reset. Further more, the AIB interface
+	 * isn't reliable any more.
+	 */
+	if (!(pe->type & EEH_PE_PHB) &&
+	    (option == EEH_RESET_HOT ||
+	    option == EEH_RESET_FUNDAMENTAL)) {
+		ret = ioda_eeh_pe_clear(pe);
+		if (ret)
+			return -EIO;
+	}
+
+	/*
+	 * The rules applied to reset, either fundamental or hot reset:
+	 *
+	 * We always reset the direct upstream bridge of the PE. If the
+	 * direct upstream bridge isn't root bridge, we always take hot
+	 * reset no matter what option (fundamental or hot) is. Otherwise,
+	 * we should do the reset according to the required option.
+	 */
+	if (pe->type & EEH_PE_PHB) {
+		ret = ioda_eeh_phb_reset(hose, option);
+	} else {
+		if (pe->type & EEH_PE_DEVICE) {
+			/*
+			 * If it's device PE, we didn't refer to the parent
+			 * PCI bus yet. So we have to figure it out indirectly.
+			 */
+			edev = list_first_entry(&pe->edevs,
+					struct eeh_dev, list);
+			dev = eeh_dev_to_pci_dev(edev);
+			dev = dev->bus->self;
+		} else {
+			/*
+			 * If it's bus PE, the parent PCI bus is already there
+			 * and just pick it up.
+			 */
+			dev = pe->bus->self;
+		}
+
+		/*
+		 * Do reset based on the fact that the direct upstream bridge
+		 * is root bridge (port) or not.
+		 */
+		if (dev->bus->number == 0)
+			ret = ioda_eeh_root_reset(hose, option);
+		else
+			ret = ioda_eeh_bridge_reset(hose, dev, option);
+	}
+
+	return ret;
+}
+
 struct pnv_eeh_ops ioda_eeh_ops = {
 	.post_init		= ioda_eeh_post_init,
 	.set_option		= ioda_eeh_set_option,
 	.get_state		= ioda_eeh_get_state,
-	.reset			= NULL,
+	.reset			= ioda_eeh_reset,
 	.get_log		= NULL,
 	.configure_bridge	= NULL
 };
-- 
1.7.5.4
