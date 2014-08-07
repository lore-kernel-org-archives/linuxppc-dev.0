Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8D70A1A06EE
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Aug 2014 15:36:23 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/2] powerpc: Add smp_mb() to arch_spin_is_locked()
Date: Thu,  7 Aug 2014 15:36:17 +1000
Message-Id: <1407389778-6793-1-git-send-email-mpe@ellerman.id.au>
Cc: paulmck@linux.vnet.ibm.com, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The kernel defines the function spin_is_locked(), which can be used to
check if a spinlock is currently locked.

Using spin_is_locked() on a lock you don't hold is obviously racy. That
is, even though you may observe that the lock is unlocked, it may become
locked at any time.

There is (at least) one exception to that, which is if two locks are
used as a pair, and the holder of each checks the status of the other
before doing any update.

Assuming *A and *B are two locks, and *COUNTER is a shared non-atomic
value:

The first CPU does:

	spin_lock(*A)

	if spin_is_locked(*B)
		# nothing
	else
		smp_mb()
		LOAD r = *COUNTER
		r++
		STORE *COUNTER = r

	spin_unlock(*A)

And the second CPU does:

	spin_lock(*B)

	if spin_is_locked(*A)
		# nothing
	else
		smp_mb()
		LOAD r = *COUNTER
		r++
		STORE *COUNTER = r

	spin_unlock(*B)

Although this is a strange locking construct, it should work.

It seems to be understood, but not documented, that spin_is_locked() is
not a memory barrier, so in the examples above and below the caller
inserts its own memory barrier before acting on the result of
spin_is_locked().

For now we assume spin_is_locked() is implemented as below, and we break
it out in our examples:

	bool spin_is_locked(*LOCK) {
		LOAD l = *LOCK
		return l.locked
	}

Our intuition is that there should be no problem even if the two code
sequences run simultaneously such as:

	CPU 0			CPU 1
	==================================================
	spin_lock(*A)		spin_lock(*B)
	LOAD b = *B		LOAD a = *A
	if b.locked # true	if a.locked # true
	# nothing		# nothing
	spin_unlock(*A)		spin_unlock(*B)

If one CPU gets the lock before the other then it will do the update and
the other CPU will back off:

	CPU 0			CPU 1
	==================================================
	spin_lock(*A)
	LOAD b = *B
				spin_lock(*B)
	if b.locked # false	LOAD a = *A
	else			if a.locked # true
	smp_mb()		# nothing
	LOAD r1 = *COUNTER	spin_unlock(*B)
	r1++
	STORE *COUNTER = r1
	spin_unlock(*A)

However in reality spin_lock() itself is not indivisible. On powerpc we
implement it as a load-and-reserve and store-conditional.

Ignoring the retry logic for the lost reservation case, it boils down to:
	spin_lock(*LOCK) {
		LOAD l = *LOCK
		l.locked = true
		STORE *LOCK = l
		ACQUIRE_BARRIER
	}

The ACQUIRE_BARRIER is required to give spin_lock() ACQUIRE semantics as
defined in memory-barriers.txt:

     This acts as a one-way permeable barrier.  It guarantees that all
     memory operations after the ACQUIRE operation will appear to happen
     after the ACQUIRE operation with respect to the other components of
     the system.

On modern powerpc systems we use lwsync for ACQUIRE_BARRIER. lwsync is
also know as "lightweight sync", or "sync 1".

As described in Power ISA v2.07 section B.2.1.1, in this scenario the
lwsync is not the barrier itself. It instead causes the LOAD of *LOCK to
act as the barrier, preventing any loads or stores in the locked region
from occurring prior to the load of *LOCK.

Whether this behaviour is in accordance with the definition of ACQUIRE
semantics in memory-barriers.txt is open to discussion, we may switch to
a different barrier in future.

What this means in practice is that the following can occur:

	CPU 0			CPU 1
	==================================================
	LOAD a = *A 		LOAD b = *B
	a.locked = true		b.locked = true
	LOAD b = *B		LOAD a = *A
	STORE *A = a		STORE *B = b
	if b.locked # false	if a.locked # false
	else			else
	smp_mb()		smp_mb()
	LOAD r1 = *COUNTER	LOAD r2 = *COUNTER
	r1++			r2++
	STORE *COUNTER = r1
				STORE *COUNTER = r2	# Lost update
	spin_unlock(*A)		spin_unlock(*B)

That is, the load of *B can occur prior to the store that makes *A
visibly locked. And similarly for CPU 1. The result is both CPUs hold
their lock and believe the other lock is unlocked.

The easiest fix for this is to add a full memory barrier to the start of
spin_is_locked(), so adding to our previous definition would give us:

	bool spin_is_locked(*LOCK) {
		smp_mb()
		LOAD l = *LOCK
		return l.locked
	}

The new barrier orders the store to the lock we are locking vs the load
of the other lock:

	CPU 0			CPU 1
	==================================================
	LOAD a = *A 		LOAD b = *B
	a.locked = true		b.locked = true
	STORE *A = a		STORE *B = b
	smp_mb()		smp_mb()
	LOAD b = *B		LOAD a = *A
	if b.locked # true	if a.locked # true
	# nothing		# nothing
	spin_unlock(*A)		spin_unlock(*B)

Although the above example is theoretical, there is code similar to this
example in sem_lock() in ipc/sem.c. This commit in addition to the next
commit appears to be a fix for crashes we are seeing in that code where
we believe this race happens in practice.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/spinlock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index 35aa339410bd..4dbe072eecbe 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -61,6 +61,7 @@ static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
 
 static inline int arch_spin_is_locked(arch_spinlock_t *lock)
 {
+	smp_mb();
 	return !arch_spin_value_unlocked(*lock);
 }
 
-- 
1.9.1
