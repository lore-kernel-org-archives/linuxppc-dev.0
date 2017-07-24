Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGYdF6SdLzDqsd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 06:58:57 +1000 (AEST)
Message-ID: <1500929926.10674.86.camel@kernel.crashing.org>
Subject: Re: [PATCH 5/6] powerpc/mm: Optimize detection of thread local mm's
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, aneesh.kumar@linux.vnet.ibm.com
Date: Tue, 25 Jul 2017 06:58:46 +1000
In-Reply-To: <20170724212533.195cb92b@roar.ozlabs.ibm.com>
References: <20170724042803.25848-1-benh@kernel.crashing.org>
 <20170724042803.25848-5-benh@kernel.crashing.org>
 <20170724212533.195cb92b@roar.ozlabs.ibm.com>
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

On Mon, 2017-07-24 at 21:25 +1000, Nicholas Piggin wrote:
> > +#ifdef CONFIG_PPC_BOOK3S_64
> > +static inline void inc_mm_active_cpus(struct mm_struct *mm)
> > +{
> > +     atomic_inc(&mm->context.active_cpus);
> > +}
> > +#else
> > +static inline void inc_mm_active_cpus(struct mm_struct *mm) { }
> > +#endif
> 
> This is a bit awkward. Can we just move the entire function to test
> cpumask and set / increment into helper functions and define them
> together with mm_is_thread_local, so it's all in one place?

I thought about it but then we have 2 variants, unless I start moving
the active_cpus into mm_context_t on all the 32-bit subarchs too, etc..

It gets messy either way.

> The extra atomic does not need to be defined when it's not used either.
> 
> Also does it make sense to define it based on NR_CPUS > BITS_PER_LONG?
> If it's <= then it should be similar load and compare, no?

Right, we could.

> Looks like a good optimisation though.

Thx. It's a pre-req for further optimizations such as flushing the PID
when a single threaded process moves, so we don't have to constantly
scan the mask.

Cheers,
Ben.
