Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e2.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3E399B700A
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2012 16:48:03 +1000 (EST)
Received: from /spool/local
 by e2.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 29 Jun 2012 02:48:01 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5T6lxD065077454
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2012 02:47:59 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5TCIoVx011672
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2012 08:18:50 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 4/7] pci: fiddle with conversion of pci and CPU address
Date: Fri, 29 Jun 2012 14:47:47 +0800
Message-Id: <0532dabef0679c8cc7a6e2e31e9f27204256b8a8.1340949637.git.shangw@linux.vnet.ibm.com>
In-Reply-To: <cover.1340949637.git.shangw@linux.vnet.ibm.com>
References: <cover.1340949637.git.shangw@linux.vnet.ibm.com>
In-Reply-To: <cover.1340949637.git.shangw@linux.vnet.ibm.com>
References: <cover.1340949637.git.shangw@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, yinghai@kernel.org,
 Gavin Shan <shangw@linux.vnet.ibm.com>, linuxram@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch fiddles with the those functions used to do conversion
between PCI and CPU address. More specificly, 2 functions are
involved: pcibios_bus_to_resource() and pcibios_resource_to_bus()

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 drivers/pci/host-bridge.c |   24 +++++++++++++++++++-----
 include/linux/pci.h       |    5 ++++-
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
index a43d393..1854a2d 100644
--- a/drivers/pci/host-bridge.c
+++ b/drivers/pci/host-bridge.c
@@ -37,10 +37,10 @@ static bool resource_contains(struct resource *res1, struct resource *res2)
 	return res1->start <= res2->start && res1->end >= res2->end;
 }
 
-void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
-			     struct resource *res)
+void __pcibios_resource_to_bus(struct pci_bus *bus, struct pci_bus_region *region,
+			       struct resource *res)
 {
-	struct pci_host_bridge *bridge = find_pci_host_bridge(dev->bus);
+	struct pci_host_bridge *bridge = find_pci_host_bridge(bus);
 	struct pci_host_bridge_window *window;
 	resource_size_t offset = 0;
 
@@ -57,6 +57,13 @@ void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
 	region->start = res->start - offset;
 	region->end = res->end - offset;
 }
+
+void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
+			     struct resource *res)
+{
+	__pcibios_resource_to_bus(dev->bus, region, res);
+}
+
 EXPORT_SYMBOL(pcibios_resource_to_bus);
 
 static bool region_contains(struct pci_bus_region *region1,
@@ -65,10 +72,10 @@ static bool region_contains(struct pci_bus_region *region1,
 	return region1->start <= region2->start && region1->end >= region2->end;
 }
 
-void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
+void __pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
 			     struct pci_bus_region *region)
 {
-	struct pci_host_bridge *bridge = find_pci_host_bridge(dev->bus);
+	struct pci_host_bridge *bridge = find_pci_host_bridge(bus);
 	struct pci_host_bridge_window *window;
 	resource_size_t offset = 0;
 
@@ -90,4 +97,11 @@ void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
 	res->start = region->start + offset;
 	res->end = region->end + offset;
 }
+
+void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
+			     struct pci_bus_region *region)
+{
+	__pcibios_bus_to_resource(dev->bus, res, region);
+}
+
 EXPORT_SYMBOL(pcibios_bus_to_resource);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 615ac90..e66f4b2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -657,9 +657,12 @@ void pcibios_update_irq(struct pci_dev *, int irq);
 void pci_fixup_cardbus(struct pci_bus *);
 
 /* Generic PCI functions used internally */
-
+void __pcibios_resource_to_bus(struct pci_bus *bus, struct pci_bus_region *region,
+				struct resource *res);
 void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
 			     struct resource *res);
+void __pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
+			       struct pci_bus_region *region);
 void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
 			     struct pci_bus_region *region);
 void pcibios_scan_specific_bus(int busn);
-- 
1.7.9.5
