Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41sKKS34kSzDrWY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 20:32:59 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 04/15] PCI: export pci_register_host_bridge
Date: Fri, 17 Aug 2018 12:26:34 +0200
Message-Id: <20180817102645.3839621-5-arnd@arndb.de>
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

There are a couple of users of the old pci_create_root_bus() interface,
which calls pci_register_host_bridge() without actually scanning the bus.

In order to get those callers a little closer to the current method
of separating the allocation and probing of the host bridge, this
exports the internal interface to modules. If all the callers can
get moved over to pci_host_probe() or pci_scan_root_bus_bridge()
later, the export can be removed again.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/probe.c | 25 ++++++++++++++++++++++++-
 include/linux/pci.h |  1 +
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index cf169742c03e..5ca7d5941ad0 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -762,7 +762,29 @@ static void pci_set_bus_msi_domain(struct pci_bus *bus)
 	dev_set_msi_domain(&bus->dev, d);
 }
 
-static int pci_register_host_bridge(struct pci_host_bridge *bridge)
+/*
+ * pci_register_host_bridge() - Register a host bridge without scanning
+ *
+ * @bridge: a newly allocated host bridge structure
+ *
+ * This is the core part of bringing up a new PCI host bridge,
+ * before we scan for attached devices and register them as
+ * pci_dev.
+ *
+ * For the most part, this is an implementation detail of the
+ * pci_host_probe() interface, which brings up the entire bus,
+ * bus some older platforms still call it directly and manually
+ * scan for devices.
+ *
+ * If your driver uses this, try to convert it to using
+ * pci_host_probe() instead.
+ *
+ * Return: zero on suggess, or a negative error code.
+ * Note: after pci_register_host_bridge() successfully returns,
+ * the pci_host_bridge device is alive in driver core, and must
+ * not be freed directly.
+ */
+int pci_register_host_bridge(struct pci_host_bridge *bridge)
 {
 	struct device *parent = bridge->dev.parent;
 	struct resource_entry *window, *n;
@@ -877,6 +899,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	kfree(bus);
 	return err;
 }
+EXPORT_SYMBOL_GPL(pci_register_host_bridge);
 
 static bool pci_bridge_child_ext_cfg_accessible(struct pci_dev *bridge)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d226e06fb5e5..e1337148cf9f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -909,6 +909,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 				    struct pci_ops *ops, void *sysdata,
 				    struct list_head *resources);
 int pci_host_probe(struct pci_host_bridge *bridge);
+int pci_register_host_bridge(struct pci_host_bridge *);
 int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int busmax);
 int pci_bus_update_busn_res_end(struct pci_bus *b, int busmax);
 void pci_bus_release_busn_res(struct pci_bus *b);
-- 
2.18.0
