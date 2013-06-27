Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9E3C62C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 15:47:00 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 26 Jun 2013 23:46:58 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id D1F713E40042
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 23:46:36 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5R5kuNw111184
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 23:46:56 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5R5kt4N010957
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 23:46:56 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 8/8] powernv/eeh: Do hotplug on devices without EEH aware
 driver
Date: Thu, 27 Jun 2013 13:46:49 +0800
Message-Id: <1372312009-13710-9-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1372312009-13710-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1372312009-13710-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

During recovery for EEH errors, the device driver requires reset
explicitly (most of cases). The EEH core doesn't do hotplug during
reset. However, there might have some device drivers that can't
support EEH. So the deivce can't be put into quite state during
the reset and possibly requesting PCI config or MMIO access. That
would lead to the failure of the reset, and we don't expect that.

The patch intends to fix that by removing those devices whose drivers
can't support EEH before reset and added into the system after reset.
In the result, it would avoid the race condition mentioned as above.
The idea was proposed by Ben.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h   |    4 +-
 arch/powerpc/include/asm/pci.h   |    1 +
 arch/powerpc/kernel/eeh_driver.c |  134 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 137 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 09a8743..dd62006 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -82,7 +82,8 @@ struct eeh_pe {
  * another tree except the currently existing tree of PCI
  * buses and PCI devices
  */
-#define EEH_DEV_IRQ_DISABLED	(1<<0)	/* Interrupt disabled		*/
+#define EEH_DEV_IRQ_DISABLED	(1 << 0)	/* Interrupt disabled	*/
+#define EEH_DEV_REMOVED		(1 << 1)	/* PCI device removed	*/
 
 struct eeh_dev {
 	int mode;			/* EEH mode			*/
@@ -95,6 +96,7 @@ struct eeh_dev {
 	struct pci_controller *phb;	/* Associated PHB		*/
 	struct device_node *dn;		/* Associated device node	*/
 	struct pci_dev *pdev;		/* Associated PCI device	*/
+	struct pci_bus *bus;		/* PCI bus used in hotplug	*/
 };
 
 static inline struct device_node *eeh_dev_to_of_node(struct eeh_dev *edev)
diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index 6653f27..af10ec5 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -183,6 +183,7 @@ extern void pci_resource_to_user(const struct pci_dev *dev, int bar,
 				 resource_size_t *start, resource_size_t *end);
 
 extern resource_size_t pcibios_io_space_offset(struct pci_controller *hose);
+extern void pcibios_setup_device(struct pci_dev *dev);
 extern void pcibios_setup_bus_devices(struct pci_bus *bus);
 extern void pcibios_setup_bus_self(struct pci_bus *bus);
 extern void pcibios_setup_phb_io_space(struct pci_controller *hose);
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 2b1ce17..cb3baab 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -244,6 +244,7 @@ static void *eeh_report_reset(void *data, void *userdata)
 	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
 	enum pci_ers_result rc, *res = userdata;
 	struct pci_driver *driver;
+	bool enable_irq = true;
 
 	if (!dev) return NULL;
 	dev->error_state = pci_channel_io_normal;
@@ -251,7 +252,21 @@ static void *eeh_report_reset(void *data, void *userdata)
 	driver = eeh_pcid_get(dev);
 	if (!driver) return NULL;
 
-	eeh_enable_irq(dev);
+	/*
+	 * For those PCI devices just added, we reloaded its driver
+	 * and needn't to enable the interrupt. The driver should
+	 * take care of that. Otherwise, complaint raised from IRQ
+	 * subsystem.
+	 */
+	if (eeh_probe_mode_dev() && (edev->mode & EEH_DEV_REMOVED)) {
+		edev->mode &= ~(EEH_DEV_REMOVED | EEH_DEV_IRQ_DISABLED);
+		edev->bus = NULL;
+		enable_irq = false;
+
+	}
+
+	if (enable_irq)
+		eeh_enable_irq(dev);
 
 	if (!driver->err_handler ||
 	    !driver->err_handler->slot_reset) {
@@ -338,6 +353,115 @@ static void *eeh_report_failure(void *data, void *userdata)
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
+	/* If the driver doesn't support EEH, remove it */
+	pr_info("EEH: Removing device %s without EEH support\n",
+		pci_name(dev));
+
+	/* Detach EEH device from PCI device */
+	edev->pdev = NULL;
+	dev->dev.archdata.edev = NULL;
+	pci_dev_put(dev);
+
+	/* Remove and address cache */
+	eeh_addr_cache_rmv_dev(dev);
+	eeh_sysfs_remove_device(dev);
+
+	/* Remove it from PCI subsystem */
+	edev->mode |= EEH_DEV_REMOVED;
+	edev->bus = dev->bus;
+	pci_stop_and_remove_bus_device(dev);
+	(*removed)++;
+
+	return NULL;
+}
+
+static void *eeh_add_device(void *data, void *userdata)
+{
+	struct eeh_dev *edev = (struct eeh_dev *)data;
+	struct pci_dev *dev;
+	struct pci_bus *bus;
+	struct resource *r;
+	int *removed = (int *)userdata;
+	int devfn, i;
+
+	if (!edev || !(edev->mode & EEH_DEV_REMOVED))
+		return NULL;
+	if (*removed <= 0)
+		return edev;
+
+	/*
+	 * We don't clear EEH_DEV_REMOVED flag here.
+	 * Instead, do that before enabling IRQ to
+	 * avoid complain from IRQ subsystem.
+	 */
+	*removed -= 1;
+	bus = edev->bus;
+	devfn = edev->config_addr & 0xFF;
+	pr_info("EEH: Adding PCI device %04x:%02x:%02x.%01x\n",
+		edev->phb->global_number, bus->number,
+		PCI_SLOT(devfn), PCI_FUNC(devfn));
+
+	/* Scan PCI function */
+	dev = pci_scan_single_device(bus, devfn);
+	if (!dev) {
+		pr_err("%s: Can't scan PCI function %02x:%02x.%01x\n",
+		       __func__, bus->number, PCI_SLOT(devfn),
+		       PCI_FUNC(devfn));
+		return NULL;
+	}
+
+	/*
+	 * Setup the PCI device. It's not enough to
+	 * claim the resource and we need assign or
+	 * reassign that.
+	 */
+	pcibios_setup_device(dev);
+	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
+		r = &dev->resource[i];
+		if (r->parent || !r->flags)
+			continue;
+		if (pci_assign_resource(dev, i)) {
+			pr_err("%s: Can't allocate %pR for %s\n",
+			       __func__, r, pci_name(dev));
+			/* Clear it out */
+			r->start = 0;
+			r->end = 0;
+			r->flags = 0;
+		}
+	}
+
+	/* Associate EEH device with PCI device */
+	pci_dev_get(dev);
+	edev->pdev = dev;
+	dev->dev.archdata.edev = edev;
+	eeh_addr_cache_insert_dev(dev);
+
+	pci_bus_add_devices(bus);
+	eeh_sysfs_add_device(dev);
+
+	return NULL;
+}
+
 /**
  * eeh_reset_device - Perform actual reset of a pci slot
  * @pe: EEH PE
@@ -351,6 +475,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
 {
 	struct timeval tstamp;
 	int cnt, rc;
+	int removed = 0;
 
 	/* pcibios will clear the counter; save the value */
 	cnt = pe->freeze_count;
@@ -364,6 +489,8 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
 	 */
 	if (bus)
 		__pcibios_remove_pci_devices(bus, 0);
+	else if (eeh_probe_mode_dev())
+		eeh_pe_dev_traverse(pe, eeh_rmv_device, &removed);
 
 	/* Reset the pci controller. (Asserts RST#; resets config space).
 	 * Reconfigure bridges and devices. Don't try to bring the system
@@ -384,8 +511,13 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
 	 * potentially weird things happen.
 	 */
 	if (bus) {
+		pr_info("EEH: Hold for 5 seconds after reset\n");
 		ssleep(5);
 		pcibios_add_pci_devices(bus);
+	} else if (eeh_probe_mode_dev() && removed) {
+		pr_info("EEH: Hold for 5 seconds after reset\n");
+		ssleep(5);
+		eeh_pe_dev_traverse(pe, eeh_add_device, &removed);
 	}
 
 	pe->tstamp = tstamp;
-- 
1.7.5.4
