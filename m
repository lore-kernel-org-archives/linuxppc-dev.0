Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 04B2C67B2E
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jun 2006 13:57:01 +1000 (EST)
Subject: [PATCH] powerpc-genirq: port legacy powermac PIC to genirq
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 13:56:38 +1000
Message-Id: <1150170999.13958.26.camel@localhost.localdomain>
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

This patch ports the legacy powermac PIC to genirq.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Patch depends on Ingo/Thomas genirq patchset. It's not to be merged
right away, It's being posted here for comments as I may have further
rework.

Index: linux-work/arch/powerpc/kernel/irq.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/irq.c	2006-06-06 13:38:03.000000000 +1000
+++ linux-work/arch/powerpc/kernel/irq.c	2006-06-07 11:27:07.000000000 +1000
@@ -62,28 +62,27 @@
 #endif
 
 int __irq_offset_value;
-#ifdef CONFIG_PPC32
-EXPORT_SYMBOL(__irq_offset_value);
-#endif
-
 static int ppc_spurious_interrupts;
 
 #ifdef CONFIG_PPC32
-#define NR_MASK_WORDS	((NR_IRQS + 31) / 32)
+EXPORT_SYMBOL(__irq_offset_value);
+atomic_t ppc_n_lost_interrupts;
 
+#ifndef CONFIG_PPC_MERGE
+#define NR_MASK_WORDS	((NR_IRQS + 31) / 32)
 unsigned long ppc_cached_irq_mask[NR_MASK_WORDS];
-atomic_t ppc_n_lost_interrupts;
+#endif
 
 #ifdef CONFIG_TAU_INT
 extern int tau_initialized;
 extern int tau_interrupts(int);
 #endif
+#endif /* CONFIG_PPC32 */
 
 #if defined(CONFIG_SMP) && !defined(CONFIG_PPC_MERGE)
 extern atomic_t ipi_recv;
 extern atomic_t ipi_sent;
 #endif
-#endif /* CONFIG_PPC32 */
 
 #ifdef CONFIG_PPC64
 EXPORT_SYMBOL(irq_desc);
Index: linux-work/arch/powerpc/platforms/powermac/pic.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/pic.c	2006-06-06 14:44:55.000000000 +1000
+++ linux-work/arch/powerpc/platforms/powermac/pic.c	2006-06-07 11:53:46.000000000 +1000
@@ -71,18 +71,19 @@ static struct interrupt_info gatwick_int
 
 #define NR_MASK_WORDS	((NR_IRQS + 31) / 32)
 static unsigned long ppc_lost_interrupts[NR_MASK_WORDS];
+static unsigned long ppc_cached_irq_mask[NR_MASK_WORDS];
+static int pmac_irq_cascade = -1;
 
-/*
- * Mark an irq as "lost".  This is only used on the pmac
- * since it can lose interrupts (see pmac_set_irq_mask).
- * -- Cort
- */
-void __set_lost(unsigned long irq_nr, int nokick)
+static void __pmac_retrigger(unsigned int irq_nr)
 {
-	if (!test_and_set_bit(irq_nr, ppc_lost_interrupts)) {
+	if (irq_nr >= max_real_irqs && pmac_irq_cascade > 0) {
+		__set_bit(irq_nr, ppc_lost_interrupts);
+		irq_nr = pmac_irq_cascade;
+		mb();
+	}
+	if (!__test_and_set_bit(irq_nr, ppc_lost_interrupts)) {
 		atomic_inc(&ppc_n_lost_interrupts);
-		if (!nokick)
-			set_dec(1);
+		set_dec(1);
 	}
 }
 
@@ -95,10 +96,10 @@ static void pmac_mask_and_ack_irq(unsign
         if ((unsigned)irq_nr >= max_irqs)
                 return;
 
-        clear_bit(irq_nr, ppc_cached_irq_mask);
-        if (test_and_clear_bit(irq_nr, ppc_lost_interrupts))
-                atomic_dec(&ppc_n_lost_interrupts);
 	spin_lock_irqsave(&pmac_pic_lock, flags);
+        __clear_bit(irq_nr, ppc_cached_irq_mask);
+        if (__test_and_clear_bit(irq_nr, ppc_lost_interrupts))
+                atomic_dec(&ppc_n_lost_interrupts);
         out_le32(&pmac_irq_hw[i]->enable, ppc_cached_irq_mask[i]);
         out_le32(&pmac_irq_hw[i]->ack, bit);
         do {
@@ -110,7 +111,7 @@ static void pmac_mask_and_ack_irq(unsign
 	spin_unlock_irqrestore(&pmac_pic_lock, flags);
 }
 
-static void pmac_set_irq_mask(unsigned int irq_nr, int nokicklost)
+static void pmac_ack_irq(unsigned int irq_nr)
 {
         unsigned long bit = 1UL << (irq_nr & 0x1f);
         int i = irq_nr >> 5;
@@ -119,7 +120,22 @@ static void pmac_set_irq_mask(unsigned i
         if ((unsigned)irq_nr >= max_irqs)
                 return;
 
-	spin_lock_irqsave(&pmac_pic_lock, flags);
+  	spin_lock_irqsave(&pmac_pic_lock, flags);
+	if (__test_and_clear_bit(irq_nr, ppc_lost_interrupts))
+                atomic_dec(&ppc_n_lost_interrupts);
+        out_le32(&pmac_irq_hw[i]->ack, bit);
+        (void)in_le32(&pmac_irq_hw[i]->ack);
+	spin_unlock_irqrestore(&pmac_pic_lock, flags);
+}
+
+static void __pmac_set_irq_mask(unsigned int irq_nr, int nokicklost)
+{
+        unsigned long bit = 1UL << (irq_nr & 0x1f);
+        int i = irq_nr >> 5;
+
+        if ((unsigned)irq_nr >= max_irqs)
+                return;
+
         /* enable unmasked interrupts */
         out_le32(&pmac_irq_hw[i]->enable, ppc_cached_irq_mask[i]);
 
@@ -136,8 +152,7 @@ static void pmac_set_irq_mask(unsigned i
          * the bit in the flag register or request another interrupt.
          */
         if (bit & ppc_cached_irq_mask[i] & in_le32(&pmac_irq_hw[i]->level))
-		__set_lost((ulong)irq_nr, nokicklost);
-	spin_unlock_irqrestore(&pmac_pic_lock, flags);
+		__pmac_retrigger(irq_nr);
 }
 
 /* When an irq gets requested for the first client, if it's an
@@ -145,62 +160,67 @@ static void pmac_set_irq_mask(unsigned i
  */
 static unsigned int pmac_startup_irq(unsigned int irq_nr)
 {
+	unsigned long flags;
         unsigned long bit = 1UL << (irq_nr & 0x1f);
         int i = irq_nr >> 5;
 
+  	spin_lock_irqsave(&pmac_pic_lock, flags);
 	if ((irq_desc[irq_nr].status & IRQ_LEVEL) == 0)
 		out_le32(&pmac_irq_hw[i]->ack, bit);
-        set_bit(irq_nr, ppc_cached_irq_mask);
-        pmac_set_irq_mask(irq_nr, 0);
+        __set_bit(irq_nr, ppc_cached_irq_mask);
+        __pmac_set_irq_mask(irq_nr, 0);
+  	spin_unlock_irqrestore(&pmac_pic_lock, flags);
 
 	return 0;
 }
 
 static void pmac_mask_irq(unsigned int irq_nr)
 {
-        clear_bit(irq_nr, ppc_cached_irq_mask);
-        pmac_set_irq_mask(irq_nr, 0);
-        mb();
+	unsigned long flags;
+
+  	spin_lock_irqsave(&pmac_pic_lock, flags);
+        __clear_bit(irq_nr, ppc_cached_irq_mask);
+        __pmac_set_irq_mask(irq_nr, 0);
+  	spin_unlock_irqrestore(&pmac_pic_lock, flags);
 }
 
 static void pmac_unmask_irq(unsigned int irq_nr)
 {
-        set_bit(irq_nr, ppc_cached_irq_mask);
-        pmac_set_irq_mask(irq_nr, 0);
+	unsigned long flags;
+
+	spin_lock_irqsave(&pmac_pic_lock, flags);
+	__set_bit(irq_nr, ppc_cached_irq_mask);
+        __pmac_set_irq_mask(irq_nr, 0);
+  	spin_unlock_irqrestore(&pmac_pic_lock, flags);
 }
 
-static void pmac_end_irq(unsigned int irq_nr)
+static int pmac_retrigger(unsigned int irq_nr)
 {
-	if (!(irq_desc[irq_nr].status & (IRQ_DISABLED|IRQ_INPROGRESS))
-	    && irq_desc[irq_nr].action) {
-        	set_bit(irq_nr, ppc_cached_irq_mask);
-	        pmac_set_irq_mask(irq_nr, 1);
-	}
-}
+	unsigned long flags;
 
+  	spin_lock_irqsave(&pmac_pic_lock, flags);
+	__pmac_retrigger(irq_nr);
+  	spin_unlock_irqrestore(&pmac_pic_lock, flags);
+	return 1;
+}
 
-struct hw_interrupt_type pmac_pic = {
+static struct irq_chip pmac_pic = {
 	.typename	= " PMAC-PIC ",
 	.startup	= pmac_startup_irq,
-	.enable		= pmac_unmask_irq,
-	.disable	= pmac_mask_irq,
-	.ack		= pmac_mask_and_ack_irq,
-	.end		= pmac_end_irq,
-};
-
-struct hw_interrupt_type gatwick_pic = {
-	.typename	= " GATWICK  ",
-	.startup	= pmac_startup_irq,
-	.enable		= pmac_unmask_irq,
-	.disable	= pmac_mask_irq,
-	.ack		= pmac_mask_and_ack_irq,
-	.end		= pmac_end_irq,
+	.mask		= pmac_mask_irq,
+	.ack		= pmac_ack_irq,
+	.mask_ack	= pmac_mask_and_ack_irq,
+	.unmask		= pmac_unmask_irq,
+	.retrigger	= pmac_retrigger,
 };
 
 static irqreturn_t gatwick_action(int cpl, void *dev_id, struct pt_regs *regs)
 {
+	unsigned long flags;
 	int irq, bits;
+	int rc = IRQ_NONE;
 
+  	spin_lock_irqsave(&pmac_pic_lock, flags);
 	for (irq = max_irqs; (irq -= 32) >= max_real_irqs; ) {
 		int i = irq >> 5;
 		bits = in_le32(&pmac_irq_hw[i]->event) | ppc_lost_interrupts[i];
@@ -210,17 +230,20 @@ static irqreturn_t gatwick_action(int cp
 		if (bits == 0)
 			continue;
 		irq += __ilog2(bits);
+		spin_unlock_irqrestore(&pmac_pic_lock, flags);
 		__do_IRQ(irq, regs);
-		return IRQ_HANDLED;
+		spin_lock_irqsave(&pmac_pic_lock, flags);
+		rc = IRQ_HANDLED;
 	}
-	printk("gatwick irq not from gatwick pic\n");
-	return IRQ_NONE;
+  	spin_unlock_irqrestore(&pmac_pic_lock, flags);
+	return rc;
 }
 
 static int pmac_get_irq(struct pt_regs *regs)
 {
 	int irq;
 	unsigned long bits = 0;
+	unsigned long flags;
 
 #ifdef CONFIG_SMP
 	void psurge_smp_message_recv(struct pt_regs *);
@@ -231,6 +254,7 @@ static int pmac_get_irq(struct pt_regs *
 		return -2;	/* ignore, already handled */
         }
 #endif /* CONFIG_SMP */
+  	spin_lock_irqsave(&pmac_pic_lock, flags);
 	for (irq = max_real_irqs; (irq -= 32) >= 0; ) {
 		int i = irq >> 5;
 		bits = in_le32(&pmac_irq_hw[i]->event) | ppc_lost_interrupts[i];
@@ -242,6 +266,7 @@ static int pmac_get_irq(struct pt_regs *
 		irq += __ilog2(bits);
 		break;
 	}
+  	spin_unlock_irqrestore(&pmac_pic_lock, flags);
 
 	return irq;
 }
@@ -390,7 +415,6 @@ static struct irqaction gatwick_cascade_
 static void __init pmac_pic_probe_oldstyle(void)
 {
         int i;
-	int irq_cascade = -1;
         struct device_node *master = NULL;
 	struct device_node *slave = NULL;
 	u8 __iomem *addr;
@@ -444,9 +468,16 @@ static void __init pmac_pic_probe_oldsty
 	}
 	BUG_ON(master == NULL);
 
-	/* Set the handler for the main PIC */
-	for ( i = 0; i < max_real_irqs ; i++ )
-		irq_desc[i].chip = &pmac_pic;
+	/* Mark level interrupts and set handlers */
+	for (i = 0; i < max_irqs; i++) {
+		int level = !!(level_mask[i >> 5] & (1UL << (i & 0x1f)));
+		if (level)
+			irq_desc[i].status |= IRQ_LEVEL;
+		else
+			irq_desc[i].status |= IRQ_DELAYED_DISABLE;
+		set_irq_chip_and_handler(i, &pmac_pic, level ?
+					 handle_level_irq : handle_edge_irq);
+	}
 
 	/* Get addresses of first controller if we have a node for it */
 	BUG_ON(of_address_to_resource(master, 0, &r));
@@ -473,29 +504,22 @@ static void __init pmac_pic_probe_oldsty
 			pmac_irq_hw[i++] =
 				(volatile struct pmac_irq_hw __iomem *)
 				(addr + 0x10);
-		irq_cascade = slave->intrs[0].line;
+		pmac_irq_cascade = slave->intrs[0].line;
 
 		printk(KERN_INFO "irq: Found slave Apple PIC %s for %d irqs"
 		       " cascade: %d\n", slave->full_name,
-		       max_irqs - max_real_irqs, irq_cascade);
+		       max_irqs - max_real_irqs, pmac_irq_cascade);
 	}
 	of_node_put(slave);
 
-	/* disable all interrupts in all controllers */
+	/* Disable all interrupts in all controllers */
 	for (i = 0; i * 32 < max_irqs; ++i)
 		out_le32(&pmac_irq_hw[i]->enable, 0);
 
-	/* mark level interrupts */
-	for (i = 0; i < max_irqs; i++)
-		if (level_mask[i >> 5] & (1UL << (i & 0x1f)))
-			irq_desc[i].status = IRQ_LEVEL;
-
-	/* Setup handlers for secondary controller and hook cascade irq*/
-	if (slave) {
-		for ( i = max_real_irqs ; i < max_irqs ; i++ )
-			irq_desc[i].chip = &gatwick_pic;
-		setup_irq(irq_cascade, &gatwick_cascade_action);
-	}
+	/* Hookup cascade irq */
+	if (slave)
+		setup_irq(pmac_irq_cascade, &gatwick_cascade_action);
+
 	printk(KERN_INFO "irq: System has %d possible interrupts\n", max_irqs);
 #ifdef CONFIG_XMON
 	setup_irq(20, &xmon_action);
Index: linux-work/include/asm-powerpc/irq.h
===================================================================
--- linux-work.orig/include/asm-powerpc/irq.h	2006-06-06 14:45:10.000000000 +1000
+++ linux-work/include/asm-powerpc/irq.h	2006-06-06 16:20:08.000000000 +1000
@@ -429,9 +429,12 @@ extern u64 ppc64_interrupt_controller;
 
 #endif
 
+#ifndef CONFIG_PPC_MERGE
 #define NR_MASK_WORDS	((NR_IRQS + 31) / 32)
 /* pedantic: these are long because they are used with set_bit --RR */
 extern unsigned long ppc_cached_irq_mask[NR_MASK_WORDS];
+#endif
+
 extern atomic_t ppc_n_lost_interrupts;
 
 #define virt_irq_create_mapping(x)	(x)
