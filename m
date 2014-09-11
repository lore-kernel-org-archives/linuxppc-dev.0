Return-Path: <atomlin@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 834251A0998
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 01:44:09 +1000 (EST)
From: Aaron Tomlin <atomlin@redhat.com>
To: peterz@infradead.org
Subject: [PATCH v3 3/3] sched: BUG when stack end location is over written
Date: Thu, 11 Sep 2014 16:41:28 +0100
Message-Id: <1410450088-18236-4-git-send-email-atomlin@redhat.com>
In-Reply-To: <1410450088-18236-1-git-send-email-atomlin@redhat.com>
References: <1410255749-2956-1-git-send-email-atomlin@redhat.com>
 <1410450088-18236-1-git-send-email-atomlin@redhat.com>
Cc: dzickus@redhat.com, jcastillo@redhat.com, riel@redhat.com, x86@kernel.org,
 akpm@linux-foundation.org, minchan@kernel.org, mingo@kernel.com,
 bmr@redhat.com, prarit@redhat.com, oleg@redhat.com, rostedt@goodmis.org,
 linux-kernel@vger.kernel.org, hannes@cmpxchg.org, mingo@redhat.com,
 aneesh.kumar@linux.vnet.ibm.com, akpm@google.com, atomlin@redhat.com,
 jgh@redhat.com, linuxppc-dev@lists.ozlabs.org, tglx@linutronix.de,
 pzijlstr@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently in the event of a stack overrun a call to schedule()
does not check for this type of corruption. This corruption is
often silent and can go unnoticed. However once the corrupted
region is examined at a later stage, the outcome is undefined
and often results in a sporadic page fault which cannot be
handled.

This patch checks for a stack overrun and takes appropriate
action since the damage is already done, there is no point
in continuing.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/sched/core.c |  3 +++
 lib/Kconfig.debug   | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ec1a286..0b70b73 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2660,6 +2660,9 @@ static noinline void __schedule_bug(struct task_struct *prev)
  */
 static inline void schedule_debug(struct task_struct *prev)
 {
+#ifdef CONFIG_SCHED_STACK_END_CHECK
+	BUG_ON(unlikely(task_stack_end_corrupted(prev)))
+#endif
 	/*
 	 * Test if we are atomic. Since do_exit() needs to call into
 	 * schedule() atomically, we ignore that path. Otherwise whine
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index a285900..2a8280a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -824,6 +824,18 @@ config SCHEDSTATS
 	  application, you can say N to avoid the very slight overhead
 	  this adds.
 
+config SCHED_STACK_END_CHECK
+	bool "Detect stack corruption on calls to schedule()"
+	depends on DEBUG_KERNEL
+	default y
+	help
+	  This option checks for a stack overrun on calls to schedule().
+	  If the stack end location is found to be over written always panic as
+	  the content of the corrupted region can no longer be trusted.
+	  This is to ensure no erroneous behaviour occurs which could result in
+	  data corruption or a sporadic crash at a later stage once the region
+	  is examined. The runtime overhead introduced is minimal.
+
 config TIMER_STATS
 	bool "Collect kernel timers statistics"
 	depends on DEBUG_KERNEL && PROC_FS
-- 
1.9.3
