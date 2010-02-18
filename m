Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
	by ozlabs.org (Postfix) with SMTP id CED3AB7D06
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Feb 2010 00:45:13 +1100 (EST)
Date: Thu, 18 Feb 2010 16:45:12 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] powerpc/85xx: Convert socrates_fpga_pic_lock to raw_spinlock
Message-ID: <20100218134512.GB5331@oksana.dev.rtsoft.ru>
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
sleepable). So, socrates_fpga_pic_lock has to be a real (non-sleepable)
spinlock.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

On Thu, Feb 18, 2010 at 12:22:18PM -0000, Thomas Gleixner wrote:
> Ben,
> 
> the following patch series is from preempt-rt. It converts the locks
> which need to be real spinlocks in -rt to raw_spinlocks.
> 
> There is no behaviourial change for !RT kernels because spinlocks and
> raw_spinlocks are the same on !RT. So for mainline this is a pure
> annotation while having it in mainline takes the burden of keeping up
> with the code changes from the RT patch set.
> 
> Please consider to merge into .34.

Oh, and I guess the same for the socrates fpga pic...

 arch/powerpc/platforms/85xx/socrates_fpga_pic.c |   34 +++++++++++-----------
 1 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/socrates_fpga_pic.c b/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
index e5da5f6..678560a 100644
--- a/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
+++ b/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
@@ -50,7 +50,7 @@ static struct socrates_fpga_irq_info fpga_irqs[SOCRATES_FPGA_NUM_IRQS] = {
 
 #define socrates_fpga_irq_to_hw(virq)    ((unsigned int)irq_map[virq].hwirq)
 
-static DEFINE_SPINLOCK(socrates_fpga_pic_lock);
+static DEFINE_RAW_SPINLOCK(socrates_fpga_pic_lock);
 
 static void __iomem *socrates_fpga_pic_iobase;
 static struct irq_host *socrates_fpga_pic_irq_host;
@@ -80,9 +80,9 @@ static inline unsigned int socrates_fpga_pic_get_irq(unsigned int irq)
 	if (i == 3)
 		return NO_IRQ;
 
-	spin_lock_irqsave(&socrates_fpga_pic_lock, flags);
+	raw_spin_lock_irqsave(&socrates_fpga_pic_lock, flags);
 	cause = socrates_fpga_pic_read(FPGA_PIC_IRQMASK(i));
-	spin_unlock_irqrestore(&socrates_fpga_pic_lock, flags);
+	raw_spin_unlock_irqrestore(&socrates_fpga_pic_lock, flags);
 	for (i = SOCRATES_FPGA_NUM_IRQS - 1; i >= 0; i--) {
 		if (cause >> (i + 16))
 			break;
@@ -116,12 +116,12 @@ static void socrates_fpga_pic_ack(unsigned int virq)
 	hwirq = socrates_fpga_irq_to_hw(virq);
 
 	irq_line = fpga_irqs[hwirq].irq_line;
-	spin_lock_irqsave(&socrates_fpga_pic_lock, flags);
+	raw_spin_lock_irqsave(&socrates_fpga_pic_lock, flags);
 	mask = socrates_fpga_pic_read(FPGA_PIC_IRQMASK(irq_line))
 		& SOCRATES_FPGA_IRQ_MASK;
 	mask |= (1 << (hwirq + 16));
 	socrates_fpga_pic_write(FPGA_PIC_IRQMASK(irq_line), mask);
-	spin_unlock_irqrestore(&socrates_fpga_pic_lock, flags);
+	raw_spin_unlock_irqrestore(&socrates_fpga_pic_lock, flags);
 }
 
 static void socrates_fpga_pic_mask(unsigned int virq)
@@ -134,12 +134,12 @@ static void socrates_fpga_pic_mask(unsigned int virq)
 	hwirq = socrates_fpga_irq_to_hw(virq);
 
 	irq_line = fpga_irqs[hwirq].irq_line;
-	spin_lock_irqsave(&socrates_fpga_pic_lock, flags);
+	raw_spin_lock_irqsave(&socrates_fpga_pic_lock, flags);
 	mask = socrates_fpga_pic_read(FPGA_PIC_IRQMASK(irq_line))
 		& SOCRATES_FPGA_IRQ_MASK;
 	mask &= ~(1 << hwirq);
 	socrates_fpga_pic_write(FPGA_PIC_IRQMASK(irq_line), mask);
-	spin_unlock_irqrestore(&socrates_fpga_pic_lock, flags);
+	raw_spin_unlock_irqrestore(&socrates_fpga_pic_lock, flags);
 }
 
 static void socrates_fpga_pic_mask_ack(unsigned int virq)
@@ -152,13 +152,13 @@ static void socrates_fpga_pic_mask_ack(unsigned int virq)
 	hwirq = socrates_fpga_irq_to_hw(virq);
 
 	irq_line = fpga_irqs[hwirq].irq_line;
-	spin_lock_irqsave(&socrates_fpga_pic_lock, flags);
+	raw_spin_lock_irqsave(&socrates_fpga_pic_lock, flags);
 	mask = socrates_fpga_pic_read(FPGA_PIC_IRQMASK(irq_line))
 		& SOCRATES_FPGA_IRQ_MASK;
 	mask &= ~(1 << hwirq);
 	mask |= (1 << (hwirq + 16));
 	socrates_fpga_pic_write(FPGA_PIC_IRQMASK(irq_line), mask);
-	spin_unlock_irqrestore(&socrates_fpga_pic_lock, flags);
+	raw_spin_unlock_irqrestore(&socrates_fpga_pic_lock, flags);
 }
 
 static void socrates_fpga_pic_unmask(unsigned int virq)
@@ -171,12 +171,12 @@ static void socrates_fpga_pic_unmask(unsigned int virq)
 	hwirq = socrates_fpga_irq_to_hw(virq);
 
 	irq_line = fpga_irqs[hwirq].irq_line;
-	spin_lock_irqsave(&socrates_fpga_pic_lock, flags);
+	raw_spin_lock_irqsave(&socrates_fpga_pic_lock, flags);
 	mask = socrates_fpga_pic_read(FPGA_PIC_IRQMASK(irq_line))
 		& SOCRATES_FPGA_IRQ_MASK;
 	mask |= (1 << hwirq);
 	socrates_fpga_pic_write(FPGA_PIC_IRQMASK(irq_line), mask);
-	spin_unlock_irqrestore(&socrates_fpga_pic_lock, flags);
+	raw_spin_unlock_irqrestore(&socrates_fpga_pic_lock, flags);
 }
 
 static void socrates_fpga_pic_eoi(unsigned int virq)
@@ -189,12 +189,12 @@ static void socrates_fpga_pic_eoi(unsigned int virq)
 	hwirq = socrates_fpga_irq_to_hw(virq);
 
 	irq_line = fpga_irqs[hwirq].irq_line;
-	spin_lock_irqsave(&socrates_fpga_pic_lock, flags);
+	raw_spin_lock_irqsave(&socrates_fpga_pic_lock, flags);
 	mask = socrates_fpga_pic_read(FPGA_PIC_IRQMASK(irq_line))
 		& SOCRATES_FPGA_IRQ_MASK;
 	mask |= (1 << (hwirq + 16));
 	socrates_fpga_pic_write(FPGA_PIC_IRQMASK(irq_line), mask);
-	spin_unlock_irqrestore(&socrates_fpga_pic_lock, flags);
+	raw_spin_unlock_irqrestore(&socrates_fpga_pic_lock, flags);
 }
 
 static int socrates_fpga_pic_set_type(unsigned int virq,
@@ -220,14 +220,14 @@ static int socrates_fpga_pic_set_type(unsigned int virq,
 	default:
 		return -EINVAL;
 	}
-	spin_lock_irqsave(&socrates_fpga_pic_lock, flags);
+	raw_spin_lock_irqsave(&socrates_fpga_pic_lock, flags);
 	mask = socrates_fpga_pic_read(FPGA_PIC_IRQCFG);
 	if (polarity)
 		mask |= (1 << hwirq);
 	else
 		mask &= ~(1 << hwirq);
 	socrates_fpga_pic_write(FPGA_PIC_IRQCFG, mask);
-	spin_unlock_irqrestore(&socrates_fpga_pic_lock, flags);
+	raw_spin_unlock_irqrestore(&socrates_fpga_pic_lock, flags);
 	return 0;
 }
 
@@ -314,14 +314,14 @@ void socrates_fpga_pic_init(struct device_node *pic)
 
 	socrates_fpga_pic_iobase = of_iomap(pic, 0);
 
-	spin_lock_irqsave(&socrates_fpga_pic_lock, flags);
+	raw_spin_lock_irqsave(&socrates_fpga_pic_lock, flags);
 	socrates_fpga_pic_write(FPGA_PIC_IRQMASK(0),
 			SOCRATES_FPGA_IRQ_MASK << 16);
 	socrates_fpga_pic_write(FPGA_PIC_IRQMASK(1),
 			SOCRATES_FPGA_IRQ_MASK << 16);
 	socrates_fpga_pic_write(FPGA_PIC_IRQMASK(2),
 			SOCRATES_FPGA_IRQ_MASK << 16);
-	spin_unlock_irqrestore(&socrates_fpga_pic_lock, flags);
+	raw_spin_unlock_irqrestore(&socrates_fpga_pic_lock, flags);
 
 	pr_info("FPGA PIC: Setting up Socrates FPGA PIC\n");
 }
-- 
1.6.5.7
