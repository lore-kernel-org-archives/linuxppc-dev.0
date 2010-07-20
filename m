Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by ozlabs.org (Postfix) with ESMTP id D86C5B70BE
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 15:40:07 +1000 (EST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glppd-linuxppc64-dev@m.gmane.org>)
	id 1Ob5Yh-00029A-7K
	for linuxppc-dev@ozlabs.org; Tue, 20 Jul 2010 07:40:03 +0200
Received: from pool-98-108-155-204.ptldor.fios.verizon.net ([98.108.155.204])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 07:40:03 +0200
Received: from dvhltc by pool-98-108-155-204.ptldor.fios.verizon.net with
	local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 07:40:03 +0200
To: linuxppc-dev@ozlabs.org
From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: Badness in =?utf-8?b?eGljc19pcGlfZGlzcGF0Y2g=?=
Date: Tue, 20 Jul 2010 05:35:07 +0000 (UTC)
Message-ID: <loom.20100720T073225-150@post.gmane.org>
References: <4BCE27E8.4090101@linux.vnet.ibm.com>
	<1271814234.13262.36.camel@concordia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <michael <at> ellerman.id.au> writes:

> 
> On Tue, 2010-04-20 at 17:17 -0500, Brian King wrote:
> > In stress testing enabling and disabling of SMT, we are regularly
> > seeing the badness warning below. Looking through the cpu offline
> > path, this is what I see:
> > 
> > 1. stop_cpu: IRQ's get disabled
> > 2. pseries_cpu_disable: set cpu offline (no barriers after this)
> > 3. xics_migrate_irqs_away: Remove ourselves from the GIQ, but still allow
> >     IPIs
> > 4. stop_cpu: IRQ's get enabled again (local_irq_enable)
> > 
> > It looks to me like there is plenty of opportunity between 1 and 2 for
> > an IPI to get queued, resulting in the badness below. Is there something
> > in xics_migrate_irqs_away that should clear any pending IPIs?

Is that not what this does?

	/* Reject any interrupt that was queued to us... */
	xics_set_cpu_priority(0);

	/* Remove ourselves from the global interrupt queue */
	xics_set_cpu_giq(default_distrib_server, 0);

I thought the above would clear any pending (queued) interrupts and disable 
additional interrupts from coming in. Of course the next line allows IPIs again"

	/* Allow IPIs again... */
	xics_set_cpu_priority(DEFAULT_PRIORITY);

Which I confess I really don't get...


> > If there
> > is, maybe the solution is as simple as adding a barrier after marking
> > the cpu offline. Or is the warning bogus and we should just remove it?
> 
> It looks like xics_migrate_irqs_away() doesn't do anything about IPIs,
> at least the comment says "Allow IPIs again". So I don't see what's to
> stop you just taking another IPI after you reenable interrupts in
> stop_cpu(). Maybe xics_ipi_dispatch() should just return if the cpu is
> offline?

We're seeing something possibly related in real-time. Notice how the decrementer 
handler interrupts stop_cpu(). Is the decrementer interrupt delivered as an IPI?

cpu 0x3: Vector: 700 (Program Check) at [c000000084d02d90]
    pc: c000000000068af4: .__might_sleep+0x11c/0x148
    lr: c000000000068af0: .__might_sleep+0x118/0x148
    sp: c000000084d03010
   msr: 8000000000021032
  current = 0xc000000086658240
  paca    = 0xc000000000bb8a80
    pid   = 4045, comm = kstop/3
kernel BUG at kernel/sched.c:10168!
enter ? for help
[c000000084d030b0] c0000000006a2798 .rt_spin_lock+0x4c/0x9c
[c000000084d03140] c0000000000e3c98 .cpuset_cpus_allowed_locked+0x38/0x74
[c000000084d031e0] c000000000070be0 .select_fallback_rq+0x10c/0x1a4
[c000000084d032a0] c00000000007cda8 .try_to_wake_up+0x1b0/0x540
[c000000084d03370] c00000000007d2e8 .wake_up_process+0x34/0x48
[c000000084d03400] c00000000008c5f8 .wakeup_softirqd+0x78/0x9c
[c000000084d03490] c00000000008c8e4 .raise_softirq+0x6c/0xa4
[c000000084d03520] c000000000099c18 .run_local_timers+0x2c/0x4c
[c000000084d035a0] c000000000099c90 .update_process_times+0x58/0x9c
[c000000084d03640] c0000000000c2e70 .tick_sched_timer+0xd0/0x120
[c000000084d036f0] c0000000000b4bec .__run_hrtimer+0x1a0/0x29c
[c000000084d037a0] c0000000000b558c .hrtimer_interrupt+0x21c/0x394
[c000000084d038d0] c0000000000307d8 .timer_interrupt+0x1dc/0x2e4
[c000000084d03970] c000000000003700 decrementer_common+0x100/0x180
--- Exception: 901 (Decrementer) at c00000000000d144 
.raw_local_irq_restore+0x48/0x54
[link register   ] c0000000000e57ec .stop_cpu+0x1c0/0x1ec
[c000000084d03c60] c00000000104a4f0 (unreliable)
[c000000084d03ca0] c0000000000e5780 .stop_cpu+0x154/0x1ec
[c000000084d03d40] c0000000000a8b84 .worker_thread+0x25c/0x338
[c000000084d03e60] c0000000000af8c8 .kthread+0xb8/0xc4
[c000000084d03f90] c000000000034408 .kernel_thread+0x54/0x70

Thanks,

Darren Hart
