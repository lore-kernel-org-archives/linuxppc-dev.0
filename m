Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rNXqp2cy2zDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jun 2016 21:42:30 +1000 (AEST)
Message-ID: <1465213340.2658.1.camel@ellerman.id.au>
Subject: [PATCH v3] powerpc: spinlock: Fix spin_unlock_wait()
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "Paul E.
 McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra
 <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, Boqun Feng
 <boqun.feng@gmail.com>
Date: Mon, 06 Jun 2016 21:42:20 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Boqun Feng <boqun.feng@gmail.com>

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
ppc, the "nop" ll/sc loop reads the lock
value and writes it back atomically, in this way it will synchronize the
view of the lock on CPU1 with that on CPU2. Therefore in the scenario
above, either CPU2 will fail to get the lock at first or CPU1 will see
the lock acquired by CPU2, both cases will eliminate this bug. This is a
similar idea as what Will Deacon did for ARM64 in:

  d86b8da04dfa ("arm64: spinlock: serialise spin_unlock_wait against concurrent lockers")

Furthermore, if the "nop" ll/sc figures out the lock is locked, we
actually don't need to do the "nop" ll/sc trick again, we can just do a
normal load+check loop for the lock to be released, because in that
case, spin_unlock_wait() is called when someone is holding the lock, and
the store part of the "nop" ll/sc happens before the lock release of the
current lock holder:

	"nop" ll/sc -> spin_unlock()

and the lock release happens before the next lock acquisition:

	spin_unlock() -> spin_lock() <next holder>

which means the "nop" ll/sc happens before the next lock acquisition:

	"nop" ll/sc -> spin_unlock() -> spin_lock() <next holder>

With a smp_mb() preceding spin_unlock_wait(), the store of object is
guaranteed to be observed by the next lock holder:

	STORE -> smp_mb() -> "nop" ll/sc
	-> spin_unlock() -> spin_lock() <next holder>

This patch therefore fixes the issue and also cleans the
arch_spin_unlock_wait() a little bit by removing superfluous memory
barriers in loops and consolidating the implementations for PPC32 and
PPC64 into one.

Suggested-by: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
[mpe: Inline the "nop" ll/sc loop and set EH=0, munge change log]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/spinlock.h | 38 +++++++++++++++++++++++++++++++------
 arch/powerpc/lib/locks.c            | 16 ----------------
 2 files changed, 32 insertions(+), 22 deletions(-)

v3 (mpe):
 - Inline the ll/sc loop.
 - Change the EH on the LWARX to 0
 - Rewrite change log to cope with the fact we removed arch_spin_is_locked_sync()

v1-->v2:

 - Improve the commit log, suggested by Peter Zijlstra
 - Keep two smp_mb()s for the safety, which though could be deleted
   if all the users have been aduited and fixed later.

diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index 523673d7583c..5f84fc147664 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -162,12 +162,38 @@ static inline void arch_spin_unlock(arch_spinlock_t *lock)
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
+	arch_spinlock_t lock_val;
+
+	smp_mb();
+
+	/*
+	 * Atomically load and store back the lock value (unchanged). This
+	 * ensures that our observation of the lock value is ordered with
+	 * respect to other lock operations.
+	 */
+	__asm__ __volatile__(
+"1:	" PPC_LWARX(%0, 0, %2, 0) "\n"
+"	stwcx. %0, 0, %2\n"
+"	bne- 1b\n"
+	: "=&r" (lock_val), "+m" (*lock)
+	: "r" (lock)
+	: "cr0", "xer");
+
+	if (arch_spin_value_unlocked(lock_val))
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
2.5.0
