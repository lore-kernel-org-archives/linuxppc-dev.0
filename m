Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E8FDF1A00FB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Sep 2014 11:09:06 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 23 Sep 2014 11:09:06 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 6CE483578054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Sep 2014 11:09:04 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8N1AfpP15007798
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Sep 2014 11:10:41 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8N1932S032674
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Sep 2014 11:09:03 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] powerpc/eeh: Emulate EEH recovery for VFIO devices
Date: Tue, 23 Sep 2014 11:09:04 +1000
Message-Id: <1411434544-10025-3-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1411434544-10025-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1411434544-10025-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When enabling EEH functionality on passed through devices (PE)
with VFIO, the devices in the PE would be removed permanently
from guest side. In that case, the PE remains frozen state.
When returning PE to host, or restarting the guest again, we
had mechanism unfreezing the PE by clearing PESTA/B frozen
bits. However, that's not enough for some adapters, which are
indicated as following "lspci" shows. Those adapters require
hot reset on the parent bus to bring their firmware back to
workable state. Otherwise, those adaptrs won't be operative
and the host (for returning case) or the guest will fail to
load the drivers for those adapters without exception.

0000:01:00.0 Ethernet controller: Emulex Corporation OneConnect \
             10Gb NIC (be3) (rev 02)
0000:01:00.0 0200: 19a2:0710 (rev 02)
0001:03:00.0 Ethernet controller: Emulex Corporation OneConnect \
             NIC (Lancer) (rev 10)
0001:03:00.0 0200: 10df:e220 (rev 10)

The patch adds mechanism to emulate EEH recovery (for hot reset
on parent PCI bus) on 3 gates to fix the issue: open/release one
adapter of the PE, enable EEH functionality on one adapter of the
PE.

Reported-by:  Murilo Fossa Vicentini <muvic@br.ibm.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h   |  1 +
 arch/powerpc/kernel/eeh.c        | 68 +++++++++++++++++++++++++++++-
 arch/powerpc/kernel/eeh_driver.c | 90 ++++++++++++++++++++++++++++++++++++++--
 3 files changed, 153 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 9bf4a5e..79c1952 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -282,6 +282,7 @@ void eeh_add_device_tree_late(struct pci_bus *);
 void eeh_add_sysfs_files(struct pci_bus *);
 void eeh_remove_device(struct pci_dev *);
 int eeh_unfreeze_pe(struct eeh_pe *pe, bool sw_state);
+int eeh_pe_reset_and_recover(struct eeh_pe *pe);
 int eeh_dev_open(struct pci_dev *pdev);
 void eeh_dev_release(struct pci_dev *pdev);
 struct eeh_pe *eeh_iommu_group_to_pe(struct iommu_group *group);
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 059aa00..6c88d781 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1193,6 +1193,69 @@ int eeh_unfreeze_pe(struct eeh_pe *pe, bool sw_state)
 	return ret;
 }
 
+
+static struct pci_device_id eeh_reset_ids[] = {
+	{ PCI_DEVICE(0x19a2, 0x0710) },	/* Emulex, BE     */
+	{ PCI_DEVICE(0x10df, 0xe220) },	/* Emulex, Lancer */
+	{ 0 }
+};
+
+static int eeh_pe_change_owner(struct eeh_pe *pe)
+{
+	struct eeh_dev *edev, *tmp;
+	struct pci_dev *pdev;
+	struct pci_device_id *id;
+	int flags, ret;
+	bool need_reset = false;
+
+	/* Check PE state */
+	flags = (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE);
+	ret = eeh_ops->get_state(pe, NULL);
+	if (ret < 0 || ret == EEH_STATE_NOT_SUPPORT)
+		return 0;
+
+	/* Unfrozen PE, nothing to do */
+	if ((ret & flags) == flags)
+		return 0;
+
+	/* Frozen PE, check if it needs PE level reset */
+	eeh_pe_for_each_dev(pe, edev, tmp) {
+		pdev = eeh_dev_to_pci_dev(edev);
+		if (!pdev)
+			continue;
+
+		for (id = &eeh_reset_ids[0]; id->vendor != 0; id++) {
+			if (id->vendor != PCI_ANY_ID &&
+			    id->vendor != pdev->vendor)
+				continue;
+			if (id->device != PCI_ANY_ID &&
+			    id->device != pdev->device)
+				continue;
+			if (id->subvendor != PCI_ANY_ID &&
+			    id->subvendor != pdev->subsystem_vendor)
+				continue;
+			if (id->subdevice != PCI_ANY_ID &&
+			    id->subdevice != pdev->subsystem_device)
+				continue;
+
+			need_reset = true;
+			break;
+		}
+
+		/* Any one device in the PE requires PE reset,
+		 * we should do that.
+		 */
+		if (need_reset)
+			break;
+	}
+
+	/* Unfroze the PE if reset isn't required */
+	if (!need_reset)
+		return eeh_unfreeze_pe(pe, true);
+
+	return eeh_pe_reset_and_recover(pe);
+}
+
 /**
  * eeh_dev_open - Increase count of pass through devices for PE
  * @pdev: PCI device
@@ -1224,7 +1287,7 @@ int eeh_dev_open(struct pci_dev *pdev)
 	 * in frozen PE won't work properly. Clear the frozen state
 	 * in advance.
 	 */
-	ret = eeh_unfreeze_pe(edev->pe, true);
+	ret = eeh_pe_change_owner(edev->pe);
 	if (ret)
 		goto out;
 
@@ -1265,6 +1328,7 @@ void eeh_dev_release(struct pci_dev *pdev)
 	/* Decrease PE's pass through count */
 	atomic_dec(&edev->pe->pass_dev_cnt);
 	WARN_ON(atomic_read(&edev->pe->pass_dev_cnt) < 0);
+	eeh_pe_change_owner(edev->pe);
 out:
 	mutex_unlock(&eeh_dev_mutex);
 }
@@ -1345,7 +1409,7 @@ int eeh_pe_set_option(struct eeh_pe *pe, int option)
 	switch (option) {
 	case EEH_OPT_ENABLE:
 		if (eeh_enabled()) {
-			ret = eeh_unfreeze_pe(pe, true);
+			ret = eeh_pe_change_owner(pe);
 			break;
 		}
 		ret = -EIO;
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 948e6f9..3fd514f 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -180,6 +180,22 @@ static bool eeh_dev_removed(struct eeh_dev *edev)
 	return false;
 }
 
+static void *eeh_dev_save_state(void *data, void *userdata)
+{
+	struct eeh_dev *edev = data;
+	struct pci_dev *pdev;
+
+	if (!edev)
+		return NULL;
+
+	pdev = eeh_dev_to_pci_dev(edev);
+	if (!pdev)
+		return NULL;
+
+	pci_save_state(pdev);
+	return NULL;
+}
+
 /**
  * eeh_report_error - Report pci error to each device driver
  * @data: eeh device
@@ -303,6 +319,22 @@ static void *eeh_report_reset(void *data, void *userdata)
 	return NULL;
 }
 
+static void *eeh_dev_restore_state(void *data, void *userdata)
+{
+	struct eeh_dev *edev = data;
+	struct pci_dev *pdev;
+
+	if (!edev)
+		return NULL;
+
+	pdev = eeh_dev_to_pci_dev(edev);
+	if (!pdev)
+		return NULL;
+
+	pci_restore_state(pdev);
+	return NULL;
+}
+
 /**
  * eeh_report_resume - Tell device to resume normal operations
  * @data: eeh device
@@ -450,10 +482,11 @@ static void *eeh_pe_detach_dev(void *data, void *userdata)
 static void *__eeh_clear_pe_frozen_state(void *data, void *flag)
 {
 	struct eeh_pe *pe = (struct eeh_pe *)data;
+	bool *clear_sw_state = flag;
 	int i, rc = 1;
 
 	for (i = 0; rc && i < 3; i++)
-		rc = eeh_unfreeze_pe(pe, false);
+		rc = eeh_unfreeze_pe(pe, clear_sw_state);
 
 	/* Stop immediately on any errors */
 	if (rc) {
@@ -465,17 +498,66 @@ static void *__eeh_clear_pe_frozen_state(void *data, void *flag)
 	return NULL;
 }
 
-static int eeh_clear_pe_frozen_state(struct eeh_pe *pe)
+static int eeh_clear_pe_frozen_state(struct eeh_pe *pe,
+				     bool clear_sw_state)
 {
 	void *rc;
 
-	rc = eeh_pe_traverse(pe, __eeh_clear_pe_frozen_state, NULL);
+	rc = eeh_pe_traverse(pe, __eeh_clear_pe_frozen_state, &clear_sw_state);
 	if (!rc)
 		eeh_pe_state_clear(pe, EEH_PE_ISOLATED);
 
 	return rc ? -EIO : 0;
 }
 
+int eeh_pe_reset_and_recover(struct eeh_pe *pe)
+{
+	int result, ret;
+
+	/* Bail if the PE is being recovered */
+	if (pe->state & EEH_PE_RECOVERING)
+		return 0;
+
+	/* Put the PE into recovery mode */
+	eeh_pe_state_mark(pe, EEH_PE_RECOVERING);
+
+	/* Save states */
+	eeh_pe_dev_traverse(pe, eeh_dev_save_state, NULL);
+
+	/* Report error */
+	eeh_pe_dev_traverse(pe, eeh_report_error, &result);
+
+	/* Issue reset */
+	eeh_pe_state_mark(pe, EEH_PE_RESET);
+	ret = eeh_reset_pe(pe);
+	if (ret) {
+		eeh_pe_state_clear(pe, EEH_PE_RECOVERING | EEH_PE_RESET);
+		return ret;
+	}
+	eeh_pe_state_clear(pe, EEH_PE_RESET);
+
+	/* Unfreeze the PE */
+	ret = eeh_clear_pe_frozen_state(pe, true);
+	if (ret) {
+		eeh_pe_state_clear(pe, EEH_PE_RECOVERING);
+		return ret;
+	}
+
+	/* Notify completion of reset */
+	eeh_pe_dev_traverse(pe, eeh_report_reset, &result);
+
+	/* Restore device state */
+	eeh_pe_dev_traverse(pe, eeh_dev_restore_state, NULL);
+
+	/* Resume */
+	eeh_pe_dev_traverse(pe, eeh_report_resume, NULL);
+
+	/* Clear recovery mode */
+	eeh_pe_state_clear(pe, EEH_PE_RECOVERING);
+
+	return 0;
+}
+
 /**
  * eeh_reset_device - Perform actual reset of a pci slot
  * @pe: EEH PE
@@ -534,7 +616,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
 	eeh_pe_state_clear(pe, EEH_PE_RESET);
 
 	/* Clear frozen state */
-	rc = eeh_clear_pe_frozen_state(pe);
+	rc = eeh_clear_pe_frozen_state(pe, false);
 	if (rc)
 		return rc;
 
-- 
1.8.3.2
