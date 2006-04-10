Return-Path: <vatsa@in.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AFF0B67AC6
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2006 22:20:46 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3ACKh6u003335
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2006 08:20:43 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3ACO06e183560
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2006 06:24:00 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k3ACKhFI004782
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2006 06:20:43 -0600
Date: Mon, 10 Apr 2006 17:48:47 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/2] tickless idle cpus: core patch - v2
Message-ID: <20060410121847.GB5564@in.ibm.com>
References: <20060407063044.GA22416@in.ibm.com>
	<17462.61423.42032.559627@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17462.61423.42032.559627@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: vatsa@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is the v2 of the core patch to skip ticks when a CPU is idle.
Changes since v1:

	-  fix the buggy call to stop_hz_timer in idle_power4.S (hopefully it 
	   is correct now!).
	-  Dont allow boot cpu to skip ticks (a follow-on patch will
	   remove this restriction)

Signed-off-by: Srivatsa Vaddagiri <vatsa@in.ibm.com>

---

 linux-2.6.17-rc1-root/arch/powerpc/Kconfig                   |    6 
 linux-2.6.17-rc1-root/arch/powerpc/kernel/idle_power4.S      |    5 
 linux-2.6.17-rc1-root/arch/powerpc/kernel/irq.c              |    3 
 linux-2.6.17-rc1-root/arch/powerpc/kernel/time.c             |  143 +++++++++--
 linux-2.6.17-rc1-root/arch/powerpc/kernel/traps.c            |    1 
 linux-2.6.17-rc1-root/arch/powerpc/platforms/pseries/setup.c |    6 
 linux-2.6.17-rc1-root/include/asm-powerpc/time.h             |    8 
 7 files changed, 147 insertions(+), 25 deletions(-)

diff -puN arch/powerpc/kernel/time.c~no_idle_hz arch/powerpc/kernel/time.c
--- linux-2.6.17-rc1/arch/powerpc/kernel/time.c~no_idle_hz	2006-04-09 10:40:58.000000000 +0530
+++ linux-2.6.17-rc1-root/arch/powerpc/kernel/time.c	2006-04-10 14:32:04.000000000 +0530
@@ -633,40 +633,97 @@ static void iSeries_tb_recal(void)
 }
 #endif
 
-/*
- * For iSeries shared processors, we have to let the hypervisor
- * set the hardware decrementer.  We set a virtual decrementer
- * in the lppaca and call the hypervisor if the virtual
- * decrementer is less than the current value in the hardware
- * decrementer. (almost always the new decrementer value will
- * be greater than the current hardware decementer so the hypervisor
- * call will not be needed)
- */
+#ifdef CONFIG_NO_IDLE_HZ
 
-/*
- * timer_interrupt - gets called when the decrementer overflows,
- * with interrupts disabled.
+static void account_ticks(struct pt_regs *regs);
+
+/* Returns 1 if this CPU was set in the mask */
+static inline int clear_hzless_mask(void)
+{
+	int cpu = smp_processor_id();
+	int rc = 0;
+
+	if (unlikely(cpu_isset(cpu, nohz_cpu_mask))) {
+		cpu_clear(cpu, nohz_cpu_mask);
+		rc = 1;
+	}
+
+	return rc;
+}
+
+#define MAX_DEC_COUNT	UINT_MAX	/* Decrementer is 32-bit */
+static int min_skip = 2;		/* Minimum number of ticks to skip */
+static int max_skip;			/* Maximum number of ticks to skip */
+
+
+int sysctl_hz_timer = 1;
+
+/* Defer timer interrupt for as long as possible. This is accomplished by
+ * programming the decrementer to a suitable value such that it raises the
+ * exception after desired interval. This features allows CPUs to
+ * be used more efficiently in virtualized environments and/or allows for
+ * lower power consumption.
+ *
+ * Called with interrupts disabled on an idle CPU. Caller has to ensure that
+ * idle loop is not exited w/o start_hz_timer being called via an interrupt
+ * to restore timer interrupt frequency.
  */
-void timer_interrupt(struct pt_regs * regs)
+
+void stop_hz_timer(void)
 {
+	unsigned long cpu = smp_processor_id(), seq, delta;
 	int next_dec;
-	int cpu = smp_processor_id();
-	unsigned long ticks;
 
-#ifdef CONFIG_PPC32
-	if (atomic_read(&ppc_n_lost_interrupts) != 0)
-		do_IRQ(regs);
-#endif
+	if (sysctl_hz_timer != 0 || cpu == boot_cpuid)
+		return;
 
-	irq_enter();
+	cpu_set(cpu, nohz_cpu_mask);
+	mb();
+	if (rcu_pending(cpu) || local_softirq_pending()) {
+		cpu_clear(cpu, nohz_cpu_mask);
+		return;
+	}
 
-	profile_tick(CPU_PROFILING, regs);
-	calculate_steal_time();
+	do {
+		seq = read_seqbegin(&xtime_lock);
 
-#ifdef CONFIG_PPC_ISERIES
-	get_lppaca()->int_dword.fields.decr_int = 0;
+		delta = next_timer_interrupt() - jiffies;
+
+		if (delta < min_skip) {
+			cpu_clear(cpu, nohz_cpu_mask);
+			return;
+		}
+
+		if (delta > max_skip)
+			delta = max_skip;
+
+		next_dec = tb_last_stamp + delta * tb_ticks_per_jiffy;
+
+	} while (read_seqretry(&xtime_lock, seq));
+
+	next_dec -= get_tb();
+	set_dec(next_dec);
+
+	return;
+}
+
+/* Take into account skipped ticks and restore the HZ timer frequency */
+void start_hz_timer(struct pt_regs *regs)
+{
+	if (clear_hzless_mask())
+		account_ticks(regs);
+}
+
+#else
+static inline int clear_hzless_mask(void) { return 0;}
 #endif
 
+static void account_ticks(struct pt_regs *regs)
+{
+	int next_dec;
+	int cpu = smp_processor_id();
+	unsigned long ticks;
+
 	while ((ticks = tb_ticks_since(per_cpu(last_jiffy, cpu)))
 	       >= tb_ticks_per_jiffy) {
 		/* Update last_jiffy */
@@ -703,6 +760,41 @@ void timer_interrupt(struct pt_regs * re
 	
 	next_dec = tb_ticks_per_jiffy - ticks;
 	set_dec(next_dec);
+}
+
+/*
+ * For iSeries shared processors, we have to let the hypervisor
+ * set the hardware decrementer.  We set a virtual decrementer
+ * in the lppaca and call the hypervisor if the virtual
+ * decrementer is less than the current value in the hardware
+ * decrementer. (almost always the new decrementer value will
+ * be greater than the current hardware decementer so the hypervisor
+ * call will not be needed)
+ */
+
+/*
+ * timer_interrupt - gets called when the decrementer overflows,
+ * with interrupts disabled.
+ */
+void timer_interrupt(struct pt_regs * regs)
+{
+#ifdef CONFIG_PPC32
+	if (atomic_read(&ppc_n_lost_interrupts) != 0)
+		do_IRQ(regs);
+#endif
+
+	irq_enter();
+
+	clear_hzless_mask();
+
+	profile_tick(CPU_PROFILING, regs);
+	calculate_steal_time();
+
+#ifdef CONFIG_PPC_ISERIES
+	get_lppaca()->int_dword.fields.decr_int = 0;
+#endif
+
+	account_ticks(regs);
 
 #ifdef CONFIG_PPC_ISERIES
 	if (hvlpevent_is_pending())
@@ -957,6 +1049,9 @@ void __init time_init(void)
 	tb_ticks_per_usec = ppc_tb_freq / 1000000;
 	tb_to_us = mulhwu_scale_factor(ppc_tb_freq, 1000000);
 	calc_cputime_factors();
+#ifdef CONFIG_NO_IDLE_HZ
+	max_skip = __USE_RTC() ? HZ : MAX_DEC_COUNT / tb_ticks_per_jiffy;
+#endif
 
 	/*
 	 * Calculate the length of each tick in ns.  It will not be
diff -puN arch/powerpc/kernel/irq.c~no_idle_hz arch/powerpc/kernel/irq.c
--- linux-2.6.17-rc1/arch/powerpc/kernel/irq.c~no_idle_hz	2006-04-09 10:40:58.000000000 +0530
+++ linux-2.6.17-rc1-root/arch/powerpc/kernel/irq.c	2006-04-09 10:40:59.000000000 +0530
@@ -60,6 +60,7 @@
 #ifdef CONFIG_PPC_ISERIES
 #include <asm/paca.h>
 #endif
+#include <asm/time.h>
 
 int __irq_offset_value;
 #ifdef CONFIG_PPC32
@@ -189,6 +190,8 @@ void do_IRQ(struct pt_regs *regs)
 
         irq_enter();
 
+	start_hz_timer(regs);
+
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
 	/* Debugging check for stack overflow: is there less than 2KB free? */
 	{
diff -puN include/asm-powerpc/time.h~no_idle_hz include/asm-powerpc/time.h
--- linux-2.6.17-rc1/include/asm-powerpc/time.h~no_idle_hz	2006-04-09 10:40:59.000000000 +0530
+++ linux-2.6.17-rc1-root/include/asm-powerpc/time.h	2006-04-09 10:40:59.000000000 +0530
@@ -198,6 +198,14 @@ static inline unsigned long tb_ticks_sin
 	return get_tbl() - tstamp;
 }
 
+#ifdef CONFIG_NO_IDLE_HZ
+extern void stop_hz_timer(void);
+extern void start_hz_timer(struct pt_regs *);
+#else
+static inline void stop_hz_timer(void) { }
+static inline void start_hz_timer(struct pt_regs *regs) { }
+#endif
+
 #define mulhwu(x,y) \
 ({unsigned z; asm ("mulhwu %0,%1,%2" : "=r" (z) : "r" (x), "r" (y)); z;})
 
diff -puN arch/powerpc/Kconfig~no_idle_hz arch/powerpc/Kconfig
--- linux-2.6.17-rc1/arch/powerpc/Kconfig~no_idle_hz	2006-04-09 10:40:59.000000000 +0530
+++ linux-2.6.17-rc1-root/arch/powerpc/Kconfig	2006-04-09 10:40:59.000000000 +0530
@@ -593,6 +593,12 @@ config HOTPLUG_CPU
 
 	  Say N if you are unsure.
 
+config NO_IDLE_HZ
+	depends on EXPERIMENTAL && (PPC_PSERIES || PPC_PMAC || PPC_MAPLE)
+	bool "Switch off timer ticks on idle CPUs"
+	help
+	  Switches the HZ timer interrupts off when a CPU is idle.
+
 config KEXEC
 	bool "kexec system call (EXPERIMENTAL)"
 	depends on PPC_MULTIPLATFORM && EXPERIMENTAL
diff -puN arch/powerpc/kernel/traps.c~no_idle_hz arch/powerpc/kernel/traps.c
--- linux-2.6.17-rc1/arch/powerpc/kernel/traps.c~no_idle_hz	2006-04-09 10:40:59.000000000 +0530
+++ linux-2.6.17-rc1-root/arch/powerpc/kernel/traps.c	2006-04-09 10:40:59.000000000 +0530
@@ -875,6 +875,7 @@ void altivec_unavailable_exception(struc
 
 void performance_monitor_exception(struct pt_regs *regs)
 {
+	start_hz_timer(regs);
 	perf_irq(regs);
 }
 
diff -puN arch/powerpc/platforms/pseries/setup.c~no_idle_hz arch/powerpc/platforms/pseries/setup.c
--- linux-2.6.17-rc1/arch/powerpc/platforms/pseries/setup.c~no_idle_hz	2006-04-09 10:40:59.000000000 +0530
+++ linux-2.6.17-rc1-root/arch/powerpc/platforms/pseries/setup.c	2006-04-09 10:40:59.000000000 +0530
@@ -463,8 +463,10 @@ static void pseries_dedicated_idle_sleep
 	 * very low priority.  The cede enables interrupts, which
 	 * doesn't matter here.
 	 */
-	if (!lppaca[cpu ^ 1].idle || poll_pending() == H_PENDING)
+	if (!lppaca[cpu ^ 1].idle || poll_pending() == H_PENDING) {
+		stop_hz_timer();
 		cede_processor();
+	}
 
 out:
 	HMT_medium();
@@ -479,6 +481,8 @@ static void pseries_shared_idle_sleep(vo
 	 */
 	get_lppaca()->idle = 1;
 
+	stop_hz_timer();
+
 	/*
 	 * Yield the processor to the hypervisor.  We return if
 	 * an external interrupt occurs (which are driven prior
diff -puN arch/powerpc/kernel/idle_power4.S~no_idle_hz arch/powerpc/kernel/idle_power4.S
--- linux-2.6.17-rc1/arch/powerpc/kernel/idle_power4.S~no_idle_hz	2006-04-09 10:40:59.000000000 +0530
+++ linux-2.6.17-rc1-root/arch/powerpc/kernel/idle_power4.S	2006-04-10 14:50:36.000000000 +0530
@@ -30,6 +30,11 @@ END_FTR_SECTION_IFCLR(CPU_FTR_CAN_NAP)
 	cmpwi	0,r4,0
 	beqlr
 
+	mflr	r0
+	std	r0,16(r1)
+	bl	.stop_hz_timer
+	ld	r0,16(r1)
+	mtlr	r0
 	/* Go to NAP now */
 BEGIN_FTR_SECTION
 	DSSALL

_

-- 
Regards,
vatsa
