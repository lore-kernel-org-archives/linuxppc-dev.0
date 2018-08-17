Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41sKKY2mfpzF0gv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 20:33:05 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 12/15] PCI: make pcibios_bus_add_device() a callback function
Date: Fri, 17 Aug 2018 12:26:42 +0200
Message-Id: <20180817102645.3839621-13-arnd@arndb.de>
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

Weak functions are confusion, and we can now add callback pointers
to pci host bridges for any controller, so let's make this one
a callback rather than a __weak global function.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/kernel/pci-common.c  | 7 +------
 arch/sh/drivers/pci/pci.c         | 1 +
 arch/sh/drivers/pci/pcie-sh7786.c | 3 ++-
 arch/sh/include/asm/pci.h         | 2 ++
 drivers/pci/bus.c                 | 8 +++++++-
 include/linux/pci.h               | 2 +-
 6 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 096011ec8670..afc9598e4349 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -270,12 +270,6 @@ int pcibios_sriov_disable(struct pci_dev *pdev)
 
 #endif /* CONFIG_PCI_IOV */
 
-void pcibios_bus_add_device(struct pci_dev *pdev)
-{
-	if (ppc_md.pcibios_bus_add_device)
-		ppc_md.pcibios_bus_add_device(pdev);
-}
-
 static resource_size_t pcibios_io_size(const struct pci_controller *hose)
 {
 #ifdef CONFIG_PPC64
@@ -1617,6 +1611,7 @@ void pcibios_scan_phb(struct pci_controller *hose)
 	hose->busn.flags = IORESOURCE_BUS;
 	pci_add_resource(&bridge->windows, &hose->busn);
 
+	bridge->bus_add_device = ppc_md->pcibios_bus_add_device;
 	bridge->dev.parent = hose->parent;
 	bridge->sysdata = hose;
 	bridge->busnr = hose->first_busno;
diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index 8256626bc53c..d5c01a86cde1 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -65,6 +65,7 @@ static void pcibios_scanbus(struct pci_channel *hose)
 	bridge->ops = hose->pci_ops;
 	bridge->swizzle_irq = pci_common_swizzle;
 	bridge->map_irq = pcibios_map_platform_irq;
+	bridge->bus_add_device = hose->bus_add_device;
 
 	ret = pci_scan_root_bus_bridge(bridge);
 	if (ret) {
diff --git a/arch/sh/drivers/pci/pcie-sh7786.c b/arch/sh/drivers/pci/pcie-sh7786.c
index 3d81a8b80942..ab78356681a0 100644
--- a/arch/sh/drivers/pci/pcie-sh7786.c
+++ b/arch/sh/drivers/pci/pcie-sh7786.c
@@ -122,6 +122,7 @@ extern struct pci_ops sh7786_pci_ops;
 	.reg_base	= start,					\
 	.mem_offset	= 0,						\
 	.io_offset	= 0,						\
+	.bus_add_device = sh7786_pci_bus_add_device,			\
 }
 
 static struct pci_channel sh7786_pci_channels[] = {
@@ -488,7 +489,7 @@ int pcibios_map_platform_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
         return evt2irq(0xae0);
 }
 
-void pcibios_bus_add_device(struct pci_dev *pdev)
+static void sh7786_pci_bus_add_device(struct pci_dev *pdev)
 {
 	pdev->dev.dma_pfn_offset = dma_pfn_offset;
 }
diff --git a/arch/sh/include/asm/pci.h b/arch/sh/include/asm/pci.h
index 10a36b1cf2ea..e605141cbcbe 100644
--- a/arch/sh/include/asm/pci.h
+++ b/arch/sh/include/asm/pci.h
@@ -35,6 +35,8 @@ struct pci_channel {
 	/* Optional error handling */
 	struct timer_list	err_timer, serr_timer;
 	unsigned int		err_irq, serr_irq;
+
+	void (*bus_add_device)(struct pci_dev *pdev);
 };
 
 /* arch/sh/drivers/pci/pci.c */
diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 5cb40b2518f9..45873ac1a49c 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -299,7 +299,13 @@ bool pci_bus_clip_resource(struct pci_dev *dev, int idx)
 
 void __weak pcibios_resource_survey_bus(struct pci_bus *bus) { }
 
-void __weak pcibios_bus_add_device(struct pci_dev *pdev) { }
+static void pcibios_bus_add_device(struct pci_dev *pdev)
+{
+	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
+
+	if (bridge->bus_add_device)
+		bridge->bus_add_device(pdev);
+}
 
 /**
  * pci_bus_add_device - start driver for a single device
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1dd8a3ecf753..d1072690cb4f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -475,6 +475,7 @@ struct pci_host_bridge {
 	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
 	int (*map_irq)(const struct pci_dev *, u8, u8);
 	void (*release_fn)(struct pci_host_bridge *);
+	void (*bus_add_device)(struct pci_dev *pdev);
 	void		*release_data;
 	struct msi_controller *msi;
 	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
@@ -880,7 +881,6 @@ extern struct list_head pci_root_buses;	/* List of all known PCI buses */
 int no_pci_devices(void);
 
 void pcibios_resource_survey_bus(struct pci_bus *bus);
-void pcibios_bus_add_device(struct pci_dev *pdev);
 void pcibios_add_bus(struct pci_bus *bus);
 void pcibios_remove_bus(struct pci_bus *bus);
 void pcibios_fixup_bus(struct pci_bus *);
-- 
2.18.0
