Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41sKKP0XfRzF0gL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 20:32:56 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 10/15] sparc/PCI: simplify pci_scan_one_pbm
Date: Fri, 17 Aug 2018 12:26:40 +0200
Message-Id: <20180817102645.3839621-11-arnd@arndb.de>
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

We no longer need a separate pci_create_root_bus() function, and
merging it into pci_scan_one_pbm() makes the implementation easier
to understand.

A possible future cleanup would move the allocation of the
pci_host_bridge structure into the callers of pci_scan_one_pbm,
and avoid duplication between pci_host_bridge and pci_pbm_info
fields.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sparc/kernel/pci.c | 62 ++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 41 deletions(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index afbce59d9231..0d34fb2ac55b 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -691,70 +691,50 @@ static void pci_claim_bus_resources(struct pci_bus *bus)
 		pci_claim_bus_resources(child_bus);
 }
 
-static struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
-		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+struct pci_bus *pci_scan_one_pbm(struct pci_pbm_info *pbm,
+				 struct device *parent)
 {
-	int error;
+	struct device_node *node = pbm->op->dev.of_node;
 	struct pci_host_bridge *bridge;
+	int ret;
 
 	bridge = pci_alloc_host_bridge(0);
 	if (!bridge)
 		return NULL;
 
 	bridge->dev.parent = parent;
+	bridge->sysdata = pbm;
+	bridge->busnr = pbm->pci_first_busno;
+	bridge->ops = pbm->pci_ops;
 
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
-struct pci_bus *pci_scan_one_pbm(struct pci_pbm_info *pbm,
-				 struct device *parent)
-{
-	LIST_HEAD(resources);
-	struct device_node *node = pbm->op->dev.of_node;
-	struct pci_bus *bus;
-
-	printk("PCI: Scanning PBM %s\n", node->full_name);
-
-	pci_add_resource_offset(&resources, &pbm->io_space,
+	pci_add_resource_offset(&bridge->windows, &pbm->io_space,
 				pbm->io_offset);
-	pci_add_resource_offset(&resources, &pbm->mem_space,
+	pci_add_resource_offset(&bridge->windows, &pbm->mem_space,
 				pbm->mem_offset);
 	if (pbm->mem64_space.flags)
-		pci_add_resource_offset(&resources, &pbm->mem64_space,
+		pci_add_resource_offset(&bridge->windows, &pbm->mem64_space,
 					pbm->mem64_offset);
 	pbm->busn.start = pbm->pci_first_busno;
 	pbm->busn.end	= pbm->pci_last_busno;
 	pbm->busn.flags	= IORESOURCE_BUS;
-	pci_add_resource(&resources, &pbm->busn);
-	bus = pci_create_root_bus(parent, pbm->pci_first_busno, pbm->pci_ops,
-				  pbm, &resources);
-	if (!bus) {
+	pci_add_resource(&bridge->windows, &pbm->busn);
+
+	printk("PCI: Scanning PBM %s\n", node->full_name);
+	ret = pci_register_host_bridge(bridge);
+	if (!ret) {
 		printk(KERN_ERR "Failed to create bus for %s\n",
 		       node->full_name);
-		pci_free_resource_list(&resources);
+		pci_free_host_bridge(bridge);
 		return NULL;
 	}
 
-	pci_of_scan_bus(pbm, node, bus);
-	pci_bus_register_of_sysfs(bus);
+	pci_of_scan_bus(pbm, node, bridge->bus);
+	pci_bus_register_of_sysfs(bridge->bus);
 
-	pci_claim_bus_resources(bus);
+	pci_claim_bus_resources(bridge->bus);
 
-	pci_bus_add_devices(bus);
-	return bus;
+	pci_bus_add_devices(bridge->bus);
+	return bridge->bus;
 }
 
 int pcibios_enable_device(struct pci_dev *dev, int mask)
-- 
2.18.0
