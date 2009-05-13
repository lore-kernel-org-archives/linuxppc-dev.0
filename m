Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5752FDDEFA
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 01:54:44 +1000 (EST)
Date: Wed, 13 May 2009 17:54:03 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Chris Friesen <cfriesen@nortel.com>
Subject: Re: question about softirqs
In-Reply-To: <4A0AE19D.9040509@nortel.com>
Message-ID: <alpine.LFD.2.00.0905131751150.3561@localhost.localdomain>
References: <18948.63755.279732.294842@cargo.ozlabs.ibm.com>
	<20090508.234815.127227651.davem@davemloft.net>
	<4A086DB2.8040703@nortel.com>
	<20090511.162436.193717082.davem@davemloft.net>
	<4A08C62F.1050105@nortel.com> <20090512081237.GA16403@elte.hu>
	<4A09933B.8010606@nortel.com> <874ovpmmdq.fsf@basil.nowhere.org>
	<4A0AC9EC.6070908@nortel.com>
	<20090513141532.GT19296@one.firstfloor.org>
	<alpine.LFD.2.00.0905131612180.3561@localhost.localdomain>
	<87my9hkrmw.fsf@basil.nowhere.org> <4A0AE19D.9040509@nortel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, netdev@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	Andi Kleen <andi@firstfloor.org>, paulus@samba.org,
	Ingo Molnar <mingo@elte.hu>, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 13 May 2009, Chris Friesen wrote:
> Andi Kleen wrote:
> > Thomas Gleixner <tglx@linutronix.de> writes:
> 
> >>Err, no. Chris is completely correct:
> >>
> >>        if (!in_interrupt())
> >>		wakeup_softirqd();
> > 
> > Yes you have to wake it up just in case, but it doesn't normally
> > process the data because a normal softirq comes in faster. It's
> > just a safety policy. 
> 
> What about the scenario I raised earlier, where we have incoming network
> packets, no hardware interrupts coming in other than the timer tick, and
> a high-priority userspace app is spinning on recvmsg() with MSG_DONTWAIT
> set?
> 
> As far as I can tell, in this scenario softirqs may not get processed on
> return from a syscall (contradicting the documentation).  In the worst
> case, they may not get processed until the next timer tick.

Right because your high prio tasks prevents that ksoftirqd runs,
because it can not preempt the high priority task.

Thanks,

	tglx
