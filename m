Return-Path: <andi@firstfloor.org>
Received: from one.firstfloor.org (one.firstfloor.org [213.235.205.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CDBFEDDFD1
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 00:24:30 +1000 (EST)
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: question about softirqs
From: Andi Kleen <andi@firstfloor.org>
References: <18948.63755.279732.294842@cargo.ozlabs.ibm.com>
	<20090508.234815.127227651.davem@davemloft.net>
	<4A086DB2.8040703@nortel.com>
	<20090511.162436.193717082.davem@davemloft.net>
	<4A08C62F.1050105@nortel.com> <20090512081237.GA16403@elte.hu>
	<4A09933B.8010606@nortel.com> <874ovpmmdq.fsf@basil.nowhere.org>
	<4A0AC9EC.6070908@nortel.com>
	<20090513141532.GT19296@one.firstfloor.org>
	<alpine.LFD.2.00.0905131612180.3561@localhost.localdomain>
Date: Wed, 13 May 2009 16:24:23 +0200
In-Reply-To: <alpine.LFD.2.00.0905131612180.3561@localhost.localdomain>
	(Thomas Gleixner's message of "Wed,
	13 May 2009 16:17:08 +0200 (CEST)")
Message-ID: <87my9hkrmw.fsf@basil.nowhere.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Thomas Gleixner <tglx@linutronix.de> writes:


> Err, no. Chris is completely correct:
>
>         if (!in_interrupt())
> 		wakeup_softirqd();

Yes you have to wake it up just in case, but it doesn't normally
process the data because a normal softirq comes in faster. It's
just a safety policy. 

You can check this by checking the accumulated CPU time on your
ksoftirqs.  Mine are all 0 even on long running systems.

The reason Andrea originally added the softirqds was just that
if you have very softirq intensive workloads they would tie
up too much CPU time or not make enough process with the default
"don't loop too often" heuristics. 

> We can not rely on irqs coming in when the softirq is raised from

You can't rely on it, but it happens in near all cases.

-Andi
-- 
ak@linux.intel.com -- Speaking for myself only.
