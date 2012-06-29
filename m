Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 40CF0B700F
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2012 16:48:02 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 29 Jun 2012 02:47:59 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5T6lubJ393544
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2012 02:47:56 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5T6ltcL006825
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2012 02:47:56 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 2/7] pci: argument pci_bus for find_pci_host_bridge
Date: Fri, 29 Jun 2012 14:47:45 +0800
Message-Id: <c487a34f0968b5583b5b2e53daad23dc9699f85e.1340949637.git.shangw@linux.vnet.ibm.com>
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

The patch changes the argument of find_pci_host_bridge() to pci_bus.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 drivers/pci/host-bridge.c |   13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
index c19776a..fc16357 100644
--- a/drivers/pci/host-bridge.c
+++ b/drivers/pci/host-bridge.c
@@ -9,20 +9,17 @@
 
 #include "pci.h"
 
-static struct pci_bus *find_pci_root_bus(struct pci_dev *dev)
+static struct pci_bus *find_pci_root_bus(struct pci_bus *bus)
 {
-	struct pci_bus *bus;
-
-	bus = dev->bus;
 	while (bus->parent)
 		bus = bus->parent;
 
 	return bus;
 }
 
-static struct pci_host_bridge *find_pci_host_bridge(struct pci_dev *dev)
+static struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus)
 {
-	struct pci_bus *root_bus = find_pci_root_bus(dev);
+	struct pci_bus *root_bus = find_pci_root_bus(bus);
 
 	return to_pci_host_bridge(root_bus->bridge);
 }
@@ -43,7 +40,7 @@ static bool resource_contains(struct resource *res1, struct resource *res2)
 void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
 			     struct resource *res)
 {
-	struct pci_host_bridge *bridge = find_pci_host_bridge(dev);
+	struct pci_host_bridge *bridge = find_pci_host_bridge(dev->bus);
 	struct pci_host_bridge_window *window;
 	resource_size_t offset = 0;
 
@@ -71,7 +68,7 @@ static bool region_contains(struct pci_bus_region *region1,
 void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
 			     struct pci_bus_region *region)
 {
-	struct pci_host_bridge *bridge = find_pci_host_bridge(dev);
+	struct pci_host_bridge *bridge = find_pci_host_bridge(dev->bus);
 	struct pci_host_bridge_window *window;
 	resource_size_t offset = 0;
 
-- 
1.7.9.5
