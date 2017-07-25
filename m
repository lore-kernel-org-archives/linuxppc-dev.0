Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGg4F61v3zDrCt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 11:04:13 +1000 (AEST)
Message-ID: <1500944625.10674.101.camel@kernel.crashing.org>
Subject: Re: [PATCH 5/6] powerpc/mm: Optimize detection of thread local mm's
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, aneesh.kumar@linux.vnet.ibm.com
Date: Tue, 25 Jul 2017 11:03:45 +1000
In-Reply-To: <20170725104445.13010b5e@roar.ozlabs.ibm.com>
References: <20170724042803.25848-1-benh@kernel.crashing.org>
 <20170724042803.25848-5-benh@kernel.crashing.org>
 <20170724212533.195cb92b@roar.ozlabs.ibm.com>
 <1500929926.10674.86.camel@kernel.crashing.org>
 <20170725104445.13010b5e@roar.ozlabs.ibm.com>
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

On Tue, 2017-07-25 at 10:44 +1000, Nicholas Piggin wrote:
> The two variants are just cleaner versions of the two variants you
> already introduced.
> 
> static inline bool mm_activate_cpu(struct mm_struct *mm)
> {
>     if (!cpumask_test_cpu(smp_processor_id(), mm_cpumask(next))) {
>         cpumask_set_cpu(smp_processor_id(), mm_cpumask(next));
> #if CONFIG_PPC_BOOK3S_64
>         atomic_inc(&mm->context.active_cpus);
> #endif
>         smp_mb();
>         return true;
>     }
>     return false;
> }

Well the above is what I originally wrote, which Michael encouraged me
to turn into a helper ;-) I was removing ifdef's from switch_mm in
this series...

> I think it would be nicer to put something like that with
> mm_is_thread_local etc definitions so you can see how it all works
> in one place.
> 
> > It gets messy either way.
> > 
> > > The extra atomic does not need to be defined when it's not used either.
> > > 
> > > Also does it make sense to define it based on NR_CPUS > BITS_PER_LONG?
> > > If it's <= then it should be similar load and compare, no?  
> > 
> > Right, we could.
> > 
> > > Looks like a good optimisation though.  
> > 
> > Thx. It's a pre-req for further optimizations such as flushing the PID
> > when a single threaded process moves, so we don't have to constantly
> > scan the mask.
> 
> Yep, will be very interesting to see how much global tlbies can be
> reduced.
> 
> Thanks,
> Nick
