Return-Path: <boqun.feng@gmail.com>
Received: from mail-ig0-x22a.google.com (mail-ig0-x22a.google.com
 [IPv6:2607:f8b0:4001:c05::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1637F1A02BD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 02:57:20 +1100 (AEDT)
Received: by igbif5 with SMTP id if5so24079472igb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 08:57:18 -0700 (PDT)
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
Subject: [PATCH tip/locking/core v4 5/6] powerpc: atomic: Implement xchg_* and
 atomic{, 64}_xchg_* variants
Date: Wed, 14 Oct 2015 23:56:00 +0800
Message-Id: <1444838161-17209-6-git-send-email-boqun.feng@gmail.com>
In-Reply-To: <1444838161-17209-1-git-send-email-boqun.feng@gmail.com>
References: <1444838161-17209-1-git-send-email-boqun.feng@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Implement xchg_relaxed and atomic{,64}_xchg_relaxed, based on these
_relaxed variants, release/acquire variants and fully ordered versions
can be built.

Note that xchg_relaxed and atomic_{,64}_xchg_relaxed are not compiler
barriers.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 arch/powerpc/include/asm/atomic.h  |  2 ++
 arch/powerpc/include/asm/cmpxchg.h | 69 +++++++++++++++++---------------------
 2 files changed, 32 insertions(+), 39 deletions(-)

diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index ab76461..1e9d526 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -186,6 +186,7 @@ static __inline__ int atomic_dec_return_relaxed(atomic_t *v)
 
 #define atomic_cmpxchg(v, o, n) (cmpxchg(&((v)->counter), (o), (n)))
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
+#define atomic_xchg_relaxed(v, new) xchg_relaxed(&((v)->counter), (new))
 
 /**
  * __atomic_add_unless - add unless the number is a given value
@@ -453,6 +454,7 @@ static __inline__ long atomic64_dec_if_positive(atomic64_t *v)
 
 #define atomic64_cmpxchg(v, o, n) (cmpxchg(&((v)->counter), (o), (n)))
 #define atomic64_xchg(v, new) (xchg(&((v)->counter), new))
+#define atomic64_xchg_relaxed(v, new) xchg_relaxed(&((v)->counter), (new))
 
 /**
  * atomic64_add_unless - add unless the number is a given value
diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/asm/cmpxchg.h
index d1a8d93..17c7e14 100644
--- a/arch/powerpc/include/asm/cmpxchg.h
+++ b/arch/powerpc/include/asm/cmpxchg.h
@@ -9,21 +9,20 @@
 /*
  * Atomic exchange
  *
- * Changes the memory location '*ptr' to be val and returns
+ * Changes the memory location '*p' to be val and returns
  * the previous value stored there.
  */
+
 static __always_inline unsigned long
-__xchg_u32(volatile void *p, unsigned long val)
+__xchg_u32_local(volatile void *p, unsigned long val)
 {
 	unsigned long prev;
 
 	__asm__ __volatile__(
-	PPC_ATOMIC_ENTRY_BARRIER
 "1:	lwarx	%0,0,%2 \n"
 	PPC405_ERR77(0,%2)
 "	stwcx.	%3,0,%2 \n\
 	bne-	1b"
-	PPC_ATOMIC_EXIT_BARRIER
 	: "=&r" (prev), "+m" (*(volatile unsigned int *)p)
 	: "r" (p), "r" (val)
 	: "cc", "memory");
@@ -31,42 +30,34 @@ __xchg_u32(volatile void *p, unsigned long val)
 	return prev;
 }
 
-/*
- * Atomic exchange
- *
- * Changes the memory location '*ptr' to be val and returns
- * the previous value stored there.
- */
 static __always_inline unsigned long
-__xchg_u32_local(volatile void *p, unsigned long val)
+__xchg_u32_relaxed(u32 *p, unsigned long val)
 {
 	unsigned long prev;
 
 	__asm__ __volatile__(
-"1:	lwarx	%0,0,%2 \n"
-	PPC405_ERR77(0,%2)
-"	stwcx.	%3,0,%2 \n\
-	bne-	1b"
-	: "=&r" (prev), "+m" (*(volatile unsigned int *)p)
+"1:	lwarx	%0,0,%2\n"
+	PPC405_ERR77(0, %2)
+"	stwcx.	%3,0,%2\n"
+"	bne-	1b"
+	: "=&r" (prev), "+m" (*p)
 	: "r" (p), "r" (val)
-	: "cc", "memory");
+	: "cc");
 
 	return prev;
 }
 
 #ifdef CONFIG_PPC64
 static __always_inline unsigned long
-__xchg_u64(volatile void *p, unsigned long val)
+__xchg_u64_local(volatile void *p, unsigned long val)
 {
 	unsigned long prev;
 
 	__asm__ __volatile__(
-	PPC_ATOMIC_ENTRY_BARRIER
 "1:	ldarx	%0,0,%2 \n"
 	PPC405_ERR77(0,%2)
 "	stdcx.	%3,0,%2 \n\
 	bne-	1b"
-	PPC_ATOMIC_EXIT_BARRIER
 	: "=&r" (prev), "+m" (*(volatile unsigned long *)p)
 	: "r" (p), "r" (val)
 	: "cc", "memory");
@@ -75,18 +66,18 @@ __xchg_u64(volatile void *p, unsigned long val)
 }
 
 static __always_inline unsigned long
-__xchg_u64_local(volatile void *p, unsigned long val)
+__xchg_u64_relaxed(u64 *p, unsigned long val)
 {
 	unsigned long prev;
 
 	__asm__ __volatile__(
-"1:	ldarx	%0,0,%2 \n"
-	PPC405_ERR77(0,%2)
-"	stdcx.	%3,0,%2 \n\
-	bne-	1b"
-	: "=&r" (prev), "+m" (*(volatile unsigned long *)p)
+"1:	ldarx	%0,0,%2\n"
+	PPC405_ERR77(0, %2)
+"	stdcx.	%3,0,%2\n"
+"	bne-	1b"
+	: "=&r" (prev), "+m" (*p)
 	: "r" (p), "r" (val)
-	: "cc", "memory");
+	: "cc");
 
 	return prev;
 }
@@ -99,14 +90,14 @@ __xchg_u64_local(volatile void *p, unsigned long val)
 extern void __xchg_called_with_bad_pointer(void);
 
 static __always_inline unsigned long
-__xchg(volatile void *ptr, unsigned long x, unsigned int size)
+__xchg_local(volatile void *ptr, unsigned long x, unsigned int size)
 {
 	switch (size) {
 	case 4:
-		return __xchg_u32(ptr, x);
+		return __xchg_u32_local(ptr, x);
 #ifdef CONFIG_PPC64
 	case 8:
-		return __xchg_u64(ptr, x);
+		return __xchg_u64_local(ptr, x);
 #endif
 	}
 	__xchg_called_with_bad_pointer();
@@ -114,25 +105,19 @@ __xchg(volatile void *ptr, unsigned long x, unsigned int size)
 }
 
 static __always_inline unsigned long
-__xchg_local(volatile void *ptr, unsigned long x, unsigned int size)
+__xchg_relaxed(void *ptr, unsigned long x, unsigned int size)
 {
 	switch (size) {
 	case 4:
-		return __xchg_u32_local(ptr, x);
+		return __xchg_u32_relaxed(ptr, x);
 #ifdef CONFIG_PPC64
 	case 8:
-		return __xchg_u64_local(ptr, x);
+		return __xchg_u64_relaxed(ptr, x);
 #endif
 	}
 	__xchg_called_with_bad_pointer();
 	return x;
 }
-#define xchg(ptr,x)							     \
-  ({									     \
-     __typeof__(*(ptr)) _x_ = (x);					     \
-     (__typeof__(*(ptr))) __xchg((ptr), (unsigned long)_x_, sizeof(*(ptr))); \
-  })
-
 #define xchg_local(ptr,x)						     \
   ({									     \
      __typeof__(*(ptr)) _x_ = (x);					     \
@@ -140,6 +125,12 @@ __xchg_local(volatile void *ptr, unsigned long x, unsigned int size)
      		(unsigned long)_x_, sizeof(*(ptr))); 			     \
   })
 
+#define xchg_relaxed(ptr, x)						\
+({									\
+	__typeof__(*(ptr)) _x_ = (x);					\
+	(__typeof__(*(ptr))) __xchg_relaxed((ptr),			\
+			(unsigned long)_x_, sizeof(*(ptr)));		\
+})
 /*
  * Compare and exchange - if *p == old, set it to new,
  * and return the old value of *p.
-- 
2.5.3
