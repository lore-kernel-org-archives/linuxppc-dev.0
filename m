Date: Thu, 29 Jul 2004 22:34:38 +0100
To: paulus@samba.org
Cc: trini@kernel.crashing.org, linuxppc-dev@lists.linuxppc.org,
	barbieri@gmail.com
Subject: [5/9] Support for old IBM PReP boxes
Message-ID: <20040729213438.GA5900@george.solinno.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: leigh@solinno.co.uk (Leigh Brown)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This adds a function to use the residual data to determine the
address to pass to i8259_init().


diff -urNX /home/leigh/.diffex linux-2.6.8-rc2-bk8.prev/arch/ppc/platforms/prep_setup.c linux-2.6.8-rc2-bk8/arch/ppc/platforms/prep_setup.c
--- linux-2.6.8-rc2-bk8.prev/arch/ppc/platforms/prep_setup.c	2004-07-29 20:42:14.000000000 +0100
+++ linux-2.6.8-rc2-bk8/arch/ppc/platforms/prep_setup.c	2004-07-29 20:43:53.000000000 +0100
@@ -980,6 +980,12 @@
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
 	early_read_config_dword(NULL, 0, 0, PCI_VENDOR_ID, &pci_viddid);
diff -urNX /home/leigh/.diffex linux-2.6.8-rc2-bk8.prev/arch/ppc/platforms/residual.c linux-2.6.8-rc2-bk8/arch/ppc/platforms/residual.c
--- linux-2.6.8-rc2-bk8.prev/arch/ppc/platforms/residual.c	2004-07-29 20:42:14.000000000 +0100
+++ linux-2.6.8-rc2-bk8/arch/ppc/platforms/residual.c	2004-07-29 20:43:53.000000000 +0100
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
diff -urNX /home/leigh/.diffex linux-2.6.8-rc2-bk8.prev/include/asm-ppc/residual.h linux-2.6.8-rc2-bk8/include/asm-ppc/residual.h
--- linux-2.6.8-rc2-bk8.prev/include/asm-ppc/residual.h	2004-07-29 20:42:14.000000000 +0100
+++ linux-2.6.8-rc2-bk8/include/asm-ppc/residual.h	2004-07-29 20:43:53.000000000 +0100
@@ -328,6 +328,7 @@
 					int SubType, int Interface, int n);
 extern int residual_pcidev_irq(struct pci_dev *dev);
 extern void residual_irq_mask(char *irq_edge_mask_lo, char *irq_edge_mask_hi);
+extern unsigned int residual_isapic_addr(void);
 extern PnP_TAG_PACKET *PnP_find_packet(unsigned char *p, unsigned packet_tag,
 				       int n);
 extern PnP_TAG_PACKET *PnP_find_small_vendor_packet(unsigned char *p,

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
