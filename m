Date: Wed, 14 Jun 2000 15:32:28 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Takashi Oe <toe@unlserve.unl.edu>
cc: Andreas Tobler <toa@pop.agri.ch>,
        Linux -Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 7200 & bitkeeper/linuxcare devel?
In-Reply-To: <Pine.LNX.3.96LJ1.1b7.1000602162200.22680A-101000@ofey.inetnebr.com>
Message-ID: <Pine.HPX.4.10.10006061131110.1970-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


[Sorry, this is long, but I've been experimenting quite a lot on this
subject recently]

On Fri, 2 Jun 2000, Takashi Oe wrote:

> Hi,
>
> On Fri, 2 Jun 2000, Andreas Tobler wrote:
>
> > Hi,
> > has anyone gotten a bitkeeper 2.4.0test1-ac7 or a linuxcare 2.3.99p9 to
> > boot under a 7200?
>
> I think I know why the kernel fails to boot on your machine.  I had to get
> around this problem for my current project.  I've sent a patch for it to
> Paul about a week ago, but, so far, nothing happened yet.  Just in case,
> the same patch is attached here.
>
> In your last post, you had a xmon log which said something like ".....
> vector: 700 ....", and I infer that kernel died with program check
> exception.
>
> Anyway, in arch/ppc/kernel/time.c, timer_interrupt() and do_gettimeofday()
> use "mftb" instruction which is not implemented in PPC 601, hence, the
> exception.  The patch workarounds this, but, personally, I feel the
> previous implementation which just used DEC register was better than my
> patch or the current one when all PPCs are considered.

Is it just me or is using the timebase in _this_ way completely wrong.
AFAIU, the code just stores the timebase during the timer interrupt and
assumes that it happens precisely at a given time of the day. i.e. it does
not account for the delay in taking the interrupt which may be quite long
if several interrupts are pending (the decrementer has a lower priorit
than external interrupts in PPC machines).

Background: I've been chasing a problem of varying clock drift as measured
by NTP. My machine is using a reference clock input from a GPS receiver
and what I see is that the /etc/ntp/drift varies from ~-10 ppm to ~+10ppm
and this is strongly correlated to the load on the machine.

This 20ppm variation might not seem much (actually it is),  but:

a) it actually causes considerable clock errors (I have seen from -6 to +6
ms) since the NTP PLL is designed to compensate for long term drifts and
takes several hours to converge (which is normal given the characteristics
of normal crystals).

b) it is (literally) astronomically large for my applications. I have
reference clocks with interfaces giving high precision and microsecond
resolution which allow me to investigate these problems.

c) the error is not due to a change of the cpu clock frequency (or rather
its crystal) with temperature or anything else... I have plotted the
frequency of the time base versus a reference clock (sampling it every 10
seconds but averaging over 900s in the end) and the peak to peak variation
over 3 days is below 0.3 ppm. This means that I lose something like 2
orders of magnitude in precision (and likely more since most of the
remaining drifts are within the loop bandwidth of NTP).

Finally it appears it is due to subtle external interferences in the
decrementer reload code. Actually waiting for the decrementer to change
before incrementing it the next interval is bogus in the presence of cache
misses when you consider the code:

# loop waiting for the decrementer to change
  30:  7d 76 02 a6 mfdec r11
  34:  7c 0b 00 00 cmpw r11,r0
  38:  41 82 ff f8 beq 30 <timer_interrupt+0x30>
# now update the decrementer
  3c:  3d 20 00 00 lis r9,0
                        3e: R_PPC_ADDR16_HA decrementer_count>
  40:  80 09 00 00 lwz r0,0(r9)
                        42: R_PPC_ADDR16_LO decrementer_count>
  44:  7c 0b 02 14 add r0,r11,r0
  48:  7c 16 03 a6 mtdec r0
  4c:  7f 83 e3 78 mr      r3,r28

The time to access decrementer_count obviously depends on whether it is
found in the L1 cache, L2 cache or main memory. On a busy machine the
delay of a cache miss may be large (and the likelyness of having to fetch
another cache line for the mtdec instruction is ~50%). So it's not
unexpected to reach a difference of 200 nS between a cache hit and cache
miss (i.e. a loaded versus idle machine). Actually this jitter of ~200 nS
would not be so serious if it would not accumulate over time to give
offsets of several milliseconds before NTP starts to react.

The solution I have implemented is to use the timebase as a reference,
using the value of the time base at a jiffy boundary as a reference for
gettimeofday and friends. Update this value (which is a global variable)
at every decrementer interrupt. The 601 introduces some complications due
to the fact it uses different registers and that the low 32 bits only
count up to 10^9 but they are fairly easy to solve.

After the patch is applied, I still see some frequency drift but they are
clearly proportional to the timebase/cpu/pci/bus frequency from other
measurements. It does not actually mean that the timebase is good: the
16.66 MHz timebase still changes by by a huge ~10 Hz=0.6ppm between a
loaded and an idle machine but this is due to physical effects (slight
change in voltage or internal EMI with the rest of the motherboard when
the CPU/PCI/memory bus is busy) and also slow drifts (~0.2 ppm probably of
thermal origin).

Still on the TODO list:

- chrp_calibrate_decr and pmac_calibrate_decr are so similar
that they should be fused into one routine. Having neither mac nor
CHRP, I did not do it.

- Check on SMP machine that the time is now correctly synchronized,
I did not remove the #ifndef __SMP__ since I can't test it but it should
work now.

- Find all remaining bugs, and optimize even more :-)

The patch also tries to provide a more precise measurement of the
decrementer frequency, but I still don't understand why this measurement
occasionally gave tremendous differences between boots: most of the boot
time decrementer frequency measurements gave similar results, but I
occasionally got a value differing by ~500ppm, which is _large_ by any
standard (2 seconds per hour), and plays havoc with both adjtime and NTP.
I have not seen this problem again since I've implemented the patch, but I
don't yet have enough samples to decide whether it is solved or not
(I'd rather say that it is not solved).

Finally the patch provides a faster gettimeofday (no division, a single
mulhwu instruction is used) and corrects a few bugs.

What this patch could help to provide in the future is higher resolution
timers (effectively giving the impression of a higher HZ) almost for free
which could be interesting for realtime applications. Actually the per
processor decrementer is the right thing to implement this because it
allows to decouple the time management from the timers (it might require a
timer queue per processor to limit cache line ping-pongs on SMP).

Ok, I've already been too verbose, so for the people who have had the
courage to read all the preceding, here is the patch (for 2.2.12 between 2
bitkeeper revisions with bk cset -Rx1..x2|bk diffs -u - so don't be
surprised by "directory" names), it probably does not apply cleanly
(without fuzz at least) to official sources given the changes in my source
tree.

If there is popular demand, I shall distill a 2.4.0test1 patch (plain
2.4.0-test1 works on my MVME boards since Monday but I would prefer to
send other patches first given the growing divergence between my sources
and the official ones).

	Gabriel.

===== arch/ppc/kernel/apus_setup.c 1.1 vs 1.2 =====
--- 1.1/arch/ppc/kernel/apus_setup.c	Sat Jun 10 23:58:37 2000
+++ 1.2/arch/ppc/kernel/apus_setup.c	Wed Jun 14 15:10:46 2000
@@ -163,7 +163,7 @@

 void apus_calibrate_decr(void)
 {
-	int freq, divisor;
+	unsigned long freq;

 	/* This algorithm for determining the bus speed was
            contributed by Ralph Schmidt. */
@@ -193,8 +193,8 @@
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
@@ -228,10 +228,10 @@

 	freq *= 60;	/* try to make freq/1e6 an integer */
         divisor = 60;
-        printk("time_init: decrementer frequency = %d/%d\n", freq, divisor);
-        decrementer_count = freq / HZ / divisor;
-        count_period_num = divisor;
-        count_period_den = freq / 1000000;
+        printk("time_init: decrementer frequency = %lu.%.6lu MHz\n",
+	       freq/1000000, freq%1000000);
+        tb_ticks_per_jiffy = freq / HZ;
+	tb_to_us = mulhwu_scale_factor(freq, 1000000);
 }

 void arch_gettod(int *year, int *mon, int *day, int *hour,
===== arch/ppc/kernel/chrp_time.c 1.1 vs 1.2 =====
--- 1.1/arch/ppc/kernel/chrp_time.c	Sat Jun 10 23:58:46 2000
+++ 1.2/arch/ppc/kernel/chrp_time.c	Wed Jun 14 15:10:46 2000
@@ -154,8 +154,7 @@
 __initfunc(void chrp_calibrate_decr(void))
 {
 	struct device_node *cpu;
-	int *fp, divisor;
-	unsigned long freq;
+	unsigned long freq, *fp;

 	if (via_calibrate_decr())
 		return;
@@ -167,14 +166,13 @@
 	freq = 16666000;		/* hardcoded default */
 	cpu = find_type_devices("cpu");
 	if (cpu != 0) {
-		fp = (int *) get_property(cpu, "timebase-frequency", NULL);
+		fp = (unsigned long *)
+		  get_property(cpu, "timebase-frequency", NULL);
 		if (fp != 0)
 			freq = *fp;
 	}
-	freq *= 60;	/* try to make freq/1e6 an integer */
-        divisor = 60;
-        printk("time_init: decrementer frequency = %lu/%d\n", freq, divisor);
-        decrementer_count = freq / HZ / divisor;
-        count_period_num = divisor;
-        count_period_den = freq / 1000000;
+        printk("time_init: decrementer frequency = %lu.%.6lu\n",
+	       freq/1000000, freq%1000000);
+        tb_ticks_per_jiffy = freq / HZ;
+        tb_to_us = mulhwu_scale_factor(freq, 1000000);
 }
===== arch/ppc/kernel/mbx_setup.c 1.1 vs 1.2 =====
--- 1.1/arch/ppc/kernel/mbx_setup.c	Sat Jun 10 23:58:59 2000
+++ 1.2/arch/ppc/kernel/mbx_setup.c	Wed Jun 14 15:10:46 2000
@@ -144,22 +144,20 @@
 __initfunc(void mbx_calibrate_decr(void))
 {
 	bd_t	*binfo = (bd_t *)&res;
-	int freq, fp, divisor;
+	unsigned long freq;

 	if ((((immap_t *)MBX_IMAP_ADDR)->im_clkrst.car_sccr & 0x02000000) == 0)
 		printk("WARNING: Wrong decrementer source clock.\n");

 	/* The manual says the frequency is in Hz, but it is really
-	 * as MHz.  The value 'fp' is the number of decrementer ticks
+	 * as MHz.  The value 'freq' is the number of decrementer ticks
 	 * per second.
 	 */
-	fp = (binfo->bi_intfreq * 1000000) / 16;
-	freq = fp*60;	/* try to make freq/1e6 an integer */
-        divisor = 60;
-        printk("time_init: decrementer frequency = %d/%d\n", freq, divisor);
-        decrementer_count = freq / HZ / divisor;
-        count_period_num = divisor;
-        count_period_den = freq / 1000000;
+	freq = binfo->bi_intfreq * (1000000 / 16);
+        printk("time_init: decrementer frequency = %lu.%.6lu MHz\n",
+	       freq/1000000, freq%1000000);
+        tb_ticks_per_jiffy = freq / HZ;
+        tb_to_us = mulhwu_scale_factor(freq, 1000000);
 }

 /* A place holder for time base interrupts, if they are ever enabled.
===== arch/ppc/kernel/pmac_time.c 1.1 vs 1.2 =====
--- 1.1/arch/ppc/kernel/pmac_time.c	Sat Jun 10 23:59:13 2000
+++ 1.2/arch/ppc/kernel/pmac_time.c	Wed Jun 14 15:10:46 2000
@@ -125,12 +125,11 @@
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
@@ -149,8 +148,10 @@
 		break;
 	case PBOOK_WAKE:
 		xtime.tv_sec = pmac_get_rtc_time() + time_diff;
+		set_dec(tb_ticks_per_jiffy);
+		/* No PBOOK has a 601 AFAIK, so use get_tbl not binary_tbl  */
+		tb_last_stamp=get_tbl();
 		xtime.tv_usec = 0;
-		set_dec(decrementer_count);
 		last_rtc_update = xtime.tv_sec;
 		break;
 	}
@@ -170,7 +171,7 @@
 __initfunc(void pmac_calibrate_decr(void))
 {
 	struct device_node *cpu;
-	int freq, *fp, divisor;
+	unsigned long freq, *fp;

 #ifdef CONFIG_PMAC_PBOOK
 	pmu_register_sleep_notifier(&time_sleep_notifier);
@@ -186,15 +187,13 @@
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

===== arch/ppc/kernel/prep_setup.c 1.2 vs 1.3 =====
--- 1.2/arch/ppc/kernel/prep_setup.c	Thu Nov  4 17:56:11 1999
+++ 1.3/arch/ppc/kernel/prep_setup.c	Wed Jun 14 15:10:47 2000
@@ -366,14 +366,13 @@
  */
 __initfunc(void prep_res_calibrate_decr(void))
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
@@ -382,32 +381,29 @@
  * but on prep we have to figure it out.
  * -- Cort
  */
-int calibrate_done = 0;
-volatile int *done_ptr = &calibrate_done;
-
+/* Done with 3 interrupts: the first one primes the cache and the
+ * 2 following ones measure the interval. The precision of the method
+ * is still doubtful due to the short interval sampled.
+ */
+static __initdata volatile int calibrate_steps = 3;
+static __initdata unsigned long tbstamp;
 __initfunc(void
 prep_calibrate_decr_handler(int            irq,
 			    void           *dev,
 			    struct pt_regs *regs))
 {
-	unsigned long freq, divisor;
-	static unsigned long t1 = 0, t2 = 0;
+	unsigned long t, freq;
+	int step=--calibrate_steps;

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

@@ -429,7 +425,7 @@
 	if (request_irq(0, prep_calibrate_decr_handler, 0, "timer", NULL) != 0)
 		panic("Could not allocate timer IRQ!");
 	__sti();
-	while ( ! *done_ptr ) /* nothing */; /* wait for calibrate */
+	while ( calibrate_steps ) /* nothing */; /* wait for calibrate */
         restore_flags(flags);
 	free_irq( 0, NULL);
 }
@@ -438,8 +434,8 @@
 /* We use the NVRAM RTC to time a second to calibrate the decrementer. */
 __initfunc(void mk48t59_calibrate_decr(void))
 {
-	unsigned long freq, divisor;
-	unsigned long t1, t2;
+	unsigned long freq;
+	unsigned long t1;
         unsigned char save_control;
         long i;
 	unsigned char sec;
@@ -459,29 +455,31 @@

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

 void
===== arch/ppc/kernel/time.c 1.1 vs 1.2 =====
--- 1.1/arch/ppc/kernel/time.c	Sat Jun 10 23:59:37 2000
+++ 1.2/arch/ppc/kernel/time.c	Wed Jun 14 15:10:47 2000
@@ -56,12 +56,12 @@

 /* The decrementer counts down by 128 every 128ns on a 601. */
 #define DECREMENTER_COUNT_601	(1000000000 / HZ)
-#define COUNT_PERIOD_NUM_601	1
-#define COUNT_PERIOD_DEN_601	1000

-unsigned decrementer_count;	/* count value for 1e6/HZ microseconds */
-unsigned count_period_num;	/* 1 decrementer count equals */
-unsigned count_period_den;	/* count_period_num / count_period_den us */
+unsigned tb_ticks_per_jiffy;	/* count value for 1e6/HZ microseconds */
+unsigned tb_to_us;		/* multiplier for mulhwu */
+unsigned tb_last_stamp;		/* timebase value at last jiffy */
+
+extern volatile unsigned long lost_ticks;

 /*
  * timer_interrupt - gets called when the decrementer overflows,
@@ -70,9 +70,9 @@
  */
 void timer_interrupt(struct pt_regs * regs)
 {
-	int dval, d;
+	int delta;
 	unsigned long cpu = smp_processor_id();
-
+
 	hardirq_enter(cpu);
 #ifdef __SMP__
 	{
@@ -95,17 +95,10 @@
 	}
 #endif /* __SMP__ */

-	while ((dval = get_dec()) < 0) {
-		/*
-		 * Wait for the decrementer to change, then jump
-		 * in and add decrementer_count to its value
-		 * (quickly, before it changes again!)
-		 */
-		while ((d = get_dec()) == dval)
-			;
-		set_dec(d + decrementer_count);
+	while ((delta = tb_last_stamp+tb_ticks_per_jiffy-binary_tbl()) <= 0) {
 		if ( !smp_processor_id() )
 		{
+			tb_last_stamp += tb_ticks_per_jiffy;
 			do_timer(regs);
 			/*
 			 * update the rtc when needed
@@ -117,10 +110,11 @@
 					last_rtc_update = xtime.tv_sec;
 				else
 					/* do it again in 60 s */
-					last_rtc_update = xtime.tv_sec - 60;
+					last_rtc_update = xtime.tv_sec - 600;
 			}
 		}
 	}
+	set_dec(delta);
 #ifdef __SMP__
 	smp_local_timer_interrupt(regs);
 #endif
@@ -151,8 +145,9 @@
 	*tv = xtime;
 	/* XXX we don't seem to have the decrementers synced properly yet */
 #ifndef __SMP__
-	tv->tv_usec += (decrementer_count - get_dec())
-	    * count_period_num / count_period_den;
+	tv->tv_usec += mulhwu(tb_to_us,
+			      binary_tbl() - tb_last_stamp
+			      + lost_ticks*tb_ticks_per_jiffy);
 	if (tv->tv_usec >= 1000000) {
 		tv->tv_usec -= 1000000;
 		tv->tv_sec++;
@@ -164,15 +159,15 @@
 void do_settimeofday(struct timeval *tv)
 {
 	unsigned long flags;
-	int frac_tick;
-
-	last_rtc_update = 0; /* so the rtc gets updated soon */
-	frac_tick = tv->tv_usec % (1000000 / HZ);
+	int tv_delta;
+
 	save_flags(flags);
 	cli();
-	xtime.tv_sec = tv->tv_sec;
-	xtime.tv_usec = tv->tv_usec - frac_tick;
-	set_dec(frac_tick * count_period_den / count_period_num);
+	last_rtc_update = 0; /* so the rtc gets updated soon */
+	tv_delta = mulhwu(tb_to_us, binary_tbl() - tb_last_stamp);
+	xtime.tv_sec = tv->tv_sec - ((tv_delta>tv->tv_usec) ? 1 : 0);
+	xtime.tv_usec = tv->tv_usec + ((tv_delta>tv->tv_usec) ?
+				       1000000 : 0) - tv_delta;
 	time_adjust = 0;                /* stop active adjtime() */
 	time_status |= STA_UNSYNC;
 	time_state = TIME_ERROR;        /* p. 24, (a) */
@@ -189,19 +184,19 @@
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

         xtime.tv_sec = ppc_md.get_rtc_time();
+	tb_last_stamp = binary_tbl();
+	set_dec(tb_ticks_per_jiffy);
         xtime.tv_usec = 0;
-
-	set_dec(decrementer_count);
 	/* mark the rtc/on-chip timer as in sync
 	 * so we don't update right away
 	 */
@@ -330,3 +325,37 @@
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
===== arch/ppc/kernel/time.h 1.1 vs 1.2 =====
--- 1.1/arch/ppc/kernel/time.h	Sat Jun 10 23:59:39 2000
+++ 1.2/arch/ppc/kernel/time.h	Wed Jun 14 15:10:47 2000
@@ -6,12 +6,14 @@
  * Paul Mackerras' version and mine for PReP and Pmac.
  */

+#include <linux/config.h>
 #include <linux/mc146818rtc.h>

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
@@ -24,11 +26,70 @@
 {
 	unsigned int ret;

-	asm volatile("mfspr %0,22" : "=r" (ret) :);
+	asm volatile("mfdec %0" : "=r" (ret) :);
 	return ret;
 }

 static __inline__ void set_dec(unsigned int val)
 {
-	asm volatile("mtspr 22,%0" : : "r" (val));
+	asm volatile("mtdec %0" : : "r" (val));
+}
+
+/* Accessor functions for the timebase (RTC on 601) registers. */
+/* If one day CONFIG_POWER is added just define __USE_RTC as 1 */
+#ifdef CONFIG_6xx
+extern __inline__ int const __USE_RTC(void) {
+	unsigned pvr;
+	asm("mfpvr %0" : "=r" (pvr));
+	return (pvr>>16) == 1;
+}
+#else
+#define __USE_RTC() 0
+#endif
+
+extern __inline__ unsigned long get_tbl(void) {
+	unsigned long tbl;
+  	asm volatile("mftb %0" : "=r" (tbl));
+	return tbl;
+}
+
+#if 0
+extern __inline__ unsigned long get_rtcl(void) {
+	unsigned long rtcl;
+  	asm volatile("mfrtcl %0" : "=r" (rtcl));
+	return rtcl;
 }
+
+extern __inline__ unsigned get_native_tbl(void) {
+	if (__USE_RTC())
+		return get_rtcl();
+	else
+		return get_tbl();
+}
+#endif
+
+extern __inline__ unsigned long get_bin_rtcl(void) {
+	unsigned long rtcl, rtcu1, rtcu2;
+	asm volatile("\
+1:	mfrtcu	%0\n\
+	mfrtcl	%1\n\
+	mfrtcu	%2\n\
+	cmpw	%0,%2\n\
+	bne-	1b\n"
+	: "=r" (rtcu1), "=r" (rtcl), "=r" (rtcu2)
+	: : "cr0");
+	return rtcu2*1000000000+rtcl;
+}
+
+extern __inline__ unsigned binary_tbl(void) {
+	if (__USE_RTC())
+		return get_bin_rtcl();
+	else
+		return get_tbl();
+}
+
+/* Use mulhwu to scale processor timebase to timeval */
+#define mulhwu(x,y) \
+({unsigned z; asm ("mulhwu %0,%1,%2" : "=r" (z) : "r" (x), "r" (y)); z;})
+
+unsigned mulhwu_scale_factor(unsigned, unsigned);

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
