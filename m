Return-Path: <npiggin@gmail.com>
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bF2t73X5zDrHF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 22:31:34 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id v13-v6so5224957pgr.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 05:31:34 -0700 (PDT)
Date: Wed, 25 Jul 2018 22:31:23 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Vaidyanathan Srinivasan
 <svaidy@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2] powerpc/64s: Move idle code to powernv C code
Message-ID: <20180725223123.0e623a0e@roar.ozlabs.ibm.com>
In-Reply-To: <20180725112645.GA9947@in.ibm.com>
References: <20180721042924.32206-1-npiggin@gmail.com>
 <20180725112645.GA9947@in.ibm.com>
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

Hi Gautham,

Thanks for the review, I also missed one or two things from you last
one, but I haven't forgotten them.

 On Wed, 25 Jul 2018 16:56:45 +0530
Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:

> Hello Nicholas,
> 
> On Sat, Jul 21, 2018 at 02:29:24PM +1000, Nicholas Piggin wrote:
> > Reimplement Book3S idle code to C, in the powernv platform code.
> > Assembly stubs are used to save and restore the stack frame and
> > non-volatile GPRs before going to idle, but these are small and
> > mostly agnostic to microarchitecture implementation details.
> > 
> > The optimisation where EC=ESL=0 idle modes did not have to save
> > GPRs or mtmsrd L=0 is restored, because it's simple to do.
> > 
> > Idle wakeup no longer uses the ->cpu_restore call to reinit SPRs,
> > but saves and restores them all explicitly. This can easily be
> > extended to tracking the set of system-wide SPRs that do not have
> > to be saved each time.
> > 
> > Moving the HMI, SPR, OPAL, locking, etc. to C is the only real
> > way this stuff will cope with non-trivial new CPU implementation
> > details, firmware changes, etc., without becoming unmaintainable.
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
> > Would appreciate any feedback on the approach in particular the
> > significantly different (and hopefully cleaner) KVM approach.  
> 
> 
> I have reviewed the C-code movement from idle_book3s.S to
> powernv/idle.c. Some comments on that part of the code inline.

Thanks. Yes the POWER7/8 code is a bit incomplete as you noticed, but
you had some good suggestions there too.

> I haven't yet gone through the book3s_hv_rmhandlers.S code changes.

Yeah that's very tricky code and I don't know if I got it right yet.
Will have to run it past the KVM people too.

> 
> 
> > 
> > Thanks,
> > Nick
> >   
> 
> [..snip..]
> 
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
> > +	union {
> > +		/* P7/P8 specific fields */
> > +		struct {
> > +			/* Per-core mask tracking idle threads and a lock bit-[L][TTTTTTTT] */
> > +			unsigned long *core_idle_state_ptr;  
> 
> Do we still need *core_idle_state_ptr ? Since this code is accessed
> through C where we have access to paca_ptrs global variable we can
> reference the "idle_state" (defined for P9 below). A lot of
> locking/unlocking code in powernv/idle.c further down the patch
> already does that, right?

Yeah you're probably right I think.

> > +
> > +	if (type == PNV_THREAD_WINKLE) {
> > +		sprs.rpr = mfspr(SPRN_RPR);
> > +		sprs.tscr = mfspr(SPRN_TSCR);  
> 
> Per-subcore SPRs aren't being saved here ?

Right, it's a bit incomplete. I'll post out a new version with P8
support soon.


> > +
> > +	if (power7_fastsleep_workaround_exit) {
> > +		rc = opal_config_cpu_idle_state(OPAL_CONFIG_IDLE_FASTSLEEP,
> > +						OPAL_CONFIG_IDLE_UNDO);
> > +		WARN_ON(rc);
> > +	}
> > +  
> 
> 
> > +	/* TB */
> > +	if (opal_resync_timebase() != OPAL_SUCCESS)
> > +		BUG();  
> 
> If we are waking up only from fastsleep, we won't lose any SPRs, but
> only the timebase. So we can return at this point.

Okay, got it.

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
> > +	if (!(psscr & (PSSCR_EC|PSSCR_ESL))) {
> > +		WARN_ON(!mmu_on);  
> 
> So this is a warning that we are trying to perform a ESL = 0 stop from a
> kvm offline case. Hence we cannot return IR|DR disabled.

Yes.

> > +#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> > +		if (cpu_has_feature(CPU_FTR_P9_TM_XER_SO_BUG)) {
> > +			local_paca->requested_psscr = psscr;
> > +			/* order setting requested_psscr vs testing dont_stop */
> > +			smp_mb();
> > +			if (atomic_read(&local_paca->dont_stop)) {
> > +				local_paca->requested_psscr = 0;
> > +				return 0;
> > +			}  
> 
> Can we move the local_paca->dont_stop check early on before saving the
> SPRs ?

It should be a very rare case but yes I don't see why not.

> > +	/* Per-thread SPRs */
> > +	mtspr(SPRN_LPCR, sprs.lpcr);
> > +	mtspr(SPRN_HFSCR, sprs.hfscr);
> > +	mtspr(SPRN_FSCR, sprs.fscr);
> > +	mtspr(SPRN_PID, sprs.pid);
> > +	mtspr(SPRN_PURR, sprs.purr);
> > +	mtspr(SPRN_SPURR, sprs.spurr);
> > +	mtspr(SPRN_DSCR, sprs.dscr);
> > +	mtspr(SPRN_WORT, sprs.wort);
> > +
> > +	mtspr(SPRN_MMCRA, sprs.mmcra);
> > +	mtspr(SPRN_MMCR0, sprs.mmcr0);
> > +	mtspr(SPRN_MMCR1, sprs.mmcr1);
> > +	mtspr(SPRN_MMCR2, sprs.mmcr2);  
> 
> We need to set SPRN_SPRG3 to local_paca->sprg_vdso. Something I missed
> last year while adding restore_additional_sprs.

Will add that.

> > +unsigned long power9_offline_stop(unsigned long psscr)
> > +{
> > +	unsigned long srr1;
> > +
> > +#ifndef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> > +	__ppc64_runlatch_off();
> > +	srr1 = power9_idle_stop(psscr, true);
> > +	__ppc64_runlatch_on();
> > +#else
> > +	/*
> > +	 * Tell KVM we're entering idle.
> > +	 * This does not have to be done in real mode because the P9 MMU
> > +	 * is independent per-thread. Some steppings share radix/hash mode
> > +	 * between threads, but in that case KVM has a barrier sync in real
> > +	 * mode before and after switching between radix and hash.
> > +	 */
> > +	local_paca->kvm_hstate.hwthread_state = KVM_HWTHREAD_IN_IDLE;
> > +
> > +	__ppc64_runlatch_off();
> > +	srr1 = power9_idle_stop(psscr, false);  
> 
> 
> Ok, so the "mmu_on" parameter for power9_idle_stop() indicates whether
> we should return from the function call with translation enabled or
> not. In the case we are offlining the secondaries in the context of
> KVM, we want to ensure that when we wakeup we are still in real-mode
> so that we can perform the hypervisor--> guest transition in
> real-mode.
> 
> Is this understanding correct ?

Yes basically. Well we can wake up in guest MMU context so host
can't turn the MMU back on before calling back to KVM code.

> If yes, and we requested an ESL=0 stop here (may be the device tree
> only had lite states), then srr1 returned by the function will be 0
> here.
> 
> Shouldn't we explicitly set an MSR_IDLE at this point ? 

Previously we could not support EC=0 mode because KVM required a SRESET
wake up. The C code does not require that, but I still don't think it
can work properly because we don't get an SRR1. Without that, I think
KVM doesn't know what to do when it wakes up. So I think it's a bit
harder than it looks.

> > @@ -661,26 +1093,33 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
> >  	}
> > 
> >  	/*
> > -	 * Set pnv_first_deep_stop_state, pnv_deepest_stop_psscr_{val,mask},
> > -	 * and the pnv_default_stop_{val,mask}.
> > -	 *
> > -	 * pnv_first_deep_stop_state should be set to the first stop
> > -	 * level to cause hypervisor state loss.
> > -	 *
> >  	 * pnv_deepest_stop_{val,mask} should be set to values corresponding to
> >  	 * the deepest stop state.
> >  	 *
> >  	 * pnv_default_stop_{val,mask} should be set to values corresponding to
> > -	 * the shallowest (OPAL_PM_STOP_INST_FAST) loss-less stop state.
> > +	 * the deepest loss-less (OPAL_PM_STOP_INST_FAST) stop state.
> >  	 */
> > -	pnv_first_deep_stop_state = MAX_STOP_STATE;
> > +	pnv_first_tb_loss_level = MAX_STOP_STATE + 1;
> > +	pnv_first_hv_loss_level = MAX_STOP_STATE + 1;
> >  	for (i = 0; i < dt_idle_states; i++) {
> >  		int err;
> >  		u64 psscr_rl = psscr_val[i] & PSSCR_RL_MASK;
> > 
> > +		/*
> > +		 * Deep state idle entry/exit does not currently cope with
> > +		 * states that lose timebase but not SPRs, skip.
> > +		 */
> > +		if ( (flags[i] & OPAL_PM_TIMEBASE_STOP) &&
> > +		    !(flags[i] & OPAL_PM_LOSE_FULL_CONTEXT))
> > +			continue;  
> 
> On POWER8 we have the capability of handling fastsleep which loses
> timebase but not SPRs.

Right.

> Would it be ok to set the pnv_first_hv_loss_level to the smallest of
> the first state that loses either TIMEBASE or FULL_CONTEXT ? Worst
> case we will end up restoring the SPRs which are not lost, but
> functionally that is not incorrect no?

This is POWER9 init so it should be okay, I will do that for POWER8.

I could just force the FULL_STOP flag for POWER9 case so theoretical
future state that loses TB first can at least be used as you say,
without adding too much complexity or untested code.

Thanks,
Nick
