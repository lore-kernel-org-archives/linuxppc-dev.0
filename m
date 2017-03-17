Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkv0g2mNMzDqnr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 16:24:35 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id g2so8468599pge.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 22:24:35 -0700 (PDT)
Date: Fri, 17 Mar 2017 15:24:22 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Vaidyanathan Srinivasan
 <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH 8/8] powerpc/64s: idle POWER8 avoid full state loss
 recovery when possible
Message-ID: <20170317152422.0e40619c@roar.ozlabs.ibm.com>
In-Reply-To: <20170316161201.GG16462@in.ibm.com>
References: <20170314092349.10981-1-npiggin@gmail.com>
 <20170314092349.10981-9-npiggin@gmail.com>
 <20170316161201.GG16462@in.ibm.com>
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

On Thu, 16 Mar 2017 21:42:01 +0530
Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:

Hey, thanks for the review.

> Hi Nick,
> 
> On Tue, Mar 14, 2017 at 07:23:49PM +1000, Nicholas Piggin wrote:
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


> > @@ -517,10 +526,34 @@ END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
> >  	 * At this stage
> >  	 * cr2 - eq if first thread to wakeup in core
> >  	 * cr3-  gt if waking up with partial/complete hypervisor state loss
> > +	 * ISA300:
> >  	 * cr4 - gt or eq if waking up from complete hypervisor state loss.  
> 
> For ISA 300, we need to restore hypervisor thread resources if we are
> waking up a state that is as deep or deeper than
> pnv_first_deep_stop_state. In that case, we expect either the "gt" bit
> or the "eq" bit of cr4 to be set.
> 
> Before this patch, on ISA 207, cr4 would be "eq" if we are waking up
> from winkle.

Yes, that was based on testing the thread idle state (nap/sleep/winkle).
The condition has become more complex now, so it moved below.


> >  	 */
> > 
> >  BEGIN_FTR_SECTION
> > +	/*
> > +	 * Were we in winkle?
> > +	 * If yes, check if all threads were in winkle, decrement our
> > +	 * winkle count, set all thread winkle bits if all were in winkle.
> > +	 * Check if our thread has a winkle bit set, and set cr4 accordingly
> > +	 * (to match ISA300, above).
> > +	 */
> > +	cmpwi	r18,PNV_THREAD_WINKLE
> > +	bne	2f
> > +	andis.	r9,r15,PNV_CORE_IDLE_WINKLE_COUNT_ALL_BIT@h
> > +	subis	r15,r15,PNV_CORE_IDLE_WINKLE_COUNT@h
> > +	beq	2f
> > +	ori	r15,r15,PNV_CORE_IDLE_THREAD_WINKLE_BITS /* all were winkle */  
> 
> So PNV_CORE_IDLE_THREAD_WINKLE_BITS will be set by the first waking
> thread in a winkle'd core. Subsequent waking thread(s) can only clear
> their respective bits from the winkle bits.

Yes. It was easier to do it on the wakeup side because the sleep side
does not take the lock, only uses atomic load/store.


> > +2:
> > +	/* Shift thread bit to winkle mask, then test if this thread is set,
> > +	 * and remove it from the winkle bits */
> > +	slwi	r8,r7,8
> > +	and	r8,r8,r15
> > +	andc	r15,r15,r8
> > +	cmpwi	cr4,r8,1 /* cr4 will be gt if our bit is set, lt if not */  
> 
> Very clever indeed! So we seem to be doing the following:
> 
> winkle_entry(thread_bit)
> {
> 	atomic_inc(core_winkle_count);
> }
> 
> winkle_exit(thread_bit)
> {
> 	atomic {
> 	       if (core_winkle_count == 8)
> 	       	  set all thread bits in core_winkle_mask;
> 
> 	       if (thread_bit set in core_winkle_mask) {
> 	       	  cr4 will be "gt".
> 	       }
> 
> 	       clear thread_bit from core_winkle_mask;
> 	}
> }
> 
> I would suggest documenting this a bit more documentation given the
> subtlety.

Yes, commenting the algorithm in pseudo C is probably a good idea. It is
a bit tricky to follow.

> 
> > +
> > +	cmpwi	cr4,r18,PNV_THREAD_WINKLE  
> 
> This second comparision seems to be undoing the benefit of the
> optimization by setting "eq" in cr4 for every thread that wakes up
> from winkle irrespective of whether the core has winkled or not.

No, good catch. That was some leftover debugging code that got in there
I think. Hmm, I'm not sure how much of my testing that's invalidated, so
I'll have to fix it up and re-run some more tests.

> 
> However, this is quite subtle, so good chances that my addled brain
> has gotten it wrong.
> 
> Case 1: If a thread were waking up from winkle. We have 2
>         possibilities
> 
>       a) The entire core winkled at least once ever since this thread
>       went to winkle. In this case we want cr4 to be "eq" or "gt" so
>       that we restore the hypervisor resources.
>       Now, for this case the first thread in the core that wakes up would find
>       count == PNV_CORE_IDLE_WINKLE_COUNT_ALL_BIT and hence would have
>       set PNV_CORE_IDLE_THREAD_WINKLE_BITS which includes this
>       thread's bit as well. Hence, this thread
>       would find its bit set in r8, thereby cr4 would be "gt". Which
>       is good for us!
> 
>       b) The entire core has not entered winkle. In which case we
>       haven't lost any hypervisor resources, so no need to restore
>       these. We would like cr4 to have neither "eq" nor "gt" set here.
>       In this case, no thread that has woken up prior to this thread
>       would find count == PNV_CORE_IDLE_WINKLE_COUNT_ALL_BIT. Hence
>       none of those earlier threads would set
>       PNV_CORE_IDLE_THREAD_WINKLE_BITS. Thus, for this thread, r8
>       would be 0, and hence cr4 would be "lt". Which is what we want.
>       
> 
> Case 2: If the thread is waking up from fast-sleep. In which case we
>       haven't lost any hypervisor resources, so no need to restore
>       these. We would like cr4 to have neither "eq" nor "gt" set here.
> 
>       While entering fastsleep, this thread wouldn't have contributed
>       to the winkle count. Thus any thread that would have woken up
>       before this thread would not find
>       winkle count == PNV_CORE_IDLE_WINKLE_COUNT_ALL_BIT
>       and hence wouldn't have set the bits in
>       PNV_CORE_IDLE_THREAD_WINKLE_BITS. Thus, r8 would
>       be 0, and hence cr4 would be "lt".
> 
> 
> So it seems to be the case that the first comparison suffices. What am
> I missing here ?

No, nothing you're quite right. Very thorough, thank you.

I'll respin and repost with the feedback.

Thanks,
Nick
