Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 023F9B6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Dec 2009 17:52:20 +1100 (EST)
Subject: [PATCH] cardbus: Add a fixup hook and fix powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 09 Dec 2009 17:52:13 +1100
Message-ID: <1260341533.16132.20.camel@pasglop>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, blofeldus@yahoo.com,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The cardbus code creates PCI devices without ever going through the
necessary fixup bits and pieces that normal PCI devices go through.

There's in fact a commented out call to pcibios_fixup_bus() in there,
it's commented because ... it doesn't work.

I could make pcibios_fixup_bus() do the right thing on powerpc easily
but I felt it cleaner instead to provide a specific hook pci_fixup_cardbus
for which a weak empty implementation is provided by the PCI core.

This fixes cardbus on powerbooks and probably all other PowerPC
platforms which was broken completely for ever on some platforms and
since 2.6.31 on others such as PowerBooks when we made the DMA ops
mandatory (since those are setup by the fixups).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Note: In the long run we might want to streamline the hooks for fixing
up new devices vs. new busses and make some stuff common between cardbus
and PCI hotplug which is actually a mess.

This is a quick fix that makes it work again in the meantime, and that
I would like to see in 2.6.31 and 2.6.32 stable at least. 

Another option if you prefer is I can make my pcibios_fixup_bus() do the
right thing in all cases I believe (by testing bus->is_added to skip
stuff that must not be done twice) and we can remove the comment and
stick the call in #ifdef CONFIG_PPC but I felt that solution was a tad
cleaner.

Olof, once that's in you should be able to remove the hack you have in
the PA-Semi code to work around this.

Cheers,
Ben.

Index: linux-work/drivers/pcmcia/cardbus.c
===================================================================
--- linux-work.orig/drivers/pcmcia/cardbus.c	2009-12-09 17:16:10.000000000 +1100
+++ linux-work/drivers/pcmcia/cardbus.c	2009-12-09 17:34:58.000000000 +1100
@@ -214,7 +214,7 @@ int __ref cb_alloc(struct pcmcia_socket 
 	unsigned int max, pass;
 
 	s->functions = pci_scan_slot(bus, PCI_DEVFN(0, 0));
-//	pcibios_fixup_bus(bus);
+	pci_fixup_cardbus(bus);
 
 	max = bus->secondary;
 	for (pass = 0; pass < 2; pass++)
Index: linux-work/include/linux/pci.h
===================================================================
--- linux-work.orig/include/linux/pci.h	2009-12-09 17:16:10.000000000 +1100
+++ linux-work/include/linux/pci.h	2009-12-09 17:34:47.000000000 +1100
@@ -564,6 +564,9 @@ void pcibios_align_resource(void *, stru
 				resource_size_t);
 void pcibios_update_irq(struct pci_dev *, int irq);
 
+/* Weak but can be overriden by arch */
+void pci_fixup_cardbus(struct pci_bus *);
+
 /* Generic PCI functions used internally */
 
 extern struct pci_bus *pci_find_bus(int domain, int busnr);
Index: linux-work/arch/powerpc/kernel/pci-common.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/pci-common.c	2009-12-09 17:16:10.000000000 +1100
+++ linux-work/arch/powerpc/kernel/pci-common.c	2009-12-09 17:35:19.000000000 +1100
@@ -1107,6 +1107,12 @@ void __devinit pcibios_setup_bus_devices
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		struct dev_archdata *sd = &dev->dev.archdata;
 
+		/* Cardbus can call us to add new devices to a bus, so ignore
+		 * those who are already fully discovered
+		 */
+		if (dev->is_added)
+			continue;
+
 		/* Setup OF node pointer in archdata */
 		sd->of_node = pci_device_to_OF_node(dev);
 
@@ -1147,6 +1153,13 @@ void __devinit pcibios_fixup_bus(struct 
 }
 EXPORT_SYMBOL(pcibios_fixup_bus);
 
+void __devinit pci_fixup_cardbus(struct pci_bus *bus)
+{
+	/* Now fixup devices on that bus */
+	pcibios_setup_bus_devices(bus);
+}
+
+
 static int skip_isa_ioresource_align(struct pci_dev *dev)
 {
 	if ((ppc_pci_flags & PPC_PCI_CAN_SKIP_ISA_ALIGN) &&
Index: linux-work/drivers/pci/pci.c
===================================================================
--- linux-work.orig/drivers/pci/pci.c	2009-12-09 17:33:24.000000000 +1100
+++ linux-work/drivers/pci/pci.c	2009-12-09 17:34:16.000000000 +1100
@@ -2723,6 +2723,11 @@ int __attribute__ ((weak)) pci_ext_cfg_a
 	return 1;
 }
 
+void __weak pci_fixup_cardbus(struct pci_bus *bus)
+{
+}
+EXPORT_SYMBOL(pci_fixup_cardbus);
+
 static int __init pci_setup(char *str)
 {
 	while (str) {
