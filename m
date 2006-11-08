Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 5232667CD5
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Nov 2006 07:37:40 +1100 (EST)
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
To: tglx@linutronix.de
Subject: [PATCH] PowerPC: dynamic tick support
Date: Thu, 9 Nov 2006 00:37:28 +0400
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200611082337.28710.sshtylyov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, greg.weeks@timesys.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add dynamic tick support for PowerPC.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
This patch is reworked against 2.6.18-hrt-dyntick2 patchset.

Known issues:
1) with 2.6.18-hrt-dyntick2, dynamic tick mode causes bootup slowdown after the
    HRT mode is entered (it seems to return to normal shortly);
2) with 2.6.18-rt7 (plus an extra patch to make it actually working :-) in the
   kernel preemption mode other than RT, that slowdown seems permanent (this
   was not happening with 2.6.18-rt6).

I don't have time to investigate now, so anybody interested is welcome to...
or I may even return to this if/when the time permits. :-)

 arch/powerpc/kernel/idle.c |    4 ++++
 1 files changed, 4 insertions(+)

Index: linux-2.6/arch/powerpc/kernel/idle.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/idle.c
+++ linux-2.6/arch/powerpc/kernel/idle.c
@@ -49,6 +49,8 @@ void cpu_idle(void)
 
 	set_thread_flag(TIF_POLLING_NRFLAG);
 	while (1) {
+		hrtimer_stop_sched_tick();
+
 		while (!need_resched() && !cpu_should_die()) {
 			ppc64_runlatch_off();
 
@@ -82,6 +84,8 @@ void cpu_idle(void)
 		ppc64_runlatch_on();
 		if (cpu_should_die())
 			cpu_die();
+
+		hrtimer_restart_sched_tick();
 		preempt_enable_no_resched();
 		schedule();
 		preempt_disable();
