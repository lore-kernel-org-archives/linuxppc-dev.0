Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
 [213.199.154.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 39A63B6FEA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2012 11:51:33 +1100 (EST)
Message-ID: <4F0B8B7D.4@freescale.com>
Date: Mon, 9 Jan 2012 18:51:09 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC PATCH 14/16] KVM: PPC: booke: category E.HV (GS-mode) support
References: <20111221013443.GN8378@schlenkerla.am.freescale.net>
 <1A656B06-E290-4B75-8F98-F8FAB8B817F1@suse.de>
In-Reply-To: <1A656B06-E290-4B75-8F98-F8FAB8B817F1@suse.de>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/09/2012 11:46 AM, Alexander Graf wrote:
> 
> On 21.12.2011, at 02:34, Scott Wood wrote:
> 
>> Chips such as e500mc that implement category E.HV in Power ISA 2.06
>> provide hardware virtualization features, including a new MSR mode for
>> guest state.  The guest OS can perform many operations without trapping
>> into the hypervisor, including transitions to and from guest userspace.
>>
>> Since we can use SRR1[GS] to reliably tell whether an exception came from
>> guest state, instead of messing around with IVPR, we use DO_KVM similarly
>> to book3s.
> 
> Is there any benefit of using DO_KVM? I would assume that messing with IVPR is faster.

Using the GS bit to decide which handler to run means we won't get
confused if a machine check or critical interrupt happens between
entering/exiting the guest and updating IVPR (we could use the IS bit
similarly in PR-mode).

This could be supplemented with IVPR (though that will add a few cycles
to guest entry/exit) or some sort of runtime patching (would be more
coarse-grained, active when any KVM guest exists) to avoid adding
overhead to traps when KVM is not used, but I'd like to quantify that
overhead first.  It should be much lower than what happens on book3s.

>> Current issues include:
>> - Machine checks from guest state are not routed to the host handler.
>> - The guest can cause a host oops by executing an emulated instruction
>>   in a page that lacks read permission.  Existing e500/4xx support has
>>   the same problem.
> 
> We solve that in book3s pr by doing
> 
>   LAST_INST = <known bad value>;
>   PACA->kvm_mode = <recover at next inst>;
>   lwz(guest pc);
>   do_more_stuff();
> 
> That way when an exception occurs at lwz() the DO_KVM handler checks that we're in kvm mode "recover" which does basically srr0+=4; rfi;.

I was thinking we'd check ESR[EPID] or SRR1[IS] as appropriate, and
treat it as a kernel fault (search exception table) -- but this works
too and is a bit cleaner (could be other uses of external pid), at the
expense of a couple extra instructions in the emulation path (but
probably a slightly faster host TLB handler).

The check wouldn't go in DO_KVM, though, since on bookehv that only
deals with diverting flow when xSRR1[GS] is set, which wouldn't be the
case here.

>> @@ -243,16 +324,20 @@ static int kvmppc_booke_irqprio_deliver(struct kvm_vcpu *vcpu,
>> 	case BOOKE_IRQPRIO_AP_UNAVAIL:
>> 	case BOOKE_IRQPRIO_ALIGNMENT:
>> 		allowed = 1;
>> -		msr_mask = MSR_CE|MSR_ME|MSR_DE;
>> +		msr_mask = MSR_GS | MSR_CE | MSR_ME | MSR_DE;
> 
> No need to do this. You already force MSR_GS in set_msr();

OK.  This was here since before set_msr() started doing that. :-)

>> +	if (!current->thread.kvm_vcpu) {
>> +		WARN(1, "no vcpu\n");
>> +		return -EPERM;
>> +	}
> 
> Huh?

Oops, leftover debugging.

>> +static int emulation_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
>> +{
>> +	enum emulation_result er;
>> +
>> +	er = kvmppc_emulate_instruction(run, vcpu);
>> +	switch (er) {
>> +	case EMULATE_DONE:
>> +		/* don't overwrite subtypes, just account kvm_stats */
>> +		kvmppc_account_exit_stat(vcpu, EMULATED_INST_EXITS);
>> +		/* Future optimization: only reload non-volatiles if
>> +		 * they were actually modified by emulation. */
>> +		return RESUME_GUEST_NV;
>> +
>> +	case EMULATE_DO_DCR:
>> +		run->exit_reason = KVM_EXIT_DCR;
>> +		return RESUME_HOST;
>> +
>> +	case EMULATE_FAIL:
>> +		/* XXX Deliver Program interrupt to guest. */
>> +		printk(KERN_CRIT "%s: emulation at %lx failed (%08x)\n",
>> +		       __func__, vcpu->arch.regs.nip, vcpu->arch.last_inst);
> 
> This should be throttled, otherwise the guest can spam our logs.

Yes it should, but I'm just moving the code here.

>> +		/* For debugging, encode the failing instruction and
>> +		 * report it to userspace. */
>> +		run->hw.hardware_exit_reason = ~0ULL << 32;
>> +		run->hw.hardware_exit_reason |= vcpu->arch.last_inst;
> 
> 
> I'm fairly sure you want to fix this :)

Likewise, that's what booke.c already does.  What should it do instead?

> /**
>>  * kvmppc_handle_exit
>>  *
>> @@ -374,12 +530,39 @@ out:
>> int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
>>                        unsigned int exit_nr)
>> {
>> -	enum emulation_result er;
>> 	int r = RESUME_HOST;
>>
>> 	/* update before a new last_exit_type is rewritten */
>> 	kvmppc_update_timing_stats(vcpu);
>>
>> +	/*
>> +	 * If we actually care, we could copy MSR, DEAR, and ESR to regs,
>> +	 * insert an appropriate trap number, etc.
>> +	 *
>> +	 * Seems like a waste of cycles for something that should only matter
>> +	 * to someone using sysrq-t/p or similar host kernel debug facility.
>> +	 * We have other debug facilities to get that information from a
>> +	 * guest through userspace.
>> +	 */
>> +	switch (exit_nr) {
>> +	case BOOKE_INTERRUPT_EXTERNAL:
>> +		do_IRQ(&vcpu->arch.regs);
> 
> Ah, so that's what you want to use regs for. So is having a pt_regs
> struct that only contains useful register values in half its fields
> any useful here? Or could we keep control of the registers ourselves,
> enabling us to maybe one day optimize things more.

I think it contains enough to be useful for debugging code such as sysrq
and tracers, and as noted in the comment we could copy the rest if we
care enough.  MSR might be worth copying.

It will eventually be used for machine checks as well, which I'd like to
hand reasonable register state to, at least for GPRs, LR, and PC.

If there's a good enough performance reason, we could just copy
everything over for machine checks and pass NULL to do_IRQ (I think it
can take this -- a dummy regs struct if not), but it seems premature at
the moment unless the switch already causes measured performance loss
(cache utilization?).

>> @@ -387,30 +570,56 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
>>
>> 	switch (exit_nr) {
>> 	case BOOKE_INTERRUPT_MACHINE_CHECK:
>> -		printk("MACHINE CHECK: %lx\n", mfspr(SPRN_MCSR));
>> -		kvmppc_dump_vcpu(vcpu);
>> -		r = RESUME_HOST;
>> +		kvm_resched(vcpu);
>> +		r = RESUME_GUEST;
> 
> huh?

Patch shuffling accident -- this belongs with a later patch that invokes
the host machine check handler similar to what is done with do_IRQ().
The host machine check handler needs some work first, though.

>> 		break;
>>
>> 	case BOOKE_INTERRUPT_EXTERNAL:
>> 		kvmppc_account_exit(vcpu, EXT_INTR_EXITS);
>> -		if (need_resched())
>> -			cond_resched();
>> +		kvm_resched(vcpu);
> 
> Why are we explicit about the resched? On book3s I just call kvm_resched(vcpu) before the switch().

There are a few exit types where we don't currently do the resched -- if
they're all bugs or don't-cares, we could move it out of the switch.

We probably should defer the check until after we've disabled
interrupts, similar to signals -- even if we didn't exit for an
interrupt, we could have received one after enabling them.

>> +		if (kvm_is_visible_gfn(vcpu->kvm, gfn)) {
>> +			/* The guest TLB had a mapping, but the shadow TLB
>> +			 * didn't. This could be because:
>> +			 * a) the entry is mapping the host kernel, or
>> +			 * b) the guest used a large mapping which we're faking
>> +			 * Either way, we need to satisfy the fault without
>> +			 * invoking the guest. */
>> +			kvmppc_mmu_map(vcpu, eaddr, gpaddr, gtlb_index);
>> +		} else {
>> +			/* Guest mapped and leaped at non-RAM! */
>> +			kvmppc_booke_queue_irqprio(vcpu,
>> +						   BOOKE_IRQPRIO_MACHINE_CHECK);
> 
> Are you sure? Couldn't this also be MMIO? That doesn't really improve the situation as executing from MMIO is tricky with the KVM model, but it's not necessarily bad. Oh well, I guess we'll have to do something and throwing an #MC isn't all that ugly.

I think I asked you about executing from MMIO once, and you said it
wasn't supported even in straight QEMU.  Have things changed?

>> diff --git a/arch/powerpc/kvm/booke.h b/arch/powerpc/kvm/booke.h
>> index 05d1d99..d53bcf2 100644
>> --- a/arch/powerpc/kvm/booke.h
>> +++ b/arch/powerpc/kvm/booke.h
>> @@ -48,7 +48,20 @@
>> #define BOOKE_IRQPRIO_PERFORMANCE_MONITOR 19
>> /* Internal pseudo-irqprio for level triggered externals */
>> #define BOOKE_IRQPRIO_EXTERNAL_LEVEL 20
>> -#define BOOKE_IRQPRIO_MAX 20
>> +#define BOOKE_IRQPRIO_DBELL 21
>> +#define BOOKE_IRQPRIO_DBELL_CRIT 22
>> +#define BOOKE_IRQPRIO_MAX 23
> 
> So was MAX wrong before or is it too big now?

MAX is just a marker for how many IRQPRIOs we have, not any sort of
external limit.  This patch adds new IRQPRIOs, so MAX goes up.

The actual limit is the number of bits in a long.

>> +	.if	\flags & NEED_EMU
>> +	lwz	r9, VCPU_KVM(r4)
> 
> writing r9
> 
>> +	.endif
>> +
>> +#ifdef CONFIG_KVM_EXIT_TIMING
>> +	/* save exit time */
>> +1:	mfspr	r7, SPRN_TBRU
>> +	mfspr	r8, SPRN_TBRL
>> +	mfspr	r9, SPRN_TBRU
> 
> overwriting r9 again?

Oops.  It's RFC for a reason. :-)

>> +#ifndef CONFIG_64BIT
> 
> Double negation is always hard to read. Please reverse the ifdef :)

OK.

>> +lightweight_exit:
>> +	PPC_STL	r2, HOST_R2(r1)
>> +
>> +	mfspr	r3, SPRN_PID
>> +	stw	r3, VCPU_HOST_PID(r4)
>> +	lwz	r3, VCPU_GUEST_PID(r4)
>> +	mtspr	SPRN_PID, r3
>> +
>> +	/* Save vcpu pointer for the exception handlers
>> +	 * must be done before loading guest r2.
>> +	 */
>> +//	SET_VCPU(r4)
> 
> hm?

Can just be removed, it's handled in booke's vcpu load/put.

>> +	lwz	r6, (VCPU_SHARED_MAS2 + 4)(r11)
>> +#else
>> +	ld	r6, (VCPU_SHARED_MAS2)(r11)
>> +#endif
>> +	lwz	r7, VCPU_SHARED_MAS7_3+4(r11)
>> +	lwz	r8, VCPU_SHARED_MAS4(r11)
>> +	mtspr	SPRN_MAS0, r3
>> +	mtspr	SPRN_MAS1, r5
>> +	mtspr	SPRN_MAS2, r6
>> +	mtspr	SPRN_MAS3, r7
>> +	mtspr	SPRN_MAS4, r8
>> +	lwz	r3, VCPU_SHARED_MAS6(r11)
>> +	lwz	r5, VCPU_SHARED_MAS7_3+0(r11)
>> +	mtspr	SPRN_MAS6, r3
>> +	mtspr	SPRN_MAS7, r5
>> +	/* Disable MAS register updates via exception */
>> +	mfspr	r3, SPRN_EPCR
>> +	oris	r3, r3, SPRN_EPCR_DMIUH@h
>> +	mtspr	SPRN_EPCR, r3
> 
> Shouldn't this happen before you set the MAS registers? :)

Yes (though we really shouldn't be getting a TLB miss here, at least on
e500mc).

>> +	/* Load some guest volatiles. */
>> +	PPC_LL	r3, VCPU_LR(r4)
>> +	PPC_LL	r5, VCPU_XER(r4)
>> +	PPC_LL	r6, VCPU_CTR(r4)
>> +	PPC_LL	r7, VCPU_CR(r4)
>> +	PPC_LL	r8, VCPU_PC(r4)
>> +#ifndef CONFIG_64BIT
>> +	lwz	r9, (VCPU_SHARED_MSR + 4)(r11)
>> +#else
>> +	ld	r9, (VCPU_SHARED_MSR)(r11)
>> +#endif
>> +	PPC_LL	r0, VCPU_GPR(r0)(r4)
>> +	PPC_LL	r1, VCPU_GPR(r1)(r4)
>> +	PPC_LL	r2, VCPU_GPR(r2)(r4)
>> +	PPC_LL	r10, VCPU_GPR(r10)(r4)
>> +	PPC_LL	r11, VCPU_GPR(r11)(r4)
>> +	PPC_LL	r12, VCPU_GPR(r12)(r4)
>> +	PPC_LL	r13, VCPU_GPR(r13)(r4)
>> +	mtlr	r3
>> +	mtxer	r5
>> +	mtctr	r6
>> +	mtcr	r7
>> +	mtsrr0	r8
>> +	mtsrr1	r9
> 
> Are you sure this should be shared->msr, not shadow_msr?

Yes, we don't use shadow_msr on bookehv.  I'll add a comment in the
struct definition as discussed in the other thread, as well as other
areas where there are subtle differences between PR-mode and GS-mode.

-Scott
