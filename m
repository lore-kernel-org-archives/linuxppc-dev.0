Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7BFA9679A6
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Aug 2006 08:54:43 +1000 (EST)
Subject: Re: [PATCH] powerpc: Improve IRQ radix tree locking
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <e991208eced0af7536e9f71bf6cb7016@bga.com>
References: <e991208eced0af7536e9f71bf6cb7016@bga.com>
Content-Type: text/plain
Date: Sat, 26 Aug 2006 08:54:23 +1000
Message-Id: <1156546464.8433.336.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-08-25 at 09:42 -0500, Milton Miller wrote:
> On Fri Aug 25 16:04:52 EST 2006,  Benjamin Herrenschmidt wrote:
> > When reworking the powerpc irq code, I figured out that we were using
> > the radix tree in a racy way. As a temporary fix, I put a spinlock in
> > there. However, this can have a significant impact on performances. 
> > This
> > patch reworks that to use a smarter technique based on the fact that
> > what we need is in fact a rwlock with extremely rare writers (thus
> > optimized for the read path).
> 
> 
> > +static void irq_radix_wrlock(unsigned long *flags)
> > +{
> > +       unsigned int cpu, ok;
> > +
> > +       spin_lock_irqsave(&irq_big_lock, *flags);
> > +       irq_radix_writer = 1;
> 
> I think the smp_mb() is needed after here
> 
> > +       do {
> > +               ok = 1;
> > +               smp_mb();
> 
> but not every time we poll the cpus.  We are only
> updating our local variable ok which we have not
> given anyone else.   It could even be a register.

Doesn't really matter, the write case is extremely rare and not at all
performance critical. If I don't put the mb in the loop, I wonder if the
compiler might start optimizing out the reads... and I don't want to add
a volatile in there. I feel safer with the smp_mb() in there.

> > +               for_each_possible_cpu(cpu) {
> > +                       if (per_cpu(irq_radix_reader, cpu)) {
> > +                               ok = 0;
> > +                               break;
> > +                       }
> > +               }
> > +               if (!ok)
> > +                       cpu_relax();
> 
> Hmmm.  the gcc barrier is conditional.   How about putting
> barrier() before the ok=1 at the top, to avoid any optimization
> blockage but still telling gcc you must read every time?

Yeah, well, as I said, smp_mb() hits both cases and this isn't perf.
critical... 

> > +       } while(!ok);
> > +}
> > +
> 
> Oh, and how about some (un)likely in irq_radix_rdlock ?  It
> could happen by default by why not show our expected path?

Yup, that would make sense. I might also drop the first test of
irq_radix_writer. The will penalize a bit more the contention case vs.
the read case but that's exactly what I want...

> And, while I'm thinking of changes, when set ok=0 above add:
> #ifdef CONFIG_SPINLOCK_DEBUG
>                                BUG_ON(cpu == smp_processor_id());
> #endif

Do you see any case where I might actually hit that ? :)

> Hmm... just thought of something .... we are spinning under
> irq lock.  We are waiting on some other thread, but not
> telling the hypervisor.   Should we confer our execution
> over to the cpu we are waiting on?  I know, it sounds ugly
> to call that code.   I guess we would want a
> cpu_waiting_on(cpu) that calls cpu_relax and/or hypervisor.

I'm not sure this will really matter in real life. The write case is
really so rare and the contention case even more...

Ben.
