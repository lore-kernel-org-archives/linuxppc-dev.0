Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41sKKW3zZCzDrHP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 20:33:03 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 09/15] PCI: xenfront: clean up pcifront_scan_root()
Date: Fri, 17 Aug 2018 12:26:39 +0200
Message-Id: <20180817102645.3839621-10-arnd@arndb.de>
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

Merging pci_scan_root_bus() into pcifront_scan_root() simplifies
the implementation and makes it more readable. We can allocate
the pcifront_sd structure along with the bridge structure, which
helps manage its lifetime rules so we don't free it before the
device has been released.

There are two small issues that I noticed that could be improved:

- It seems we unregister the 'bus' device that is a child of the
  'pci_host_bridge' device after we unregister its parent in
  pcifront_free_roots(), which seems odd.
- We probably don't need an extra pci_bus_entry list at all,
  but could instead walk the children of the pcifront_device,
  which are all pci_host_bridge devices.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/xen-pcifront.c | 67 ++++++++++++--------------------------
 1 file changed, 21 insertions(+), 46 deletions(-)

diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index 24070e1c5f22..a5eb6cb02bec 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -443,40 +443,12 @@ static int pcifront_scan_bus(struct pcifront_device *pdev,
 	return 0;
 }
 
-static struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
-		struct pci_ops *ops, void *sysdata, struct list_head *resources)
-{
-	struct pci_host_bridge *bridge;
-	int error;
-
-	bridge = pci_alloc_host_bridge(0);
-	if (!bridge)
-		return NULL;
-
-	list_splice_init(resources, &bridge->windows);
-	bridge->dev.parent = parent;
-	bridge->sysdata = sysdata;
-	bridge->busnr = bus;
-	bridge->ops = ops;
-
-	error = pci_scan_root_bus_bridge(bridge);
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
 static int pcifront_scan_root(struct pcifront_device *pdev,
 				 unsigned int domain, unsigned int bus)
 {
-	struct pci_bus *b;
-	LIST_HEAD(resources);
 	struct pcifront_sd *sd = NULL;
 	struct pci_bus_entry *bus_entry = NULL;
+	struct pci_host_bridge *bridge;
 	int err = 0;
 	static struct resource busn_res = {
 		.start = 0,
@@ -498,50 +470,55 @@ static int pcifront_scan_root(struct pcifront_device *pdev,
 	dev_info(&pdev->xdev->dev, "Creating PCI Frontend Bus %04x:%02x\n",
 		 domain, bus);
 
+	bridge = pci_alloc_host_bridge(sizeof(*sd));
+	if (!bridge)
+		return -ENOMEM;
+
 	bus_entry = kzalloc(sizeof(*bus_entry), GFP_KERNEL);
-	sd = kzalloc(sizeof(*sd), GFP_KERNEL);
-	if (!bus_entry || !sd) {
+	sd = pci_host_bridge_priv(bridge);
+	if (!bus_entry) {
 		err = -ENOMEM;
 		goto err_out;
 	}
-	pci_add_resource(&resources, &ioport_resource);
-	pci_add_resource(&resources, &iomem_resource);
-	pci_add_resource(&resources, &busn_res);
+	pci_add_resource(&bridge->windows, &ioport_resource);
+	pci_add_resource(&bridge->windows, &iomem_resource);
+	pci_add_resource(&bridge->windows, &busn_res);
 	pcifront_init_sd(sd, domain, bus, pdev);
+	bridge->dev.parent = &pdev->xdev->dev;
+	bridge->sysdata = sd;
+	bridge->busnr = bus;
+	bridge->ops = &pcifront_bus_ops;
 
 	pci_lock_rescan_remove();
 
-	b = pci_scan_root_bus(&pdev->xdev->dev, bus,
-				  &pcifront_bus_ops, sd, &resources);
-	if (!b) {
+	err = pci_scan_root_bus_bridge(bridge);
+	if (err < 0) {
 		dev_err(&pdev->xdev->dev,
 			"Error creating PCI Frontend Bus!\n");
-		err = -ENOMEM;
 		pci_unlock_rescan_remove();
-		pci_free_resource_list(&resources);
 		goto err_out;
 	}
 
-	bus_entry->bus = b;
+	bus_entry->bus = bridge->bus;
 
 	list_add(&bus_entry->list, &pdev->root_buses);
 
 	/* pci_scan_root_bus skips devices which do not have a
 	* devfn==0. The pcifront_scan_bus enumerates all devfn. */
-	err = pcifront_scan_bus(pdev, domain, bus, b);
+	err = pcifront_scan_bus(pdev, domain, bus, bridge->bus);
 
 	/* Claim resources before going "live" with our devices */
-	pci_walk_bus(b, pcifront_claim_resource, pdev);
+	pci_walk_bus(bridge->bus, pcifront_claim_resource, pdev);
 
 	/* Create SysFS and notify udev of the devices. Aka: "going live" */
-	pci_bus_add_devices(b);
+	pci_bus_add_devices(bridge->bus);
 
 	pci_unlock_rescan_remove();
 	return err;
 
 err_out:
+	pci_free_host_bridge(bridge);
 	kfree(bus_entry);
-	kfree(sd);
 
 	return err;
 }
@@ -605,8 +582,6 @@ static void pcifront_free_roots(struct pcifront_device *pdev)
 
 		free_root_bus_devs(bus_entry->bus);
 
-		kfree(bus_entry->bus->sysdata);
-
 		device_unregister(bus_entry->bus->bridge);
 		pci_remove_bus(bus_entry->bus);
 
-- 
2.18.0
