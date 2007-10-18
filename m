Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7680BDDE44
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 12:57:24 +1000 (EST)
Subject: Re: [PATCH] synchronize_irq needs a barrier
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <1192675254.12879.29.camel@pasglop>
References: <1192670742.12879.5.camel@pasglop>
	<alpine.LFD.0.999.0710171906150.26902@woody.linux-foundation.org>
	<1192675254.12879.29.camel@pasglop>
Content-Type: text/plain
Date: Thu, 18 Oct 2007 12:57:15 +1000
Message-Id: <1192676235.12879.40.camel@pasglop>
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


> 
> In general, I tend to think that for this function to make any sense
> (that is, to synchronize anything at all), it needs a barrier or you are
> just making a decision based on a totally random value of desc->status
> since it can have been re-ordered, speculatively loaded, pre-fetched,
> whatever'ed... :-).

Take a real life example:

drivers/message/fusion/mptbase.c

	/* Disable interrupts! */
	CHIPREG_WRITE32(&ioc->chip->IntMask, 0xFFFFFFFF);

	ioc->active = 0;
	synchronize_irq(pdev->irq);

And we aren't in a spinlock here. 

That's just a random example grepped.... I think I see a few more. Then,
some drivers like tg3 actually do an smp_mb() before calling
synchronize_irq(). But then, some don't.

I think trying to have all drivers be correct here is asking for
trouble, we'd rather have synchronize_irq() be uber-safe. It's not like
it was used in hot path anyway.

Ben.
