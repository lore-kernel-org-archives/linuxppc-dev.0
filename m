Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 3DE2A67D1C
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Nov 2006 08:05:25 +1100 (EST)
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
To: tglx@linutronix.de
Subject: [PATCH] PowerPC: clockevents and HRT support
Date: Wed, 8 Nov 2006 01:05:08 +0400
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200611080005.08633.sshtylyov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, greg.weeks@timesys.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add PowerPC decrementer clock event driver and enable HRT.
Every effort has been made to support the different implementations of the
decrementer: the classic one (with 970 series variation), 40x and Book E
specific ones.

I had to make CONFIG_GENERIC_CLOCKEVENTS option selectable for the
compatibility reasons -- this option is not compatible with the PPC64
deterministic time accounting.

Thanks to Daniel Walker and Thomas Gleixner for suggestions they made...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
This patch has been reworked against 2.6.18-hrt-dyntick2 patchset and
tested on the classic and Book E 32-bit CPUs.

CONFIG_PPC_MULTIPLATFORM was the best option I was able to come up with
to cover machines built on 970 series CPU...

 arch/powerpc/Kconfig       |   13 ++++
 arch/powerpc/kernel/time.c |  121 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 133 insertions(+), 1 deletion(-)

Index: linux-2.6/arch/powerpc/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/Kconfig
+++ linux-2.6/arch/powerpc/Kconfig
@@ -281,7 +281,7 @@ config PPC_STD_MMU_32
 
 config VIRT_CPU_ACCOUNTING
 	bool "Deterministic task and CPU time accounting"
-	depends on PPC64
+	depends on PPC64 && !GENERIC_CLOCKEVENTS
 	default y
 	help
 	  Select this option to enable more accurate task and CPU time
@@ -599,6 +599,17 @@ config HIGHMEM
 	depends on PPC32
 
 source kernel/Kconfig.hz
+
+config GENERIC_CLOCKEVENTS
+	bool "Clock event devices support"
+	default n
+	help
+	  Enable support for the clock event devices necessary for the
+	  high-resolution timers and the tickless system support.
+	  NOTE: This is not compatible with the deterministic time accounting
+	  option on PPC64.
+
+source kernel/time/Kconfig
 source kernel/Kconfig.preempt
 source "fs/Kconfig.binfmt"
 
Index: linux-2.6/arch/powerpc/kernel/time.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/time.c
+++ linux-2.6/arch/powerpc/kernel/time.c
@@ -51,6 +51,7 @@
 #include <linux/rtc.h>
 #include <linux/jiffies.h>
 #include <linux/posix-timers.h>
+#include <linux/clockchips.h>
 
 #include <asm/io.h>
 #include <asm/processor.h>
@@ -124,6 +125,80 @@ unsigned long ppc_tb_freq;
 static u64 tb_last_jiffy __cacheline_aligned_in_smp;
 static DEFINE_PER_CPU(u64, last_jiffy);
 
+#ifdef CONFIG_GENERIC_CLOCKEVENTS
+
+#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+#define DECREMENTER_MAX 0xffffffff
+#else
+#define DECREMENTER_MAX 0x7fffffff /* setting MSB triggers an interrupt */
+#endif
+
+struct decrementer_device {
+       struct clock_event_device device;
+       int mode;
+};
+
+static void decrementer_set_next_event(unsigned long evt,
+				       struct clock_event_device *dev)
+{
+#if defined(CONFIG_40x)
+	mtspr(SPRN_PIT, evt);	/* 40x has a hidden PIT auto-reload register */
+#elif defined(CONFIG_BOOKE)
+	mtspr(SPRN_DECAR, evt); /* Book E  has separate auto-reload register */
+	set_dec(evt);
+#else
+	set_dec(evt - 1);	/* Classic decrementer interrupts at -1 */
+#endif
+}
+
+static void decrementer_set_mode(enum	clock_event_mode mode,
+				 struct clock_event_device *dev)
+{
+	struct decrementer_device *decrementer;
+#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+	u32 tcr = mfspr(SPRN_TCR);
+
+	if (mode == CLOCK_EVT_PERIODIC)
+		tcr |=  TCR_ARE;
+	else
+		tcr &= ~TCR_ARE;
+
+	mtspr(SPRN_TCR, tcr);
+#endif
+	decrementer = container_of(dev, struct decrementer_device, device);
+	decrementer->mode = mode;
+
+	if (mode == CLOCK_EVT_PERIODIC)
+		decrementer_set_next_event(tb_ticks_per_jiffy, dev);
+}
+
+static struct clock_event_device decrementer_template = {
+	.name		= "decrementer",
+	.capabilities	= CLOCK_CAP_PROFILE | CLOCK_CAP_UPDATE |
+			  CLOCK_CAP_NEXTEVT,
+	.shift		= 32,
+	.set_mode	= decrementer_set_mode,
+	.set_next_event	= decrementer_set_next_event,
+};
+
+static DEFINE_PER_CPU(struct decrementer_device, decrementers);
+
+static void register_decrementer(void)
+{
+	int cpu = smp_processor_id();
+	struct decrementer_device *decrementer = &per_cpu(decrementers, cpu);
+
+	decrementer->device = decrementer_template;
+
+	/* We only want do_timer() to be called on a boot CPU. */
+	if (cpu == boot_cpuid) 
+		decrementer->device.capabilities |= CLOCK_CAP_TICK;
+
+	register_local_clockevent(&decrementer->device);
+}
+
+#endif /* CONFIG_GENERIC_CLOCKEVENTS */
+
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 /*
  * Factors for converting from cputime_t (timebase ticks) to
@@ -340,6 +415,9 @@ void snapshot_timebase(void)
 {
 	__get_cpu_var(last_jiffy) = get_tb();
 	snapshot_purr();
+#ifdef CONFIG_GENERIC_CLOCKEVENTS
+	register_decrementer();
+#endif
 }
 
 void __delay(unsigned long loops)
@@ -495,7 +573,28 @@ void timer_interrupt(struct pt_regs * re
 
 	irq_enter();
 
+#ifdef CONFIG_GENERIC_CLOCKEVENTS
+#ifdef CONFIG_PPC_MULTIPLATFORM
+	/*
+	 * We must write a positive value to the decrementer to clear
+	 * the interrupt on the IBM 970 CPU series.  In periodic mode,
+	 * this happens when the decrementer gets reloaded later, but
+	 * in one-shot mode, we have to do it here since an event handler
+	 * may skip loading the new value...
+	 */
+	if (per_cpu(decrementers, cpu).mode != CLOCK_EVT_PERIODIC)
+		set_dec(DECREMENTER_MAX);
+#endif
+	/*
+	 * We can't disable the decrementer, so in the period between
+	 * CPU being marked offline and calling stop-self, it's taking
+	 * timer interrupts...
+	 */
+	if (!cpu_is_offline(cpu))
+		per_cpu(decrementers, cpu).device.event_handler(regs);
+#else
 	profile_tick(CPU_PROFILING, regs);
+#endif
 	calculate_steal_time();
 
 #ifdef CONFIG_PPC_ISERIES
@@ -510,6 +609,7 @@ void timer_interrupt(struct pt_regs * re
 		if (__USE_RTC() && per_cpu(last_jiffy, cpu) >= 1000000000)
 			per_cpu(last_jiffy, cpu) -= 1000000000;
 
+#ifndef CONFIG_GENERIC_CLOCKEVENTS
 		/*
 		 * We cannot disable the decrementer, so in the period
 		 * between this cpu's being marked offline in cpu_online_map
@@ -519,6 +619,7 @@ void timer_interrupt(struct pt_regs * re
 		 */
 		if (!cpu_is_offline(cpu))
 			account_process_time(regs);
+#endif
 
 		/*
 		 * No need to check whether cpu is offline here; boot_cpuid
@@ -531,14 +632,23 @@ void timer_interrupt(struct pt_regs * re
 		tb_next_jiffy = tb_last_jiffy + tb_ticks_per_jiffy;
 		if (per_cpu(last_jiffy, cpu) >= tb_next_jiffy) {
 			tb_last_jiffy = tb_next_jiffy;
+#ifndef CONFIG_GENERIC_CLOCKEVENTS
 			do_timer(1);
+#endif
 			timer_check_rtc();
 		}
 		write_sequnlock(&xtime_lock);
 	}
 	
 	next_dec = tb_ticks_per_jiffy - ticks;
+#ifdef CONFIG_GENERIC_CLOCKEVENTS
+#if !defined(CONFIG_40x) && !defined(CONFIG_BOOKE)
+	if (per_cpu(decrementers, cpu).mode == CLOCK_EVT_PERIODIC)
+		set_dec(next_dec - 1);
+#endif
+#else
 	set_dec(next_dec);
+#endif
 
 #ifdef CONFIG_PPC_ISERIES
 	if (hvlpevent_is_pending())
@@ -787,8 +897,19 @@ void __init time_init(void)
 	tb_to_ns_scale = scale;
 	tb_to_ns_shift = shift;
 
+#ifdef CONFIG_GENERIC_CLOCKEVENTS
+	decrementer_template.mult = div_sc(ppc_tb_freq, NSEC_PER_SEC,
+					   decrementer_template.shift);
+	decrementer_template.max_delta_ns =
+		clockevent_delta2ns(DECREMENTER_MAX, &decrementer_template);
+	decrementer_template.min_delta_ns =
+		clockevent_delta2ns(0xf, &decrementer_template);
+
+	register_decrementer();
+#else
 	/* Not exact, but the timer interrupt takes care of this */
 	set_dec(tb_ticks_per_jiffy);
+#endif
 }
 
 #define FEBRUARY	2
