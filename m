Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 99D001A178F
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Nov 2015 10:35:11 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Sun, 8 Nov 2015 09:35:10 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id C5B212CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Nov 2015 10:35:07 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA7NZ1k524313882
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 8 Nov 2015 10:35:09 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA7NYYL1012490
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 8 Nov 2015 10:34:35 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, bhelgaas@google.com, mpe@ellerman.id.au,
 aik@ozlabs.ru
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V13 9/9] powerpc/eeh: Support error recovery for VF PE
Date: Sun,  8 Nov 2015 07:30:35 +0800
Message-Id: <1446939035-2617-10-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1446939035-2617-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1446939035-2617-1-git-send-email-weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PFs are enumerated on PCI bus, while VFs are created by PF's driver.

In EEH recovery, it has two cases:
1. Device and driver is EEH aware, error handlers are called.
2. Device and driver is not EEH aware, un-plug the device and plug it again
by enumerating it.

The special thing happens on the second case. For a PF, we could use the
original pci core to enumerate the bus, while for VF we need to record the
VFs which aer un-plugged then plug it again.

Also The patch caches the VF index in pci_dn, which can be used to
calculate VF's bus, device and function number. Those information helps to
locate the VF's PCI device instance when doing hotplug during EEH recovery
if necessary.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h        |   2 +
 arch/powerpc/include/asm/pci-bridge.h |   1 +
 arch/powerpc/kernel/eeh.c             |   8 +++
 arch/powerpc/kernel/eeh_dev.c         |   1 +
 arch/powerpc/kernel/eeh_driver.c      | 132 +++++++++++++++++++++++++++-------
 arch/powerpc/kernel/eeh_pe.c          |   3 +-
 arch/powerpc/kernel/pci_dn.c          |   4 +-
 7 files changed, 123 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 331c856..4448433 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -139,9 +139,11 @@ struct eeh_dev {
 	int af_cap;			/* Saved AF capability		*/
 	struct eeh_pe *pe;		/* Associated PE		*/
 	struct list_head list;		/* Form link list in the PE	*/
+	struct list_head rmv_list;	/* Record the removed edev 	*/
 	struct pci_controller *phb;	/* Associated PHB		*/
 	struct pci_dn *pdn;		/* Associated PCI device node	*/
 	struct pci_dev *pdev;		/* Associated PCI device	*/
+	bool   in_error;		/* Error flag for eeh_dev	*/
 	struct pci_dev *physfn;		/* Associated PF PORT		*/
 	struct pci_bus *bus;		/* PCI bus for partial hotplug	*/
 };
diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 9b365d6..533e6e9 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -211,6 +211,7 @@ struct pci_dn {
 #define IODA_INVALID_PE		(-1)
 #ifdef CONFIG_PPC_POWERNV
 	int	pe_number;
+	int     vf_index;		/* VF index in the PF */
 #ifdef CONFIG_PCI_IOV
 	u16     vfs_expanded;		/* number of VFs IOV BAR expanded */
 	u16     num_vfs;		/* number of VFs enabled*/
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 41a4b30..99c961a 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1245,6 +1245,14 @@ void eeh_remove_device(struct pci_dev *dev)
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
+	edev->in_error = false;
 	dev->dev.archdata.edev = NULL;
 	if (!(edev->pe->state & EEH_PE_KEEP))
 		eeh_rmv_from_parent_pe(edev);
diff --git a/arch/powerpc/kernel/eeh_dev.c b/arch/powerpc/kernel/eeh_dev.c
index aabba94..7815095 100644
--- a/arch/powerpc/kernel/eeh_dev.c
+++ b/arch/powerpc/kernel/eeh_dev.c
@@ -67,6 +67,7 @@ void *eeh_dev_init(struct pci_dn *pdn, void *data)
 	edev->pdn = pdn;
 	edev->phb = phb;
 	INIT_LIST_HEAD(&edev->list);
+	INIT_LIST_HEAD(&edev->rmv_list);
 
 	return NULL;
 }
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 89eb4bc..f25428a 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -34,6 +34,11 @@
 #include <asm/prom.h>
 #include <asm/rtas.h>
 
+struct eeh_rmv_data {
+	struct list_head edev_list;
+	int removed;
+};
+
 /**
  * eeh_pcid_name - Retrieve name of PCI device driver
  * @pdev: PCI device
@@ -211,6 +216,7 @@ static void *eeh_report_error(void *data, void *userdata)
 	if (rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
 	if (*res == PCI_ERS_RESULT_NONE) *res = rc;
 
+	edev->in_error = true;
 	eeh_pcid_put(dev);
 	return NULL;
 }
@@ -282,7 +288,8 @@ static void *eeh_report_reset(void *data, void *userdata)
 
 	if (!driver->err_handler ||
 	    !driver->err_handler->slot_reset ||
-	    (edev->mode & EEH_DEV_NO_HANDLER)) {
+	    (edev->mode & EEH_DEV_NO_HANDLER) ||
+	    (!edev->in_error)) {
 		eeh_pcid_put(dev);
 		return NULL;
 	}
@@ -326,6 +333,7 @@ static void *eeh_report_resume(void *data, void *userdata)
 {
 	struct eeh_dev *edev = (struct eeh_dev *)data;
 	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
+	bool was_in_error;
 	struct pci_driver *driver;
 
 	if (!dev || eeh_dev_removed(edev))
@@ -335,11 +343,13 @@ static void *eeh_report_resume(void *data, void *userdata)
 	driver = eeh_pcid_get(dev);
 	if (!driver) return NULL;
 
+	was_in_error = edev->in_error;
+	edev->in_error = false;
 	eeh_enable_irq(dev);
 
 	if (!driver->err_handler ||
 	    !driver->err_handler->resume ||
-	    (edev->mode & EEH_DEV_NO_HANDLER)) {
+	    (edev->mode & EEH_DEV_NO_HANDLER) || !was_in_error) {
 		edev->mode &= ~EEH_DEV_NO_HANDLER;
 		eeh_pcid_put(dev);
 		return NULL;
@@ -386,12 +396,39 @@ static void *eeh_report_failure(void *data, void *userdata)
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
-	int *removed = (int *)userdata;
+	struct eeh_rmv_data *rmv_data = (struct eeh_rmv_data *)userdata;
+	int *removed = rmv_data ? &rmv_data->removed : NULL;
+	struct pci_dn *pdn = eeh_dev_to_pdn(edev);
 
 	/*
 	 * Actually, we should remove the PCI bridges as well.
@@ -416,7 +453,7 @@ static void *eeh_rmv_device(void *data, void *userdata)
 	driver = eeh_pcid_get(dev);
 	if (driver) {
 		eeh_pcid_put(dev);
-		if (driver->err_handler)
+		if (removed && driver->err_handler)
 			return NULL;
 	}
 
@@ -425,11 +462,26 @@ static void *eeh_rmv_device(void *data, void *userdata)
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
+
+		if (rmv_data)
+			list_add(&edev->rmv_list, &rmv_data->edev_list);
+	} else {
+		pci_lock_rescan_remove();
+		pci_stop_and_remove_bus_device(dev);
+		pci_unlock_rescan_remove();
+	}
 
 	return NULL;
 }
@@ -543,11 +595,13 @@ int eeh_pe_reset_and_recover(struct eeh_pe *pe)
  * During the reset, udev might be invoked because those affected
  * PCI devices will be removed and then added.
  */
-static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
+static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
+				struct eeh_rmv_data *rmv_data)
 {
 	struct pci_bus *frozen_bus = eeh_pe_bus_get(pe);
 	struct timeval tstamp;
-	int cnt, rc, removed = 0;
+	int cnt, rc;
+	struct eeh_dev *edev;
 
 	/* pcibios will clear the counter; save the value */
 	cnt = pe->freeze_count;
@@ -561,12 +615,15 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
 	 */
 	eeh_pe_state_mark(pe, EEH_PE_KEEP);
 	if (bus) {
-		pci_lock_rescan_remove();
-		pcibios_remove_pci_devices(bus);
-		pci_unlock_rescan_remove();
-	} else if (frozen_bus) {
-		eeh_pe_dev_traverse(pe, eeh_rmv_device, &removed);
-	}
+		if (pe->type & EEH_PE_VF) {
+			eeh_pe_dev_traverse(pe, eeh_rmv_device, NULL);
+		} else {
+			pci_lock_rescan_remove();
+			pcibios_remove_pci_devices(bus);
+			pci_unlock_rescan_remove();
+		}
+	} else if (frozen_bus)
+		eeh_pe_dev_traverse(pe, eeh_rmv_device, rmv_data);
 
 	/*
 	 * Reset the pci controller. (Asserts RST#; resets config space).
@@ -607,14 +664,22 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
 		 * PE. We should disconnect it so the binding can be
 		 * rebuilt when adding PCI devices.
 		 */
+		edev = list_first_entry(&pe->edevs, struct eeh_dev, list);
 		eeh_pe_traverse(pe, eeh_pe_detach_dev, NULL);
-		pcibios_add_pci_devices(bus);
-	} else if (frozen_bus && removed) {
+		if (pe->type & EEH_PE_VF)
+			eeh_add_virt_device(edev, NULL);
+		else
+			pcibios_add_pci_devices(bus);
+	} else if (frozen_bus && rmv_data->removed) {
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
 
@@ -633,8 +698,10 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
 static void eeh_handle_normal_event(struct eeh_pe *pe)
 {
 	struct pci_bus *frozen_bus;
+	struct eeh_dev *edev, *tmp;
 	int rc = 0;
 	enum pci_ers_result result = PCI_ERS_RESULT_NONE;
+	struct eeh_rmv_data rmv_data = {LIST_HEAD_INIT(rmv_data.edev_list), 0};
 
 	frozen_bus = eeh_pe_bus_get(pe);
 	if (!frozen_bus) {
@@ -681,7 +748,7 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
 	 */
 	if (result == PCI_ERS_RESULT_NONE) {
 		pr_info("EEH: Reset with hotplug activity\n");
-		rc = eeh_reset_device(pe, frozen_bus);
+		rc = eeh_reset_device(pe, frozen_bus, NULL);
 		if (rc) {
 			pr_warn("%s: Unable to reset, err=%d\n",
 				__func__, rc);
@@ -733,7 +800,7 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
 	/* If any device called out for a reset, then reset the slot */
 	if (result == PCI_ERS_RESULT_NEED_RESET) {
 		pr_info("EEH: Reset without hotplug activity\n");
-		rc = eeh_reset_device(pe, NULL);
+		rc = eeh_reset_device(pe, NULL, &rmv_data);
 		if (rc) {
 			pr_warn("%s: Cannot reset, err=%d\n",
 				__func__, rc);
@@ -753,6 +820,15 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
 		goto hard_fail;
 	}
 
+	/*
+	 * For those hot removed VFs, we should add back them after PF get
+	 * recovered properly.
+	 */
+	list_for_each_entry_safe(edev, tmp, &rmv_data.edev_list, rmv_list) {
+		eeh_add_virt_device(edev, NULL);
+		list_del(&edev->rmv_list);
+	}
+
 	/* Tell all device drivers that they can resume operations */
 	pr_info("EEH: Notify device driver to resume\n");
 	eeh_pe_dev_traverse(pe, eeh_report_resume, NULL);
@@ -792,11 +868,15 @@ perm_error:
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
index 29240ad..b7facb9 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -936,7 +936,8 @@ struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe)
 	if (pe->type & EEH_PE_PHB) {
 		bus = pe->phb->bus;
 	} else if (pe->type & EEH_PE_BUS ||
-		   pe->type & EEH_PE_DEVICE) {
+		   pe->type & EEH_PE_DEVICE ||
+		   pe->type & EEH_PE_VF) {
 		if (pe->bus) {
 			bus = pe->bus;
 			goto out;
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index 5091b05..9e9cb16 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -139,6 +139,7 @@ struct pci_dn *pci_get_pdn(struct pci_dev *pdev)
 #ifdef CONFIG_PCI_IOV
 static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
 					   struct pci_dev *pdev,
+					   int vf_index,
 					   int busno, int devfn)
 {
 	struct pci_dn *pdn;
@@ -158,6 +159,7 @@ static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
 	pdn->busno = busno;
 	pdn->devfn = devfn;
 #ifdef CONFIG_PPC_POWERNV
+	pdn->vf_index = vf_index;
 	pdn->pe_number = IODA_INVALID_PE;
 #endif
 	INIT_LIST_HEAD(&pdn->child_list);
@@ -198,7 +200,7 @@ struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
 		return NULL;
 
 	for (i = 0; i < pci_sriov_get_totalvfs(pdev); i++) {
-		pdn = add_one_dev_pci_data(parent, NULL,
+		pdn = add_one_dev_pci_data(parent, NULL, i,
 					   pci_iov_virtfn_bus(pdev, i),
 					   pci_iov_virtfn_devfn(pdev, i));
 		if (!pdn) {
-- 
2.5.0
