Message-ID: <1847.80.7.99.14.1086887021.squirrel@www.solinno.co.uk>
Date: Thu, 10 Jun 2004 18:03:41 +0100 (BST)
Subject: [RFC][PATCH 5/9] Support for old IBM PReP boxes
From: "Leigh Brown" <leigh@solinno.co.uk>
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This patch adds code to use residual data to find the address used
to call i8259_init().  Some IBMs have these in odd places, or
have funny ones that don't seem to work (in which case it returns
0 to use polling mode).


diff -urNX .diffex linux-2.6.6-prev/arch/ppc/platforms/prep_setup.c
linux-2.6.6/arch/ppc/platforms/prep_setup.c
--- linux-2.6.6-prev/arch/ppc/platforms/prep_setup.c	2004-06-10
14:06:10.000000000 +0100
+++ linux-2.6.6/arch/ppc/platforms/prep_setup.c	2004-06-10
14:08:18.000000000 +0100
@@ -981,6 +981,12 @@
 	}
 	for ( i = 0 ; i < NUM_8259_INTERRUPTS ; i++ )
 		irq_desc[i].handler = &i8259_pic;
+
+	if (have_residual_data()) {
+		i8259_init(residual_isapic_addr());
+		return;
+	}
+
 	/* If we have a Raven PCI bridge or a Hawk PCI bridge / Memory
 	 * controller, we poll (as they have a different int-ack address). */
 	early_read_config_dword(0, 0, 0, PCI_VENDOR_ID, &pci_viddid);
diff -urNX .diffex linux-2.6.6-prev/arch/ppc/platforms/residual.c
linux-2.6.6/arch/ppc/platforms/residual.c
--- linux-2.6.6-prev/arch/ppc/platforms/residual.c	2004-06-10
14:06:10.000000000 +0100
+++ linux-2.6.6/arch/ppc/platforms/residual.c	2004-06-10
14:08:18.000000000 +0100
@@ -917,6 +917,39 @@
 	*irq_edge_mask_hi = irq_mask >> 8;
 }

+unsigned int __init residual_isapic_addr(void)
+{
+	PPC_DEVICE *isapic;
+	PnP_TAG_PACKET *pkt;
+	unsigned int addr;
+
+	isapic = residual_find_device(~0, NULL, SystemPeripheral,
+				      ProgrammableInterruptController,
+				      ISA_PIC, 0);
+	if (!isapic)
+		goto unknown;
+
+	pkt = PnP_find_large_vendor_packet(res->DevicePnPHeap +
+						isapic->AllocatedOffset, 9, 0);
+	if (!pkt)
+		goto unknown;
+
+#define p pkt->L4_Pack.L4_Data.L4_PPCPack
+	/* Must be 32-bit memory address */
+	if (!((p.PPCData[0] == 2) && (p.PPCData[1] == 32)))
+		goto unknown;
+
+	/* It doesn't seem to work where length != 1 (what can I say? :-/ ) */
+	if (ld_le32((unsigned int *)(p.PPCData + 12)) != 1)
+		goto unknown;
+
+	addr = ld_le32((unsigned int *) (p.PPCData + 4));
+#undef p
+	return addr;
+unknown:
+	return 0;
+}
+
 PnP_TAG_PACKET *PnP_find_packet(unsigned char *p,
 				unsigned packet_tag,
 				int n)
diff -urNX .diffex linux-2.6.6-prev/include/asm-ppc/residual.h
linux-2.6.6/include/asm-ppc/residual.h
--- linux-2.6.6-prev/include/asm-ppc/residual.h	2004-06-10
14:06:10.000000000 +0100
+++ linux-2.6.6/include/asm-ppc/residual.h	2004-06-10 14:08:18.000000000
+0100
@@ -328,6 +328,7 @@
 					int SubType, int Interface, int n);
 extern int residual_pcidev_irq(struct pci_dev *dev);
 extern void residual_irq_mask(char *irq_edge_mask_lo, char
*irq_edge_mask_hi);
+extern unsigned int residual_isapic_addr(void);
 extern PnP_TAG_PACKET *PnP_find_packet(unsigned char *p, unsigned
packet_tag,
 				       int n);
 extern PnP_TAG_PACKET *PnP_find_small_vendor_packet(unsigned char *p,


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
