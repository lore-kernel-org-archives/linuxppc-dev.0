Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 89C8DB7F81
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2010 23:31:55 +1100 (EST)
Message-Id: <20100218122000.301814237@linutronix.de>
Date: Thu, 18 Feb 2010 12:22:39 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: [patch 05/15] powerpc: Convert context_lock to raw_spinlock
References: <20100218121904.620984825@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

context_lock needs to be a real spinlock in RT. Convert it to
raw_spinlock.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/mm/mmu_context_nohash.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

Index: linux-2.6-tip/arch/powerpc/mm/mmu_context_nohash.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/mm/mmu_context_nohash.c
+++ linux-2.6-tip/arch/powerpc/mm/mmu_context_nohash.c
@@ -56,7 +56,7 @@ static unsigned int next_context, nr_fre
 static unsigned long *context_map;
 static unsigned long *stale_map[NR_CPUS];
 static struct mm_struct **context_mm;
-static DEFINE_SPINLOCK(context_lock);
+static DEFINE_RAW_SPINLOCK(context_lock);
 
 #define CTX_MAP_SIZE	\
 	(sizeof(unsigned long) * (last_context / BITS_PER_LONG + 1))
@@ -121,9 +121,9 @@ static unsigned int steal_context_smp(un
 	/* This will happen if you have more CPUs than available contexts,
 	 * all we can do here is wait a bit and try again
 	 */
-	spin_unlock(&context_lock);
+	raw_spin_unlock(&context_lock);
 	cpu_relax();
-	spin_lock(&context_lock);
+	raw_spin_lock(&context_lock);
 
 	/* This will cause the caller to try again */
 	return MMU_NO_CONTEXT;
@@ -194,7 +194,7 @@ void switch_mmu_context(struct mm_struct
 	unsigned long *map;
 
 	/* No lockless fast path .. yet */
-	spin_lock(&context_lock);
+	raw_spin_lock(&context_lock);
 
 	pr_hard("[%d] activating context for mm @%p, active=%d, id=%d",
 		cpu, next, next->context.active, next->context.id);
@@ -278,7 +278,7 @@ void switch_mmu_context(struct mm_struct
 	/* Flick the MMU and release lock */
 	pr_hardcont(" -> %d\n", id);
 	set_context(id, next->pgd);
-	spin_unlock(&context_lock);
+	raw_spin_unlock(&context_lock);
 }
 
 /*
@@ -307,7 +307,7 @@ void destroy_context(struct mm_struct *m
 
 	WARN_ON(mm->context.active != 0);
 
-	spin_lock_irqsave(&context_lock, flags);
+	raw_spin_lock_irqsave(&context_lock, flags);
 	id = mm->context.id;
 	if (id != MMU_NO_CONTEXT) {
 		__clear_bit(id, context_map);
@@ -318,7 +318,7 @@ void destroy_context(struct mm_struct *m
 		context_mm[id] = NULL;
 		nr_free_contexts++;
 	}
-	spin_unlock_irqrestore(&context_lock, flags);
+	raw_spin_unlock_irqrestore(&context_lock, flags);
 }
 
 #ifdef CONFIG_SMP
