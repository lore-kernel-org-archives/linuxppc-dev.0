Return-Path: <n_tbinh@yahoo.com>
Received: from web30702.mail.mud.yahoo.com (web30702.mail.mud.yahoo.com
	[68.142.200.135]) by ozlabs.org (Postfix) with SMTP id 05D4C687DE
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Nov 2005 14:20:56 +1100 (EST)
Message-ID: <20051129032051.6836.qmail@web30702.mail.mud.yahoo.com>
Date: Tue, 29 Nov 2005 03:20:50 +0000 (GMT)
From: Nguyen Thanh Binh <n_tbinh@yahoo.com>
To: "Autran, Guillaume" <gautran@mrv.com>,
	"'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
In-Reply-To: <19EE6EC66973A5408FBE4CB7772F6F0A2105B2@ltnmail.xyplex.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1518963006-1133234450=:4697"
Subject: RE: Booting hangs after "Calibrating delay loop..."
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1518963006-1133234450=:4697
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Hi Guillaume,

I have tried with your suggestions. But I did not find
arch/ppc/syslib/m8xx_setup.c as you said, instead I
found arch/ppc/kernel/m8xx_setup.c.
I have modified as you showed me, but the result was
always the same.
It means that boot hangs after printing "Calibrating
delay loop...".

You can find what I have modified in the attached
files 
(time.c in arch/ppc/kernel, m8xx_setup.c in
arch/ppc/kernel).

Do you have any idea?

Thank you very much.

Binh Nguyen

--- "Autran, Guillaume" <gautran@mrv.com> wrote:

> Hi,
> 
> I remember there is some race condition before
> calling set_dec(..) in time.c
> Basically, what happens is that the external
> decrementer is set way before
> the interrupt gets enabled. When we get to enable
> the interrupt, the
> decrementer value already reached 0 and wrapped
> arround (at least in our
> case). 
> The fix was to comment the line in:
> arch/ppc/kernel/time.c:330:
> set_dec(tb_ticks_per_jiffy);
> 
> And move it to:
> arch/ppc/syslib/m8xx_setup.c
> inside m8xx_calibrate_decr() just before setting up
> the interrupt for the
> decrementer.
> 
> In time.c, you may also need to initialize stamp =
> get_native_tbl(); as this
> variable may not have been initialized since you are
> using an external
> decrementer.
> 
> Try that...
> 
> Guillaume.
> 


		
___________________________________________________________ 
WIN ONE OF THREE YAHOO! VESPAS - Enter now! - http://uk.cars.yahoo.com/features/competitions/vespa.html
--0-1518963006-1133234450=:4697
Content-Type: text/x-c; name="time.c"
Content-Description: 2251979003-time.c
Content-Disposition: inline; filename="time.c"

/*
 * Common time routines among all ppc machines.
 *
 * Written by Cort Dougan (cort@cs.nmt.edu) to merge
 * Paul Mackerras' version and mine for PReP and Pmac.
 * MPC8xx/MBX changes by Dan Malek (dmalek@jlc.net).
 *
 * First round of bugfixes by Gabriel Paubert (paubert@iram.es)
 * to make clock more stable (2.4.0-test5). The only thing
 * that this code assumes is that the timebases have been synchronized
 * by firmware on SMP and are never stopped (never do sleep
 * on SMP then, nap and doze are OK).
 *
 * TODO (not necessarily in this file):
 * - improve precision and reproducibility of timebase frequency
 * measurement at boot time.
 * - get rid of xtime_lock for gettimeofday (generic kernel problem
 * to be implemented on all architectures for SMP scalability and
 * eventually implementing gettimeofday without entering the kernel).
 * - put all time/clock related variables in a single structure
 * to minimize number of cache lines touched by gettimeofday()
 * - for astronomical applications: add a new function to get
 * non ambiguous timestamps even around leap seconds. This needs
 * a new timestamp format and a good name.
 *
 *
 * The following comment is partially obsolete (at least the long wait
 * is no more a valid reason):
 * Since the MPC8xx has a programmable interrupt timer, I decided to
 * use that rather than the decrementer.  Two reasons: 1.) the clock
 * frequency is low, causing 2.) a long wait in the timer interrupt
 *		while ((d = get_dec()) == dval)
 * loop.  The MPC8xx can be driven from a variety of input clocks,
 * so a number of assumptions have been made here because the kernel
 * parameter HZ is a constant.  We assume (correctly, today :-) that
 * the MPC8xx on the MBX board is driven from a 32.768 kHz crystal.
 * This is then divided by 4, providing a 8192 Hz clock into the PIT.
 * Since it is not possible to get a nice 100 Hz clock out of this, without
 * creating a software PLL, I have set HZ to 128.  -- Dan
 *
 * 1997-09-10  Updated NTP code according to technical memorandum Jan '96
 *             "A Kernel Model for Precision Timekeeping" by Dave Mills
 */

#include <linux/config.h>
#include <linux/errno.h>
#include <linux/sched.h>
#include <linux/kernel.h>
#include <linux/param.h>
#include <linux/string.h>
#include <linux/mm.h>
#include <linux/module.h>
#include <linux/interrupt.h>
#include <linux/timex.h>
#include <linux/kernel_stat.h>
#include <linux/mc146818rtc.h>
#include <linux/time.h>
#include <linux/init.h>

#include <linux/trace.h>

#include <asm/segment.h>
#include <asm/io.h>
#include <asm/processor.h>
#include <asm/nvram.h>
#include <asm/cache.h>
#include <asm/8xx_immap.h>
#include <asm/machdep.h>

#include <asm/time.h>

#ifdef CONFIG_HIGH_RES_TIMERS
#include <linux/hrtime.h>
int hr_time_resolution = CONFIG_HIGH_RES_RESOLUTION;
int arch_to_nsec;
int nsec_to_arch;
unsigned volatile jiffies_seq = 0;
#endif

unsigned long disarm_decr[NR_CPUS];

extern int do_sys_settimeofday(struct timeval *tv, struct timezone *tz);

/* keep track of when we need to update the rtc */
time_t last_rtc_update;
extern rwlock_t xtime_lock;

/* The decrementer counts down by 128 every 128ns on a 601. */
#define DECREMENTER_COUNT_601	(1000000000 / HZ)

unsigned tb_ticks_per_jiffy;
unsigned tb_to_us;
unsigned tb_last_stamp;
extern unsigned long wall_jiffies;

static long time_offset;

spinlock_t rtc_lock = SPIN_LOCK_UNLOCKED;

EXPORT_SYMBOL(rtc_lock);

/* Timer interrupt helper function */
static inline int tb_delta(unsigned *jiffy_stamp) {
	int delta;
	if (__USE_RTC()) {
		delta = get_rtcl();
		if (delta < *jiffy_stamp) *jiffy_stamp -= 1000000000;
		delta -= *jiffy_stamp;
	} else {
		delta = get_tbl() - *jiffy_stamp;
	}
	return delta;
}

extern unsigned long prof_cpu_mask;
extern unsigned int * prof_buffer;
extern unsigned long prof_len;
extern unsigned long prof_shift;
extern char _stext;

static inline void ppc_do_profile (unsigned long nip)
{
	if (!prof_buffer)
		return;

	/*
	 * Only measure the CPUs specified by /proc/irq/prof_cpu_mask.
	 * (default is all CPUs.)
	 */
	if (!((1<<smp_processor_id()) & prof_cpu_mask))
		return;

	nip -= (unsigned long) &_stext;
	nip >>= prof_shift;
	/*
	 * Don't ignore out-of-bounds EIP values silently,
	 * put them into the last histogram slot, so if
	 * present, they will show up as a sharp peak.
	 */
	if (nip > prof_len-1)
		nip = prof_len-1;
	atomic_inc((atomic_t *)&prof_buffer[nip]);
}

#ifdef CONFIG_HIGH_RES_TIMERS
int hr_set_dec(unsigned count) {

	if (time_before(count, get_tbl()))
		/* missed it */
		return 1;

	/* ok, we've got a shot */
	set_dec(count - get_tbl());

	if (time_before_eq(get_tbl(), count))
		/* made it */
		return 0;

	/*
	 * Ohh, just missed it. If we were slow enough to have loaded the
	 * decrementer with a negative value, we're going to have to wait
	 * an awfully long time for another decrementer interrupt. So, we'll
	 * trigger an interrupt right now and let timer_interrupt recover and
	 * re-schedule the next jiffie to make up for our mistake.
	 */
	set_dec(1);
	return 1;

}
int schedule_hr_timer_int(unsigned ref_jiffies, int cycles) {

	unsigned temp_jiffies, seq;
	unsigned req_tb, next_jiffy_tb;
	int flags, ret;

	while (unlikely(cycles >= tb_ticks_per_jiffy)) {
		ref_jiffies++;
		cycles -= tb_ticks_per_jiffy;
	}

	do {
		int jiffies_diff;

		seq = jiffies_seq;
		temp_jiffies = jiffies;
		barrier();

		req_tb = tb_last_stamp + cycles;
		if (unlikely(jiffies_diff = ref_jiffies - temp_jiffies))
			req_tb += (jiffies_diff) * tb_ticks_per_jiffy;

		next_jiffy_tb = tb_last_stamp + tb_ticks_per_jiffy;

		barrier();
	} while (unlikely((seq != jiffies_seq) || (seq & 1)));

	if (time_before(ref_jiffies, temp_jiffies))
		return 1;

	/* paranoia */
	if (time_after(ref_jiffies, temp_jiffies) ||
	    time_after(req_tb, next_jiffy_tb))
		BUG();

	local_irq_save(flags);
	ret = hr_set_dec(req_tb);
	local_irq_restore(flags);

	return ret;
}
void __init hr_time_init(void)
{
	unsigned tb_ticks_per_sec;

	/*
	 * Use mulhwu_scale_factor to find the number ticks needed to equal
	 * 1,000,000 uSecs (1 Sec).
	 */
	tb_ticks_per_sec = mulhwu_scale_factor(tb_to_us, USEC_PER_SEC);

	arch_to_nsec = div_sc_n(HR_TIME_SCALE_NSEC, NSEC_PER_SEC,
				tb_ticks_per_sec);
	nsec_to_arch = div_sc_n(HR_TIME_SCALE_CYCLES, tb_ticks_per_sec,
				NSEC_PER_SEC);

	printk("hr_time_init: arch_to_nsec = %u, nsec_to_arch = %u\n",
		arch_to_nsec, nsec_to_arch);
}
#endif
/*
 * timer_interrupt - gets called when the decrementer overflows,
 * with interrupts disabled.
 * We set it up to overflow again in 1/HZ seconds.
 */
int timer_interrupt(struct pt_regs * regs)
{
	int next_dec;
	unsigned long cpu = smp_processor_id();
	unsigned jiffy_stamp = last_jiffy_stamp(cpu);
#ifdef CONFIG_HIGH_RES_TIMERS
	int hr_tick = 1;
#endif
	extern void do_IRQ(struct pt_regs *);

	if (atomic_read(&ppc_n_lost_interrupts) != 0)
		do_IRQ(regs);

	TRACE_TRAP_ENTRY(regs->trap, instruction_pointer(regs));

	hardirq_enter(cpu);
	
	while ((next_dec = tb_ticks_per_jiffy - tb_delta(&jiffy_stamp)) < 0) {
		jiffy_stamp += tb_ticks_per_jiffy;
		if (!user_mode(regs))
			ppc_do_profile(instruction_pointer(regs));
		if (unlikely(!heartbeat_count(cpu)--) 
				&& heartbeat_reset(cpu)) {
			ppc_md.heartbeat();
			heartbeat_count(cpu) = heartbeat_reset(cpu);
		}
#ifdef CONFIG_HIGH_RES_TIMERS
		hr_tick = 0;
#endif
	  	if (cpu)
			continue;

		/* We are in an interrupt, no need to save/restore flags */
		write_lock(&xtime_lock);
		tb_last_stamp = jiffy_stamp;
#ifdef CONFIG_HIGH_RES_TIMERS
		jiffies_seq++;
#endif
		do_timer(regs);
#ifdef CONFIG_HIGH_RES_TIMERS
		jiffies_seq++;
#endif

		/*
		 * update the rtc when needed, this should be performed on the
		 * right fraction of a second. Half or full second ?
		 * Full second works on mk48t59 clocks, others need testing.
		 * Note that this update is basically only used through
		 * the adjtimex system calls. Setting the HW clock in
		 * any other way is a /dev/rtc and userland business.
		 * This is still wrong by -0.5/+1.5 jiffies because of the
		 * timer interrupt resolution and possible delay, but here we
		 * hit a quantization limit which can only be solved by higher
		 * resolution timers and decoupling time management from timer
		 * interrupts. This is also wrong on the clocks
		 * which require being written at the half second boundary.
		 * We should have an rtc call that only sets the minutes and
		 * seconds like on Intel to avoid problems with non UTC clocks.
		 */
		if ( ppc_md.set_rtc_time && (time_status & STA_UNSYNC) == 0 &&
		     xtime.tv_sec - last_rtc_update >= 659 &&
		     abs(xtime.tv_usec - (1000000-1000000/HZ)) < 500000/HZ &&
		     jiffies - wall_jiffies == 1) {
		  	if (ppc_md.set_rtc_time(xtime.tv_sec+1 + time_offset) == 0)
				last_rtc_update = xtime.tv_sec+1;
			else
				/* Try again one minute later */
				last_rtc_update += 60;
		}
		write_unlock(&xtime_lock);
	}
	if (!disarm_decr[cpu])
		set_dec(next_dec);
#ifdef CONFIG_HIGH_RES_TIMERS
	if (hr_tick)
		do_hr_timer_int();
#endif
	last_jiffy_stamp(cpu) = jiffy_stamp;

#ifdef CONFIG_SMP
	smp_local_timer_interrupt(regs);
#endif /* CONFIG_SMP */

	hardirq_exit(cpu);

	if (softirq_pending(cpu))
		do_softirq();

	TRACE_TRAP_EXIT();

	return 1; /* lets ret_from_int know we can do checks */
}

/*
 * This version of gettimeofday has microsecond resolution.
 */
void do_gettimeofday(struct timeval *tv)
{
	unsigned long flags;
	unsigned delta, lost_ticks, usec, sec;

	read_lock_irqsave(&xtime_lock, flags);
	sec = xtime.tv_sec;
	usec = xtime.tv_usec;
	delta = tb_ticks_since(tb_last_stamp);
#ifdef CONFIG_SMP
	/* As long as timebases are not in sync, gettimeofday can only
	 * have jiffy resolution on SMP.
	 */
	if (!smp_tb_synchronized)
		delta = 0;
#endif /* CONFIG_SMP */
	lost_ticks = jiffies - wall_jiffies;
	read_unlock_irqrestore(&xtime_lock, flags);

	usec += mulhwu(tb_to_us, tb_ticks_per_jiffy * lost_ticks + delta);
	while (usec >= 1000000) {
	  	sec++;
		usec -= 1000000;
	}
	tv->tv_sec = sec;
	tv->tv_usec = usec;
}

void do_settimeofday(struct timeval *tv)
{
	unsigned long flags;
	int tb_delta, new_usec, new_sec;

	write_lock_irqsave(&xtime_lock, flags);
	/* Updating the RTC is not the job of this code. If the time is
	 * stepped under NTP, the RTC will be update after STA_UNSYNC
	 * is cleared. Tool like clock/hwclock either copy the RTC
	 * to the system time, in which case there is no point in writing
	 * to the RTC again, or write to the RTC but then they don't call
	 * settimeofday to perform this operation. Note also that
	 * we don't touch the decrementer since:
	 * a) it would lose timer interrupt synchronization on SMP
	 * (if it is working one day)
	 * b) it could make one jiffy spuriously shorter or longer
	 * which would introduce another source of uncertainty potentially
	 * harmful to relatively short timers.
	 */

	/* This works perfectly on SMP only if the tb are in sync but 
	 * guarantees an error < 1 jiffy even if they are off by eons,
	 * still reasonable when gettimeofday resolution is 1 jiffy.
	 */
	tb_delta = tb_ticks_since(last_jiffy_stamp(smp_processor_id()));
	tb_delta += (jiffies - wall_jiffies) * tb_ticks_per_jiffy;
	new_sec = tv->tv_sec;
	new_usec = tv->tv_usec - mulhwu(tb_to_us, tb_delta);
	while (new_usec <0) {
		new_sec--; 
		new_usec += 1000000;
	}
	xtime.tv_usec = new_usec;
	xtime.tv_sec = new_sec;

	wall_to_monotonic.tv_sec += xtime.tv_sec - tv->tv_sec;
	wall_to_monotonic.tv_nsec += (xtime.tv_usec - tv->tv_usec) * 
		NSEC_PER_USEC;

	if (wall_to_monotonic.tv_nsec > NSEC_PER_SEC) {
		wall_to_monotonic.tv_nsec -= NSEC_PER_SEC;
		wall_to_monotonic.tv_sec++;
	}
	if (wall_to_monotonic.tv_nsec < 0) {
		wall_to_monotonic.tv_nsec += NSEC_PER_SEC;
		wall_to_monotonic.tv_sec--;
	}

	/* In case of a large backwards jump in time with NTP, we want the 
	 * clock to be updated as soon as the PLL is again in lock.
	 */
	last_rtc_update = new_sec - 658;

	time_adjust = 0;                /* stop active adjtime() */
	time_status |= STA_UNSYNC;
	time_state = TIME_ERROR;        /* p. 24, (a) */
	time_maxerror = NTP_PHASE_LIMIT;
	time_esterror = NTP_PHASE_LIMIT;
	write_unlock_irqrestore(&xtime_lock, flags);
	clock_was_set();
}

/* This function is only called on the boot processor */
void __init time_init(void)
{
	time_t sec, old_sec;
	unsigned old_stamp, stamp, elapsed;

	stamp = get_native_tbl(); /* Binh 25/11/05 */


        if (ppc_md.time_init != NULL)
                time_offset = ppc_md.time_init();

	if (__USE_RTC()) {
		/* 601 processor: dec counts down by 128 every 128ns */
		tb_ticks_per_jiffy = DECREMENTER_COUNT_601;
		/* mulhwu_scale_factor(1000000000, 1000000) is 0x418937 */
		tb_to_us = 0x418937;
        } else {
                ppc_md.calibrate_decr();
	}
#ifdef CONFIG_HIGH_RES_TIMERS
	hr_time_init();
#endif

	/* Now that the decrementer is calibrated, it can be used in case the 
	 * clock is stuck, but the fact that we have to handle the 601
	 * makes things more complex. Repeatedly read the RTC until the
	 * next second boundary to try to achieve some precision.  If there
	 * is no RTC, we still need to set tb_last_stamp and
	 * last_jiffy_stamp(cpu 0) to the current stamp.
	 */
	stamp = get_native_tbl();
	if (ppc_md.get_rtc_time) {
		sec = ppc_md.get_rtc_time();
		elapsed = 0;
		do {
			old_stamp = stamp; 
			old_sec = sec;
			stamp = get_native_tbl();
			if (__USE_RTC() && stamp < old_stamp)
				old_stamp -= 1000000000;
			elapsed += stamp - old_stamp;
			sec = ppc_md.get_rtc_time();
		} while ( sec == old_sec && elapsed < 2*HZ*tb_ticks_per_jiffy);
		if (sec == old_sec)
			printk("Warning: real time clock seems stuck!\n");
		xtime.tv_sec = sec;
		wall_to_monotonic.tv_sec = -sec;
		xtime.tv_usec = 0;
		wall_to_monotonic.tv_nsec = 0;

		/* No update now, we just read the time from the RTC ! */
		last_rtc_update = xtime.tv_sec;
	}

	last_jiffy_stamp(0) = tb_last_stamp = stamp;

	/* Not exact, but the timer interrupt takes care of this */
	/* set_dec(tb_ticks_per_jiffy); Binh 25/11/05 */

	/* If platform provided a timezone (pmac), we correct the time
	 * using do_sys_settimeofday() which in turn calls warp_clock()
	 */
        if (time_offset) {
        	struct timezone tz;
        	tz.tz_minuteswest = -time_offset / 60;
        	tz.tz_dsttime = 0;
        	do_sys_settimeofday(NULL, &tz);
        }
}

#define FEBRUARY		2
#define	STARTOFTIME		1970
#define SECDAY			86400L
#define SECYR			(SECDAY * 365)
#define	leapyear(y)		((!(y % 4) && (y % 100)) || !(y % 400))
#define	days_in_year(a) 	(leapyear(a) ? 366 : 365)
#define	days_in_month(a) 	(month_days[(a) - 1])

static int month_days[12] = {
	31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
};

void to_tm(int tim, struct rtc_time * tm)
{
	register int i;
	register long hms, day, gday;

	gday = day = tim / SECDAY;
	hms = tim % SECDAY;

	/* Hours, minutes, seconds are easy */
	tm->tm_hour = hms / 3600;
	tm->tm_min = (hms % 3600) / 60;
	tm->tm_sec = (hms % 3600) % 60;

	/* Number of years in days */
	for (i = STARTOFTIME; day >= days_in_year(i); i++)
		day -= days_in_year(i);
	tm->tm_year = i;

	/* Number of months in days left */
	if (leapyear(tm->tm_year))
		days_in_month(FEBRUARY) = 29;
	for (i = 1; day >= days_in_month(i); i++)
		day -= days_in_month(i);
	days_in_month(FEBRUARY) = 28;
	tm->tm_mon = i;

	/* Days are what is left over (+1) from all that. */
	tm->tm_mday = day + 1;

	/*
	 * Determine the day of week. Jan. 1, 1970 was a Thursday.
	 */
	tm->tm_wday = (gday + 4) % 7;
}

/* Auxiliary function to compute scaling factors */
/* Actually the choice of a timebase running at 1/4 the of the bus
 * frequency giving resolution of a few tens of nanoseconds is quite nice.
 * It makes this computation very precise (27-28 bits typically) which
 * is optimistic considering the stability of most processor clock
 * oscillators and the precision with which the timebase frequency
 * is measured but does not harm.
 */
unsigned mulhwu_scale_factor(unsigned inscale, unsigned outscale) {
	unsigned mlt=0, tmp, err;
	/* No concern for performance, it's done once: use a stupid
	 * but safe and compact method to find the multiplier.
	 */
	for (tmp = 1U<<31; tmp != 0; tmp >>= 1) {
		if (mulhwu(inscale, mlt|tmp) < outscale) mlt|=tmp;
	}
	/* We might still be off by 1 for the best approximation.
	 * A side effect of this is that if outscale is too large
	 * the returned value will be zero.
	 * Many corner cases have been checked and seem to work,
	 * some might have been forgotten in the test however.
	 */
	err = inscale*(mlt+1);
	if (err <= inscale/2) mlt++;
	return mlt;
}


--0-1518963006-1133234450=:4697
Content-Type: text/x-c; name="m8xx_setup.c"
Content-Description: 980338913-m8xx_setup.c
Content-Disposition: inline; filename="m8xx_setup.c"

/*
 *  linux/arch/ppc/kernel/setup.c
 *
 *  Copyright (C) 1995  Linus Torvalds
 *  Adapted from 'alpha' version by Gary Thomas
 *  Modified by Cort Dougan (cort@cs.nmt.edu)
 *  Modified for MBX using prep/chrp/pmac functions by Dan (dmalek@jlc.net)
 *  Further modified for generic 8xx by Dan.
 */

/*
 * bootup setup stuff..
 */

#include <linux/config.h>
#include <linux/errno.h>
#include <linux/sched.h>
#include <linux/kernel.h>
#include <linux/mm.h>
#include <linux/stddef.h>
#include <linux/unistd.h>
#include <linux/ptrace.h>
#include <linux/slab.h>
#include <linux/user.h>
#include <linux/a.out.h>
#include <linux/tty.h>
#include <linux/major.h>
#include <linux/interrupt.h>
#include <linux/reboot.h>
#include <linux/init.h>
#include <linux/blk.h>
#include <linux/ioport.h>
#include <linux/console.h>
#include <linux/bootmem.h>
#include <linux/ide.h>
#include <linux/seq_file.h>

#include <asm/mmu.h>
#include <asm/processor.h>
#include <asm/residual.h>
#include <asm/io.h>
#include <asm/pgtable.h>
#include <asm/mpc8xx.h>
#include <asm/8xx_immap.h>
#include <asm/machdep.h>
#include <asm/bootinfo.h>
#include <asm/time.h>
#include <asm/i8259.h>

#include "ppc8xx_pic.h"

extern int i8259_pic_irq_offset; /* defined in arch/ppc/kernel/i8259.c */

static int m8xx_set_rtc_time(unsigned long time);
static unsigned long m8xx_get_rtc_time(void);
void m8xx_calibrate_decr(void);

unsigned char __res[sizeof(bd_t)];

extern void m8xx_ide_init(void);
extern void m8xx_find_bridges(void);

extern unsigned long find_available_memory(void);
extern void m8xx_cpm_reset(uint);
extern void rpxfb_alloc_pages(void);

void __init
m8xx_setup_arch(void)
{
	int	cpm_page;

	cpm_page = (int) alloc_bootmem_pages(PAGE_SIZE);

	/* Reset the Communication Processor Module.
	*/
	m8xx_cpm_reset(cpm_page);

#ifdef CONFIG_FB_RPX
	rpxfb_alloc_pages();
#endif

#ifdef notdef
	ROOT_DEV = to_kdev_t(0x0301); /* hda1 */
#endif

#ifdef CONFIG_BLK_DEV_INITRD
#if 0
	ROOT_DEV = to_kdev_t(0x0200); /* floppy */
	rd_prompt = 1;
	rd_doload = 1;
	rd_image_start = 0;
#endif
#if 0	/* XXX this may need to be updated for the new bootmem stuff,
	   or possibly just deleted (see set_phys_avail() in init.c).
	   - paulus. */
	/* initrd_start and size are setup by boot/head.S and kernel/head.S */
	if ( initrd_start )
	{
		if (initrd_end > *memory_end_p)
		{
			printk("initrd extends beyond end of memory "
			       "(0x%08lx > 0x%08lx)\ndisabling initrd\n",
			       initrd_end,*memory_end_p);
			initrd_start = 0;
		}
	}
#endif
#endif

#ifdef CONFIG_PCI
	m8xx_find_bridges();
#endif
}

void
abort(void)
{
#ifdef CONFIG_XMON
	xmon(0);
#endif
	machine_restart(NULL);

	/* not reached */
	for (;;);
}

/* A place holder for time base interrupts, if they are ever enabled. */
void timebase_interrupt(int irq, void * dev, struct pt_regs * regs)
{
	printk ("timebase_interrupt()\n");
}

/* The decrementer counts at the system (internal) clock frequency divided by
 * sixteen, or external oscillator divided by four.  We force the processor
 * to use system clock divided by sixteen.
 */
void __init m8xx_calibrate_decr(void)
{
	bd_t	*binfo = (bd_t *)__res;
	int freq, fp, divisor;

	/* Unlock the SCCR. */
	((volatile immap_t *)IMAP_ADDR)->im_clkrstk.cark_sccrk = ~KAPWR_KEY;
	((volatile immap_t *)IMAP_ADDR)->im_clkrstk.cark_sccrk = KAPWR_KEY;

	/* Force all 8xx processors to use divide by 16 processor clock. */
	((volatile immap_t *)IMAP_ADDR)->im_clkrst.car_sccr |= 0x02000000;

	/* Processor frequency is MHz.
	 * The value 'fp' is the number of decrementer ticks per second.
	 */
	fp = binfo->bi_intfreq / 16;
	freq = fp*60;	/* try to make freq/1e6 an integer */
        divisor = 60;
        printk("Decrementer Frequency = %d/%d\n", freq, divisor);
        tb_ticks_per_jiffy = freq / HZ / divisor;
	tb_to_us = mulhwu_scale_factor(freq / divisor, 1000000);
#ifdef CONFIG_ILATENCY
	{
		extern long ticks_per_usec;
		ticks_per_usec = freq / divisor / 1000000;
	}
#endif

	/* Perform some more timer/timebase initialization.  This used
	 * to be done elsewhere, but other changes caused it to get
	 * called more than once....that is a bad thing.
	 *
	 * First, unlock all of the registers we are going to modify.
	 * To protect them from corruption during power down, registers
	 * that are maintained by keep alive power are "locked".  To
	 * modify these registers we have to write the key value to
	 * the key location associated with the register.
	 * Some boards power up with these unlocked, while others
	 * are locked.  Writing anything (including the unlock code?)
	 * to the unlocked registers will lock them again.  So, here
	 * we guarantee the registers are locked, then we unlock them
	 * for our use.
	 */
	((volatile immap_t *)IMAP_ADDR)->im_sitk.sitk_tbscrk = ~KAPWR_KEY;
	((volatile immap_t *)IMAP_ADDR)->im_sitk.sitk_rtcsck = ~KAPWR_KEY;
	((volatile immap_t *)IMAP_ADDR)->im_sitk.sitk_tbk    = ~KAPWR_KEY;
	((volatile immap_t *)IMAP_ADDR)->im_sitk.sitk_tbscrk =  KAPWR_KEY;
	((volatile immap_t *)IMAP_ADDR)->im_sitk.sitk_rtcsck =  KAPWR_KEY;
	((volatile immap_t *)IMAP_ADDR)->im_sitk.sitk_tbk    =  KAPWR_KEY;

	/* Disable the RTC one second and alarm interrupts. */
	((volatile immap_t *)IMAP_ADDR)->im_sit.sit_rtcsc &=
						~(RTCSC_SIE | RTCSC_ALE);
	/* Enable the RTC */
	((volatile immap_t *)IMAP_ADDR)->im_sit.sit_rtcsc |=
						(RTCSC_RTF | RTCSC_RTE);

	/* Binh 25/11/05 */
	   set_dec(tb_ticks_per_jiffy); 
	

	/* Enabling the decrementer also enables the timebase interrupts
	 * (or from the other point of view, to get decrementer interrupts
	 * we have to enable the timebase).  The decrementer interrupt
	 * is wired into the vector table, nothing to do here for that.
	 */
	((volatile immap_t *)IMAP_ADDR)->im_sit.sit_tbscr =
				((mk_int_int_mask(DEC_INTERRUPT) << 8) |
					 (TBSCR_TBF | TBSCR_TBE));

	if (request_irq(DEC_INTERRUPT, timebase_interrupt, 0, "tbint",
				NULL) != 0)
		panic("Could not allocate timer IRQ!");
}

/* The RTC on the MPC8xx is an internal register.
 * We want to protect this during power down, so we need to unlock,
 * modify, and re-lock.
 */
static int
m8xx_set_rtc_time(unsigned long time)
{
	((volatile immap_t *)IMAP_ADDR)->im_sitk.sitk_rtck = KAPWR_KEY;
	((volatile immap_t *)IMAP_ADDR)->im_sit.sit_rtc = time;
	((volatile immap_t *)IMAP_ADDR)->im_sitk.sitk_rtck = ~KAPWR_KEY;
	return(0);
}

static unsigned long
m8xx_get_rtc_time(void)
{
	/* Get time from the RTC. */
	return((unsigned long)(((immap_t *)IMAP_ADDR)->im_sit.sit_rtc));
}

static void
m8xx_restart(char *cmd)
{
	__volatile__ unsigned char dummy;
	uint	msr;

	cli();
	((immap_t *)IMAP_ADDR)->im_clkrst.car_plprcr |= 0x00000080;

	/* Clear the ME bit in MSR to cause checkstop on machine check
	*/
	__asm__("mfmsr %0" : "=r" (msr) );
	msr &= ~0x1000;
	__asm__("mtmsr %0" : : "r" (msr) );

	dummy = ((immap_t *)IMAP_ADDR)->im_clkrst.res[0];
	printk("Restart failed\n");
	while(1);
}

static void
m8xx_power_off(void)
{
   m8xx_restart(NULL);
}

static void
m8xx_halt(void)
{
   m8xx_restart(NULL);
}


static int
m8xx_show_percpuinfo(struct seq_file *m, int i)
{
	bd_t	*bp;

	bp = (bd_t *)__res;

	seq_printf(m, "clock\t\t: %dMHz\n"
		   "bus clock\t: %dMHz\n",
		   bp->bi_intfreq / 1000000,
		   bp->bi_busfreq / 1000000);

	return 0;
}

/* Initialize the internal interrupt controller.  The number of
 * interrupts supported can vary with the processor type, and the
 * 82xx family can have up to 64.
 * External interrupts can be either edge or level triggered, and
 * need to be initialized by the appropriate driver.
 */
static void __init
m8xx_init_IRQ(void)
{
	int i;
	void cpm_interrupt_init(void);

	for (i = SIU_IRQ_OFFSET ; i < SIU_IRQ_OFFSET + NR_SIU_INTS ; i++)
		irq_desc[i].handler = &ppc8xx_pic;

	cpm_interrupt_init();

#if defined(CONFIG_PCI)
	for (i = I8259_IRQ_OFFSET ; i < I8259_IRQ_OFFSET + NR_8259_INTS ; i++)
		irq_desc[i].handler = &i8259_pic;

	i8259_pic_irq_offset = I8259_IRQ_OFFSET;
	i8259_init(0);

	/* The i8259 cascade interrupt must be level sensitive. */
	((immap_t *)IMAP_ADDR)->im_siu_conf.sc_siel &= 
		~(0x80000000 >> ISA_BRIDGE_INT);

	if (request_irq(ISA_BRIDGE_INT, mbx_i8259_action, 0, "i8259 cascade",
				NULL) != 0)
		panic("Could not allocate 8259 IRQ!");
#endif	/* CONFIG_PCI */
}

/* -------------------------------------------------------------------- */

/*
 * This is a big hack right now, but it may turn into something real
 * someday.
 *
 * For the 8xx boards (at this time anyway), there is nothing to initialize
 * associated the PROM.  Rather than include all of the prom.c
 * functions in the image just to get prom_init, all we really need right
 * now is the initialization of the physical memory region.
 */
static unsigned long __init
m8xx_find_end_of_memory(void)
{
	bd_t	*binfo;
	extern unsigned char __res[];

	binfo = (bd_t *)__res;

	return binfo->bi_memsize;
}

#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
#if !defined(CONFIG_BLK_DEV_MPC8xx_IDE)
/*
 * IDE stuff.
 * These functions are to support an IDE device on the mpc8xx pcmcia interface
 * when using the pcmcia-cs module to manage the pcmcia interface.
 */
static int
m8xx_ide_check_region(ide_ioreg_t from, unsigned int extent)
{
	return check_region(from, extent);
}

static void
m8xx_ide_request_region(ide_ioreg_t from, unsigned int extent, const char *name)
{
	request_region(from, extent, name);
	return;
}

static void
m8xx_ide_release_region(ide_ioreg_t from, unsigned int extent)
{
	release_region(from, extent);
	return;
}

static int
m8xx_ide_default_irq(ide_ioreg_t base)
{
	return SIU_LEVEL4;
}

static ide_ioreg_t
m8xx_ide_default_io_base(int index)
{
	return index;
}
#endif	/* if !defined(CONFIG_BLK_DEV_MPC8xx_IDE) */
#endif	/* if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE) */

/*
 * Now map in some of the I/O space that is generically needed
 * or shared with multiple devices.
 * All of this fits into the same 4Mbyte region, so it only
 * requires one page table page.  (or at least it used to  -- paulus)
 */
static void __init
m8xx_map_io(void)
{
        io_block_mapping(IMAP_ADDR, IMAP_ADDR, IMAP_SIZE, _PAGE_IO);
#ifdef CONFIG_MBX
        io_block_mapping(NVRAM_ADDR, NVRAM_ADDR, NVRAM_SIZE, _PAGE_IO);
        io_block_mapping(MBX_CSR_ADDR, MBX_CSR_ADDR, MBX_CSR_SIZE, _PAGE_IO);
        io_block_mapping(PCI_CSR_ADDR, PCI_CSR_ADDR, PCI_CSR_SIZE, _PAGE_IO);

#if !defined(CONFIG_PCI)
	/* Map some of the PCI/ISA I/O space to get the IDE interface.
	*/
        io_block_mapping(PCI_ISA_IO_ADDR, PCI_ISA_IO_ADDR, 0x4000, _PAGE_IO);
        io_block_mapping(PCI_IDE_ADDR, PCI_IDE_ADDR, 0x4000, _PAGE_IO);
#endif
#endif
#if defined(CONFIG_RPXLITE) || defined(CONFIG_RPXCLASSIC)
	io_block_mapping(RPX_CSR_ADDR, RPX_CSR_ADDR, RPX_CSR_SIZE, _PAGE_IO);
#if !defined(CONFIG_PCI)
	io_block_mapping(_IO_BASE,_IO_BASE,_IO_BASE_SIZE, _PAGE_IO);
#endif
#endif
#if defined(CONFIG_HTDMSOUND) || defined(CONFIG_RPXTOUCH) || defined(CONFIG_FB_RPX)
	io_block_mapping(HIOX_CSR_ADDR, HIOX_CSR_ADDR, HIOX_CSR_SIZE, _PAGE_IO);
#endif
#ifdef CONFIG_FADS
	io_block_mapping(BCSR_ADDR, BCSR_ADDR, BCSR_SIZE, _PAGE_IO);
	io_block_mapping(_IO_BASE,_IO_BASE,_IO_BASE_SIZE, _PAGE_IO);
#endif
#ifdef CONFIG_PCI
        io_block_mapping(PCI_ISA_IO_ADDR, PCI_ISA_IO_ADDR, PCI_ISA_IO_SIZE,
			 _PAGE_IO);
        io_block_mapping(PCI_CSR_ADDR, PCI_CSR_ADDR, PCI_CSR_SIZE, _PAGE_IO);
#endif
}

void __init
platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
		unsigned long r6, unsigned long r7)
{
	parse_bootinfo(find_bootinfo());

	if ( r3 )
		memcpy( (void *)__res,(void *)(r3+KERNELBASE), sizeof(bd_t) );

#ifdef CONFIG_BLK_DEV_INITRD
	/* take care of initrd if we have one */
	if ( r4 )
	{
		initrd_start = r4 + KERNELBASE;
		initrd_end = r5 + KERNELBASE;
	}
#endif /* CONFIG_BLK_DEV_INITRD */
	/* take care of cmd line */
	if ( r6 )
	{
		*(char *)(r7+KERNELBASE) = 0;
		strcpy(cmd_line, (char *)(r6+KERNELBASE));
	}

#ifdef CONFIG_PCI
	isa_io_base = _IO_BASE;
	isa_mem_base = _ISA_MEM_BASE;
	pci_dram_offset = PCI_DRAM_OFFSET;
#endif

	ppc_md.setup_arch		= m8xx_setup_arch;
	ppc_md.show_percpuinfo		= m8xx_show_percpuinfo;
	ppc_md.irq_cannonicalize	= NULL;
	ppc_md.init_IRQ			= m8xx_init_IRQ;
	ppc_md.get_irq			= m8xx_get_irq;
	ppc_md.init			= NULL;

	ppc_md.restart			= m8xx_restart;
	ppc_md.power_off		= m8xx_power_off;
	ppc_md.halt			= m8xx_halt;

	ppc_md.time_init		= NULL;
	ppc_md.set_rtc_time		= m8xx_set_rtc_time;
	ppc_md.get_rtc_time		= m8xx_get_rtc_time;
	ppc_md.calibrate_decr		= m8xx_calibrate_decr;

	ppc_md.find_end_of_memory	= m8xx_find_end_of_memory;
	ppc_md.setup_io_mappings	= m8xx_map_io;

	ppc_md.kbd_setkeycode		= NULL;
	ppc_md.kbd_getkeycode		= NULL;
	ppc_md.kbd_translate		= NULL;
	ppc_md.kbd_unexpected_up	= NULL;
	ppc_md.kbd_leds			= NULL;
	ppc_md.kbd_init_hw		= NULL;
	ppc_md.ppc_kbd_sysrq_xlate	= NULL;

#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
#if defined(CONFIG_BLK_DEV_MPC8xx_IDE)
	m8xx_ide_init();
#else
	ppc_ide_md.ide_request_region 	= m8xx_ide_request_region;
	ppc_ide_md.ide_release_region 	= m8xx_ide_release_region;
	ppc_ide_md.ide_check_region 	= m8xx_ide_check_region;
	ppc_ide_md.default_irq		= m8xx_ide_default_irq;
	ppc_ide_md.default_io_base	= m8xx_ide_default_io_base;
	/* The default ppc_ide_md.ide_init_hwif function is sufficient. */
#endif	/* if defined(CONFIG_BLK_DEV_MPC8xx_IDE) */
#endif	/* if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE) */

#ifdef CONFIG_DUMMY_CONSOLE
	conswitchp = &dummy_con;
#endif
}

--0-1518963006-1133234450=:4697--
