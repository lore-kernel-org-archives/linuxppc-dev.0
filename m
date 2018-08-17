Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41sKKB6CqkzDrWY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 20:32:45 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 03/15] PCI: move pci_scan_root_bus into callers
Date: Fri, 17 Aug 2018 12:26:33 +0200
Message-Id: <20180817102645.3839621-4-arnd@arndb.de>
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

There are only six remaining callers of the old pci_scan_root_bus()
interface. Since we want to expose the pci_host_bridge structure
everywhere and discourage users from calling the old interfaces, let's
move the implementation into the respective callsites.

While this duplicates the source code, it makes the object code smaller
for almost all users by avoiding the global implementation, and it allows
further cleanup of the callers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/ia64/sn/kernel/io_init.c    | 27 +++++++++++++++++++++++++++
 arch/microblaze/pci/pci-common.c | 27 +++++++++++++++++++++++++++
 arch/s390/pci/pci.c              | 27 +++++++++++++++++++++++++++
 arch/x86/pci/common.c            | 27 +++++++++++++++++++++++++++
 arch/xtensa/kernel/pci.c         | 27 +++++++++++++++++++++++++++
 drivers/pci/probe.c              | 28 ----------------------------
 drivers/pci/xen-pcifront.c       | 27 +++++++++++++++++++++++++++
 include/linux/pci.h              |  3 ---
 8 files changed, 162 insertions(+), 31 deletions(-)

diff --git a/arch/ia64/sn/kernel/io_init.c b/arch/ia64/sn/kernel/io_init.c
index d63809a6adfa..e768702a7b45 100644
--- a/arch/ia64/sn/kernel/io_init.c
+++ b/arch/ia64/sn/kernel/io_init.c
@@ -213,6 +213,33 @@ sn_io_slot_fixup(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(sn_io_slot_fixup);
 
+static struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
+		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+{
+	struct pci_host_bridge *bridge;
+	int error;
+
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
+		return NULL;
+
+	list_splice_init(resources, &bridge->windows);
+	bridge->dev.parent = parent;
+	bridge->sysdata = sysdata;
+	bridge->busnr = bus;
+	bridge->ops = ops;
+
+	error = pci_scan_root_bus_bridge(bridge);
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
  * sn_pci_controller_fixup() - This routine sets up a bus's resources
  *			       consistent with the Linux PCI abstraction layer.
diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index f34346d56095..302071385e1b 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -977,6 +977,33 @@ static void pcibios_setup_phb_resources(struct pci_controller *hose,
 		 (unsigned long)hose->io_base_virt - _IO_BASE);
 }
 
+static struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
+		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+{
+	struct pci_host_bridge *bridge;
+	int error;
+
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
+		return NULL;
+
+	list_splice_init(resources, &bridge->windows);
+	bridge->dev.parent = parent;
+	bridge->sysdata = sysdata;
+	bridge->busnr = bus;
+	bridge->ops = ops;
+
+	error = pci_scan_root_bus_bridge(bridge);
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
 static void pcibios_scan_phb(struct pci_controller *hose)
 {
 	LIST_HEAD(resources);
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 9f6f392a4461..b21205f131ce 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -786,6 +786,33 @@ void pcibios_remove_bus(struct pci_bus *bus)
 	kfree(zdev);
 }
 
+static struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
+		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+{
+	struct pci_host_bridge *bridge;
+	int error;
+
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
+		return NULL;
+
+	list_splice_init(resources, &bridge->windows);
+	bridge->dev.parent = parent;
+	bridge->sysdata = sysdata;
+	bridge->busnr = bus;
+	bridge->ops = ops;
+
+	error = pci_scan_root_bus_bridge(bridge);
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
 static int zpci_scan_bus(struct zpci_dev *zdev)
 {
 	LIST_HEAD(resources);
diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index d4ec117c1142..e740d9aa4024 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -453,6 +453,33 @@ void __init dmi_check_pciprobe(void)
 	dmi_check_system(pciprobe_dmi_table);
 }
 
+static struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
+		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+{
+	struct pci_host_bridge *bridge;
+	int error;
+
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
+		return NULL;
+
+	list_splice_init(resources, &bridge->windows);
+	bridge->dev.parent = parent;
+	bridge->sysdata = sysdata;
+	bridge->busnr = bus;
+	bridge->ops = ops;
+
+	error = pci_scan_root_bus_bridge(bridge);
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
 void pcibios_scan_root(int busnum)
 {
 	struct pci_bus *bus;
diff --git a/arch/xtensa/kernel/pci.c b/arch/xtensa/kernel/pci.c
index 21f13e9aabe1..5a8fd67e6c5e 100644
--- a/arch/xtensa/kernel/pci.c
+++ b/arch/xtensa/kernel/pci.c
@@ -116,6 +116,33 @@ static void __init pci_controller_apertures(struct pci_controller *pci_ctrl,
 	}
 }
 
+static struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
+		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+{
+	struct pci_host_bridge *bridge;
+	int error;
+
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
+		return NULL;
+
+	list_splice_init(resources, &bridge->windows);
+	bridge->dev.parent = parent;
+	bridge->sysdata = sysdata;
+	bridge->busnr = bus;
+	bridge->ops = ops;
+
+	error = pci_scan_root_bus_bridge(bridge);
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
 static int __init pcibios_init(void)
 {
 	struct pci_controller *pci_ctrl;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 12c3aa63c34d..cf169742c03e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3050,34 +3050,6 @@ int pci_scan_root_bus_bridge(struct pci_host_bridge *bridge)
 }
 EXPORT_SYMBOL(pci_scan_root_bus_bridge);
 
-struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
-		struct pci_ops *ops, void *sysdata, struct list_head *resources)
-{
-	struct pci_host_bridge *bridge;
-	int error;
-
-	bridge = pci_alloc_host_bridge(0);
-	if (!bridge)
-		return NULL;
-
-	list_splice_init(resources, &bridge->windows);
-	bridge->dev.parent = parent;
-	bridge->sysdata = sysdata;
-	bridge->busnr = bus;
-	bridge->ops = ops;
-
-	error = pci_scan_root_bus_bridge(bridge);
-	if (error < 0)
-		goto err_out;
-
-	return bridge->bus;
-
-err_out:
-	kfree(bridge);
-	return NULL;
-}
-EXPORT_SYMBOL(pci_scan_root_bus);
-
 /**
  * pci_rescan_bus_bridge_resize - Scan a PCI bus for devices
  * @bridge: PCI bridge for the bus to scan
diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index eba6e33147a2..24070e1c5f22 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -443,6 +443,33 @@ static int pcifront_scan_bus(struct pcifront_device *pdev,
 	return 0;
 }
 
+static struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
+		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+{
+	struct pci_host_bridge *bridge;
+	int error;
+
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
+		return NULL;
+
+	list_splice_init(resources, &bridge->windows);
+	bridge->dev.parent = parent;
+	bridge->sysdata = sysdata;
+	bridge->busnr = bus;
+	bridge->ops = ops;
+
+	error = pci_scan_root_bus_bridge(bridge);
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
 static int pcifront_scan_root(struct pcifront_device *pdev,
 				 unsigned int domain, unsigned int bus)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d77ce35a2b33..d226e06fb5e5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -912,9 +912,6 @@ int pci_host_probe(struct pci_host_bridge *bridge);
 int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int busmax);
 int pci_bus_update_busn_res_end(struct pci_bus *b, int busmax);
 void pci_bus_release_busn_res(struct pci_bus *b);
-struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
-				  struct pci_ops *ops, void *sysdata,
-				  struct list_head *resources);
 int pci_scan_root_bus_bridge(struct pci_host_bridge *bridge);
 struct pci_bus *pci_add_new_bus(struct pci_bus *parent, struct pci_dev *dev,
 				int busnr);
-- 
2.18.0
