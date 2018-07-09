Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41PNqL6SfpzDr0X
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2018 21:47:26 +1000 (AEST)
Date: Mon, 9 Jul 2018 13:47:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-next <linux-next@vger.kernel.org>,
 stephen Rothwell <sfr@canb.auug.org.au>, mpe <mpe@ellerman.id.au>,
 sachinp <sachinp@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [next-20180709][bisected 9cf57731][ppc] build fail with ld: BFD
 version 2.26.1-1.fc25 assertion fail elf64-ppc.c:14734
Message-ID: <20180709114716.GN2476@hirez.programming.kicks-ass.net>
References: <1531129883.6480.7.camel@abdul.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1531129883.6480.7.camel@abdul.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 09, 2018 at 03:21:23PM +0530, Abdul Haleem wrote:
> Greeting's
> 
> Today's next fails to build on powerpc with below error
> 
> kernel/cpu.o:(.data.rel+0x18e0): undefined reference to
> `lockup_detector_online_cpu'
> ld: BFD version 2.26.1-1.fc25 assertion fail elf64-ppc.c:14734
> kernel/cpu.o:(.data.rel+0x18e8): undefined reference to
> `lockup_detector_offline_cpu'
> ld: BFD version 2.26.1-1.fc25 assertion fail elf64-ppc.c:14734
> Makefile:1005: recipe for target 'vmlinux' failed
> make: *** [vmlinux] Error 1

Urgh, sorry about that. I think the below should cure that.

I got confused by all the varioud CONFIG options here abour and
conflated CONFIG_LOCKUP_DETECTOR and CONFIG_SOFTLOCKUP_DETECTOR it
seems.

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
