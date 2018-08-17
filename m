Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41sKK61ljZzDqm6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 20:32:41 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 11/15] PCI: hyperv: convert to pci_scan_root_bus_bridge
Date: Fri, 17 Aug 2018 12:26:41 +0200
Message-Id: <20180817102645.3839621-12-arnd@arndb.de>
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

create_root_hv_pci_bus() uses a rather generic method of probing the host
bridge, which can be simplified by just calling pci_scan_root_bus_bridge()
after setting up the pci_host_bridge structure.

Since we can no longer assign hbus->pci_bus in the middle, I just remove
that member completely and use the pci_host_bridge instead.

Ideally we'd convert it to pci_host_probe() for simplicity, but
that is a bit different and I could not easily test it. Using
pci_scan_root_bus_bridge should not change the behavior at all.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/controller/pci-hyperv.c | 75 +++++++++++------------------
 1 file changed, 28 insertions(+), 47 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index df7cddea8e30..49586aefa38b 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -443,7 +443,7 @@ struct hv_pcibus_device {
 	struct resource *high_mmio_res;
 	struct completion *survey_event;
 	struct completion remove_event;
-	struct pci_bus *pci_bus;
+	struct pci_host_bridge *bridge;
 	spinlock_t config_lock;	/* Avoid two threads writing index page */
 	spinlock_t device_list_lock;	/* Protect lists below */
 	void __iomem *cfg_addr;
@@ -1457,34 +1457,6 @@ static void prepopulate_bars(struct hv_pcibus_device *hbus)
 	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
 }
 
-static struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
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
 /**
  * create_root_hv_pci_bus() - Expose a new root PCI bus
  * @hbus:	Root PCI bus, as understood by this driver
@@ -1493,25 +1465,34 @@ static struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
  */
 static int create_root_hv_pci_bus(struct hv_pcibus_device *hbus)
 {
-	/* Register the device */
-	hbus->pci_bus = pci_create_root_bus(&hbus->hdev->device,
-					    0, /* bus number is always zero */
-					    &hv_pcifront_ops,
-					    &hbus->sysdata,
-					    &hbus->resources_for_children);
-	if (!hbus->pci_bus)
-		return -ENODEV;
+	struct pci_host_bridge *bridge;
+	int ret;
+
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
+		return -ENOMEM;
 
-	hbus->pci_bus->msi = &hbus->msi_chip;
-	hbus->pci_bus->msi->dev = &hbus->hdev->device;
+	hbus->bridge = bridge;
+	bridge->dev.parent = &hbus->hdev->device;
+	list_splice_init(&hbus->resources_for_children, &bridge->windows);
+	bridge->sysdata = &hbus->sysdata;
+	bridge->ops = &hv_pcifront_ops;
+	bridge->msi = &hbus->msi_chip;
+	bridge->msi->dev = &hbus->hdev->device;
 
 	pci_lock_rescan_remove();
-	pci_scan_child_bus(hbus->pci_bus);
-	pci_bus_assign_resources(hbus->pci_bus);
-	pci_bus_add_devices(hbus->pci_bus);
-	pci_unlock_rescan_remove();
+	/* ideally we should use pci_host_probe here */
+	ret = pci_scan_root_bus_bridge(bridge);
+	if (ret < 0) {
+		pci_free_host_bridge(bridge);
+		goto error;
+	}
+	pci_bus_assign_resources(bridge->bus);
+	pci_bus_add_devices(bridge->bus);
 	hbus->state = hv_pcibus_installed;
-	return 0;
+error:
+	pci_unlock_rescan_remove();
+	return ret;
 }
 
 struct q_res_req_compl {
@@ -1769,7 +1750,7 @@ static void pci_devices_present_work(struct work_struct *work)
 		 * because there may have been changes.
 		 */
 		pci_lock_rescan_remove();
-		pci_scan_child_bus(hbus->pci_bus);
+		pci_scan_child_bus(hbus->bridge->bus);
 		pci_unlock_rescan_remove();
 		break;
 
@@ -2669,8 +2650,8 @@ static int hv_pci_remove(struct hv_device *hdev)
 	if (hbus->state == hv_pcibus_installed) {
 		/* Remove the bus from PCI's point of view. */
 		pci_lock_rescan_remove();
-		pci_stop_root_bus(hbus->pci_bus);
-		pci_remove_root_bus(hbus->pci_bus);
+		pci_stop_root_bus(hbus->bridge->bus);
+		pci_remove_root_bus(hbus->bridge->bus);
 		pci_unlock_rescan_remove();
 		hbus->state = hv_pcibus_removed;
 	}
-- 
2.18.0
