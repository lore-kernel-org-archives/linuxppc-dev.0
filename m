Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41mky623tkzDqww
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2018 09:30:21 +1000 (AEST)
Received: by mail-pl0-x242.google.com with SMTP id g6-v6so3190669plq.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Aug 2018 16:30:21 -0700 (PDT)
Date: Fri, 10 Aug 2018 09:30:11 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, Mahesh Jagannath
 Salgaonkar <mahesh@linux.vnet.ibm.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, Akshay Adiga
 <akshay.adiga@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] powerpc/64s: reimplement book3s idle code in C
Message-ID: <20180810093011.321e4081@roar.ozlabs.ibm.com>
In-Reply-To: <20180809144504.GB14215@in.ibm.com>
References: <20180803041350.25493-1-npiggin@gmail.com>
 <20180803041350.25493-2-npiggin@gmail.com>
 <20180809144504.GB14215@in.ibm.com>
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

On Thu, 9 Aug 2018 20:15:04 +0530
Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:

> Hello Nicholas,
> On Fri, Aug 03, 2018 at 02:13:50PM +1000, Nicholas Piggin wrote:
> > Reimplement Book3S idle code in C, moving POWER7/8/9 implementation
> > speific HV idle code to the powernv platform code. Generic book3s
> > assembly stubs are kept in common code and used only to save and
> > restore the stack frame and non-volatile GPRs just before going to
> > idle and just after waking up, which can return into C code.
> > 
> > Moving the HMI, SPR, OPAL, locking, etc. to C is the only real
> > way this stuff will cope with non-trivial new CPU implementation
> > details, firmware changes, etc., without becoming unmaintainable.
> > 
> > This is not a strict translation to C code, there are some
> > differences.
> > 
> > - Idle wakeup no longer uses the ->cpu_restore call to reinit SPRs,
> >   but saves and restores them all explicitly.
> > 
> > - The optimisation where EC=ESL=0 idle modes did not have to save
> >   GPRs or change MSR is restored, because it's now simple to do.
> >   State loss modes that did not actually lose GPRs can use this
> >   optimization too.
> > 
> > - KVM secondary entry code is now more of a call/return style
> >   rather than spaghetti. nap_state_lost is not required beccause
> >   KVM always returns via NVGPR restorig path.
> > 
> > This seems pretty solid, so needs more review and testing now. The
> > KVM changes are pretty significant and complicated. POWER7 needs to
> > be tested too.
> > 
> > Open question:
> > - Why does P9 restore some of the PMU SPRs (but not others), and
> >   P8 only zeroes them?  
> 
> We are restoring MMCR0 (from the value saved in the stack) and MMCR1,
> MMCR2, and MMCRA in the stop_sprs in PACA. We saw that MMCRH and MMCRC
> are cleared on both POWER8 and POWER9. Hence we didn't restore
> them. MMCRS is being initialized by the KVM code.
> 
> Is there anything apart from these that need to be restored ?

No I'm wondering why it is we restore those on POWER9? POWER8 does not
restore them, only zeroes. What is the difference with POWER9?

I will leave that in for now so we don't change too much with one patch,
but it would be nice to document a bit better the reasons for saving or
clearing SPRs.

> 
> > 
> > Since RFC v1:
> > - Now tested and working with POWER9 hash and radix.
> > - KVM support added. This took a bit of work to untangle and might
> >   still have some issues, but POWER9 seems to work including hash on
> >   radix with dependent threads mode.
> > - This snowballed a bit because of KVM and other details making it
> >   not feasible to leave POWER7/8 code alone. That's only half done
> >   at the moment.
> > - So far this trades about 800 lines of asm for 500 of C. With POWER7/8
> >   support done it might be another hundred or so lines of C.
> > 
> > Since RFC v2:
> > - Fixed deep state SLB reloading
> > - Now tested and working with POWER8.
> > - Accounted for most feedback.
> > 
> > Since RFC v3:
> > - Rebased to powerpc merge + idle state bugfix
> > - Split SLB flush/restore code out and shared with MCE code (pseries
> >   MCE patches can also use).
> > - More testing on POWER8 including KVM with secondaries.
> > - Performance testing looks good. EC=ESL=0 is about 5% faster, other
> >   stop states look a little faster too.
> > - Adjusted SPR saving to handler POWER7, haven't tested it.  
> 
> 
> This patch looks good to me.
> 
> A couple of comments below. 
> 
> > ---  
> 
> [... snip ..]
> 
> > @@ -178,23 +177,30 @@ struct paca_struct {
> >  #endif
> > 
> >  #ifdef CONFIG_PPC_POWERNV
> > -	/* Per-core mask tracking idle threads and a lock bit-[L][TTTTTTTT] */
> > -	u32 *core_idle_state_ptr;
> > -	u8 thread_idle_state;		/* PNV_THREAD_RUNNING/NAP/SLEEP	*/
> > -	/* Mask to indicate thread id in core */
> > -	u8 thread_mask;
> > -	/* Mask to denote subcore sibling threads */
> > -	u8 subcore_sibling_mask;
> > -	/* Flag to request this thread not to stop */
> > -	atomic_t dont_stop;
> > -	/* The PSSCR value that the kernel requested before going to stop */
> > -	u64 requested_psscr;
> > +	/* PowerNV idle fields */
> > +	/* PNV_CORE_IDLE_* bits, all siblings work on thread 0 paca */
> > +	unsigned long idle_state;
> > +	union {
> > +		/* P7/P8 specific fields */
> > +		struct {
> > +			/* PNV_THREAD_RUNNING/NAP/SLEEP	*/
> > +			u8 thread_idle_state;
> > +			/* Mask to indicate thread id in core */
> > +			u8 thread_mask;  
> 
> This is no longer needed. We can get this from cpu_thread_in_core()
> from the C code.
> 
> The only place where we are currently using this is to DUMP the value
> of the thread_mask from xmon but not anywhere else in the idle entry
> code.

Good catch, removed it.

> > +			/* Mask to denote subcore sibling threads */
> > +			u8 subcore_sibling_mask;
> > +		};
> > 
> > -	/*
> > -	 * Save area for additional SPRs that need to be
> > -	 * saved/restored during cpuidle stop.
> > -	 */
> > -	struct stop_sprs stop_sprs;
> > +		/* P9 specific fields */
> > +		struct {
> > +#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> > +			/* The PSSCR value that the kernel requested before going to stop */
> > +			u64 requested_psscr;
> > +			/* Flag to request this thread not to stop */
> > +			atomic_t dont_stop;
> > +#endif
> > +		};
> > +	};
> >  #endif  
> [..snip..]
> 
> > --- a/arch/powerpc/kernel/exceptions-64s.S
> > +++ b/arch/powerpc/kernel/exceptions-64s.S
> > @@ -136,8 +136,9 @@ TRAMP_KVM(PACA_EXNMI, 0x100)
> > 
> >  #ifdef CONFIG_PPC_P7_NAP
> >  EXC_COMMON_BEGIN(system_reset_idle_common)
> > -	mfspr	r12,SPRN_SRR1
> > -	b	pnv_powersave_wakeup
> > +	mfspr	r3,SPRN_SRR1
> > +	bltlr	cr3	/* no state loss, return to idle caller */  
> 
> So, if we are in an ESL=EC=0 stop, and we get an xscom SRESET,
> I guess the expected value in SPRN_SRR1[46:47] will be
> SRR1_WS_NOLOSS.

Yes it should, because ESL=0.

> 
> In this case, though the LR would correspond to the caller of
> isa3_idle_stop_noloss(), r3 would have SPRN_SRR1 as opposed to 0 which
> is what we would have returned from isa3_idle_stop_noloss().
> 
> Do we use the value to service the NMI ?

Yes. System reset exception is cleared when the interrupt is delivered
so we can't ignore it.

> 
> > +	b	idle_return_gpr_loss
> >  #endif
> > 
> >  /*
> > @@ -416,17 +417,17 @@ EXC_COMMON_BEGIN(machine_check_idle_common)
> >  	 * Then decrement MCE nesting after finishing with the stack.
> >  	 */
> >  	ld	r3,_MSR(r1)
> > +	ld	r4,_LINK(r1)
> > 
> >  	lhz	r11,PACA_IN_MCE(r13)
> >  	subi	r11,r11,1
> >  	sth	r11,PACA_IN_MCE(r13)
> > 
> > -	/* Turn off the RI bit because SRR1 is used by idle wakeup code. */
> > -	/* Recoverability could be improved by reducing the use of SRR1. */
> > -	li	r11,0
> > -	mtmsrd	r11,1
> > -
> > -	b	pnv_powersave_wakeup_mce
> > +	mtlr	r4
> > +	rlwinm	r10,r3,47-31,30,31
> > +	cmpwi	cr3,r10,2  
> 
> Can we use SRR1_WS_GPRLOSS here as well as in IDLETEST() ?

You mean

  cmpwi    cr3,r10,SRR1_WS_GPRLOSS >> (63-47)

> 
> > +	bltlr	cr3	/* no state loss, return to idle caller */
> > +	b	idle_return_gpr_loss  
> 
> [..snip..]
> 
> > +_GLOBAL(isa206_idle_insn_mayloss)
> > +	std	r1,PACAR1(r13)
> > +	mflr	r4
> > +	mfcr	r5
> > +	/* use stack red zone rather than a new frame */
> > +	addi	r6,r1,-INT_FRAME_SIZE
> > +	SAVE_GPR(2, r6)
> > +	SAVE_NVGPRS(r6)
> > +	std	r4,_LINK(r6)
> > +	std	r5,_CCR(r6)
> > +	cmpwi	r3,PNV_THREAD_NAP
> > +	bne	1f
> > +	IDLE_STATE_ENTER_SEQ_NORET(PPC_NAP)  
> 
> We can have the following here, since we don't expect to return from
> nap. 
> 
>         b	. /* catch bugs */"
> 
> > +1:	cmpwi	r3,PNV_THREAD_SLEEP  

Sure, added.

> [..snip..]
> 
> > +static unsigned long power7_idle_insn(unsigned long type)
> > +{
> > +	int cpu = raw_smp_processor_id();
> > +	int first = cpu_first_thread_sibling(cpu);
> > +	unsigned long thread = 1UL << cpu_thread_in_core(cpu);
> > +	unsigned long *state = &paca_ptrs[first]->idle_state;
> > +	unsigned long srr1;
> > +	bool full_winkle;
> > +	struct p7_sprs sprs;
> > +	bool sprs_saved = false;
> > +	int rc;
> > +
> > +	memset(&sprs, 0, sizeof(sprs));
> > +
> > +	if (unlikely(type != PNV_THREAD_NAP)) {
> > +		atomic_lock_thread_idle();
> > +
> > +		BUG_ON(!(*state & thread));
> > +		*state &= ~thread;
> > +
> > +		if (power7_fastsleep_workaround_entry) {
> > +			if ((*state & ((1 << threads_per_core) - 1)) == 0) {
> > +				rc = opal_config_cpu_idle_state(
> > +						OPAL_CONFIG_IDLE_FASTSLEEP,
> > +						OPAL_CONFIG_IDLE_APPLY);
> > +				BUG_ON(rc);
> > +			}
> > +		}
> > +
> > +		if (type == PNV_THREAD_WINKLE) {
> > +			sprs.tscr	= mfspr(SPRN_TSCR);
> > +			sprs.worc	= mfspr(SPRN_WORC);
> > +
> > +			sprs.sdr1	= mfspr(SPRN_SDR1);
> > +			sprs.rpr	= mfspr(SPRN_RPR);
> > +			sprs.amor	= mfspr(SPRN_AMOR);
> > +
> > +			sprs.lpcr	= mfspr(SPRN_LPCR);
> > +			if (cpu_has_feature(CPU_FTR_ARCH_207S)) {
> > +				sprs.hfscr	= mfspr(SPRN_HFSCR);
> > +				sprs.fscr	= mfspr(SPRN_FSCR);
> > +			}
> > +			sprs.purr	= mfspr(SPRN_PURR);
> > +			sprs.spurr	= mfspr(SPRN_SPURR);
> > +			sprs.dscr	= mfspr(SPRN_DSCR);
> > +			sprs.wort	= mfspr(SPRN_WORT);
> > +
> > +			sprs_saved = true;
> > +
> > +			/*
> > +			 * Increment winkle counter and set all winkle bits if
> > +			 * all threads are winkling. This allows wakeup side to
> > +			 * distinguish between fast sleep and winkle state
> > +			 * loss. Fast sleep still has to resync the timebase so
> > +			 * this may not be a really big win.
> > +			 */
> > +			*state += 1 << PNV_CORE_IDLE_WINKLE_COUNT_SHIFT;
> > +			if ((*state & PNV_CORE_IDLE_WINKLE_COUNT_BITS) >> PNV_CORE_IDLE_WINKLE_COUNT_SHIFT == threads_per_core)
> > +				*state |= PNV_CORE_IDLE_THREAD_WINKLE_BITS;
> > +			WARN_ON((*state & PNV_CORE_IDLE_WINKLE_COUNT_BITS) == 0);
> > +		}
> > +
> > +		atomic_unlock_thread_idle();
> > +	}
> > +  
> 
> Could we add the following for debug purposes. We are already dumping
> thread_idle_state in xmon.
> 
>       	paca->thread_idle_state = type; 
> 
> > +	srr1 = isa206_idle_insn_mayloss(type);  
> 
> And the following: 
>       paca->thread_idle_state = PNV_THREAD_RUNNING;

Yes I'll add that.

> 
> Apart from debugging purpose, IIRC, on some versions of POWER8,
> SRR1[46:47] wasn't being updated to 0b00 when we get an xscom SRESET
> while in running state. Thus, the only way to distinguish whether we
> entered 0x100 is due to a nap/fastsleep/winkle wakeup or due to an NMI
> caused when the processor wasn't in idle state was
> paca->thread_idle_state.

We don't actually do anything with that today, do we? Is that one
of the reasons we don't use xscom SRESET on POWER8?

> 
> > +
> > +	WARN_ON_ONCE(!srr1);
> > +	WARN_ON_ONCE(mfmsr() & (MSR_IR|MSR_DR));
> > +
> > +	if (unlikely((srr1 & SRR1_WAKEMASK_P8) == SRR1_WAKEHMI))  
> [..snip..]
> 
> > +static unsigned long power9_idle_stop(unsigned long psscr, bool mmu_on)
> > +{
> > +	int cpu = raw_smp_processor_id();
> > +	int first = cpu_first_thread_sibling(cpu);
> > +	unsigned long *state = &paca_ptrs[first]->idle_state;
> > +	unsigned long srr1;
> > +	unsigned long mmcr0 = 0;
> > +	struct p9_sprs sprs;
> > +	bool sprs_saved = false;
> > +
> > +	memset(&sprs, 0, sizeof(sprs));
> > +
> > +	if (!(psscr & (PSSCR_EC|PSSCR_ESL))) {
> > +		BUG_ON(!mmu_on);
> > +
> > +		/*
> > +		 * Wake synchronously. SRESET via xscom may still cause
> > +		 * a 0x100 powersave wakeup with SRR1 reason!
> > +		 */
> > +		srr1 = isa3_idle_stop_noloss(psscr);
> > +		if (likely(!srr1))
> > +			return 0;
> > +  
> 
> We come here if if we were woken up from a ESL=0 stop by a xscom
> SRESET. Where would the SRESET be handled ?

In irq_set_pending_from_srr1(), the same as EC=1 states.

> 
> > +		/*
> > +		 * Registers not saved, can't recover!
> > +		 * This would be a hardware bug
> > +		 */
> > +		BUG_ON((srr1 & SRR1_WAKESTATE) != SRR1_WS_NOLOSS);
> > +
> > +		goto out;
> > +	}
> > +  
> 
> 
> The patch looks good otherwise, especially the idle_book3s.S :-)
> 
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

Thank you for all the reviews

Thanks,
Nick
