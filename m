Date: Thu, 3 Aug 2000 12:54:28 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Martin Costabel <costabel@wanadoo.fr>, linuxppc-dev@lists.linuxppc.org,
        Iain Sandoe <iain@sandoe.co.uk>
Subject: Re: rtc again...
In-Reply-To: <20000803093049.3478@mailhost.mipsys.com>
Message-ID: <Pine.HPX.4.10.10008031133480.9070-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 3 Aug 2000, Benjamin Herrenschmidt wrote:

>
> >I am using it as module both for 2.2.17-bk and for 2.4.0-test5. They
> >don't give the same time, and I think it is the one in 2.4.0 that is
> >right. I am at GMT+2:00, and the time in 2.2.17 is 2 hours early. When I
> >change /etc/sysconfig/clock from "UTC=false" to "UTC=true", both times
> >shift by 2 hours, but the discrepancy remains.
> >
> >The following patch for bitkeeper linuxppc_2_2 fixes this problem for
> >me. It brings 2.2.17pre13 in line with 2.4.0-test5 (and MacOS). I cannot
> >test the VIAPMU part, so maybe there the offset is necessary, but for
> >the VIACUDA part, it seems wrong.
>
> You patch reverts a fix I made some time ago. Basially, what probably
> happens is that your RTC is in UTC time, not in local time. The Mac RTC
> is supposed to be in local time, the offset corrects the kernel time on
> boot to account for this. Previously, without that fix, the kernel used
> to boot with a bogus UTC time until userland fixes it.

Actually given the problems with RTC being UTC or local time, the offset
might perhaps better be setup as a kernel parameter so that th system
start up in a known good state. It seems that it is in RAM for Macs, but
what about other machines (I have no problems since all my machines are
UTC and I simply refuse to use an OS which requires anything else) ?

Ok, I have since long promised a patch for 2.4 to improve the clock
precision, here it is (relative to kernel.org 2.4.0-test5) but it has only
been tested on my MVME boards. There is still quite a long TODO list I
have added to time.c but at least stability is there on UP machines at
least (it should work perfectly on SMP if timebases are in sync).

I have doubts about 8xx: it won't work if the timebase is really running
below 1 MHz, but you can't expect 1 microsecond resolution timestamps
either in this case. The fix is quite easy however but requires an
additional global variable. And no, I did not change the names of global
variables for fun but to get linker error until the kernel would build.

Note that I have removed the #if 0 to prevent RTC update from Bemjamin,
the code was completely bogus to start with: you should only update the
RTC when STA_UNSYNC is clear, not when it is set. If you are using NTP,
you don't need anything else: set CONFIG_PPC_RTC off, NTP does RTC updates
through adjtimex and this should simply work right out of the box with
this patch, at least it does for me and the clock is very stable.

I still see tremendously large long term drifts (of the order of 1 ppm)
but this is due to the fact that el cheapo crystals on computers are
actually narrowband noise sources and not precision oscillators.

Please test and give feedbcak.

	Gabriel.

===== arch/ppc/kernel/apus_setup.c 1.2 vs 1.3 =====
--- 1.2/arch/ppc/kernel/apus_setup.c	Tue Apr 25 19:58:46 2000
+++ 1.3/arch/ppc/kernel/apus_setup.c	Thu Jul 13 14:06:48 2000
@@ -304,7 +304,7 @@
 void apus_calibrate_decr(void)
 {
 #ifdef CONFIG_APUS
-	int freq, divisor;
+	unsigned long freq;

 	/* This algorithm for determining the bus speed was
            contributed by Ralph Schmidt. */
@@ -335,8 +335,8 @@
 		bus_speed = 60;
 		freq = 15000000;
 	} else if ((bus_speed >= 63) && (bus_speed < 69)) {
-		bus_speed = 66;
-		freq = 16500000;
+		bus_speed = 67;
+		freq = 16666667;
 	} else {
 		printk ("APUS: Unable to determine bus speed (%d). "
 			"Defaulting to 50MHz", bus_speed);
@@ -375,12 +375,10 @@

 	}

-	freq *= 60;	/* try to make freq/1e6 an integer */
-        divisor = 60;
-        printk("time_init: decrementer frequency = %d/%d\n", freq, divisor);
-        decrementer_count = freq / HZ / divisor;
-        count_period_num = divisor;
-        count_period_den = freq / 1000000;
+        printk("time_init: decrementer frequency = %lu.%.6lu MHz\n",
+	       freq/1000000, freq%1000000);
+	tb_ticks_per_jiffy = freq / HZ;
+	tb_to_us = mulhwu_scale_factor(freq, 1000000);

 	__bus_speed = bus_speed;
 	__speed_test_failed = speed_test_failed;
===== arch/ppc/kernel/chrp_time.c 1.3 vs 1.5 =====
--- 1.3/arch/ppc/kernel/chrp_time.c	Mon May 15 16:53:30 2000
+++ 1.5/arch/ppc/kernel/chrp_time.c	Sat Jul 29 19:54:16 2000
@@ -26,7 +26,7 @@
 #include <asm/nvram.h>
 #include <asm/prom.h>
 #include <asm/init.h>
-#include "time.h"
+#include <asm/time.h>

 static int nvram_as1 = NVRAM_AS1;
 static int nvram_as0 = NVRAM_AS0;
@@ -155,8 +155,7 @@
 void __init chrp_calibrate_decr(void)
 {
 	struct device_node *cpu;
-	int *fp, divisor;
-	unsigned long freq;
+	unsigned long freq, *fp;

 	if (via_calibrate_decr())
 		return;
@@ -168,15 +167,13 @@
 	freq = 16666000;		/* hardcoded default */
 	cpu = find_type_devices("cpu");
 	if (cpu != 0) {
-		fp = (int *) get_property(cpu, "timebase-frequency", NULL);
+		fp = (unsigned long *)
+		  	get_property(cpu, "timebase-frequency", NULL);
 		if (fp != 0)
-			freq = *fp;
+		  	freq = *fp;
 	}
-	freq *= 30;
-	divisor = 30;
-        printk("time_init: decrementer frequency = %lu/%d (%ld MHz)\n", freq,
-	       divisor, (freq/divisor)>>20);
-        decrementer_count = freq / HZ / divisor;
-        count_period_num = divisor;
-        count_period_den = freq / 1000000;
+        printk("time_init: decrementer frequency = %lu.%.6lu MHz\n",
+	       freq/1000000, freq%1000000);
+        tb_ticks_per_jiffy = freq / HZ;
+        tb_to_us = mulhwu_scale_factor(freq, 1000000);
 }
===== arch/ppc/kernel/pmac_time.c 1.2 vs 1.5 =====
--- 1.2/arch/ppc/kernel/pmac_time.c	Mon Jun 19 19:59:36 2000
+++ 1.5/arch/ppc/kernel/pmac_time.c	Mon Jul 31 11:28:27 2000
@@ -26,7 +26,8 @@
 #include <asm/pgtable.h>
 #include <asm/machdep.h>

-#include "time.h"
+#include <asm/time.h>
+#include <asm/nvram.h>

 extern rwlock_t xtime_lock;

@@ -54,8 +55,30 @@
 /* Bits in IFR and IER */
 #define T1_INT		0x40		/* Timer 1 interrupt */

-__pmac
+extern struct timezone sys_tz;
+
+__init
+void pmac_time_init(void)
+{
+#ifdef CONFIG_NVRAM
+	s32 delta = 0;
+	int dst;
+
+	delta = ((s32)pmac_xpram_read(PMAC_XPRAM_MACHINE_LOC + 0x9)) << 16;
+	delta |= ((s32)pmac_xpram_read(PMAC_XPRAM_MACHINE_LOC + 0xa)) << 8;
+	delta |= pmac_xpram_read(PMAC_XPRAM_MACHINE_LOC + 0xb);
+	if (delta & 0x00800000UL)
+		delta |= 0xFF000000UL;
+	dst = ((pmac_xpram_read(PMAC_XPRAM_MACHINE_LOC + 0x8) & 0x80) != 0);
+	printk("GMT Delta read from XPRAM: %d minutes, DST: %s\n", delta/60,
+		dst ? "on" : "off");
+	sys_tz.tz_minuteswest = -delta/60;
+	/* I _suppose_ this is 0:off, 1:on */
+	sys_tz.tz_dsttime = dst;
+#endif
+}

+__pmac
 unsigned long pmac_get_rtc_time(void)
 {
 #ifdef CONFIG_ADB
@@ -95,7 +118,39 @@

 int pmac_set_rtc_time(unsigned long nowtime)
 {
-	return 0;
+#ifdef CONFIG_ADB
+	struct adb_request req;
+#endif
+	nowtime += RTC_OFFSET - sys_tz.tz_minuteswest * 60;
+
+	switch (sys_ctrler) {
+#ifdef CONFIG_ADB_CUDA
+	case SYS_CTRLER_CUDA:
+		if (cuda_request(&req, NULL, 6, CUDA_PACKET, CUDA_SET_TIME,
+				 nowtime >> 24, nowtime >> 16, nowtime >> 8, nowtime) < 0)
+			return 0;
+		while (!req.complete)
+			cuda_poll();
+//		if (req.reply_len != 7)
+			printk(KERN_ERR "pmac_set_rtc_time: got %d byte reply\n",
+			       req.reply_len);
+		return 1;
+#endif /* CONFIG_ADB_CUDA */
+#ifdef CONFIG_ADB_PMU
+	case SYS_CTRLER_PMU:
+		if (pmu_request(&req, NULL, 5, PMU_SET_RTC,
+				nowtime >> 24, nowtime >> 16, nowtime >> 8, nowtime) < 0)
+			return 0;
+		while (!req.complete)
+			pmu_poll();
+		if (req.reply_len != 5)
+			printk(KERN_ERR "pmac_set_rtc_time: got %d byte reply\n",
+			       req.reply_len);
+		return 1;
+#endif /* CONFIG_ADB_PMU */
+	default:
+		return 0;
+	}
 }

 /*
@@ -136,12 +191,11 @@
 		;
 	dend = get_dec();

-	decrementer_count = (dstart - dend) / 6;
-	count_period_num = 60;
-	count_period_den = decrementer_count * 6 * HZ / 100000;
+	tb_ticks_per_jiffy = (dstart - dend) / 6;
+	tb_to_us = mulhwu_scale_factor(dstart - dend, 60000);

-	printk(KERN_INFO "via_calibrate_decr: decrementer_count = %u (%u ticks)\n",
-	       decrementer_count, dstart - dend);
+	printk(KERN_INFO "via_calibrate_decr: tb_ticks_per_jiffy = %u (%u ticks)\n",
+	       tb_ticks_per_jiffy, dstart - dend);

 	return 1;
 }
@@ -164,8 +218,10 @@
 	case PBOOK_WAKE:
 		write_lock_irqsave(&xtime_lock, flags);
 		xtime.tv_sec = pmac_get_rtc_time() + time_diff;
+		set_dec(tb_ticks_per_jiffy);
+		/* No PBOOK has a 601 AFAIK, so use get_tbl not binary_tbl  */
+		tb_last_stamp=get_tbl();
 		xtime.tv_usec = 0;
-		set_dec(decrementer_count);
 		last_rtc_update = xtime.tv_sec;
 		write_unlock_irqrestore(&xtime_lock, flags);
 		break;
@@ -186,7 +242,7 @@
 void __init pmac_calibrate_decr(void)
 {
 	struct device_node *cpu;
-	int freq, *fp, divisor;
+	unsigned long freq, *fp;

 #ifdef CONFIG_PMAC_PBOOK
 	pmu_register_sleep_notifier(&time_sleep_notifier);
@@ -202,15 +258,13 @@
 	cpu = find_type_devices("cpu");
 	if (cpu == 0)
 		panic("can't find cpu node in time_init");
-	fp = (int *) get_property(cpu, "timebase-frequency", NULL);
+	fp = (unsigned long *) get_property(cpu, "timebase-frequency", NULL);
 	if (fp == 0)
 		panic("can't get cpu timebase frequency");
-	freq = *fp * 60;	/* try to make freq/1e6 an integer */
-	divisor = 60;
-	printk("time_init: decrementer frequency = %d/%d\n",
-	       freq, divisor);
-	decrementer_count = freq / HZ / divisor;
-	count_period_num = divisor;
-	count_period_den = freq / 1000000;
+	freq = *fp;
+	printk("time_init: decrementer frequency = %lu.%.6lu MHz\n",
+	       freq/1000000, freq%1000000);
+	tb_ticks_per_jiffy = freq / HZ;
+	tb_to_us = mulhwu_scale_factor(freq, 1000000);
 }

===== arch/ppc/kernel/ppc_ksyms.c 1.8 vs 1.10 =====
--- 1.8/arch/ppc/kernel/ppc_ksyms.c	Wed Jul 12 15:20:37 2000
+++ 1.10/arch/ppc/kernel/ppc_ksyms.c	Sat Jul 29 19:54:20 2000
@@ -281,7 +281,7 @@
 EXPORT_SYMBOL(irq_desc);
 void ppc_irq_dispatch_handler(struct pt_regs *, int);
 EXPORT_SYMBOL(ppc_irq_dispatch_handler);
-EXPORT_SYMBOL(decrementer_count);
+EXPORT_SYMBOL(tb_ticks_per_jiffy);
 EXPORT_SYMBOL(get_wchan);
 EXPORT_SYMBOL(console_drivers);
 EXPORT_SYMBOL(console_lock);
===== arch/ppc/kernel/prep_setup.c 1.3 vs 1.5 =====
--- 1.3/arch/ppc/kernel/prep_setup.c	Tue Jun  6 16:52:46 2000
+++ 1.5/arch/ppc/kernel/prep_setup.c	Sat Jul 29 19:54:20 2000
@@ -49,7 +49,7 @@
 #include <asm/raven.h>
 #include <asm/keyboard.h>

-#include "time.h"
+#include <asm/time.h>
 #include "local_irq.h"
 #include "i8259.h"
 #include "open_pic.h"
@@ -377,14 +377,13 @@
  */
 void __init prep_res_calibrate_decr(void)
 {
-	int freq, divisor;
+	unsigned long freq, divisor=4;

 	freq = res->VitalProductData.ProcessorBusHz;
-	divisor = 4;
-	printk("time_init: decrementer frequency = %d/%d\n", freq, divisor);
-	decrementer_count = freq / HZ / divisor;
-	count_period_num = divisor;
-	count_period_den = freq / 1000000;
+	printk("time_init: decrementer frequency = %lu.%.6lu MHz\n",
+	       (freq/divisor)/1000000, (freq/divisor)%1000000);
+	tb_ticks_per_jiffy = freq / HZ / divisor;
+	tb_to_us = mulhwu_scale_factor(freq/divisor, 1000000);
 }

 /*
@@ -393,32 +392,30 @@
  * but on prep we have to figure it out.
  * -- Cort
  */
-int calibrate_done = 0;
-volatile int *done_ptr = &calibrate_done;
+/* Done with 3 interrupts: the first one primes the cache and the
+ * 2 following ones measure the interval. The precision of the method
+ * is still doubtful due to the short interval sampled.
+ */
+static __initdata volatile int calibrate_steps = 3;
+static __initdata unsigned tbstamp;

 void __init
 prep_calibrate_decr_handler(int            irq,
 			    void           *dev,
 			    struct pt_regs *regs)
 {
-	unsigned long freq, divisor;
-	static unsigned long t1 = 0, t2 = 0;
-
-	if ( !t1 )
-		t1 = get_dec();
-	else if (!t2)
-	{
-		t2 = get_dec();
-		t2 = t1-t2;  /* decr's in 1/HZ */
-		t2 = t2*HZ;  /* # decrs in 1s - thus in Hz */
-		freq = t2 * 60;	/* try to make freq/1e6 an integer */
-		divisor = 60;
-		printk("time_init: decrementer frequency = %lu/%lu (%luMHz)\n",
-		       freq, divisor,t2>>20);
-		decrementer_count = freq / HZ / divisor;
-		count_period_num = divisor;
-		count_period_den = freq / 1000000;
-		*done_ptr = 1;
+	unsigned long t, freq;
+	int step=--calibrate_steps;
+
+	t = get_tbl();
+	if (step > 0) {
+		tbstamp = t;
+	} else {
+		freq = (t - tbstamp)*HZ;
+		printk("time_init: decrementer frequency = %lu.%.6lu MHz\n",
+		       freq/1000000, freq%1000000);
+		tb_ticks_per_jiffy = freq / HZ;
+		tb_to_us = mulhwu_scale_factor(freq, 1000000);
 	}
 }

@@ -440,7 +437,7 @@
 	if (request_irq(0, prep_calibrate_decr_handler, 0, "timer", NULL) != 0)
 		panic("Could not allocate timer IRQ!");
 	__sti();
-	while ( ! *done_ptr ) /* nothing */; /* wait for calibrate */
+	while ( calibrate_steps ) /* nothing */; /* wait for calibrate */
         restore_flags(flags);
 	free_irq( 0, NULL);
 }
@@ -449,8 +446,8 @@
 /* We use the NVRAM RTC to time a second to calibrate the decrementer. */
 void __init mk48t59_calibrate_decr(void)
 {
-	unsigned long freq, divisor;
-	unsigned long t1, t2;
+	unsigned long freq;
+	unsigned long t1;
         unsigned char save_control;
         long i;
 	unsigned char sec;
@@ -470,29 +467,31 @@

 	/* Read the seconds value to see when it changes. */
 	sec = ppc_md.nvram_read_val(MK48T59_RTC_SECONDS);
+	/* Actually this is bad for precicion, we should have a loop in
+	 * which we only read the seconds counter. nvram_read_val writes
+	 * the address bytes on every call and this takes a lot of time.
+	 * Perhaps an nvram_wait_change method returning a time
+	 * stamp with a loop count as parameter would be the  solution.
+	 */
 	for (i = 0 ; i < 1000000 ; i++)	{ /* may take up to 1 second... */
+	   t1 = get_tbl();
 	   if (ppc_md.nvram_read_val(MK48T59_RTC_SECONDS) != sec) {
 	      break;
 	   }
 	}
-	t1 = get_dec();

 	sec = ppc_md.nvram_read_val(MK48T59_RTC_SECONDS);
 	for (i = 0 ; i < 1000000 ; i++)	{ /* Should take up 1 second... */
+	   freq = get_tbl()-t1;
 	   if (ppc_md.nvram_read_val(MK48T59_RTC_SECONDS) != sec) {
 	      break;
 	   }
 	}

-	t2 = t1 - get_dec();
-
-	freq = t2 * 60;	/* try to make freq/1e6 an integer */
-	divisor = 60;
-	printk("time_init: decrementer frequency = %lu/%lu (%luMHz)\n",
-	       freq, divisor,t2>>20);
-	decrementer_count = freq / HZ / divisor;
-	count_period_num = divisor;
-	count_period_den = freq / 1000000;
+	printk("time_init: decrementer frequency = %lu.%.6lu MHz\n",
+	       freq/1000000, freq%1000000);
+	tb_ticks_per_jiffy = freq / HZ;
+	tb_to_us = mulhwu_scale_factor(freq, 1000000);
 }

 void __prep
===== arch/ppc/kernel/time.c 1.4 vs 1.7 =====
--- 1.4/arch/ppc/kernel/time.c	Mon Jun 19 19:59:36 2000
+++ 1.7/arch/ppc/kernel/time.c	Wed Aug  2 13:24:39 2000
@@ -5,7 +5,28 @@
  * Written by Cort Dougan (cort@cs.nmt.edu) to merge
  * Paul Mackerras' version and mine for PReP and Pmac.
  * MPC8xx/MBX changes by Dan Malek (dmalek@jlc.net).
+ *
+ * First round of bugfixes by Gabriel Paubert (paubert@iram.es)
+ * to make clock more stable (2.4.0-test5). The only thing
+ * that this code assumes is that the timebases have been synchronized
+ * by firmware on SMP and are never stopped (never do sleep
+ * on SMP then, nap and doze are OK).
+ *
+ * TODO (not necessarily in this file):
+ * - improve precicion and reproducibility of timebase frequency
+ * measurement at boot time.
+ * - get rid of xtime_lock for gettimeofday (generic kernel problem
+ * to be implemented on all architectures for SMP scalability and
+ * eventually implementing gettimeofday without entering the kernel).
+ * - put all time/clock related variables in a single structure
+ * to minimize number of cache lines touched by gettimeofday()
+ * - for astronomical applications: add a new function to get
+ * non ambiguous timestamps even around leap seconds. This needs
+ * a new timestamp format and a good name.
+ *
  *
+ * The following comment is partially obsolete (at least the long wait
+ * is no more a valid reason):
  * Since the MPC8xx has a programmable interrupt timer, I decided to
  * use that rather than the decrementer.  Two reasons: 1.) the clock
  * frequency is low, causing 2.) a long wait in the timer interrupt
@@ -44,24 +65,22 @@
 #include <asm/8xx_immap.h>
 #include <asm/machdep.h>

-#include "time.h"
+#include <asm/time.h>

 void smp_local_timer_interrupt(struct pt_regs *);

 /* keep track of when we need to update the rtc */
-time_t last_rtc_update = 0;
+time_t last_rtc_update;
 extern rwlock_t xtime_lock;

 /* The decrementer counts down by 128 every 128ns on a 601. */
 #define DECREMENTER_COUNT_601	(1000000000 / HZ)
-#define COUNT_PERIOD_NUM_601	1
-#define COUNT_PERIOD_DEN_601	1000

-unsigned decrementer_count;	/* count value for 1e6/HZ microseconds */
-unsigned count_period_num;	/* 1 decrementer count equals */
-unsigned count_period_den;	/* count_period_num / count_period_den us */
-unsigned long last_tb;
+unsigned tb_ticks_per_jiffy;
+unsigned tb_to_us;
+unsigned tb_last_stamp;

+extern unsigned long wall_jiffies;
 /*
  * timer_interrupt - gets called when the decrementer overflows,
  * with interrupts disabled.
@@ -69,8 +88,8 @@
  */
 int timer_interrupt(struct pt_regs * regs)
 {
-	int dval, d;
-	unsigned long flags;
+	int delta;
+	unsigned local_stamp = tb_last_stamp;
 	unsigned long cpu = smp_processor_id();

 	hardirq_enter(cpu);
@@ -95,47 +114,47 @@
 	}
 #endif /* CONFIG_SMP */

-	dval = get_dec();
-	/*
-	 * Wait for the decrementer to change, then jump
-	 * in and add decrementer_count to its value
-	 * (quickly, before it changes again!)
-	 */
-	while ((d = get_dec()) == dval)
-		;
-	asm volatile("mftb 	%0" : "=r" (last_tb) );
-	/*
-	 * Don't play catchup between the call to time_init()
-	 * and sti() in init/main.c.
-	 *
-	 * This also means if we're delayed for > HZ
-	 * we lose those ticks.  If we're delayed for > HZ
-	 * then we have something wrong anyway, though.
-	 *
-	 * -- Cort
+	/* This might fail on 601 SMP systems, are there any out there ?
+	 * The right way to do it might be to add a per CPU timebase stamp
+	 * in the per CPU interrupt structure. Would this be acceptable ?
 	 */
-	if ( d < (-1*decrementer_count) )
-		d = 0;
-	set_dec(d + decrementer_count);
-	if ( !smp_processor_id() )
-	{
+	while ((delta = tb_ticks_per_jiffy-tb_ticks_since(local_stamp)) <=0) {
+
+		local_stamp += tb_ticks_per_jiffy;
+	  	if (smp_processor_id()) continue;
+		/* We are in an interrupt, no need to save/restore flags */
+		write_lock(&xtime_lock);
+		tb_last_stamp = local_stamp;
 		do_timer(regs);
 		/*
-		 * update the rtc when needed
+		 * update the rtc when needed, this should be performed on the
+		 * right fraction of a second. Half or full second ?
+		 * Full second works on mk48t59 clocks, others need testing.
+		 * Note that this update is basically only used through
+		 * the adjtimex system calls. Setting the HW clock in
+		 * any other way is a /dev/rtc and userland business.
+		 * This is still wrong by -0.5/+1.5 jiffies because of the
+		 * timer interrupt resolution and possible delay, but here we
+		 * hit a quantization limit which can only be solved by higher
+		 * resolution timers and decoupling time management from timer
+		 * interrupts.
+		 * We should have an rtc call that only sets the minutes and
+		 * seconds like on Intel to avoid problems with non UTC clocks.
 		 */
-		read_lock_irqsave(&xtime_lock, flags);
-		if ( (time_status & STA_UNSYNC) &&
-		     ((xtime.tv_sec > last_rtc_update + 60) ||
-		      (xtime.tv_sec < last_rtc_update)) )
-		{
-			if (ppc_md.set_rtc_time(xtime.tv_sec) == 0)
-				last_rtc_update = xtime.tv_sec;
+		if ( (time_status & STA_UNSYNC) == 0 &&
+		     xtime.tv_sec - last_rtc_update >= 659 &&
+		     xtime.tv_usec >= 1000000 - 1500000/HZ &&
+		     xtime.tv_usec <= 1000000 - 500000/HZ &&
+		     jiffies-wall_jiffies == 1) {
+		  	if (ppc_md.set_rtc_time(xtime.tv_sec+1) == 0)
+				last_rtc_update = xtime.tv_sec+1;
 			else
-				/* do it again in 60 s */
-				last_rtc_update = xtime.tv_sec;
+				/* Try again one minute later */
+				last_rtc_update += 60;
 		}
-		read_unlock_irqrestore(&xtime_lock, flags);
+		write_unlock(&xtime_lock);
 	}
+	set_dec(delta);
 #ifdef CONFIG_SMP
 	smp_local_timer_interrupt(regs);
 #endif
@@ -152,46 +171,57 @@
  */
 void do_gettimeofday(struct timeval *tv)
 {
-	unsigned long flags, diff;
+	unsigned long flags;
+	unsigned delta, lost_ticks, usec, sec;

-	save_flags(flags);
-	cli();
 	read_lock_irqsave(&xtime_lock, flags);
-	*tv = xtime;
+	sec = xtime.tv_sec;
+	usec = xtime.tv_usec;
+	delta = tb_ticks_since(tb_last_stamp);
+	lost_ticks = jiffies-wall_jiffies;
 	read_unlock_irqrestore(&xtime_lock, flags);
-	/* XXX we don't seem to have the decrementers synced properly yet */
-#ifndef CONFIG_SMP
-	asm volatile("mftb %0" : "=r" (diff) );
-	diff -= last_tb;
-	tv->tv_usec += diff * count_period_num / count_period_den;
-	tv->tv_sec += tv->tv_usec / 1000000;
-	tv->tv_usec = tv->tv_usec % 1000000;
-#endif

-	restore_flags(flags);
+	usec += mulhwu(tb_to_us, tb_ticks_per_jiffy*lost_ticks + delta);
+	while (usec>1000000) {
+	  	sec++;
+		usec -= 1000000;
+	}
+	tv->tv_sec = sec;
+	tv->tv_usec = usec;
 }

 void do_settimeofday(struct timeval *tv)
 {
 	unsigned long flags;
-	int frac_tick;
-
-	last_rtc_update = 0; /* so the rtc gets updated soon */
+	int tv_delta;

-	frac_tick = tv->tv_usec % (1000000 / HZ);
-	save_flags(flags);
-	cli();
 	write_lock_irqsave(&xtime_lock, flags);
-	xtime.tv_sec = tv->tv_sec;
-	xtime.tv_usec = tv->tv_usec - frac_tick;
-	write_unlock_irqrestore(&xtime_lock, flags);
-	set_dec(frac_tick * count_period_den / count_period_num);
+	/* the rtc has to be updated soon but *not* *now* to avoid
+ 	 * introducing random fractional second offsets. Do not attempt the
+ 	 * update before the next second boundary. Actually, it will not
+	 * be updated until STA_UNSYNC is cleared. Note also that
+	 * we don't touch the decrementer since:
+	 * a) it would lose timer interrupt synchronization on SMP
+	 * b) it could make one jiffy spuriously shorter or longer
+	 * which would introduce another source of uncertainty potentially
+	 * harmful to relatively short timers.
+	 * In short, jiffies are always updated at regular intervals
+	 * and it's the clock wall time (xtime) which is adjusted and
+	 * is not always a multiple of 1/Hz seconds.
+	 */
+
+	tv_delta = mulhwu(tb_to_us, tb_ticks_since(tb_last_stamp));
+	xtime.tv_sec = tv->tv_sec - ((tv_delta>tv->tv_usec) ? 1 : 0);
+	xtime.tv_usec = tv->tv_usec + ((tv_delta>tv->tv_usec) ?
+				       1000000 : 0) - tv_delta;
+	last_rtc_update = xtime.tv_sec - 658;
+
 	time_adjust = 0;                /* stop active adjtime() */
 	time_status |= STA_UNSYNC;
 	time_state = TIME_ERROR;        /* p. 24, (a) */
 	time_maxerror = NTP_PHASE_LIMIT;
 	time_esterror = NTP_PHASE_LIMIT;
-	restore_flags(flags);
+	write_unlock_irqrestore(&xtime_lock, flags);
 }


@@ -203,23 +233,23 @@
                 ppc_md.time_init();
         }

-	if ((_get_PVR() >> 16) == 1) {
+	if (__USE_RTC()) {
 		/* 601 processor: dec counts down by 128 every 128ns */
-		decrementer_count = DECREMENTER_COUNT_601;
-		count_period_num = COUNT_PERIOD_NUM_601;
-		count_period_den = COUNT_PERIOD_DEN_601;
+		tb_ticks_per_jiffy = DECREMENTER_COUNT_601;
+		/* mulhwu_scale_factor(1000000000, 1000000) is 0x418937 */
+		tb_to_us = 0x418937;
         } else if (!smp_processor_id()) {
                 ppc_md.calibrate_decr();
 	}

 	write_lock_irqsave(&xtime_lock, flags);
 	xtime.tv_sec = ppc_md.get_rtc_time();
+	tb_last_stamp = get_native_tbl();
+	set_dec(tb_ticks_per_jiffy);
 	xtime.tv_usec = 0;
+	/* No update now, we just read the time from the RTC ! */
+	last_rtc_update = xtime.tv_sec;
 	write_unlock_irqrestore(&xtime_lock, flags);
-
-	set_dec(decrementer_count);
-	/* allow setting the time right away */
-	last_rtc_update = 0;
 }

 /* Converts Gregorian date to seconds since 1970-01-01 00:00:00.
@@ -344,3 +374,37 @@
 	 */
 	GregorianDay(tm);
 }
+
+/* Auxiliary function to compute scaling factors */
+/* Actually the choice of a timebase running at 1/4 the of the bus
+ * frequency giving resolution of a few tens of nanoseconds is quite nice.
+ * It makes this computation very precise (27-28 bits typically) which
+ * is optimistic considering the stability of most processor clock
+ * oscillators and the precision with which the timebase frequency
+ * is measured but does not harm.
+ */
+unsigned mulhwu_scale_factor(unsigned inscale, unsigned outscale) {
+	unsigned mlt=0, tmp, err;
+	/* No concern for performance, it's done once: use a stupid
+	 * but safe and compact method to find the multiplier.
+	 */
+	for (tmp = 1U<<31; tmp != 0; tmp >>= 1) {
+		if (mulhwu(inscale, mlt|tmp) < outscale) mlt|=tmp;
+	}
+	/* We might still be off by 1 for the best approximation.
+	 * A side effect of this is that if outscale is too large
+	 * the returned value will be zero.
+	 * Many corner cases have been checked and seem to work,
+	 * some might have been forgotten in the test however.
+	 * The precision for typical values (outscale is 1 million),
+	 * inscale is between a few millions to a few tens of
+	 * millions is 27-28 bits, which is optimistic about the
+	 * quality of 99.99% CPU clock oscillators (and the precision
+	 * with which the frequency is measured at boot with the current
+	 * setup) but does no harm.
+	 */
+	err = inscale*(mlt+1);
+	if (err <= inscale/2) mlt++;
+	return mlt;
+}
+
===== include/asm-ppc/time.h 1.1 vs 1.4 =====
--- 1.1/arch/ppc/kernel/time.h	Mon Jun  5 16:03:49 2000
+++ 1.4/include/asm-ppc/time.h	Wed Aug  2 13:24:39 2000
@@ -12,9 +12,10 @@
 #include <asm/processor.h>

 /* time.c */
-extern unsigned decrementer_count;
-extern unsigned count_period_num;
-extern unsigned count_period_den;
+extern unsigned tb_ticks_per_jiffy;
+extern unsigned tb_to_us;
+extern unsigned tb_last_stamp;
+
 extern unsigned long mktime(unsigned int, unsigned int, unsigned int,
 			    unsigned int, unsigned int, unsigned int);
 extern void to_tm(int tim, struct rtc_time * tm);
@@ -40,3 +41,73 @@
 	mtspr(SPRN_DEC, val);
 #endif
 }
+
+/* Accessor functions for the timebase (RTC on 601) registers. */
+/* If one day CONFIG_POWER is added just define __USE_RTC as 1 */
+#ifdef CONFIG_6xx
+extern __inline__ int const __USE_RTC(void) {
+	return (mfspr(SPRN_PVR)>>16) == 1;
+}
+#else
+#define __USE_RTC() 0
+#endif
+
+extern __inline__ unsigned long get_tbl(void) {
+	unsigned long tbl;
+	asm volatile("mftb %0" : "=r" (tbl));
+	return tbl;
+}
+
+extern __inline__ unsigned long get_rtcl(void) {
+	unsigned long rtcl;
+	asm volatile("mfrtcl %0" : "=r" (rtcl));
+	return rtcl;
+}
+
+extern __inline__ unsigned get_native_tbl(void) {
+	if (__USE_RTC())
+		return get_rtcl();
+	else
+	  	return get_tbl();
+}
+
+/* On machines with RTC, this function can only be used safely
+ * after the timestamp and for 1 second. It is only used by gettimeofday
+ * however so it should not matter.
+ */
+extern __inline__ unsigned tb_ticks_since(unsigned tstamp) {
+	if (__USE_RTC()) {
+		int delta = get_rtcl() - tstamp;
+		return delta<0 ? delta + 1000000000 : delta;
+	} else {
+        	return get_tbl() - tstamp;
+	}
+}
+
+#if 0
+extern __inline__ unsigned long get_bin_rtcl(void) {
+      unsigned long rtcl, rtcu1, rtcu2;
+      asm volatile("\
+1:    mfrtcu  %0\n\
+      mfrtcl  %1\n\
+      mfrtcu  %2\n\
+      cmpw    %0,%2\n\
+      bne-    1b\n"
+      : "=r" (rtcu1), "=r" (rtcl), "=r" (rtcu2)
+      : : "cr0");
+      return rtcu2*1000000000+rtcl;
+}
+
+extern __inline__ unsigned binary_tbl(void) {
+      if (__USE_RTC())
+              return get_bin_rtcl();
+      else
+              return get_tbl();
+}
+#endif
+
+/* Use mulhwu to scale processor timebase to timeval */
+#define mulhwu(x,y) \
+({unsigned z; asm ("mulhwu %0,%1,%2" : "=r" (z) : "r" (x), "r" (y)); z;})
+
+unsigned mulhwu_scale_factor(unsigned, unsigned);

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
