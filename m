Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3144167B30
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jun 2006 13:55:14 +1000 (EST)
Subject: [PATCH] powerpc-genirq: port 8259 driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 13:54:50 +1000
Message-Id: <1150170890.13958.23.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch ports the powerpc's i8259 driver to genirq.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Patch depends on Ingo/Thomas genirq patchset. It's not to be merged
right away, It's being posted here for comments as I may have further
rework.

Index: linux-work/arch/powerpc/sysdev/i8259.c
===================================================================
--- linux-work.orig/arch/powerpc/sysdev/i8259.c	2006-06-06 14:39:19.000000000 +1000
+++ linux-work/arch/powerpc/sysdev/i8259.c	2006-06-06 14:45:10.000000000 +1000
@@ -69,11 +69,6 @@ int i8259_irq(struct pt_regs *regs)
 	return irq + i8259_pic_irq_offset;
 }
 
-int i8259_irq_cascade(struct pt_regs *regs, void *unused)
-{
-	return i8259_irq(regs);
-}
-
 static void i8259_mask_and_ack_irq(unsigned int irq_nr)
 {
 	unsigned long flags;
@@ -129,19 +124,11 @@ static void i8259_unmask_irq(unsigned in
 	spin_unlock_irqrestore(&i8259_lock, flags);
 }
 
-static void i8259_end_irq(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS))
-	    && irq_desc[irq].action)
-		i8259_unmask_irq(irq);
-}
-
-struct hw_interrupt_type i8259_pic = {
-	.typename = " i8259    ",
-	.enable = i8259_unmask_irq,
-	.disable = i8259_mask_irq,
-	.ack = i8259_mask_and_ack_irq,
-	.end = i8259_end_irq,
+static struct irq_chip i8259_pic = {
+	.typename	= " i8259    ",
+	.mask		= i8259_mask_irq,
+	.unmask		= i8259_unmask_irq,
+	.mask_ack	= i8259_mask_and_ack_irq,
 };
 
 static struct resource pic1_iores = {
@@ -207,8 +194,11 @@ void __init i8259_init(unsigned long int
 
 	spin_unlock_irqrestore(&i8259_lock, flags);
 
-	for (i = 0; i < NUM_ISA_INTERRUPTS; ++i)
-		irq_desc[offset + i].chip = &i8259_pic;
+	for (i = 0; i < NUM_ISA_INTERRUPTS; ++i) {
+		set_irq_chip_and_handler(offset + i, &i8259_pic,
+					 handle_level_irq);
+		irq_desc[offset + i].status |= IRQ_LEVEL;
+	}
 
 	/* reserve our resources */
 	setup_irq(offset + 2, &i8259_irqaction);
Index: linux-work/include/asm-powerpc/i8259.h
===================================================================
--- linux-work.orig/include/asm-powerpc/i8259.h	2006-06-06 14:39:19.000000000 +1000
+++ linux-work/include/asm-powerpc/i8259.h	2006-06-06 14:45:10.000000000 +1000
@@ -4,11 +4,8 @@
 
 #include <linux/irq.h>
 
-extern struct hw_interrupt_type i8259_pic;
-
 extern void i8259_init(unsigned long intack_addr, int offset);
 extern int i8259_irq(struct pt_regs *regs);
-extern int i8259_irq_cascade(struct pt_regs *regs, void *unused);
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_I8259_H */
