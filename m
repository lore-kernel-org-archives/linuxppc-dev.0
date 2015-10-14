Return-Path: <boqun.feng@gmail.com>
Received: from mail-ig0-x22a.google.com (mail-ig0-x22a.google.com
 [IPv6:2607:f8b0:4001:c05::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3F5E01A02AC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 02:56:50 +1100 (AEDT)
Received: by igsu6 with SMTP id u6so20071621igs.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 08:56:48 -0700 (PDT)
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
Subject: [PATCH tip/locking/core v4 1/6] powerpc: atomic: Make *xchg and
 *cmpxchg a full barrier
Date: Wed, 14 Oct 2015 23:55:56 +0800
Message-Id: <1444838161-17209-2-git-send-email-boqun.feng@gmail.com>
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

According to memory-barriers.txt, xchg, cmpxchg and their atomic{,64}_
versions all need to imply a full barrier, however they are now just
RELEASE+ACQUIRE, which is not a full barrier.

So replace PPC_RELEASE_BARRIER and PPC_ACQUIRE_BARRIER with
PPC_ATOMIC_ENTRY_BARRIER and PPC_ATOMIC_EXIT_BARRIER in
__{cmp,}xchg_{u32,u64} respectively to guarantee a full barrier
semantics of atomic{,64}_{cmp,}xchg() and {cmp,}xchg().

This patch is a complement of commit b97021f85517 ("powerpc: Fix
atomic_xxx_return barrier semantics").

Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Cc: <stable@vger.kernel.org> # 3.4+
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 arch/powerpc/include/asm/cmpxchg.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

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
-- 
2.5.3
