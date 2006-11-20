Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8520B67BE6
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Nov 2006 12:16:21 +1100 (EST)
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
	type IRQ handlers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20061119202348.GA27649@elte.hu>
References: <200611192243.34850.sshtylyov@ru.mvista.com>
	<1163966437.5826.99.camel@localhost.localdomain>
	<20061119200650.GA22949@elte.hu>
	<1163967590.5826.104.camel@localhost.localdomain>
	<20061119202348.GA27649@elte.hu>
Content-Type: text/plain
Date: Mon, 20 Nov 2006 12:16:19 +1100
Message-Id: <1163985380.5826.139.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, dwalker@mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> it's a compatibility hack only. Threaded handlers are a different type 
> of flow, but often the fasteoi handler is not changed to the threaded 
> handler so i changed it to be a threaded handler too.
> 
> threaded handlers need a mask() + an ack(), because that's the correct 
> model to map them to kernel threads - threaded handlers can be delayed 
> for a long time if something higher-prio is preempting them.

I've re-read the old thread and I disagree with you there. I think the
right approach was proposed initially by Daniel Walker.

If my understanding of "threaded handlers" is correct, that is delaying
the delivery of the interrupt to a thread while restoring the ability to
process further interrupts of the same or lower priority immediately.

There is no such thing as an explicit "ack" on fasteoi controllers. The
ack is implicit with the reading of the vector (either via a special
cycle on the bus or via reading the intack register for example on
mpic).

So by doing a mask followed by an eoi, you essentially mask the
interrupt preventing further delivery of that interrupt and lower the
CPU priority in the PIC thus allowing processing of further interrupts.

Are there other fasteoi controllers than the ones I have on powerpc
anyway ?

There is one thing I disagree with in the initial patch from Daniel
however, it's the fact that he can't deal with fasteoi handlers that
have no mask/unmask.

I have such a controller, on Cell, though currently I do have an empty
mask and unmask for it, I've been thinking about removing them (and
fixing callers to test for NULL). This is the Cell's top level
controller and it is edge only (at this level, on Cell, all interrupts
are messages).

Thus it can perfectly well cope with soft-masking (delayed disable if
you prefer) and that is compatible with using a fasteoi handler. There
should be no reason why that wouldn't work for -rt as well.

Ben.
