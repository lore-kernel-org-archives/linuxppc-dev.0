Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B11CADDFC9
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 00:42:10 +1000 (EST)
Date: Wed, 13 May 2009 16:17:08 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Andi Kleen <andi@firstfloor.org>
Subject: Re: question about softirqs
In-Reply-To: <20090513141532.GT19296@one.firstfloor.org>
Message-ID: <alpine.LFD.2.00.0905131612180.3561@localhost.localdomain>
References: <18948.63755.279732.294842@cargo.ozlabs.ibm.com>
	<20090508.234815.127227651.davem@davemloft.net>
	<4A086DB2.8040703@nortel.com>
	<20090511.162436.193717082.davem@davemloft.net>
	<4A08C62F.1050105@nortel.com> <20090512081237.GA16403@elte.hu>
	<4A09933B.8010606@nortel.com> <874ovpmmdq.fsf@basil.nowhere.org>
	<4A0AC9EC.6070908@nortel.com>
	<20090513141532.GT19296@one.firstfloor.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, netdev@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	paulus@samba.org, Ingo Molnar <mingo@elte.hu>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 13 May 2009, Andi Kleen wrote:

> > "If a soft irq is raised in process context, raise_softirq() in
> > kernel/softirq.c calls wakeup_softirqd() to make sure that ksoftirqd
> 
> softirqd is only used when the softirq runs for too long or when
> there are no suitable irq exits for a long time.
> 
> In normal situations (not excessive time in softirq) they don't
> do anything. 

Err, no. Chris is completely correct:

        if (!in_interrupt())
		wakeup_softirqd();

We can not rely on irqs coming in when the softirq is raised from
thread context. An irq_exit might be faster to process it than the
scheduler can schedule ksoftirqd in, but ksoftirqd is woken and runs
nevertheless. If it finds a softirq pending then it processes them in
it's context and irq_exit calls to softirq are returning right away.

Thanks,

	tglx
