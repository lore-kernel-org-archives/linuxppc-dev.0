Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 294F2B7E93
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2010 23:32:05 +1100 (EST)
Message-Id: <20100218122000.622487988@linutronix.de>
Date: Thu, 18 Feb 2010 12:23:11 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: [patch 13/15] powerpc: Convert i8259_lock to raw_spinlock
References: <20100218121904.620984825@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

i8259_lock needs to be a real spinlock in RT. Convert it to
raw_spinlock.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/sysdev/i8259.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

Index: linux-2.6-tip/arch/powerpc/sysdev/i8259.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/sysdev/i8259.c
+++ linux-2.6-tip/arch/powerpc/sysdev/i8259.c
@@ -23,7 +23,7 @@ static unsigned char cached_8259[2] = { 
 #define cached_A1 (cached_8259[0])
 #define cached_21 (cached_8259[1])
 
-static DEFINE_SPINLOCK(i8259_lock);
+static DEFINE_RAW_SPINLOCK(i8259_lock);
 
 static struct irq_host *i8259_host;
 
@@ -42,7 +42,7 @@ unsigned int i8259_irq(void)
 	if (pci_intack)
 		irq = readb(pci_intack);
 	else {
-		spin_lock(&i8259_lock);
+		raw_spin_lock(&i8259_lock);
 		lock = 1;
 
 		/* Perform an interrupt acknowledge cycle on controller 1. */
@@ -74,7 +74,7 @@ unsigned int i8259_irq(void)
 		irq = NO_IRQ;
 
 	if (lock)
-		spin_unlock(&i8259_lock);
+		raw_spin_unlock(&i8259_lock);
 	return irq;
 }
 
@@ -82,7 +82,7 @@ static void i8259_mask_and_ack_irq(unsig
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&i8259_lock, flags);
+	raw_spin_lock_irqsave(&i8259_lock, flags);
 	if (irq_nr > 7) {
 		cached_A1 |= 1 << (irq_nr-8);
 		inb(0xA1); 	/* DUMMY */
@@ -95,7 +95,7 @@ static void i8259_mask_and_ack_irq(unsig
 		outb(cached_21, 0x21);
 		outb(0x20, 0x20);	/* Non-specific EOI */
 	}
-	spin_unlock_irqrestore(&i8259_lock, flags);
+	raw_spin_unlock_irqrestore(&i8259_lock, flags);
 }
 
 static void i8259_set_irq_mask(int irq_nr)
@@ -110,13 +110,13 @@ static void i8259_mask_irq(unsigned int 
 
 	pr_debug("i8259_mask_irq(%d)\n", irq_nr);
 
-	spin_lock_irqsave(&i8259_lock, flags);
+	raw_spin_lock_irqsave(&i8259_lock, flags);
 	if (irq_nr < 8)
 		cached_21 |= 1 << irq_nr;
 	else
 		cached_A1 |= 1 << (irq_nr-8);
 	i8259_set_irq_mask(irq_nr);
-	spin_unlock_irqrestore(&i8259_lock, flags);
+	raw_spin_unlock_irqrestore(&i8259_lock, flags);
 }
 
 static void i8259_unmask_irq(unsigned int irq_nr)
@@ -125,13 +125,13 @@ static void i8259_unmask_irq(unsigned in
 
 	pr_debug("i8259_unmask_irq(%d)\n", irq_nr);
 
-	spin_lock_irqsave(&i8259_lock, flags);
+	raw_spin_lock_irqsave(&i8259_lock, flags);
 	if (irq_nr < 8)
 		cached_21 &= ~(1 << irq_nr);
 	else
 		cached_A1 &= ~(1 << (irq_nr-8));
 	i8259_set_irq_mask(irq_nr);
-	spin_unlock_irqrestore(&i8259_lock, flags);
+	raw_spin_unlock_irqrestore(&i8259_lock, flags);
 }
 
 static struct irq_chip i8259_pic = {
@@ -241,7 +241,7 @@ void i8259_init(struct device_node *node
 	unsigned long flags;
 
 	/* initialize the controller */
-	spin_lock_irqsave(&i8259_lock, flags);
+	raw_spin_lock_irqsave(&i8259_lock, flags);
 
 	/* Mask all first */
 	outb(0xff, 0xA1);
@@ -273,7 +273,7 @@ void i8259_init(struct device_node *node
 	outb(cached_A1, 0xA1);
 	outb(cached_21, 0x21);
 
-	spin_unlock_irqrestore(&i8259_lock, flags);
+	raw_spin_unlock_irqrestore(&i8259_lock, flags);
 
 	/* create a legacy host */
 	i8259_host = irq_alloc_host(node, IRQ_HOST_MAP_LEGACY,
