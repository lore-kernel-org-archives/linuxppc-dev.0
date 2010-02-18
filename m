Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EA2C7B811B
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2010 23:31:59 +1100 (EST)
Message-Id: <20100218122000.431550876@linutronix.de>
Date: Thu, 18 Feb 2010 12:22:52 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: [patch 08/15] powerpc: Convert beatic_irq_mask_lock to raw_spinlock
References: <20100218121904.620984825@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

beatic_irq_mask_lock needs to be a real spinlock in RT. Convert it to
raw_spinlock.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/platforms/cell/beat_interrupt.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

Index: linux-2.6-tip/arch/powerpc/platforms/cell/beat_interrupt.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/cell/beat_interrupt.c
+++ linux-2.6-tip/arch/powerpc/platforms/cell/beat_interrupt.c
@@ -30,7 +30,7 @@
 #include "beat_wrapper.h"
 
 #define	MAX_IRQS	NR_IRQS
-static DEFINE_SPINLOCK(beatic_irq_mask_lock);
+static DEFINE_RAW_SPINLOCK(beatic_irq_mask_lock);
 static uint64_t	beatic_irq_mask_enable[(MAX_IRQS+255)/64];
 static uint64_t	beatic_irq_mask_ack[(MAX_IRQS+255)/64];
 
@@ -65,30 +65,30 @@ static void beatic_mask_irq(unsigned int
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&beatic_irq_mask_lock, flags);
+	raw_spin_lock_irqsave(&beatic_irq_mask_lock, flags);
 	beatic_irq_mask_enable[irq_plug/64] &= ~(1UL << (63 - (irq_plug%64)));
 	beatic_update_irq_mask(irq_plug);
-	spin_unlock_irqrestore(&beatic_irq_mask_lock, flags);
+	raw_spin_unlock_irqrestore(&beatic_irq_mask_lock, flags);
 }
 
 static void beatic_unmask_irq(unsigned int irq_plug)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&beatic_irq_mask_lock, flags);
+	raw_spin_lock_irqsave(&beatic_irq_mask_lock, flags);
 	beatic_irq_mask_enable[irq_plug/64] |= 1UL << (63 - (irq_plug%64));
 	beatic_update_irq_mask(irq_plug);
-	spin_unlock_irqrestore(&beatic_irq_mask_lock, flags);
+	raw_spin_unlock_irqrestore(&beatic_irq_mask_lock, flags);
 }
 
 static void beatic_ack_irq(unsigned int irq_plug)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&beatic_irq_mask_lock, flags);
+	raw_spin_lock_irqsave(&beatic_irq_mask_lock, flags);
 	beatic_irq_mask_ack[irq_plug/64] &= ~(1UL << (63 - (irq_plug%64)));
 	beatic_update_irq_mask(irq_plug);
-	spin_unlock_irqrestore(&beatic_irq_mask_lock, flags);
+	raw_spin_unlock_irqrestore(&beatic_irq_mask_lock, flags);
 }
 
 static void beatic_end_irq(unsigned int irq_plug)
@@ -103,10 +103,10 @@ static void beatic_end_irq(unsigned int 
 
 		printk(KERN_ERR "IRQ over-downcounted, plug %d\n", irq_plug);
 	}
-	spin_lock_irqsave(&beatic_irq_mask_lock, flags);
+	raw_spin_lock_irqsave(&beatic_irq_mask_lock, flags);
 	beatic_irq_mask_ack[irq_plug/64] |= 1UL << (63 - (irq_plug%64));
 	beatic_update_irq_mask(irq_plug);
-	spin_unlock_irqrestore(&beatic_irq_mask_lock, flags);
+	raw_spin_unlock_irqrestore(&beatic_irq_mask_lock, flags);
 }
 
 static struct irq_chip beatic_pic = {
