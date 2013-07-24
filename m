Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e36.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BE9122C00E0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 12:25:17 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 23 Jul 2013 20:25:15 -0600
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 9DDF21FF0044
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 20:19:51 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6O2PBcF130524
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 20:25:12 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6O2PAOg032205
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 20:25:11 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 07/11] powerpc/pci: Partial hotplug support
Date: Wed, 24 Jul 2013 10:24:57 +0800
Message-Id: <1374632701-20972-8-git-send-email-shangw@linux.vnet.ibm.com>
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

When EEH error happens to one specific PE, the device drivers
of its attached EEH devices (PCI devices) are checked to see
the further action: reset with complete hotplug, or reset without
hotplug. However, that's not enough for those PCI devices whose
drivers can't support EEH, or those PCI devices without driver.
So we need do so-called "partial hotplug" on basis of PCI devices.
In the situation, part of PCI devices of the specific PE are
unplugged and plugged again after PE reset.

The patch changes pcibios_add_pci_devices() so that it can support
full hotplug and so-called "partial" hotplug based on device-tree
or real hardware. It's notable that pci_of_scan.c has been changed
for a bit in order to support the "partial" hotplug based on dev-tree.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/pci-common.c  |    2 +
 arch/powerpc/kernel/pci-hotplug.c |   14 ++++++---
 arch/powerpc/kernel/pci_of_scan.c |   56 ++++++++++++++++++++++++++----------
 3 files changed, 51 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index f46914a..7d22a67 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1462,6 +1462,8 @@ void pcibios_finish_adding_to_bus(struct pci_bus *bus)
 	/* Allocate bus and devices resources */
 	pcibios_allocate_bus_resources(bus);
 	pcibios_claim_one_bus(bus);
+	if (!pci_has_flag(PCI_PROBE_ONLY))
+		pci_assign_unassigned_bus_resources(bus);
 
 	/* Fixup EEH */
 	eeh_add_device_tree_late(bus);
diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
index fc0831d..62388a6 100644
--- a/arch/powerpc/kernel/pci-hotplug.c
+++ b/arch/powerpc/kernel/pci-hotplug.c
@@ -71,7 +71,7 @@ EXPORT_SYMBOL_GPL(pcibios_remove_pci_devices);
  */
 void pcibios_add_pci_devices(struct pci_bus * bus)
 {
-	int slotno, num, mode, pass, max;
+	int slotno, mode, pass, max;
 	struct pci_dev *dev;
 	struct device_node *dn = pci_bus_to_OF_node(bus);
 
@@ -85,11 +85,15 @@ void pcibios_add_pci_devices(struct pci_bus * bus)
 		/* use ofdt-based probe */
 		of_rescan_bus(dn, bus);
 	} else if (mode == PCI_PROBE_NORMAL) {
-		/* use legacy probe */
+		/*
+		 * Use legacy probe. In the partial hotplug case, we
+		 * probably have indirect child devices unplugged. So
+		 * we don't check return value from pci_scan_slot() in
+		 * order for full-scan to pick up those indirect child
+		 * devices, which were removed during partial hotplug.
+		 */
 		slotno = PCI_SLOT(PCI_DN(dn->child)->devfn);
-		num = pci_scan_slot(bus, PCI_DEVFN(slotno, 0));
-		if (!num)
-			return;
+		pci_scan_slot(bus, PCI_DEVFN(slotno, 0));
 		pcibios_setup_bus_devices(bus);
 		max = bus->busn_res.start;
 		for (pass = 0; pass < 2; pass++) {
diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index 6b0ba58..15d9105 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -230,11 +230,14 @@ void of_scan_pci_bridge(struct pci_dev *dev)
 		return;
 	}
 
-	bus = pci_add_new_bus(dev->bus, dev, busrange[0]);
+	bus = pci_find_bus(pci_domain_nr(dev->bus), busrange[0]);
 	if (!bus) {
-		printk(KERN_ERR "Failed to create pci bus for %s\n",
-		       node->full_name);
-		return;
+		bus = pci_add_new_bus(dev->bus, dev, busrange[0]);
+		if (!bus) {
+			printk(KERN_ERR "Failed to create pci bus for %s\n",
+			       node->full_name);
+			return;
+		}
 	}
 
 	bus->primary = dev->bus->number;
@@ -292,6 +295,38 @@ void of_scan_pci_bridge(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(of_scan_pci_bridge);
 
+static struct pci_dev *of_scan_pci_dev(struct pci_bus *bus,
+			    struct device_node *dn)
+{
+	struct pci_dev *dev = NULL;
+	const u32 *reg;
+	int reglen, devfn;
+
+	pr_debug("  * %s\n", dn->full_name);
+	if (!of_device_is_available(dn))
+		return NULL;
+
+	reg = of_get_property(dn, "reg", &reglen);
+	if (reg == NULL || reglen < 20)
+		return NULL;
+	devfn = (reg[0] >> 8) & 0xff;
+
+	/* Check if the PCI device is already there */
+	dev = pci_get_slot(bus, devfn);
+	if (dev) {
+		pci_dev_put(dev);
+		return dev;
+	}
+
+	/* create a new pci_dev for this device */
+	dev = of_create_pci_dev(dn, bus, devfn);
+	if (!dev)
+		return NULL;
+
+	pr_debug("  dev header type: %x\n", dev->hdr_type);
+	return dev;
+}
+
 /**
  * __of_scan_bus - given a PCI bus node, setup bus and scan for child devices
  * @node: device tree node for the PCI bus
@@ -302,8 +337,6 @@ static void __of_scan_bus(struct device_node *node, struct pci_bus *bus,
 			  int rescan_existing)
 {
 	struct device_node *child;
-	const u32 *reg;
-	int reglen, devfn;
 	struct pci_dev *dev;
 
 	pr_debug("of_scan_bus(%s) bus no %d...\n",
@@ -311,16 +344,7 @@ static void __of_scan_bus(struct device_node *node, struct pci_bus *bus,
 
 	/* Scan direct children */
 	for_each_child_of_node(node, child) {
-		pr_debug("  * %s\n", child->full_name);
-		if (!of_device_is_available(child))
-			continue;
-		reg = of_get_property(child, "reg", &reglen);
-		if (reg == NULL || reglen < 20)
-			continue;
-		devfn = (reg[0] >> 8) & 0xff;
-
-		/* create a new pci_dev for this device */
-		dev = of_create_pci_dev(child, bus, devfn);
+		dev = of_scan_pci_dev(bus, child);
 		if (!dev)
 			continue;
 		pr_debug("    dev header type: %x\n", dev->hdr_type);
-- 
1.7.5.4
