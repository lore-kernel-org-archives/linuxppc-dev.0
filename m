Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8BB0EDE064
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 07:44:44 +1100 (EST)
Subject: Re: Interrupt handling documentation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
In-Reply-To: <200803171713.51671.laurentp@cse-semaphore.com>
References: <200803111158.48540.laurentp@cse-semaphore.com>
	<1205283088.7544.8.camel@concordia.ozlabs.ibm.com>
	<200803131456.26722.laurentp@cse-semaphore.com>
	<200803171713.51671.laurentp@cse-semaphore.com>
Content-Type: text/plain
Date: Tue, 18 Mar 2008 07:44:05 +1100
Message-Id: <1205786645.26869.178.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2008-03-17 at 17:13 +0100, Laurent Pinchart wrote:

> The PIC I am working with is linked to a falling-edge external irq on the 
> CPM2. When the first PIC interrupt was generated the kernel called the PIC 
> chained irq handler endlessly.
> 
> After some investigation it turned out the external interrupt bit in the CPM2 
> interrupt pending register never got cleared. set_irq_chained_handler() 
> registers the chained irq handler at the lowest level in the irq stack, 
> bypassing all the interrupt acknowledgement/masking logic.

Yes, exactly. To answer a previous question in the thread, the reason
there are two approaches to cascades is just that:

 - The "easy" approach using setup_irq(). The normal interrupt handling
is done for the cascade, it's masked/acked/whatever-is-needed as any
other interrupt before the second interrupt is fetched. This results
is slightly more kernel stack usage and overhead in getting to the
second interrupt, among other things, but is easier.

 - The "fast" approach using a chained handler. This, as you noticed,
bypass pretty much the whole stack and calls the chain handler directly.
That means that your chain handler is responsible to perform all the
necessary things to ensure the cascade interrupt is properly ack'ed
etc...
 
> The fix was easy, all I had to do was to call desc->chip->ack(irq) at the 
> beginning on the chained irq handler and desc->chip->eoi(irq) at the end. 

For an edge cascade, that would do, I suppose. But beware that if you
are only calling ack() and not mask(), then a subsequent chain interrupt
from the same cascade can (and will) potentially happen while you are
calling the handler as the cascade itself has been ack'ed and not
masked. In the case of cpm2, that also probably means you don't need to
call end().

That might be fine though, but it increases the chances of having of
stack overflows caused by interrupts stacking up.

> However, I'm wondering if this really belongs in the PIC code, or if PICs 
> shouldn't be registered at a higher level (setup_irq or even request_irq) so 
> that they would reuse the handle_*_irq handlers. Any opinion on this ?

They can. The chain handling mechanism is an optimisation. It avoids a
spinlock and other bits & pieces which improve performance & latency of
handling cascaded interrupts, at the expense of that added complexity.

Ben.
