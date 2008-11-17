Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 74297474CA
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 10:31:22 +1100 (EST)
Subject: Re: Large stack usage in fs code (especially for PPC64)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <alpine.DEB.1.10.0811171508300.8722@gandalf.stny.rr.com>
References: <alpine.DEB.1.10.0811171508300.8722@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Tue, 18 Nov 2008 10:30:27 +1100
Message-Id: <1226964627.7178.261.camel@pasglop>
Mime-Version: 1.0
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
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

On Mon, 2008-11-17 at 15:34 -0500, Steven Rostedt wrote:
> 
> I've been hitting stack overflows on a PPC64 box, so I ran the ftrace 
> stack_tracer and part of the problem with that box is that it can nest 
> interrupts too deep. But what also worries me is that there's some heavy 
> hitters of stacks in generic code. Namely the fs directory has some.

Note that we shouldn't stack interrupts much in practice. The PIC will
not let same or lower prio interrupts in until we have completed one.
However timer/decrementer is not going through the PIC, so I think what
happens is we get a hw IRQ, on the way back, just before returning from
do_IRQ (so we have completed the IRQ from the PIC standpoint), we go
into soft-irq's, at which point deep inside SCSI we get another HW IRQ
and we stack a decrementer interrupt on top of it.

Now, we should do stack switching for both HW IRQs and softirqs with
CONFIG_IRQSTACKS, which should significantly alleviate the problem.

Your second trace also shows how horrible the stack traces can be when
the device-model kicks in, ie, register->probe->register sub device ->
etc... that isnt going to be nice on x86 with 4k stacks neither. 

I wonder if we should generally recommend for drivers of "bus" devices
not to register sub devices from their own probe() routine, but defer
that to a kernel thread... Because the stacking can be pretty bad, I
mean, nobody's done SATA over USB yet but heh :-)

Cheers,
Ben.
