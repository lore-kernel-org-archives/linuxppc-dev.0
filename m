Return-Path: <boqun.feng@gmail.com>
Received: from mail-oi0-x232.google.com (mail-oi0-x232.google.com
 [IPv6:2607:f8b0:4003:c06::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3417E1A02BF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 21:16:34 +1100 (AEDT)
Received: by oiad129 with SMTP id d129so97314168oia.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 03:16:32 -0700 (PDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Boqun Feng <boqun.feng@gmail.com>, <stable@vger.kernel.org>
Subject: [PATCH RESEND tip/locking/core v5 1/6] powerpc: atomic: Make _return
 atomics and *{cmp}xchg fully ordered
Date: Mon, 26 Oct 2015 18:15:36 +0800
Message-Id: <1445854536-22645-1-git-send-email-boqun.feng@gmail.com>
In-Reply-To: <1445853057-20735-1-git-send-email-boqun.feng@gmail.com>
References: <1445853057-20735-1-git-send-email-boqun.feng@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch fixes two problems to make value-returning atomics and
{cmp}xchg fully ordered on PPC.

According to memory-barriers.txt:

> Any atomic operation that modifies some state in memory and returns
> information about the state (old or new) implies an SMP-conditional
> general memory barrier (smp_mb()) on each side of the actual
> operation ...

which means these operations should be fully ordered. However on PPC,
PPC_ATOMIC_ENTRY_BARRIER is the barrier before the actual operation,
which is currently "lwsync" if SMP=y. The leading "lwsync" can not
guarantee fully ordered atomics, according to Paul Mckenney:

https://lkml.org/lkml/2015/10/14/970

To fix this, we define PPC_ATOMIC_ENTRY_BARRIER as "sync" to guarantee
the fully-ordered semantics.

This also makes futex atomics fully ordered, which can avoid possible
memory ordering problems if userspace code relies on futex system call
for fully ordered semantics.

Another thing to fix is that xchg, cmpxchg and their atomic{64}_
versions are currently RELEASE+ACQUIRE, which are not fully ordered.

So also replace PPC_RELEASE_BARRIER and PPC_ACQUIRE_BARRIER with
PPC_ATOMIC_ENTRY_BARRIER and PPC_ATOMIC_EXIT_BARRIER in
__{cmp,}xchg_{u32,u64} respectively to guarantee fully ordered semantics
of atomic{,64}_{cmp,}xchg() and {cmp,}xchg(), as a complement of commit
b97021f85517 ("powerpc: Fix atomic_xxx_return barrier semantics").

Cc: <stable@vger.kernel.org> # 3.4+
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---

Michael, I also change PPC_ATOMIC_ENTRY_BARRIER as "sync" if SMP=y in this
version , which is different from the previous one, so request for a new ack.
Thank you ;-)

 arch/powerpc/include/asm/cmpxchg.h | 16 ++++++++--------
 arch/powerpc/include/asm/synch.h   |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/asm/cmpxchg.h
index ad6263c..d1a8d93 100644
--- a/arch/powerpc/include/asm/cmpxchg.h
+++ b/arch/powerpc/include/asm/cmpxchg.h
@@ -18,12 +18,12 @@ __xchg_u32(volatile void *p, unsigned long val)
 	unsigned long prev;
 
 	__asm__ __volatile__(
-	PPC_RELEASE_BARRIER
+	PPC_ATOMIC_ENTRY_BARRIER
 "1:	lwarx	%0,0,%2 \n"
 	PPC405_ERR77(0,%2)
 "	stwcx.	%3,0,%2 \n\
 	bne-	1b"
-	PPC_ACQUIRE_BARRIER
+	PPC_ATOMIC_EXIT_BARRIER
 	: "=&r" (prev), "+m" (*(volatile unsigned int *)p)
 	: "r" (p), "r" (val)
 	: "cc", "memory");
@@ -61,12 +61,12 @@ __xchg_u64(volatile void *p, unsigned long val)
 	unsigned long prev;
 
 	__asm__ __volatile__(
-	PPC_RELEASE_BARRIER
+	PPC_ATOMIC_ENTRY_BARRIER
 "1:	ldarx	%0,0,%2 \n"
 	PPC405_ERR77(0,%2)
 "	stdcx.	%3,0,%2 \n\
 	bne-	1b"
-	PPC_ACQUIRE_BARRIER
+	PPC_ATOMIC_EXIT_BARRIER
 	: "=&r" (prev), "+m" (*(volatile unsigned long *)p)
 	: "r" (p), "r" (val)
 	: "cc", "memory");
@@ -151,14 +151,14 @@ __cmpxchg_u32(volatile unsigned int *p, unsigned long old, unsigned long new)
 	unsigned int prev;
 
 	__asm__ __volatile__ (
-	PPC_RELEASE_BARRIER
+	PPC_ATOMIC_ENTRY_BARRIER
 "1:	lwarx	%0,0,%2		# __cmpxchg_u32\n\
 	cmpw	0,%0,%3\n\
 	bne-	2f\n"
 	PPC405_ERR77(0,%2)
 "	stwcx.	%4,0,%2\n\
 	bne-	1b"
-	PPC_ACQUIRE_BARRIER
+	PPC_ATOMIC_EXIT_BARRIER
 	"\n\
 2:"
 	: "=&r" (prev), "+m" (*p)
@@ -197,13 +197,13 @@ __cmpxchg_u64(volatile unsigned long *p, unsigned long old, unsigned long new)
 	unsigned long prev;
 
 	__asm__ __volatile__ (
-	PPC_RELEASE_BARRIER
+	PPC_ATOMIC_ENTRY_BARRIER
 "1:	ldarx	%0,0,%2		# __cmpxchg_u64\n\
 	cmpd	0,%0,%3\n\
 	bne-	2f\n\
 	stdcx.	%4,0,%2\n\
 	bne-	1b"
-	PPC_ACQUIRE_BARRIER
+	PPC_ATOMIC_EXIT_BARRIER
 	"\n\
 2:"
 	: "=&r" (prev), "+m" (*p)
diff --git a/arch/powerpc/include/asm/synch.h b/arch/powerpc/include/asm/synch.h
index e682a71..c508686 100644
--- a/arch/powerpc/include/asm/synch.h
+++ b/arch/powerpc/include/asm/synch.h
@@ -44,7 +44,7 @@ static inline void isync(void)
 	MAKE_LWSYNC_SECTION_ENTRY(97, __lwsync_fixup);
 #define PPC_ACQUIRE_BARRIER	 "\n" stringify_in_c(__PPC_ACQUIRE_BARRIER)
 #define PPC_RELEASE_BARRIER	 stringify_in_c(LWSYNC) "\n"
-#define PPC_ATOMIC_ENTRY_BARRIER "\n" stringify_in_c(LWSYNC) "\n"
+#define PPC_ATOMIC_ENTRY_BARRIER "\n" stringify_in_c(sync) "\n"
 #define PPC_ATOMIC_EXIT_BARRIER	 "\n" stringify_in_c(sync) "\n"
 #else
 #define PPC_ACQUIRE_BARRIER
-- 
2.6.2
