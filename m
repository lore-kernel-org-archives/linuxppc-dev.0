Return-Path: <bhelgaas@google.com>
Received: from mail-qa0-f73.google.com (mail-qa0-f73.google.com
 [209.85.216.73])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 710EDB700C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2012 08:37:04 +1000 (EST)
Received: by qafk22 with SMTP id k22so608429qaf.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2012 15:37:01 -0700 (PDT)
Subject: [PATCH v3 1/2] powerpc/PCI: move DMA & IRQ init to device_add()
 notification path
To: Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 23 May 2012 16:37:00 -0600
Message-ID: <20120523223700.24276.76804.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120523222635.24276.80023.stgit@bhelgaas.mtv.corp.google.com>
References: <20120523222635.24276.80023.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Michal Simek <monstr@monstr.eu>, microblaze-uclinux@itee.uq.edu.au,
 Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
 Jesse Larrew <jlarrew@linux.vnet.ibm.com>, jbarnes@virtuousgeek.org,
 Dominik Brodowski <linux@dominikbrodowski.net>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>

PowerPC initialized DMA and IRQ information in the pci_scan_child_bus()
-> pcibios_fixup_bus() path.  Some hotplug drivers use that path, but
others don't, e.g., pciehp, so sometimes hot-added devices are only
partly initialized.

This patch moves that initialization from pcibios_fixup_bus() to a new
pci_bus_notify() called in the pci_bus_add_device() -> device_add() path.
That means the initialization happens the same way for all PCI devices,
whether they are present at boot or hot-added later.

Note that powerpc was the only user of pci_fixup_cardbus(), which was
used to do this same setup for cardbus devices.  That's no longer
needed because this setup will now be done in the same device_add()
notification path as all other PCI devices.

Typical failure of a hot-added e1000e device prior to this change:

    # echo 1 > /sys/bus/pci/slots/1/power
    <snip>
    e1000e 0000:03:00.0: enabling device (0000 -> 0002)
    e1000e 0000:03:00.0: No usable DMA configuration, aborting
    e1000e: probe of 0000:03:00.0 failed with error -5

Successful initialization after this change:

    # echo 1 > /sys/bus/pci/slots/1/power
    <snip>
    e1000e 0000:03:00.0: enabling device (0000 -> 0002)
    irq: irq 6 on host /soc@ffe00000/msi@41600 mapped to virtual irq 27
    e1000e 0000:03:00.0: eth0: (PCI Express:2.5GT/s:Width x1) 00:15:17:bf:c0:c9
    e1000e 0000:03:00.0: eth0: Intel(R) PRO/1000 Network Connection
    e1000e 0000:03:00.0: eth0: MAC: 1, PHY: 4, PBA No: D50861-003

[bhelgaas: changelog, notifier name, registration can be __init]
CC: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Hiroo MATSUMOTO <matsumoto.hiroo@jp.fujitsu.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/powerpc/include/asm/pci.h             |    2 -
 arch/powerpc/kernel/pci-common.c           |   87 ++++++++++++++--------------
 arch/powerpc/kernel/pci_32.c               |    2 +
 arch/powerpc/kernel/pci_64.c               |    2 +
 arch/powerpc/kernel/pci_of_scan.c          |    1 
 arch/powerpc/platforms/pseries/pci_dlpar.c |    1 
 drivers/pci/pci.c                          |    5 --
 drivers/pcmcia/cardbus.c                   |    3 -
 include/linux/pci.h                        |    3 -
 9 files changed, 49 insertions(+), 57 deletions(-)

diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index 6653f27..d6a36a4 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -183,10 +183,10 @@ extern void pci_resource_to_user(const struct pci_dev *dev, int bar,
 				 resource_size_t *start, resource_size_t *end);
 
 extern resource_size_t pcibios_io_space_offset(struct pci_controller *hose);
-extern void pcibios_setup_bus_devices(struct pci_bus *bus);
 extern void pcibios_setup_bus_self(struct pci_bus *bus);
 extern void pcibios_setup_phb_io_space(struct pci_controller *hose);
 extern void pcibios_scan_phb(struct pci_controller *hose);
+extern void pcibios_setup_bus_notifier(void);
 
 #endif	/* __KERNEL__ */
 #endif /* __ASM_POWERPC_PCI_H */
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 7320f36..41b39ba 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1009,40 +1009,6 @@ void __devinit pcibios_setup_bus_self(struct pci_bus *bus)
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
@@ -1059,19 +1025,9 @@ void __devinit pcibios_fixup_bus(struct pci_bus *bus)
 
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
@@ -1685,6 +1641,49 @@ void __devinit pcibios_scan_phb(struct pci_controller *hose)
 	}
 }
 
+static int pci_bus_notify(struct notifier_block *nb, unsigned long action,
+			  void *data)
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
+	.notifier_call = pci_bus_notify,
+};
+
+void __init pcibios_setup_bus_notifier(void)
+{
+	bus_register_notifier(&pci_bus_type, &device_nb);
+}
+
 static void fixup_hide_host_resource_fsl(struct pci_dev *dev)
 {
 	int i, class = dev->class >> 8;
diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index 4b06ec5..640cc35 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -231,6 +231,8 @@ static int __init pcibios_init(void)
 
 	printk(KERN_INFO "PCI: Probing PCI hardware\n");
 
+	pcibios_setup_bus_notifier();
+
 	if (pci_has_flag(PCI_REASSIGN_ALL_BUS))
 		pci_assign_all_buses = 1;
 
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 4ff190f..8b212d3 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -48,6 +48,8 @@ static int __init pcibios_init(void)
 
 	printk(KERN_INFO "PCI: Probing PCI hardware\n");
 
+	pcibios_setup_bus_notifier();
+
 	/* For now, override phys_mem_access_prot. If we need it,g
 	 * later, we may move that initialization to each ppc_md
 	 */
diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index ae5ea5e..eb09eca 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -333,7 +333,6 @@ static void __devinit __of_scan_bus(struct device_node *node,
 	 */
 	if (!rescan_existing)
 		pcibios_setup_bus_self(bus);
-	pcibios_setup_bus_devices(bus);
 
 	/* Now scan child busses */
 	list_for_each_entry(dev, &bus->devices, bus_list) {
diff --git a/arch/powerpc/platforms/pseries/pci_dlpar.c b/arch/powerpc/platforms/pseries/pci_dlpar.c
index 3ccebc8..0b1b6b3 100644
--- a/arch/powerpc/platforms/pseries/pci_dlpar.c
+++ b/arch/powerpc/platforms/pseries/pci_dlpar.c
@@ -120,7 +120,6 @@ void pcibios_add_pci_devices(struct pci_bus * bus)
 		num = pci_scan_slot(bus, PCI_DEVFN(slotno, 0));
 		if (!num)
 			return;
-		pcibios_setup_bus_devices(bus);
 		max = bus->busn_res.start;
 		for (pass=0; pass < 2; pass++)
 			list_for_each_entry(dev, &bus->devices, bus_list) {
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 15d442a..43e0a4f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3789,11 +3789,6 @@ int __attribute__ ((weak)) pci_ext_cfg_avail(struct pci_dev *dev)
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
index 24caeaf..a980691 100644
--- a/drivers/pcmcia/cardbus.c
+++ b/drivers/pcmcia/cardbus.c
@@ -71,7 +71,6 @@ int __ref cb_alloc(struct pcmcia_socket *s)
 	unsigned int max, pass;
 
 	s->functions = pci_scan_slot(bus, PCI_DEVFN(0, 0));
-	pci_fixup_cardbus(bus);
 
 	max = bus->busn_res.start;
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
index a0e2d7f..3924c02 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -651,9 +651,6 @@ resource_size_t pcibios_align_resource(void *, const struct resource *,
 				resource_size_t);
 void pcibios_update_irq(struct pci_dev *, int irq);
 
-/* Weak but can be overriden by arch */
-void pci_fixup_cardbus(struct pci_bus *);
-
 /* Generic PCI functions used internally */
 
 void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
