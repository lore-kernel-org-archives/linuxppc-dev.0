Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41sKKV74xtzDrb6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 20:33:02 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 01/15] PCI: clean up legacy host bridge scan functions
Date: Fri, 17 Aug 2018 12:26:31 +0200
Message-Id: <20180817102645.3839621-2-arnd@arndb.de>
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

Aside from the modern pci_host_bridge based interfaces, we have a couple
of interfaces from old times that are still used in a couple of platforms:
pci_create_root_bus(), pci_scan_bus() and pci_scan_root_bus().

As a first step towards getting everybody to use the new interfaces,
this simplifies the latter two to call the pci_alloc_host_bridge() and
pci_register_host_bridge()/pci_scan_root_bus_bridge() interfaces directly.

The behavior should be entirely unchanged here, but we can then push
down the functions into the individual host implementations.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/probe.c | 86 ++++++++++++++++++++++++---------------------
 1 file changed, 45 insertions(+), 41 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ec784009a36b..b0f666271245 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -23,13 +23,6 @@
 #define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
 #define CARDBUS_RESERVE_BUSNR	3
 
-static struct resource busn_resource = {
-	.name	= "PCI busn",
-	.start	= 0,
-	.end	= 255,
-	.flags	= IORESOURCE_BUS,
-};
-
 /* Ugh.  Need to stop exporting this to modules. */
 LIST_HEAD(pci_root_buses);
 EXPORT_SYMBOL(pci_root_buses);
@@ -3060,53 +3053,64 @@ EXPORT_SYMBOL(pci_scan_root_bus_bridge);
 struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
 		struct pci_ops *ops, void *sysdata, struct list_head *resources)
 {
-	struct resource_entry *window;
-	bool found = false;
-	struct pci_bus *b;
-	int max;
-
-	resource_list_for_each_entry(window, resources)
-		if (window->res->flags & IORESOURCE_BUS) {
-			found = true;
-			break;
-		}
+	struct pci_host_bridge *bridge;
+	int error;
 
-	b = pci_create_root_bus(parent, bus, ops, sysdata, resources);
-	if (!b)
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
 		return NULL;
 
-	if (!found) {
-		dev_info(&b->dev,
-		 "No busn resource found for root bus, will use [bus %02x-ff]\n",
-			bus);
-		pci_bus_insert_busn_res(b, bus, 255);
-	}
+	list_splice_init(resources, &bridge->windows);
+	bridge->dev.parent = parent;
+	bridge->sysdata = sysdata;
+	bridge->busnr = bus;
+	bridge->ops = ops;
 
-	max = pci_scan_child_bus(b);
+	error = pci_scan_root_bus_bridge(bridge);
+	if (error < 0)
+		goto err_out;
 
-	if (!found)
-		pci_bus_update_busn_res_end(b, max);
+	return bridge->bus;
 
-	return b;
+err_out:
+	kfree(bridge);
+	return NULL;
 }
 EXPORT_SYMBOL(pci_scan_root_bus);
 
+static struct resource busn_resource = {
+	.name	= "PCI busn",
+	.start	= 0,
+	.end	= 255,
+	.flags	= IORESOURCE_BUS,
+};
+
 struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops,
 					void *sysdata)
 {
-	LIST_HEAD(resources);
-	struct pci_bus *b;
+	struct pci_host_bridge *bridge;
+	int error;
 
-	pci_add_resource(&resources, &ioport_resource);
-	pci_add_resource(&resources, &iomem_resource);
-	pci_add_resource(&resources, &busn_resource);
-	b = pci_create_root_bus(NULL, bus, ops, sysdata, &resources);
-	if (b) {
-		pci_scan_child_bus(b);
-	} else {
-		pci_free_resource_list(&resources);
-	}
-	return b;
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
+		goto err;
+
+	pci_add_resource(&bridge->windows, &ioport_resource);
+	pci_add_resource(&bridge->windows, &iomem_resource);
+	pci_add_resource(&bridge->windows, &busn_resource);
+	bridge->sysdata = sysdata;
+	bridge->busnr = bus;
+	bridge->ops = ops;
+
+	error = pci_scan_root_bus_bridge(bridge);
+	if (error < 0)
+		goto err;
+
+	return bridge->bus;
+
+err:
+	pci_free_host_bridge(bridge);
+	return NULL;
 }
 EXPORT_SYMBOL(pci_scan_bus);
 
-- 
2.18.0
