Date: Thu, 29 Jul 2004 22:34:27 +0100
To: paulus@samba.org
Cc: trini@kernel.crashing.org, linuxppc-dev@lists.linuxppc.org,
	barbieri@gmail.com
Subject: [4/9] Support for old IBM PReP boxes
Message-ID: <20040729213427.GA5893@george.solinno.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: leigh@solinno.co.uk (Leigh Brown)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This adds a function to determine the 8259 level/edge mask word.
With this function we can now (in theory) support any IBM PReP
machine.  We therefore add a little bit more code to fallback
to using residual data if we don't recognise the machine.


diff -urNX /home/leigh/.diffex linux-2.6.8-rc2-bk8.prev/arch/ppc/platforms/prep_pci.c linux-2.6.8-rc2-bk8/arch/ppc/platforms/prep_pci.c
--- linux-2.6.8-rc2-bk8.prev/arch/ppc/platforms/prep_pci.c	2004-07-29 20:41:49.000000000 +0100
+++ linux-2.6.8-rc2-bk8/arch/ppc/platforms/prep_pci.c	2004-07-29 20:42:14.000000000 +0100
@@ -901,6 +901,17 @@
 }

 void __init
+prep_residual_setup_pci(char *irq_edge_mask_lo, char *irq_edge_mask_hi)
+{
+	if (have_residual_data()) {
+		Motherboard_map_name = res->VitalProductData.PrintableModel;
+		Motherboard_map = NULL;
+		Motherboard_routes = NULL;
+		residual_irq_mask(irq_edge_mask_lo, irq_edge_mask_hi);
+	}
+}
+
+void __init
 prep_sandalfoot_setup_pci(char *irq_edge_mask_lo, char *irq_edge_mask_hi)
 {
 	Motherboard_map_name = "IBM 6015/7020 (Sandalfoot/Sandalbow)";
@@ -1022,10 +1033,13 @@
 	}

 	/* Set up mapping from slots */
-	for (i = 1;  i <= 4;  i++)
-		ibc_pirq[i-1] = Motherboard_routes[i];
-	/* Enable PCI interrupts */
-	*ibc_pcicon |= 0x20;
+	if (Motherboard_routes) {
+		for (i = 1;  i <= 4;  i++)
+			ibc_pirq[i-1] = Motherboard_routes[i];
+
+		/* Enable PCI interrupts */
+		*ibc_pcicon |= 0x20;
+	}
 }

 void __init
diff -urNX /home/leigh/.diffex linux-2.6.8-rc2-bk8.prev/arch/ppc/platforms/prep_setup.c linux-2.6.8-rc2-bk8/arch/ppc/platforms/prep_setup.c
--- linux-2.6.8-rc2-bk8.prev/arch/ppc/platforms/prep_setup.c	2004-07-29 20:41:21.000000000 +0100
+++ linux-2.6.8-rc2-bk8/arch/ppc/platforms/prep_setup.c	2004-07-29 20:42:14.000000000 +0100
@@ -79,6 +79,7 @@

 int _prep_type;

+extern void prep_residual_setup_pci(char *irq_edge_mask_lo, char *irq_edge_mask_hi);
 extern void prep_sandalfoot_setup_pci(char *irq_edge_mask_lo, char *irq_edge_mask_hi);
 extern void prep_thinkpad_setup_pci(char *irq_edge_mask_lo, char *irq_edge_mask_hi);
 extern void prep_carolina_setup_pci(char *irq_edge_mask_lo, char *irq_edge_mask_hi);
@@ -209,6 +210,13 @@
 }

 static int __prep
+prep_gen_cpuinfo(struct seq_file *m)
+{
+	prep_ibm_cpuinfo(m);
+	return 0;
+}
+
+static int __prep
 prep_sandalfoot_cpuinfo(struct seq_file *m)
 {
 	unsigned int equip_reg = inb(PREP_IBM_EQUIPMENT);
@@ -821,7 +829,16 @@
 				ppc_md.show_cpuinfo = prep_thinkpad_cpuinfo;
 				break;
 			default:
-				printk(" -- unknown! Assuming Carolina");
+				if (have_residual_data()) {
+					prep_gen_enable_l2();
+					setup_ibm_pci = prep_residual_setup_pci;
+					ppc_md.power_off = prep_halt;
+					ppc_md.show_cpuinfo = prep_gen_cpuinfo;
+					break;
+				}
+				else
+					printk(" - unknown! Assuming Carolina");
+					/* fall through */
 			case PREP_IBM_CAROLINA_IDE_0:
 			case PREP_IBM_CAROLINA_IDE_1:
 			case PREP_IBM_CAROLINA_IDE_2:
diff -urNX /home/leigh/.diffex linux-2.6.8-rc2-bk8.prev/arch/ppc/platforms/residual.c linux-2.6.8-rc2-bk8/arch/ppc/platforms/residual.c
--- linux-2.6.8-rc2-bk8.prev/arch/ppc/platforms/residual.c	2004-07-29 20:41:49.000000000 +0100
+++ linux-2.6.8-rc2-bk8/arch/ppc/platforms/residual.c	2004-07-29 20:42:14.000000000 +0100
@@ -887,6 +887,36 @@
 	return (irq < 0) ? 0 : irq;
 }

+void __init residual_irq_mask(char *irq_edge_mask_lo, char *irq_edge_mask_hi)
+{
+	PPC_DEVICE *dev;
+	int i = 0;
+	unsigned short irq_mask = 0x000; /* default to edge */
+
+	while ((dev = residual_find_device(-1, NULL, -1, -1, -1, i++))) {
+		PnP_TAG_PACKET *pkt;
+		unsigned short mask;
+		int size;
+		int offset = dev->AllocatedOffset;
+
+		if (!offset)
+			continue;
+
+		pkt = PnP_find_packet(res->DevicePnPHeap + offset,
+					      IRQFormat, 0);
+		if (!pkt)
+			continue;
+
+		size = tag_small_count(pkt->S1_Pack.Tag) + 1;
+		mask = ld_le16((unsigned short *)pkt->S4_Pack.IRQMask);
+		if (size > 3 && (pkt->S4_Pack.IRQInfo & 0x0c))
+			irq_mask |= mask;
+	}
+
+	*irq_edge_mask_lo = irq_mask & 0xff;
+	*irq_edge_mask_hi = irq_mask >> 8;
+}
+
 PnP_TAG_PACKET *PnP_find_packet(unsigned char *p,
 				unsigned packet_tag,
 				int n)
diff -urNX /home/leigh/.diffex linux-2.6.8-rc2-bk8.prev/include/asm-ppc/residual.h linux-2.6.8-rc2-bk8/include/asm-ppc/residual.h
--- linux-2.6.8-rc2-bk8.prev/include/asm-ppc/residual.h	2004-07-29 20:41:49.000000000 +0100
+++ linux-2.6.8-rc2-bk8/include/asm-ppc/residual.h	2004-07-29 20:42:14.000000000 +0100
@@ -327,6 +327,7 @@
 					unsigned char * DevID, int BaseType,
 					int SubType, int Interface, int n);
 extern int residual_pcidev_irq(struct pci_dev *dev);
+extern void residual_irq_mask(char *irq_edge_mask_lo, char *irq_edge_mask_hi);
 extern PnP_TAG_PACKET *PnP_find_packet(unsigned char *p, unsigned packet_tag,
 				       int n);
 extern PnP_TAG_PACKET *PnP_find_small_vendor_packet(unsigned char *p,

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
