Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e38.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 799F72C02C8
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jul 2013 12:57:50 +1000 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 4 Jul 2013 20:57:47 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 2AACF19D803E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 20:57:34 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r652viIH153662
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jul 2013 20:57:44 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r652vhZD016282
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jul 2013 20:57:44 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 8/8] powerpc/eeh: Support partial hotplug
Date: Fri,  5 Jul 2013 10:57:34 +0800
Message-Id: <1372993054-25730-9-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1372993054-25730-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1372993054-25730-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When EEH error happens to one specific PE, some devices with drivers
supporting EEH won't except hotplug on the deivce. However, there
might have other deivces without driver, or with driver without EEH
support. For the case, we need do partial hotplug in order to make
sure that the PE becomes absolutely quite during reset. Otherise,
the PE reset might fail and leads to failure of error recovery.

The patch intends to support so-called "partial" hotplug for EEH:
Before we do reset, we stop and remove those PCI devices without
EEH sensitive driver. The corresponding EEH devices are not detached
from its PE, but with special flag. After the reset is done, those
EEH devices with the special flag will be scanned one by one.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h   |    6 ++-
 arch/powerpc/kernel/eeh.c        |   22 ++++++--
 arch/powerpc/kernel/eeh_driver.c |  109 ++++++++++++++++++++++++++++++++++++--
 arch/powerpc/kernel/eeh_pe.c     |   26 +++++----
 4 files changed, 141 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index e8c411b..f54a601 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -84,7 +84,8 @@ struct eeh_pe {
  * another tree except the currently existing tree of PCI
  * buses and PCI devices
  */
-#define EEH_DEV_IRQ_DISABLED	(1<<0)	/* Interrupt disabled		*/
+#define EEH_DEV_IRQ_DISABLED	(1 << 0)	/* Interrupt disabled	*/
+#define EEH_DEV_DISCONNECTED	(1 << 1)	/* Removing from PE	*/
 
 struct eeh_dev {
 	int mode;			/* EEH mode			*/
@@ -97,6 +98,7 @@ struct eeh_dev {
 	struct pci_controller *phb;	/* Associated PHB		*/
 	struct device_node *dn;		/* Associated device node	*/
 	struct pci_dev *pdev;		/* Associated PCI device	*/
+	struct pci_bus *bus;		/* PCI bus for partial hotplug	*/
 };
 
 static inline struct device_node *eeh_dev_to_of_node(struct eeh_dev *edev)
@@ -197,6 +199,8 @@ struct eeh_pe *eeh_pe_get(struct eeh_dev *edev);
 int eeh_add_to_parent_pe(struct eeh_dev *edev);
 int eeh_rmv_from_parent_pe(struct eeh_dev *edev);
 void eeh_pe_update_time_stamp(struct eeh_pe *pe);
+void *eeh_pe_traverse(struct eeh_pe *root,
+		eeh_traverse_func fn, void *flag);
 void *eeh_pe_dev_traverse(struct eeh_pe *root,
 		eeh_traverse_func fn, void *flag);
 void eeh_pe_restore_bars(struct eeh_pe *pe);
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index b518c49..8b414b3 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -985,15 +985,27 @@ void eeh_remove_device(struct pci_dev *dev)
 	/* Unregister the device with the EEH/PCI address search system */
 	pr_debug("EEH: Removing device %s\n", pci_name(dev));
 
-	if (!edev || !edev->pdev) {
+	if (!edev || !edev->pdev || !edev->pe) {
 		pr_debug("EEH: Not referenced !\n");
 		return;
 	}
-	edev->pdev = NULL;
-	dev->dev.archdata.edev = NULL;
-	pci_dev_put(dev);
 
-	eeh_rmv_from_parent_pe(edev);
+	/*
+	 * During the hotplug for EEH error recovery, we need the EEH
+	 * device attached to the parent PE in order for BAR restore
+	 * a bit later. So we keep it for BAR restore and remove it
+	 * from the parent PE during the BAR resotre.
+	 */
+	if (!(edev->pe->state & EEH_PE_KEEP)) {
+		edev->pdev = NULL;
+		dev->dev.archdata.edev = NULL;
+		pci_dev_put(dev);
+
+		eeh_rmv_from_parent_pe(edev);
+	} else {
+		edev->mode |= EEH_DEV_DISCONNECTED;
+	}
+
 	eeh_addr_cache_rmv_dev(dev);
 	eeh_sysfs_remove_device(dev);
 }
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 9ef3bbb..807d2bb 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -338,6 +338,92 @@ static void *eeh_report_failure(void *data, void *userdata)
 	return NULL;
 }
 
+static void *eeh_rmv_device(void *data, void *userdata)
+{
+	struct pci_driver *driver;
+	struct eeh_dev *edev = (struct eeh_dev *)data;
+	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
+	int *removed = (int *)userdata;
+
+	/*
+	 * Actually, we should remove the PCI bridges as well.
+	 * However, that's lots of complexity to do that,
+	 * particularly some of devices under the bridge might
+	 * support EEH. So we just care about PCI devices for
+	 * simplicity here.
+	 */
+	if (!dev || (dev->hdr_type & PCI_HEADER_TYPE_BRIDGE))
+		return NULL;
+	driver = eeh_pcid_get(dev);
+	if (driver && driver->err_handler)
+		return NULL;
+
+	/* Remove it from PCI subsystem */
+	pr_debug("EEH: Removing %s without EEH sensitive driver\n",
+		 pci_name(dev));
+	edev->bus = dev->bus;
+	edev->mode |= EEH_DEV_DISCONNECTED;
+	(*removed)++;
+
+	pci_stop_and_remove_bus_device(dev);
+
+	return NULL;
+}
+
+static void *eeh_add_pe_devices(void *data, void *userdata)
+{
+	struct pci_bus *bus;
+	struct eeh_pe *pe = (struct eeh_pe *)data;
+	struct eeh_dev *edev, *tmp;
+	int *removed = (int *)userdata;
+
+	eeh_pe_for_each_dev(pe, edev, tmp) {
+		if ((*removed) <= 0)
+			return pe;
+
+		if (!(edev->mode & EEH_DEV_DISCONNECTED))
+			continue;
+
+		pr_debug("EEH: Scanning %04x:%02x:%02x.%01x\n",
+			 pci_domain_nr(edev->bus), edev->bus->number,
+			 PCI_SLOT(edev->config_addr & 0xFF),
+			 PCI_FUNC(edev->config_addr & 0xFF));
+
+		/*
+		 * The EEH device is still connected to PE. It's time
+		 * to remove it from the parent PE.
+		 */
+		bus = edev->bus;
+		edev->mode &= ~(EEH_DEV_DISCONNECTED | EEH_DEV_IRQ_DISABLED);
+		edev->bus = NULL;
+		(*removed)--;
+		eeh_rmv_from_parent_pe(edev);
+
+		pcibios_scan_pci_dev(bus, eeh_dev_to_of_node(edev));
+	}
+
+	return NULL;
+}
+
+static void *eeh_pe_detach_dev(void *data, void *userdata)
+{
+	struct eeh_pe *pe = (struct eeh_pe *)data;
+	struct eeh_dev *edev, *tmp;
+
+	eeh_pe_for_each_dev(pe, edev, tmp) {
+		if (!(edev->mode & EEH_DEV_DISCONNECTED)) {
+			pr_warn("EEH: PHB#%x-PE#%x has bogus EEH device\n",
+				pe->phb->global_number, pe->addr);
+			continue;
+		}
+
+		edev->mode &= ~EEH_DEV_DISCONNECTED;
+		eeh_rmv_from_parent_pe(edev);
+	}
+
+	return NULL;
+}
+
 /**
  * eeh_reset_device - Perform actual reset of a pci slot
  * @pe: EEH PE
@@ -350,7 +436,7 @@ static void *eeh_report_failure(void *data, void *userdata)
 static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
 {
 	struct timeval tstamp;
-	int cnt, rc;
+	int cnt, rc, removed = 0;
 
 	/* pcibios will clear the counter; save the value */
 	cnt = pe->freeze_count;
@@ -362,10 +448,11 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
 	 * devices are expected to be attached soon when calling
 	 * into pcibios_add_pci_devices().
 	 */
-	if (bus) {
-		eeh_pe_state_mark(pe, EEH_PE_KEEP);
+	eeh_pe_state_mark(pe, EEH_PE_KEEP);
+	if (bus)
 		pcibios_remove_pci_devices(bus);
-	}
+	else
+		eeh_pe_dev_traverse(pe, eeh_rmv_device, &removed);
 
 	/* Reset the pci controller. (Asserts RST#; resets config space).
 	 * Reconfigure bridges and devices. Don't try to bring the system
@@ -386,10 +473,22 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
 	 * potentially weird things happen.
 	 */
 	if (bus) {
+		pr_info("EEH: Sleep 5s ahead of complete hotplug\n");
 		ssleep(5);
+
+		/*
+		 * The EEH device is still connected with its parent
+		 * PE. We should disconnect it so the binding can be
+		 * rebuilt when adding PCI devices.
+		 */
+		eeh_pe_traverse(pe, eeh_pe_detach_dev, NULL);
 		pcibios_add_pci_devices(bus);
-		eeh_pe_state_clear(pe, EEH_PE_KEEP);
+	} else if (removed) {
+		pr_info("EEH: Sleep 5s ahead of partial hotplug\n");
+		ssleep(5);
+		eeh_pe_traverse(pe, eeh_add_pe_devices, &removed);
 	}
+	eeh_pe_state_clear(pe, EEH_PE_KEEP);
 
 	pe->tstamp = tstamp;
 	pe->freeze_count = cnt;
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index c8b815e..f6bdde7 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -149,8 +149,8 @@ static struct eeh_pe *eeh_pe_next(struct eeh_pe *pe,
  * callback returns something other than NULL, or no more PEs
  * to be traversed.
  */
-static void *eeh_pe_traverse(struct eeh_pe *root,
-			eeh_traverse_func fn, void *flag)
+void *eeh_pe_traverse(struct eeh_pe *root,
+		      eeh_traverse_func fn, void *flag)
 {
 	struct eeh_pe *pe;
 	void *ret;
@@ -728,22 +728,26 @@ static void eeh_restore_device_bars(struct eeh_dev *edev,
  */
 static void *eeh_restore_one_device_bars(void *data, void *flag)
 {
-	struct pci_dev *pdev = NULL;
 	struct eeh_dev *edev = (struct eeh_dev *)data;
+	struct pci_dev *pdev = eeh_dev_to_pci_dev(edev);
 	struct device_node *dn = eeh_dev_to_of_node(edev);
 
-	/* Trace the PCI bridge */
-	if (eeh_probe_mode_dev()) {
-		pdev = eeh_dev_to_pci_dev(edev);
-		if (pdev->hdr_type != PCI_HEADER_TYPE_BRIDGE)
-                        pdev = NULL;
-        }
-
-	if (pdev)
+	/* Do special restore for bridges */
+	if (pdev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
 		eeh_restore_bridge_bars(pdev, edev, dn);
 	else
 		eeh_restore_device_bars(edev, dn);
 
+	/*
+	 * If the PCI device is associated with the EEH
+	 * device, It's time to clear the association.
+	 */
+	if (edev->mode & EEH_DEV_DISCONNECTED) {
+		edev->pdev = NULL;
+		pdev->dev.archdata.edev = NULL;
+		pci_dev_put(pdev);
+	}
+
 	return NULL;
 }
 
-- 
1.7.5.4
