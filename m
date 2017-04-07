Return-Path: <srs0=zfgn=3p=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzlVN4y8PzDqH7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 13:31:24 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vzlVN4Ngyz8sx8
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 13:31:24 +1000 (AEST)
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vzlVM3FyXz9s1h
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Apr 2017 13:31:23 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id g2so12256293pge.2
 for <linuxppc-dev@ozlabs.org>; Thu, 06 Apr 2017 20:31:23 -0700 (PDT)
Date: Fri, 7 Apr 2017 13:31:01 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon
 <will.deacon@arm.com>, David Miller <davem@davemloft.net>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Anton Blanchard
 <anton@samba.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [RFC][PATCH] spin loop arch primitives for busy waiting
Message-ID: <20170407133101.3a620064@roar.ozlabs.ibm.com>
In-Reply-To: <CA+55aFzvRiVx3dvXaQUpYwoHq0DnrV9RPXWnqSeb9b80DFosHA@mail.gmail.com>
References: <20170404095001.664718b8@roar.ozlabs.ibm.com>
 <CA+55aFzdUMZHzXtn9PyhJg7GjYNQ5fy6=LzBNJx==Ab=U=YYjw@mail.gmail.com>
 <20170404130233.1f45115b@roar.ozlabs.ibm.com>
 <20170405.070157.871721909352646302.davem@davemloft.net>
 <20170406105958.196c6977@roar.ozlabs.ibm.com>
 <20170406141352.GF18204@arm.com>
 <CA+55aFwgNhF=QUKMKLc9TfQ=cgF2mvMEVx9hJms4wQqCsib9Rw@mail.gmail.com>
 <20170406163651.hj7apd63uxupgdb3@hirez.programming.kicks-ass.net>
 <CA+55aFzTn9e=F68SOtEvvZLdT6zCj9+gLc-OS7qhDKdM7zaasA@mail.gmail.com>
 <20170406192342.GC3093@worktop>
 <CA+55aFzvRiVx3dvXaQUpYwoHq0DnrV9RPXWnqSeb9b80DFosHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 6 Apr 2017 12:41:52 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, Apr 6, 2017 at 12:23 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Something like so then. According to the SDM mwait is a no-op if we do
> > not execute monitor first. So this variant should get the first
> > iteration without expensive instructions.  
> 
> No, the problem is that we *would* have executed a prior monitor that
> could still be pending - from a previous invocation of
> smp_cond_load_acquire().
> 
> Especially with spinlocks, these things can very much happen back-to-back.
> 
> And it would be pending with a different address (the previous
> spinlock) that might not have changed since then (and might not be
> changing), so now we might actually be pausing in mwait waiting for
> that *other* thing to change.
> 
> So it would probably need to do something complicated like
> 
>   #define smp_cond_load_acquire(ptr, cond_expr)                         \
>   ({                                                                    \
>         typeof(ptr) __PTR = (ptr);                                      \
>         typeof(*ptr) VAL;                                               \
>         do {                                                            \
>                 VAL = READ_ONCE(*__PTR);                                \
>                 if (cond_expr)                                          \
>                         break;                                          \
>                 for (;;) {                                              \
>                         ___monitor(__PTR, 0, 0);                        \
>                         VAL = READ_ONCE(*__PTR);                        \
>                         if (cond_expr) break;                           \
>                         ___mwait(0xf0 /* C0 */, 0);                     \
>                 }                                                       \
>         } while (0)                                                     \
>         smp_acquire__after_ctrl_dep();                                  \
>         VAL;                                                            \
>   })
> 
> which might just generate nasty enough code to not be worth it.

Okay, that's a bit of an issue I had with the spin_begin/in/end primitives.
The problem being some of these loops are a fastpath that expect success on
first iteration when not spinning. seqlock is another example.

powerpc does not want to go to low priority until after the initial test
fails, but cpu_relax based architectures do not want a pointless extra branch.

I added a spin_until_cond_likely() primitive that catches a number of these.
Not sure how well people would like that though.

Most loops actually are slowpath ones and work fine with begin/in/end though.
Attached a combined patch for reference with powerpc implementation and some
sites converted.

diff --git a/include/linux/processor.h b/include/linux/processor.h
new file mode 100644
index 000000000000..0a058aaa9bab
--- /dev/null
+++ b/include/linux/processor.h
@@ -0,0 +1,62 @@
+/* Misc low level processor primitives */
+#ifndef _LINUX_PROCESSOR_H
+#define _LINUX_PROCESSOR_H
+
+#include <asm/processor.h>
+
+/*
+ * spin_begin is used before beginning a busy-wait loop, and must be paired
+ * with spin_end when the loop is exited. spin_cpu_relax must be called
+ * within the loop.
+ *
+ * The loop body should be as small and fast as possible, on the order of
+ * tens of instructions/cycles as a guide. It should and avoid calling
+ * cpu_relax, or any "spin" or sleep type of primitive including nested uses
+ * of these primitives. It should not lock or take any other resource.
+ * Violations of these guidelies will not cause a bug, but may cause sub
+ * optimal performance.
+ *
+ * These loops are optimized to be used where wait times are expected to be
+ * less than the cost of a context switch (and associated overhead).
+ *
+ * Detection of resource owner and decision to spin or sleep or guest-yield
+ * (e.g., spin lock holder vcpu preempted, or mutex owner not on CPU) can be
+ * tested within the loop body.
+ */
+#ifndef spin_begin
+#define spin_begin()
+#endif
+
+#ifndef spin_cpu_relax
+#define spin_cpu_relax() cpu_relax()
+#endif
+
+/*
+ * spin_cpu_yield may be called to yield (undirected) to the hypervisor if
+ * necessary. This should be used if the wait is expected to take longer
+ * than context switch overhead, but we can't sleep or do a directed yield.
+ */
+#ifndef spin_cpu_yield
+#define spin_cpu_yield() cpu_relax_yield()
+#endif
+
+#ifndef spin_end
+#define spin_end()
+#endif
+
+/*
+ * spin_until_cond_likely can be used to wait for a condition to become true. It
+ * may be expected that the first iteration will true in the common case
+ * (no spinning).
+ */
+#ifndef spin_until_cond_likely
+#define spin_until_cond_likely(cond)					\
+do {								\
+	spin_begin();						\
+	while (unlikely(cond))						\
+		spin_cpu_relax();				\
+	spin_end();						\
+} while (0)
+#endif
+
+#endif /* _LINUX_PROCESSOR_H */
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index e0fecbcea2a2..47d134755c02 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -398,6 +398,33 @@ static inline unsigned long __pack_fe01(unsigned int fpmode)
 
 #ifdef CONFIG_PPC64
 #define cpu_relax()	do { HMT_low(); HMT_medium(); barrier(); } while (0)
+
+#ifndef spin_begin
+#define spin_begin()	HMT_low()
+#endif
+
+#ifndef spin_cpu_relax
+#define spin_cpu_relax()	barrier()
+#endif
+
+#ifndef spin_cpu_yield
+#define spin_cpu_yield()
+#endif
+
+#ifndef spin_end
+#define spin_end()	HMT_medium()
+#endif
+
+#define spin_until_cond_likely(cond)					\
+do {								\
+	if (unlikely(cond)) {					\
+		spin_begin();					\
+		while (cond)					\
+			spin_cpu_relax();			\
+		spin_end();					\
+	}							\
+} while (0)
+
 #else
 #define cpu_relax()	barrier()
 #endif
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 07b90725855e..5d2fec2d43ed 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -442,6 +442,7 @@ void __delay(unsigned long loops)
 	unsigned long start;
 	int diff;
 
+	spin_begin();
 	if (__USE_RTC()) {
 		start = get_rtcl();
 		do {
@@ -449,13 +450,14 @@ void __delay(unsigned long loops)
 			diff = get_rtcl() - start;
 			if (diff < 0)
 				diff += 1000000000;
+			spin_cpu_relax();
 		} while (diff < loops);
 	} else {
 		start = get_tbl();
 		while (get_tbl() - start < loops)
-			HMT_low();
-		HMT_medium();
+			spin_cpu_relax();
 	}
+	spin_end();
 }
 EXPORT_SYMBOL(__delay);
 
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index cc332608e656..6175855e5535 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -181,8 +181,10 @@ static inline void native_lock_hpte(struct hash_pte *hptep)
 	while (1) {
 		if (!test_and_set_bit_lock(HPTE_LOCK_BIT, word))
 			break;
+		spin_begin();
 		while(test_bit(HPTE_LOCK_BIT, word))
-			cpu_relax();
+			spin_cpu_relax();
+		spin_end();
 	}
 }
 
diff --git a/include/linux/bit_spinlock.h b/include/linux/bit_spinlock.h
index 3b5bafce4337..a9093ad8b5a2 100644
--- a/include/linux/bit_spinlock.h
+++ b/include/linux/bit_spinlock.h
@@ -25,9 +25,11 @@ static inline void bit_spin_lock(int bitnum, unsigned long *addr)
 #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
 	while (unlikely(test_and_set_bit_lock(bitnum, addr))) {
 		preempt_enable();
+		spin_begin();
 		do {
-			cpu_relax();
+			spin_cpu_relax();
 		} while (test_bit(bitnum, addr));
+		spin_end();
 		preempt_disable();
 	}
 #endif
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 1828900c9411..323ed2f272c4 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -80,8 +80,7 @@ static inline void *netpoll_poll_lock(struct napi_struct *napi)
 	if (dev && dev->npinfo) {
 		int owner = smp_processor_id();
 
-		while (cmpxchg(&napi->poll_owner, -1, owner) != -1)
-			cpu_relax();
+		spin_until_cond_likely(cmpxchg(&napi->poll_owner, -1, owner) == -1);
 
 		return napi;
 	}
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index ead97654c4e9..3991e2927c13 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -32,6 +32,7 @@
  * by Keith Owens and Andrea Arcangeli
  */
 
+#include <linux/processor.h>
 #include <linux/spinlock.h>
 #include <linux/preempt.h>
 #include <linux/lockdep.h>
@@ -108,12 +109,8 @@ static inline unsigned __read_seqcount_begin(const seqcount_t *s)
 {
 	unsigned ret;
 
-repeat:
-	ret = READ_ONCE(s->sequence);
-	if (unlikely(ret & 1)) {
-		cpu_relax();
-		goto repeat;
-	}
+	spin_until_cond_likely(!((ret = READ_ONCE(s->sequence)) & 1));
+
 	return ret;
 }
 
diff --git a/kernel/locking/mcs_spinlock.h b/kernel/locking/mcs_spinlock.h
index 6a385aabcce7..f10b3fca6efd 100644
--- a/kernel/locking/mcs_spinlock.h
+++ b/kernel/locking/mcs_spinlock.h
@@ -27,8 +27,10 @@ struct mcs_spinlock {
  */
 #define arch_mcs_spin_lock_contended(l)					\
 do {									\
+	spin_begin();							\
 	while (!(smp_load_acquire(l)))					\
-		cpu_relax();						\
+		spin_cpu_relax();					\
+	spin_end();							\
 } while (0)
 #endif
 
@@ -107,8 +109,10 @@ void mcs_spin_unlock(struct mcs_spinlock **lock, struct mcs_spinlock *node)
 		if (likely(cmpxchg_release(lock, node, NULL) == node))
 			return;
 		/* Wait until the next pointer is set */
+		spin_begin();
 		while (!(next = READ_ONCE(node->next)))
-			cpu_relax();
+			spin_cpu_relax();
+		spin_end();
 	}
 
 	/* Pass lock to next waiter. */
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 198527a62149..a8e42bfa2eef 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -427,6 +427,7 @@ bool mutex_spin_on_owner(struct mutex *lock, struct task_struct *owner,
 	bool ret = true;
 
 	rcu_read_lock();
+	spin_begin();
 	while (__mutex_owner(lock) == owner) {
 		/*
 		 * Ensure we emit the owner->on_cpu, dereference _after_
@@ -450,8 +451,9 @@ bool mutex_spin_on_owner(struct mutex *lock, struct task_struct *owner,
 			break;
 		}
 
-		cpu_relax();
+		spin_cpu_relax();
 	}
+	spin_end();
 	rcu_read_unlock();
 
 	return ret;
@@ -532,20 +534,25 @@ mutex_optimistic_spin(struct mutex *lock, struct ww_acquire_ctx *ww_ctx,
 			goto fail;
 	}
 
+	spin_begin();
 	for (;;) {
 		struct task_struct *owner;
 
 		/* Try to acquire the mutex... */
 		owner = __mutex_trylock_or_owner(lock);
-		if (!owner)
+		if (!owner) {
+			spin_end();
 			break;
+		}
 
 		/*
 		 * There's an owner, wait for it to either
 		 * release the lock or go to sleep.
 		 */
-		if (!mutex_spin_on_owner(lock, owner, ww_ctx, waiter))
+		if (!mutex_spin_on_owner(lock, owner, ww_ctx, waiter)) {
+			spin_end();
 			goto fail_unlock;
+		}
 
 		/*
 		 * The cpu_relax() call is a compiler barrier which forces
@@ -553,7 +560,7 @@ mutex_optimistic_spin(struct mutex *lock, struct ww_acquire_ctx *ww_ctx,
 		 * memory barriers as we'll eventually observe the right
 		 * values at the cost of a few extra spins.
 		 */
-		cpu_relax();
+		spin_cpu_relax();
 	}
 
 	if (!waiter)
diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
index a3167941093b..bb83dccf277c 100644
--- a/kernel/locking/osq_lock.c
+++ b/kernel/locking/osq_lock.c
@@ -53,6 +53,7 @@ osq_wait_next(struct optimistic_spin_queue *lock,
 	 */
 	old = prev ? prev->cpu : OSQ_UNLOCKED_VAL;
 
+	spin_begin();
 	for (;;) {
 		if (atomic_read(&lock->tail) == curr &&
 		    atomic_cmpxchg_acquire(&lock->tail, curr, old) == curr) {
@@ -80,8 +81,9 @@ osq_wait_next(struct optimistic_spin_queue *lock,
 				break;
 		}
 
-		cpu_relax();
+		spin_cpu_relax();
 	}
+	spin_end();
 
 	return next;
 }
diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index cc3ed0ccdfa2..786f26453a4a 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -53,10 +53,12 @@ struct __qrwlock {
 static __always_inline void
 rspin_until_writer_unlock(struct qrwlock *lock, u32 cnts)
 {
+	spin_begin();
 	while ((cnts & _QW_WMASK) == _QW_LOCKED) {
-		cpu_relax();
+		spin_cpu_relax();
 		cnts = atomic_read_acquire(&lock->cnts);
 	}
+	spin_end();
 }
 
 /**
@@ -123,6 +125,7 @@ void queued_write_lock_slowpath(struct qrwlock *lock)
 	 * Set the waiting flag to notify readers that a writer is pending,
 	 * or wait for a previous writer to go away.
 	 */
+	spin_begin();
 	for (;;) {
 		struct __qrwlock *l = (struct __qrwlock *)lock;
 
@@ -130,7 +133,7 @@ void queued_write_lock_slowpath(struct qrwlock *lock)
 		   (cmpxchg_relaxed(&l->wmode, 0, _QW_WAITING) == 0))
 			break;
 
-		cpu_relax();
+		spin_cpu_relax();
 	}
 
 	/* When no more readers, set the locked flag */
@@ -141,8 +144,10 @@ void queued_write_lock_slowpath(struct qrwlock *lock)
 					    _QW_LOCKED) == _QW_WAITING))
 			break;
 
-		cpu_relax();
+		spin_cpu_relax();
 	}
+	spin_end();
+
 unlock:
 	arch_spin_unlock(&lock->wait_lock);
 }
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index b2caec7315af..4cd2c148e989 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -361,6 +361,7 @@ void queued_spin_unlock_wait(struct qspinlock *lock)
 {
 	u32 val;
 
+	spin_begin();
 	for (;;) {
 		val = atomic_read(&lock->val);
 
@@ -371,14 +372,15 @@ void queued_spin_unlock_wait(struct qspinlock *lock)
 			break;
 
 		/* not locked, but pending, wait until we observe the lock */
-		cpu_relax();
+		spin_cpu_relax();
 	}
 
 	/* any unlock is good */
 	while (atomic_read(&lock->val) & _Q_LOCKED_MASK)
-		cpu_relax();
+		spin_cpu_relax();
 
 done:
+	spin_end();
 	smp_acquire__after_ctrl_dep();
 }
 EXPORT_SYMBOL(queued_spin_unlock_wait);
@@ -427,8 +429,10 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 * 0,1,0 -> 0,0,1
 	 */
 	if (val == _Q_PENDING_VAL) {
+		spin_begin();
 		while ((val = atomic_read(&lock->val)) == _Q_PENDING_VAL)
-			cpu_relax();
+			spin_cpu_relax();
+		spin_end();
 	}
 
 	/*
@@ -608,8 +612,10 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 * contended path; wait for next if not observed yet, release.
 	 */
 	if (!next) {
+		spin_begin();
 		while (!(next = READ_ONCE(node->next)))
-			cpu_relax();
+			spin_cpu_relax();
+		spin_end();
 	}
 
 	arch_mcs_spin_unlock_contended(&next->locked);
diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index e6b2f7ad3e51..0dd12c61220d 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -292,15 +292,19 @@ static void pv_wait_node(struct mcs_spinlock *node, struct mcs_spinlock *prev)
 	bool wait_early;
 
 	for (;;) {
+		spin_begin();
 		for (wait_early = false, loop = SPIN_THRESHOLD; loop; loop--) {
-			if (READ_ONCE(node->locked))
+			if (READ_ONCE(node->locked)) {
+				spin_end();
 				return;
+			}
 			if (pv_wait_early(pp, loop)) {
 				wait_early = true;
 				break;
 			}
-			cpu_relax();
+			spin_cpu_relax();
 		}
+		spin_end();
 
 		/*
 		 * Order pn->state vs pn->locked thusly:
@@ -416,11 +420,15 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
 		 * disable lock stealing before attempting to acquire the lock.
 		 */
 		set_pending(lock);
+		spin_begin();
 		for (loop = SPIN_THRESHOLD; loop; loop--) {
-			if (trylock_clear_pending(lock))
+			if (trylock_clear_pending(lock)) {
+				spin_end();
 				goto gotlock;
-			cpu_relax();
+			}
+			spin_cpu_relax();
 		}
+		spin_end();
 		clear_pending(lock);
 
 
diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 34e727f18e49..2d0e539f1a95 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -358,6 +358,7 @@ static noinline bool rwsem_spin_on_owner(struct rw_semaphore *sem)
 		goto out;
 
 	rcu_read_lock();
+	spin_begin();
 	while (sem->owner == owner) {
 		/*
 		 * Ensure we emit the owner->on_cpu, dereference _after_
@@ -373,12 +374,14 @@ static noinline bool rwsem_spin_on_owner(struct rw_semaphore *sem)
 		 */
 		if (!owner->on_cpu || need_resched() ||
 				vcpu_is_preempted(task_cpu(owner))) {
+			spin_end();
 			rcu_read_unlock();
 			return false;
 		}
 
-		cpu_relax();
+		spin_cpu_relax();
 	}
+	spin_end();
 	rcu_read_unlock();
 out:
 	/*
@@ -408,6 +411,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 	 *  2) readers own the lock as we can't determine if they are
 	 *     actively running or not.
 	 */
+	spin_begin();
 	while (rwsem_spin_on_owner(sem)) {
 		/*
 		 * Try to acquire the lock
@@ -432,8 +436,9 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 		 * memory barriers as we'll eventually observe the right
 		 * values at the cost of a few extra spins.
 		 */
-		cpu_relax();
+		spin_cpu_relax();
 	}
+	spin_end();
 	osq_unlock(&sem->osq);
 done:
 	preempt_enable();
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index ac6d5176463d..99a032d9f4a9 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -10,6 +10,7 @@
 #include <linux/mm.h>
 #include <linux/stackprotector.h>
 #include <linux/suspend.h>
+#include <linux/processor.h>
 
 #include <asm/tlb.h>
 
@@ -63,9 +64,13 @@ static noinline int __cpuidle cpu_idle_poll(void)
 	trace_cpu_idle_rcuidle(0, smp_processor_id());
 	local_irq_enable();
 	stop_critical_timings();
+
+	spin_begin();
 	while (!tif_need_resched() &&
 		(cpu_idle_force_poll || tick_check_broadcast_expired()))
-		cpu_relax();
+		spin_cpu_relax();
+	spin_end();
+
 	start_critical_timings();
 	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
 	rcu_idle_exit();
