Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkYQW674zzDq8f
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 03:12:19 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2GG8RHL087862
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 12:12:09 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 297kqkykau-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 12:12:08 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Thu, 16 Mar 2017 12:12:07 -0400
Date: Thu, 16 Mar 2017 21:42:01 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gautham R Shenoy <ego@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH 8/8] powerpc/64s: idle POWER8 avoid full state loss
 recovery when possible
Reply-To: ego@linux.vnet.ibm.com
References: <20170314092349.10981-1-npiggin@gmail.com>
 <20170314092349.10981-9-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170314092349.10981-9-npiggin@gmail.com>
Message-Id: <20170316161201.GG16462@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nick,

On Tue, Mar 14, 2017 at 07:23:49PM +1000, Nicholas Piggin wrote:
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

I like the technique.. Some comments below.

> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/include/asm/cpuidle.h | 32 ++++++++++++++++++++++++---
>  arch/powerpc/kernel/idle_book3s.S  | 45 +++++++++++++++++++++++++++++++++-----
>  2 files changed, 68 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
> index b9d9f960dffd..b68a5cd75ae8 100644
> --- a/arch/powerpc/include/asm/cpuidle.h
> +++ b/arch/powerpc/include/asm/cpuidle.h
> @@ -2,13 +2,39 @@
>  #define _ASM_POWERPC_CPUIDLE_H
> 
>  #ifdef CONFIG_PPC_POWERNV
> -/* Used in powernv idle state management */
> +/* Thread state used in powernv idle state management */
>  #define PNV_THREAD_RUNNING              0
>  #define PNV_THREAD_NAP                  1
>  #define PNV_THREAD_SLEEP                2
>  #define PNV_THREAD_WINKLE               3
> -#define PNV_CORE_IDLE_LOCK_BIT          0x10000000
> -#define PNV_CORE_IDLE_THREAD_BITS       0x000000FF
> +
> +/*
> + * Core state used in powernv idle for POWER8.
> + *
> + * The lock bit synchronizes updates to the state, as well as parts of the
> + * sleep/wake code (see kernel/idle_book3s.S).
> + *
> + * Bottom 8 bits track the idle state of each thread. Bit is cleared before
> + * the thread executes an idle instruction (nap/sleep/winkle).
> + *
> + * Then there is winkle tracking. A core does not lose complete state
> + * until every thread is in winkle. So the winkle count field counts the
> + * number of threads in winkle (small window of false positives is okay
> + * around the sleep/wake, so long as there are no false negatives).
> + *
> + * When the winkle count reaches 8 (the COUNT_ALL_BIT becomes set), then
> + * the THREAD_WINKLE_BITS are set, which indicate which threads have not
> + * yet woken from the winkle state.
> + */
> +#define PNV_CORE_IDLE_LOCK_BIT			0x10000000
> +
> +#define PNV_CORE_IDLE_WINKLE_COUNT		0x00010000
> +#define PNV_CORE_IDLE_WINKLE_COUNT_ALL_BIT	0x00080000
> +#define PNV_CORE_IDLE_WINKLE_COUNT_BITS		0x000F0000
> +#define PNV_CORE_IDLE_THREAD_WINKLE_BITS_SHIFT	8
> +#define PNV_CORE_IDLE_THREAD_WINKLE_BITS	0x0000FF00
> +
> +#define PNV_CORE_IDLE_THREAD_BITS       	0x000000FF
> 
>  /*
>   * ============================ NOTE =================================
> diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> index 3cb75907c5c5..87518a1dca50 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -210,15 +210,20 @@ pnv_enter_arch207_idle_mode:
>  	/* Sleep or winkle */
>  	lbz	r7,PACA_THREAD_MASK(r13)
>  	ld	r14,PACA_CORE_IDLE_STATE_PTR(r13)
> +	li	r5,0
> +	beq	cr3,3f
> +	lis	r5,PNV_CORE_IDLE_WINKLE_COUNT@h
> +3:
>  lwarx_loop1:
>  	lwarx	r15,0,r14
> 
>  	andis.	r9,r15,PNV_CORE_IDLE_LOCK_BIT@h
>  	bnel-	core_idle_lock_held
> 
> +	add	r15,r15,r5			/* Add if winkle */
>  	andc	r15,r15,r7			/* Clear thread bit */
> 
> -	andi.	r15,r15,PNV_CORE_IDLE_THREAD_BITS
> +	andi.	r9,r15,PNV_CORE_IDLE_THREAD_BITS
> 
>  /*
>   * If cr0 = 0, then current thread is the last thread of the core entering
> @@ -437,16 +442,14 @@ pnv_restore_hyp_resource_arch300:
>  pnv_restore_hyp_resource_arch207:
>  	/*
>  	 * POWER ISA 2.07 or less.
> -	 * Check if we slept with winkle.
> +	 * Check if we slept with sleep or winkle.
>  	 */
>  	ld	r2,PACATOC(r13);
> 
> -	lbz	r0,PACA_THREAD_IDLE_STATE(r13)
> -	cmpwi	cr2,r0,PNV_THREAD_NAP
> -	cmpwi	cr4,r0,PNV_THREAD_WINKLE
> +	lbz	r4,PACA_THREAD_IDLE_STATE(r13)
>  	li	r0,PNV_THREAD_RUNNING
>  	stb	r0,PACA_THREAD_IDLE_STATE(r13)	/* Clear thread state */
> -
> +	cmpwi	cr2,r4,PNV_THREAD_NAP
>  	bgt	cr2,pnv_wakeup_tb_loss	/* Either sleep or Winkle */
> 
> 
> @@ -467,7 +470,12 @@ pnv_restore_hyp_resource_arch207:
>   *
>   * r13 - PACA
>   * cr3 - gt if waking up with partial/complete hypervisor state loss
> + *
> + * If ISA300:
>   * cr4 - gt or eq if waking up from complete hypervisor state loss.
> + *
> + * If ISA207:
> + * r4 - PACA_THREAD_IDLE_STATE
>   */
>  pnv_wakeup_tb_loss:
>  	ld	r1,PACAR1(r13)
> @@ -482,6 +490,7 @@ pnv_wakeup_tb_loss:
>  	 * required to return back to caller after hypervisor state restore is
>  	 * complete.
>  	 */
> +	mr	r18,r4
>  	mflr	r17
>  	mfspr	r16,SPRN_SRR1
>  BEGIN_FTR_SECTION
> @@ -517,10 +526,34 @@ END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
>  	 * At this stage
>  	 * cr2 - eq if first thread to wakeup in core
>  	 * cr3-  gt if waking up with partial/complete hypervisor state loss
> +	 * ISA300:
>  	 * cr4 - gt or eq if waking up from complete hypervisor state loss.

For ISA 300, we need to restore hypervisor thread resources if we are
waking up a state that is as deep or deeper than
pnv_first_deep_stop_state. In that case, we expect either the "gt" bit
or the "eq" bit of cr4 to be set.

Before this patch, on ISA 207, cr4 would be "eq" if we are waking up
from winkle.


>  	 */
> 
>  BEGIN_FTR_SECTION
> +	/*
> +	 * Were we in winkle?
> +	 * If yes, check if all threads were in winkle, decrement our
> +	 * winkle count, set all thread winkle bits if all were in winkle.
> +	 * Check if our thread has a winkle bit set, and set cr4 accordingly
> +	 * (to match ISA300, above).
> +	 */
> +	cmpwi	r18,PNV_THREAD_WINKLE
> +	bne	2f
> +	andis.	r9,r15,PNV_CORE_IDLE_WINKLE_COUNT_ALL_BIT@h
> +	subis	r15,r15,PNV_CORE_IDLE_WINKLE_COUNT@h
> +	beq	2f
> +	ori	r15,r15,PNV_CORE_IDLE_THREAD_WINKLE_BITS /* all were winkle */

So PNV_CORE_IDLE_THREAD_WINKLE_BITS will be set by the first waking
thread in a winkle'd core. Subsequent waking thread(s) can only clear
their respective bits from the winkle bits.

> +2:
> +	/* Shift thread bit to winkle mask, then test if this thread is set,
> +	 * and remove it from the winkle bits */
> +	slwi	r8,r7,8
> +	and	r8,r8,r15
> +	andc	r15,r15,r8
> +	cmpwi	cr4,r8,1 /* cr4 will be gt if our bit is set, lt if not */

Very clever indeed! So we seem to be doing the following:

winkle_entry(thread_bit)
{
	atomic_inc(core_winkle_count);
}

winkle_exit(thread_bit)
{
	atomic {
	       if (core_winkle_count == 8)
	       	  set all thread bits in core_winkle_mask;

	       if (thread_bit set in core_winkle_mask) {
	       	  cr4 will be "gt".
	       }

	       clear thread_bit from core_winkle_mask;
	}
}

I would suggest documenting this a bit more documentation given the
subtlety.

> +
> +	cmpwi	cr4,r18,PNV_THREAD_WINKLE

This second comparision seems to be undoing the benefit of the
optimization by setting "eq" in cr4 for every thread that wakes up
from winkle irrespective of whether the core has winkled or not.

However, this is quite subtle, so good chances that my addled brain
has gotten it wrong.

Case 1: If a thread were waking up from winkle. We have 2
        possibilities

      a) The entire core winkled at least once ever since this thread
      went to winkle. In this case we want cr4 to be "eq" or "gt" so
      that we restore the hypervisor resources.
      Now, for this case the first thread in the core that wakes up would find
      count == PNV_CORE_IDLE_WINKLE_COUNT_ALL_BIT and hence would have
      set PNV_CORE_IDLE_THREAD_WINKLE_BITS which includes this
      thread's bit as well. Hence, this thread
      would find its bit set in r8, thereby cr4 would be "gt". Which
      is good for us!

      b) The entire core has not entered winkle. In which case we
      haven't lost any hypervisor resources, so no need to restore
      these. We would like cr4 to have neither "eq" nor "gt" set here.
      In this case, no thread that has woken up prior to this thread
      would find count == PNV_CORE_IDLE_WINKLE_COUNT_ALL_BIT. Hence
      none of those earlier threads would set
      PNV_CORE_IDLE_THREAD_WINKLE_BITS. Thus, for this thread, r8
      would be 0, and hence cr4 would be "lt". Which is what we want.
      

Case 2: If the thread is waking up from fast-sleep. In which case we
      haven't lost any hypervisor resources, so no need to restore
      these. We would like cr4 to have neither "eq" nor "gt" set here.

      While entering fastsleep, this thread wouldn't have contributed
      to the winkle count. Thus any thread that would have woken up
      before this thread would not find
      winkle count == PNV_CORE_IDLE_WINKLE_COUNT_ALL_BIT
      and hence wouldn't have set the bits in
      PNV_CORE_IDLE_THREAD_WINKLE_BITS. Thus, r8 would
      be 0, and hence cr4 would be "lt".


So it seems to be the case that the first comparison suffices. What am
I missing here ?

> +
>  	lbz	r4,PACA_SUBCORE_SIBLING_MASK(r13)
>  	and	r4,r4,r15
>  	cmpwi	r4,0	/* Check if first in subcore */
> -- 
> 2.11.0
> 

--
Thanks and Regards
gautham.
