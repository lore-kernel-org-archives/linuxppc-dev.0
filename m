Date: Mon, 14 Aug 2000 14:59:56 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Paul Mackerras <paulus@linuxcare.com.au>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: rtc again... 
In-Reply-To: <14740.61112.962127.150660@argo.linuxcare.com.au>
Message-ID: <Pine.HPX.4.10.10008141451270.27028-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 12 Aug 2000, Paul Mackerras wrote:

> I merged in your patch and tried it on my 7600/powersurge machine.  It
> seems to work just fine.

Here is the first followup patch, which needs testing, to be applied on
top of the preceding one. This patch corrects 601 handling, cleans up many
other small things, should ensure that no decrementer interrupt is ever
lost on SMP and UP (unless blocked for >1s on 601 or 2^32 TB ticks on
others), and moves the initial time read loop in some get_rtc_time
functions to time_init. Precision on boot still has to be checked.

Booted on an MVME2600...

I'm not going to have time to switch to BK before end of September. Time
handling still needs more cleanups, I hope to do some in the next 2 weeks
but I'm very busy on other fronts.

	Gabriel.

 arch/ppc/kernel/chrp_time.c  |   26 +++++----
 arch/ppc/kernel/pmac_time.c  |    4 -
 arch/ppc/kernel/prep_setup.c |   48 +++++++++-------
 arch/ppc/kernel/prep_time.c  |   44 +++++----------
 arch/ppc/kernel/time.c       |  122 ++++++++++++++++++++++++++++++-------------
 include/asm-ppc/hardirq.h    |    7 ++
 6 files changed, 155 insertions, 96 deletions


diff -Nru a/arch/ppc/kernel/chrp_time.c b/arch/ppc/kernel/chrp_time.c
--- a/arch/ppc/kernel/chrp_time.c	Mon Aug 14 14:48:34 2000
+++ b/arch/ppc/kernel/chrp_time.c	Mon Aug 14 14:48:34 2000
@@ -115,28 +115,34 @@
 unsigned long __chrp chrp_get_rtc_time(void)
 {
 	unsigned int year, mon, day, hour, min, sec;
-	int i;
+	int uip, i;

 	/* The Linux interpretation of the CMOS clock register contents:
 	 * When the Update-In-Progress (UIP) flag goes from 1 to 0, the
 	 * RTC registers show the second which has precisely just started.
 	 * Let's hope other operating systems interpret the RTC the same way.
 	 */
-	/* read RTC exactly on falling edge of update flag */
-	for (i = 0 ; i < 1000000 ; i++)	/* may take up to 1 second... */
-		if (chrp_cmos_clock_read(RTC_FREQ_SELECT) & RTC_UIP)
-			break;
-	for (i = 0 ; i < 1000000 ; i++)	/* must try at least 2.228 ms */
-		if (!(chrp_cmos_clock_read(RTC_FREQ_SELECT) & RTC_UIP))
-			break;
-	do { /* Isn't this overkill ? UIP above should guarantee consistency */
+
+	/* Since the UIP flag is set for about 2.2 ms and the clock
+	 * is typically written with a precision of 1 jiffy, trying
+	 * to obtain a precision better than a few milliseconds is
+	 * an illusion. Only consistency is interesting, this also
+	 * allows to use the routine for /dev/rtc without a potential
+	 * 1 second kernel busy loop triggered by any reader of /dev/rtc.
+	 */
+
+	for ( i = 0; i<1000000; i++) {
+		uip = chrp_cmos_clock_read(RTC_FREQ_SELECT);
 		sec = chrp_cmos_clock_read(RTC_SECONDS);
 		min = chrp_cmos_clock_read(RTC_MINUTES);
 		hour = chrp_cmos_clock_read(RTC_HOURS);
 		day = chrp_cmos_clock_read(RTC_DAY_OF_MONTH);
 		mon = chrp_cmos_clock_read(RTC_MONTH);
 		year = chrp_cmos_clock_read(RTC_YEAR);
-	} while (sec != chrp_cmos_clock_read(RTC_SECONDS));
+		uip |= chrp_cmos_clock_read(RTC_FREQ_SELECT);
+		if ((uip & RTC_UIP)==0) break;
+	}
+
 	if (!(chrp_cmos_clock_read(RTC_CONTROL) & RTC_DM_BINARY) || RTC_ALWAYS_BCD)
 	  {
 	    BCD_TO_BIN(sec);
diff -Nru a/arch/ppc/kernel/pmac_time.c b/arch/ppc/kernel/pmac_time.c
--- a/arch/ppc/kernel/pmac_time.c	Mon Aug 14 14:48:34 2000
+++ b/arch/ppc/kernel/pmac_time.c	Mon Aug 14 14:48:34 2000
@@ -219,8 +219,8 @@
 		write_lock_irqsave(&xtime_lock, flags);
 		xtime.tv_sec = pmac_get_rtc_time() + time_diff;
 		set_dec(tb_ticks_per_jiffy);
-		/* No PBOOK has a 601 AFAIK, so use get_tbl not binary_tbl  */
-		tb_last_stamp=get_tbl();
+		/* No PBOOK has a 601 AFAIK, so use get_tbl, not native */
+		last_jiffy_stamp(0)=tb_last_stamp=get_tbl();
 		xtime.tv_usec = 0;
 		last_rtc_update = xtime.tv_sec;
 		write_unlock_irqrestore(&xtime_lock, flags);
diff -Nru a/arch/ppc/kernel/prep_setup.c b/arch/ppc/kernel/prep_setup.c
--- a/arch/ppc/kernel/prep_setup.c	Mon Aug 14 14:48:34 2000
+++ b/arch/ppc/kernel/prep_setup.c	Mon Aug 14 14:48:34 2000
@@ -442,37 +442,41 @@
 	free_irq( 0, NULL);
 }

+static void __init mk48t59_init(void) {
+	unsigned char tmp;

-/* We use the NVRAM RTC to time a second to calibrate the decrementer. */
+	tmp = ppc_md.nvram_read_val(MK48T59_RTC_CONTROLB);
+	if (tmp & MK48T59_RTC_CB_STOP) {
+		printk("Warning: RTC was stopped, date will be wrong.\n");
+		ppc_md.nvram_write_val(MK48T59_RTC_CONTROLB,
+				       tmp & ~MK48T59_RTC_CB_STOP);
+		/* Low frequency crystal oscillators may take a very long
+		 * time to startup and stabilize. For now just ignore the
+		 * the issue, but attempting to calibrate the decrementer
+		 * from the RTC just after this wakeup is likely to be very
+		 * inaccurate. Firmware should not allow to load
+		 * the OS with the clock stopped anyway...
+		 */
+	}
+	/* Ensure that the clock registers are updated */
+	tmp = ppc_md.nvram_read_val(MK48T59_RTC_CONTROLA);
+	tmp &= ~(MK48T59_RTC_CA_READ | MK48T59_RTC_CA_WRITE);
+	ppc_md.nvram_write_val(MK48T59_RTC_CONTROLA, tmp);
+}
+
+/* We use the NVRAM RTC to time a second to calibrate the decrementer,
+ * the RTC registers have just been set up in the right state by the
+ * preceding routine.
+ */
 void __init mk48t59_calibrate_decr(void)
 {
 	unsigned long freq;
 	unsigned long t1;
-        unsigned char save_control;
         long i;
 	unsigned char sec;

-
-	/* Make sure the time is not stopped. */
-	save_control = ppc_md.nvram_read_val(MK48T59_RTC_CONTROLB);
-
-	ppc_md.nvram_write_val(MK48T59_RTC_CONTROLA,
-			     (save_control & (~MK48T59_RTC_CB_STOP)));
-
-	/* Now make sure the read bit is off so the value will change. */
-	save_control = ppc_md.nvram_read_val(MK48T59_RTC_CONTROLA);
-	save_control &= ~MK48T59_RTC_CA_READ;
-	ppc_md.nvram_write_val(MK48T59_RTC_CONTROLA, save_control);
-
-
 	/* Read the seconds value to see when it changes. */
 	sec = ppc_md.nvram_read_val(MK48T59_RTC_SECONDS);
-	/* Actually this is bad for precicion, we should have a loop in
-	 * which we only read the seconds counter. nvram_read_val writes
-	 * the address bytes on every call and this takes a lot of time.
-	 * Perhaps an nvram_wait_change method returning a time
-	 * stamp with a loop count as parameter would be the  solution.
-	 */
 	for (i = 0 ; i < 1000000 ; i++)	{ /* may take up to 1 second... */
 	   t1 = get_tbl();
 	   if (ppc_md.nvram_read_val(MK48T59_RTC_SECONDS) != sec) {
@@ -805,6 +809,7 @@
 		{
 			ppc_md.set_rtc_time   = mk48t59_set_rtc_time;
 			ppc_md.get_rtc_time   = mk48t59_get_rtc_time;
+			ppc_md.time_init      = mk48t59_init;
 		}
 		else
 		{
@@ -825,6 +830,7 @@
 		ppc_md.set_rtc_time   = mk48t59_set_rtc_time;
 		ppc_md.get_rtc_time   = mk48t59_get_rtc_time;
 		ppc_md.calibrate_decr = mk48t59_calibrate_decr;
+		ppc_md.time_init      = mk48t59_init;
 	}

 #if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
diff -Nru a/arch/ppc/kernel/prep_time.c b/arch/ppc/kernel/prep_time.c
--- a/arch/ppc/kernel/prep_time.c	Mon Aug 14 14:48:34 2000
+++ b/arch/ppc/kernel/prep_time.c	Mon Aug 14 14:48:34 2000
@@ -99,28 +99,34 @@
 unsigned long mc146818_get_rtc_time(void)
 {
 	unsigned int year, mon, day, hour, min, sec;
-	int i;
+	int uip, i;

 	/* The Linux interpretation of the CMOS clock register contents:
 	 * When the Update-In-Progress (UIP) flag goes from 1 to 0, the
 	 * RTC registers show the second which has precisely just started.
 	 * Let's hope other operating systems interpret the RTC the same way.
 	 */
-	/* read RTC exactly on falling edge of update flag */
-	for (i = 0 ; i < 1000000 ; i++)	/* may take up to 1 second... */
-		if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP)
-			break;
-	for (i = 0 ; i < 1000000 ; i++)	/* must try at least 2.228 ms */
-		if (!(CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP))
-			break;
-	do { /* Isn't this overkill ? UIP above should guarantee consistency */
+
+	/* Since the UIP flag is set for about 2.2 ms and the clock
+	 * is typically written with a precision of 1 jiffy, trying
+	 * to obtain a precision better than a few milliseconds is
+	 * an illusion. Only consistency is interesting, this also
+	 * allows to use the routine for /dev/rtc without a potential
+	 * 1 second kernel busy loop triggered by any reader of /dev/rtc.
+	 */
+
+	for ( i = 0; i<1000000; i++) {
+		uip = CMOS_READ(RTC_FREQ_SELECT);
 		sec = CMOS_READ(RTC_SECONDS);
 		min = CMOS_READ(RTC_MINUTES);
 		hour = CMOS_READ(RTC_HOURS);
 		day = CMOS_READ(RTC_DAY_OF_MONTH);
 		mon = CMOS_READ(RTC_MONTH);
 		year = CMOS_READ(RTC_YEAR);
-	} while (sec != CMOS_READ(RTC_SECONDS));
+		uip |= CMOS_READ(RTC_FREQ_SELECT);
+		if ((uip & RTC_UIP)==0) break;
+	}
+
 	if (!(CMOS_READ(RTC_CONTROL) & RTC_DM_BINARY)
 	    || RTC_ALWAYS_BCD)
 	{
@@ -179,26 +185,10 @@
 	unsigned int year, mon, day, hour, min, sec;
 	int i;

-	/* Make sure the time is not stopped. */
-	save_control = ppc_md.nvram_read_val(MK48T59_RTC_CONTROLB);
-
-	ppc_md.nvram_write_val(MK48T59_RTC_CONTROLA,
-			     (save_control & (~MK48T59_RTC_CB_STOP)));
-
-	/* Now make sure the read bit is off so the value will change. */
+	/* Simple: freeze the clock, read it and allow updates again */
 	save_control = ppc_md.nvram_read_val(MK48T59_RTC_CONTROLA);
 	save_control &= ~MK48T59_RTC_CA_READ;
 	ppc_md.nvram_write_val(MK48T59_RTC_CONTROLA, save_control);
-
-	/* Read the seconds value to see when it changes. */
-	sec = ppc_md.nvram_read_val(MK48T59_RTC_SECONDS);
-
-	/* Wait until the seconds value changes, then read the value. */
-	for (i = 0 ; i < 1000000 ; i++)	{ /* may take up to 1 second... */
-	   if (ppc_md.nvram_read_val(MK48T59_RTC_SECONDS) != sec) {
-	      break;
-	   }
-	}

 	/* Set the register to read the value. */
 	ppc_md.nvram_write_val(MK48T59_RTC_CONTROLA,
diff -Nru a/arch/ppc/kernel/time.c b/arch/ppc/kernel/time.c
--- a/arch/ppc/kernel/time.c	Mon Aug 14 14:48:34 2000
+++ b/arch/ppc/kernel/time.c	Mon Aug 14 14:48:34 2000
@@ -81,6 +81,19 @@
 unsigned tb_last_stamp;

 extern unsigned long wall_jiffies;
+
+/* Timer interrupt helper function */
+static inline int tb_delta(unsigned *jiffy_stamp) {
+	int delta;
+	if (__USE_RTC()) {
+		delta = get_rtcl();
+		if (delta < *jiffy_stamp) *jiffy_stamp -= 1000000000;
+		delta -= *jiffy_stamp;
+	} else {
+		delta = get_tbl() - *jiffy_stamp;
+	}
+	return delta;
+}
 /*
  * timer_interrupt - gets called when the decrementer overflows,
  * with interrupts disabled.
@@ -88,9 +101,9 @@
  */
 int timer_interrupt(struct pt_regs * regs)
 {
-	int delta;
-	unsigned local_stamp = tb_last_stamp;
+	int next_dec;
 	unsigned long cpu = smp_processor_id();
+	unsigned jiffy_stamp = last_jiffy_stamp(cpu);

 	hardirq_enter(cpu);
 #ifdef CONFIG_SMP
@@ -114,17 +127,12 @@
 	}
 #endif /* CONFIG_SMP */

-	/* This might fail on 601 SMP systems, are there any out there ?
-	 * The right way to do it might be to add a per CPU timebase stamp
-	 * in the per CPU interrupt structure. Would this be acceptable ?
-	 */
-	while ((delta = tb_ticks_per_jiffy-tb_ticks_since(local_stamp)) <=0) {
-
-		local_stamp += tb_ticks_per_jiffy;
+	do {
+		jiffy_stamp += tb_ticks_per_jiffy;
 	  	if (smp_processor_id()) continue;
 		/* We are in an interrupt, no need to save/restore flags */
 		write_lock(&xtime_lock);
-		tb_last_stamp = local_stamp;
+		tb_last_stamp = jiffy_stamp;
 		do_timer(regs);
 		/*
 		 * update the rtc when needed, this should be performed on the
@@ -137,14 +145,14 @@
 		 * timer interrupt resolution and possible delay, but here we
 		 * hit a quantization limit which can only be solved by higher
 		 * resolution timers and decoupling time management from timer
-		 * interrupts.
+		 * interrupts. This is also wrong on the clocks
+		 * which require being written at the half second boundary.
 		 * We should have an rtc call that only sets the minutes and
 		 * seconds like on Intel to avoid problems with non UTC clocks.
 		 */
 		if ( (time_status & STA_UNSYNC) == 0 &&
 		     xtime.tv_sec - last_rtc_update >= 659 &&
-		     xtime.tv_usec >= 1000000 - 1500000/HZ &&
-		     xtime.tv_usec <= 1000000 - 500000/HZ &&
+		     abs(xtime.tv_usec - (1000000-1000000/HZ)) < 500000/HZ &&
 		     jiffies-wall_jiffies == 1) {
 		  	if (ppc_md.set_rtc_time(xtime.tv_sec+1) == 0)
 				last_rtc_update = xtime.tv_sec+1;
@@ -153,8 +161,9 @@
 				last_rtc_update += 60;
 		}
 		write_unlock(&xtime_lock);
-	}
-	set_dec(delta);
+	} while((next_dec=tb_ticks_per_jiffy-tb_delta(&jiffy_stamp))<0);
+	set_dec(next_dec);
+	last_jiffy_stamp(cpu) = jiffy_stamp;
 #ifdef CONFIG_SMP
 	smp_local_timer_interrupt(regs);
 #endif
@@ -177,7 +186,14 @@
 	read_lock_irqsave(&xtime_lock, flags);
 	sec = xtime.tv_sec;
 	usec = xtime.tv_usec;
+#ifdef CONFIG_SMP
+	/* As long as timebases are not in sync, gettimeofday can only
+	 * have jiffy resolution on SMP.
+	 */
+	delta = 0;
+#else
 	delta = tb_ticks_since(tb_last_stamp);
+#endif
 	lost_ticks = jiffies-wall_jiffies;
 	read_unlock_irqrestore(&xtime_lock, flags);

@@ -193,15 +209,18 @@
 void do_settimeofday(struct timeval *tv)
 {
 	unsigned long flags;
-	int tv_delta;
+	int tb_delta, new_usec, new_sec;

 	write_lock_irqsave(&xtime_lock, flags);
-	/* the rtc has to be updated soon but *not* *now* to avoid
- 	 * introducing random fractional second offsets. Do not attempt the
- 	 * update before the next second boundary. Actually, it will not
-	 * be updated until STA_UNSYNC is cleared. Note also that
+	/* Updating the RTC is not the job of this code. If the time is
+	 * stepped under NTP, the RTC will be update after STA_UNSYNC
+	 * is cleared. Tool like clock/hwclock either copy the RTC
+	 * to the system time, in which case there is no point in writing
+	 * to the RTC again, or write to the RTC but then they don't call
+	 * settimeofday to perform this operation. Note also that
 	 * we don't touch the decrementer since:
 	 * a) it would lose timer interrupt synchronization on SMP
+	 * (if it is working one day)
 	 * b) it could make one jiffy spuriously shorter or longer
 	 * which would introduce another source of uncertainty potentially
 	 * harmful to relatively short timers.
@@ -210,12 +229,26 @@
 	 * is not always a multiple of 1/Hz seconds.
 	 */

-	tv_delta = mulhwu(tb_to_us, tb_ticks_since(tb_last_stamp));
-	xtime.tv_sec = tv->tv_sec - ((tv_delta>tv->tv_usec) ? 1 : 0);
-	xtime.tv_usec = tv->tv_usec + ((tv_delta>tv->tv_usec) ?
-				       1000000 : 0) - tv_delta;
-	last_rtc_update = xtime.tv_sec - 658;
-
+	/* This works perfectly on SMP only if the tb are in sync but
+	 * guarantees an error < 1 jiffy even if they are off by eons,
+	 * still reasonable when gettimeofday resolution is 1 jiffy.
+	 */
+	tb_delta = tb_ticks_since(last_jiffy_stamp(smp_processor_id()));
+	tb_delta += (jiffies-wall_jiffies) * tb_ticks_per_jiffy;
+	new_sec = tv->tv_sec;
+	new_usec = tv->tv_usec - mulhwu(tb_to_us, tb_delta);
+	while (new_usec <0) {
+		new_sec--;
+		new_usec += 1000000;
+	}
+	xtime.tv_usec = new_usec;
+	xtime.tv_sec = new_sec;
+
+	/* In case of a large backwards jump in time with NTP, we want the
+	 * clock to be updated as soon as the PLL is again in lock.
+	 */
+	last_rtc_update = new_sec - 658;
+
 	time_adjust = 0;                /* stop active adjtime() */
 	time_status |= STA_UNSYNC;
 	time_state = TIME_ERROR;        /* p. 24, (a) */
@@ -227,6 +260,9 @@

 void __init time_init(void)
 {
+	time_t sec, old_sec;
+	unsigned old_stamp, stamp, elapsed;
+	/* This function is only called on the boot processor */
 	unsigned long flags;
         if (ppc_md.time_init != NULL)
         {
@@ -238,18 +274,38 @@
 		tb_ticks_per_jiffy = DECREMENTER_COUNT_601;
 		/* mulhwu_scale_factor(1000000000, 1000000) is 0x418937 */
 		tb_to_us = 0x418937;
-        } else if (!smp_processor_id()) {
+        } else {
                 ppc_md.calibrate_decr();
 	}

+	/* Now that the decrementer is calibrated, it can be used in case the
+	 * clock is stuck, but the fact that we have to handle the 601
+	 * makes things more complex. Repeatedly read the RTC until the
+	 * next second boundary to try to achieve some precision...
+	 */
+	stamp = get_native_tbl();
+	sec = ppc_md.get_rtc_time();
+	elapsed = 0;
+	do {
+		old_stamp = stamp;
+		old_sec = sec;
+		stamp = get_native_tbl();
+		if (__USE_RTC() && stamp < old_stamp) old_stamp -= 1000000000;
+		elapsed += stamp - old_stamp;
+		sec = ppc_md.get_rtc_time();
+	} while ( sec == old_sec && elapsed < 2*HZ*tb_ticks_per_jiffy);
+	if (sec==old_sec) {
+		printk("Warning: real time clock seems stuck!\n");
+	}
 	write_lock_irqsave(&xtime_lock, flags);
-	xtime.tv_sec = ppc_md.get_rtc_time();
-	tb_last_stamp = get_native_tbl();
-	set_dec(tb_ticks_per_jiffy);
+	xtime.tv_sec = sec;
+	last_jiffy_stamp(0) = tb_last_stamp = stamp;
 	xtime.tv_usec = 0;
 	/* No update now, we just read the time from the RTC ! */
 	last_rtc_update = xtime.tv_sec;
 	write_unlock_irqrestore(&xtime_lock, flags);
+	/* Not exact, but the timer interrupt takes care of this */
+	set_dec(tb_ticks_per_jiffy);
 }

 /* Converts Gregorian date to seconds since 1970-01-01 00:00:00.
@@ -396,12 +452,6 @@
 	 * the returned value will be zero.
 	 * Many corner cases have been checked and seem to work,
 	 * some might have been forgotten in the test however.
-	 * The precision for typical values (outscale is 1 million),
-	 * inscale is between a few millions to a few tens of
-	 * millions is 27-28 bits, which is optimistic about the
-	 * quality of 99.99% CPU clock oscillators (and the precision
-	 * with which the frequency is measured at boot with the current
-	 * setup) but does no harm.
 	 */
 	err = inscale*(mlt+1);
 	if (err <= inscale/2) mlt++;
diff -Nru a/include/asm-ppc/hardirq.h b/include/asm-ppc/hardirq.h
--- a/include/asm-ppc/hardirq.h	Mon Aug 14 14:48:34 2000
+++ b/include/asm-ppc/hardirq.h	Mon Aug 14 14:48:34 2000
@@ -5,16 +5,23 @@
 #include <asm/smp.h>

 /* entry.S is sensitive to the offsets of these fields */
+/* The __last_jiffy_stamp field is needed to ensure that no decrementer
+ * interrupt is lost on SMP machines. Since on most CPUs it is in the same
+ * cache line as local_irq_count, it is cheap to access and is also used on UP
+ * for uniformity.
+ */
 typedef struct {
 	unsigned int __softirq_active;
 	unsigned int __softirq_mask;
 	unsigned int __local_irq_count;
 	unsigned int __local_bh_count;
 	unsigned int __syscall_count;
+	unsigned int __last_jiffy_stamp;
 } ____cacheline_aligned irq_cpustat_t;

 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */

+#define last_jiffy_stamp(cpu) __IRQ_STAT((cpu), __last_jiffy_stamp)
 /*
  * Are we in an interrupt context? Either doing bottom half
  * or hardware interrupt processing?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
