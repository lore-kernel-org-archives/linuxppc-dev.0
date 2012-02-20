Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C4F1EB6F9F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2012 22:40:33 +1100 (EST)
Subject: Re: [PATCH 13/30] KVM: PPC: booke: category E.HV (GS-mode) support
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <4F3EC2A1.7080702@freescale.com>
Date: Mon, 20 Feb 2012 12:40:27 +0100
Message-Id: <37B8BD82-D665-4A1F-B851-13C846BFD799@suse.de>
References: <1329498837-11717-1-git-send-email-agraf@suse.de>
 <1329498837-11717-14-git-send-email-agraf@suse.de>
 <4F3EC2A1.7080702@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 17.02.2012, at 22:12, Scott Wood wrote:

> On 02/17/2012 11:13 AM, Alexander Graf wrote:
>> From: Scott Wood <scottwood@freescale.com>
>>=20
>> Chips such as e500mc that implement category E.HV in Power ISA 2.06
>> provide hardware virtualization features, including a new MSR mode =
for
>> guest state.  The guest OS can perform many operations without =
trapping
>> into the hypervisor, including transitions to and from guest =
userspace.
>>=20
>> Since we can use SRR1[GS] to reliably tell whether an exception came =
from
>> guest state, instead of messing around with IVPR, we use DO_KVM =
similarly
>> to book3s.
>>=20
>> Current issues include:
>> - Machine checks from guest state are not routed to the host handler.
>> - The guest can cause a host oops by executing an emulated =
instruction
>>   in a page that lacks read permission.  Existing e500/4xx support =
has
>>   the same problem.
>>=20
>> Includes work by Ashish Kalra <Ashish.Kalra@freescale.com>,
>> Varun Sethi <Varun.Sethi@freescale.com>, and
>> Liu Yu <yu.liu@freescale.com>.
>>=20
>> Signed-off-by: Scott Wood <scottwood@freescale.com>
>> [agraf: remove pt_regs usage]
>> Signed-off-by: Alexander Graf <agraf@suse.de>
>> ---
>=20
> Thanks for picking this up!
>=20
>> +static unsigned long get_guest_esr(struct kvm_vcpu *vcpu)
>> +{
>> +#ifdef CONFIG_KVM_BOOKE_HV
>> +	return mfspr(SPRN_ESR);
>> +#else
>> +	return vcpu->arch.shared->esr;
>> +#endif
>> +}
>=20
> s/SPRN_ESR/SPRN_GESR/

Ouch :)

>=20
>> int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
>>                        unsigned int exit_nr)
>> {
>> -	enum emulation_result er;
>> 	int r =3D RESUME_HOST;
>>=20
>> 	/* update before a new last_exit_type is rewritten */
>> 	kvmppc_update_timing_stats(vcpu);
>>=20
>> +	switch (exit_nr) {
>> +	case BOOKE_INTERRUPT_EXTERNAL:
>> +		do_IRQ(current->thread.regs);
>> +		break;
>=20
> What will current->thread.regs point to here?  Something on the stack
> from the last normal host exception entry?

Yup. Regs only contains a few register values of volatile state that we =
shouldn't care about at this point anyways, right?

> We probably want to create a pt_regs on the stack and at least provide
> PC, LR, and r1 for perfmon interrupts and such.

We don't want guest information to leak into the host kernel, do we? =
=46rom the host's POV, any exit inside the guest happens right at the =
guest exit path of KVM.

The way we handle this on book3s is that we actually jump right into the =
real handler from asm code, right when we recovered all the MMU state. =
We could do the same here - basically move this whole thing off to asm =
code and jump right to the actual interrupt handler, not the above =
do_IRQ implementation.

Then register state in regs would also be guaranteed to be sane, since =
it's created by the interrupt handler itself.

>=20
>> @@ -384,30 +558,56 @@ int kvmppc_handle_exit(struct kvm_run *run, =
struct kvm_vcpu *vcpu,
>>=20
>> 	switch (exit_nr) {
>> 	case BOOKE_INTERRUPT_MACHINE_CHECK:
>> -		printk("MACHINE CHECK: %lx\n", mfspr(SPRN_MCSR));
>> -		kvmppc_dump_vcpu(vcpu);
>> -		r =3D RESUME_HOST;
>> +		kvm_resched(vcpu);
>> +		r =3D RESUME_GUEST;
>> 		break;
>=20
> Leave this bit out (proper machine check handling will come later).

Ok, I'll readd it with a later patch on top that also sets =
run->hw.hardware_exit_reason to something debugg'y, so user space can =
abort.

>=20
>> 	case BOOKE_INTERRUPT_PROGRAM:
>> -		if (vcpu->arch.shared->msr & MSR_PR) {
>> +		if (vcpu->arch.shared->msr & (MSR_PR | MSR_GS)) {
>> 			/* Program traps generated by user-level =
software must be handled
>> 			 * by the guest kernel. */
>> 			kvmppc_core_queue_program(vcpu, =
vcpu->arch.fault_esr);
>=20
> Should update the comment for why we're checking GS (i.e. we get a
> different trap for emulation with GS-mode).

k

>=20
>> +#define SET_VCPU(vcpu)		\
>> +        PPC_STL	vcpu, (THREAD + THREAD_KVM_VCPU)(r2)
>=20
> Change spaces to tab before PPC_STL

The whole thing gets removed a few patches later.

>=20
>> +#define LONGBYTES		(BITS_PER_LONG / 8)
>> +
>> +#define VCPU_GPR(n)     	(VCPU_GPRS + (n * LONGBYTES))
>> +#define VCPU_GUEST_SPRG(n)	(VCPU_GUEST_SPRGS + (n * LONGBYTES))
>> +
>> +/* The host stack layout: */
>> +#define HOST_R1         (0 * LONGBYTES) /* Implied by stwu. */
>> +#define HOST_CALLEE_LR  (1 * LONGBYTES)
>> +#define HOST_RUN        (2 * LONGBYTES) /* struct kvm_run */
>> +/*
>> + * r2 is special: it holds 'current', and it made nonvolatile in the
>> + * kernel with the -ffixed-r2 gcc option.
>> + */
>> +#define HOST_R2         (3 * LONGBYTES)
>> +#define HOST_NV_GPRS    (4 * LONGBYTES)
>> +#define HOST_NV_GPR(n)  (HOST_NV_GPRS + ((n - 14) * LONGBYTES))
>> +#define HOST_MIN_STACK_SIZE (HOST_NV_GPR(31) + LONGBYTES)
>> +#define HOST_STACK_SIZE ((HOST_MIN_STACK_SIZE + 15) & ~15) /* Align. =
*/
>> +#define HOST_STACK_LR   (HOST_STACK_SIZE + LONGBYTES) /* In caller =
stack frame. */
>> +
>> +#define NEED_EMU		0x00000001 /* emulation -- save nv regs =
*/
>> +#define NEED_DEAR		0x00000002 /* save faulting DEAR */
>> +#define NEED_ESR		0x00000004 /* save faulting ESR */
>> +
>> +/*
>> + * On entry:
>> + * r4 =3D vcpu, r5 =3D srr0, r6 =3D srr1
>> + * saved in vcpu: cr, ctr, r3-r13
>> + */
>> +.macro kvm_handler_common intno, srr0, flags
>> +	mfspr	r10, SPRN_PID
>> +	lwz	r8, VCPU_HOST_PID(r4)
>> +	PPC_LL	r11, VCPU_SHARED(r4)
>> +	PPC_STL	r14, VCPU_GPR(r14)(r4) /* We need a non-volatile GPR. */
>> +	li	r14, \intno
>> +
>> +	stw	r10, VCPU_GUEST_PID(r4)
>> +	mtspr	SPRN_PID, r8
>> +
>> +	.if	\flags & NEED_EMU
>> +	lwz	r9, VCPU_KVM(r4)
>> +	.endif
>> +
>> +#ifdef CONFIG_KVM_EXIT_TIMING
>> +	/* save exit time */
>> +1:	mfspr	r7, SPRN_TBRU
>> +	mfspr	r8, SPRN_TBRL
>> +	mfspr	r9, SPRN_TBRU
>> +	cmpw	r9, r7
>> +	PPC_STL	r8, VCPU_TIMING_EXIT_TBL(r4)
>> +	bne-	1b
>> +	PPC_STL	r9, VCPU_TIMING_EXIT_TBU(r4)
>> +#endif
>=20
> As you pointed out to me last time, r9 is clobbered if exit timing is
> enabled (but see below, the load of VCPU_KVM can be removed along with
> the subsequent load of LVM_LPID(r9)).

Yes, fixed a few patches later. I went with the "put patches on top of =
your patches" style instead of rebasing and modifying your patches too =
much, so that it's easier for you guys to integrate this downstream.

>=20
>> +	oris	r8, r6, MSR_CE@h
>> +#ifndef CONFIG_64BIT
>> +	stw	r6, (VCPU_SHARED_MSR + 4)(r11)
>> +#else
>> +	std	r6, (VCPU_SHARED_MSR)(r11)
>> +#endif
>> +	ori	r8, r8, MSR_ME | MSR_RI
>> +	PPC_STL	r5, VCPU_PC(r4)
>> +
>> +	/*
>> +	 * Make sure CE/ME/RI are set (if appropriate for exception =
type)
>> +	 * whether or not the guest had it set.  Since mfmsr/mtmsr are
>> +	 * somewhat expensive, skip in the common case where the guest
>> +	 * had all these bits set (and thus they're still set if
>> +	 * appropriate for the exception type).
>> +	 */
>> +	cmpw	r6, r8
>> +	.if	\flags & NEED_EMU
>> +	lwz	r9, KVM_LPID(r9)
>> +	.endif
>=20
> Where do we use r9?  This is probably left over from something old.

Looks like it, yup.


Alex
