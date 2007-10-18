Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 71C77DDE43
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 12:41:09 +1000 (EST)
Subject: Re: [PATCH] synchronize_irq needs a barrier
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <alpine.LFD.0.999.0710171906150.26902@woody.linux-foundation.org>
References: <1192670742.12879.5.camel@pasglop>
	<alpine.LFD.0.999.0710171906150.26902@woody.linux-foundation.org>
Content-Type: text/plain
Date: Thu, 18 Oct 2007 12:40:54 +1000
Message-Id: <1192675254.12879.29.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	akpm <akpm@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2007-10-17 at 19:12 -0700, Linus Torvalds wrote:
> 
> So, what exactly does it protect against? At a minimum, this needs a 
> comment in the changelog, and probably preferably in the source code too.

I replied to Andrew, but I agree, it's worth a comment, I'll add one.

> The thing is, synchronize_irq() can only protect against interrupts that 
> are *already*running* on another CPU, and the caller must have made sure 
> that no new interrupts are coming in (or at least that whatever new 
> interrupts that come in will not pick up a certain piece of data). 
> 
> So I can imagine that the smb_mb() is there so that the caller - who has 
> cleared some list or done something like that - will have any preceding 
> writes that it did be serialized with actually checking the old state of 
> "desc->status".

Yes.

> Fair enough - I can see that a smp_mb() is useful. But I think it needs 
> documenting as such, and preferably with an example of how this actually 
> happened in the first place (do you have one?)

One could argue that it's the caller that should do the mb() but that
would really be asking for trouble. Since most usage scenario require
it, and it's not a hot path, I prefer having it here.

Note that some kind of read barrier or compiler barrier should be needed
regardless, or we are just not sync'ing with anything at all (we may
have loaded the value ages ago and thus operate on a totally stale
value). I prefer a full barrier to also ensure all previous stores are
pushed out.

> The synchronize_irq() users that are really fundamental (ie the irq 
> datastructures themselves) all should use the irq descriptor spinlock, and 
> should *not* be needing any of this, since they would have serialized with 
> whoever actually set the IRQ_INPROGRESS bit in the first place.

That isn't always the case. You can have very efficient lock-less fast
path and use synchronize_irq as a kind of RCU-like way to have the slow
path do the right thing.

> So in *that* sense, I think the memory barrier is useless, and I can't 
> make up my mind whether it's good or bad. Which is why I'd really like to 
> have an example scenario spelled out where it makes a difference..

Well, typically, I can clear a pointer and want to make sure my IRQ
handler isn't using it anymore before freeing the memory. Or set a "HW
is off" flag. Having spinlocks all over isn't always the best approach
on things that are really hot path, it's fair enough to use lockless
approaches like that by moving the burden to the slow path that does
synchronize_irq.

In general, I tend to think that for this function to make any sense
(that is, to synchronize anything at all), it needs a barrier or you are
just making a decision based on a totally random value of desc->status
since it can have been re-ordered, speculatively loaded, pre-fetched,
whatever'ed... :-).

Want a respin with a comment ?

Ben.
