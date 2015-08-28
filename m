Return-Path: <boqun.feng@gmail.com>
Received: from mail-io0-x233.google.com (mail-io0-x233.google.com
 [IPv6:2607:f8b0:4001:c06::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 300791A01ED
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2015 12:49:05 +1000 (AEST)
Received: by iods203 with SMTP id s203so79184637iod.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 19:49:02 -0700 (PDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC 4/5] powerpc: atomic: implement xchg_* and atomic{,
 64}_xchg_* variants
Date: Fri, 28 Aug 2015 10:48:18 +0800
Message-Id: <1440730099-29133-5-git-send-email-boqun.feng@gmail.com>
In-Reply-To: <1440730099-29133-1-git-send-email-boqun.feng@gmail.com>
References: <1440730099-29133-1-git-send-email-boqun.feng@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Implement xchg_relaxed and define atomic{,64}_xchg_* as xchg_relaxed,
based on these _relaxed variants, release/acquire variants can be built.

Note that xchg_relaxed and atomic_{,64}_xchg_relaxed are not compiler
barriers.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 arch/powerpc/include/asm/atomic.h  |  2 ++
 arch/powerpc/include/asm/cmpxchg.h | 64 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index 806ce50..4965dcf 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -193,6 +193,7 @@ static __inline__ int atomic_dec_return(atomic_t *v)
 
 #define atomic_cmpxchg(v, o, n) (cmpxchg(&((v)->counter), (o), (n)))
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
+#define atomic_xchg_relaxed(v, new) xchg_relaxed(&((v)->counter), (new))
 
 /**
  * __atomic_add_unless - add unless the number is a given value
@@ -461,6 +462,7 @@ static __inline__ long atomic64_dec_if_positive(atomic64_t *v)
 
 #define atomic64_cmpxchg(v, o, n) (cmpxchg(&((v)->counter), (o), (n)))
 #define atomic64_xchg(v, new) (xchg(&((v)->counter), new))
+#define atomic64_xchg_relaxed(v, new) xchg_relaxed(&((v)->counter), (new))
 
 /**
  * atomic64_add_unless - add unless the number is a given value
diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/asm/cmpxchg.h
index ad6263c..66374f4 100644
--- a/arch/powerpc/include/asm/cmpxchg.h
+++ b/arch/powerpc/include/asm/cmpxchg.h
@@ -54,6 +54,32 @@ __xchg_u32_local(volatile void *p, unsigned long val)
 	return prev;
 }
 
+/*
+ * Atomic exchange relaxed
+ *
+ * Changes the memory location '*p' to be val and returns
+ * the previous value stored there.
+ *
+ * Note that this is not a compiler barrier, there is no order
+ * guarantee around.
+ */
+static __always_inline unsigned long
+__xchg_u32_relaxed(u32 *p, unsigned long val)
+{
+	unsigned long prev;
+
+	__asm__ __volatile__(
+"1:	lwarx	%0,0,%2\n"
+	PPC405_ERR77(0, %2)
+"	stwcx.	%3,0,%2\n"
+"	bne-	1b"
+	: "=&r" (prev), "+m" (*p)
+	: "r" (p), "r" (val)
+	: "cc");
+
+	return prev;
+}
+
 #ifdef CONFIG_PPC64
 static __always_inline unsigned long
 __xchg_u64(volatile void *p, unsigned long val)
@@ -90,6 +116,23 @@ __xchg_u64_local(volatile void *p, unsigned long val)
 
 	return prev;
 }
+
+static __always_inline unsigned long
+__xchg_u64_relaxed(u64 *p, unsigned long val)
+{
+	unsigned long prev;
+
+	__asm__ __volatile__(
+"1:	ldarx	%0,0,%2\n"
+	PPC405_ERR77(0, %2)
+"	stdcx.	%3,0,%2\n"
+"	bne-	1b"
+	: "=&r" (prev), "+m" (*p)
+	: "r" (p), "r" (val)
+	: "cc");
+
+	return prev;
+}
 #endif
 
 /*
@@ -127,6 +170,21 @@ __xchg_local(volatile void *ptr, unsigned long x, unsigned int size)
 	__xchg_called_with_bad_pointer();
 	return x;
 }
+
+static __always_inline unsigned long
+__xchg_relaxed(void *ptr, unsigned long x, unsigned int size)
+{
+	switch (size) {
+	case 4:
+		return __xchg_u32_relaxed(ptr, x);
+#ifdef CONFIG_PPC64
+	case 8:
+		return __xchg_u64_relaxed(ptr, x);
+#endif
+	}
+	__xchg_called_with_bad_pointer();
+	return x;
+}
 #define xchg(ptr,x)							     \
   ({									     \
      __typeof__(*(ptr)) _x_ = (x);					     \
@@ -140,6 +198,12 @@ __xchg_local(volatile void *ptr, unsigned long x, unsigned int size)
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
2.5.0
