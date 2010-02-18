Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
	by ozlabs.org (Postfix) with SMTP id 0DAA8B7E5A
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Feb 2010 00:57:28 +1100 (EST)
Date: Thu, 18 Feb 2010 16:57:27 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] powerpc/86xx: Convert gef_pic_lock to raw_spinlock
Message-ID: <20100218135727.GA18924@oksana.dev.rtsoft.ru>
References: <20100218121904.620984825@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20100218121904.620984825@linutronix.de>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Interrupt controllers' hooks are executed in the atomic context, so
they are not permitted to sleep (with RT kernels non-raw spinlocks are
sleepable). So, gef_pic_lock has to be a real (non-sleepable) spinlock.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/platforms/86xx/gef_pic.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/gef_pic.c b/arch/powerpc/platforms/86xx/gef_pic.c
index 0110a87..7ad9c0d 100644
--- a/arch/powerpc/platforms/86xx/gef_pic.c
+++ b/arch/powerpc/platforms/86xx/gef_pic.c
@@ -49,7 +49,7 @@
 #define gef_irq_to_hw(virq)    ((unsigned int)irq_map[virq].hwirq)
 
 
-static DEFINE_SPINLOCK(gef_pic_lock);
+static DEFINE_RAW_SPINLOCK(gef_pic_lock);
 
 static void __iomem *gef_pic_irq_reg_base;
 static struct irq_host *gef_pic_irq_host;
@@ -118,11 +118,11 @@ static void gef_pic_mask(unsigned int virq)
 
 	hwirq = gef_irq_to_hw(virq);
 
-	spin_lock_irqsave(&gef_pic_lock, flags);
+	raw_spin_lock_irqsave(&gef_pic_lock, flags);
 	mask = in_be32(gef_pic_irq_reg_base + GEF_PIC_INTR_MASK(0));
 	mask &= ~(1 << hwirq);
 	out_be32(gef_pic_irq_reg_base + GEF_PIC_INTR_MASK(0), mask);
-	spin_unlock_irqrestore(&gef_pic_lock, flags);
+	raw_spin_unlock_irqrestore(&gef_pic_lock, flags);
 }
 
 static void gef_pic_mask_ack(unsigned int virq)
@@ -141,11 +141,11 @@ static void gef_pic_unmask(unsigned int virq)
 
 	hwirq = gef_irq_to_hw(virq);
 
-	spin_lock_irqsave(&gef_pic_lock, flags);
+	raw_spin_lock_irqsave(&gef_pic_lock, flags);
 	mask = in_be32(gef_pic_irq_reg_base + GEF_PIC_INTR_MASK(0));
 	mask |= (1 << hwirq);
 	out_be32(gef_pic_irq_reg_base + GEF_PIC_INTR_MASK(0), mask);
-	spin_unlock_irqrestore(&gef_pic_lock, flags);
+	raw_spin_unlock_irqrestore(&gef_pic_lock, flags);
 }
 
 static struct irq_chip gef_pic_chip = {
@@ -199,7 +199,7 @@ void __init gef_pic_init(struct device_node *np)
 	/* Map the devices registers into memory */
 	gef_pic_irq_reg_base = of_iomap(np, 0);
 
-	spin_lock_irqsave(&gef_pic_lock, flags);
+	raw_spin_lock_irqsave(&gef_pic_lock, flags);
 
 	/* Initialise everything as masked. */
 	out_be32(gef_pic_irq_reg_base + GEF_PIC_CPU0_INTR_MASK, 0);
@@ -208,7 +208,7 @@ void __init gef_pic_init(struct device_node *np)
 	out_be32(gef_pic_irq_reg_base + GEF_PIC_CPU0_MCP_MASK, 0);
 	out_be32(gef_pic_irq_reg_base + GEF_PIC_CPU1_MCP_MASK, 0);
 
-	spin_unlock_irqrestore(&gef_pic_lock, flags);
+	raw_spin_unlock_irqrestore(&gef_pic_lock, flags);
 
 	/* Map controller */
 	gef_pic_cascade_irq = irq_of_parse_and_map(np, 0);
-- 
1.6.5.7
