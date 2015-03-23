Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D4F01A2ACF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2015 14:03:53 +1100 (AEDT)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C78FC140134
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Mar 2015 14:03:52 +1100 (AEDT)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 23 Mar 2015 13:03:52 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id A9C9F3578054
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Mar 2015 14:03:49 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2N33fVA18677878
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Mar 2015 14:03:49 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2N33FRJ007281
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Mar 2015 14:03:16 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 1/2] PCI: One more parameter to pci_set_pcie_reset_state()
Date: Mon, 23 Mar 2015 14:02:50 +1100
Message-Id: <1427079771-18472-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Brian King <brking@us.ibm.com>, cascardo@linux.vnet.ibm.com,
 bhelgaas@google.com, Frank Haverkamp <haver@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch adds one more parameter ("probe") to pci_set_pcie_reset_state(),
which allows to check if one particular PCI device can be resetted by the
function. The function will be reused to support PCI device specific methods
maintained in pci_dev_reset_methods[] in subsequent patch.

Cc: Brian King <brking@us.ibm.com>
Cc: Frank Haverkamp <haver@linux.vnet.ibm.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
v3: Fix arguments of pci_set_pcie_reset_state() in cxl driver
v2: Reimplemented based on pci_set_pcie_reset_state()
---
 arch/powerpc/kernel/eeh.c       | 14 ++++++++++----
 drivers/misc/cxl/pci.c          |  2 +-
 drivers/misc/genwqe/card_base.c |  9 +++++++--
 drivers/pci/pci.c               | 15 +++++++++------
 drivers/scsi/ipr.c              |  5 +++--
 include/linux/pci.h             |  5 +++--
 6 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index daa68a1..cd85c18 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -726,11 +726,14 @@ static void *eeh_restore_dev_state(void *data, void *userdata)
  * pcibios_set_pcie_slot_reset - Set PCI-E reset state
  * @dev: pci device struct
  * @state: reset state to enter
+ * @probe: check if the device can take the reset
  *
  * Return value:
  * 	0 if success
  */
-int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state state)
+int pcibios_set_pcie_reset_state(struct pci_dev *dev,
+				 enum pcie_reset_state state,
+				 int probe)
 {
 	struct eeh_dev *edev = pci_dev_to_eeh_dev(dev);
 	struct eeh_pe *pe = eeh_dev_to_pe(edev);
@@ -738,9 +741,12 @@ int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state stat
 	if (!pe) {
 		pr_err("%s: No PE found on PCI device %s\n",
 			__func__, pci_name(dev));
-		return -EINVAL;
+		return -ENOTTY;
 	}
 
+	if (probe)
+		return 0;
+
 	switch (state) {
 	case pcie_deassert_reset:
 		eeh_ops->reset(pe, EEH_RESET_DEACTIVATE);
@@ -762,8 +768,8 @@ int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state stat
 		break;
 	default:
 		eeh_pe_state_clear(pe, EEH_PE_CFG_BLOCKED);
-		return -EINVAL;
-	};
+		return -ENOTTY;
+	}
 
 	return 0;
 }
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 1ef0164..3a87bfc 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -789,7 +789,7 @@ int cxl_reset(struct cxl *adapter)
 	/* pcie_warm_reset requests a fundamental pci reset which includes a
 	 * PERST assert/deassert.  PERST triggers a loading of the image
 	 * if "user" or "factory" is selected in sysfs */
-	if ((rc = pci_set_pcie_reset_state(dev, pcie_warm_reset))) {
+	if ((rc = pci_set_pcie_reset_state(dev, pcie_warm_reset, 0))) {
 		dev_err(&dev->dev, "cxl: pcie_warm_reset failed\n");
 		return rc;
 	}
diff --git a/drivers/misc/genwqe/card_base.c b/drivers/misc/genwqe/card_base.c
index 4cf8f82..4871f69 100644
--- a/drivers/misc/genwqe/card_base.c
+++ b/drivers/misc/genwqe/card_base.c
@@ -782,17 +782,22 @@ static int genwqe_pci_fundamental_reset(struct pci_dev *pci_dev)
 {
 	int rc;
 
+	/* Probe if the device can take the reset */
+	rc = pci_set_pcie_reset_state(pci_dev, pcie_warm_reset, 1);
+	if (rc)
+		return rc;
+
 	/*
 	 * lock pci config space access from userspace,
 	 * save state and issue PCIe fundamental reset
 	 */
 	pci_cfg_access_lock(pci_dev);
 	pci_save_state(pci_dev);
-	rc = pci_set_pcie_reset_state(pci_dev, pcie_warm_reset);
+	rc = pci_set_pcie_reset_state(pci_dev, pcie_warm_reset, 0);
 	if (!rc) {
 		/* keep PCIe reset asserted for 250ms */
 		msleep(250);
-		pci_set_pcie_reset_state(pci_dev, pcie_deassert_reset);
+		pci_set_pcie_reset_state(pci_dev, pcie_deassert_reset, 0);
 		/* Wait for 2s to reload flash and train the link */
 		msleep(2000);
 	}
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 81f06e8..8581a5f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1558,28 +1558,31 @@ EXPORT_SYMBOL(pci_disable_device);
  * pcibios_set_pcie_reset_state - set reset state for device dev
  * @dev: the PCIe device reset
  * @state: Reset state to enter into
- *
+ * @probe: Check if the device can take the reset
  *
  * Sets the PCIe reset state for the device. This is the default
  * implementation. Architecture implementations can override this.
  */
 int __weak pcibios_set_pcie_reset_state(struct pci_dev *dev,
-					enum pcie_reset_state state)
+					enum pcie_reset_state state,
+					int probe)
 {
-	return -EINVAL;
+	return -ENOTTY;
 }
 
 /**
  * pci_set_pcie_reset_state - set reset state for device dev
  * @dev: the PCIe device reset
  * @state: Reset state to enter into
- *
+ * @probe: Check if the device can take the reset
  *
  * Sets the PCI reset state for the device.
  */
-int pci_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state state)
+int pci_set_pcie_reset_state(struct pci_dev *dev,
+			     enum pcie_reset_state state,
+			     int probe)
 {
-	return pcibios_set_pcie_reset_state(dev, state);
+	return pcibios_set_pcie_reset_state(dev, state, probe);
 }
 EXPORT_SYMBOL_GPL(pci_set_pcie_reset_state);
 
diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index 9219953..89026f4 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -8317,7 +8317,8 @@ static int ipr_reset_start_bist(struct ipr_cmnd *ipr_cmd)
 static int ipr_reset_slot_reset_done(struct ipr_cmnd *ipr_cmd)
 {
 	ENTER;
-	pci_set_pcie_reset_state(ipr_cmd->ioa_cfg->pdev, pcie_deassert_reset);
+	pci_set_pcie_reset_state(ipr_cmd->ioa_cfg->pdev,
+				 pcie_deassert_reset, 0);
 	ipr_cmd->job_step = ipr_reset_bist_done;
 	ipr_reset_start_timer(ipr_cmd, IPR_WAIT_FOR_BIST_TIMEOUT);
 	LEAVE;
@@ -8339,7 +8340,7 @@ static int ipr_reset_slot_reset(struct ipr_cmnd *ipr_cmd)
 	struct pci_dev *pdev = ioa_cfg->pdev;
 
 	ENTER;
-	pci_set_pcie_reset_state(pdev, pcie_warm_reset);
+	pci_set_pcie_reset_state(pdev, pcie_warm_reset, 0);
 	ipr_cmd->job_step = ipr_reset_slot_reset_done;
 	ipr_reset_start_timer(ipr_cmd, IPR_PCI_RESET_TIMEOUT);
 	LEAVE;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4e1f17d..052ac63 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -960,7 +960,8 @@ extern unsigned int pcibios_max_latency;
 void pci_set_master(struct pci_dev *dev);
 void pci_clear_master(struct pci_dev *dev);
 
-int pci_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state state);
+int pci_set_pcie_reset_state(struct pci_dev *dev,
+			     enum pcie_reset_state state, int probe);
 int pci_set_cacheline_size(struct pci_dev *dev);
 #define HAVE_PCI_SET_MWI
 int __must_check pci_set_mwi(struct pci_dev *dev);
@@ -1648,7 +1649,7 @@ extern unsigned long pci_hotplug_mem_size;
 void pcibios_disable_device(struct pci_dev *dev);
 void pcibios_set_master(struct pci_dev *dev);
 int pcibios_set_pcie_reset_state(struct pci_dev *dev,
-				 enum pcie_reset_state state);
+				 enum pcie_reset_state state, int probe);
 int pcibios_add_device(struct pci_dev *dev);
 void pcibios_release_device(struct pci_dev *dev);
 void pcibios_penalize_isa_irq(int irq, int active);
-- 
1.8.3.2
