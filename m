Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vmsDk07zCzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 21:11:49 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2KA9f01132509
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 06:11:47 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29906v4f41-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 06:11:46 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Mon, 20 Mar 2017 04:11:45 -0600
Date: Mon, 20 Mar 2017 15:41:39 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [PATCH 7/7] powerpc/64s: idle POWER8 avoid full state loss
 recovery where possible
Reply-To: ego@linux.vnet.ibm.com
References: <20170320060152.1016-1-npiggin@gmail.com>
 <20170320060152.1016-8-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170320060152.1016-8-npiggin@gmail.com>
Message-Id: <20170320101139.GA20417@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nick,

On Mon, Mar 20, 2017 at 04:01:52PM +1000, Nicholas Piggin wrote:
> If not all threads were in winkle, full state loss recovery is not
> necessary and can be avoided. A previous patch removed this optimisation
> due to some complexity with the implementation. Re-implement it by
> counting the number of threads in winkle with the per-core idle state.
> Only restore full state loss if all threads were in winkle.
> 
> This has a small window of false positives right before threads execute
> winkle and just after they wake up, when the winkle count does not
> reflect the true number of threads in winkle. This is not a significant
> problem in comparison with even the minimum winkle duration. For
> correctness, a false positive is not a problem (only false negatives
> would be).

The patch looks good. Just a minor comment.


>  BEGIN_FTR_SECTION
> +	/*
> +	 * Were we in winkle?
> +	 * If yes, check if all threads were in winkle, decrement our
> +	 * winkle count, set all thread winkle bits if all were in winkle.
> +	 * Check if our thread has a winkle bit set, and set cr4 accordingly
> +	 * (to match ISA300, above). Pseudo-code for core idle state
> +	 * transitions for ISA207 is as follows (everything happens atomically
> +	 * due to store conditional and/or lock bit):
> +	 *
> +	 * nap_idle() { }
> +	 * nap_wake() { }
> +	 *
> +	 * sleep_idle()
> +	 * {
> +	 *	core_idle_state &= ~thread_in_core
> +	 * }
> +	 *
> +	 * sleep_wake()
> +	 * {
> +	 *     bool first_in_core, first_in_subcore;
> +	 *
> +	 *     first_in_core = (core_idle_state & IDLE_THREAD_BITS) == 0;
> +	 *     first_in_subcore = (core_idle_state & SUBCORE_SIBLING_MASK) == 0;
> +	 *
> +	 *     core_idle_state |= thread_in_core;
> +	 * }
> +	 *
> +	 * winkle_idle()
> +	 * {
> +	 *	core_idle_state &= ~thread_in_core;
> +	 *	core_idle_state += 1 << WINKLE_COUNT_SHIFT;
> +	 * }
> +	 *
> +	 * winkle_wake()
> +	 * {
> +	 *     bool first_in_core, first_in_subcore, winkle_state_lost;
> +	 *
> +	 *     first_in_core = (core_idle_state & IDLE_THREAD_BITS) == 0;
> +	 *     first_in_subcore = (core_idle_state & SUBCORE_SIBLING_MASK) == 0;
> +	 *
> +	 *     core_idle_state |= thread_in_core;
> +	 *
> +	 *     if ((core_idle_state & WINKLE_MASK) == (8 << WINKLE_COUNT_SIHFT))
> +	 *         core_idle_state |= THREAD_WINKLE_BITS;

We also do the following decrement. I forgot this in the pseudo-code in my
earlier reply.

  	 	core_idle_state -= 1 << WINKLE_COUNT_SHIFT;
		
		   
> +	 *     winkle_state_lost = core_idle_state &
> +	 *				(thread_in_core << WINKLE_THREAD_SHIFT);
> +	 *     core_idle_state &= ~(thread_in_core << WINKLE_THREAD_SHIFT);
> +	 * }
> +	 *
> +	 */
> +	cmpwi	r18,PNV_THREAD_WINKLE
> +	bne	2f
> +	andis.	r9,r15,PNV_CORE_IDLE_WINKLE_COUNT_ALL_BIT@h
> +	subis	r15,r15,PNV_CORE_IDLE_WINKLE_COUNT@h
> +	beq	2f
> +	ori	r15,r15,PNV_CORE_IDLE_THREAD_WINKLE_BITS /* all were winkle */
> +2:
> +	/* Shift thread bit to winkle mask, then test if this thread is set,
> +	 * and remove it from the winkle bits */
> +	slwi	r8,r7,8
> +	and	r8,r8,r15
> +	andc	r15,r15,r8
> +	cmpwi	cr4,r8,1 /* cr4 will be gt if our bit is set, lt if not */
> +

Looks good other wise.

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>


>  	lbz	r4,PACA_SUBCORE_SIBLING_MASK(r13)
>  	and	r4,r4,r15
>  	cmpwi	r4,0	/* Check if first in subcore */
> -- 
> 2.11.0
> 
