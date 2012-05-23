Return-Path: <bhelgaas@google.com>
Received: from mail-vb0-f73.google.com (mail-vb0-f73.google.com
 [209.85.212.73])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1B812B706B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2012 08:37:09 +1000 (EST)
Received: by vbbfd1 with SMTP id fd1so951747vbb.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2012 15:37:06 -0700 (PDT)
Subject: [PATCH v3 2/2] microblaze/PCI: move DMA & IRQ init to device_add()
 notification path
To: Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 23 May 2012 16:37:05 -0600
Message-ID: <20120523223705.24276.20161.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120523222635.24276.80023.stgit@bhelgaas.mtv.corp.google.com>
References: <20120523222635.24276.80023.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Michal Simek <monstr@monstr.eu>, microblaze-uclinux@itee.uq.edu.au,
 Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
 Jesse Larrew <jlarrew@linux.vnet.ibm.com>, jbarnes@virtuousgeek.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>

Microblaze initialized DMA and IRQ information in the pci_scan_child_bus()
-> pcibios_fixup_bus() path.  Some hotplug drivers use that path, but
others don't, e.g., pciehp, so sometimes hot-added devices are only
partly initialized.

This patch moves that initialization from pcibios_fixup_bus() to a new
pci_bus_notify() called in the pci_bus_add_device() -> device_add() path.
That means the initialization happens the same way for all PCI devices,
whether they are present at boot or hot-added later.

[bhelgaas: changelog, notifier name, inline registration]
Signed-off-by: Hiroo MATSUMOTO <matsumoto.hiroo@jp.fujitsu.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/microblaze/include/asm/pci.h |    1 -
 arch/microblaze/pci/pci-common.c  |   62 ++++++++++++++++++++-----------------
 2 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/arch/microblaze/include/asm/pci.h b/arch/microblaze/include/asm/pci.h
index a0da88b..2aa97fd 100644
--- a/arch/microblaze/include/asm/pci.h
+++ b/arch/microblaze/include/asm/pci.h
@@ -141,7 +141,6 @@ extern void pci_resource_to_user(const struct pci_dev *dev, int bar,
 				 const struct resource *rsrc,
 				 resource_size_t *start, resource_size_t *end);
 
-extern void pcibios_setup_bus_devices(struct pci_bus *bus);
 extern void pcibios_setup_bus_self(struct pci_bus *bus);
 
 /* This part of code was originally in xilinx-pci.h */
diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index 9b32483..6487ed0 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -983,31 +983,6 @@ void __devinit pcibios_setup_bus_self(struct pci_bus *bus)
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
@@ -1019,9 +994,6 @@ void __devinit pcibios_fixup_bus(struct pci_bus *bus)
 
 	/* Now fixup the bus bus */
 	pcibios_setup_bus_self(bus);
-
-	/* Now fixup devices on that bus */
-	pcibios_setup_bus_devices(bus);
 }
 EXPORT_SYMBOL(pcibios_fixup_bus);
 
@@ -1512,6 +1484,38 @@ static void __devinit pcibios_scan_phb(struct pci_controller *hose)
 	hose->last_busno = bus->busn_res.end;
 }
 
+static int pci_bus_notify(struct notifier_block *nb, unsigned long action,
+			  void *data)
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
+	.notifier_call = pci_bus_notify,
+};
+
 static int __init pcibios_init(void)
 {
 	struct pci_controller *hose, *tmp;
@@ -1519,6 +1523,8 @@ static int __init pcibios_init(void)
 
 	printk(KERN_INFO "PCI: Probing PCI hardware\n");
 
+	bus_register_notifier(&pci_bus_type, &device_nb);
+
 	/* Scan all of the recorded PCI controllers.  */
 	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
 		hose->last_busno = 0xff;
