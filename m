Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2448D2C0104
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 12:25:18 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 23 Jul 2013 22:25:16 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id A69EEC90044
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 22:25:11 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6O2PCww097930
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 22:25:12 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6O2PCY2010664
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 23:25:12 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 08/11] powerpc/eeh: Support partial hotplug
Date: Wed, 24 Jul 2013 10:24:58 +0800
Message-Id: <1374632701-20972-9-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1374632701-20972-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1374632701-20972-1-git-send-email-shangw@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/eeh.h               |    6 ++-
 arch/powerpc/kernel/eeh.c                    |   30 +++++++++-
 arch/powerpc/kernel/eeh_driver.c             |   74 ++++++++++++++++++++++++--
 arch/powerpc/kernel/eeh_pe.c                 |   20 +++-----
 arch/powerpc/kernel/eeh_sysfs.c              |    7 +++
 arch/powerpc/platforms/powernv/eeh-powernv.c |    2 +-
 arch/powerpc/platforms/pseries/eeh_pseries.c |    2 +-
 7 files changed, 117 insertions(+), 24 deletions(-)

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
index 56bd458..a5783f1 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -900,7 +900,21 @@ void eeh_add_device_late(struct pci_dev *dev)
 		pr_debug("EEH: Already referenced !\n");
 		return;
 	}
-	WARN_ON(edev->pdev);
+
+	/*
+	 * The EEH cache might not be removed correctly because of
+	 * unbalanced kref to the device during unplug time, which
+	 * relies on pcibios_release_device(). So we have to remove
+	 * that here explicitly.
+	 */
+	if (edev->pdev) {
+		eeh_rmv_from_parent_pe(edev);
+		eeh_addr_cache_rmv_dev(edev->pdev);
+		eeh_sysfs_remove_device(edev->pdev);
+
+		edev->pdev = NULL;
+		dev->dev.archdata.edev = NULL;
+	}
 
 	edev->pdev = dev;
 	dev->dev.archdata.edev = edev;
@@ -982,14 +996,24 @@ void eeh_remove_device(struct pci_dev *dev)
 	/* Unregister the device with the EEH/PCI address search system */
 	pr_debug("EEH: Removing device %s\n", pci_name(dev));
 
-	if (!edev || !edev->pdev) {
+	if (!edev || !edev->pdev || !edev->pe) {
 		pr_debug("EEH: Not referenced !\n");
 		return;
 	}
+
+	/*
+	 * During the hotplug for EEH error recovery, we need the EEH
+	 * device attached to the parent PE in order for BAR restore
+	 * a bit later. So we keep it for BAR restore and remove it
+	 * from the parent PE during the BAR resotre.
+	 */
 	edev->pdev = NULL;
 	dev->dev.archdata.edev = NULL;
+	if (!(edev->pe->state & EEH_PE_KEEP))
+		eeh_rmv_from_parent_pe(edev);
+	else
+		edev->mode |= EEH_DEV_DISCONNECTED;
 
-	eeh_rmv_from_parent_pe(edev);
 	eeh_addr_cache_rmv_dev(dev);
 	eeh_sysfs_remove_device(dev);
 }
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 9ef3bbb..9fda75d 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -338,6 +338,54 @@ static void *eeh_report_failure(void *data, void *userdata)
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
+static void *eeh_pe_detach_dev(void *data, void *userdata)
+{
+	struct eeh_pe *pe = (struct eeh_pe *)data;
+	struct eeh_dev *edev, *tmp;
+
+	eeh_pe_for_each_dev(pe, edev, tmp) {
+		if (!(edev->mode & EEH_DEV_DISCONNECTED))
+			continue;
+
+		edev->mode &= ~(EEH_DEV_DISCONNECTED | EEH_DEV_IRQ_DISABLED);
+		eeh_rmv_from_parent_pe(edev);
+	}
+
+	return NULL;
+}
+
 /**
  * eeh_reset_device - Perform actual reset of a pci slot
  * @pe: EEH PE
@@ -349,8 +397,9 @@ static void *eeh_report_failure(void *data, void *userdata)
  */
 static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
 {
+	struct pci_bus *frozen_bus = eeh_pe_bus_get(pe);
 	struct timeval tstamp;
-	int cnt, rc;
+	int cnt, rc, removed = 0;
 
 	/* pcibios will clear the counter; save the value */
 	cnt = pe->freeze_count;
@@ -362,10 +411,11 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
 	 * devices are expected to be attached soon when calling
 	 * into pcibios_add_pci_devices().
 	 */
-	if (bus) {
-		eeh_pe_state_mark(pe, EEH_PE_KEEP);
+	eeh_pe_state_mark(pe, EEH_PE_KEEP);
+	if (bus)
 		pcibios_remove_pci_devices(bus);
-	}
+	else if (frozen_bus)
+		eeh_pe_dev_traverse(pe, eeh_rmv_device, &removed);
 
 	/* Reset the pci controller. (Asserts RST#; resets config space).
 	 * Reconfigure bridges and devices. Don't try to bring the system
@@ -386,10 +436,24 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
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
+	} else if (frozen_bus && removed) {
+		pr_info("EEH: Sleep 5s ahead of partial hotplug\n");
+		ssleep(5);
+
+		eeh_pe_traverse(pe, eeh_pe_detach_dev, NULL);
+		pcibios_add_pci_devices(frozen_bus);
 	}
+	eeh_pe_state_clear(pe, EEH_PE_KEEP);
 
 	pe->tstamp = tstamp;
 	pe->freeze_count = cnt;
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index c8b815e..2aa955a 100644
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
@@ -409,8 +409,8 @@ int eeh_rmv_from_parent_pe(struct eeh_dev *edev)
 	int cnt;
 
 	if (!edev->pe) {
-		pr_warning("%s: No PE found for EEH device %s\n",
-			__func__, edev->dn->full_name);
+		pr_debug("%s: No PE found for EEH device %s\n",
+			 __func__, edev->dn->full_name);
 		return -EEXIST;
 	}
 
@@ -728,18 +728,12 @@ static void eeh_restore_device_bars(struct eeh_dev *edev,
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
diff --git a/arch/powerpc/kernel/eeh_sysfs.c b/arch/powerpc/kernel/eeh_sysfs.c
index e7ae348..61e2a14 100644
--- a/arch/powerpc/kernel/eeh_sysfs.c
+++ b/arch/powerpc/kernel/eeh_sysfs.c
@@ -68,6 +68,13 @@ void eeh_sysfs_add_device(struct pci_dev *pdev)
 
 void eeh_sysfs_remove_device(struct pci_dev *pdev)
 {
+	/*
+	 * The parent directory might have been removed. We needn't
+	 * continue for that case.
+	 */
+	if (!pdev->dev.kobj.sd)
+		return;
+
 	device_remove_file(&pdev->dev, &dev_attr_eeh_mode);
 	device_remove_file(&pdev->dev, &dev_attr_eeh_config_addr);
 	device_remove_file(&pdev->dev, &dev_attr_eeh_pe_config_addr);
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 969cce7..a380428 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -114,7 +114,7 @@ static int powernv_eeh_dev_probe(struct pci_dev *dev, void *flag)
 	 * the root bridge. So it's not reasonable to continue
 	 * the probing.
 	 */
-	if (!dn || !edev)
+	if (!dn || !edev || edev->pe)
 		return 0;
 
 	/* Skip for PCI-ISA bridge */
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index b456b15..0f44f9f 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -153,7 +153,7 @@ static void *pseries_eeh_of_probe(struct device_node *dn, void *flag)
 
 	/* Retrieve OF node and eeh device */
 	edev = of_node_to_eeh_dev(dn);
-	if (!of_device_is_available(dn))
+	if (edev->pe || !of_device_is_available(dn))
 		return NULL;
 
 	/* Retrieve class/vendor/device IDs */
-- 
1.7.5.4
