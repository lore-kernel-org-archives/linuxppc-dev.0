Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 78E4710082E
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2012 16:48:49 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 29 Jun 2012 02:48:46 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5T6m091382472
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2012 02:48:00 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5T6lxUs001746
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2012 03:48:00 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 6/7] pci: function to retrieve alignment of p2p bars
Date: Fri, 29 Jun 2012 14:47:49 +0800
Message-Id: <9229382f79ce3eeb4645160b5349a51bb51db06b.1340949637.git.shangw@linux.vnet.ibm.com>
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

The patch introduces function pci_align_boundary() to retrieve the
minimal alignment of p2p bars according to the argument.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 drivers/pci/host-bridge.c |   24 ++++++++++++++++++++++++
 include/linux/pci.h       |    1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
index 1854a2d..dc9a95e 100644
--- a/drivers/pci/host-bridge.c
+++ b/drivers/pci/host-bridge.c
@@ -105,3 +105,27 @@ void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
 }
 
 EXPORT_SYMBOL(pcibios_bus_to_resource);
+
+resource_size_t pci_align_boundary(struct pci_bus *bus, unsigned long flags)
+{
+	resource_size_t align = 0;
+	struct pci_host_bridge *bridge = find_pci_host_bridge(bus);
+
+	flags &= (IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_PREFETCH);
+	switch (flags) {
+	case IORESOURCE_IO:
+		align = (1 << bridge->io_align_shift);
+		break;
+	case IORESOURCE_MEM:
+		align = (1 << bridge->mem_align_shift);
+		break;
+	case (IORESOURCE_MEM | IORESOURCE_PREFETCH):
+		align = (1 << bridge->pmem_align_shift);
+		break;
+	default:
+		printk(KERN_WARNING "%s: invalid flags 0x%lx\n",
+			__func__, flags);
+	}
+
+	return align;
+}
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2b2b38d..64523ef 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -673,6 +673,7 @@ void __pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
 			       struct pci_bus_region *region);
 void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
 			     struct pci_bus_region *region);
+resource_size_t pci_align_boundary(struct pci_bus *bus, unsigned long flags);
 void pcibios_scan_specific_bus(int busn);
 extern struct pci_bus *pci_find_bus(int domain, int busnr);
 void pci_bus_add_devices(const struct pci_bus *bus);
-- 
1.7.9.5
