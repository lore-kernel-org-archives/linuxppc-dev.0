Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B19B71A0287
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 11:28:06 +1100 (AEDT)
Message-ID: <1444696086.5383.3.camel@ellerman.id.au>
Subject: Re: [PATCH 1/6] powerpc/kconfig: Move NR_IRQS into "Kernel Options"
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org, linuxppc-dev@ozlabs.org, thuth@redhat.com
Date: Tue, 13 Oct 2015 11:28:06 +1100
In-Reply-To: <5354986.Emc3ODSKdL@wuerfel>
References: <1444338557-14988-1-git-send-email-mpe@ellerman.id.au>
 <7516455.YEROTAngT1@wuerfel> <1444648065.31951.3.camel@ellerman.id.au>
 <5354986.Emc3ODSKdL@wuerfel>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-10-12 at 13:50 +0200, Arnd Bergmann wrote:
> On Monday 12 October 2015 22:07:45 Michael Ellerman wrote:
> > Yeah, this builds and boots at least on pseries KVM.
> > 
> > diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/irq.h
> > index e8e3a0a04eb0..35fba282b7f9 100644
> > --- a/arch/powerpc/include/asm/irq.h
> > +++ b/arch/powerpc/include/asm/irq.h
> > @@ -23,11 +23,8 @@ extern atomic_t ppc_n_lost_interrupts;
> >  /* This number is used when no interrupt has been assigned */
> >  #define NO_IRQ                 (0)
> >  
> > -/* Total number of virq in the platform */
> > -#define NR_IRQS                CONFIG_NR_IRQS
> > -
> > -/* Same thing, used by the generic IRQ code */
> >  #define NR_IRQS_LEGACY         NUM_ISA_INTERRUPTS
> > +#define NR_IRQS                        NR_IRQS_LEGACY
> >  
> >  extern irq_hw_number_t virq_to_hw(unsigned int virq);
> >  
> 
> This looks like the way it's intended.

Hmm, though IRQ_BITMAP_BITS is still a hard limit, and by default it's set to
NR_IRQS + 8196.

So we'd be relying on the + 8196 to get us up to a reasonable number. That
looks like it was added as a bit of a hack/bug-fix, so I'm not sure we want to
rely on it. (c1ee6264280e ("genirq: Prevent access beyond allocated_irqs
bitmap"))

All the distros seem to run with NR_IRQS=512, so it seems no one has needed
more than that or we would have heard about it presumably.

At the same time if we're only spending a single bit for each interrupt number
maybe we should just set it to min(512, NR_CPUS) or something like that to make
sure it's always reasonably big.


> I've also checked that no powerpc platform defines a static IRQ larger than
> NUM_ISA_INTERRUPTS, and only two files do it at all
> (arch/powerpc/platforms/chrp/pegasos_eth.c and arch/powerpc/sysdev/rtc_cmos_setup.c).

Thanks. You clearly have better grep fu than me :)

cheers
