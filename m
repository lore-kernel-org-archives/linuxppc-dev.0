Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e34.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 112992C0096
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 02:11:34 +1000 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Tue, 25 Jun 2013 10:11:30 -0600
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id DAD441FF0064
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 09:58:48 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5PG3luJ121022
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 10:03:51 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5PG630w003383
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 10:06:05 -0600
Date: Tue, 25 Jun 2013 09:03:32 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: Regression in RCU subsystem in latest mainline kernel
Message-ID: <20130625160332.GA3828@linux.vnet.ibm.com>
References: <1626500.7WAVXjfS9F@pcimr>
 <20130614122800.GL5146@linux.vnet.ibm.com>
 <1645938.As0LR1yeVd@pcimr>
 <1371243967.9844.338.camel@gandalf.local.home>
 <1371261741.21896.20.camel@pasglop>
 <20130617074213.GA3589@concordia>
 <20130619040906.GA5146@linux.vnet.ibm.com>
 <20130625071914.GA29957@concordia>
 <20130625074422.GB29957@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130625074422.GB29957@concordia>
Cc: Rojhalat Ibrahim <imr@rtschenk.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 25, 2013 at 05:44:23PM +1000, Michael Ellerman wrote:
> On Tue, Jun 25, 2013 at 05:19:14PM +1000, Michael Ellerman wrote:
> > 
> > Here's another trace from 3.10-rc7 plus a few local patches.
> 
> And here's another with CONFIG_RCU_CPU_STALL_INFO=y in case that's useful:
> 
> PASS running test_pmc5_6_overuse()
> INFO: rcu_sched self-detected stall on CPU
> 	8: (1 GPs behind) idle=8eb/140000000000002/0 softirq=215/220 

So this CPU has been out of action since before the beginning of the
current grace period ("1 GPs behind").  It is not idle, having taken
a pair of nested interrupts from process context (matching the stack
below).  This CPU has take five softirqs since the last grace period
that it noticed, which makes it likely that the loop is within the
softirq handler.

> 	 (t=2100 jiffies g=18446744073709551583 c=18446744073709551582 q=13)

Assuming HZ=100, this stall has been going on  for 21 seconds.  There
is a grace period in progress according to RCU's global state (which
this CPU is not yet aware of).  There are a total of 13 RCU callbacks
queued across the entire system.

If the system is at all responsive, I suggest using ftrace (either from
the boot command line or at runtime) to trace __do_softirq() and
hrtimer_interrupt().

							Thanx, Paul

> cpu 0x8: Vector: 0  at [c0000003ea03eae0]
>     pc: c00000000011d9b0: .rcu_check_callbacks+0x450/0x910
>     lr: c00000000011d9b0: .rcu_check_callbacks+0x450/0x910
>     sp: c0000003ea03ec40
>    msr: 9000000000009032
>   current = 0xc0000003ebf9f4a0
>   paca    = 0xc00000000fdc2400	 softe: 0	 irq_happened: 0x00
>     pid   = 2444, comm = power8-events
> enter ? for help
> [c0000003ea03ed70] c000000000094cd0 .update_process_times+0x40/0x90
> [c0000003ea03ee00] c0000000000df050 .tick_sched_handle.isra.13+0x20/0xa0
> [c0000003ea03ee80] c0000000000df2bc .tick_sched_timer+0x5c/0xa0
> [c0000003ea03ef20] c0000000000b3728 .__run_hrtimer+0x98/0x260
> [c0000003ea03efc0] c0000000000b4738 .hrtimer_interrupt+0x138/0x3c0
> [c0000003ea03f0d0] c00000000001cd34 .timer_interrupt+0x124/0x2f0
> [c0000003ea03f180] c00000000000a4f4 restore_check_irq_replay+0x68/0xa8
> --- Exception: 901 (Decrementer) at c000000000093ad4 .run_timer_softirq+0x74/0x360
> [c0000003ea03f580] c000000000089ac4 .__do_softirq+0x174/0x350
> [c0000003ea03f6a0] c000000000089ea8 .irq_exit+0xb8/0x100
> [c0000003ea03f720] c00000000001cd68 .timer_interrupt+0x158/0x2f0
> [c0000003ea03f7d0] c00000000000a4f4 restore_check_irq_replay+0x68/0xa8
> --- Exception: 901 (Decrementer) at c00000000014a520 .task_function_call+0x60/0x70
> [c0000003ea03fac0] c00000000014a634 .perf_event_enable+0x104/0x1c0 (unreliable)
> [c0000003ea03fb70] c0000000001495ec .perf_event_for_each_child+0x5c/0xf0
> [c0000003ea03fc00] c00000000014cd78 .perf_ioctl+0x108/0x400
> [c0000003ea03fca0] c0000000001d9aa0 .do_vfs_ioctl+0xb0/0x740
> [c0000003ea03fd80] c0000000001da188 .SyS_ioctl+0x58/0xb0
> [c0000003ea03fe30] c000000000009d54 syscall_exit+0x0/0x98
> --- Exception: c01 (System Call) at 00001fffffee03d0
> SP (3ffff5e7cc90) is in userspace
> 
> 
> cheers
> 
