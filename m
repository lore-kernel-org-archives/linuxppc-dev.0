Return-Path: <tipbot@zytor.com>
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Q7h83nNjzDr0d
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2018 02:58:47 +1000 (AEST)
Date: Tue, 10 Jul 2018 09:00:55 -0700
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-aef92a8bed25d03b8f03ce499a56e8e8e5e2c05e@git.kernel.org>
Cc: mingo@kernel.org, hpa@zytor.com, torvalds@linux-foundation.org,
 peterz@infradead.org, sfr@canb.auug.org.au, sachinp@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
 mpe@ellerman.id.au, tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org,
 abdhalee@linux.vnet.ibm.com
Reply-To: mpe@ellerman.id.au, linux-next@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, abdhalee@linux.vnet.ibm.com,
 tglx@linutronix.de, hpa@zytor.com, torvalds@linux-foundation.org,
 peterz@infradead.org, mingo@kernel.org, sachinp@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, sfr@canb.auug.org.au
In-Reply-To: <20180710114210.GI2476@hirez.programming.kicks-ass.net>
References: <20180710114210.GI2476@hirez.programming.kicks-ass.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] watchdog/softlockup: Fix the SOFTLOCKUP_DETECTOR=n
 build
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit-ID:  aef92a8bed25d03b8f03ce499a56e8e8e5e2c05e
Gitweb:     https://git.kernel.org/tip/aef92a8bed25d03b8f03ce499a56e8e8e5e2c05e
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Tue, 10 Jul 2018 13:42:10 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 10 Jul 2018 17:56:22 +0200

watchdog/softlockup: Fix the SOFTLOCKUP_DETECTOR=n build

I got confused by all the various CONFIG options here about and
conflated CONFIG_LOCKUP_DETECTOR and CONFIG_SOFTLOCKUP_DETECTOR.

This results in a build failure for:

   CONFIG_LOCKUP_DETECTOR=y && CONFIG_SOFTLOCKUP_DETECTOR=n

As reported by Abdul.

Reported-and-tested-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-next <linux-next@vger.kernel.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: mpe <mpe@ellerman.id.au>
Cc: sachinp <sachinp@linux.vnet.ibm.com>
Cc: stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 9cf57731b63e ("watchdog/softlockup: Replace "watchdog/%u" threads with cpu_stop_work")
Link: http://lkml.kernel.org/r/20180710114210.GI2476@hirez.programming.kicks-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/nmi.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 80664bbeca43..08f9247e9827 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -33,15 +33,10 @@ extern int sysctl_hardlockup_all_cpu_backtrace;
 #define sysctl_hardlockup_all_cpu_backtrace 0
 #endif /* !CONFIG_SMP */
 
-extern int lockup_detector_online_cpu(unsigned int cpu);
-extern int lockup_detector_offline_cpu(unsigned int cpu);
-
 #else /* CONFIG_LOCKUP_DETECTOR */
 static inline void lockup_detector_init(void) { }
 static inline void lockup_detector_soft_poweroff(void) { }
 static inline void lockup_detector_cleanup(void) { }
-#define lockup_detector_online_cpu	NULL
-#define lockup_detector_offline_cpu	NULL
 #endif /* !CONFIG_LOCKUP_DETECTOR */
 
 #ifdef CONFIG_SOFTLOCKUP_DETECTOR
@@ -50,12 +45,18 @@ extern void touch_softlockup_watchdog(void);
 extern void touch_softlockup_watchdog_sync(void);
 extern void touch_all_softlockup_watchdogs(void);
 extern unsigned int  softlockup_panic;
-#else
+
+extern int lockup_detector_online_cpu(unsigned int cpu);
+extern int lockup_detector_offline_cpu(unsigned int cpu);
+#else /* CONFIG_SOFTLOCKUP_DETECTOR */
 static inline void touch_softlockup_watchdog_sched(void) { }
 static inline void touch_softlockup_watchdog(void) { }
 static inline void touch_softlockup_watchdog_sync(void) { }
 static inline void touch_all_softlockup_watchdogs(void) { }
-#endif
+
+#define lockup_detector_online_cpu	NULL
+#define lockup_detector_offline_cpu	NULL
+#endif /* CONFIG_SOFTLOCKUP_DETECTOR */
 
 #ifdef CONFIG_DETECT_HUNG_TASK
 void reset_hung_task_detector(void);
