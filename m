Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6EB84DDE2B
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 11:55:39 +1000 (EST)
Subject: Re: [PATCH] synchronize_irq needs a barrier
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20071017184512.a1c647b2.akpm@linux-foundation.org>
References: <1192670742.12879.5.camel@pasglop>
	<20071017184512.a1c647b2.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Thu, 18 Oct 2007 11:55:23 +1000
Message-Id: <1192672523.12879.21.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > Index: linux-work/kernel/irq/manage.c
> > ===================================================================
> > --- linux-work.orig/kernel/irq/manage.c	2007-10-18 11:22:16.000000000 +1000
> > +++ linux-work/kernel/irq/manage.c	2007-10-18 11:22:20.000000000 +1000
> > @@ -33,6 +33,7 @@ void synchronize_irq(unsigned int irq)
> >  	if (irq >= NR_IRQS)
> >  		return;
> >  
> > +	smp_mb();
> >  	while (desc->status & IRQ_INPROGRESS)
> >  		cpu_relax();
> >  }
> 
> Anyone reading this code is going to ask "wtf is that for".  It needs a
> comment telling them.
> 
> 
> mb() is the new lock_kernel().  Sigh.

Ugh ?

That sounds fairly obvious to me :-) we are reading a value, that is
totally unordered, nothing to do about lock kernel or whatever, if we
want the above statement to make any sense in any kind of usage
scenario, it needs to be ordered vs. what happens before.

For example, take a construct like:

	device->my_hw_is_off = 1;
	synchronize_irq();
	turn_off_hardware();

That basically makes sure the irq either sees device->my_hw_is_off
being set to 1, or if an irq handler is already in progress and hasn't
seen it, we wait for it to complete.

(You can replace "hw_is_off" with anything that we want to set and make
sure the IRQ handler sees it before proceeding. It could be clearing a
pointer to something and make sure the irq sees it before freeing the
data, etc...).

I think pretty much any use of synchronize_irq() I can imagine needs
such kind of ordering... or it simply doesn't synchronize anything :-)

Cheers,
Ben.
