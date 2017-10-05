Return-Path: <mathieu.desnoyers@efficios.com>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7SH0426tzDqhb
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 09:33:48 +1100 (AEDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Boqun Feng <boqun.feng@gmail.com>, Andrew Hunter <ahh@google.com>,
 Maged Michael <maged.michael@gmail.com>, gromer@google.com,
 Avi Kivity <avi@scylladb.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Dave Watson <davejwatson@fb.com>, Alan Stern <stern@rowland.harvard.edu>,
 Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org
Subject: [RFC PATCH for 4.14 1/2] membarrier: Remove unused code for
 architectures without membarrier hooks
Date: Thu,  5 Oct 2017 18:33:26 -0400
Message-Id: <20171005223327.3500-1-mathieu.desnoyers@efficios.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Architectures without membarrier hooks don't need to emit the
empty membarrier_arch_switch_mm() static inline when
CONFIG_MEMBARRIER=y.

Adapt the CONFIG_MEMBARRIER=n counterpart to only emit the empty
membarrier_arch_switch_mm() for architectures with membarrier hooks.

Reported-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: Andrew Hunter <ahh@google.com>
CC: Maged Michael <maged.michael@gmail.com>
CC: gromer@google.com
CC: Avi Kivity <avi@scylladb.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org>
CC: Michael Ellerman <mpe@ellerman.id.au>
CC: Dave Watson <davejwatson@fb.com>
CC: Alan Stern <stern@rowland.harvard.edu>
CC: Will Deacon <will.deacon@arm.com>
CC: Andy Lutomirski <luto@kernel.org>
CC: Ingo Molnar <mingo@redhat.com>
CC: Alexander Viro <viro@zeniv.linux.org.uk>
CC: linuxppc-dev@lists.ozlabs.org
CC: linux-arch@vger.kernel.org
---
 include/linux/sched/mm.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index d5a9ab8f3836..b2767ecb21a8 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -215,10 +215,6 @@ static inline void memalloc_noreclaim_restore(unsigned int flags)
 #ifdef CONFIG_ARCH_HAS_MEMBARRIER_HOOKS
 #include <asm/membarrier.h>
 #else
-static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
-		struct mm_struct *next, struct task_struct *tsk)
-{
-}
 static inline void membarrier_arch_fork(struct task_struct *t,
 		unsigned long clone_flags)
 {
@@ -247,10 +243,12 @@ static inline void membarrier_execve(struct task_struct *t)
 	membarrier_arch_execve(t);
 }
 #else
+#ifdef CONFIG_ARCH_HAS_MEMBARRIER_HOOKS
 static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
 		struct mm_struct *next, struct task_struct *tsk)
 {
 }
+#endif
 static inline void membarrier_fork(struct task_struct *t,
 		unsigned long clone_flags)
 {
-- 
2.11.0
