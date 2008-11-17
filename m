Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id 82C48DDE21
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 10:30:57 +1100 (EST)
Date: Mon, 17 Nov 2008 18:30:53 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Large stack usage in fs code (especially for PPC64)
In-Reply-To: <18721.60712.438025.564030@cargo.ozlabs.ibm.com>
Message-ID: <alpine.DEB.1.10.0811171829140.26123@gandalf.stny.rr.com>
References: <alpine.DEB.1.10.0811171508300.8722@gandalf.stny.rr.com>
	<alpine.DEB.1.10.0811171557370.26123@gandalf.stny.rr.com>
	<18721.60712.438025.564030@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 18 Nov 2008, Paul Mackerras wrote:

> Steven Rostedt writes:
> 
> > Here's my stack after boot up with CONFIG_IRQSTACKS set. Seems that 
> > softirqs still use the same stack as the process.
> 
> They shouldn't.  I don't see do_softirq in the trace, though.  Which
> functions did you think would be run in a softirq?  It looks to me
> like the deepest 10 or so functions are called at hard irq level,
> within hrtimer_interrupt called from timer_interrupt.
> 
> > root@electra ~> cat /debug/tracing/stack_trace 
> >         Depth   Size      Location    (59 entries)
> >         -----   ----      --------
> >   0)    12384     192   ftrace_call+0x4/0x14
> >   1)    12192     128   .sched_clock+0x20/0x60
> >   2)    12064     128   .sched_clock_cpu+0x34/0x50
> >   3)    11936     144   .cpu_clock+0x3c/0xa0
> >   4)    11792     144   .get_timestamp+0x2c/0x50
> >   5)    11648     144   .__touch_softlockup_watchdog+0x3c/0x60
> >   6)    11504     192   .softlockup_tick+0xe4/0x220
> >   7)    11312     128   .run_local_timers+0x34/0x50
> >   8)    11184     160   .update_process_times+0x44/0xb0
> >   9)    11024     176   .tick_sched_timer+0x8c/0x120
> >  10)    10848     160   .__run_hrtimer+0xd8/0x130
> >  11)    10688     240   .hrtimer_interrupt+0x16c/0x220
> >  12)    10448     160   .timer_interrupt+0xcc/0x110
> >  13)    10288      96   decrementer_common+0xe0/0x100

Ah, you are right. I thought I saw softirq code in there, but must have 
been seeing things. I need to get my eyesight checked. The other day I 
totally botch a hand in cards because I thought I had 3 Aces of diamonds 
when I really only had 2 Aces of diamonds and a Ace of hearts.

-- Steve
