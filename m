Return-Path: <CFRIESEN@nortel.com>
Received: from zrtps0kp.nortel.com (zrtps0kp.nortel.com [47.140.192.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 7BE3CDDFF1
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 02:10:51 +1000 (EST)
Message-ID: <4A0AF0FD.9050501@nortel.com>
Date: Wed, 13 May 2009 10:10:37 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: question about softirqs
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
	<alpine.LFD.2.00.0905131751150.3561@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.00.0905131751150.3561@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
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

Thomas Gleixner wrote:
> On Wed, 13 May 2009, Chris Friesen wrote:

>> As far as I can tell, in this scenario softirqs may not get processed on
>> return from a syscall (contradicting the documentation).  In the worst
>> case, they may not get processed until the next timer tick.
> 
> Right because your high prio tasks prevents that ksoftirqd runs,
> because it can not preempt the high priority task.

Exactly.

I'm suggesting that this point (the idea that softirqs may or may not
get processed on return from syscall depending on relative task
priority) should probably be documented somewhere, because the current
documentation (in the kernel and on the web) doesn't mention it at all.

Maybe I should just submit a patch to
Documentation/DocBook/kernel-hacking.tmpl.

Chris
