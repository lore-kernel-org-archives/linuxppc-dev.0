From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Tue, 11 Mar 2003 12:46:14 -0700
To: linuxppc-dev@lists.linuxppc.org
Subject: gt64260_mask_irq bug fix
Message-ID: <20030311194614.GA4005@rover.farnsworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This patch two fixes.
First, it removes the spinlock calls from gt64260_unmask_irq and
gt64260_mask_irq.  I was the one who added these in a misguided
attempt to fix the problem addressed by the second fix.

Second, after the irq is masked, we wait for the gt64260's internal
pipeline to drain before returning.  Apparently this bit someone
on irq 36, but it is necessary for all irqs.

-Dale

Patch vs. linuxppc_2_4_devel

===== gt64260_pic.c 1.10 vs edited =====
--- 1.10/arch/ppc/kernel/gt64260_pic.c	Fri Feb 28 10:31:00 2003
+++ edited/gt64260_pic.c	Tue Mar 11 12:28:10 2003
@@ -283,10 +283,7 @@
 void
 gt64260_unmask_irq(unsigned int irq)
 {
-    	unsigned long flags;
-
 	irq -= gt64260_irq_base;
-	spin_lock_irqsave(&gt64260_lock, flags);

 	if (irq > 31) {
 		if (irq > 63) {
@@ -304,7 +301,6 @@
 		set_bit(irq, &ppc_cached_irq_mask[0]);
 		gt_write(GT64260_IC_CPU_INTR_MASK_LO, ppc_cached_irq_mask[0]);
 	}
-	spin_unlock_irqrestore(&gt64260_lock, flags);
 }


@@ -325,10 +321,8 @@
 static void
 gt64260_mask_irq(unsigned int irq)
 {
-    	unsigned long flags;
-
 	irq -= gt64260_irq_base;
-	spin_lock_irqsave(&gt64260_lock, flags);
+
 	if (irq > 31) {
 		if (irq > 63) {
 			/* mask GPP irq */
@@ -345,11 +339,12 @@
 		clear_bit(irq, &ppc_cached_irq_mask[0]);
 		gt_write(GT64260_IC_CPU_INTR_MASK_LO, ppc_cached_irq_mask[0]);
 	}
-	spin_unlock_irqrestore(&gt64260_lock, flags);
-
-	if (irq == 36) { /* Seems necessary for SDMA interrupts */
-		udelay(1);
-	}
+	/*
+	 * Need to drain the gt64260 pipeline to ensure that the irq has
+	 * been masked before returning.  Reading any gt64260 register
+	 * is sufficient.
+	 */
+	(void) gt_read(GT64260_GPP_INTR_MASK);
 }


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
