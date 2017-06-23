Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wvFV45tvpzDqnf
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 20:45:48 +1000 (AEST)
Message-ID: <1498214736.31581.77.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Invalidate ERAT on powersave wakeup for POWER9
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Date: Fri, 23 Jun 2017 05:45:36 -0500
In-Reply-To: <87mv8zoxp8.fsf@concordia.ellerman.id.au>
References: <20170622172616.7598-1-mikey@neuling.org>
 <87mv8zoxp8.fsf@concordia.ellerman.id.au>
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

On Fri, 2017-06-23 at 19:33 +1000, Michael Ellerman wrote:
> Michael Neuling <mikey@neuling.org> writes:
> 
> > On POWER9 the ERAT may be incorrect on wakeup from some stop states
> > that lose state. This causes random segvs and illegal instructions
> > when these stop states are enabled.
> 
> Incorrect how?

As in stale. Not sure about the details.

> Because with the ERAT flush where you've put it, there's still a good
> amount of code executed prior to the flush isn't there?

In real mode, should be ok.

> ie. we come in at 0x100, do some of the prolog, do IDLE_TEST which takes
> us to pnv_powersave_wakeup, which then restores state from the paca
> (memory), that returns and then we check KVM ... and then finally we end
> up at pnv_wakeup_loss.
> 
> Or is there some other path? Or is the ERAT incorrect in some specific
> way which means we only need to flush there?

I think real mode translations are ok but I'll ask around.

Cheers,
Ben.

> cheers
> 
> > diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> > index 1ea14b96f1..ace2ad50c8 100644
> > --- a/arch/powerpc/kernel/idle_book3s.S
> > +++ b/arch/powerpc/kernel/idle_book3s.S
> > @@ -793,6 +793,9 @@ fastsleep_workaround_at_exit:
> >   */
> >  .global pnv_wakeup_loss
> >  pnv_wakeup_loss:
> > +BEGIN_FTR_SECTION
> > +	PPC_INVALIDATE_ERAT
> > +END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
> >  	ld	r1,PACAR1(r13)
> >  BEGIN_FTR_SECTION
> >  	CHECK_HMI_INTERRUPT
> > -- 
> > 2.11.0
