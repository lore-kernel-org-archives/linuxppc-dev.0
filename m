Return-Path: <matsumoto.hiroo@jp.fujitsu.com>
Received: from fgwmail7.fujitsu.co.jp (fgwmail7.fujitsu.co.jp [192.51.44.37])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AF51AB700A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2012 13:14:38 +1000 (EST)
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
 by fgwmail7.fujitsu.co.jp (Postfix) with ESMTP id 876DF179372C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2012 11:30:52 +0900 (JST)
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 204803EE0C5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2012 11:30:50 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id F03B845DE51
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2012 11:30:49 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id C3CE645DE4E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2012 11:30:49 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id A04F1E08002
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2012 11:30:49 +0900 (JST)
Received: from m002.s.css.fujitsu.com (m002.s.css.fujitsu.com [10.23.4.32])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 4B0BF1DB802F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2012 11:30:49 +0900 (JST)
Message-ID: <4FBC4C92.7080902@jp.fujitsu.com>
Date: Wed, 23 May 2012 11:33:54 +0900
From: Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 1/2] powerpc/PCI: Add pcibios_device_change_notifier for
 powerpc
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

* Not patched pciehp message on powerpc platform
# echo 1 > /sys/bus/pci/slots/1/power
<snip>
pcieport 0000:02:01.0: PCI bridge to [bus 03-03]
pcieport 0000:02:01.0:   bridge window [io  0xff7ee000-0xff7eefff]
pcieport 0000:02:01.0:   bridge window [mem 0xa0100000-0xa01fffff]
pcieport 0000:02:01.0: bridge window [mem 0xa0200000-0xa02fffff 64bit pref]
pci 0000:03:00.0: no hotplug settings from platform
e1000e 0000:03:00.0: Disabling ASPM  L1
e1000e 0000:03:00.0: enabling device (0000 -> 0002)
e1000e 0000:03:00.0: No usable DMA configuration, aborting
e1000e: probe of 0000:03:00.0 failed with error -5

* Patched pciehp message on powerpc platform
# echo 1 > /sys/bus/pci/slots/1/power
<snip>
pcieport 0000:02:01.0: PCI bridge to [bus 03-03]
pcieport 0000:02:01.0:   bridge window [io  0xff7ee000-0xff7eefff]
pcieport 0000:02:01.0:   bridge window [mem 0xa0100000-0xa01fffff]
pcieport 0000:02:01.0: bridge window [mem 0xa0200000-0xa02fffff 64bit pref]
pci 0000:03:00.0: no hotplug settings from platform
e1000e 0000:03:00.0: Disabling ASPM  L1
e1000e 0000:03:00.0: enabling device (0000 -> 0002)
irq: irq 6 on host /soc@ffe00000/msi@41600 mapped to virtual irq 27
e1000e 0000:03:00.0: eth0: (PCI Express:2.5GT/s:Width x1) 00:15:17:bf:c0:c9
e1000e 0000:03:00.0: eth0: Intel(R) PRO/1000 Network Connection
e1000e 0000:03:00.0: eth0: MAC: 1, PHY: 4, PBA No: D50861-003

Signed-off-by: Hiroo MATSUMOTO <matsumoto.hiroo@jp.fujitsu.com>
---
 arch/powerpc/include/asm/pci.h             |    2 +-
 arch/powerpc/kernel/pci-common.c           |   87 ++++++++++++++--------------
 arch/powerpc/kernel/pci_32.c               |    2 +
 arch/powerpc/kernel/pci_64.c               |    2 +
 arch/powerpc/kernel/pci_of_scan.c          |    1 -
 arch/powerpc/platforms/pseries/pci_dlpar.c |    1 -
 drivers/pci/pci.c                          |    5 --
 drivers/pcmcia/cardbus.c                   |    3 +-
 include/linux/pci.h                        |    3 -
 9 files changed, 49 insertions(+), 57 deletions(-)

diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index f54b3d2..7b4ca5a 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -190,10 +190,10 @@ extern void pci_resource_to_user(const struct pci_dev *dev, int bar,
 				 const struct resource *rsrc,
 				 resource_size_t *start, resource_size_t *end);

-extern void pcibios_setup_bus_devices(struct pci_bus *bus);
 extern void pcibios_setup_bus_self(struct pci_bus *bus);
 extern void pcibios_setup_phb_io_space(struct pci_controller *hose);
 extern void pcibios_scan_phb(struct pci_controller *hose);
+extern void pcibios_setup_bus_notifier(void);

 #endif	/* __KERNEL__ */
 #endif /* __ASM_POWERPC_PCI_H */
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index cce98d7..42a00b5 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1097,40 +1097,6 @@ void __devinit pcibios_setup_bus_self(struct pci_bus *bus)
 		ppc_md.pci_dma_bus_setup(bus);
 }

-void __devinit pcibios_setup_bus_devices(struct pci_bus *bus)
-{
-	struct pci_dev *dev;
-
-	pr_debug("PCI: Fixup bus devices %d (%s)\n",
-		 bus->number, bus->self ? pci_name(bus->self) : "PHB");
-
-	list_for_each_entry(dev, &bus->devices, bus_list) {
-		/* Cardbus can call us to add new devices to a bus, so ignore
-		 * those who are already fully discovered
-		 */
-		if (dev->is_added)
-			continue;
-
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
-	}
-}
-
 void pcibios_set_master(struct pci_dev *dev)
 {
 	/* No special bus mastering setup handling */
@@ -1147,19 +1113,9 @@ void __devinit pcibios_fixup_bus(struct pci_bus *bus)

 	/* Now fixup the bus bus */
 	pcibios_setup_bus_self(bus);
-
-	/* Now fixup devices on that bus */
-	pcibios_setup_bus_devices(bus);
 }
 EXPORT_SYMBOL(pcibios_fixup_bus);

-void __devinit pci_fixup_cardbus(struct pci_bus *bus)
-{
-	/* Now fixup devices on that bus */
-	pcibios_setup_bus_devices(bus);
-}
-
-
 static int skip_isa_ioresource_align(struct pci_dev *dev)
 {
 	if (pci_has_flag(PCI_CAN_SKIP_ISA_ALIGN) &&
@@ -1763,6 +1719,49 @@ void __devinit pcibios_scan_phb(struct pci_controller *hose)
 	}
 }

+static int pcibios_device_change_notifier(struct notifier_block *nb,
+					  unsigned long action, void *data)
+{
+	struct pci_dev *dev = to_pci_dev(data);
+
+	switch (action) {
+	case BUS_NOTIFY_ADD_DEVICE:
+		/* Setup OF node pointer in the device */
+		dev->dev.of_node = pci_device_to_OF_node(dev);
+
+		/* Fixup NUMA node as it may not be setup yet by the generic
+		 * code and is needed by the DMA init
+		 */
+		set_dev_node(&dev->dev, pcibus_to_node(dev->bus));
+
+		/* Hook up default DMA ops */
+		set_dma_ops(&dev->dev, pci_dma_ops);
+		set_dma_offset(&dev->dev, PCI_DRAM_OFFSET);
+
+		/* Additional platform DMA/iommu setup */
+		if (ppc_md.pci_dma_dev_setup)
+			ppc_md.pci_dma_dev_setup(dev);
+
+		/* Read default IRQs and fixup if necessary */
+		pci_read_irq_line(dev);
+		if (ppc_md.pci_irq_fixup)
+			ppc_md.pci_irq_fixup(dev);
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
 static void fixup_hide_host_resource_fsl(struct pci_dev *dev)
 {
 	int i, class = dev->class >> 8;
diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index fdd1a3d..5a30cec 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -231,6 +231,8 @@ static int __init pcibios_init(void)

 	printk(KERN_INFO "PCI: Probing PCI hardware\n");

+	pcibios_setup_bus_notifier();
+
 	if (pci_has_flag(PCI_REASSIGN_ALL_BUS))
 		pci_assign_all_buses = 1;

diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 3318d39..d66c9dc 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -50,6 +50,8 @@ static int __init pcibios_init(void)

 	printk(KERN_INFO "PCI: Probing PCI hardware\n");

+	pcibios_setup_bus_notifier();
+
 	/* For now, override phys_mem_access_prot. If we need it,g
 	 * later, we may move that initialization to each ppc_md
 	 */
diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index b37d0b5..1e29642 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -329,7 +329,6 @@ static void __devinit __of_scan_bus(struct device_node *node,
 	 */
 	if (!rescan_existing)
 		pcibios_setup_bus_self(bus);
-	pcibios_setup_bus_devices(bus);

 	/* Now scan child busses */
 	list_for_each_entry(dev, &bus->devices, bus_list) {
diff --git a/arch/powerpc/platforms/pseries/pci_dlpar.c b/arch/powerpc/platforms/pseries/pci_dlpar.c
index 55d4ec1..fdb8b64 100644
--- a/arch/powerpc/platforms/pseries/pci_dlpar.c
+++ b/arch/powerpc/platforms/pseries/pci_dlpar.c
@@ -120,7 +120,6 @@ void pcibios_add_pci_devices(struct pci_bus * bus)
 		num = pci_scan_slot(bus, PCI_DEVFN(slotno, 0));
 		if (!num)
 			return;
-		pcibios_setup_bus_devices(bus);
 		max = bus->secondary;
 		for (pass=0; pass < 2; pass++)
 			list_for_each_entry(dev, &bus->devices, bus_list) {
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index af295bb..f363b5d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3698,11 +3698,6 @@ int __attribute__ ((weak)) pci_ext_cfg_avail(struct pci_dev *dev)
 	return 1;
 }

-void __weak pci_fixup_cardbus(struct pci_bus *bus)
-{
-}
-EXPORT_SYMBOL(pci_fixup_cardbus);
-
 static int __init pci_setup(char *str)
 {
 	while (str) {
diff --git a/drivers/pcmcia/cardbus.c b/drivers/pcmcia/cardbus.c
index 9a58862..8f7baa6 100644
--- a/drivers/pcmcia/cardbus.c
+++ b/drivers/pcmcia/cardbus.c
@@ -71,7 +71,6 @@ int __ref cb_alloc(struct pcmcia_socket *s)
 	unsigned int max, pass;

 	s->functions = pci_scan_slot(bus, PCI_DEVFN(0, 0));
-	pci_fixup_cardbus(bus);

 	max = bus->secondary;
 	for (pass = 0; pass < 2; pass++)
@@ -85,7 +84,6 @@ int __ref cb_alloc(struct pcmcia_socket *s)
 	 */
 	pci_bus_size_bridges(bus);
 	pci_bus_assign_resources(bus);
-	cardbus_config_irq_and_cls(bus, s->pci_irq);

 	/* socket specific tune function */
 	if (s->tune_bridge)
@@ -93,6 +91,7 @@ int __ref cb_alloc(struct pcmcia_socket *s)

 	pci_enable_bridges(bus);
 	pci_bus_add_devices(bus);
+	cardbus_config_irq_and_cls(bus, s->pci_irq);

 	return 0;
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index a16b1df..56f50fd 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -651,9 +651,6 @@ resource_size_t pcibios_align_resource(void *, const struct resource *,
 				resource_size_t);
 void pcibios_update_irq(struct pci_dev *, int irq);

-/* Weak but can be overriden by arch */
-void pci_fixup_cardbus(struct pci_bus *);
-
 /* Generic PCI functions used internally */

 void pcibios_scan_specific_bus(int busn);
-- 
1.7.3.4
