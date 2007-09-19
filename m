Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 2EACBDDE1C
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 16:51:35 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
From: Tony Breeds <tony@bakeyournoodle.com>
Date: Wed, 19 Sep 2007 16:49:48 +1000
Subject: [PATCH 5/5] Enable tickless idle and high res timers for powerpc
In-Reply-To: <1190184586.867449.381310088392.qpush@thor>
Message-Id: <20070919064948.0C43E399915@thor>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>

---

 arch/powerpc/Kconfig                   |    1 +
 arch/powerpc/kernel/idle.c             |    3 +++
 arch/powerpc/platforms/iseries/setup.c |    5 +++++
 3 files changed, 9 insertions(+)

Index: working/arch/powerpc/Kconfig
===================================================================
--- working.orig/arch/powerpc/Kconfig
+++ working/arch/powerpc/Kconfig
@@ -168,6 +168,7 @@ config HIGHMEM
 	bool "High memory support"
 	depends on PPC32
 
+source kernel/time/Kconfig
 source kernel/Kconfig.hz
 source kernel/Kconfig.preempt
 source "fs/Kconfig.binfmt"
Index: working/arch/powerpc/kernel/idle.c
===================================================================
--- working.orig/arch/powerpc/kernel/idle.c
+++ working/arch/powerpc/kernel/idle.c
@@ -24,6 +24,7 @@
 #include <linux/smp.h>
 #include <linux/cpu.h>
 #include <linux/sysctl.h>
+#include <linux/tick.h>
 
 #include <asm/system.h>
 #include <asm/processor.h>
@@ -59,6 +60,7 @@ void cpu_idle(void)
 
 	set_thread_flag(TIF_POLLING_NRFLAG);
 	while (1) {
+		tick_nohz_stop_sched_tick();
 		while (!need_resched() && !cpu_should_die()) {
 			ppc64_runlatch_off();
 
@@ -90,6 +92,7 @@ void cpu_idle(void)
 
 		HMT_medium();
 		ppc64_runlatch_on();
+		tick_nohz_restart_sched_tick();
 		if (cpu_should_die())
 			cpu_die();
 		preempt_enable_no_resched();
Index: working/arch/powerpc/platforms/iseries/setup.c
===================================================================
--- working.orig/arch/powerpc/platforms/iseries/setup.c
+++ working/arch/powerpc/platforms/iseries/setup.c
@@ -26,6 +26,7 @@
 #include <linux/major.h>
 #include <linux/root_dev.h>
 #include <linux/kernel.h>
+#include <linux/tick.h>
 
 #include <asm/processor.h>
 #include <asm/machdep.h>
@@ -562,6 +563,7 @@ static void yield_shared_processor(void)
 static void iseries_shared_idle(void)
 {
 	while (1) {
+		tick_nohz_stop_sched_tick();
 		while (!need_resched() && !hvlpevent_is_pending()) {
 			local_irq_disable();
 			ppc64_runlatch_off();
@@ -575,6 +577,7 @@ static void iseries_shared_idle(void)
 		}
 
 		ppc64_runlatch_on();
+		tick_nohz_restart_sched_tick();
 
 		if (hvlpevent_is_pending())
 			process_iSeries_events();
@@ -590,6 +593,7 @@ static void iseries_dedicated_idle(void)
 	set_thread_flag(TIF_POLLING_NRFLAG);
 
 	while (1) {
+		tick_nohz_stop_sched_tick();
 		if (!need_resched()) {
 			while (!need_resched()) {
 				ppc64_runlatch_off();
@@ -606,6 +610,7 @@ static void iseries_dedicated_idle(void)
 		}
 
 		ppc64_runlatch_on();
+		tick_nohz_restart_sched_tick();
 		preempt_enable_no_resched();
 		schedule();
 		preempt_disable();
