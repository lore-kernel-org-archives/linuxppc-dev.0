Date: Thu, 29 Jul 2004 22:34:23 +0100
To: paulus@samba.org
Cc: trini@kernel.crashing.org, linuxppc-dev@lists.linuxppc.org,
	barbieri@gmail.com
Subject: [3/9] Support for old IBM PReP boxes
Message-ID: <20040729213423.GA5884@george.solinno.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: leigh@solinno.co.uk (Leigh Brown)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This adds a function to use the residual data to determine the IRQ
for a given PCI device, and changes prep_pcibios_fixup() to use it.


diff -urNX /home/leigh/.diffex linux-2.6.8-rc2-bk8.prev/arch/ppc/platforms/prep_pci.c linux-2.6.8-rc2-bk8/arch/ppc/platforms/prep_pci.c
--- linux-2.6.8-rc2-bk8.prev/arch/ppc/platforms/prep_pci.c	2004-07-29 20:40:14.000000000 +0100
+++ linux-2.6.8-rc2-bk8/arch/ppc/platforms/prep_pci.c	2004-07-29 20:41:49.000000000 +0100
@@ -1171,38 +1171,52 @@
 prep_pcibios_fixup(void)
 {
         struct pci_dev *dev = NULL;
+	int irq;
+	int have_openpic = (OpenPIC_Addr != NULL);

 	prep_route_pci_interrupts();

 	printk("Setting PCI interrupts for a \"%s\"\n", Motherboard_map_name);
-	if (OpenPIC_Addr) {
-		/* PCI interrupts are controlled by the OpenPIC */
-		while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
-			if (dev->bus->number == 0) {
-                       		dev->irq = openpic_to_irq(Motherboard_map[PCI_SLOT(dev->devfn)]);
-				pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
-			} else {
-				if (Motherboard_non0 != NULL)
-					Motherboard_non0(dev);
-			}
-		}
-
-		/* Setup the Winbond or Via PIB */
-		prep_pib_init();
-
-		return;
-	}

-	dev = NULL;
+	/* Iterate through all the PCI devices, setting the IRQ */
 	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
 		/*
-		 * Use our old hard-coded kludge to figure out what
-		 * irq this device uses.  This is necessary on things
-		 * without residual data. -- Cort
+		 * If we have residual data, then this is easy: query the
+		 * residual data for the IRQ line allocated to the device.
+		 * This works the same whether we have an OpenPic or not.
+		 */
+		if (have_residual_data()) {
+			irq = residual_pcidev_irq(dev);
+			dev->irq = have_openpic ? openpic_to_irq(irq) : irq;
+		}
+		/*
+		 * If we don't have residual data, then we need to use
+		 * tables to determine the IRQ.  The table organisation
+		 * is different depending on whether there is an OpenPIC
+		 * or not.  The tables are only used for bus 0, so check
+		 * this first.
 		 */
-		unsigned char d = PCI_SLOT(dev->devfn);
-		dev->irq = Motherboard_routes[Motherboard_map[d]];
+		else if (dev->bus->number == 0) {
+			irq = Motherboard_map[PCI_SLOT(dev->devfn)];
+			dev->irq = have_openpic ? openpic_to_irq(irq)
+						: Motherboard_routes[irq];
+		}
+		/*
+		 * Finally, if we don't have residual data and the bus is
+		 * non-zero, use the callback (if provided)
+		 */
+		else {
+			if (Motherboard_non0 != NULL)
+				Motherboard_non0(dev);
+
+			continue;
+		}
+
+		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
 	}
+
+	/* Setup the Winbond or Via PIB */
+	prep_pib_init();
 }

 static void __init
diff -urNX /home/leigh/.diffex linux-2.6.8-rc2-bk8.prev/arch/ppc/platforms/residual.c linux-2.6.8-rc2-bk8/arch/ppc/platforms/residual.c
--- linux-2.6.8-rc2-bk8.prev/arch/ppc/platforms/residual.c	2004-07-29 20:40:14.000000000 +0100
+++ linux-2.6.8-rc2-bk8/arch/ppc/platforms/residual.c	2004-07-29 20:41:49.000000000 +0100
@@ -827,6 +827,66 @@
 	return NULL;
 }

+static int __init
+residual_scan_pcibridge(PnP_TAG_PACKET * pkt, struct pci_dev *dev)
+{
+	int irq = -1;
+
+#define data pkt->L4_Pack.L4_Data.L4_PPCPack.PPCData
+	if (dev->bus->number == data[16]) {
+		int i, size;
+
+		size = 3 + ld_le16((u_short *) (&pkt->L4_Pack.Count0));
+		for (i = 20; i < size - 4; i += 12) {
+			unsigned char pin;
+			int line_irq;
+
+			if (dev->devfn != data[i + 1])
+				continue;
+
+			pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
+			if (pin) {
+				line_irq = ld_le16((unsigned short *)
+						(&data[i + 4 + 2 * (pin - 1)]));
+				irq = (line_irq == 0xffff) ? 0
+							   : line_irq & 0x7fff;
+			} else
+				irq = 0;
+
+			break;
+		}
+	}
+#undef data
+
+	return irq;
+}
+
+int __init
+residual_pcidev_irq(struct pci_dev *dev)
+{
+	int i = 0;
+	int irq = -1;
+	PPC_DEVICE *bridge;
+
+	while ((bridge = residual_find_device
+	       (-1, NULL, BridgeController, PCIBridge, -1, i++))) {
+
+		PnP_TAG_PACKET *pkt;
+		if (bridge->AllocatedOffset) {
+			pkt = PnP_find_large_vendor_packet(res->DevicePnPHeap +
+					   bridge->AllocatedOffset, 3, 0);
+			if (!pkt)
+				continue;
+
+			irq = residual_scan_pcibridge(pkt, dev);
+			if (irq != -1)
+				break;
+		}
+	}
+
+	return (irq < 0) ? 0 : irq;
+}
+
 PnP_TAG_PACKET *PnP_find_packet(unsigned char *p,
 				unsigned packet_tag,
 				int n)
diff -urNX /home/leigh/.diffex linux-2.6.8-rc2-bk8.prev/include/asm-ppc/residual.h linux-2.6.8-rc2-bk8/include/asm-ppc/residual.h
--- linux-2.6.8-rc2-bk8.prev/include/asm-ppc/residual.h	2004-07-29 20:40:14.000000000 +0100
+++ linux-2.6.8-rc2-bk8/include/asm-ppc/residual.h	2004-07-29 20:41:49.000000000 +0100
@@ -315,11 +315,18 @@
   } RESIDUAL;


+/*
+ * Forward declaration - we can't include <linux/pci.h> because it
+ * breaks the boot loader
+ */
+struct pci_dev;
+
 extern RESIDUAL *res;
 extern void print_residual_device_info(void);
 extern PPC_DEVICE *residual_find_device(unsigned long BusMask,
 					unsigned char * DevID, int BaseType,
 					int SubType, int Interface, int n);
+extern int residual_pcidev_irq(struct pci_dev *dev);
 extern PnP_TAG_PACKET *PnP_find_packet(unsigned char *p, unsigned packet_tag,
 				       int n);
 extern PnP_TAG_PACKET *PnP_find_small_vendor_packet(unsigned char *p,

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
