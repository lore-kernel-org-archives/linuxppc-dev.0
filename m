Return-Path: <npiggin@gmail.com>
Received: from mail-ot0-x242.google.com (mail-ot0-x242.google.com
 [IPv6:2607:f8b0:4003:c0f::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vmsYX15V5zDqYB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 21:26:24 +1100 (AEDT)
Received: by mail-ot0-x242.google.com with SMTP id i1so18736573ota.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 03:26:24 -0700 (PDT)
Date: Mon, 20 Mar 2017 20:26:05 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [PATCH 7/7] powerpc/64s: idle POWER8 avoid full state loss
 recovery where possible
Message-ID: <20170320202605.304b33ad@roar.ozlabs.ibm.com>
In-Reply-To: <20170320101139.GA20417@in.ibm.com>
References: <20170320060152.1016-1-npiggin@gmail.com>
 <20170320060152.1016-8-npiggin@gmail.com>
 <20170320101139.GA20417@in.ibm.com>
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

On Mon, 20 Mar 2017 15:41:39 +0530
Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:

> Hi Nick,
> 
> On Mon, Mar 20, 2017 at 04:01:52PM +1000, Nicholas Piggin wrote:
> > If not all threads were in winkle, full state loss recovery is not
> > necessary and can be avoided. A previous patch removed this optimisation
> > due to some complexity with the implementation. Re-implement it by
> > counting the number of threads in winkle with the per-core idle state.
> > Only restore full state loss if all threads were in winkle.
> > 
> > This has a small window of false positives right before threads execute
> > winkle and just after they wake up, when the winkle count does not
> > reflect the true number of threads in winkle. This is not a significant
> > problem in comparison with even the minimum winkle duration. For
> > correctness, a false positive is not a problem (only false negatives
> > would be).  
> 
> The patch looks good. Just a minor comment.
> 
> 
> >  BEGIN_FTR_SECTION
> > +	/*
> > +	 * Were we in winkle?
> > +	 * If yes, check if all threads were in winkle, decrement our
> > +	 * winkle count, set all thread winkle bits if all were in winkle.
> > +	 * Check if our thread has a winkle bit set, and set cr4 accordingly
> > +	 * (to match ISA300, above). Pseudo-code for core idle state
> > +	 * transitions for ISA207 is as follows (everything happens atomically
> > +	 * due to store conditional and/or lock bit):
> > +	 *
> > +	 * nap_idle() { }
> > +	 * nap_wake() { }
> > +	 *
> > +	 * sleep_idle()
> > +	 * {
> > +	 *	core_idle_state &= ~thread_in_core
> > +	 * }
> > +	 *
> > +	 * sleep_wake()
> > +	 * {
> > +	 *     bool first_in_core, first_in_subcore;
> > +	 *
> > +	 *     first_in_core = (core_idle_state & IDLE_THREAD_BITS) == 0;
> > +	 *     first_in_subcore = (core_idle_state & SUBCORE_SIBLING_MASK) == 0;
> > +	 *
> > +	 *     core_idle_state |= thread_in_core;
> > +	 * }
> > +	 *
> > +	 * winkle_idle()
> > +	 * {
> > +	 *	core_idle_state &= ~thread_in_core;
> > +	 *	core_idle_state += 1 << WINKLE_COUNT_SHIFT;
> > +	 * }
> > +	 *
> > +	 * winkle_wake()
> > +	 * {
> > +	 *     bool first_in_core, first_in_subcore, winkle_state_lost;
> > +	 *
> > +	 *     first_in_core = (core_idle_state & IDLE_THREAD_BITS) == 0;
> > +	 *     first_in_subcore = (core_idle_state & SUBCORE_SIBLING_MASK) == 0;
> > +	 *
> > +	 *     core_idle_state |= thread_in_core;
> > +	 *
> > +	 *     if ((core_idle_state & WINKLE_MASK) == (8 << WINKLE_COUNT_SIHFT))
> > +	 *         core_idle_state |= THREAD_WINKLE_BITS;  
> 
> We also do the following decrement. I forgot this in the pseudo-code in my
> earlier reply.
> 
>   	 	core_idle_state -= 1 << WINKLE_COUNT_SHIFT;

Lucky somebody is paying attention. Yes, this is needed. I won't resend
a patch if mpe can make the change.

 
> Looks good other wise.
> 
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

Thank you.

What do you want to do about your DD1 fix? I think there are some minor
clashes between them. I'm happy to rebase on top of yours if you prefer
it to go in first.

Thanks,
Nick
