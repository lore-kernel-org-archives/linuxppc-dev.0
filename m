Return-Path: <boqun.feng@gmail.com>
Received: from mail-oi0-x22b.google.com (mail-oi0-x22b.google.com
 [IPv6:2607:f8b0:4003:c06::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 297411A03F8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Nov 2015 12:31:31 +1100 (AEDT)
Received: by oies66 with SMTP id s66so86800150oie.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Nov 2015 17:31:29 -0800 (PST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Boqun Feng <boqun.feng@gmail.com>, <stable@vger.kernel.org>
Subject: [PATCH powerpc/next 1/2] powerpc: Make value-returning atomics fully
 ordered
Date: Mon,  2 Nov 2015 09:30:31 +0800
Message-Id: <1446427832-8742-1-git-send-email-boqun.feng@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

According to memory-barriers.txt:

> Any atomic operation that modifies some state in memory and returns
> information about the state (old or new) implies an SMP-conditional
> general memory barrier (smp_mb()) on each side of the actual
> operation ...

Which mean these operations should be fully ordered. However on PPC,
PPC_ATOMIC_ENTRY_BARRIER is the barrier before the actual operation,
which is currently "lwsync" if SMP=y. The leading "lwsync" can not
guarantee fully ordered atomics, according to Paul Mckenney:

https://lkml.org/lkml/2015/10/14/970

To fix this, we define PPC_ATOMIC_ENTRY_BARRIER as "sync" to guarantee
the fully-ordered semantics.

This also makes futex atomics fully ordered, which can avoid possible
memory ordering problems if userspace code relies on futex system call
for fully ordered semantics.

Cc: <stable@vger.kernel.org> # 3.4+
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
These two are separated and splited from the patchset of powerpc atomic
variants implementation, whose link is:

https://lkml.org/lkml/2015/10/26/141

Based on next branch of powerpc tree, tested by 0day.

 arch/powerpc/include/asm/synch.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
