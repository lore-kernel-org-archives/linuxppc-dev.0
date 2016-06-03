Return-Path: <boqun.feng@gmail.com>
Received: from mail-it0-x242.google.com (mail-it0-x242.google.com
 [IPv6:2607:f8b0:4001:c0b::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rLVPk4727zDqks
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jun 2016 13:46:18 +1000 (AEST)
Received: by mail-it0-x242.google.com with SMTP id i127so5159976ita.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jun 2016 20:46:18 -0700 (PDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>,
 Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v2] powerpc: spinlock: Fix spin_unlock_wait()
Date: Fri,  3 Jun 2016 11:49:48 +0800
Message-Id: <20160603034948.17589-1-boqun.feng@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is an ordering issue with spin_unlock_wait() on powerpc, because
the spin_lock primitive is an ACQUIRE and an ACQUIRE is only ordering
the load part of the operation with memory operations following it.
Therefore the following event sequence can happen:

CPU 1			CPU 2			CPU 3
==================	====================	==============
						spin_unlock(&lock);
			spin_lock(&lock):
			  r1 = *lock; // r1 == 0;
o = object;		o = READ_ONCE(object); // reordered here
object = NULL;
smp_mb();
spin_unlock_wait(&lock);
			  *lock = 1;
smp_mb();
o->dead = true;         < o = READ_ONCE(object); > // reordered upwards
			if (o) // true
				BUG_ON(o->dead); // true!!

To fix this, we add a "nop" ll/sc loop in arch_spin_unlock_wait() on
ppc (arch_spin_is_locked_sync()), the "nop" ll/sc loop reads the lock
value and writes it back atomically, in this way it will synchronize the
view of the lock on CPU1 with that on CPU2. Therefore in the scenario
above, either CPU2 will fail to get the lock at first or CPU1 will see
the lock acquired by CPU2, both cases will eliminate this bug. This is a
similar idea as what Will Deacon did for ARM64 in:

  d86b8da04dfa ("arm64: spinlock: serialise spin_unlock_wait against concurrent lockers")

Further more, if arch_spin_is_locked_sync() figures out the lock is
locked, we actually don't need to do the "nop" ll/sc trick again, we can
just do a normal load+check loop for the lock to be released, because in
that case, spin_unlock_wait() is called when someone is holding the
lock, and the store part of arch_spin_is_locked_sync() happens before
the lock release of the current lock holder:

	arch_spin_is_locked_sync() -> spin_unlock()

and the lock release happens before the next lock acquisition:

	spin_unlock() -> spin_lock() <next holder>

which means arch_spin_is_locked_sync() happens before the next lock
acquisition:

	arch_spin_is_locked_sync() -> spin_unlock() -> spin_lock() <next holder>

With a smp_mb() perceding spin_unlock_wait(), the store of object is
guaranteed to be observed by the next lock holder:

	STORE -> smp_mb() -> arch_spin_is_locked_sync()
	-> spin_unlock() -> spin_lock() <next holder>

This patch therefore fixes the issue and also cleans the
arch_spin_unlock_wait() a little bit by removing superfluous memory
barriers in loops and consolidating the implementations for PPC32 and
PPC64 into one.

Suggested-by: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
---
v1-->v2:

*	Improve the commit log, suggested by Peter Zijlstra

*	Keep two smp_mb()s for the safety, which though could be deleted
	if all the users have been aduited and fixed later.
	

 arch/powerpc/include/asm/spinlock.h | 42 +++++++++++++++++++++++++++++++------
 arch/powerpc/lib/locks.c            | 16 --------------
 2 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index 523673d7583c..2ed893662866 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -64,6 +64,25 @@ static inline int arch_spin_is_locked(arch_spinlock_t *lock)
 }
 
 /*
+ * Use a ll/sc loop to read the lock value, the STORE part of this operation is
+ * used for making later lock operation observe it.
+ */
+static inline bool arch_spin_is_locked_sync(arch_spinlock_t *lock)
+{
+	arch_spinlock_t tmp;
+
+	__asm__ __volatile__(
+"1:	" PPC_LWARX(%0, 0, %2, 1) "\n"
+"	stwcx. %0, 0, %2\n"
+"	bne- 1b\n"
+	: "=&r" (tmp), "+m" (*lock)
+	: "r" (lock)
+	: "cr0", "xer");
+
+	return !arch_spin_value_unlocked(tmp);
+}
+
+/*
  * This returns the old value in the lock, so we succeeded
  * in getting the lock if the return value is 0.
  */
@@ -162,12 +181,23 @@ static inline void arch_spin_unlock(arch_spinlock_t *lock)
 	lock->slock = 0;
 }
 
-#ifdef CONFIG_PPC64
-extern void arch_spin_unlock_wait(arch_spinlock_t *lock);
-#else
-#define arch_spin_unlock_wait(lock) \
-	do { while (arch_spin_is_locked(lock)) cpu_relax(); } while (0)
-#endif
+static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
+{
+	smp_mb();
+
+	if (!arch_spin_is_locked_sync(lock))
+		goto out;
+
+	while (!arch_spin_value_unlocked(*lock)) {
+		HMT_low();
+		if (SHARED_PROCESSOR)
+			__spin_yield(lock);
+	}
+	HMT_medium();
+
+out:
+	smp_mb();
+}
 
 /*
  * Read-write spinlocks, allowing multiple readers
diff --git a/arch/powerpc/lib/locks.c b/arch/powerpc/lib/locks.c
index f7deebdf3365..b7b1237d4aa6 100644
--- a/arch/powerpc/lib/locks.c
+++ b/arch/powerpc/lib/locks.c
@@ -68,19 +68,3 @@ void __rw_yield(arch_rwlock_t *rw)
 		get_hard_smp_processor_id(holder_cpu), yield_count);
 }
 #endif
-
-void arch_spin_unlock_wait(arch_spinlock_t *lock)
-{
-	smp_mb();
-
-	while (lock->slock) {
-		HMT_low();
-		if (SHARED_PROCESSOR)
-			__spin_yield(lock);
-	}
-	HMT_medium();
-
-	smp_mb();
-}
-
-EXPORT_SYMBOL(arch_spin_unlock_wait);
-- 
2.8.3
