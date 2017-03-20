Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vn1fh5G7YzDqZT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 03:31:24 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2KGSqeL114869
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 12:31:22 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29ahvytucg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 12:31:22 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Mon, 20 Mar 2017 12:31:21 -0400
Date: Mon, 20 Mar 2017 22:01:15 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [PATCH 7/7] powerpc/64s: idle POWER8 avoid full state loss
 recovery where possible
Reply-To: ego@linux.vnet.ibm.com
References: <20170320060152.1016-1-npiggin@gmail.com>
 <20170320060152.1016-8-npiggin@gmail.com>
 <20170320101139.GA20417@in.ibm.com>
 <20170320202605.304b33ad@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170320202605.304b33ad@roar.ozlabs.ibm.com>
Message-Id: <20170320163115.GA20610@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nick,

On Mon, Mar 20, 2017 at 08:26:05PM +1000, Nicholas Piggin wrote:
> On Mon, 20 Mar 2017 15:41:39 +0530
> Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:
> 
> > Hi Nick,
> > 
> > On Mon, Mar 20, 2017 at 04:01:52PM +1000, Nicholas Piggin wrote:
> > > If not all threads were in winkle, full state loss recovery is not
> > > necessary and can be avoided. A previous patch removed this optimisation
> > > due to some complexity with the implementation. Re-implement it by
> > > counting the number of threads in winkle with the per-core idle state.
> > > Only restore full state loss if all threads were in winkle.
> > > 
> > > This has a small window of false positives right before threads execute
> > > winkle and just after they wake up, when the winkle count does not
> > > reflect the true number of threads in winkle. This is not a significant
> > > problem in comparison with even the minimum winkle duration. For
> > > correctness, a false positive is not a problem (only false negatives
> > > would be).  
> > 
> > The patch looks good. Just a minor comment.
> > 
> > 
> > >  BEGIN_FTR_SECTION
> > > +	/*
> > > +	 * Were we in winkle?
> > > +	 * If yes, check if all threads were in winkle, decrement our
> > > +	 * winkle count, set all thread winkle bits if all were in winkle.
> > > +	 * Check if our thread has a winkle bit set, and set cr4 accordingly
> > > +	 * (to match ISA300, above). Pseudo-code for core idle state
> > > +	 * transitions for ISA207 is as follows (everything happens atomically
> > > +	 * due to store conditional and/or lock bit):
> > > +	 *
> > > +	 * nap_idle() { }
> > > +	 * nap_wake() { }
> > > +	 *
> > > +	 * sleep_idle()
> > > +	 * {
> > > +	 *	core_idle_state &= ~thread_in_core
> > > +	 * }
> > > +	 *
> > > +	 * sleep_wake()
> > > +	 * {
> > > +	 *     bool first_in_core, first_in_subcore;
> > > +	 *
> > > +	 *     first_in_core = (core_idle_state & IDLE_THREAD_BITS) == 0;
> > > +	 *     first_in_subcore = (core_idle_state & SUBCORE_SIBLING_MASK) == 0;
> > > +	 *
> > > +	 *     core_idle_state |= thread_in_core;
> > > +	 * }
> > > +	 *
> > > +	 * winkle_idle()
> > > +	 * {
> > > +	 *	core_idle_state &= ~thread_in_core;
> > > +	 *	core_idle_state += 1 << WINKLE_COUNT_SHIFT;
> > > +	 * }
> > > +	 *
> > > +	 * winkle_wake()
> > > +	 * {
> > > +	 *     bool first_in_core, first_in_subcore, winkle_state_lost;
> > > +	 *
> > > +	 *     first_in_core = (core_idle_state & IDLE_THREAD_BITS) == 0;
> > > +	 *     first_in_subcore = (core_idle_state & SUBCORE_SIBLING_MASK) == 0;
> > > +	 *
> > > +	 *     core_idle_state |= thread_in_core;
> > > +	 *
> > > +	 *     if ((core_idle_state & WINKLE_MASK) == (8 << WINKLE_COUNT_SIHFT))
> > > +	 *         core_idle_state |= THREAD_WINKLE_BITS;  
> > 
> > We also do the following decrement. I forgot this in the pseudo-code in my
> > earlier reply.
> > 
> >   	 	core_idle_state -= 1 << WINKLE_COUNT_SHIFT;
> 
> Lucky somebody is paying attention. Yes, this is needed. I won't resend
> a patch if mpe can make the change.
> 
> 
> > Looks good other wise.
> > 
> > Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> 
> Thank you.
> 
> What do you want to do about your DD1 fix? I think there are some minor
> clashes between them. I'm happy to rebase on top of yours if you prefer
> it to go in first.

I have sent an updated version of the DD1 fix today rebasing on
v4.11-rc3.

I applied your series on top of that and noticed some minor conflict
with patches 1,2,3 and 7.

If you are ok with it, I would like the DD1 Hotplug fixes to go in
first.

> 
> Thanks,
> Nick
> 
