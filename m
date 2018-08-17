Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41sKKW4LFrzF0kx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 20:33:03 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 05/15] PCI: move pci_create_root_bus into callers
Date: Fri, 17 Aug 2018 12:26:35 +0200
Message-Id: <20180817102645.3839621-6-arnd@arndb.de>
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

There are only seven remaining callers of the old pci_scan_root_bus()
interface. Since we want to expose the pci_host_bridge structure
everywhere and discourage users from calling the old interfaces, let's
move the implementation into the respective callsites.

While this duplicates the source code, it makes the object code smaller
for almost all users by avoiding the global implementation, and it allows
further cleanup of the callers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/kernel/pci-common.c    | 28 +++++++++++++++++++++++++++
 arch/sparc/kernel/pci.c             | 28 +++++++++++++++++++++++++++
 drivers/acpi/pci_root.c             | 30 ++++++++++++++++++++++++++++-
 drivers/parisc/dino.c               | 28 +++++++++++++++++++++++++++
 drivers/parisc/lba_pci.c            | 28 +++++++++++++++++++++++++++
 drivers/pci/controller/pci-hyperv.c | 28 +++++++++++++++++++++++++++
 drivers/pci/controller/vmd.c        | 30 ++++++++++++++++++++++++++++-
 drivers/pci/probe.c                 | 29 ----------------------------
 include/linux/pci.h                 |  3 ---
 9 files changed, 198 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 88e4f69a09e5..57ca621a32f4 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1587,6 +1587,34 @@ struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus)
 	return of_node_get(hose->dn);
 }
 
+static struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
+		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+{
+	int error;
+	struct pci_host_bridge *bridge;
+
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
+		return NULL;
+
+	bridge->dev.parent = parent;
+
+	list_splice_init(resources, &bridge->windows);
+	bridge->sysdata = sysdata;
+	bridge->busnr = bus;
+	bridge->ops = ops;
+
+	error = pci_register_host_bridge(bridge);
+	if (error < 0)
+		goto err_out;
+
+	return bridge->bus;
+
+err_out:
+	kfree(bridge);
+	return NULL;
+}
+
 /**
  * pci_scan_phb - Given a pci_controller, setup and scan the PCI bus
  * @hose: Pointer to the PCI host controller instance structure
diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 17ea16a1337c..afbce59d9231 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -691,6 +691,34 @@ static void pci_claim_bus_resources(struct pci_bus *bus)
 		pci_claim_bus_resources(child_bus);
 }
 
+static struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
+		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+{
+	int error;
+	struct pci_host_bridge *bridge;
+
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
+		return NULL;
+
+	bridge->dev.parent = parent;
+
+	list_splice_init(resources, &bridge->windows);
+	bridge->sysdata = sysdata;
+	bridge->busnr = bus;
+	bridge->ops = ops;
+
+	error = pci_register_host_bridge(bridge);
+	if (error < 0)
+		goto err_out;
+
+	return bridge->bus;
+
+err_out:
+	kfree(bridge);
+	return NULL;
+}
+
 struct pci_bus *pci_scan_one_pbm(struct pci_pbm_info *pbm,
 				 struct device *parent)
 {
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 7433035ded95..85dbcf47015b 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -873,6 +873,34 @@ static void acpi_pci_root_release_info(struct pci_host_bridge *bridge)
 	__acpi_pci_root_release_info(bridge->release_data);
 }
 
+static struct pci_bus *acpi_pci_create_root_bus(struct device *parent, int bus,
+		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+{
+	int error;
+	struct pci_host_bridge *bridge;
+
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
+		return NULL;
+
+	bridge->dev.parent = parent;
+
+	list_splice_init(resources, &bridge->windows);
+	bridge->sysdata = sysdata;
+	bridge->busnr = bus;
+	bridge->ops = ops;
+
+	error = pci_register_host_bridge(bridge);
+	if (error < 0)
+		goto err_out;
+
+	return bridge->bus;
+
+err_out:
+	kfree(bridge);
+	return NULL;
+}
+
 struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 				     struct acpi_pci_root_ops *ops,
 				     struct acpi_pci_root_info *info,
@@ -902,7 +930,7 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 
 	pci_acpi_root_add_resources(info);
 	pci_add_resource(&info->resources, &root->secondary);
-	bus = pci_create_root_bus(NULL, busnum, ops->pci_ops,
+	bus = acpi_pci_create_root_bus(NULL, busnum, ops->pci_ops,
 				  sysdata, &info->resources);
 	if (!bus)
 		goto out_release_info;
diff --git a/drivers/parisc/dino.c b/drivers/parisc/dino.c
index 7390fb8ca9d1..91c837de7616 100644
--- a/drivers/parisc/dino.c
+++ b/drivers/parisc/dino.c
@@ -882,6 +882,34 @@ static const char *cujo_vers[] = {
 
 void ccio_cujo20_fixup(struct parisc_device *dev, u32 iovp);
 
+static struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
+		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+{
+	int error;
+	struct pci_host_bridge *bridge;
+
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
+		return NULL;
+
+	bridge->dev.parent = parent;
+
+	list_splice_init(resources, &bridge->windows);
+	bridge->sysdata = sysdata;
+	bridge->busnr = bus;
+	bridge->ops = ops;
+
+	error = pci_register_host_bridge(bridge);
+	if (error < 0)
+		goto err_out;
+
+	return bridge->bus;
+
+err_out:
+	kfree(bridge);
+	return NULL;
+}
+
 /*
 ** Determine if dino should claim this chip (return 0) or not (return 1).
 ** If so, initialize the chip appropriately (card-mode vs bridge mode).
diff --git a/drivers/parisc/lba_pci.c b/drivers/parisc/lba_pci.c
index 69bd98421eb1..901b7f07fe91 100644
--- a/drivers/parisc/lba_pci.c
+++ b/drivers/parisc/lba_pci.c
@@ -1464,6 +1464,34 @@ lba_hw_init(struct lba_device *d)
  */
 static unsigned int lba_next_bus = 0;
 
+static struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
+		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+{
+	int error;
+	struct pci_host_bridge *bridge;
+
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
+		return NULL;
+
+	bridge->dev.parent = parent;
+
+	list_splice_init(resources, &bridge->windows);
+	bridge->sysdata = sysdata;
+	bridge->busnr = bus;
+	bridge->ops = ops;
+
+	error = pci_register_host_bridge(bridge);
+	if (error < 0)
+		goto err_out;
+
+	return bridge->bus;
+
+err_out:
+	kfree(bridge);
+	return NULL;
+}
+
 /*
  * Determine if lba should claim this chip (return 0) or not (return 1).
  * If so, initialize the chip and tell other partners in crime they
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index c00f82cc54aa..df7cddea8e30 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1457,6 +1457,34 @@ static void prepopulate_bars(struct hv_pcibus_device *hbus)
 	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
 }
 
+static struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
+		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+{
+	int error;
+	struct pci_host_bridge *bridge;
+
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
+		return NULL;
+
+	bridge->dev.parent = parent;
+
+	list_splice_init(resources, &bridge->windows);
+	bridge->sysdata = sysdata;
+	bridge->busnr = bus;
+	bridge->ops = ops;
+
+	error = pci_register_host_bridge(bridge);
+	if (error < 0)
+		goto err_out;
+
+	return bridge->bus;
+
+err_out:
+	kfree(bridge);
+	return NULL;
+}
+
 /**
  * create_root_hv_pci_bus() - Expose a new root PCI bus
  * @hbus:	Root PCI bus, as understood by this driver
diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index fd2dbd7eed7b..311c9f6761ae 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -579,6 +579,34 @@ static int vmd_find_free_domain(void)
 	return domain + 1;
 }
 
+static struct pci_bus *vmd_create_root_bus(struct device *parent, int bus,
+		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+{
+	int error;
+	struct pci_host_bridge *bridge;
+
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
+		return NULL;
+
+	bridge->dev.parent = parent;
+
+	list_splice_init(resources, &bridge->windows);
+	bridge->sysdata = sysdata;
+	bridge->busnr = bus;
+	bridge->ops = ops;
+
+	error = pci_register_host_bridge(bridge);
+	if (error < 0)
+		goto err_out;
+
+	return bridge->bus;
+
+err_out:
+	kfree(bridge);
+	return NULL;
+}
+
 static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 {
 	struct pci_sysdata *sd = &vmd->sysdata;
@@ -705,7 +733,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
 	pci_add_resource_offset(&resources, &vmd->resources[2], offset[1]);
 
-	vmd->bus = pci_create_root_bus(&vmd->dev->dev, busn_start, &vmd_ops,
+	vmd->bus = vmd_create_root_bus(&vmd->dev->dev, busn_start, &vmd_ops,
 				       sd, &resources);
 	if (!vmd->bus) {
 		pci_free_resource_list(&resources);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 5ca7d5941ad0..eaedb4fe143a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2909,35 +2909,6 @@ void __weak pcibios_remove_bus(struct pci_bus *bus)
 {
 }
 
-struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
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
-EXPORT_SYMBOL_GPL(pci_create_root_bus);
-
 int pci_host_probe(struct pci_host_bridge *bridge)
 {
 	struct pci_bus *bus, *child;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e1337148cf9f..1dd8a3ecf753 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -905,9 +905,6 @@ void pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
 void pcibios_scan_specific_bus(int busn);
 struct pci_bus *pci_find_bus(int domain, int busnr);
 void pci_bus_add_devices(const struct pci_bus *bus);
-struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
-				    struct pci_ops *ops, void *sysdata,
-				    struct list_head *resources);
 int pci_host_probe(struct pci_host_bridge *bridge);
 int pci_register_host_bridge(struct pci_host_bridge *);
 int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int busmax);
-- 
2.18.0
