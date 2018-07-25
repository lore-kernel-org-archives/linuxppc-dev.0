Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bCcG6k6TzDrdc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 21:26:54 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6PBP5pX108750
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 07:26:52 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2kepdcn3wh-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 07:26:51 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 25 Jul 2018 07:26:51 -0400
Date: Wed, 25 Jul 2018 16:56:45 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2] powerpc/64s: Move idle code to powernv C code
Reply-To: ego@linux.vnet.ibm.com
References: <20180721042924.32206-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180721042924.32206-1-npiggin@gmail.com>
Message-Id: <20180725112645.GA9947@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Nicholas,

On Sat, Jul 21, 2018 at 02:29:24PM +1000, Nicholas Piggin wrote:
> Reimplement Book3S idle code to C, in the powernv platform code.
> Assembly stubs are used to save and restore the stack frame and
> non-volatile GPRs before going to idle, but these are small and
> mostly agnostic to microarchitecture implementation details.
> 
> The optimisation where EC=ESL=0 idle modes did not have to save
> GPRs or mtmsrd L=0 is restored, because it's simple to do.
> 
> Idle wakeup no longer uses the ->cpu_restore call to reinit SPRs,
> but saves and restores them all explicitly. This can easily be
> extended to tracking the set of system-wide SPRs that do not have
> to be saved each time.
> 
> Moving the HMI, SPR, OPAL, locking, etc. to C is the only real
> way this stuff will cope with non-trivial new CPU implementation
> details, firmware changes, etc., without becoming unmaintainable.
> 
> Since RFC v1:
> - Now tested and working with POWER9 hash and radix.
> - KVM support added. This took a bit of work to untangle and might
>   still have some issues, but POWER9 seems to work including hash on
>   radix with dependent threads mode.
> - This snowballed a bit because of KVM and other details making it
>   not feasible to leave POWER7/8 code alone. That's only half done
>   at the moment.
> - So far this trades about 800 lines of asm for 500 of C. With POWER7/8
>   support done it might be another hundred or so lines of C.
> 
> Would appreciate any feedback on the approach in particular the
> significantly different (and hopefully cleaner) KVM approach.


I have reviewed the C-code movement from idle_book3s.S to
powernv/idle.c. Some comments on that part of the code inline.

I haven't yet gone through the book3s_hv_rmhandlers.S code changes.


> 
> Thanks,
> Nick
> 

[..snip..]

> 
>  #ifdef CONFIG_PPC_POWERNV
> -	/* Per-core mask tracking idle threads and a lock bit-[L][TTTTTTTT] */
> -	u32 *core_idle_state_ptr;
> -	u8 thread_idle_state;		/* PNV_THREAD_RUNNING/NAP/SLEEP	*/
> -	/* Mask to indicate thread id in core */
> -	u8 thread_mask;
> -	/* Mask to denote subcore sibling threads */
> -	u8 subcore_sibling_mask;
> -	/* Flag to request this thread not to stop */
> -	atomic_t dont_stop;
> -	/* The PSSCR value that the kernel requested before going to stop */
> -	u64 requested_psscr;
> +	union {
> +		/* P7/P8 specific fields */
> +		struct {
> +			/* Per-core mask tracking idle threads and a lock bit-[L][TTTTTTTT] */
> +			unsigned long *core_idle_state_ptr;

Do we still need *core_idle_state_ptr ? Since this code is accessed
through C where we have access to paca_ptrs global variable we can
reference the "idle_state" (defined for P9 below). A lot of
locking/unlocking code in powernv/idle.c further down the patch
already does that, right?



> +			/* PNV_THREAD_RUNNING/NAP/SLEEP	*/
> +			u8 thread_idle_state;
> +			/* Mask to indicate thread id in core */
> +			u8 thread_mask;
> +			/* Mask to denote subcore sibling threads */
> +			u8 subcore_sibling_mask;
> +		};
> 
> -	/*
> -	 * Save area for additional SPRs that need to be
> -	 * saved/restored during cpuidle stop.
> -	 */
> -	struct stop_sprs stop_sprs;
> +		/* P9 specific fields */
> +		struct {
> +			/* The PSSCR value that the kernel requested before going to stop */
> +			u64 requested_psscr;
> +			unsigned long idle_state;
> +#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> +			/* Flag to request this thread not to stop */
> +			atomic_t dont_stop;
> +#endif
> +		};
> +	};
>  #endif
> 

[..snip..]

>  	/*
> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> index 12f13acee1f6..5b6af21ea9aa 100644
> --- a/arch/powerpc/platforms/powernv/idle.c
> +++ b/arch/powerpc/platforms/powernv/idle.c
> @@ -16,6 +16,7 @@
>  #include <linux/device.h>

[..snip..]

> +static inline void atomic_start_thread_idle(void)
> +{
> +	int cpu = raw_smp_processor_id();
> +	int first = cpu_first_thread_sibling(cpu);
> +	int thread_nr = cpu_thread_in_core(cpu);
> +	unsigned long *state = &paca_ptrs[first]->idle_state;

We are using this in both POWER8 and POWER9 code and are (rightly IMO)
referencing the idle_state variable.

> +
> +	clear_bit(thread_nr, state);
> +}
> +
> +static inline void atomic_stop_thread_idle(void)
> +{
> +	int cpu = raw_smp_processor_id();
> +	int first = cpu_first_thread_sibling(cpu);
> +	int thread_nr = cpu_thread_in_core(cpu);
> +	unsigned long *state = &paca_ptrs[first]->idle_state;
> +
> +	set_bit(thread_nr, state);
> +}
> +
> +static inline void atomic_lock_thread_idle(void)
> +{
> +	int cpu = raw_smp_processor_id();
> +	int first = cpu_first_thread_sibling(cpu);
> +	unsigned long *state = &paca_ptrs[first]->idle_state;
> +
> +	while (unlikely(test_and_set_bit_lock(NR_PNV_CORE_IDLE_LOCK_BIT, state)))
> +		barrier();
> +	isync();
> +}
> +
> +static inline void atomic_unlock_and_stop_thread_idle(void)
> +{
> +	int cpu = raw_smp_processor_id();
> +	int first = cpu_first_thread_sibling(cpu);
> +	unsigned long thread = 1UL << cpu_thread_in_core(cpu);
> +	unsigned long *state = &paca_ptrs[first]->idle_state;
> +	u64 s = READ_ONCE(*state);
> +	u64 new, tmp;
> +
> +	BUG_ON(!(s & PNV_CORE_IDLE_LOCK_BIT));
> +	BUG_ON(s & thread);
> +
> +again:
> +	new = (s | thread) & ~PNV_CORE_IDLE_LOCK_BIT;
> +	tmp = cmpxchg(state, s, new);
> +	if (unlikely(tmp != s)) {
> +		s = tmp;
> +		goto again;
> +	}
> +}
> +
> +static inline void atomic_unlock_thread_idle(void)
> +{
> +	int cpu = raw_smp_processor_id();
> +	int first = cpu_first_thread_sibling(cpu);
> +	unsigned long *state = &paca_ptrs[first]->idle_state;
> +
> +	BUG_ON(!test_bit(NR_PNV_CORE_IDLE_LOCK_BIT, state));
> +	clear_bit_unlock(NR_PNV_CORE_IDLE_LOCK_BIT, state);
> +}
> +
> +struct p7_sprs {
> +	/* per core */
> +	u64 tscr;
> +	u64 worc;
> +
> +	/* per subcore */
> +	u64 sdr1;
> +	u64 rpr;
> +	u64 amor;
> +
> +	/* per thread */
> +	u64 lpcr;
> +	u64 hfscr;
> +	u64 fscr;
> +	u64 pid;
> +	u64 purr;
> +	u64 spurr;
> +	u64 dscr;
> +	u64 wort;
> +
> +	u64 mmcra;
> +	u32 mmcr0;
> +	u32 mmcr1;
> +	u64 mmcr2;
> +};
> +
> +static unsigned long power7_idle_insn(unsigned long type)
> +{
> +	int cpu = raw_smp_processor_id();
> +	int first = cpu_first_thread_sibling(cpu);
> +	unsigned long thread = 1UL << cpu_thread_in_core(cpu);
> +	unsigned long *state = &paca_ptrs[first]->idle_state;

Ditto.

> +	unsigned long srr1;
> +	struct p7_sprs sprs;
> +	int rc;
> +
> +	memset(&sprs, 0, sizeof(sprs));
> +
> +	if (type != PNV_THREAD_NAP) {
> +		atomic_lock_thread_idle();
> +
> +		if (power7_fastsleep_workaround_entry) {
> +			/* XXX: lock over application, last thread of core */
> +			rc = opal_config_cpu_idle_state(OPAL_CONFIG_IDLE_FASTSLEEP,
> +							OPAL_CONFIG_IDLE_APPLY);
> +			if (rc)
> +				return 0; /* XXX */
> +		}
> +	}
> +
> +	if (type == PNV_THREAD_WINKLE) {
> +		sprs.rpr = mfspr(SPRN_RPR);
> +		sprs.tscr = mfspr(SPRN_TSCR);

Per-subcore SPRs aren't being saved here ?

> +
> +		sprs.lpcr = mfspr(SPRN_LPCR);
> +		sprs.hfscr = mfspr(SPRN_HFSCR);
> +		sprs.fscr = mfspr(SPRN_FSCR);
> +		sprs.pid = mfspr(SPRN_PID);
> +		sprs.purr = mfspr(SPRN_PURR);
> +		sprs.spurr = mfspr(SPRN_SPURR);
> +		sprs.dscr = mfspr(SPRN_DSCR);
> +
> +		sprs.mmcra = mfspr(SPRN_MMCRA);
> +		sprs.mmcr0 = mfspr(SPRN_MMCR0);
> +		sprs.mmcr1 = mfspr(SPRN_MMCR1);
> +		sprs.mmcr2 = mfspr(SPRN_MMCR2);
> +	}
> +
> +	atomic_unlock_thread_idle();
> +
> +	srr1 = isa206_idle_insn_mayloss(type);
> +
> +	WARN_ON_ONCE(!srr1);
> +	WARN_ON_ONCE(mfmsr() & (MSR_IR|MSR_DR));
> +
> +	if (unlikely((srr1 & SRR1_WAKEMASK_P8) == SRR1_WAKEHMI))
> +		hmi_exception_realmode(NULL);
> +
> +	if (likely((srr1 & SRR1_WAKESTATE) != SRR1_WS_HVLOSS))
> +		return srr1;
> +
> +	/* HV state loss */
> +	if (type == PNV_THREAD_NAP) {
> +		BUG();
> +		for (;;)
> +			;
> +	}
> +
> +	atomic_lock_thread_idle();
> +
> +	WARN_ON(*state & thread);
> +
> +	if ((*state & ((1 << threads_per_core) - 1)) != 0) {
> +		isync();
> +		goto core_woken;
> +	}
> +
> +	/* Per-core SPRs */
> +	mtspr(SPRN_RPR, sprs.rpr);
> +	mtspr(SPRN_TSCR, sprs.tscr);
> +
> +	if (power7_fastsleep_workaround_exit) {
> +		rc = opal_config_cpu_idle_state(OPAL_CONFIG_IDLE_FASTSLEEP,
> +						OPAL_CONFIG_IDLE_UNDO);
> +		WARN_ON(rc);
> +	}
> +


> +	/* TB */
> +	if (opal_resync_timebase() != OPAL_SUCCESS)
> +		BUG();

If we are waking up only from fastsleep, we won't lose any SPRs, but
only the timebase. So we can return at this point.


> +
> +core_woken:
> +	atomic_unlock_and_stop_thread_idle();
> +
> +	/* Per-thread SPRs */
> +	mtspr(SPRN_LPCR, sprs.lpcr);
> +	mtspr(SPRN_HFSCR, sprs.hfscr);
> +	mtspr(SPRN_FSCR, sprs.fscr);
> +	mtspr(SPRN_PID, sprs.pid);
> +	mtspr(SPRN_PURR, sprs.purr);
> +	mtspr(SPRN_SPURR, sprs.spurr);
> +	mtspr(SPRN_DSCR, sprs.dscr);
> +
> +	mtspr(SPRN_MMCRA, sprs.mmcra);
> +	mtspr(SPRN_MMCR0, sprs.mmcr0);
> +	mtspr(SPRN_MMCR1, sprs.mmcr1);
> +	mtspr(SPRN_MMCR2, sprs.mmcr2);
> +
> +	__slb_flush_and_rebolt();
> +
> +	return srr1;
> +}
> +
> +extern unsigned long idle_kvm_start_guest(unsigned long srr1);
> +
> +unsigned long power7_offline(void)
> +{
> +	unsigned long srr1;
> +
> +	mtmsr(MSR_IDLE);
> +
> +#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> +	/* Tell KVM we're entering idle. */
> +	/******************************************************/
> +	/*  N O T E   W E L L    ! ! !    N O T E   W E L L   */
> +	/* The following store to HSTATE_HWTHREAD_STATE(r13)  */
> +	/* MUST occur in real mode, i.e. with the MMU off,    */
> +	/* and the MMU must stay off until we clear this flag */
> +	/* and test HSTATE_HWTHREAD_REQ(r13) in               */
> +	/* pnv_powersave_wakeup in this file.                 */
> +	/* The reason is that another thread can switch the   */
> +	/* MMU to a guest context whenever this flag is set   */
> +	/* to KVM_HWTHREAD_IN_IDLE, and if the MMU was on,    */
> +	/* that would potentially cause this thread to start  */
> +	/* executing instructions from guest memory in        */
> +	/* hypervisor mode, leading to a host crash or data   */
> +	/* corruption, or worse.                              */
> +	/******************************************************/
> +	local_paca->kvm_hstate.hwthread_state = KVM_HWTHREAD_IN_IDLE;
> +#endif
> +
> +	__ppc64_runlatch_off();
> +	srr1 = power7_idle_insn(power7_offline_type);
> +	__ppc64_runlatch_on();
> +
> +#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> +	if (local_paca->kvm_hstate.hwthread_state != KVM_HWTHREAD_IN_KERNEL) {
> +		local_paca->kvm_hstate.hwthread_state = KVM_HWTHREAD_IN_KERNEL;
> +		/* Order setting hwthread_state vs. testing hwthread_req */
> +		smp_mb();
> +	}
> +	if (local_paca->kvm_hstate.hwthread_req)
> +		srr1 = idle_kvm_start_guest(srr1);
> +#endif
> +
> +	mtmsr(MSR_KERNEL);
> +
> +	return srr1;
> +}
> +
>  static unsigned long __power7_idle_type(unsigned long type)
>  {
>  	unsigned long srr1;
> @@ -320,9 +521,11 @@ static unsigned long __power7_idle_type(unsigned long type)
>  	if (!prep_irq_for_idle_irqsoff())
>  		return 0;
> 
> +	mtmsr(MSR_IDLE);
>  	__ppc64_runlatch_off();
>  	srr1 = power7_idle_insn(type);
>  	__ppc64_runlatch_on();
> +	mtmsr(MSR_KERNEL);
> 
>  	fini_irq_for_idle_irqsoff();
> 
> @@ -345,6 +548,242 @@ void power7_idle(void)
>  	power7_idle_type(PNV_THREAD_NAP);
>  }
> 
> +struct p9_sprs {
> +	/* per core */
> +	u64 ptcr;
> +	u64 rpr;
> +	u64 tscr;
> +	u64 ldbar;
> +	u64 amor;
> +
> +	/* per thread */
> +	u64 lpcr;
> +	u64 hfscr;
> +	u64 fscr;
> +	u64 pid;
> +	u64 purr;
> +	u64 spurr;
> +	u64 dscr;
> +	u64 wort;
> +
> +	u64 mmcra;
> +	u32 mmcr0;
> +	u32 mmcr1;
> +	u64 mmcr2;
> +};
> +
> +static unsigned long power9_idle_stop(unsigned long psscr, bool mmu_on)
> +{
> +	int cpu = raw_smp_processor_id();
> +	int first = cpu_first_thread_sibling(cpu);
> +	unsigned long *state = &paca_ptrs[first]->idle_state;
> +	unsigned long srr1;
> +	unsigned long mmcr0 = 0;
> +	struct p9_sprs sprs;
> +	bool sprs_saved = false;
> +
> +	if (!(psscr & (PSSCR_EC|PSSCR_ESL))) {
> +		WARN_ON(!mmu_on);

So this is a warning that we are trying to perform a ESL = 0 stop from a
kvm offline case. Hence we cannot return IR|DR disabled.

> +
> +		/*
> +		 * Wake synchronously. SRESET via xscom may still cause
> +		 * a 0x100 powersave wakeup with SRR1 reason!
> +		 */
> +		srr1 = isa3_idle_stop_noloss(psscr);
> +		if (likely(!srr1))
> +			return 0;
> +
> +		if ((srr1 & SRR1_WAKESTATE) != SRR1_WS_NOLOSS) {
> +			/*
> +			 * Registers not saved, can't recover!
> +			 * This would be a hardware bug
> +			 */
> +			BUG();
> +			for (;;)
> +				;
> +		}
> +
> +	} else {
> +		if (!cpu_has_feature(CPU_FTR_POWER9_DD2_1)) {
> +			 /*
> +			  * POWER9 DD2 can incorrectly set PMAO when waking up
> +			  * after a state-loss idle. Saving and restoring MMCR0
> +			  * over idle is a workaround.
> +			  */
> +			mmcr0 = mfspr(SPRN_MMCR0);
> +		}
> +		if ((psscr & PSSCR_RL_MASK) >= pnv_first_hv_loss_level) {
> +			sprs.lpcr = mfspr(SPRN_LPCR);
> +			sprs.hfscr = mfspr(SPRN_HFSCR);
> +			sprs.fscr = mfspr(SPRN_FSCR);
> +			sprs.pid = mfspr(SPRN_PID);
> +			sprs.purr = mfspr(SPRN_PURR);
> +			sprs.spurr = mfspr(SPRN_SPURR);
> +			sprs.dscr = mfspr(SPRN_DSCR);
> +			sprs.wort = mfspr(SPRN_WORT);
> +
> +			sprs.mmcra = mfspr(SPRN_MMCRA);
> +			sprs.mmcr0 = mfspr(SPRN_MMCR0);
> +			sprs.mmcr1 = mfspr(SPRN_MMCR1);
> +			sprs.mmcr2 = mfspr(SPRN_MMCR2);
> +
> +			sprs.ptcr = mfspr(SPRN_PTCR);
> +			sprs.rpr = mfspr(SPRN_RPR);
> +			sprs.tscr = mfspr(SPRN_TSCR);
> +			sprs.ldbar = mfspr(SPRN_LDBAR);
> +			sprs.amor = mfspr(SPRN_AMOR);
> +
> +			atomic_start_thread_idle();
> +			sprs_saved = true;
> +		}
> +#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> +		if (cpu_has_feature(CPU_FTR_P9_TM_XER_SO_BUG)) {
> +			local_paca->requested_psscr = psscr;
> +			/* order setting requested_psscr vs testing dont_stop */
> +			smp_mb();
> +			if (atomic_read(&local_paca->dont_stop)) {
> +				local_paca->requested_psscr = 0;
> +				return 0;
> +			}

Can we move the local_paca->dont_stop check early on before saving the
SPRs ?

> +
> +			srr1 = isa3_idle_stop_mayloss(psscr);
> +			local_paca->requested_psscr = 0;
> +		} else
> +#endif
> +			srr1 = isa3_idle_stop_mayloss(psscr);
> +
> +	       psscr = mfspr(SPRN_PSSCR);
> +	}
> +
> +	WARN_ON_ONCE(!srr1);
> +	WARN_ON_ONCE(mfmsr() & (MSR_IR|MSR_DR));
> +
> +	if ((srr1 & SRR1_WAKESTATE) != SRR1_WS_NOLOSS) {
> +		unsigned long mmcra;
> +
> +		/*
> +		 * Workaround for POWER9 DD2, if we lost resources, the ERAT
> +		 * might have been mixed up and needs flushing. We also need
> +		 * to reload MMCR0 (see mmcr0 comment above).
> +		 */
> +		if (!cpu_has_feature(CPU_FTR_POWER9_DD2_1)) {
> +			asm volatile(PPC_INVALIDATE_ERAT);
> +			mtspr(SPRN_MMCR0, mmcr0);
> +		}
> +
> +		/*
> +		 * DD2.2 and earlier need to set then clear bit 60 in MMCRA
> +		 * to ensure the PMU starts running.
> +		 */
> +		mmcra = mfspr(SPRN_MMCRA);
> +		mmcra |= PPC_BIT(60);
> +		mtspr(SPRN_MMCRA, mmcra);
> +		mmcra &= ~PPC_BIT(60);
> +		mtspr(SPRN_MMCRA, mmcra);
> +	}
> +
> +	if (unlikely((srr1 & SRR1_WAKEMASK_P8) == SRR1_WAKEHMI))
> +		hmi_exception_realmode(NULL);
> +
> +	/*
> +	 * On POWER9, SRR1 bits do not match exactly as expected.
> +	 * SRR1_WS_GPRLOSS (10b) can also result in SPR loss, so
> +	 * always test PSSCR if there is any state loss.
> +	 */
> +	if (likely((psscr & PSSCR_RL_MASK) < pnv_first_hv_loss_level)) {
> +		if (sprs_saved)
> +			atomic_stop_thread_idle();
> +		goto out;
> +	}
> +
> +	/* HV state loss */
> +	if (!sprs_saved) {
> +		BUG();
> +		for (;;)
> +			;
> +	}
> +
> +	atomic_lock_thread_idle();
> +
> +	if ((*state & ((1 << threads_per_core) - 1)) != 0)
> +		goto core_woken;
> +
> +	/* Per-core SPRs */
> +	mtspr(SPRN_PTCR, sprs.ptcr);
> +	mtspr(SPRN_RPR, sprs.rpr);
> +	mtspr(SPRN_TSCR, sprs.tscr);
> +	mtspr(SPRN_LDBAR, sprs.ldbar);
> +	mtspr(SPRN_AMOR, sprs.amor);
> +
> +	if ((psscr & PSSCR_RL_MASK) >= pnv_first_tb_loss_level) {
> +		/* TB loss */
> +		if (opal_resync_timebase() != OPAL_SUCCESS)
> +			BUG();
> +	}
> +
> +core_woken:
> +	atomic_unlock_and_stop_thread_idle();
> +
> +	/* Per-thread SPRs */
> +	mtspr(SPRN_LPCR, sprs.lpcr);
> +	mtspr(SPRN_HFSCR, sprs.hfscr);
> +	mtspr(SPRN_FSCR, sprs.fscr);
> +	mtspr(SPRN_PID, sprs.pid);
> +	mtspr(SPRN_PURR, sprs.purr);
> +	mtspr(SPRN_SPURR, sprs.spurr);
> +	mtspr(SPRN_DSCR, sprs.dscr);
> +	mtspr(SPRN_WORT, sprs.wort);
> +
> +	mtspr(SPRN_MMCRA, sprs.mmcra);
> +	mtspr(SPRN_MMCR0, sprs.mmcr0);
> +	mtspr(SPRN_MMCR1, sprs.mmcr1);
> +	mtspr(SPRN_MMCR2, sprs.mmcr2);

We need to set SPRN_SPRG3 to local_paca->sprg_vdso. Something I missed
last year while adding restore_additional_sprs.


> +
> +	if (!radix_enabled())
> +		__slb_flush_and_rebolt();
> +
> +out:
> +	if (mmu_on)
> +		mtmsr(MSR_KERNEL);
> +
> +	return srr1;
> +}
> +
> +unsigned long power9_offline_stop(unsigned long psscr)
> +{
> +	unsigned long srr1;
> +
> +#ifndef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> +	__ppc64_runlatch_off();
> +	srr1 = power9_idle_stop(psscr, true);
> +	__ppc64_runlatch_on();
> +#else
> +	/*
> +	 * Tell KVM we're entering idle.
> +	 * This does not have to be done in real mode because the P9 MMU
> +	 * is independent per-thread. Some steppings share radix/hash mode
> +	 * between threads, but in that case KVM has a barrier sync in real
> +	 * mode before and after switching between radix and hash.
> +	 */
> +	local_paca->kvm_hstate.hwthread_state = KVM_HWTHREAD_IN_IDLE;
> +
> +	__ppc64_runlatch_off();
> +	srr1 = power9_idle_stop(psscr, false);


Ok, so the "mmu_on" parameter for power9_idle_stop() indicates whether
we should return from the function call with translation enabled or
not. In the case we are offlining the secondaries in the context of
KVM, we want to ensure that when we wakeup we are still in real-mode
so that we can perform the hypervisor--> guest transition in
real-mode.

Is this understanding correct ?

If yes, and we requested an ESL=0 stop here (may be the device tree
only had lite states), then srr1 returned by the function will be 0
here.

Shouldn't we explicitly set an MSR_IDLE at this point ? 

> +	__ppc64_runlatch_on();
> +
> +	if (local_paca->kvm_hstate.hwthread_state != KVM_HWTHREAD_IN_KERNEL) {
> +		local_paca->kvm_hstate.hwthread_state = KVM_HWTHREAD_IN_KERNEL;
> +		/* Order setting hwthread_state vs. testing hwthread_req */
> +		smp_mb();
> +	}
> +	if (local_paca->kvm_hstate.hwthread_req)
> +		srr1 = idle_kvm_start_guest(srr1);
> +	mtmsr(MSR_KERNEL);
> +#endif
> +
> +	return srr1;
> +}
> +
>  static unsigned long __power9_idle_type(unsigned long stop_psscr_val,
>  				      unsigned long stop_psscr_mask)
>  {
> @@ -358,7 +797,7 @@ static unsigned long __power9_idle_type(unsigned long stop_psscr_val,
>  	psscr = (psscr & ~stop_psscr_mask) | stop_psscr_val;
> 
>  	__ppc64_runlatch_off();
> -	srr1 = power9_idle_stop(psscr);
> +	srr1 = power9_idle_stop(psscr, true);
>  	__ppc64_runlatch_on();
> 
>  	fini_irq_for_idle_irqsoff();
> @@ -407,7 +846,7 @@ void pnv_power9_force_smt4_catch(void)
>  			atomic_inc(&paca_ptrs[cpu0+thr]->dont_stop);
>  	}
>  	/* order setting dont_stop vs testing requested_psscr */
> -	mb();
> +	smp_mb();
>  	for (thr = 0; thr < threads_per_core; ++thr) {
>  		if (!paca_ptrs[cpu0+thr]->requested_psscr)
>  			++awake_threads;
> @@ -466,7 +905,7 @@ static void pnv_program_cpu_hotplug_lpcr(unsigned int cpu, u64 lpcr_val)
>  	 * Program the LPCR via stop-api only if the deepest stop state
>  	 * can lose hypervisor context.
>  	 */
> -	if (supported_cpuidle_states & OPAL_PM_LOSE_FULL_CONTEXT)
> +	if (pm_flags_possible & OPAL_PM_LOSE_FULL_CONTEXT)
>  		opal_slw_set_reg(pir, SPRN_LPCR, lpcr_val);
>  }
> 
> @@ -478,7 +917,6 @@ static void pnv_program_cpu_hotplug_lpcr(unsigned int cpu, u64 lpcr_val)
>  unsigned long pnv_cpu_offline(unsigned int cpu)
>  {
>  	unsigned long srr1;
> -	u32 idle_states = pnv_get_supported_cpuidle_states();
>  	u64 lpcr_val;
> 
>  	/*
> @@ -503,15 +941,8 @@ unsigned long pnv_cpu_offline(unsigned int cpu)
>  		psscr = (psscr & ~pnv_deepest_stop_psscr_mask) |
>  						pnv_deepest_stop_psscr_val;
>  		srr1 = power9_offline_stop(psscr);
> -
> -	} else if ((idle_states & OPAL_PM_WINKLE_ENABLED) &&
> -		   (idle_states & OPAL_PM_LOSE_FULL_CONTEXT)) {
> -		srr1 = power7_idle_insn(PNV_THREAD_WINKLE);
> -	} else if ((idle_states & OPAL_PM_SLEEP_ENABLED) ||
> -		   (idle_states & OPAL_PM_SLEEP_ENABLED_ER1)) {
> -		srr1 = power7_idle_insn(PNV_THREAD_SLEEP);
> -	} else if (idle_states & OPAL_PM_NAP_ENABLED) {
> -		srr1 = power7_idle_insn(PNV_THREAD_NAP);
> +	} else if (cpu_has_feature(CPU_FTR_ARCH_206) && power7_offline_type) {
> +		srr1 = power7_offline();
>  	} else {
>  		/* This is the fallback method. We emulate snooze */
>  		while (!generic_check_cpu_restart(cpu)) {
> @@ -623,7 +1054,8 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
>  	u64 *psscr_val = NULL;
>  	u64 *psscr_mask = NULL;
>  	u32 *residency_ns = NULL;
> -	u64 max_residency_ns = 0;
> +	u64 max_deep_residency_ns = 0;
> +	u64 max_default_residency_ns = 0;
>  	int rc = 0, i;
> 
>  	psscr_val = kcalloc(dt_idle_states, sizeof(*psscr_val), GFP_KERNEL);
> @@ -661,26 +1093,33 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
>  	}
> 
>  	/*
> -	 * Set pnv_first_deep_stop_state, pnv_deepest_stop_psscr_{val,mask},
> -	 * and the pnv_default_stop_{val,mask}.
> -	 *
> -	 * pnv_first_deep_stop_state should be set to the first stop
> -	 * level to cause hypervisor state loss.
> -	 *
>  	 * pnv_deepest_stop_{val,mask} should be set to values corresponding to
>  	 * the deepest stop state.
>  	 *
>  	 * pnv_default_stop_{val,mask} should be set to values corresponding to
> -	 * the shallowest (OPAL_PM_STOP_INST_FAST) loss-less stop state.
> +	 * the deepest loss-less (OPAL_PM_STOP_INST_FAST) stop state.
>  	 */
> -	pnv_first_deep_stop_state = MAX_STOP_STATE;
> +	pnv_first_tb_loss_level = MAX_STOP_STATE + 1;
> +	pnv_first_hv_loss_level = MAX_STOP_STATE + 1;
>  	for (i = 0; i < dt_idle_states; i++) {
>  		int err;
>  		u64 psscr_rl = psscr_val[i] & PSSCR_RL_MASK;
> 
> +		/*
> +		 * Deep state idle entry/exit does not currently cope with
> +		 * states that lose timebase but not SPRs, skip.
> +		 */
> +		if ( (flags[i] & OPAL_PM_TIMEBASE_STOP) &&
> +		    !(flags[i] & OPAL_PM_LOSE_FULL_CONTEXT))
> +			continue;

On POWER8 we have the capability of handling fastsleep which loses
timebase but not SPRs.

Would it be ok to set the pnv_first_hv_loss_level to the smallest of
the first state that loses either TIMEBASE or FULL_CONTEXT ? Worst
case we will end up restoring the SPRs which are not lost, but
functionally that is not incorrect no?


> +
> +		if ((flags[i] & OPAL_PM_TIMEBASE_STOP) &&
> +		     (pnv_first_tb_loss_level > psscr_rl))
> +			pnv_first_tb_loss_level = psscr_rl;
> +
>  		if ((flags[i] & OPAL_PM_LOSE_FULL_CONTEXT) &&
> -		     (pnv_first_deep_stop_state > psscr_rl))
> -			pnv_first_deep_stop_state = psscr_rl;
> +		     (pnv_first_hv_loss_level > psscr_rl))
> +			pnv_first_hv_loss_level = psscr_rl;
> 
>  		err = validate_psscr_val_mask(&psscr_val[i], &psscr_mask[i],
>  					      flags[i]);

--
Thanks and Regards
gautham.
