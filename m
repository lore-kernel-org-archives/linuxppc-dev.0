Return-Path: <B41889@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D238B2C0147
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Apr 2013 22:26:48 +1100 (EST)
From: Yuanquan Chen <Yuanquan.Chen@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>,
 <bhelgaas@google.com>
Subject: [PATCH] powerpc/pci: fix PCI-e devices rescan issue on powerpc
 platform
Date: Tue, 2 Apr 2013 19:26:54 +0800
Message-ID: <1364902014-943-1-git-send-email-Yuanquan.Chen@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Yuanquan Chen <Yuanquan.Chen@freescale.com>,
 Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Powerpc initializes the DMA and IRQ information in pci_scan_child_bus()->
pcibios_fixup_bus()->pcibios_setup_bus_devices(). But for the devices
which are hotpluged, bus->is added has been set for the first scan of the
PCI-e bus, so the initialization code won't be called. Then the hotpluged
devices' driver will fail to load.

For example :
The PCI-e device 0001:03:00.0 is the Intel PCI-e e1000e network card, remove
it from the system:

    # echo 1 > /sys/bus/pci/devices/0001\:03\:00.0/remove
    # e1000e 0001:03:00.0 eth0: removed PHC

Rescan it from it's bus:

    # echo 1 > /sys/bus/pci/devices/0001\:02\:00.0/rescan
    ...
    e1000e 0001:03:00.0: Disabling ASPM L0s L1
    e1000e 0001:03:00.0: No usable DMA configuration, aborting
    e1000e: probe of 0001:03:00.0 failed with error -5

So we move the DMA & IRQ initialization code from pcibios_setup_devices() and
construct a new function pcibios_enable_device. We call this function in
pcibios_enable_device, which will be called by PCI-e rescan code. At the
meanwhile, we avoid the the impact on cardbus. I also validate this patch with
silicon's PCIe-sata which encounters the IRQ issue.

Signed-off-by: Yuanquan Chen <Yuanquan.Chen@freescale.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>
---
 arch/powerpc/kernel/pci-common.c |   43 +++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index fa12ae4..0324758 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1023,6 +1023,27 @@ void pcibios_setup_bus_self(struct pci_bus *bus)
 		ppc_md.pci_dma_bus_setup(bus);
 }
 
+void pcibios_setup_device(struct pci_dev *dev)
+{
+	/* Fixup NUMA node as it may not be setup yet by the generic
+	 * code and is needed by the DMA init
+	 */
+	set_dev_node(&dev->dev, pcibus_to_node(dev->bus));
+
+	/* Hook up default DMA ops */
+	set_dma_ops(&dev->dev, pci_dma_ops);
+	set_dma_offset(&dev->dev, PCI_DRAM_OFFSET);
+
+	/* Additional platform DMA/iommu setup */
+	if (ppc_md.pci_dma_dev_setup)
+		ppc_md.pci_dma_dev_setup(dev);
+
+	/* Read default IRQs and fixup if necessary */
+	pci_read_irq_line(dev);
+	if (ppc_md.pci_irq_fixup)
+		ppc_md.pci_irq_fixup(dev);
+}
+
 void pcibios_setup_bus_devices(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
@@ -1037,23 +1058,7 @@ void pcibios_setup_bus_devices(struct pci_bus *bus)
 		if (dev->is_added)
 			continue;
 
-		/* Fixup NUMA node as it may not be setup yet by the generic
-		 * code and is needed by the DMA init
-		 */
-		set_dev_node(&dev->dev, pcibus_to_node(dev->bus));
-
-		/* Hook up default DMA ops */
-		set_dma_ops(&dev->dev, pci_dma_ops);
-		set_dma_offset(&dev->dev, PCI_DRAM_OFFSET);
-
-		/* Additional platform DMA/iommu setup */
-		if (ppc_md.pci_dma_dev_setup)
-			ppc_md.pci_dma_dev_setup(dev);
-
-		/* Read default IRQs and fixup if necessary */
-		pci_read_irq_line(dev);
-		if (ppc_md.pci_irq_fixup)
-			ppc_md.pci_irq_fixup(dev);
+		pcibios_setup_device(dev);
 	}
 }
 
@@ -1494,6 +1499,10 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 		if (ppc_md.pcibios_enable_device_hook(dev))
 			return -EINVAL;
 
+	/* avoid pcie irq fix up impact on cardbus */
+	if (dev->hdr_type != PCI_HEADER_TYPE_CARDBUS)
+		pcibios_setup_device(dev);
+
 	return pci_enable_resources(dev, mask);
 }
 
-- 
1.7.9.5
