Return-Path: <arnd@arndb.de>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 086631A098C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 23:08:05 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linuxppc-dev@ozlabs.org, thuth@redhat.com
Subject: Re: [PATCH 1/6] powerpc/kconfig: Move NR_IRQS into "Kernel Options"
Date: Tue, 13 Oct 2015 14:07:53 +0200
Message-ID: <7228646.CdUrxvyAOh@wuerfel>
In-Reply-To: <1444696086.5383.3.camel@ellerman.id.au>
References: <1444338557-14988-1-git-send-email-mpe@ellerman.id.au>
 <5354986.Emc3ODSKdL@wuerfel> <1444696086.5383.3.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 13 October 2015 11:28:06 Michael Ellerman wrote:
> On Mon, 2015-10-12 at 13:50 +0200, Arnd Bergmann wrote:
> > On Monday 12 October 2015 22:07:45 Michael Ellerman wrote:
> > > Yeah, this builds and boots at least on pseries KVM.
> > > 
> > > diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/irq.h
> > > index e8e3a0a04eb0..35fba282b7f9 100644
> > > --- a/arch/powerpc/include/asm/irq.h
> > > +++ b/arch/powerpc/include/asm/irq.h
> > > @@ -23,11 +23,8 @@ extern atomic_t ppc_n_lost_interrupts;
> > >  /* This number is used when no interrupt has been assigned */
> > >  #define NO_IRQ                 (0)
> > >  
> > > -/* Total number of virq in the platform */
> > > -#define NR_IRQS                CONFIG_NR_IRQS
> > > -
> > > -/* Same thing, used by the generic IRQ code */
> > >  #define NR_IRQS_LEGACY         NUM_ISA_INTERRUPTS
> > > +#define NR_IRQS                        NR_IRQS_LEGACY
> > >  
> > >  extern irq_hw_number_t virq_to_hw(unsigned int virq);
> > >  
> > 
> > This looks like the way it's intended.
> 
> Hmm, though IRQ_BITMAP_BITS is still a hard limit, and by default it's set to
> NR_IRQS + 8196.

Ah, I wasn't aware of this limit.

> So we'd be relying on the + 8196 to get us up to a reasonable number. That
> looks like it was added as a bit of a hack/bug-fix, so I'm not sure we want to
> rely on it. (c1ee6264280e ("genirq: Prevent access beyond allocated_irqs
> bitmap"))
> 
> All the distros seem to run with NR_IRQS=512, so it seems no one has needed
> more than that or we would have heard about it presumably.
> 
> At the same time if we're only spending a single bit for each interrupt number
> maybe we should just set it to min(512, NR_CPUS) or something like that to make
> sure it's always reasonably big.

The NR_IRQS part is what consumes actual kernel memory, and it may hurt you
on some of the older embedded machines with small RAM. Reducing this is of
course the main idea behind CONFIG_SPARSE_IRQ, and I don't see any indication
that we ever need more than NR_IRQS_LEGACY here.

It's the +8196 part I'd be more worried about for large systems, as you say
it has been picked arbitrarily, and can easily be too small if you have
hundreds or thousands of CPU cores.

Maybe we could change the IRQ_BITMAP_BITS to have use

#define IRQ_BITMAP_BITS (NR_IRQS_LEGACY + MAX_NUMNODES * 8192)

which leaves it as it is on small machines, but gives large NUMA machines
(which should always have enough RAM anyway) some more room.

	Arnd 
