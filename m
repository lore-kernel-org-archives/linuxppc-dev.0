Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41sKV71DYvzF0h9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 20:40:30 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 13/15] PCI: turn pcibios_alloc_irq into a callback
Date: Fri, 17 Aug 2018 12:26:43 +0200
Message-Id: <20180817102645.3839621-14-arnd@arndb.de>
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

Weak functions are a bit confusing, and we can better deal with
this using a callback function. pcibios_free_irq() is actually
completely unused, but it seems better to treat it the same way
as the allocation, unless we want to remove it completely.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/kernel/pci.c  | 16 +++-------------
 drivers/pci/pci-driver.c | 13 +++++++++++--
 include/linux/pci.h      |  2 ++
 3 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 0e2ea1c78542..3d196c68e362 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -22,19 +22,6 @@
 #include <linux/pci-ecam.h>
 #include <linux/slab.h>
 
-#ifdef CONFIG_ACPI
-/*
- * Try to assign the IRQ number when probing a new device
- */
-int pcibios_alloc_irq(struct pci_dev *dev)
-{
-	if (!acpi_disabled)
-		acpi_pci_irq_enable(dev);
-
-	return 0;
-}
-#endif
-
 /*
  * raw_pci_read/write - Platform-specific PCI config space access.
  */
@@ -93,6 +80,9 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
 
 		ACPI_COMPANION_SET(&bridge->dev, adev);
 		set_dev_node(bus_dev, acpi_get_node(acpi_device_handle(adev)));
+
+		/* Try to assign the IRQ number when probing a new device */
+		bridge->alloc_irq = acpi_pci_irq_enable;
 	}
 
 	return 0;
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index bef17c3fca67..c96bc7bd56da 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -387,13 +387,22 @@ static int __pci_device_probe(struct pci_driver *drv, struct pci_dev *pci_dev)
 	return error;
 }
 
-int __weak pcibios_alloc_irq(struct pci_dev *dev)
+int pcibios_alloc_irq(struct pci_dev *dev)
 {
+	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
+
+	if (bridge->alloc_irq)
+		return bridge->alloc_irq(dev);
+
 	return 0;
 }
 
-void __weak pcibios_free_irq(struct pci_dev *dev)
+void pcibios_free_irq(struct pci_dev *dev)
 {
+	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
+
+	if (bridge->free_irq)
+		bridge->free_irq(dev);
 }
 
 #ifdef CONFIG_PCI_IOV
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d1072690cb4f..1296d9fcc5da 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -476,6 +476,8 @@ struct pci_host_bridge {
 	int (*map_irq)(const struct pci_dev *, u8, u8);
 	void (*release_fn)(struct pci_host_bridge *);
 	void (*bus_add_device)(struct pci_dev *pdev);
+	int (*alloc_irq)(struct pci_dev *);
+	int (*free_irq)(struct pci_dev *);
 	void		*release_data;
 	struct msi_controller *msi;
 	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
-- 
2.18.0
