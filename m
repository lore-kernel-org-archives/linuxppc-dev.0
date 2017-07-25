Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGff26bKRzDrCh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 10:44:58 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id y129so13071527pgy.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 17:44:58 -0700 (PDT)
Date: Tue, 25 Jul 2017 10:44:45 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH 5/6] powerpc/mm: Optimize detection of thread local mm's
Message-ID: <20170725104445.13010b5e@roar.ozlabs.ibm.com>
In-Reply-To: <1500929926.10674.86.camel@kernel.crashing.org>
References: <20170724042803.25848-1-benh@kernel.crashing.org>
 <20170724042803.25848-5-benh@kernel.crashing.org>
 <20170724212533.195cb92b@roar.ozlabs.ibm.com>
 <1500929926.10674.86.camel@kernel.crashing.org>
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

On Tue, 25 Jul 2017 06:58:46 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Mon, 2017-07-24 at 21:25 +1000, Nicholas Piggin wrote:
> > > +#ifdef CONFIG_PPC_BOOK3S_64
> > > +static inline void inc_mm_active_cpus(struct mm_struct *mm)
> > > +{
> > > +     atomic_inc(&mm->context.active_cpus);
> > > +}
> > > +#else
> > > +static inline void inc_mm_active_cpus(struct mm_struct *mm) { }
> > > +#endif  
> > 
> > This is a bit awkward. Can we just move the entire function to test
> > cpumask and set / increment into helper functions and define them
> > together with mm_is_thread_local, so it's all in one place?  
> 
> I thought about it but then we have 2 variants, unless I start moving
> the active_cpus into mm_context_t on all the 32-bit subarchs too, etc..

The two variants are just cleaner versions of the two variants you
already introduced.

static inline bool mm_activate_cpu(struct mm_struct *mm)
{
    if (!cpumask_test_cpu(smp_processor_id(), mm_cpumask(next))) {
        cpumask_set_cpu(smp_processor_id(), mm_cpumask(next));
#if CONFIG_PPC_BOOK3S_64
        atomic_inc(&mm->context.active_cpus);
#endif
        smp_mb();
        return true;
    }
    return false;
}

I think it would be nicer to put something like that with
mm_is_thread_local etc definitions so you can see how it all works
in one place.

> It gets messy either way.
> 
> > The extra atomic does not need to be defined when it's not used either.
> > 
> > Also does it make sense to define it based on NR_CPUS > BITS_PER_LONG?
> > If it's <= then it should be similar load and compare, no?  
> 
> Right, we could.
> 
> > Looks like a good optimisation though.  
> 
> Thx. It's a pre-req for further optimizations such as flushing the PID
> when a single threaded process moves, so we don't have to constantly
> scan the mask.

Yep, will be very interesting to see how much global tlbies can be
reduced.

Thanks,
Nick
