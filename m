Return-Path: <boqun.feng@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1B31D1A09BF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Dec 2015 01:25:24 +1100 (AEDT)
Received: by mail-pa0-x243.google.com with SMTP id fl14so742152pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 06:25:24 -0800 (PST)
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
Subject: [PATCH v6 4/4] powerpc: atomic: Implement acquire/release/relaxed
 variants for cmpxchg
Date: Tue, 15 Dec 2015 22:24:17 +0800
Message-Id: <1450189457-10589-5-git-send-email-boqun.feng@gmail.com>
In-Reply-To: <1450189457-10589-1-git-send-email-boqun.feng@gmail.com>
References: <1450189457-10589-1-git-send-email-boqun.feng@gmail.com>
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

However, we don't do the similar for _release, because that will require
putting barriers in the middle of ll/sc loops, which is probably a bad
idea.

Note cmpxchg{,64}_relaxed and atomic{,64}_cmpxchg_relaxed are not
compiler barriers.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 arch/powerpc/include/asm/atomic.h  |  10 +++
 arch/powerpc/include/asm/cmpxchg.h | 149 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 158 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index 409d3cf..fb8ce7e 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -176,6 +176,11 @@ static __inline__ int atomic_dec_return_relaxed(atomic_t *v)
 #define atomic_dec_return_relaxed atomic_dec_return_relaxed
 
 #define atomic_cmpxchg(v, o, n) (cmpxchg(&((v)->counter), (o), (n)))
+#define atomic_cmpxchg_relaxed(v, o, n) \
+	cmpxchg_relaxed(&((v)->counter), (o), (n))
+#define atomic_cmpxchg_acquire(v, o, n) \
+	cmpxchg_acquire(&((v)->counter), (o), (n))
+
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 #define atomic_xchg_relaxed(v, new) xchg_relaxed(&((v)->counter), (new))
 
@@ -444,6 +449,11 @@ static __inline__ long atomic64_dec_if_positive(atomic64_t *v)
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
index 17c7e14..cae4fa8 100644
--- a/arch/powerpc/include/asm/cmpxchg.h
+++ b/arch/powerpc/include/asm/cmpxchg.h
@@ -181,6 +181,56 @@ __cmpxchg_u32_local(volatile unsigned int *p, unsigned long old,
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
+/*
+ * cmpxchg family don't have order guarantee if cmp part fails, therefore we
+ * can avoid superfluous barriers if we use assembly code to implement
+ * cmpxchg() and cmpxchg_acquire(), however we don't do the similar for
+ * cmpxchg_release() because that will result in putting a barrier in the
+ * middle of a ll/sc loop, which is probably a bad idea. For example, this
+ * might cause the conditional store more likely to fail.
+ */
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
@@ -224,6 +274,46 @@ __cmpxchg_u64_local(volatile unsigned long *p, unsigned long old,
 
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
@@ -262,6 +352,37 @@ __cmpxchg_local(volatile void *ptr, unsigned long old, unsigned long new,
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
@@ -279,6 +400,23 @@ __cmpxchg_local(volatile void *ptr, unsigned long old, unsigned long new,
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
@@ -290,7 +428,16 @@ __cmpxchg_local(volatile void *ptr, unsigned long old, unsigned long new,
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
2.6.4
