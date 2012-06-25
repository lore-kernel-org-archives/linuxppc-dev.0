Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e34.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 12944B70B5
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2012 13:11:06 +1000 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Sun, 24 Jun 2012 21:11:03 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id C5DA21FF001C
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2012 03:10:30 +0000 (WET)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5P3AVFY212132
 for <linuxppc-dev@ozlabs.org>; Sun, 24 Jun 2012 21:10:31 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5P3AUcK017947
 for <linuxppc-dev@ozlabs.org>; Sun, 24 Jun 2012 21:10:31 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH V3 1/2] PCI: retrieve host bridge by PCI bus
Date: Mon, 25 Jun 2012 11:10:19 +0800
Message-Id: <1340593821-19011-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With current implementation, there is one function to retrieve
the corresponding host bridge (struct pci_host_bridge) according
to the given PCI device (struct pci_dev) and that function has
been declared as "static". Further, we don't have the public
function to retrieve host bridge from PCI bus yet. The function
is useful somewhere.

The additional information like minimal resource alignment for I/O
and MMIO bars of p2p bridges will be put into the PCI host bridge.
The patch introduces the public function pci_bus_host_bridge() to
retrieve the corresponding PCI host bridge according to the specified
PCI bus, then accessing the information regarding the minimal resource
alignment for I/O and MMIO bars of p2p bridges.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
Reviewed-by: Ram Pai <linuxram@us.ibm.com>
Reviewed-by: Richard Yang <weiyang@linux.vnet.ibm.com>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/pci/host-bridge.c |   13 +++++++++++++
 include/linux/pci.h       |    2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
index a68dc61..b95f0ce 100644
--- a/drivers/pci/host-bridge.c
+++ b/drivers/pci/host-bridge.c
@@ -27,6 +27,19 @@ static struct pci_host_bridge *find_pci_host_bridge(struct pci_dev *dev)
 	return to_pci_host_bridge(bus->bridge);
 }
 
+struct pci_host_bridge *pci_bus_host_bridge(struct pci_bus *bus)
+{
+	struct pci_bus *b = bus;
+
+	/* Find the PCI root bus */
+	while (b->parent)
+		b = b->parent;
+
+	return to_pci_host_bridge(b->bridge);
+}
+
+EXPORT_SYMBOL(pci_bus_host_bridge);
+
 void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
 				 void (*release_fn)(struct pci_host_bridge *),
 				 void *release_data)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index fefb4e1..6d5bb1c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -656,7 +656,7 @@ void pcibios_update_irq(struct pci_dev *, int irq);
 void pci_fixup_cardbus(struct pci_bus *);
 
 /* Generic PCI functions used internally */
-
+struct pci_host_bridge *pci_bus_host_bridge(struct pci_bus *bus);
 void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
 			     struct resource *res);
 void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
-- 
1.7.9.5
