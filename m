Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yDCRT38lVzDrBX
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Oct 2017 03:12:37 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9DG6WYu036656
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Oct 2017 12:12:35 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2djym7u6na-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Oct 2017 12:12:35 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Fri, 13 Oct 2017 12:12:33 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, mathieu.desnoyers@efficios.com, peterz@infradead.org,
 boqun.feng@gmail.com, ahh@google.com, maged.michael@gmail.com,
 gromer@google.com, avi@scylladb.com, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, davejwatson@fb.com,
 stern@rowland.harvard.edu, will.deacon@arm.com, luto@kernel.org,
 viro@zeniv.linux.org.uk, piggin@gmail.com, linux-arch@vger.kernel.org,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@redhat.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH tip/sched/membarrier 4/5] membarrier: Remove unused code for
 architectures without membarrier hooks
Date: Fri, 13 Oct 2017 09:12:24 -0700
In-Reply-To: <20171012170051.GA27468@linux.vnet.ibm.com>
References: <20171012170051.GA27468@linux.vnet.ibm.com>
Message-Id: <1507911145-4134-4-git-send-email-paulmck@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

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
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 include/linux/sched/mm.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index e4955d293687..40379edac388 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -221,10 +221,6 @@ static inline void memalloc_noreclaim_restore(unsigned int flags)
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
@@ -253,10 +249,12 @@ static inline void membarrier_execve(struct task_struct *t)
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
2.5.2
