Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
	by ozlabs.org (Postfix) with SMTP id 5DE5AB7E77
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Feb 2010 00:43:14 +1100 (EST)
Date: Thu, 18 Feb 2010 16:43:12 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] powerpc/qe: Convert qe_ic_lock to raw_spinlock
Message-ID: <20100218134312.GA5331@oksana.dev.rtsoft.ru>
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
sleepable). So, qe_ic_lock has to be a real (non-sleepable) spinlock.

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

If nothing has changed in -rt, then qe_ic should be in the same boat.

 arch/powerpc/sysdev/qe_lib/qe_ic.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.c b/arch/powerpc/sysdev/qe_lib/qe_ic.c
index 2acc928..9c90a34 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_ic.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_ic.c
@@ -33,7 +33,7 @@
 
 #include "qe_ic.h"
 
-static DEFINE_SPINLOCK(qe_ic_lock);
+static DEFINE_RAW_SPINLOCK(qe_ic_lock);
 
 static struct qe_ic_info qe_ic_info[] = {
 	[1] = {
@@ -201,13 +201,13 @@ static void qe_ic_unmask_irq(unsigned int virq)
 	unsigned long flags;
 	u32 temp;
 
-	spin_lock_irqsave(&qe_ic_lock, flags);
+	raw_spin_lock_irqsave(&qe_ic_lock, flags);
 
 	temp = qe_ic_read(qe_ic->regs, qe_ic_info[src].mask_reg);
 	qe_ic_write(qe_ic->regs, qe_ic_info[src].mask_reg,
 		    temp | qe_ic_info[src].mask);
 
-	spin_unlock_irqrestore(&qe_ic_lock, flags);
+	raw_spin_unlock_irqrestore(&qe_ic_lock, flags);
 }
 
 static void qe_ic_mask_irq(unsigned int virq)
@@ -217,7 +217,7 @@ static void qe_ic_mask_irq(unsigned int virq)
 	unsigned long flags;
 	u32 temp;
 
-	spin_lock_irqsave(&qe_ic_lock, flags);
+	raw_spin_lock_irqsave(&qe_ic_lock, flags);
 
 	temp = qe_ic_read(qe_ic->regs, qe_ic_info[src].mask_reg);
 	qe_ic_write(qe_ic->regs, qe_ic_info[src].mask_reg,
@@ -233,7 +233,7 @@ static void qe_ic_mask_irq(unsigned int virq)
 	 */
 	mb();
 
-	spin_unlock_irqrestore(&qe_ic_lock, flags);
+	raw_spin_unlock_irqrestore(&qe_ic_lock, flags);
 }
 
 static struct irq_chip qe_ic_irq_chip = {
-- 
1.6.5.7
