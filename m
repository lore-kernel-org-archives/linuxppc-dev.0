Return-Path: <boqun.feng@gmail.com>
Received: from mail-ob0-x244.google.com (mail-ob0-x244.google.com
 [IPv6:2607:f8b0:4003:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0BDC11A0999
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 20:51:55 +1100 (AEDT)
Received: by obbia6 with SMTP id ia6so7414269obb.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 02:51:52 -0700 (PDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH tip/locking/core v5 4/6] powerpc: atomic: Implement atomic{,
 64}_*_return_* variants
Date: Mon, 26 Oct 2015 17:50:55 +0800
Message-Id: <1445853057-20735-5-git-send-email-boqun.feng@gmail.com>
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

On powerpc, acquire and release semantics can be achieved with
lightweight barriers("lwsync" and "ctrl+isync"), which can be used to
implement __atomic_op_{acquire,release}.

For release semantics, since we only need to ensure all memory accesses
that issue before must take effects before the -store- part of the
atomics, "lwsync" is what we only need. On the platform without
"lwsync", "sync" should be used. Therefore, smp_lwsync() is used here.

For acquire semantics, "lwsync" is what we only need for the similar
reason.  However on the platform without "lwsync", we can use "isync"
rather than "sync" as an acquire barrier. Therefore in
__atomic_op_acquire() we use PPC_ACQUIRE_BARRIER, which is barrier() on
UP, "lwsync" if available and "isync" otherwise.

Implement atomic{,64}_{add,sub,inc,dec}_return_relaxed, and build other
variants with these helpers.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 arch/powerpc/include/asm/atomic.h | 107 +++++++++++++++++++++++---------------
 1 file changed, 65 insertions(+), 42 deletions(-)

diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index 55f106e..f9c0c6c 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -12,6 +12,24 @@
 
 #define ATOMIC_INIT(i)		{ (i) }
 
+/*
+ * Since *_return_relaxed and {cmp}xchg_relaxed are implemented with
+ * a "bne-" instruction at the end, so an isync is enough as a acquire barrier
+ * on the platform without lwsync.
+ */
+#define __atomic_op_acquire(op, args...)				\
+({									\
+	typeof(op##_relaxed(args)) __ret  = op##_relaxed(args);		\
+	__asm__ __volatile__(PPC_ACQUIRE_BARRIER "" : : : "memory");	\
+	__ret;								\
+})
+
+#define __atomic_op_release(op, args...)				\
+({									\
+	smp_lwsync();							\
+	op##_relaxed(args);						\
+})
+
 static __inline__ int atomic_read(const atomic_t *v)
 {
 	int t;
@@ -42,27 +60,27 @@ static __inline__ void atomic_##op(int a, atomic_t *v)			\
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
@@ -71,8 +89,11 @@ ATOMIC_OP(and, and)
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
@@ -92,21 +113,19 @@ static __inline__ void atomic_inc(atomic_t *v)
 	: "cc", "xer");
 }
 
-static __inline__ int atomic_inc_return(atomic_t *v)
+static __inline__ int atomic_inc_return_relaxed(atomic_t *v)
 {
 	int t;
 
 	__asm__ __volatile__(
-	PPC_ATOMIC_ENTRY_BARRIER
-"1:	lwarx	%0,0,%1		# atomic_inc_return\n\
+"1:	lwarx	%0,0,%1		# atomic_inc_return_relaxed\n\
 	addic	%0,%0,1\n"
 	PPC405_ERR77(0,%1)
 "	stwcx.	%0,0,%1 \n\
 	bne-	1b"
-	PPC_ATOMIC_EXIT_BARRIER
 	: "=&r" (t)
 	: "r" (&v->counter)
-	: "cc", "xer", "memory");
+	: "cc", "xer");
 
 	return t;
 }
@@ -136,25 +155,26 @@ static __inline__ void atomic_dec(atomic_t *v)
 	: "cc", "xer");
 }
 
-static __inline__ int atomic_dec_return(atomic_t *v)
+static __inline__ int atomic_dec_return_relaxed(atomic_t *v)
 {
 	int t;
 
 	__asm__ __volatile__(
-	PPC_ATOMIC_ENTRY_BARRIER
-"1:	lwarx	%0,0,%1		# atomic_dec_return\n\
+"1:	lwarx	%0,0,%1		# atomic_dec_return_relaxed\n\
 	addic	%0,%0,-1\n"
 	PPC405_ERR77(0,%1)
 "	stwcx.	%0,0,%1\n\
 	bne-	1b"
-	PPC_ATOMIC_EXIT_BARRIER
 	: "=&r" (t)
 	: "r" (&v->counter)
-	: "cc", "xer", "memory");
+	: "cc", "xer");
 
 	return t;
 }
 
+#define atomic_inc_return_relaxed atomic_inc_return_relaxed
+#define atomic_dec_return_relaxed atomic_dec_return_relaxed
+
 #define atomic_cmpxchg(v, o, n) (cmpxchg(&((v)->counter), (o), (n)))
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
@@ -285,26 +305,27 @@ static __inline__ void atomic64_##op(long a, atomic64_t *v)		\
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
@@ -312,8 +333,11 @@ ATOMIC64_OP(and, and)
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
@@ -332,20 +356,18 @@ static __inline__ void atomic64_inc(atomic64_t *v)
 	: "cc", "xer");
 }
 
-static __inline__ long atomic64_inc_return(atomic64_t *v)
+static __inline__ long atomic64_inc_return_relaxed(atomic64_t *v)
 {
 	long t;
 
 	__asm__ __volatile__(
-	PPC_ATOMIC_ENTRY_BARRIER
 "1:	ldarx	%0,0,%1		# atomic64_inc_return\n\
 	addic	%0,%0,1\n\
 	stdcx.	%0,0,%1 \n\
 	bne-	1b"
-	PPC_ATOMIC_EXIT_BARRIER
 	: "=&r" (t)
 	: "r" (&v->counter)
-	: "cc", "xer", "memory");
+	: "cc", "xer");
 
 	return t;
 }
@@ -374,24 +396,25 @@ static __inline__ void atomic64_dec(atomic64_t *v)
 	: "cc", "xer");
 }
 
-static __inline__ long atomic64_dec_return(atomic64_t *v)
+static __inline__ long atomic64_dec_return_relaxed(atomic64_t *v)
 {
 	long t;
 
 	__asm__ __volatile__(
-	PPC_ATOMIC_ENTRY_BARRIER
 "1:	ldarx	%0,0,%1		# atomic64_dec_return\n\
 	addic	%0,%0,-1\n\
 	stdcx.	%0,0,%1\n\
 	bne-	1b"
-	PPC_ATOMIC_EXIT_BARRIER
 	: "=&r" (t)
 	: "r" (&v->counter)
-	: "cc", "xer", "memory");
+	: "cc", "xer");
 
 	return t;
 }
 
+#define atomic64_inc_return_relaxed atomic64_inc_return_relaxed
+#define atomic64_dec_return_relaxed atomic64_dec_return_relaxed
+
 #define atomic64_sub_and_test(a, v)	(atomic64_sub_return((a), (v)) == 0)
 #define atomic64_dec_and_test(v)	(atomic64_dec_return((v)) == 0)
 
-- 
2.6.2
