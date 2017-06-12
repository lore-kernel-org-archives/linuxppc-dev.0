Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wmbSK5z91zDqL2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 00:51:13 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id s66so2059160pfs.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 07:51:13 -0700 (PDT)
Date: Tue, 13 Jun 2017 00:51:01 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 04/14] powerpc/64s: idle process interrupts from system
 reset wakeup
Message-ID: <20170613005101.4755e71a@roar.ozlabs.ibm.com>
In-Reply-To: <20170612094105.GC10921@in.ibm.com>
References: <20170611235835.7400-1-npiggin@gmail.com>
 <20170611235835.7400-5-npiggin@gmail.com>
 <20170612094105.GC10921@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 12 Jun 2017 15:11:06 +0530
Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:

> Hi Nick,
> 
> On Mon, Jun 12, 2017 at 09:58:25AM +1000, Nicholas Piggin wrote:
> > When the CPU wakes from low power state, it begins at the system reset
> > interrupt with the exception that caused the wakeup encoded in SRR1.
> > 
> > Today, powernv idle wakeup ignores the wakeup reason (except a special
> > case for HMI), and the regular interrupt corresponding to the
> > exception will fire after the idle wakeup exits.
> > 
> > Change this to replay the interrupt from the idle wakeup before
> > interrupts are hard-enabled.
> > 
> > Test on POWER8 of context_switch selftests benchmark with polling idle
> > disabled (e.g., always nap, giving cross-CPU IPIs) gives the following
> > results:
> > 
> >                                 original         wakeup direct
> > Different threads, same core:   315k/s           264k/s
> > Different cores:                235k/s           242k/s
> > 
> > There is a slowdown for doorbell IPI (same core) case because system
> > reset wakeup does not clear the message and the doorbell interrupt
> > fires again needlessly.  
> 
> Should we clear the doorbell message if we are recording the fact that
> the Doorbell irq has happened in paca ?

As you saw, I clear it in the next patch.

It would be quite tidy to msgclear when moving srr1 wakeup into pending
mask. But on the other hand, I thought that deferring the clear as late
as possible and moving it closer to where IRQs will be hard enabled
again may help to avoid taking other IPIs.

> 
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  arch/powerpc/include/asm/hw_irq.h     |  2 ++
> >  arch/powerpc/kernel/irq.c             | 25 +++++++++++++++++++++++++
> >  arch/powerpc/platforms/powernv/idle.c | 10 ++++++++--
> >  3 files changed, 35 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
> > index f06112cf8734..8366bdc69988 100644  
> 
> [..snip..]
> 
> > --- a/arch/powerpc/kernel/irq.c
> > +++ b/arch/powerpc/kernel/irq.c
> > @@ -348,6 +348,7 @@ bool prep_irq_for_idle(void)
> >  	return true;
> >  }
> > 
> > +#ifdef CONFIG_PPC_BOOK3S
> >  /*
> >   * This is for idle sequences that return with IRQs off, but the
> >   * idle state itself wakes on interrupt. Tell the irq tracer that
> > @@ -379,6 +380,30 @@ bool prep_irq_for_idle_irqsoff(void)
> >  }
> > 
> >  /*
> > + * Take the SRR1 wakeup reason, index into this table to find the
> > + * appropriate irq_happened bit.
> > + */
> > +static const u8 srr1_to_irq[0x10] = {
> > +	0, 0, 0,
> > +	PACA_IRQ_DBELL,
> > +	0,
> > +	PACA_IRQ_DBELL,
> > +	PACA_IRQ_DEC,
> > +	0,
> > +	PACA_IRQ_EE,
> > +	PACA_IRQ_EE,
> > +	PACA_IRQ_HMI,
> > +	0, 0, 0, 0, 0 };
> > +
> > +void irq_set_pending_from_srr1(unsigned long srr1)
> > +{
> > +	unsigned int idx = (srr1 >> 18) & SRR1_WAKEMASK_P8;  
> 
> Shouldn't this be
> 	unsigned int idx = (srr1 & SRR1_WAKEMASK_P8) >> 18;
> 	
> 	?

Yes, good catch. That will teach me not to verify after making a change.
Will fix.

Thanks,
Nick
