Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17480.47308.126194.26202@cargo.ozlabs.ibm.com>
Date: Fri, 21 Apr 2006 20:49:48 +1000
From: Paul Mackerras <paulus@samba.org>
To: vatsa@in.ibm.com
Subject: Re: [PATCH 1/2] tickless idle cpus: core patch - v2
In-Reply-To: <20060410121847.GB5564@in.ibm.com>
References: <20060407063044.GA22416@in.ibm.com>
	<17462.61423.42032.559627@cargo.ozlabs.ibm.com>
	<20060410121847.GB5564@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Srivatsa Vaddagiri writes:

> This is the v2 of the core patch to skip ticks when a CPU is idle.
...
> +/* Returns 1 if this CPU was set in the mask */
> +static inline int clear_hzless_mask(void)
> +{
> +	int cpu = smp_processor_id();
> +	int rc = 0;
> +
> +	if (unlikely(cpu_isset(cpu, nohz_cpu_mask))) {
> +		cpu_clear(cpu, nohz_cpu_mask);

Is the nohz_cpu_mask accessed by other cpus?  I wonder if using a
1-byte per-cpu variable for this, or even a bit in the thread_info
struct, might be better because it would reduce the number of atomic
bit set/clear operations we have to do.

> +#define MAX_DEC_COUNT	UINT_MAX	/* Decrementer is 32-bit */

The decrementer value should be restricted to INT_MAX.  I think some
implementations will take a decrementer interrupt if you set the
decrementer to a negative value.

> +static void account_ticks(struct pt_regs *regs)
> +{
> +	int next_dec;
> +	int cpu = smp_processor_id();
> +	unsigned long ticks;
> +
>  	while ((ticks = tb_ticks_since(per_cpu(last_jiffy, cpu)))
>  	       >= tb_ticks_per_jiffy) {
>  		/* Update last_jiffy */

This is just the loop body from timer_interrupt, right?  Why do we
have to loop around N times after we skipped N ticks?  What we're
doing inside the loop is:

- account_process_time, but we know we were in the idle task, so the
  time is just idle time.  If we have the accurate accounting stuff
  turned on the first call to account_process_time will account all
  the idle time anyway.

- we're not skipping ticks on the boot cpu (yet), so we won't do the
  do_timer and timer_recalc_offset calls.

I think we could probably rearrange this code to eliminate the need
for the regs argument - all it's used for is telling whether we were
in user mode, and we know we weren't since we were in the idle task.
That would mean that we maybe could call start_hz_timer from the idle
task body instead of inside do_IRQ etc.  The only thing we'd have to
watch out for is updating the decrementer if some interrupt handler
called add_timer/mod_timer etc.

Assuming we make the changes we have discussed to reduce the skewing
of the decrementer interrupts quite small, and allow any cpu to call
do_timer, then how where you thinking that xtime and the NTP stuff
would get updated, in the situation where all cpus are skipping ticks?
By doing N calls to do_timer in a row?  Or by adding N-1 to jiffies_64
and then calling do_timer once?

> +#ifdef CONFIG_NO_IDLE_HZ
> +	max_skip = __USE_RTC() ? HZ : MAX_DEC_COUNT / tb_ticks_per_jiffy;
> +#endif

If we allow the boot cpu to skip ticks, then we will have to make sure
that at least one cpu wakes up in time to do the updating in
recalc_timer_offset.

Paul.
