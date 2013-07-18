Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e38.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 80A382C00F5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jul 2013 12:14:38 +1000 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 17 Jul 2013 20:14:36 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id D2CA53E4004F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jul 2013 20:14:12 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6I2EYwY134376
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jul 2013 20:14:34 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6I2EXAh028762
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jul 2013 20:14:33 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 07/10] powerpc/pci: Partial hotplug support
Date: Thu, 18 Jul 2013 10:14:17 +0800
Message-Id: <1374113660-15347-8-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1374113660-15347-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1374113660-15347-1-git-send-email-shangw@linux.vnet.ibm.com>
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

The patch adds functions to support scanning signle PCI device
(function) either based on device-tree or hardware for plugging.
The existing function pci_stop_and_remove_bus_device() is enough
for unplugging. Besides, the patch also fixes the issue that we
need reassign the resources if we had flag PCI_REASSIGN_ALL_RSRC.
Otherwise, to claim the resources of attached devices of the PCI
bus should fail and the newly added devices in "complete" hotplug
can't be enabled.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pci-bridge.h |    2 +-
 arch/powerpc/include/asm/pci.h        |    2 +
 arch/powerpc/kernel/pci-common.c      |    8 ++-
 arch/powerpc/kernel/pci-hotplug.c     |   92 +++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/pci_of_scan.c     |   43 +++++++++++----
 5 files changed, 132 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 32d0d20..070aed3 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -213,7 +213,7 @@ extern void pcibios_remove_pci_devices(struct pci_bus *bus);
 
 /** Discover new pci devices under this bus, and add them */
 extern void pcibios_add_pci_devices(struct pci_bus *bus);
-
+void pcibios_scan_pci_dev(struct pci_bus *bus, struct device_node *dn);
 
 extern void isa_bridge_find_early(struct pci_controller *hose);
 
diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index 6653f27..28cfc95 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -167,6 +167,8 @@ extern struct pci_dev *of_create_pci_dev(struct device_node *node,
 					struct pci_bus *bus, int devfn);
 
 extern void of_scan_pci_bridge(struct pci_dev *dev);
+extern struct pci_dev *of_scan_pci_dev(struct pci_bus *bus,
+				       struct device_node *dn);
 
 extern void of_scan_bus(struct device_node *node, struct pci_bus *bus);
 extern void of_rescan_bus(struct device_node *node, struct pci_bus *bus);
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index f46914a..6f3a1cb 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1460,8 +1460,12 @@ void pcibios_finish_adding_to_bus(struct pci_bus *bus)
 		 pci_domain_nr(bus), bus->number);
 
 	/* Allocate bus and devices resources */
-	pcibios_allocate_bus_resources(bus);
-	pcibios_claim_one_bus(bus);
+	if (pci_has_flag(PCI_REASSIGN_ALL_RSRC)) {
+		pci_assign_unassigned_bus_resources(bus);
+	} else {
+		pcibios_allocate_bus_resources(bus);
+		pcibios_claim_one_bus(bus);
+	}
 
 	/* Fixup EEH */
 	eeh_add_device_tree_late(bus);
diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
index fc0831d..c79105f 100644
--- a/arch/powerpc/kernel/pci-hotplug.c
+++ b/arch/powerpc/kernel/pci-hotplug.c
@@ -104,3 +104,95 @@ void pcibios_add_pci_devices(struct pci_bus * bus)
 	pcibios_finish_adding_to_bus(bus);
 }
 EXPORT_SYMBOL_GPL(pcibios_add_pci_devices);
+
+static void pcibios_of_scan_dev(struct pci_bus *bus, struct device_node *dn)
+{
+	struct pci_dev *dev;
+	int ret;
+
+	dev = of_scan_pci_dev(bus, dn);
+	if (!dev)
+		return;
+
+	eeh_add_device_early(dn);
+	pcibios_add_device(dev);
+	eeh_add_device_late(dev);
+
+	ret = pci_bus_add_device(dev);
+	if (ret) {
+		pr_info("%s: Failed to add PCI dev %s\n",
+			__func__, pci_name(dev));
+		return;
+	}
+
+	eeh_sysfs_add_device(dev);
+}
+
+static void pcibios_scan_dev(struct pci_bus *bus, struct device_node *dn)
+{
+	struct pci_dn *pdn = PCI_DN(dn);
+	struct pci_dev *dev;
+	struct resource *r;
+	int i, ret;
+
+	eeh_add_device_early(dn);
+	dev = pci_scan_single_device(bus, pdn->devfn);
+	if (!dev) {
+		pr_warn("%s: Failed to probe %04x:%02x:%2x.%01x\n",
+			__func__, pci_domain_nr(bus), bus->number,
+			PCI_SLOT(pdn->devfn), PCI_FUNC(pdn->devfn));
+		return;
+	}
+
+	/*
+	 * If we already requested to reassign resources, the
+	 * start address of individual resources is zero'ed
+	 * during PCI header fixup time. So we need reassign
+	 * the resource for the case. Otherwise, it's enough
+	 * to claim it.
+	 */
+	pcibios_add_device(dev);
+	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
+		r = &dev->resource[i];
+		if (r->parent || !r->flags)
+			continue;
+		if (pci_has_flag(PCI_REASSIGN_ALL_RSRC)) {
+			ret = pci_assign_resource(dev, i);
+		} else {
+			if (!r->start)
+				continue;
+			ret = pci_claim_resource(dev, i);
+		}
+
+		if (ret) {
+			pr_warn("%s: Can't assign %pR for %s\n",
+				__func__, r, pci_name(dev));
+			/* Clear it out */
+			r->start = 0;
+			r->end = 0;
+			r->flags = 0;
+		}
+	}
+
+	eeh_add_device_late(dev);
+	ret = pci_bus_add_device(dev);
+	if (ret) {
+		pr_warn("%s: Failed to add PCI device %s\n",
+			__func__, pci_name(dev));
+		return;
+	}
+	eeh_sysfs_add_device(dev);
+}
+
+void pcibios_scan_pci_dev(struct pci_bus *bus, struct device_node *dn)
+{
+	int mode = PCI_PROBE_NORMAL;
+
+	if (ppc_md.pci_probe_mode)
+		mode = ppc_md.pci_probe_mode(bus);
+
+	if (mode == PCI_PROBE_DEVTREE)
+		pcibios_of_scan_dev(bus, dn);
+	else if (mode == PCI_PROBE_NORMAL)
+		pcibios_scan_dev(bus, dn);
+}
diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index 6b0ba58..81041c9 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -293,6 +293,36 @@ void of_scan_pci_bridge(struct pci_dev *dev)
 EXPORT_SYMBOL(of_scan_pci_bridge);
 
 /**
+ * of_scan_pci_dev - given a PCI device node, setup the PCI device
+ * @bus: PCI bus
+ * @dn: device tree node for the PCI device
+ */
+struct pci_dev *of_scan_pci_dev(struct pci_bus *bus,
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
+	/* create a new pci_dev for this device */
+	dev = of_create_pci_dev(dn, bus, devfn);
+	if (!dev)
+		return NULL;
+
+	pr_debug("  dev header type: %x\n", dev->hdr_type);
+	return dev;
+}
+
+/**
  * __of_scan_bus - given a PCI bus node, setup bus and scan for child devices
  * @node: device tree node for the PCI bus
  * @bus: pci_bus structure for the PCI bus
@@ -302,8 +332,6 @@ static void __of_scan_bus(struct device_node *node, struct pci_bus *bus,
 			  int rescan_existing)
 {
 	struct device_node *child;
-	const u32 *reg;
-	int reglen, devfn;
 	struct pci_dev *dev;
 
 	pr_debug("of_scan_bus(%s) bus no %d...\n",
@@ -311,16 +339,7 @@ static void __of_scan_bus(struct device_node *node, struct pci_bus *bus,
 
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
