Return-Path: <matsumoto.hiroo@jp.fujitsu.com>
Received: from fgwmail8.fujitsu.co.jp (fgwmail8.fujitsu.co.jp [192.51.44.38])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 965CDB73DD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2012 13:16:01 +1000 (EST)
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
 by fgwmail8.fujitsu.co.jp (Postfix) with ESMTP id B81BB1793343
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2012 11:31:04 +0900 (JST)
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 94AC63EE0C3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2012 11:31:02 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 7604245DE53
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2012 11:31:02 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 5C1C445DE51
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2012 11:31:02 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 507DEE08003
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2012 11:31:02 +0900 (JST)
Received: from m0001.s.css.fujitsu.com (m0001.s.css.fujitsu.com [10.23.4.186])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 01E641DB803B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2012 11:31:02 +0900 (JST)
Message-ID: <4FBC4C9B.3030309@jp.fujitsu.com>
Date: Wed, 23 May 2012 11:34:03 +0900
From: Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 2/2] microblaze/PCI: Add pcibios_device_change_notifier
 for microblaze
Content-Type: text/plain; charset=ISO-2022-JP
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 jbarnes@virtuousgeek.org, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pcibios_setup_bus_devices which sets DMA and IRQs of PCI device is called
only when boot, so DMA and IRQs of PCI device will not set when hotplug.
This patch adds pcibios_device_change_notifier which sets DMA and IRQs of
PCI device when PCI device adds, so DMA and IRQs of PCI device will be set
when boot and hotplug.

Signed-off-by: Hiroo MATSUMOTO <matsumoto.hiroo@jp.fujitsu.com>
---
 arch/microblaze/include/asm/pci.h |    2 +-
 arch/microblaze/pci/pci-common.c  |   67 +++++++++++++++++++++---------------
 2 files changed, 40 insertions(+), 29 deletions(-)

diff --git a/arch/microblaze/include/asm/pci.h b/arch/microblaze/include/asm/pci.h
index 0331376..8d11277 100644
--- a/arch/microblaze/include/asm/pci.h
+++ b/arch/microblaze/include/asm/pci.h
@@ -149,8 +149,8 @@ extern void pci_resource_to_user(const struct pci_dev *dev, int bar,
 				 const struct resource *rsrc,
 				 resource_size_t *start, resource_size_t *end);

-extern void pcibios_setup_bus_devices(struct pci_bus *bus);
 extern void pcibios_setup_bus_self(struct pci_bus *bus);
+extern void pcibios_setup_bus_notifier(void);

 /* This part of code was originally in xilinx-pci.h */
 #ifdef CONFIG_PCI_XILINX
diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index 85f2ac1..bb28ede 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -1063,31 +1063,6 @@ void __devinit pcibios_setup_bus_self(struct pci_bus *bus)
 		pcibios_fixup_bridge(bus);
 }

-void __devinit pcibios_setup_bus_devices(struct pci_bus *bus)
-{
-	struct pci_dev *dev;
-
-	pr_debug("PCI: Fixup bus devices %d (%s)\n",
-		 bus->number, bus->self ? pci_name(bus->self) : "PHB");
-
-	list_for_each_entry(dev, &bus->devices, bus_list) {
-		/* Setup OF node pointer in archdata */
-		dev->dev.of_node = pci_device_to_OF_node(dev);
-
-		/* Fixup NUMA node as it may not be setup yet by the generic
-		 * code and is needed by the DMA init
-		 */
-		set_dev_node(&dev->dev, pcibus_to_node(dev->bus));
-
-		/* Hook up default DMA ops */
-		set_dma_ops(&dev->dev, pci_dma_ops);
-		dev->dev.archdata.dma_data = (void *)PCI_DRAM_OFFSET;
-
-		/* Read default IRQs and fixup if necessary */
-		pci_read_irq_line(dev);
-	}
-}
-
 void __devinit pcibios_fixup_bus(struct pci_bus *bus)
 {
 	/* When called from the generic PCI probe, read PCI<->PCI bridge
@@ -1099,9 +1074,6 @@ void __devinit pcibios_fixup_bus(struct pci_bus *bus)

 	/* Now fixup the bus bus */
 	pcibios_setup_bus_self(bus);
-
-	/* Now fixup devices on that bus */
-	pcibios_setup_bus_devices(bus);
 }
 EXPORT_SYMBOL(pcibios_fixup_bus);

@@ -1604,6 +1576,43 @@ static void __devinit pcibios_scan_phb(struct pci_controller *hose)
 	hose->last_busno = bus->subordinate;
 }

+static int pcibios_device_change_notifier(struct notifier_block *nb,
+					  unsigned long action, void *data)
+{
+	struct pci_dev *dev = to_pci_dev(data);
+
+	switch (action) {
+	case BUS_NOTIFY_ADD_DEVICE:
+		/* Setup OF node pointer in archdata */
+		dev->dev.of_node = pci_device_to_OF_node(dev);
+
+		/* Fixup NUMA node as it may not be setup yet by the generic
+		 * code and is needed by the DMA init
+		 */
+		set_dev_node(&dev->dev, pcibus_to_node(dev->bus));
+
+		/* Hook up default DMA ops */
+		set_dma_ops(&dev->dev, pci_dma_ops);
+		dev->dev.archdata.dma_data = (void *)PCI_DRAM_OFFSET;
+
+		/* Read default IRQs and fixup if necessary */
+		pci_read_irq_line(dev);
+
+		break;
+	}
+
+	return 0;
+}
+
+static struct notifier_block device_nb = {
+	.notifier_call = pcibios_device_change_notifier,
+};
+
+void __devinit pcibios_setup_bus_notifier(void)
+{
+	bus_register_notifier(&pci_bus_type, &device_nb);
+}
+
 static int __init pcibios_init(void)
 {
 	struct pci_controller *hose, *tmp;
@@ -1611,6 +1620,8 @@ static int __init pcibios_init(void)

 	printk(KERN_INFO "PCI: Probing PCI hardware\n");

+	pcibios_setup_bus_notifier();
+
 	/* Scan all of the recorded PCI controllers.  */
 	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
 		hose->last_busno = 0xff;
-- 
1.7.3.4
