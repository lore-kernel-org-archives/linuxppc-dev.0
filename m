From: hollis@austin.ibm.com
Date: Tue, 6 Nov 2001 17:15:59 -0600
To: linuxppc-dev@lists.linuxppc.org
Cc: davidm@amberdata.demon.co.uk, Sven.Dickert@planb.de
Subject: RFC: i8259.c cleanup
Message-ID: <20011106171559.D9471@austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="DIOMP1UsTsWJauNi"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--DIOMP1UsTsWJauNi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

i8259.c hasn't worked right for a long time on IBM PReP's, which crippled
those that use IDE ("hda: lost interrupt" forever). I sent a note about this a
while back
(http://lists.linuxppc.org/linuxppc-workstation/200109/msg00030.html) but
never got any answers...

Anyways, by reading from 0xbffffff0 we can get the active irq without having
to play with the 8259 directly (which we were doing wrong; see above URL).
This is true on the IBM PReP's because the 8259's are implemented in the Fire
Coral SIO bridge (which is on the PCI bus), so it can respond to the PHB's
interrupt request. (Unless I'm mistaken it's the PHB, in this case MPC105,
which decodes 0xbffffff0 and asks the system interrupt controller to supply
the active irq number.)

The following patch (to linuxppc_2_4_devel) does exactly that - it reads from
0xbffffff0 instead of the 8259 directly. This seems to have completely fixed
the lost irq problems that we (IBM PReP users) have been having for a long
time. This patch has only been tested on a 6050 so far, but that should cover
all the Carolina's.

I'm not positive this trick will work on every board that has an 8259. The
PReP spec calls for it, and anything with an MPC105/106 should support it. I'm
really hoping that covers everyone...

Also, with this trick our i8259.c could be made almost identical to
i386/mips/alpha, which already know the irq vector entering mask_and_ack().
A lot of our boards call i8259_irq() directly though, which would have to be
changed. I only suggest it because the i386 folks apparently know 8259's
better than we do... :) Oh, and alpha uses the rotating priority feature which
sounds cool. :)

The patch also cleans up some whitespace (parts of i8259.c were apparently
copied and pasted from one xterm to another), adds a few comments, and adds
resource_request's for both 8259's.

i8259_irq() (called from a variety of embedded files) is passed a single
argument, int cpu. This argument is never used and should probably be deleted?

I have one other question, regarding spin_lock vs spin_lock_irqsave. We use
both in different places in i8259.c ("_irqsave" is commented out in some
places). i386 and mips use irqsave in their i8259.c's, alpha does not. Which
is appropriate here?

-Hollis

--DIOMP1UsTsWJauNi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="8259-cleanup.patch"

===== arch/ppc/kernel/i8259.c 1.10 vs edited =====
--- 1.10/arch/ppc/kernel/i8259.c	Sun Nov  4 04:07:37 2001
+++ edited/arch/ppc/kernel/i8259.c	Tue Nov  6 17:01:49 2001
@@ -4,11 +4,14 @@

 #include <linux/stddef.h>
 #include <linux/init.h>
+#include <linux/ioport.h>
 #include <linux/sched.h>
 #include <linux/signal.h>
 #include <asm/io.h>
 #include <asm/i8259.h>

+static volatile char *pci_intack; /* RO, gives us the irq vector */
+
 unsigned char cached_8259[2] = { 0xff, 0xff };
 #define cached_A1 (cached_8259[0])
 #define cached_21 (cached_8259[1])
@@ -22,30 +25,19 @@
 	int irq;

 	spin_lock/*_irqsave*/(&i8259_lock/*, flags*/);
-        /*
-         * Perform an interrupt acknowledge cycle on controller 1
-         */
-        outb(0x0C, 0x20);
-        irq = inb(0x20) & 7;
-        if (irq == 2)
-        {
-                /*
-                 * Interrupt is cascaded so perform interrupt
-                 * acknowledge on controller 2
-                 */
-                outb(0x0C, 0xA0);
-                irq = (inb(0xA0) & 7) + 8;
-        }
-        else if (irq==7)
-        {
-                /*
-                 * This may be a spurious interrupt
-                 *
-                 * Read the interrupt status register. If the most
-                 * significant bit is not set then there is no valid
+	/*
+	 * Perform an interrupt acknowledge cycle on controller 1
+	 */
+	irq = *pci_intack & 0xff;
+	if (irq == 7) {
+		/*
+		 * This may be a spurious interrupt
+		 *
+		 * Read the interrupt status register. If the most
+		 * significant bit is not set then there is no valid
 		 * interrupt
 		 */
-		outb(0x0b, 0x20);
+		outb(0x0b, 0x20); /* select ISR */
 		if(~inb(0x20)&0x80) {
 			spin_unlock/*_irqrestore*/(&i8259_lock/*, flags*/);
 			return -1;
@@ -60,28 +52,28 @@
 	unsigned long flags;

 	spin_lock_irqsave(&i8259_lock, flags);
-        if ( irq_nr >= i8259_pic_irq_offset )
-                irq_nr -= i8259_pic_irq_offset;
+	if ( irq_nr >= i8259_pic_irq_offset )
+		irq_nr -= i8259_pic_irq_offset;

-        if (irq_nr > 7) {
-                cached_A1 |= 1 << (irq_nr-8);
-                inb(0xA1);      /* DUMMY */
-                outb(cached_A1,0xA1);
-                outb(0x20,0xA0);        /* Non-specific EOI */
-                outb(0x20,0x20);        /* Non-specific EOI to cascade */
-        } else {
-                cached_21 |= 1 << irq_nr;
-                inb(0x21);      /* DUMMY */
-                outb(cached_21,0x21);
-                outb(0x20,0x20);        /* Non-specific EOI */
-        }
+	if (irq_nr > 7) {
+		cached_A1 |= 1 << (irq_nr-8);
+		inb(0xA1); /* DUMMY */
+		outb(cached_A1,0xA1);
+		outb(0x20,0xA0); /* Non-specific EOI */
+		outb(0x20,0x20); /* Non-specific EOI to cascade */
+	} else {
+		cached_21 |= 1 << irq_nr;
+		inb(0x21); /* DUMMY */
+		outb(cached_21,0x21);
+		outb(0x20,0x20); /* Non-specific EOI */
+	}
 	spin_unlock_irqrestore(&i8259_lock, flags);
 }

 static void i8259_set_irq_mask(int irq_nr)
 {
-        outb(cached_A1,0xA1);
-        outb(cached_21,0x21);
+	outb(cached_A1,0xA1);
+	outb(cached_21,0x21);
 }

 static void i8259_mask_irq(unsigned int irq_nr)
@@ -89,13 +81,13 @@
 	unsigned long flags;

 	spin_lock_irqsave(&i8259_lock, flags);
-        if ( irq_nr >= i8259_pic_irq_offset )
-                irq_nr -= i8259_pic_irq_offset;
-        if ( irq_nr < 8 )
-                cached_21 |= 1 << irq_nr;
-        else
-                cached_A1 |= 1 << (irq_nr-8);
-        i8259_set_irq_mask(irq_nr);
+	if ( irq_nr >= i8259_pic_irq_offset )
+		irq_nr -= i8259_pic_irq_offset;
+	if ( irq_nr < 8 )
+		cached_21 |= 1 << irq_nr;
+	else
+		cached_A1 |= 1 << (irq_nr-8);
+	i8259_set_irq_mask(irq_nr);
 	spin_unlock_irqrestore(&i8259_lock, flags);
 }

@@ -104,13 +96,13 @@
 	unsigned long flags;

 	spin_lock_irqsave(&i8259_lock, flags);
-        if ( irq_nr >= i8259_pic_irq_offset )
-                irq_nr -= i8259_pic_irq_offset;
-        if ( irq_nr < 8 )
-                cached_21 &= ~(1 << irq_nr);
-        else
-                cached_A1 &= ~(1 << (irq_nr-8));
-        i8259_set_irq_mask(irq_nr);
+	if ( irq_nr >= i8259_pic_irq_offset )
+		irq_nr -= i8259_pic_irq_offset;
+	if ( irq_nr < 8 )
+		cached_21 &= ~(1 << irq_nr);
+	else
+		cached_A1 &= ~(1 << (irq_nr-8));
+	i8259_set_irq_mask(irq_nr);
 	spin_unlock_irqrestore(&i8259_lock, flags);
 }

@@ -121,14 +113,22 @@
 }

 struct hw_interrupt_type i8259_pic = {
-        " i8259    ",
-        NULL,
-        NULL,
-        i8259_unmask_irq,
-        i8259_mask_irq,
-        i8259_mask_and_ack_irq,
-        i8259_end_irq,
-        NULL
+	" i8259    ",
+	NULL,
+	NULL,
+	i8259_unmask_irq,
+	i8259_mask_irq,
+	i8259_mask_and_ack_irq,
+	i8259_end_irq,
+	NULL
+};
+
+static struct resource pic1_io_resource = {
+	"pic1", 0x20, 0x3f, IORESOURCE_BUSY
+};
+
+static struct resource pic2_io_resource = {
+	"pic2", 0xa0, 0xbf, IORESOURCE_BUSY
 };

 void __init i8259_init(void)
@@ -136,21 +136,26 @@
 	unsigned long flags;

 	spin_lock_irqsave(&i8259_lock, flags);
-        /* init master interrupt controller */
-        outb(0x11, 0x20); /* Start init sequence */
-        outb(0x00, 0x21); /* Vector base */
-        outb(0x04, 0x21); /* edge tiggered, Cascade (slave) on IRQ2 */
-        outb(0x01, 0x21); /* Select 8086 mode */
-        outb(0xFF, 0x21); /* Mask all */
-        /* init slave interrupt controller */
-        outb(0x11, 0xA0); /* Start init sequence */
-        outb(0x08, 0xA1); /* Vector base */
-        outb(0x02, 0xA1); /* edge triggered, Cascade (slave) on IRQ2 */
-        outb(0x01, 0xA1); /* Select 8086 mode */
-        outb(0xFF, 0xA1); /* Mask all */
-        outb(cached_A1, 0xA1);
-        outb(cached_21, 0x21);
+	/* init master interrupt controller */
+	outb(0x11, 0x20); /* Start init sequence */
+	outb(0x00, 0x21); /* Vector base */
+	outb(0x04, 0x21); /* edge tiggered, Cascade (slave) on IRQ2 */
+	outb(0x01, 0x21); /* Select 8086 mode */
+	outb(0xFF, 0x21); /* Mask all */
+	/* init slave interrupt controller */
+	outb(0x11, 0xA0); /* Start init sequence */
+	outb(0x08, 0xA1); /* Vector base */
+	outb(0x02, 0xA1); /* edge triggered, Cascade (slave) on IRQ2 */
+	outb(0x01, 0xA1); /* Select 8086 mode */
+	outb(0xFF, 0xA1); /* Mask all */
+	outb(cached_A1, 0xA1);
+	outb(cached_21, 0x21);
 	spin_unlock_irqrestore(&i8259_lock, flags);
-        request_irq( i8259_pic_irq_offset + 2, no_action, SA_INTERRUPT,
-                     "82c59 secondary cascade", NULL );
+
+	request_irq( i8259_pic_irq_offset + 2, no_action, SA_INTERRUPT,
+				"82c59 secondary cascade", NULL );
+	request_resource(&ioport_resource, &pic1_io_resource);
+	request_resource(&ioport_resource, &pic2_io_resource);
+
+	pci_intack = ioremap(0xbffffff0, 1);
 }

--DIOMP1UsTsWJauNi--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
