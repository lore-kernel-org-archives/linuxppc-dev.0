Date: Thu, 29 Jul 2004 22:35:01 +0100
To: paulus@samba.org
Cc: trini@kernel.crashing.org, linuxppc-dev@lists.linuxppc.org,
	barbieri@gmail.com
Subject: [9/9] Support for old IBM PReP boxes
Message-ID: <20040729213501.GA5929@george.solinno.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: leigh@solinno.co.uk (Leigh Brown)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This makes the /proc/interrupts display the correct edge/level
indicator for each interrupt.  This is purely cosmetic, but does
reduce confusion.

diff -urNX /home/leigh/.diffex linux-2.6.8-rc2-bk8.prev/arch/ppc/platforms/prep_pci.c linux-2.6.8-rc2-bk8/arch/ppc/platforms/prep_pci.c
--- linux-2.6.8-rc2-bk8.prev/arch/ppc/platforms/prep_pci.c	2004-07-29 20:44:33.000000000 +0100
+++ linux-2.6.8-rc2-bk8/arch/ppc/platforms/prep_pci.c	2004-07-29 20:56:09.000000000 +0100
@@ -1029,11 +1029,18 @@
 		}
 	} else if ( _prep_type == _PREP_IBM ) {
 		unsigned char irq_edge_mask_lo, irq_edge_mask_hi;
+		unsigned short irq_edge_mask;
+		int i;

 		setup_ibm_pci(&irq_edge_mask_lo, &irq_edge_mask_hi);

 		outb(inb(0x04d0)|irq_edge_mask_lo, 0x4d0); /* primary 8259 */
 		outb(inb(0x04d1)|irq_edge_mask_hi, 0x4d1); /* cascaded 8259 */
+
+		irq_edge_mask = (irq_edge_mask_hi << 8) | irq_edge_mask_lo;
+		for (i = 0; i < 16; ++i, irq_edge_mask >>= 1)
+			if (irq_edge_mask & 1)
+				irq_desc[i].status |= IRQ_LEVEL;
 	} else {
 		printk("No known machine pci routing!\n");
 		return;

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
