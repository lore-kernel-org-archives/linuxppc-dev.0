From: hollis@austin.ibm.com
Date: Tue, 4 Dec 2001 10:29:58 -0600
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: patch: i8259.c & PCI int ack
Message-ID: <20011204102958.L421@austin.ibm.com>
References: <20011203160923.H421@austin.ibm.com> <20011204094600.K421@austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wq9mPyueHGvFACwf"
In-Reply-To: <20011204094600.K421@austin.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Ugh.

-Hollis

--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="i8259-full.diff"

===== kernel/i8259.c 1.11 vs edited =====
--- 1.11/arch/ppc/kernel/i8259.c	Sun Nov 25 21:32:25 2001
+++ edited/arch/ppc/kernel/i8259.c	Mon Dec  3 16:45:31 2001
@@ -4,11 +4,15 @@

 #include <linux/stddef.h>
 #include <linux/init.h>
+#include <linux/irq.h>
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
@@ -17,35 +21,58 @@

 int i8259_pic_irq_offset;

-int i8259_irq(int cpu)
+/* Acknowledge the irq using the PCI host bridge's interrupt acknowledge
+ * feature. (Polling is somehow broken on some IBM and Motorola PReP boxes.)
+ */
+int i8259_irq(void)
 {
 	int irq;
-
+
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
+
+	irq = *pci_intack & 0xff;
+	if (irq==7) {
+		/*
+		 * This may be a spurious interrupt.
+		 *
+		 * Read the interrupt status register (ISR). If the most
+		 * significant bit is not set then there is no valid
+		 * interrupt.
+		 */
+		if(~inb(0x20)&0x80) {
+			irq = -1;
+		}
+	}
+	spin_unlock/*_irqrestore*/(&i8259_lock/*, flags*/);
+	return irq;
+}
+
+/* Poke the 8259's directly using poll commands. */
+int i8259_poll(void)
+{
+	int irq;
+
+	spin_lock/*_irqsave*/(&i8259_lock/*, flags*/);
+	/*
+	 * Perform an interrupt acknowledge cycle on controller 1
+	 */
+	outb(0x0C, 0x20); /* prepare for poll */
+	irq = inb(0x20) & 7;
+	if (irq == 2) {
+		/*
+		 * Interrupt is cascaded so perform interrupt
+		 * acknowledge on controller 2
+		 */
+		outb(0x0C, 0xA0); /* prepare for poll */
+		irq = (inb(0xA0) & 7) + 8;
+	} else if (irq==7) {
+		/*
+		 * This may be a spurious interrupt
+		 *
+		 * Read the interrupt status register. If the most
+		 * significant bit is not set then there is no valid
 		 * interrupt
 		 */
-		outb(0x0b, 0x20);
 		if(~inb(0x20)&0x80) {
 			spin_unlock/*_irqrestore*/(&i8259_lock/*, flags*/);
 			return -1;
@@ -58,30 +85,30 @@
 static void i8259_mask_and_ack_irq(unsigned int irq_nr)
 {
 	unsigned long flags;
-
+
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
@@ -89,13 +116,13 @@
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

@@ -104,13 +131,13 @@
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

@@ -121,36 +148,62 @@
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
 };

-void __init i8259_init(void)
+static struct resource pic1_iores = {
+	"8259 (master)", 0x20, 0x21, IORESOURCE_BUSY
+};
+
+static struct resource pic2_iores = {
+	"8259 (slave)", 0xa0, 0xa1, IORESOURCE_BUSY
+};
+
+static struct resource pic_edgectrl_iores = {
+	"8259 edge control", 0x4d0, 0x4d1, IORESOURCE_BUSY
+};
+
+void __init i8259_init(long intack_addr)
 {
 	unsigned long flags;
-
+
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
+
+	/* init slave interrupt controller */
+	outb(0x11, 0xA0); /* Start init sequence */
+	outb(0x08, 0xA1); /* Vector base */
+	outb(0x02, 0xA1); /* edge triggered, Cascade (slave) on IRQ2 */
+	outb(0x01, 0xA1); /* Select 8086 mode */
+
+	/* always read ISR */
+	outb(0x0B, 0x20);
+	outb(0x0B, 0xA0);
+
+	/* Mask all interrupts */
+	outb(cached_A1, 0xA1);
+	outb(cached_21, 0x21);
+
 	spin_unlock_irqrestore(&i8259_lock, flags);
-        request_irq( i8259_pic_irq_offset + 2, no_action, SA_INTERRUPT,
-                     "82c59 secondary cascade", NULL );
+
+	/* reserve our resources */
+	request_irq( i8259_pic_irq_offset + 2, no_action, SA_INTERRUPT,
+				"82c59 secondary cascade", NULL );
+	request_resource(&ioport_resource, &pic1_iores);
+	request_resource(&ioport_resource, &pic2_iores);
+	request_resource(&ioport_resource, &pic_edgectrl_iores);
+
+	if (intack_addr)
+		pci_intack = ioremap(intack_addr, 1);
 }
===== kernel/open_pic.c 1.42 vs edited =====
--- 1.42/arch/ppc/kernel/open_pic.c	Sun Nov  4 06:02:40 2001
+++ edited/arch/ppc/kernel/open_pic.c	Mon Dec  3 14:16:51 2001
@@ -19,6 +19,7 @@
 #include <linux/irq.h>
 #include <asm/ptrace.h>
 #include <asm/signal.h>
+#include <asm/i8259.h>
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/prom.h>
@@ -825,9 +826,6 @@
 /*
  * Clean up needed. -VAL
  */
-#ifndef CONFIG_GEMINI
-	extern int i8259_irq(int cpu);
-#endif
 	int irq = openpic_irq();

 	/* Management of the cascade should be moved out of here */
@@ -842,7 +840,7 @@
 			irq = *chrp_int_ack_special;
 #ifndef CONFIG_GEMINI
 		else
-			irq = i8259_irq( smp_processor_id() );
+			irq = i8259_poll();
 #endif
 		openpic_eoi();
         }
===== platforms/adir_pic.c 1.6 vs edited =====
--- 1.6/arch/ppc/platforms/adir_pic.c	Mon Nov 26 23:30:58 2001
+++ edited/arch/ppc/platforms/adir_pic.c	Tue Dec  4 08:47:49 2001
@@ -102,7 +102,7 @@
 	/* Initialize the cascaded 8259's on the VT82C686 */
 	for (i=0; i<16; i++)
 		irq_desc[i].handler = &i8259_pic;
-	i8259_init();
+	i8259_init(NULL);

 	/* Initialize Adirondack CPLD PIC and enable 8259 interrupt cascade */
 	for (i=16; i<32; i++)
@@ -126,7 +126,7 @@
 		return irq;

 	if (irq == ADIR_IRQ_VT82C686_INTR)
-		irq = i8259_irq(0);
+		irq = i8259_poll();

 	return irq;
 }
===== platforms/chrp_setup.c 1.49 vs edited =====
--- 1.49/arch/ppc/platforms/chrp_setup.c	Wed Nov 28 22:43:34 2001
+++ edited/arch/ppc/platforms/chrp_setup.c	Mon Dec  3 14:04:25 2001
@@ -370,7 +370,7 @@
 	openpic_init(1, NUM_8259_INTERRUPTS, chrp_int_ack_special, nmi_irq);
 	for ( i = 0 ; i < NUM_8259_INTERRUPTS  ; i++ )
 		irq_desc[i].handler = &i8259_pic;
-	i8259_init();
+	i8259_init(NULL);
 #if defined(CONFIG_VT) && defined(CONFIG_ADB_KEYBOARD) && defined(XMON)
 	/* see if there is a keyboard in the device tree
 	   with a parent of type "adb" */
===== platforms/k2_setup.c 1.21 vs edited =====
--- 1.21/arch/ppc/platforms/k2_setup.c	Tue Nov 27 16:44:21 2001
+++ edited/arch/ppc/platforms/k2_setup.c	Tue Dec  4 08:49:04 2001
@@ -334,13 +334,13 @@
 	for ( i = 0 ; i < 16 ; i++ )
 		irq_desc[i].handler = &i8259_pic;

-	i8259_init();
+	i8259_init(NULL);
 }

 static int
 k2_get_irq(struct pt_regs *regs)
 {
-	return i8259_irq(0);
+	return i8259_poll();
 }

 void __init platform_init(unsigned long r3, unsigned long r4,
===== platforms/lopec_setup.c 1.13 vs edited =====
--- 1.13/arch/ppc/platforms/lopec_setup.c	Tue Nov 27 15:37:17 2001
+++ edited/arch/ppc/platforms/lopec_setup.c	Tue Dec  4 08:49:38 2001
@@ -98,7 +98,7 @@
 	irq = openpic_irq();

 	if (irq == LOPEC_SIO_IRQ) {
-		cascade_irq = i8259_irq(0);
+		cascade_irq = i8259_poll();

 		if (cascade_irq != -1) {
 			irq = cascade_irq;
@@ -229,7 +229,7 @@
 		       LOPEC_SIO_IRQ);
 	}

-	i8259_init();
+	i8259_init(NULL);
 }

 static void __init
===== platforms/mcpn765_setup.c 1.21 vs edited =====
--- 1.21/arch/ppc/platforms/mcpn765_setup.c	Tue Nov 27 15:06:46 2001
+++ edited/arch/ppc/platforms/mcpn765_setup.c	Tue Dec  4 08:50:11 2001
@@ -194,7 +194,7 @@
 	for(i=0; i < NUM_8259_INTERRUPTS; i++)
 		irq_desc[i].handler = &i8259_pic;

-	i8259_init();
+	i8259_init(NULL);

 	if ( ppc_md.progress )
 		ppc_md.progress("init_irq: exit", 0);
===== platforms/menf1_setup.c 1.16 vs edited =====
--- 1.16/arch/ppc/platforms/menf1_setup.c	Tue Nov 27 15:06:46 2001
+++ edited/arch/ppc/platforms/menf1_setup.c	Tue Dec  4 08:50:40 2001
@@ -146,12 +146,12 @@

 	for ( i = 0 ; i < NUM_8259_INTERRUPTS  ; i++ )
 		irq_desc[i].handler = &i8259_pic;
-	i8259_init();
+	i8259_init(NULL);
 }

 static int menf1_get_irq(struct pt_regs *regs)
 {
-	return i8259_irq(0);
+	return i8259_poll();
 }

 /*
===== platforms/mvme5100_setup.c 1.22 vs edited =====
--- 1.22/arch/ppc/platforms/mvme5100_setup.c	Tue Nov 27 17:22:04 2001
+++ edited/arch/ppc/platforms/mvme5100_setup.c	Tue Dec  4 08:51:17 2001
@@ -143,7 +143,7 @@
 	for(i=0; i < NUM_8259_INTERRUPTS; i++)
 		irq_desc[i].handler = &i8259_pic;

-	i8259_init();
+	i8259_init(NULL);
 #else
 	openpic_init(1, 0, NULL, -1);
 #endif
===== platforms/pcore_setup.c 1.16 vs edited =====
--- 1.16/arch/ppc/platforms/pcore_setup.c	Tue Nov 27 15:06:46 2001
+++ edited/arch/ppc/platforms/pcore_setup.c	Tue Dec  4 08:52:31 2001
@@ -166,13 +166,13 @@
 	for ( i = 0 ; i < 16 ; i++ )
 		irq_desc[i].handler = &i8259_pic;

-	i8259_init();
+	i8259_init(NULL);
 }

 static int
 pcore_get_irq(struct pt_regs *regs)
 {
-	return i8259_irq(0);
+	return i8259_poll();
 }

 /*
===== platforms/powerpmc250.c 1.12 vs edited =====
--- 1.12/arch/ppc/platforms/powerpmc250.c	Tue Nov 27 17:22:04 2001
+++ edited/arch/ppc/platforms/powerpmc250.c	Tue Dec  4 08:53:19 2001
@@ -192,7 +192,7 @@
 }

 /* Resolves the open_pic.c build without including i8259.c */
-int i8259_irq(int cpu)
+int i8259_poll(void)
 {
 	return 0;
 }
===== platforms/pplus_setup.c 1.4 vs edited =====
--- 1.4/arch/ppc/platforms/pplus_setup.c	Wed Nov 21 15:27:27 2001
+++ edited/arch/ppc/platforms/pplus_setup.c	Tue Dec  4 08:54:04 2001
@@ -261,7 +261,7 @@
 static int
 pplus_get_irq(struct pt_regs *regs)
 {
-	return i8259_irq(smp_processor_id());
+	return i8259_poll();
 }

 static void __init
@@ -273,7 +273,7 @@
 		openpic_init(1, NUM_8259_INTERRUPTS, 0, -1);
 	for ( i = 0 ; i < NUM_8259_INTERRUPTS ; i++ )
 		irq_desc[i].handler = &i8259_pic;
-	i8259_init();
+	i8259_init(NULL);
 }

 #if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
===== platforms/prep_setup.c 1.59 vs edited =====
--- 1.59/arch/ppc/platforms/prep_setup.c	Thu Nov 29 08:55:58 2001
+++ edited/arch/ppc/platforms/prep_setup.c	Mon Dec  3 13:48:45 2001
@@ -667,7 +667,7 @@
 static int __prep
 prep_get_irq(struct pt_regs *regs)
 {
-	return i8259_irq(smp_processor_id());
+	return i8259_irq();
 }

 static void __init
@@ -679,7 +679,7 @@
 		openpic_init(1, NUM_8259_INTERRUPTS, 0, -1);
 	for ( i = 0 ; i < NUM_8259_INTERRUPTS ; i++ )
 		irq_desc[i].handler = &i8259_pic;
-	i8259_init();
+	i8259_init(0xbffffff0); /* PCI interrupt ack address for MPC105 and 106 */
 }

 #if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
===== platforms/prpmc750_setup.c 1.17 vs edited =====
--- 1.17/arch/ppc/platforms/prpmc750_setup.c	Tue Nov 27 17:22:04 2001
+++ edited/arch/ppc/platforms/prpmc750_setup.c	Tue Dec  4 08:56:18 2001
@@ -201,7 +201,7 @@
 }

 /* Resolves the open_pic.c build without including i8259.c */
-int i8259_irq(int cpu)
+int i8259_poll(void)
 {
 	return 0;
 }
===== platforms/prpmc800_setup.c 1.12 vs edited =====
--- 1.12/arch/ppc/platforms/prpmc800_setup.c	Tue Nov 27 17:22:04 2001
+++ edited/arch/ppc/platforms/prpmc800_setup.c	Tue Dec  4 08:57:00 2001
@@ -195,7 +195,7 @@
 }

 /* Resolves the open_pic.c build without including i8259.c */
-int i8259_irq(int cpu)
+int i8259_poll()
 {
 	return 0;
 }
===== platforms/sandpoint_setup.c 1.20 vs edited =====
--- 1.20/arch/ppc/platforms/sandpoint_setup.c	Tue Nov 27 15:06:47 2001
+++ edited/arch/ppc/platforms/sandpoint_setup.c	Tue Dec  4 08:58:55 2001
@@ -327,7 +327,7 @@
 			SANDPOINT_SIO_IRQ);
 	}

-	i8259_init();
+	i8259_init(NULL);
 }

 static int
@@ -338,7 +338,7 @@
 	irq = openpic_irq();

 	if (irq == SANDPOINT_SIO_IRQ) {
-		cascade_irq = i8259_irq(smp_processor_id());
+		cascade_irq = i8259_poll();

 		if (cascade_irq != -1) {
 			irq = cascade_irq;
===== ./i8259.h 1.9 vs edited =====
--- 1.9/include/asm-ppc/i8259.h Sun Nov  4 04:07:38 2001
+++ edited/include/asm-ppc/i8259.h    Mon Dec  3 14:09:08 2001
@@ -5,11 +5,10 @@
 #ifndef _PPC_KERNEL_i8259_H
 #define _PPC_KERNEL_i8259_H

-#include <linux/irq.h>
-
 extern struct hw_interrupt_type i8259_pic;

-void i8259_init(void);
-int i8259_irq(int);
+void i8259_init(long);
+int i8259_irq(void);
+int i8259_poll(void);

 #endif /* _PPC_KERNEL_i8259_H */

--wq9mPyueHGvFACwf--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
