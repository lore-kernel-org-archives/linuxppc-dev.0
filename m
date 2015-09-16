Return-Path: <boqun.feng@gmail.com>
Received: from mail-ob0-x229.google.com (mail-ob0-x229.google.com
 [IPv6:2607:f8b0:4003:c01::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9805E1A0622
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 01:50:17 +1000 (AEST)
Received: by obbda8 with SMTP id da8so152232504obb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 08:50:15 -0700 (PDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC v2 3/7] powerpc: atomic: Implement atomic{, 64}_{add,
 sub}_return_* variants
Date: Wed, 16 Sep 2015 23:49:31 +0800
Message-Id: <1442418575-12297-4-git-send-email-boqun.feng@gmail.com>
In-Reply-To: <1442418575-12297-1-git-send-email-boqun.feng@gmail.com>
References: <1442418575-12297-1-git-send-email-boqun.feng@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On powerpc, we don't need a general memory barrier to achieve acquire and
release semantics, so __atomic_op_{acquire,release} can be implemented
using "lwsync" and "isync".

For release semantics, since we only need to ensure all memory accesses
that issue before must take effects before the -store- part of the
atomics, "lwsync" is what we only need. On the platform without
"lwsync", "sync" should be used. Therefore, smp_lwsync() is used here.

For acquire semantics, "lwsync" is what we only need for the similar
reason.  However on the platform without "lwsync", we can use "isync"
rather than "sync" as an acquire barrier. So a new kind of barrier
smp_acquire_barrier__after_atomic() is introduced, which is barrier() on
UP, "lwsync" if available and "isync" otherwise.

__atomic_op_fence is defined as smp_lwsync() + _relaxed +
smp_mb__after_atomic() to guarantee a fully order.

Implement atomic{,64}_{add,sub}_return_relaxed, and build other variants
with these helpers.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 arch/powerpc/include/asm/atomic.h | 88 ++++++++++++++++++++++++++++-----------
 1 file changed, 64 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index 55f106e..d1dcdcf 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -12,6 +12,39 @@
 
 #define ATOMIC_INIT(i)		{ (i) }
 
+/*
+ * Since {add,sub}_return_relaxed and xchg_relaxed are implemented with
+ * a "bne-" instruction at the end, so an isync is enough as a acquire barrier
+ * on the platform without lwsync.
+ */
+#ifdef CONFIG_SMP
+#define smp_acquire_barrier__after_atomic() \
+	__asm__ __volatile__(PPC_ACQUIRE_BARRIER : : : "memory")
+#else
+#define smp_acquire_barrier__after_atomic() barrier()
+#endif
+#define __atomic_op_acquire(op, args...)				\
+({									\
+	typeof(op##_relaxed(args)) __ret  = op##_relaxed(args);		\
+	smp_acquire_barrier__after_atomic();				\
+	__ret;								\
+})
+
+#define __atomic_op_release(op, args...)				\
+({									\
+	smp_lwsync();							\
+	op##_relaxed(args);						\
+})
+
+#define __atomic_op_fence(op, args...)				\
+({									\
+	typeof(op##_relaxed(args)) __ret;				\
+	smp_lwsync();							\
+	__ret = op##_relaxed(args);					\
+	smp_mb__after_atomic();						\
+	__ret;								\
+})
+
 static __inline__ int atomic_read(const atomic_t *v)
 {
 	int t;
@@ -42,27 +75,27 @@ static __inline__ void atomic_##op(int a, atomic_t *v)			\
 	: "cc");							\
 }									\
 
-#define ATOMIC_OP_RETURN(op, asm_op)					\
-static __inline__ int atomic_##op##_return(int a, atomic_t *v)		\
+#define ATOMIC_OP_RETURN_RELAXED(op, asm_op)				\
+static inline int atomic_##op##_return_relaxed(int a, atomic_t *v)	\
 {									\
 	int t;								\
 									\
 	__asm__ __volatile__(						\
-	PPC_ATOMIC_ENTRY_BARRIER					\
-"1:	lwarx	%0,0,%2		# atomic_" #op "_return\n"		\
-	#asm_op " %0,%1,%0\n"						\
-	PPC405_ERR77(0,%2)						\
-"	stwcx.	%0,0,%2 \n"						\
+"1:	lwarx	%0,0,%3		# atomic_" #op "_return_relaxed\n"	\
+	#asm_op " %0,%2,%0\n"						\
+	PPC405_ERR77(0, %3)						\
+"	stwcx.	%0,0,%3\n"						\
 "	bne-	1b\n"							\
-	PPC_ATOMIC_EXIT_BARRIER						\
-	: "=&r" (t)							\
+	: "=&r" (t), "+m" (v->counter)					\
 	: "r" (a), "r" (&v->counter)					\
-	: "cc", "memory");						\
+	: "cc");							\
 									\
 	return t;							\
 }
 
-#define ATOMIC_OPS(op, asm_op) ATOMIC_OP(op, asm_op) ATOMIC_OP_RETURN(op, asm_op)
+#define ATOMIC_OPS(op, asm_op)						\
+	ATOMIC_OP(op, asm_op)						\
+	ATOMIC_OP_RETURN_RELAXED(op, asm_op)
 
 ATOMIC_OPS(add, add)
 ATOMIC_OPS(sub, subf)
@@ -71,8 +104,11 @@ ATOMIC_OP(and, and)
 ATOMIC_OP(or, or)
 ATOMIC_OP(xor, xor)
 
+#define atomic_add_return_relaxed atomic_add_return_relaxed
+#define atomic_sub_return_relaxed atomic_sub_return_relaxed
+
 #undef ATOMIC_OPS
-#undef ATOMIC_OP_RETURN
+#undef ATOMIC_OP_RETURN_RELAXED
 #undef ATOMIC_OP
 
 #define atomic_add_negative(a, v)	(atomic_add_return((a), (v)) < 0)
@@ -285,26 +321,27 @@ static __inline__ void atomic64_##op(long a, atomic64_t *v)		\
 	: "cc");							\
 }
 
-#define ATOMIC64_OP_RETURN(op, asm_op)					\
-static __inline__ long atomic64_##op##_return(long a, atomic64_t *v)	\
+#define ATOMIC64_OP_RETURN_RELAXED(op, asm_op)				\
+static inline long							\
+atomic64_##op##_return_relaxed(long a, atomic64_t *v)			\
 {									\
 	long t;								\
 									\
 	__asm__ __volatile__(						\
-	PPC_ATOMIC_ENTRY_BARRIER					\
-"1:	ldarx	%0,0,%2		# atomic64_" #op "_return\n"		\
-	#asm_op " %0,%1,%0\n"						\
-"	stdcx.	%0,0,%2 \n"						\
+"1:	ldarx	%0,0,%3		# atomic64_" #op "_return_relaxed\n"	\
+	#asm_op " %0,%2,%0\n"						\
+"	stdcx.	%0,0,%3\n"						\
 "	bne-	1b\n"							\
-	PPC_ATOMIC_EXIT_BARRIER						\
-	: "=&r" (t)							\
+	: "=&r" (t), "+m" (v->counter)					\
 	: "r" (a), "r" (&v->counter)					\
-	: "cc", "memory");						\
+	: "cc");							\
 									\
 	return t;							\
 }
 
-#define ATOMIC64_OPS(op, asm_op) ATOMIC64_OP(op, asm_op) ATOMIC64_OP_RETURN(op, asm_op)
+#define ATOMIC64_OPS(op, asm_op)					\
+	ATOMIC64_OP(op, asm_op)						\
+	ATOMIC64_OP_RETURN_RELAXED(op, asm_op)
 
 ATOMIC64_OPS(add, add)
 ATOMIC64_OPS(sub, subf)
@@ -312,8 +349,11 @@ ATOMIC64_OP(and, and)
 ATOMIC64_OP(or, or)
 ATOMIC64_OP(xor, xor)
 
-#undef ATOMIC64_OPS
-#undef ATOMIC64_OP_RETURN
+#define atomic64_add_return_relaxed atomic64_add_return_relaxed
+#define atomic64_sub_return_relaxed atomic64_sub_return_relaxed
+
+#undef ATOPIC64_OPS
+#undef ATOMIC64_OP_RETURN_RELAXED
 #undef ATOMIC64_OP
 
 #define atomic64_add_negative(a, v)	(atomic64_add_return((a), (v)) < 0)
-- 
2.5.1
