Return-Path: <vatsa@in.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D43F5679F4
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Apr 2006 01:41:57 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3OFfrKI025361
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Apr 2006 11:41:53 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3OFfr3O229642
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Apr 2006 11:41:53 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k3OFfq1C013859
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Apr 2006 11:41:53 -0400
Date: Mon, 24 Apr 2006 21:09:53 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/2] tickless idle cpus: core patch - v2
Message-ID: <20060424153953.GA4934@in.ibm.com>
References: <20060407063044.GA22416@in.ibm.com>
	<17462.61423.42032.559627@cargo.ozlabs.ibm.com>
	<20060410121847.GB5564@in.ibm.com>
	<17480.47308.126194.26202@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17480.47308.126194.26202@cargo.ozlabs.ibm.com>
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

Paul,
	At the outset I am slightly confused on whether you are
proposing to allow boot cpus to skip ticks or not. A clarification on
this will help!

On Fri, Apr 21, 2006 at 08:49:48PM +1000, Paul Mackerras wrote:
> Is the nohz_cpu_mask accessed by other cpus?  I wonder if using a

Yes, nohz_cpu_mask can be accessed by other CPUs, as part of RCU batch
processing.

> 1-byte per-cpu variable for this, or even a bit in the thread_info
> struct, might be better because it would reduce the number of atomic
> bit set/clear operations we have to do.

Agreed that updating a global bitmask is not a scalable thing to do. But
unfortunately this is tied to RCU implementation ATM. I know that Dipankar has 
plans to get rid of nohz_cpu_mask in the RCU implementation. When that happens, 
maybe we can revist this.

> > +#define MAX_DEC_COUNT	UINT_MAX	/* Decrementer is 32-bit */
> 
> The decrementer value should be restricted to INT_MAX.  I think some
> implementations will take a decrementer interrupt if you set the
> decrementer to a negative value.

Ok. Thanks for pointing it out.

> > +static void account_ticks(struct pt_regs *regs)
> > +{
> > +	int next_dec;
> > +	int cpu = smp_processor_id();
> > +	unsigned long ticks;
> > +
> >  	while ((ticks = tb_ticks_since(per_cpu(last_jiffy, cpu)))
> >  	       >= tb_ticks_per_jiffy) {
> >  		/* Update last_jiffy */
> 
> This is just the loop body from timer_interrupt, right?  Why do we

Correct. Note that this loop body is common to both timer_interrupt and 
start_hz_timer currently.

> have to loop around N times after we skipped N ticks?  What we're
> doing inside the loop is:
> 
> - account_process_time, but we know we were in the idle task, so the
>   time is just idle time.  If we have the accurate accounting stuff
>   turned on the first call to account_process_time will account all
>   the idle time anyway.

Do you mean to say that "the first call to account_system_vtime will account 
all the idle time"? AFAICS account_process_time (->account_process_vtime) is
accounting just usertime.

I had a related question: if we put the idle CPU to some power-saving
state in the period that it is tickless, would its PURR value keep
getting incremented? If not, would that affect the idle time we
calculate after skipping N ticks (in case accurate acct is turned ON
that is)?

> - we're not skipping ticks on the boot cpu (yet), so we won't do the
>   do_timer and timer_recalc_offset calls.

Don't follow you here. I thought we wanted to let the boot cpu to skip
ticks too (as you seem to indicate down below - while talking of
updating xtime/NTP)? If we want to allow that, then we need to be able to
call do_timer with a regs argument?

> I think we could probably rearrange this code to eliminate the need
> for the regs argument - all it's used for is telling whether we were
> in user mode, and we know we weren't since we were in the idle task.
> That would mean that we maybe could call start_hz_timer from the idle
> task body instead of inside do_IRQ etc.  The only thing we'd have to
> watch out for is updating the decrementer if some interrupt handler
> called add_timer/mod_timer etc.

One problem in deferring the call to start_hz_timer like this is RCU. Ideally
we want to clear the tickless idle-CPU from nohz_cpu_mask -as soon- as it
starts processing an interrupt. Otherwise RCU will think that the CPU is in
tickless state (hence not accessing RCU-protected data structures) while the 
idle-CPU is processing interrupts/softirqs and will not include the CPU in its
grace-period processing. This may be a bad thing to allow. 

The other problem in deferring a call to start_hz_timer is we could cause them 
to be running with an incorrect jiffy value (can happen if all cpus were
skipping ticks for a period).

IMO we should let start_hz_timer be called as it is being called now, i.e
immediately when a tickless idle-CPU wakes up. This would also
unfortunately mean that we need to embed calls to start_hz_timer from all
the interrupt paths (do_IRQ, performance_monitor_exception etc) where we
come out of tickless state.

> Assuming we make the changes we have discussed to reduce the skewing
> of the decrementer interrupts quite small, and allow any cpu to call
> do_timer, then how where you thinking that xtime and the NTP stuff
> would get updated, in the situation where all cpus are skipping ticks?
> By doing N calls to do_timer in a row?  Or by adding N-1 to jiffies_64
> and then calling do_timer once?

I assume this implies we want to let boot-cpu to skip ticks?

Ideally it would be good if we add N-1 to jiffies_64 and call do_timer
once. But I wonder if it can be done w/o being racy. In order to calculate
N, we may calculate the difference, delta, between current timebase and
tb_last_stamp as:

	delta = tb_ticks_since(tb_last_stamp);	-> Step 1

We may then calculate N as:

	N = delta / tb_ticks_per_jiffy;		-> Step 2

However this will be racy, if we happen to sample timebase (Step 1) just
before a jiffy boundary. In which case, we would have missed to update
jiffy by 1? To avoid this, we may need to check for the corner case and
introduce a 'goto retry' loop?

BTW, I realized that my patch to let boot cpu to skip ticks also is
slightly buggy here:

                if (cpu != do_timer_cpu)
                       continue;

                write_seqlock(&xtime_lock);
		...
                do_timer(regs);
		...
                write_sequnlock(&xtime_lock);

There needs to a different while loop to call do_timer based on 
tb_ticks_since(tb_last_stamp). Will fix it next time around.

> 
> > +#ifdef CONFIG_NO_IDLE_HZ
> > +	max_skip = __USE_RTC() ? HZ : MAX_DEC_COUNT / tb_ticks_per_jiffy;
> > +#endif
> 
> If we allow the boot cpu to skip ticks, then we will have to make sure
> that at least one cpu wakes up in time to do the updating in
> recalc_timer_offset.

Good point. However is this critical, especially if all cpus had been
idle for quite a while? As I understand, if we don't wakeup in time to
do timer_recalc_offset, the only drawback is the first gettimeofday will
be slow (because it has make a system call)?



-- 
Regards,
vatsa
