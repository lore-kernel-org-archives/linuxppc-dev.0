Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 12 Dec 2007 16:23:04 +1100
Subject: [PATCH 12/13] [POWERPC] Fixup powermac enable device hook
In-Reply-To: <1197436973.110379.888292904645.qpush@grosgo>
Message-Id: <20071212052308.25511DE013@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Powermac's use of the pcibios_enable_device_hook() got slightly
broken by the recent PCI merge in that it won't be called for
the "initial" case of assigning resources to a previously
unassigned device. This was an abuse of that hook anyway, so
instead we now use a header quirk.

While at it, we move a #ifdef CONFIG_PPC32 to enclose more code
that is only ever used on 32 bits.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/platforms/powermac/pci.c |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

--- linux-work.orig/arch/powerpc/platforms/powermac/pci.c	2007-12-10 16:45:58.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/pci.c	2007-12-10 16:56:01.000000000 +1100
@@ -1058,6 +1058,7 @@ void __init pmac_pci_init(void)
 #endif
 }
 
+#ifdef CONFIG_PPC32
 int pmac_pci_enable_device_hook(struct pci_dev *dev)
 {
 	struct device_node* node;
@@ -1106,7 +1107,6 @@ int pmac_pci_enable_device_hook(struct p
 	 * bridge and we must not, for example, enable MWI or set the
 	 * cache line size on them.
 	 */
-#ifdef CONFIG_PPC32
 	if (updatecfg) {
 		u16 cmd;
 
@@ -1118,12 +1118,23 @@ int pmac_pci_enable_device_hook(struct p
 
 		pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE,
 				      L1_CACHE_BYTES >> 2);
-#endif
 	}
 
 	return 0;
 }
 
+void __devinit pmac_pci_fixup_ohci(struct pci_dev *dev)
+{
+	struct device_node *node = pci_device_to_OF_node(dev);
+
+	/* We don't want to assign resources to USB controllers
+	 * absent from the OF tree (iBook second controller)
+	 */
+	if (dev->class == PCI_CLASS_SERIAL_USB_OHCI && !node)
+		dev->resource[0].flags = 0;
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_APPLE, PCI_ANY_ID, pmac_pci_fixup_ohci);
+
 /* We power down some devices after they have been probed. They'll
  * be powered back on later on
  */
@@ -1171,7 +1182,6 @@ void __init pmac_pcibios_after_init(void
 	of_node_put(nd);
 }
 
-#ifdef CONFIG_PPC32
 void pmac_pci_fixup_cardbus(struct pci_dev* dev)
 {
 	if (!machine_is(powermac))
@@ -1259,7 +1269,7 @@ void pmac_pci_fixup_pciata(struct pci_de
 	}
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_ANY_ID, PCI_ANY_ID, pmac_pci_fixup_pciata);
-#endif
+#endif /* CONFIG_PPC32 */
 
 /*
  * Disable second function on K2-SATA, it's broken
