Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41sKK63ZXZzDr5p
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 20:32:41 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 07/15] PCI/ACPI: clean up acpi_pci_root_create()
Date: Fri, 17 Aug 2018 12:26:37 +0200
Message-Id: <20180817102645.3839621-8-arnd@arndb.de>
In-Reply-To: <20180817102645.3839621-1-arnd@arndb.de>
References: <20180817102645.3839621-1-arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The acpi_pci_create_root_bus() can be fully integrated into
acpi_pci_root_create(), improving a few things:

* We can call pci_scan_root_bus_bridge(), which registers and
  scans the bridge in one step.
* After a failure in pci_register_host_bridge(), we correctly
  clean up the resources.
* The bridge settings (release function, flags, operations etc)
  can get set up before registering the bridge.
* Further cleanup would be possible, removing duplication between
  pci_host_bridge and some ACPI structures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/acpi/pci_root.c | 68 +++++++++++++++--------------------------
 1 file changed, 24 insertions(+), 44 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 85dbcf47015b..5f73de3b67c8 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -873,34 +873,6 @@ static void acpi_pci_root_release_info(struct pci_host_bridge *bridge)
 	__acpi_pci_root_release_info(bridge->release_data);
 }
 
-static struct pci_bus *acpi_pci_create_root_bus(struct device *parent, int bus,
-		struct pci_ops *ops, void *sysdata, struct list_head *resources)
-{
-	int error;
-	struct pci_host_bridge *bridge;
-
-	bridge = pci_alloc_host_bridge(0);
-	if (!bridge)
-		return NULL;
-
-	bridge->dev.parent = parent;
-
-	list_splice_init(resources, &bridge->windows);
-	bridge->sysdata = sysdata;
-	bridge->busnr = bus;
-	bridge->ops = ops;
-
-	error = pci_register_host_bridge(bridge);
-	if (error < 0)
-		goto err_out;
-
-	return bridge->bus;
-
-err_out:
-	kfree(bridge);
-	return NULL;
-}
-
 struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 				     struct acpi_pci_root_ops *ops,
 				     struct acpi_pci_root_info *info,
@@ -909,8 +881,7 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 	int ret, busnum = root->secondary.start;
 	struct acpi_device *device = root->device;
 	int node = acpi_get_node(device->handle);
-	struct pci_bus *bus;
-	struct pci_host_bridge *host_bridge;
+	struct pci_host_bridge *bridge;
 
 	info->root = root;
 	info->bridge = device;
@@ -930,30 +901,39 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 
 	pci_acpi_root_add_resources(info);
 	pci_add_resource(&info->resources, &root->secondary);
-	bus = acpi_pci_create_root_bus(NULL, busnum, ops->pci_ops,
-				  sysdata, &info->resources);
-	if (!bus)
+
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
 		goto out_release_info;
 
-	host_bridge = to_pci_host_bridge(bus->bridge);
+	list_splice_init(&info->resources, &bridge->windows);
+	bridge->sysdata = sysdata;
+	bridge->busnr = busnum;
+	bridge->ops = ops->pci_ops;
+	pci_set_host_bridge_release(bridge, acpi_pci_root_release_info,
+				    info);
+
 	if (!(root->osc_control_set & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL))
-		host_bridge->native_pcie_hotplug = 0;
+		bridge->native_pcie_hotplug = 0;
 	if (!(root->osc_control_set & OSC_PCI_SHPC_NATIVE_HP_CONTROL))
-		host_bridge->native_shpc_hotplug = 0;
+		bridge->native_shpc_hotplug = 0;
 	if (!(root->osc_control_set & OSC_PCI_EXPRESS_AER_CONTROL))
-		host_bridge->native_aer = 0;
+		bridge->native_aer = 0;
 	if (!(root->osc_control_set & OSC_PCI_EXPRESS_PME_CONTROL))
-		host_bridge->native_pme = 0;
+		bridge->native_pme = 0;
 	if (!(root->osc_control_set & OSC_PCI_EXPRESS_LTR_CONTROL))
-		host_bridge->native_ltr = 0;
+		bridge->native_ltr = 0;
+
+	ret = pci_scan_root_bus_bridge(bridge);
+	if (ret < 0)
+		goto out_release_bridge;
 
-	pci_scan_child_bus(bus);
-	pci_set_host_bridge_release(host_bridge, acpi_pci_root_release_info,
-				    info);
 	if (node != NUMA_NO_NODE)
-		dev_printk(KERN_DEBUG, &bus->dev, "on NUMA node %d\n", node);
-	return bus;
+		dev_printk(KERN_DEBUG, &bridge->bus->dev, "on NUMA node %d\n", node);
+	return bridge->bus;
 
+out_release_bridge:
+	pci_free_host_bridge(bridge);
 out_release_info:
 	__acpi_pci_root_release_info(info);
 	return NULL;
-- 
2.18.0
