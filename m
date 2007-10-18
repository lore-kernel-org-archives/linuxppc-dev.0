Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6E2D2DDE1E
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 09:18:17 +1000 (EST)
Subject: Re: [PATCH] synchronize_irq needs a barrier
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <alpine.LFD.0.999.0710181549330.26902@woody.linux-foundation.org>
References: <E1IiWnJ-0000ne-00@gondolin.me.apana.org.au>
	<1192745137.7367.40.camel@pasglop>
	<alpine.LFD.0.999.0710181549330.26902@woody.linux-foundation.org>
Content-Type: text/plain
Date: Fri, 19 Oct 2007 09:17:29 +1000
Message-Id: <1192749449.7367.51.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2007-10-18 at 15:52 -0700, Linus Torvalds wrote:
> 
> On Fri, 19 Oct 2007, Benjamin Herrenschmidt wrote:
> > 
> > The barrier would guarantee that ioc->active (and in fact the write to
> > the chip too above) are globally visible
> 
> No, it doesn't really guarantee that.
> 
> The thing is, there is no such thing as "globally visible".
> 
> There is a "ordering of visibility wrt CPU's", but it's not global, it's 
> quite potentially per-CPU. So a barrier on one CPU doesn't guarantee 
> anything at all without a barrier on the *other* CPU.
> 
> That said, the interrupt handling itself contains various barriers on the 
> CPU's that receive interrupts, thanks to the spinlocking. But I do agree 
> with Herbert that adding a "smb_mb()" is certainly in no way "obviously 
> correct", because it doesn't talk about what the other side does wrt 
> barriers and that word in memory.

I agree and you can see that in fact, we don't have enough barrier on
the other side since spin_unlock doesn't prevent subsequent loads from
crossing a previous store...

I wonder if that's worth trying to address, adding a barrier in
handle_IRQ_event for example, or we can continue ignoring the barrier
and let some drivers do their own fixes in fancy ways.

Ben.
