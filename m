Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4189E1A1BD4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 11:43:09 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Tue, 19 May 2015 11:43:08 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8F9DF3578053
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 11:43:05 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4J1gvfb26738700
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 11:43:05 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4J1gWJu006281
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 11:42:33 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, bhelgaas@google.com
Subject: [PATCH V6 09/10] powerpc/eeh: Support error recovery for VF PE
Date: Tue, 19 May 2015 09:35:11 +0800
Message-Id: <1431999312-10517-10-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1431999312-10517-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1431999312-10517-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, Wei Yang <weiyang@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Different from PCI bus dependent PE, PE for VFs doesn't have the
primary bus, on which the PCI hotplug is implemented. The patch
supports error recovery, especially the PCI hotplug for VF's PE.
The hotplug on VF's PE is implemented based on VFs, instead of
PCI bus any more.

[gwshan: changelog and code refactoring]
Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h   |    1 +
 arch/powerpc/kernel/eeh.c        |    8 +++
 arch/powerpc/kernel/eeh_driver.c |  100 ++++++++++++++++++++++++++++++--------
 arch/powerpc/kernel/eeh_pe.c     |    3 +-
 4 files changed, 90 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 3d64cf3..d24382c 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -140,6 +140,7 @@ struct eeh_dev {
 	struct pci_controller *phb;	/* Associated PHB		*/
 	struct pci_dn *pdn;		/* Associated PCI device node	*/
 	struct pci_dev *pdev;		/* Associated PCI device	*/
+	int    in_error;		/* Error flag for eeh_dev	*/
 	struct pci_dev *physfn;		/* Associated PF PORT		*/
 	struct pci_bus *bus;		/* PCI bus for partial hotplug	*/
 };
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 9ee61d1..1207547 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1229,6 +1229,14 @@ void eeh_remove_device(struct pci_dev *dev)
 	 * from the parent PE during the BAR resotre.
 	 */
 	edev->pdev = NULL;
+
+	/*
+	 * The flag "in_error" is used to trace EEH devices for VFs
+	 * in error state or not. It's set in eeh_report_error(). If
+	 * it's not set, eeh_report_{reset,resume}() won't be called
+	 * for the VF EEH device.
+	 */
+	edev->in_error = 0;
 	dev->dev.archdata.edev = NULL;
 	if (!(edev->pe->state & EEH_PE_KEEP))
 		eeh_rmv_from_parent_pe(edev);
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 24768ff..63a2c33 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -211,6 +211,7 @@ static void *eeh_report_error(void *data, void *userdata)
 	if (rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
 	if (*res == PCI_ERS_RESULT_NONE) *res = rc;
 
+	edev->in_error = 1;
 	eeh_pcid_put(dev);
 	return NULL;
 }
@@ -282,7 +283,8 @@ static void *eeh_report_reset(void *data, void *userdata)
 
 	if (!driver->err_handler ||
 	    !driver->err_handler->slot_reset ||
-	    (edev->mode & EEH_DEV_NO_HANDLER)) {
+	    (edev->mode & EEH_DEV_NO_HANDLER) ||
+	    (!edev->in_error)) {
 		eeh_pcid_put(dev);
 		return NULL;
 	}
@@ -339,14 +341,16 @@ static void *eeh_report_resume(void *data, void *userdata)
 
 	if (!driver->err_handler ||
 	    !driver->err_handler->resume ||
-	    (edev->mode & EEH_DEV_NO_HANDLER)) {
+	    (edev->mode & EEH_DEV_NO_HANDLER) ||
+	    (!edev->in_error)) {
 		edev->mode &= ~EEH_DEV_NO_HANDLER;
-		eeh_pcid_put(dev);
-		return NULL;
+		goto out;
 	}
 
 	driver->err_handler->resume(dev);
 
+out:
+	edev->in_error = 0;
 	eeh_pcid_put(dev);
 	return NULL;
 }
@@ -386,12 +390,38 @@ static void *eeh_report_failure(void *data, void *userdata)
 	return NULL;
 }
 
+static void *eeh_add_virt_device(void *data, void *userdata)
+{
+	struct pci_driver *driver;
+	struct eeh_dev *edev = (struct eeh_dev *)data;
+	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
+	struct pci_dn *pdn = eeh_dev_to_pdn(edev);
+
+	if (!(edev->physfn)) {
+		pr_warn("%s: EEH dev %04x:%02x:%02x.%01x not for VF\n",
+			__func__, edev->phb->global_number, pdn->busno,
+			PCI_SLOT(pdn->devfn), PCI_FUNC(pdn->devfn));
+		return NULL;
+	}
+
+	driver = eeh_pcid_get(dev);
+	if (driver) {
+		eeh_pcid_put(dev);
+		if (driver->err_handler)
+			return NULL;
+	}
+
+	pci_iov_virtfn_add(edev->physfn, pdn->vf_index, 0);
+	return NULL;
+}
+
 static void *eeh_rmv_device(void *data, void *userdata)
 {
 	struct pci_driver *driver;
 	struct eeh_dev *edev = (struct eeh_dev *)data;
 	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
 	int *removed = (int *)userdata;
+	struct pci_dn *pdn = eeh_dev_to_pdn(edev);
 
 	/*
 	 * Actually, we should remove the PCI bridges as well.
@@ -416,7 +446,7 @@ static void *eeh_rmv_device(void *data, void *userdata)
 	driver = eeh_pcid_get(dev);
 	if (driver) {
 		eeh_pcid_put(dev);
-		if (driver->err_handler)
+		if (removed && driver->err_handler)
 			return NULL;
 	}
 
@@ -425,11 +455,23 @@ static void *eeh_rmv_device(void *data, void *userdata)
 		 pci_name(dev));
 	edev->bus = dev->bus;
 	edev->mode |= EEH_DEV_DISCONNECTED;
-	(*removed)++;
+	if (removed)
+		(*removed)++;
 
-	pci_lock_rescan_remove();
-	pci_stop_and_remove_bus_device(dev);
-	pci_unlock_rescan_remove();
+	if (edev->physfn) {
+		pci_iov_virtfn_remove(edev->physfn, pdn->vf_index, 0);
+		edev->pdev = NULL;
+
+		/*
+		 * We have to set the VF PE number to invalid one, which is
+		 * required to plug the VF successfully.
+		 */
+		pdn->pe_number = IODA_INVALID_PE;
+	} else {
+		pci_lock_rescan_remove();
+		pci_stop_and_remove_bus_device(dev);
+		pci_unlock_rescan_remove();
+	}
 
 	return NULL;
 }
@@ -548,6 +590,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
 	struct pci_bus *frozen_bus = eeh_pe_bus_get(pe);
 	struct timeval tstamp;
 	int cnt, rc, removed = 0;
+	struct eeh_dev *edev;
 
 	/* pcibios will clear the counter; save the value */
 	cnt = pe->freeze_count;
@@ -561,12 +604,15 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
 	 */
 	eeh_pe_state_mark(pe, EEH_PE_KEEP);
 	if (bus) {
-		pci_lock_rescan_remove();
-		pcibios_remove_pci_devices(bus);
-		pci_unlock_rescan_remove();
-	} else if (frozen_bus) {
+		if (pe->type & EEH_PE_VF)
+			eeh_pe_dev_traverse(pe, eeh_rmv_device, NULL);
+		else {
+			pci_lock_rescan_remove();
+			pcibios_remove_pci_devices(bus);
+			pci_unlock_rescan_remove();
+		}
+	} else if (frozen_bus)
 		eeh_pe_dev_traverse(pe, eeh_rmv_device, &removed);
-	}
 
 	/*
 	 * Reset the pci controller. (Asserts RST#; resets config space).
@@ -607,14 +653,22 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
 		 * PE. We should disconnect it so the binding can be
 		 * rebuilt when adding PCI devices.
 		 */
+		edev = list_first_entry(&pe->edevs, struct eeh_dev, list);
 		eeh_pe_traverse(pe, eeh_pe_detach_dev, NULL);
-		pcibios_add_pci_devices(bus);
+		if (pe->type & EEH_PE_VF)
+			eeh_add_virt_device(edev, NULL);
+		else
+			pcibios_add_pci_devices(bus);
 	} else if (frozen_bus && removed) {
 		pr_info("EEH: Sleep 5s ahead of partial hotplug\n");
 		ssleep(5);
 
+		edev = list_first_entry(&pe->edevs, struct eeh_dev, list);
 		eeh_pe_traverse(pe, eeh_pe_detach_dev, NULL);
-		pcibios_add_pci_devices(frozen_bus);
+		if (pe->type & EEH_PE_VF)
+			eeh_add_virt_device(edev, NULL);
+		else
+			pcibios_add_pci_devices(frozen_bus);
 	}
 	eeh_pe_state_clear(pe, EEH_PE_KEEP);
 
@@ -792,11 +846,15 @@ perm_error:
 	 * the their PCI config any more.
 	 */
 	if (frozen_bus) {
-		eeh_pe_dev_mode_mark(pe, EEH_DEV_REMOVED);
-
-		pci_lock_rescan_remove();
-		pcibios_remove_pci_devices(frozen_bus);
-		pci_unlock_rescan_remove();
+		if (pe->type & EEH_PE_VF) {
+			eeh_pe_dev_traverse(pe, eeh_rmv_device, NULL);
+			eeh_pe_dev_mode_mark(pe, EEH_DEV_REMOVED);
+		} else {
+			eeh_pe_dev_mode_mark(pe, EEH_DEV_REMOVED);
+			pci_lock_rescan_remove();
+			pcibios_remove_pci_devices(frozen_bus);
+			pci_unlock_rescan_remove();
+		}
 	}
 }
 
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 260a701..5cde950 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -914,7 +914,8 @@ struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe)
 	if (pe->type & EEH_PE_PHB) {
 		bus = pe->phb->bus;
 	} else if (pe->type & EEH_PE_BUS ||
-		   pe->type & EEH_PE_DEVICE) {
+		   pe->type & EEH_PE_DEVICE ||
+		   pe->type & EEH_PE_VF) {
 		if (pe->bus) {
 			bus = pe->bus;
 			goto out;
-- 
1.7.9.5
