Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41QXMf4FxzzF35J
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2018 18:30:54 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id e13-v6so4577017pff.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2018 01:30:54 -0700 (PDT)
Date: Wed, 11 Jul 2018 18:30:36 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Vaidyanathan Srinivasan
 <svaidy@linux.vnet.ibm.com>, Akshay Adiga
 <akshay.adiga@linux.vnet.ibm.com>, huntbag@linux.vnet.ibm.com
Subject: Re: [RFC PATCH] powerpc/64s: Move ISAv3.0 / POWER9 idle code to
 powernv C code
Message-ID: <20180711183036.02c006d3@roar.ozlabs.ibm.com>
In-Reply-To: <20180710110634.GA29887@in.ibm.com>
References: <20180708142436.15714-1-npiggin@gmail.com>
 <20180710110634.GA29887@in.ibm.com>
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

On Tue, 10 Jul 2018 16:36:34 +0530
Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:

> Hello Nicholas,
> 
> 
> On Mon, Jul 09, 2018 at 12:24:36AM +1000, Nicholas Piggin wrote:
> > Reimplement POWER9 idle code in C, in the powernv platform code.
> > Assembly stubs are used to save and restore the stack frame and
> > non-volatile GPRs before going to idle, but these are small and
> > mostly agnostic to microarchitecture implementation details.
> >  
> 
> Thanks for this patch.  It is indeed hard to maneuver through the
> current assembly code and change things without introducing new bugs.

Hey thanks for the very good review. I don't mean to disparage the
existing asm code too much :) We were doing our best there to get
something working, now I think it's a good time to step back and see
what we can improve.

> > POWER7/8 code is not converted (yet), but that's not a moving
> > target, and it doesn't make you want to claw your eyes out so
> > much with the POWER9 code untangled from it.
> > 
> > The optimisation where EC=ESL=0 idle modes did not have to save
> > GPRs or mtmsrd L=0 is restored, because it's simple to do.
> > 
> > Idle wakeup no longer uses the ->cpu_restore call to reinit SPRs,
> > but saves and restores them all explicitly.  
> 
> Right! The ->cpu_restore call in the current code is rendered
> ineffective by "restore_additional_sprs" which is called after the
> cpu_restore. 

Yes, I would actually like to do an initial incremental patch for this,
and remove it from P7/8 CPU types as well. I think that's quite easy to
do, and a useful cleanup to remove it entirely.

> > diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
> > index e210a83eb196..b668f030d531 100644
> > --- a/arch/powerpc/include/asm/cpuidle.h
> > +++ b/arch/powerpc/include/asm/cpuidle.h
> > @@ -28,6 +28,7 @@
> >   * yet woken from the winkle state.
> >   */
> >  #define PNV_CORE_IDLE_LOCK_BIT			0x10000000
> > +#define NR_PNV_CORE_IDLE_LOCK_BIT		28  
> 
> We can define PNV_CORE_IDLE_LOCK_BIT mask based on
> NR_PNV_CORE_IDLE_LOCK_BIT ?

Yep good point.

> > diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> > index 76a14702cb9c..36b5f0e18c0c 100644
> > --- a/arch/powerpc/kernel/exceptions-64s.S
> > +++ b/arch/powerpc/kernel/exceptions-64s.S
> > @@ -135,8 +135,14 @@ TRAMP_KVM(PACA_EXNMI, 0x100)
> > 
> >  #ifdef CONFIG_PPC_P7_NAP
> >  EXC_COMMON_BEGIN(system_reset_idle_common)
> > +BEGIN_FTR_SECTION
> > +	mfspr	r3,SPRN_SRR1
> > +	bltlr	cr3	/* no state loss, return to idle caller */  
> 
> This is a nice optimization. But perhaps needs a carefully checked.
> We wakeup at SYSTEM_RESET only when we have executed stop via the
> mayloss() call which creates an additional stack frame. When we return
> back to the caller, we will go back with that stack frame. Perhaps we
> need to jump to a isa3_idle_wake_gpr_noloss ?

I wasn't 100% sure of all this so yes it's something I do need to
verify carefully. I did test a few different cases in mambo and stepped
through things, but could easily have bugs.

I could have got something wrong, but I think mayloss does not create
an additional stack frame, so this works okay. It's just using red zone.
... I think...

> > +_GLOBAL(isa3_idle_stop_mayloss)
> > +	std	r1,PACAR1(r13)
> > +	mflr	r4
> > +	mfcr	r5
> > +	/* use stack red zone rather than a new frame */
> > +	addi	r6,r1,-INT_FRAME_SIZE
> > +	SAVE_GPR(2, r6)
> > +	SAVE_NVGPRS(r6)
> > +	std	r4,_LINK(r6)
> > +	std	r5,_CCR(r6)
> > +	mtspr 	SPRN_PSSCR,r3
> > +	PPC_STOP  
> 
> 
> Suppose we enter into a isa3_idle_stop_may_loss (ESL=EC=1), but as
> soon as we execute PPC_STOP, if we get interrupted, we will go back to
> SYSTEM_RESET vector.
> 
> The SRR1[46:47] should be 0x1, due to which we will do a bl there,
> thereby going back to the caller of isa3_idle_stop_mayloss. Which
> implies that we need to perform the stack unwinding there.

Well we haven't modified r1 here, so I thought it should be okay. It
seems to do the right thing in mambo.

> > +static inline void atomic_unlock_thread_idle(void)
> > +{
> > +	int cpu = raw_smp_processor_id();
> > +	int first = cpu_first_thread_sibling(cpu);
> > +	unsigned long *state = &paca_ptrs[first]->idle_state;
> > +
> > +	clear_bit_unlock(NR_PNV_CORE_IDLE_LOCK_BIT, state);
> > +}
> > +
> > +static unsigned long power9_idle_stop(unsigned long psscr, bool  mmu_on)  
> 
> We are not using the mmu_on anywhere in the code. Is this for
> restoring the IR|DR bit in the MSR ?

Hmm, it's supposed to be for KVM secondaries that have to have the MMU
switched off around idle/wake. I haven't got all the KVM stuff right
yet though.


Thanks,
Nick
