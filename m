Return-Path: <herbert@gondor.apana.org.au>
Received: from arnor.apana.org.au (rhun.apana.org.au [64.62.148.172])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 55C06DE35C
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 00:56:28 +1000 (EST)
From: Herbert Xu <herbert@gondor.apana.org.au>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] synchronize_irq needs a barrier
In-Reply-To: <1192676235.12879.40.camel@pasglop>
Message-Id: <E1IiWnJ-0000ne-00@gondolin.me.apana.org.au>
Date: Thu, 18 Oct 2007 22:56:17 +0800
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> Take a real life example:
> 
> drivers/message/fusion/mptbase.c
> 
>        /* Disable interrupts! */
>        CHIPREG_WRITE32(&ioc->chip->IntMask, 0xFFFFFFFF);
> 
>        ioc->active = 0;
>        synchronize_irq(pdev->irq);
> 
> And we aren't in a spinlock here. 
> 
> That's just a random example grepped.... I think I see a few more. Then,
> some drivers like tg3 actually do an smp_mb() before calling
> synchronize_irq(). But then, some don't.

I really don't see what the point of the barrier would be here.
Barriers are generally useless unless you have a counter-part
on the other side.

The counterpart here is presumably the interrupt handler, which
should be terminated by the IO write above regardless of the
memory barrier.

Of course I might have missed your point.  If so please give
a description like this for the race that you see:

CPU1			CPU2
disable IRQ
			whatever the race is
synchronize_irq

> I think trying to have all drivers be correct here is asking for
> trouble, we'd rather have synchronize_irq() be uber-safe. It's not like
> it was used in hot path anyway.

While in general I'd agree with you about give latitude to
drivers, memory barriers I think is something that we can't
afford to.

The reason is that memory barries tend to come in pairs, e.g.,

CPU1			CPU2
write A
wmb
write B
			read B
			rmb
			read A

Taking away either barrier would render the other useless.

So whenever we add only one barrier for the benefit of driver
writers who don't bother to think about barriers we may not
be helping them at all.

In any case, such writers should use easier tools like spin
locks rather than trying to go lockless.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
