Return-Path: <boqun.feng@gmail.com>
Received: from mail-ob0-x22c.google.com (mail-ob0-x22c.google.com
 [IPv6:2607:f8b0:4003:c01::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C6FB61A0CA9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 01:50:40 +1000 (AEST)
Received: by obqa2 with SMTP id a2so152870932obq.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 08:50:38 -0700 (PDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC v2 6/7] powerpc: atomic: Make atomic{,
 64}_xchg and xchg a full barrier
Date: Wed, 16 Sep 2015 23:49:34 +0800
Message-Id: <1442418575-12297-7-git-send-email-boqun.feng@gmail.com>
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

According to memory-barriers.txt, xchg and its atomic{,64}_ versions
need to imply a full barrier, however they are now just RELEASE+ACQUIRE,
which is not a full barrier.

So remove the definition of xchg(), and let __atomic_op_fence() build
the full-barrier versions of these operations.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 arch/powerpc/include/asm/cmpxchg.h | 64 --------------------------------------
 1 file changed, 64 deletions(-)

diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/asm/cmpxchg.h
index f40f295..9f0379a 100644
--- a/arch/powerpc/include/asm/cmpxchg.h
+++ b/arch/powerpc/include/asm/cmpxchg.h
@@ -12,31 +12,7 @@
  * Changes the memory location '*ptr' to be val and returns
  * the previous value stored there.
  */
-static __always_inline unsigned long
-__xchg_u32(volatile void *p, unsigned long val)
-{
-	unsigned long prev;
 
-	__asm__ __volatile__(
-	PPC_RELEASE_BARRIER
-"1:	lwarx	%0,0,%2 \n"
-	PPC405_ERR77(0,%2)
-"	stwcx.	%3,0,%2 \n\
-	bne-	1b"
-	PPC_ACQUIRE_BARRIER
-	: "=&r" (prev), "+m" (*(volatile unsigned int *)p)
-	: "r" (p), "r" (val)
-	: "cc", "memory");
-
-	return prev;
-}
-
-/*
- * Atomic exchange
- *
- * Changes the memory location '*ptr' to be val and returns
- * the previous value stored there.
- */
 static __always_inline unsigned long
 __xchg_u32_local(volatile void *p, unsigned long val)
 {
@@ -82,25 +58,6 @@ __xchg_u32_relaxed(u32 *p, unsigned long val)
 
 #ifdef CONFIG_PPC64
 static __always_inline unsigned long
-__xchg_u64(volatile void *p, unsigned long val)
-{
-	unsigned long prev;
-
-	__asm__ __volatile__(
-	PPC_RELEASE_BARRIER
-"1:	ldarx	%0,0,%2 \n"
-	PPC405_ERR77(0,%2)
-"	stdcx.	%3,0,%2 \n\
-	bne-	1b"
-	PPC_ACQUIRE_BARRIER
-	: "=&r" (prev), "+m" (*(volatile unsigned long *)p)
-	: "r" (p), "r" (val)
-	: "cc", "memory");
-
-	return prev;
-}
-
-static __always_inline unsigned long
 __xchg_u64_local(volatile void *p, unsigned long val)
 {
 	unsigned long prev;
@@ -142,21 +99,6 @@ __xchg_u64_relaxed(u64 *p, unsigned long val)
 extern void __xchg_called_with_bad_pointer(void);
 
 static __always_inline unsigned long
-__xchg(volatile void *ptr, unsigned long x, unsigned int size)
-{
-	switch (size) {
-	case 4:
-		return __xchg_u32(ptr, x);
-#ifdef CONFIG_PPC64
-	case 8:
-		return __xchg_u64(ptr, x);
-#endif
-	}
-	__xchg_called_with_bad_pointer();
-	return x;
-}
-
-static __always_inline unsigned long
 __xchg_local(volatile void *ptr, unsigned long x, unsigned int size)
 {
 	switch (size) {
@@ -185,12 +127,6 @@ __xchg_relaxed(void *ptr, unsigned long x, unsigned int size)
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
-- 
2.5.1
