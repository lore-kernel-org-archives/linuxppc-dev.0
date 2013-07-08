Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 8D20D2C007C
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Jul 2013 23:39:11 +1000 (EST)
Subject: Re: [PATCH 2/2] KVM: PPC: Book3E: Get vcpu's last instruction for
 emulation
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1372411203-14795-2-git-send-email-mihai.caraman@freescale.com>
Date: Mon, 8 Jul 2013 15:39:05 +0200
Message-Id: <3079C0F5-E13B-4572-8C9D-BCE558AF64D8@suse.de>
References: <1372411203-14795-1-git-send-email-mihai.caraman@freescale.com>
 <1372411203-14795-2-git-send-email-mihai.caraman@freescale.com>
To: Mihai Caraman <mihai.caraman@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 28.06.2013, at 11:20, Mihai Caraman wrote:

> lwepx faults needs to be handled by KVM and this implies additional =
code
> in DO_KVM macro to identify the source of the exception originated =
from
> host context. This requires to check the Exception Syndrome Register
> (ESR[EPID]) and External PID Load Context Register (EPLC[EGS]) for =
DTB_MISS,
> DSI and LRAT exceptions which is too intrusive for the host.
>=20
> Get rid of lwepx and acquire last instuction in kvmppc_handle_exit() =
by
> searching for the physical address and kmap it. This fixes an infinite =
loop

What's the difference in speed for this?

Also, could we call lwepx later in host code, when =
kvmppc_get_last_inst() gets invoked?

> caused by lwepx's data TLB miss handled in the host and the TODO for =
TLB
> eviction and execute-but-not-read entries.
>=20
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
> Resend this pacth for Alex G. he was unsubscribed from kvm-ppc mailist
> for a while.
>=20
> arch/powerpc/include/asm/mmu-book3e.h |    6 ++-
> arch/powerpc/kvm/booke.c              |    6 +++
> arch/powerpc/kvm/booke.h              |    2 +
> arch/powerpc/kvm/bookehv_interrupts.S |   32 ++-------------
> arch/powerpc/kvm/e500.c               |    4 ++
> arch/powerpc/kvm/e500mc.c             |   69 =
+++++++++++++++++++++++++++++++++
> 6 files changed, 91 insertions(+), 28 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/mmu-book3e.h =
b/arch/powerpc/include/asm/mmu-book3e.h
> index 99d43e0..32e470e 100644
> --- a/arch/powerpc/include/asm/mmu-book3e.h
> +++ b/arch/powerpc/include/asm/mmu-book3e.h
> @@ -40,7 +40,10 @@
>=20
> /* MAS registers bit definitions */
>=20
> -#define MAS0_TLBSEL(x)		(((x) << 28) & 0x30000000)
> +#define MAS0_TLBSEL_MASK	0x30000000
> +#define MAS0_TLBSEL_SHIFT	28
> +#define MAS0_TLBSEL(x)		(((x) << MAS0_TLBSEL_SHIFT) & =
MAS0_TLBSEL_MASK)
> +#define MAS0_GET_TLBSEL(mas0)	(((mas0) & MAS0_TLBSEL_MASK) >> =
MAS0_TLBSEL_SHIFT)
> #define MAS0_ESEL_MASK		0x0FFF0000
> #define MAS0_ESEL_SHIFT		16
> #define MAS0_ESEL(x)		(((x) << MAS0_ESEL_SHIFT) & =
MAS0_ESEL_MASK)
> @@ -58,6 +61,7 @@
> #define MAS1_TSIZE_MASK		0x00000f80
> #define MAS1_TSIZE_SHIFT	7
> #define MAS1_TSIZE(x)		(((x) << MAS1_TSIZE_SHIFT) & =
MAS1_TSIZE_MASK)
> +#define MAS1_GET_TSIZE(mas1)	(((mas1) & MAS1_TSIZE_MASK) >> =
MAS1_TSIZE_SHIFT)
>=20
> #define MAS2_EPN		(~0xFFFUL)
> #define MAS2_X0			0x00000040
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index 1020119..6764a8e 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -836,6 +836,12 @@ int kvmppc_handle_exit(struct kvm_run *run, =
struct kvm_vcpu *vcpu,
> 	/* update before a new last_exit_type is rewritten */
> 	kvmppc_update_timing_stats(vcpu);
>=20
> +	/*
> +	 * The exception type can change at this point, such as if the =
TLB entry
> +	 * for the emulated instruction has been evicted.
> +	 */
> +	kvmppc_prepare_for_emulation(vcpu, &exit_nr);

Please model this the same way as book3s. Check out =
kvmppc_get_last_inst() as a starting point.

> +
> 	/* restart interrupts if they were meant for the host */
> 	kvmppc_restart_interrupt(vcpu, exit_nr);
>=20
> diff --git a/arch/powerpc/kvm/booke.h b/arch/powerpc/kvm/booke.h
> index 5fd1ba6..a0d0fea 100644
> --- a/arch/powerpc/kvm/booke.h
> +++ b/arch/powerpc/kvm/booke.h
> @@ -90,6 +90,8 @@ void kvmppc_vcpu_disable_spe(struct kvm_vcpu *vcpu);
> void kvmppc_booke_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
> void kvmppc_booke_vcpu_put(struct kvm_vcpu *vcpu);
>=20
> +void kvmppc_prepare_for_emulation(struct kvm_vcpu *vcpu, unsigned int =
*exit_nr);
> +
> enum int_class {
> 	INT_CLASS_NONCRIT,
> 	INT_CLASS_CRIT,
> diff --git a/arch/powerpc/kvm/bookehv_interrupts.S =
b/arch/powerpc/kvm/bookehv_interrupts.S
> index 20c7a54..0538ab9 100644
> --- a/arch/powerpc/kvm/bookehv_interrupts.S
> +++ b/arch/powerpc/kvm/bookehv_interrupts.S
> @@ -120,37 +120,20 @@
>=20
> 	.if	\flags & NEED_EMU
> 	/*
> -	 * This assumes you have external PID support.
> -	 * To support a bookehv CPU without external PID, you'll
> -	 * need to look up the TLB entry and create a temporary mapping.
> -	 *
> -	 * FIXME: we don't currently handle if the lwepx faults.  =
PR-mode
> -	 * booke doesn't handle it either.  Since Linux doesn't use
> -	 * broadcast tlbivax anymore, the only way this should happen is
> -	 * if the guest maps its memory execute-but-not-read, or if we
> -	 * somehow take a TLB miss in the middle of this entry code and
> -	 * evict the relevant entry.  On e500mc, all kernel lowmem is
> -	 * bolted into TLB1 large page mappings, and we don't use
> -	 * broadcast invalidates, so we should not take a TLB miss here.
> -	 *
> -	 * Later we'll need to deal with faults here.  Disallowing guest
> -	 * mappings that are execute-but-not-read could be an option on
> -	 * e500mc, but not on chips with an LRAT if it is used.
> +	 * We don't use external PID support. lwepx faults would need to =
be
> +	 * handled by KVM and this implies aditional code in DO_KVM (for
> +	 * DTB_MISS, DSI and LRAT) to check ESR[EPID] and EPLC[EGS] =
which
> +	 * is too intrusive for the host. Get last instuction in
> +	 * kvmppc_handle_exit().
> 	 */
> -
> -	mfspr	r3, SPRN_EPLC	/* will already have correct ELPID and =
EGS */
> 	PPC_STL	r15, VCPU_GPR(R15)(r4)
> 	PPC_STL	r16, VCPU_GPR(R16)(r4)
> 	PPC_STL	r17, VCPU_GPR(R17)(r4)
> 	PPC_STL	r18, VCPU_GPR(R18)(r4)
> 	PPC_STL	r19, VCPU_GPR(R19)(r4)
> -	mr	r8, r3
> 	PPC_STL	r20, VCPU_GPR(R20)(r4)
> -	rlwimi	r8, r6, EPC_EAS_SHIFT - MSR_IR_LG, EPC_EAS
> 	PPC_STL	r21, VCPU_GPR(R21)(r4)
> -	rlwimi	r8, r6, EPC_EPR_SHIFT - MSR_PR_LG, EPC_EPR
> 	PPC_STL	r22, VCPU_GPR(R22)(r4)
> -	rlwimi	r8, r10, EPC_EPID_SHIFT, EPC_EPID
> 	PPC_STL	r23, VCPU_GPR(R23)(r4)
> 	PPC_STL	r24, VCPU_GPR(R24)(r4)
> 	PPC_STL	r25, VCPU_GPR(R25)(r4)
> @@ -160,11 +143,6 @@
> 	PPC_STL	r29, VCPU_GPR(R29)(r4)
> 	PPC_STL	r30, VCPU_GPR(R30)(r4)
> 	PPC_STL	r31, VCPU_GPR(R31)(r4)
> -	mtspr	SPRN_EPLC, r8
> -	isync
> -	lwepx   r9, 0, r5
> -	mtspr	SPRN_EPLC, r3
> -	stw	r9, VCPU_LAST_INST(r4)
> 	.endif
>=20
> 	.if	\flags & NEED_ESR
> diff --git a/arch/powerpc/kvm/e500.c b/arch/powerpc/kvm/e500.c
> index ce6b73c..c82a89f 100644
> --- a/arch/powerpc/kvm/e500.c
> +++ b/arch/powerpc/kvm/e500.c
> @@ -439,6 +439,10 @@ int kvmppc_set_one_reg(struct kvm_vcpu *vcpu, u64 =
id,
> 	return r;
> }
>=20
> +void kvmppc_prepare_for_emulation(struct kvm_vcpu *vcpu, unsigned int =
*exit_nr)
> +{
> +}
> +
> struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int =
id)
> {
> 	struct kvmppc_vcpu_e500 *vcpu_e500;
> diff --git a/arch/powerpc/kvm/e500mc.c b/arch/powerpc/kvm/e500mc.c
> index c3bdc0a..3641df7 100644
> --- a/arch/powerpc/kvm/e500mc.c
> +++ b/arch/powerpc/kvm/e500mc.c
> @@ -271,6 +271,75 @@ int kvmppc_set_one_reg(struct kvm_vcpu *vcpu, u64 =
id,
> 	return r;
> }
>=20
> +void kvmppc_prepare_for_emulation(struct kvm_vcpu *vcpu, unsigned int =
*exit_nr)

This really should be a generic "read data from guest address space" =
operation for the guest mmu handling code. Please implement that in =
e500_mmu.c.

> +{
> +	gva_t geaddr;
> +	hpa_t addr;
> +	u64 mas7_mas3;
> +	hva_t eaddr;
> +	u32 mas1, mas3;
> +	struct page *page;
> +	unsigned int addr_space, psize_shift;
> +	bool pr;
> +
> +	if ((*exit_nr !=3D BOOKE_INTERRUPT_DATA_STORAGE) &&
> +	    (*exit_nr !=3D BOOKE_INTERRUPT_DTLB_MISS) &&
> +	    (*exit_nr !=3D BOOKE_INTERRUPT_HV_PRIV))
> +		return;
> +
> +	/* Search guest translation to find the real addressss */
> +	geaddr =3D vcpu->arch.pc;
> +	addr_space =3D (vcpu->arch.shared->msr & MSR_IS) >> MSR_IR_LG;
> +	mtspr(SPRN_MAS6, (vcpu->arch.pid << MAS6_SPID_SHIFT) | =
addr_space);
> +	mtspr(SPRN_MAS5, MAS5_SGS | vcpu->kvm->arch.lpid);
> +	isync();
> +	asm volatile("tlbsx 0, %[geaddr]\n" : : [geaddr] "r" (geaddr));
> +	mtspr(SPRN_MAS5, 0);
> +	mtspr(SPRN_MAS8, 0);=09

Doesn't this break when a secondary thread eliminated that TLB entry by =
accident?

> +
> +	mas1 =3D mfspr(SPRN_MAS1);
> +	if (!(mas1 & MAS1_VALID)) {
> +		/*
> +	 	 * There is no translation for the emulated instruction.
> +		 * Simulate an instruction TLB miss. This should force =
the host
> +		 * or ultimately the guest to add the translation and =
then
> +		 * reexecute the instruction.
> +		 */
> +		*exit_nr =3D BOOKE_INTERRUPT_ITLB_MISS;

Ah, so that's how you handle that case. Please don't swizzle around exit =
information like that. It makes the code hard to follow.

> +		return;
> +	}
> +
> +	mas3 =3D mfspr(SPRN_MAS3);
> +	pr =3D vcpu->arch.shared->msr & MSR_PR;
> +	if ((pr && (!(mas3 & MAS3_UX))) || ((!pr) && (!(mas3 & =
MAS3_SX)))) {
> +	 	/*
> +		 * Another thread may rewrite the TLB entry in parallel, =
don't
> +		 * execute from the address if the execute permission is =
not set

Isn't this racy?

> +		 */
> +		vcpu->arch.fault_esr =3D 0;
> +		*exit_nr =3D BOOKE_INTERRUPT_INST_STORAGE;
> +		return;
> +	}
> +
> +	/* Get page size */
> +	if (MAS0_GET_TLBSEL(mfspr(SPRN_MAS0)) =3D=3D 0)
> +		psize_shift =3D PAGE_SHIFT;
> +	else
> +		psize_shift =3D MAS1_GET_TSIZE(mas1) + 10;
> +
> +	mas7_mas3 =3D (((u64) mfspr(SPRN_MAS7)) << 32) |
> +		    mfspr(SPRN_MAS3);

You're non-atomically reading MAS3/MAS7 after you've checked for =
permissions on MAS3. I'm surprised there's no handler that allows MAS3/7 =
access through the new, combined SPR for 64bit systems.

> +	addr =3D (mas7_mas3 & (~0ULL << psize_shift)) |
> +	       (geaddr & ((1ULL << psize_shift) - 1ULL));
> +
> +	/* Map a page and get guest's instruction */
> +	page =3D pfn_to_page(addr >> PAGE_SHIFT);

So it seems to me like you're jumping through a lot of hoops to make =
sure this works for LRAT and non-LRAT at the same time. Can't we just =
treat them as the different things they are?

What if we have different MMU backends for LRAT and non-LRAT? The =
non-LRAT case could then try lwepx, if that fails, fall back to read the =
shadow TLB. For the LRAT case, we'd do lwepx, if that fails fall back to =
this logic.


Alex

> +	eaddr =3D (unsigned long)kmap_atomic(page);
> +	eaddr |=3D addr & ~PAGE_MASK;
> +	vcpu->arch.last_inst =3D *(u32 *)eaddr;
> +	kunmap_atomic((u32 *)eaddr);
> +}
> +
> struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int =
id)
> {
> 	struct kvmppc_vcpu_e500 *vcpu_e500;
> --=20
> 1.7.4.1
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
