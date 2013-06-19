Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e37.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 12B422C031E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 14:09:32 +1000 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Tue, 18 Jun 2013 22:09:20 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 01AA219D803E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 22:09:09 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5J49HVi362836
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 22:09:17 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5J4Bg7W029793
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 22:11:43 -0600
Date: Tue, 18 Jun 2013 21:09:06 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: Regression in RCU subsystem in latest mainline kernel
Message-ID: <20130619040906.GA5146@linux.vnet.ibm.com>
References: <1626500.7WAVXjfS9F@pcimr>
 <20130614122800.GL5146@linux.vnet.ibm.com>
 <1645938.As0LR1yeVd@pcimr>
 <1371243967.9844.338.camel@gandalf.local.home>
 <1371261741.21896.20.camel@pasglop>
 <20130617074213.GA3589@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130617074213.GA3589@concordia>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Rojhalat Ibrahim <imr@rtschenk.de>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 17, 2013 at 05:42:13PM +1000, Michael Ellerman wrote:
> On Sat, Jun 15, 2013 at 12:02:21PM +1000, Benjamin Herrenschmidt wrote:
> > On Fri, 2013-06-14 at 17:06 -0400, Steven Rostedt wrote:
> > > I was pretty much able to reproduce this on my PA Semi PPC box. Funny
> > > thing is, when I type on the console, it makes progress. Anyway, it
> > > seems that powerpc has an issue with irq_work(). I'll try to get some
> > > time either tonight or next week to figure it out.
> > 
> > Does this help ?
> > 
> > diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> > index 5cbcf4d..ea185e0 100644
> > --- a/arch/powerpc/kernel/irq.c
> > +++ b/arch/powerpc/kernel/irq.c
> > @@ -162,7 +162,7 @@ notrace unsigned int __check_irq_replay(void)
> >  	 * in case we also had a rollover while hard disabled
> >  	 */
> >  	local_paca->irq_happened &= ~PACA_IRQ_DEC;
> > -	if (decrementer_check_overflow())
> > +	if ((happened & PACA_IRQ_DEC) || decrementer_check_overflow())
> >  		return 0x900;
> >  
> >  	/* Finally check if an external interrupt happened */
> > 
> 
> This seems to help, but doesn't elminate the RCU stall warnings I am
> seeing. I now see them less often, but not never.
> 
> Stack trace is something like:

Hmmm...  How many CPUs are on your system?  And how much work is
perf_event_for_each_child() having to do here?

If the amount of work is large and your kernel is built with
CONFIG_PREEMPT=n, the RCU CPU stall warning would be expected behavior.
If so, we might need a preemption point in perf_event_for_each_child().

							Thanx, Paul

>   INFO: rcu_sched detected stalls on CPUs/tasks: { 32} (detected by 12, t=21372 jiffies, g=18446744073709551503, c=18446744073709551502, q=1018)
>   Task dump for CPU 32:
>   power8-events   R  running task     4960  2009   1988 0x00000004
>   Call Trace:
>   [c000000fb0e3f910] [c000000fb0e3f9d0] 0xc000000fb0e3f9d0 (unreliable)
>   
>   [c000000fb0e3edc0] [c0000000000b2894] .__run_hrtimer+0xa4/0x2a0
>   [c000000fb0e3ee70] [c0000000000b36d8] .hrtimer_interrupt+0x148/0x320
>   [c000000fb0e3ef80] [c00000000001c754] .timer_interrupt+0x134/0x320
>   [c000000fb0e3f040] [c00000000000a4f4] restore_check_irq_replay+0x68/0xa8
>   --- Exception: 901 at .arch_local_irq_restore+0x24/0x90
>       LR = .__do_softirq+0x100/0x3a0
>   [c000000fb0e3f330] [c0000000000c4784] .vtime_account_irq_enter+0x34/0x70 (unreliable)
>   [c000000fb0e3f3a0] [c000000000089680] .__do_softirq+0x100/0x3a0
>   [c000000fb0e3f4c0] [c000000000089b38] .irq_exit+0xc8/0x110
>   [c000000fb0e3f540] [c00000000001c788] .timer_interrupt+0x168/0x320
>   [c000000fb0e3f600] [c0000000000025cc] decrementer_common+0x14c/0x180
>   --- Exception: 901 at .arch_local_irq_restore+0x74/0x90
>       LR = .arch_local_irq_restore+0x74/0x90
>   [c000000fb0e3f8f0] [c000000fb0e3f970] 0xc000000fb0e3f970 (unreliable)
>   [c000000fb0e3f960] [c0000000000e4ae0] .smp_call_function_single+0x1d0/0x1e0
>   [c000000fb0e3fa10] [c000000000147aa4] .task_function_call+0x54/0x70
>   [c000000fb0e3fab0] [c000000000147bc4] .perf_event_enable+0x104/0x1c0
>   [c000000fb0e3fb60] [c000000000146800] .perf_event_for_each_child+0x60/0x110
>   [c000000fb0e3fbf0] [c00000000014a528] .perf_ioctl+0x108/0x3f0
>   [c000000fb0e3fca0] [c0000000001d7138] .do_vfs_ioctl+0xb8/0x730
>   [c000000fb0e3fd80] [c0000000001d780c] .SyS_ioctl+0x5c/0xb0
>   [c000000fb0e3fe30] [c000000000009d54] syscall_exit+0x0/0x98
> 
> 
> cheers
> 
