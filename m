Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 03 Jun 2009 14:53:37 +1000
Subject: [PATCH] powerpc/mm: Fix a AB->BA deadlock scenario with nohash MMU
	context lock
Message-Id: <20090603045351.96BEEDDDF7@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The MMU context_lock can be taken from switch_mm() while the
rq->lock is held. The rq->lock can also be taken from interrupts,
thus if we get interrupted in destroy_context() with the context
lock held and that interrupt tries to take the rq->lock, there's
a possible deadlock scenario with another CPU having the rq->lock
and calling switch_mm() which takes our context lock.

The fix is to always ensure interrupts are off when taking our
context lock. The switch_mm() path is already good so this fixes
the destroy_context() path.

While at it, turn the context lock into a new style spinlock.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---


 arch/powerpc/mm/mmu_context_nohash.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- linux-work.orig/arch/powerpc/mm/mmu_context_nohash.c	2009-06-03 14:14:47.000000000 +1000
+++ linux-work/arch/powerpc/mm/mmu_context_nohash.c	2009-06-03 14:25:30.000000000 +1000
@@ -46,7 +46,7 @@ static unsigned int next_context, nr_fre
 static unsigned long *context_map;
 static unsigned long *stale_map[NR_CPUS];
 static struct mm_struct **context_mm;
-static spinlock_t context_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(context_lock);
 
 #define CTX_MAP_SIZE	\
 	(sizeof(unsigned long) * (last_context / BITS_PER_LONG + 1))
@@ -272,6 +272,7 @@ int init_new_context(struct task_struct 
  */
 void destroy_context(struct mm_struct *mm)
 {
+	unsigned long flags;
 	unsigned int id;
 
 	if (mm->context.id == MMU_NO_CONTEXT)
@@ -279,7 +280,7 @@ void destroy_context(struct mm_struct *m
 
 	WARN_ON(mm->context.active != 0);
 
-	spin_lock(&context_lock);
+	spin_lock_irqsave(&context_lock, flags);
 	id = mm->context.id;
 	if (id != MMU_NO_CONTEXT) {
 		__clear_bit(id, context_map);
@@ -290,7 +291,7 @@ void destroy_context(struct mm_struct *m
 #endif
 		nr_free_contexts++;
 	}
-	spin_unlock(&context_lock);
+	spin_unlock_irqrestore(&context_lock, flags);
 }
 
 #ifdef CONFIG_SMP
