Return-Path: <boqun.feng@gmail.com>
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com
 [IPv6:2607:f8b0:400e:c03::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BF0D1A0617
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 01:50:49 +1000 (AEST)
Received: by pacex6 with SMTP id ex6so213108759pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 08:50:47 -0700 (PDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC v2 7/7] powerpc: atomic: Make atomic{,
 64}_cmpxchg and cmpxchg a full barrier
Date: Wed, 16 Sep 2015 23:49:35 +0800
Message-Id: <1442418575-12297-8-git-send-email-boqun.feng@gmail.com>
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

According to memory-barriers.txt, cmpxchg and its atomic{,64}_ versions
need to imply a full barrier, however they are now just RELEASE+ACQUIRE,
which is not a full barrier.

So replace PPC_RELEASE_BARRIER and PPC_ACQUIRE_BARRIER with
PPC_ATOMIC_ENTRY_BARRIER and PPC_ATOMIC_EXIT_BARRIER in
__cmpxchg_{u32,u64} respectively to guarantee full-barrier semantics
of atomic{,64}_cmpxchg() and cmpxchg().

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 arch/powerpc/include/asm/cmpxchg.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/asm/cmpxchg.h
index 9f0379a..5c58743 100644
--- a/arch/powerpc/include/asm/cmpxchg.h
+++ b/arch/powerpc/include/asm/cmpxchg.h
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
@@ -239,13 +239,13 @@ __cmpxchg_u64(volatile unsigned long *p, unsigned long old, unsigned long new)
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
2.5.1
