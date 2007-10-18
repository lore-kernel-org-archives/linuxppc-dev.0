Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 129DADDED0
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 09:53:13 +1000 (EST)
Subject: Re: [PATCH] synchronize_irq needs a barrier
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <alpine.LFD.0.999.0710181627091.26902@woody.linux-foundation.org>
References: <E1IiWnJ-0000ne-00@gondolin.me.apana.org.au>
	<1192745137.7367.40.camel@pasglop>
	<alpine.LFD.0.999.0710181549330.26902@woody.linux-foundation.org>
	<1192749449.7367.51.camel@pasglop>
	<alpine.LFD.0.999.0710181627091.26902@woody.linux-foundation.org>
Content-Type: text/plain
Date: Fri, 19 Oct 2007 09:52:33 +1000
Message-Id: <1192751553.7367.57.camel@pasglop>
Mime-Version: 1.0
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	akpm@linux-foundation.org, Ingo Molnar <mingo@elte.hu>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> So how about something like this (untested! not necessarily very well 
> thought through either!)
> 
> Basic notion: the only thing that serializes the IRQ_INPROGRESS flag is 
> the descriptor lock. And we don't have to (or even want to!) hold it while 
> waiting for the thing, but we want to *have*held*it* in between whatever 
> we're synchronizing with.
> 
> The internal irq handler functions already held the lock when they did 
> whatever they need to serialize - and they are possibly performance 
> critical too - so they use the "internal" function that doesn't get the 
> lock unnecessarily again.

That may do the trick as the read can't cross the spin_lock (it can
cross spin_unlock but not lock). Advantage over adding a barrier to
handle_IRQ_event() is that it keeps the overhead to the slow path
(synchronize_irq).

Note that I didn't actually experience a problem here. I just came upon
that by accident while thinking about a similar issue I have with
napi_synchronize().

Looks good to me on a first glance (unfortunately a bit ugly but heh).

Ben.
