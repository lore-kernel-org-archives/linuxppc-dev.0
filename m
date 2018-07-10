Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Q0g86KJCzDqgr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2018 21:42:28 +1000 (AEST)
Date: Tue, 10 Jul 2018 13:42:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-next <linux-next@vger.kernel.org>,
 stephen Rothwell <sfr@canb.auug.org.au>, mpe <mpe@ellerman.id.au>,
 sachinp <sachinp@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] watchdog/softlockup: Fix SOFTLOCKUP_DETECTOR=n build
Message-ID: <20180710114210.GI2476@hirez.programming.kicks-ass.net>
References: <1531129883.6480.7.camel@abdul.in.ibm.com>
 <20180709114716.GN2476@hirez.programming.kicks-ass.net>
 <1531159814.6480.11.camel@abdul.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1531159814.6480.11.camel@abdul.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 09, 2018 at 11:40:14PM +0530, Abdul Haleem wrote:

> Thanks Peter for the patch, build and boot is fine.
> 
> Reported-and-tested-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>

Excellent, Ingo can you stick this in?

---
Subject: watchdog/softlockup: Fix SOFTLOCKUP_DETECTOR=n build
From: Peter Zijlstra <peterz@infradead.org>
Date: Mon, 9 Jul 2018 13:47:16 +0200

I got confused by all the various CONFIG options here about and
conflated CONFIG_LOCKUP_DETECTOR and CONFIG_SOFTLOCKUP_DETECTOR. This
results in a build failure for:

   CONFIG_LOCKUP_DETECTOR=y && CONFIG_SOFTLOCKUP_DETECTOR=n

As reported by Abdul.

Cc: Ingo Molnar <mingo@kernel.org>
Cc: stephen Rothwell <sfr@canb.auug.org.au>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: sachinp <sachinp@linux.vnet.ibm.com>
Cc: mpe <mpe@ellerman.id.au>
Reported-and-tested-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Fixes: 9cf57731b63e ("watchdog/softlockup: Replace "watchdog/%u" threads with cpu_stop_work")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180709114716.GN2476@hirez.programming.kicks-ass.net
---
 include/linux/nmi.h |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -33,15 +33,10 @@ extern int sysctl_hardlockup_all_cpu_bac
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
@@ -50,12 +45,18 @@ extern void touch_softlockup_watchdog(vo
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
