Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 052AB2C00CD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 21:11:11 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 23 Jul 2013 07:11:08 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 731976E803A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 07:11:01 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6NBB6fr155612
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 07:11:06 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6NBB5wH014766
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 07:11:06 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 07/11] powerpc/pci: Partial hotplug support
Date: Tue, 23 Jul 2013 19:10:52 +0800
Message-Id: <1374577856-1712-8-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1374577856-1712-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1374577856-1712-1-git-send-email-shangw@linux.vnet.ibm.com>
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
 arch/powerpc/kernel/pci-common.c  |    1 +
 arch/powerpc/kernel/pci-hotplug.c |    6 +--
 arch/powerpc/kernel/pci_of_scan.c |   56 ++++++++++++++++++++++++++----------
 3 files changed, 43 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index f46914a..f80a4f4 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1462,6 +1462,7 @@ void pcibios_finish_adding_to_bus(struct pci_bus *bus)
 	/* Allocate bus and devices resources */
 	pcibios_allocate_bus_resources(bus);
 	pcibios_claim_one_bus(bus);
+	pci_assign_unassigned_bus_resources(bus);
 
 	/* Fixup EEH */
 	eeh_add_device_tree_late(bus);
diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
index fc0831d..8e9b1c2 100644
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
 
@@ -87,9 +87,7 @@ void pcibios_add_pci_devices(struct pci_bus * bus)
 	} else if (mode == PCI_PROBE_NORMAL) {
 		/* use legacy probe */
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
