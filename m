Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41sKK45cX4zDr5p
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 20:32:40 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 02/15] PCI: move pci_scan_bus into callers
Date: Fri, 17 Aug 2018 12:26:32 +0200
Message-Id: <20180817102645.3839621-3-arnd@arndb.de>
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

There are only two remaining callers of the old pci_scan_bus()
interface. Since we want to expose the pci_host_bridge structure
everywhere and discourage users from calling the old interfaces,
let's move the implementation into the respective callsites.

While this duplicates the source code, it makes the object code
smaller for all users by avoiding the global implementation,
and it allows further cleanup of the two callers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sparc/kernel/pcic.c          | 35 ++++++++++++++++++++++++++++++
 drivers/pci/hotplug/ibmphp_core.c | 35 ++++++++++++++++++++++++++++++
 drivers/pci/probe.c               | 36 -------------------------------
 include/linux/pci.h               |  1 -
 4 files changed, 70 insertions(+), 37 deletions(-)

diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
index ee4c9a9a171c..0197b80fe590 100644
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -387,6 +387,41 @@ int __init pcic_probe(void)
 	return 0;
 }
 
+static struct resource busn_resource = {
+	.name	= "PCI busn",
+	.start	= 0,
+	.end	= 255,
+	.flags	= IORESOURCE_BUS,
+};
+
+static struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops,
+					void *sysdata)
+{
+	struct pci_host_bridge *bridge;
+	int error;
+
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
+		return NULL;
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
+err_res:
+	pci_free_host_bridge(bridge);
+	return NULL;
+}
+
 static void __init pcic_pbm_scan_bus(struct linux_pcic *pcic)
 {
 	struct linux_pbm_info *pbm = &pcic->pbm;
diff --git a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
index 4ea57e9019f1..d35463ee96ba 100644
--- a/drivers/pci/hotplug/ibmphp_core.c
+++ b/drivers/pci/hotplug/ibmphp_core.c
@@ -717,6 +717,41 @@ static void ibm_unconfigure_device(struct pci_func *func)
 	pci_unlock_rescan_remove();
 }
 
+static struct resource busn_resource = {
+	.name	= "pci busn",
+	.start	= 0,
+	.end	= 255,
+	.flags	= IORESOURCE_BUS,
+};
+
+static struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops,
+					void *sysdata)
+{
+	struct pci_host_bridge *bridge;
+	int error;
+
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
+		return NULL;
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
+}
+
 /*
  * The following function is to fix kernel bug regarding
  * getting bus entries, here we manually add those primary
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b0f666271245..12c3aa63c34d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3078,42 +3078,6 @@ struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
 }
 EXPORT_SYMBOL(pci_scan_root_bus);
 
-static struct resource busn_resource = {
-	.name	= "PCI busn",
-	.start	= 0,
-	.end	= 255,
-	.flags	= IORESOURCE_BUS,
-};
-
-struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops,
-					void *sysdata)
-{
-	struct pci_host_bridge *bridge;
-	int error;
-
-	bridge = pci_alloc_host_bridge(0);
-	if (!bridge)
-		goto err;
-
-	pci_add_resource(&bridge->windows, &ioport_resource);
-	pci_add_resource(&bridge->windows, &iomem_resource);
-	pci_add_resource(&bridge->windows, &busn_resource);
-	bridge->sysdata = sysdata;
-	bridge->busnr = bus;
-	bridge->ops = ops;
-
-	error = pci_scan_root_bus_bridge(bridge);
-	if (error < 0)
-		goto err;
-
-	return bridge->bus;
-
-err:
-	pci_free_host_bridge(bridge);
-	return NULL;
-}
-EXPORT_SYMBOL(pci_scan_bus);
-
 /**
  * pci_rescan_bus_bridge_resize - Scan a PCI bus for devices
  * @bridge: PCI bridge for the bus to scan
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e72ca8dd6241..d77ce35a2b33 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -905,7 +905,6 @@ void pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
 void pcibios_scan_specific_bus(int busn);
 struct pci_bus *pci_find_bus(int domain, int busnr);
 void pci_bus_add_devices(const struct pci_bus *bus);
-struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops, void *sysdata);
 struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 				    struct pci_ops *ops, void *sysdata,
 				    struct list_head *resources);
-- 
2.18.0
