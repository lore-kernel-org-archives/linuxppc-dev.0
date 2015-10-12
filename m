Return-Path: <boqun.feng@gmail.com>
Received: from mail-oi0-x22f.google.com (mail-oi0-x22f.google.com
 [IPv6:2607:f8b0:4003:c06::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1E93E1A082E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 01:15:58 +1100 (AEDT)
Received: by oihr205 with SMTP id r205so15589939oih.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 07:15:56 -0700 (PDT)
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
Subject: [PATCH v3 6/6] powerpc: atomic: Implement cmpxchg{, 64}_* and atomic{,
 64}_cmpxchg_* variants
Date: Mon, 12 Oct 2015 22:14:06 +0800
Message-Id: <1444659246-24769-7-git-send-email-boqun.feng@gmail.com>
In-Reply-To: <1444659246-24769-1-git-send-email-boqun.feng@gmail.com>
References: <1444659246-24769-1-git-send-email-boqun.feng@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Implement cmpxchg{,64}_relaxed and atomic{,64}_cmpxchg_relaxed, based on
which _release variants can be built.

To avoid superfluous barriers in _acquire variants, we implement these
operations with assembly code rather use __atomic_op_acquire() to build
them automatically.

For the same reason, we keep the assembly implementation of fully
ordered cmpxchg operations.

Note cmpxchg{,64}_relaxed and atomic{,64}_cmpxchg_relaxed are not
compiler barriers.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 arch/powerpc/include/asm/atomic.h  |  10 +++
 arch/powerpc/include/asm/cmpxchg.h | 141 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 150 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index 8869fb3..9f44515 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -191,6 +191,11 @@ static __inline__ int atomic_dec_return_relaxed(atomic_t *v)
 #define atomic_dec_return_relaxed atomic_dec_return_relaxed
 
 #define atomic_cmpxchg(v, o, n) (cmpxchg(&((v)->counter), (o), (n)))
+#define atomic_cmpxchg_relaxed(v, o, n) \
+	cmpxchg_relaxed(&((v)->counter), (o), (n))
+#define atomic_cmpxchg_acquire(v, o, n) \
+	cmpxchg_acquire(&((v)->counter), (o), (n))
+
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 #define atomic_xchg_relaxed(v, new) xchg_relaxed(&((v)->counter), (new))
 
@@ -459,6 +464,11 @@ static __inline__ long atomic64_dec_if_positive(atomic64_t *v)
 }
 
 #define atomic64_cmpxchg(v, o, n) (cmpxchg(&((v)->counter), (o), (n)))
+#define atomic64_cmpxchg_relaxed(v, o, n) \
+	cmpxchg_relaxed(&((v)->counter), (o), (n))
+#define atomic64_cmpxchg_acquire(v, o, n) \
+	cmpxchg_acquire(&((v)->counter), (o), (n))
+
 #define atomic64_xchg(v, new) (xchg(&((v)->counter), new))
 #define atomic64_xchg_relaxed(v, new) xchg_relaxed(&((v)->counter), (new))
 
diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/asm/cmpxchg.h
index 17c7e14..fd4ea04 100644
--- a/arch/powerpc/include/asm/cmpxchg.h
+++ b/arch/powerpc/include/asm/cmpxchg.h
@@ -181,6 +181,48 @@ __cmpxchg_u32_local(volatile unsigned int *p, unsigned long old,
 	return prev;
 }
 
+static __always_inline unsigned long
+__cmpxchg_u32_relaxed(u32 *p, unsigned long old, unsigned long new)
+{
+	unsigned long prev;
+
+	__asm__ __volatile__ (
+"1:	lwarx	%0,0,%2		# __cmpxchg_u32_relaxed\n"
+"	cmpw	0,%0,%3\n"
+"	bne-	2f\n"
+	PPC405_ERR77(0, %2)
+"	stwcx.	%4,0,%2\n"
+"	bne-	1b\n"
+"2:"
+	: "=&r" (prev), "+m" (*p)
+	: "r" (p), "r" (old), "r" (new)
+	: "cc");
+
+	return prev;
+}
+
+static __always_inline unsigned long
+__cmpxchg_u32_acquire(u32 *p, unsigned long old, unsigned long new)
+{
+	unsigned long prev;
+
+	__asm__ __volatile__ (
+"1:	lwarx	%0,0,%2		# __cmpxchg_u32_acquire\n"
+"	cmpw	0,%0,%3\n"
+"	bne-	2f\n"
+	PPC405_ERR77(0, %2)
+"	stwcx.	%4,0,%2\n"
+"	bne-	1b\n"
+	PPC_ACQUIRE_BARRIER
+	"\n"
+"2:"
+	: "=&r" (prev), "+m" (*p)
+	: "r" (p), "r" (old), "r" (new)
+	: "cc", "memory");
+
+	return prev;
+}
+
 #ifdef CONFIG_PPC64
 static __always_inline unsigned long
 __cmpxchg_u64(volatile unsigned long *p, unsigned long old, unsigned long new)
@@ -224,6 +266,46 @@ __cmpxchg_u64_local(volatile unsigned long *p, unsigned long old,
 
 	return prev;
 }
+
+static __always_inline unsigned long
+__cmpxchg_u64_relaxed(u64 *p, unsigned long old, unsigned long new)
+{
+	unsigned long prev;
+
+	__asm__ __volatile__ (
+"1:	ldarx	%0,0,%2		# __cmpxchg_u64_relaxed\n"
+"	cmpd	0,%0,%3\n"
+"	bne-	2f\n"
+"	stdcx.	%4,0,%2\n"
+"	bne-	1b\n"
+"2:"
+	: "=&r" (prev), "+m" (*p)
+	: "r" (p), "r" (old), "r" (new)
+	: "cc");
+
+	return prev;
+}
+
+static __always_inline unsigned long
+__cmpxchg_u64_acquire(u64 *p, unsigned long old, unsigned long new)
+{
+	unsigned long prev;
+
+	__asm__ __volatile__ (
+"1:	ldarx	%0,0,%2		# __cmpxchg_u64_acquire\n"
+"	cmpd	0,%0,%3\n"
+"	bne-	2f\n"
+"	stdcx.	%4,0,%2\n"
+"	bne-	1b\n"
+	PPC_ACQUIRE_BARRIER
+	"\n"
+"2:"
+	: "=&r" (prev), "+m" (*p)
+	: "r" (p), "r" (old), "r" (new)
+	: "cc", "memory");
+
+	return prev;
+}
 #endif
 
 /* This function doesn't exist, so you'll get a linker error
@@ -262,6 +344,37 @@ __cmpxchg_local(volatile void *ptr, unsigned long old, unsigned long new,
 	return old;
 }
 
+static __always_inline unsigned long
+__cmpxchg_relaxed(void *ptr, unsigned long old, unsigned long new,
+		  unsigned int size)
+{
+	switch (size) {
+	case 4:
+		return __cmpxchg_u32_relaxed(ptr, old, new);
+#ifdef CONFIG_PPC64
+	case 8:
+		return __cmpxchg_u64_relaxed(ptr, old, new);
+#endif
+	}
+	__cmpxchg_called_with_bad_pointer();
+	return old;
+}
+
+static __always_inline unsigned long
+__cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
+		  unsigned int size)
+{
+	switch (size) {
+	case 4:
+		return __cmpxchg_u32_acquire(ptr, old, new);
+#ifdef CONFIG_PPC64
+	case 8:
+		return __cmpxchg_u64_acquire(ptr, old, new);
+#endif
+	}
+	__cmpxchg_called_with_bad_pointer();
+	return old;
+}
 #define cmpxchg(ptr, o, n)						 \
   ({									 \
      __typeof__(*(ptr)) _o_ = (o);					 \
@@ -279,6 +392,23 @@ __cmpxchg_local(volatile void *ptr, unsigned long old, unsigned long new,
 				    (unsigned long)_n_, sizeof(*(ptr))); \
   })
 
+#define cmpxchg_relaxed(ptr, o, n)					\
+({									\
+	__typeof__(*(ptr)) _o_ = (o);					\
+	__typeof__(*(ptr)) _n_ = (n);					\
+	(__typeof__(*(ptr))) __cmpxchg_relaxed((ptr),			\
+			(unsigned long)_o_, (unsigned long)_n_,		\
+			sizeof(*(ptr)));				\
+})
+
+#define cmpxchg_acquire(ptr, o, n)					\
+({									\
+	__typeof__(*(ptr)) _o_ = (o);					\
+	__typeof__(*(ptr)) _n_ = (n);					\
+	(__typeof__(*(ptr))) __cmpxchg_acquire((ptr),			\
+			(unsigned long)_o_, (unsigned long)_n_,		\
+			sizeof(*(ptr)));				\
+})
 #ifdef CONFIG_PPC64
 #define cmpxchg64(ptr, o, n)						\
   ({									\
@@ -290,7 +420,16 @@ __cmpxchg_local(volatile void *ptr, unsigned long old, unsigned long new,
 	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
 	cmpxchg_local((ptr), (o), (n));					\
   })
-#define cmpxchg64_relaxed	cmpxchg64_local
+#define cmpxchg64_relaxed(ptr, o, n)					\
+({									\
+	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
+	cmpxchg_relaxed((ptr), (o), (n));				\
+})
+#define cmpxchg64_acquire(ptr, o, n)					\
+({									\
+	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
+	cmpxchg_acquire((ptr), (o), (n));				\
+})
 #else
 #include <asm-generic/cmpxchg-local.h>
 #define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
-- 
2.5.3
