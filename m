Return-Path: <anton@ozlabs.org>
Date: Fri, 22 Sep 2006 20:30:14 +1000
From: Anton Blanchard <anton@samba.org>
To: paulus@samba.org
Subject: [PATCH] Always call cede in pseries dedicated idle loop
Message-ID: <20060922103014.GE22420@krispykreme>
References: <20060922082636.GC22420@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060922082636.GC22420@krispykreme>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Not sure what I was thinking, heres something that actually builds.

--

The smt_snooze_delay logic changed a bit when the idle loops were
consolidated. A value of 0 used to mean we always polled, now it means
we always sleep. Instead of restoring the old behaviour, lets put a
reasonable default in smt_snooze_delay. This means we spin for a bit (in
case an external interrupt comes in) and then sleep.

Also the pseries dedicated idle loop currently does not cede both
threads in an SMT pair. The hypervisor wants us to call in so it can
power manage, so lets do that.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: build/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- build.orig/arch/powerpc/platforms/pseries/setup.c	2006-09-22 19:04:56.000000000 +1000
+++ build/arch/powerpc/platforms/pseries/setup.c	2006-09-22 20:21:01.000000000 +1000
@@ -477,7 +477,6 @@ static void pseries_dedicated_idle_sleep
 { 
 	unsigned int cpu = smp_processor_id();
 	unsigned long start_snooze;
-	unsigned long *smt_snooze_delay = &__get_cpu_var(smt_snooze_delay);
 
 	/*
 	 * Indicate to the HV that we are idle. Now would be
@@ -490,9 +489,9 @@ static void pseries_dedicated_idle_sleep
 	 * has been checked recently.  If we should poll for a little
 	 * while, do so.
 	 */
-	if (*smt_snooze_delay) {
+	if (__get_cpu_var(smt_snooze_delay)) {
 		start_snooze = get_tb() +
-			*smt_snooze_delay * tb_ticks_per_usec;
+			__get_cpu_var(smt_snooze_delay) * tb_ticks_per_usec;
 		local_irq_enable();
 		set_thread_flag(TIF_POLLING_NRFLAG);
 
@@ -512,24 +511,7 @@ static void pseries_dedicated_idle_sleep
 			goto out;
 	}
 
-	/*
-	 * If not SMT, cede processor.  If CPU is running SMT
-	 * cede if the other thread is not idle, so that it can
-	 * go single-threaded.  If the other thread is idle,
-	 * we ask the hypervisor if it has pending work it
-	 * wants to do and cede if it does.  Otherwise we keep
-	 * polling in order to reduce interrupt latency.
-	 *
-	 * Doing the cede when the other thread is active will
-	 * result in this thread going dormant, meaning the other
-	 * thread gets to run in single-threaded (ST) mode, which
-	 * is slightly faster than SMT mode with this thread at
-	 * very low priority.  The cede enables interrupts, which
-	 * doesn't matter here.
-	 */
-	if (!cpu_has_feature(CPU_FTR_SMT) || !lppaca[cpu ^ 1].idle
-	    || poll_pending() == H_PENDING)
-		cede_processor();
+	cede_processor();
 
 out:
 	HMT_medium();
Index: build/arch/powerpc/kernel/sysfs.c
===================================================================
--- build.orig/arch/powerpc/kernel/sysfs.c	2006-09-22 20:19:43.000000000 +1000
+++ build/arch/powerpc/kernel/sysfs.c	2006-09-22 20:20:17.000000000 +1000
@@ -25,8 +25,8 @@ static DEFINE_PER_CPU(struct cpu, cpu_de
 /* SMT stuff */
 
 #ifdef CONFIG_PPC_MULTIPLATFORM
-/* default to snooze disabled */
-DEFINE_PER_CPU(unsigned long, smt_snooze_delay);
+/* Time in microseconds we delay before sleeping in the idle loop */
+DEFINE_PER_CPU(unsigned long, smt_snooze_delay) = { 100 };
 
 static ssize_t store_smt_snooze_delay(struct sys_device *dev, const char *buf,
 				      size_t count)
