Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r4YNt5xCvzDqD8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 21:12:14 +1000 (AEST)
Message-ID: <1462965128.31037.1.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/tm: Clean up duplication of code
From: Michael Ellerman <mpe@ellerman.id.au>
To: Rashmica <rashmicy@gmail.com>, Balbir Singh <bsingharora@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Date: Wed, 11 May 2016 21:12:08 +1000
In-Reply-To: <5732E2EC.5080403@gmail.com>
References: <1462942500-30188-1-git-send-email-rashmicy@gmail.com>
 <a3fd1cda-2462-1424-1ec0-bd4da23eb4f6@gmail.com>
 <5732E2EC.5080403@gmail.com>
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

On Wed, 2016-05-11 at 17:44 +1000, Rashmica wrote:
> On 11/05/16 15:03, Balbir Singh wrote:
> > On 11/05/16 14:55, Rashmica Gupta wrote:
> > > The same logic for tm_abort appears twice, so pull it out into a
> > > function.
> > > 
> > > diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> > > index 7635b1c6b5da..1cef8f5aee9b 100644
> > > --- a/arch/powerpc/mm/hash_utils_64.c
> > > +++ b/arch/powerpc/mm/hash_utils_64.c
> > > @@ -1318,6 +1318,25 @@ out_exit:
> > >   	local_irq_restore(flags);
> > >   }
> > >   
> > > +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> > > +	/* Transactions are not aborted by tlbiel, only tlbie.

Can you fix up the comment formatting while you're there, should be:

/*
 * Transactions are not aborted by tlbiel, only tlbie.

> > > +	 * Without, syncing a page back to a block device w/ PIO could pick up
> > > +	 * transactional data (bad!) so we force an abort here.  Before the
> > > +	 * sync the page will be made read-only, which will flush_hash_page.
> > > +	 * BIG ISSUE here: if the kernel uses a page from userspace without
> > > +	 * unmapping it first, it may see the speculated version.
> > > +	 */
> > > +static inline void abort_tm(int local)
> > > +{
> > > +	if (local && cpu_has_feature(CPU_FTR_TM) &&
> > > +	    current->thread.regs &&
> > > +	    MSR_TM_ACTIVE(current->thread.regs->msr)) {
> > > +		tm_enable();
> > > +		tm_abort(TM_CAUSE_TLBI);
> > > +	}
> > > +}
> > While your at this do
> > 
> > #else
> > 
> > static inline void abort_tm(int local)
> > {
> > }
> If I'm doing that, wouldn't it make more sense to write:
> 
> +static inline void abort_tm(int local)

It needs a better name. Perhaps tlb_flush_abort_tm() ?

> +{
> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> +	if (local && cpu_has_feature(CPU_FTR_TM) &&
> +	    current->thread.regs &&
> +	    MSR_TM_ACTIVE(current->thread.regs->msr)) {
> +		tm_enable();
> +		tm_abort(TM_CAUSE_TLBI);
> +	}
> +#endif
> +}

In this case it would make some sense.

But the goal is "no #ifdef's in C code", which that would violate.

And if you have two functions that need to be inside the #ifdef then the above
doesn't work anymore.

So the preferred style is:

  #ifdef CONFIG_FOO
  static void foo(int bar)
  {
  	...
  }
  #else /* !CONFIG_FOO */
  static inline foo(int bar) { }
  #endif


And when it expands you end up with:

  #ifdef CONFIG_FOO
  static void foo(int bar)
  {
  	...
  }

  static void foo_new(int bar)
  {
  	...
  }
  #else /* !CONFIG_FOO */
  static inline foo(int bar) { }
  static inline foo_new(int bar) { }
  #endif


cheers
