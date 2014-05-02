Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E09CB140132
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 May 2014 19:55:01 +1000 (EST)
Message-ID: <53636B71.2020103@suse.de>
Date: Fri, 02 May 2014 11:54:57 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Mihai Caraman <mihai.caraman@freescale.com>
Subject: Re: [PATCH v2 3/4] KVM: PPC: Alow kvmppc_get_last_inst() to fail
References: <1398905152-18091-1-git-send-email-mihai.caraman@freescale.com>
 <1398905152-18091-4-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1398905152-18091-4-git-send-email-mihai.caraman@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/01/2014 02:45 AM, Mihai Caraman wrote:
> On book3e, guest last instruction was read on the exist path using load
> external pid (lwepx) dedicated instruction. lwepx failures have to be
> handled by KVM and this would require additional checks in DO_KVM hooks
> (beside MSR[GS] = 1). However extra checks on host fast path are commonly
> considered too intrusive.
>
> This patch lay down the path for an altenative solution, by allowing
> kvmppc_get_lat_inst() function to fail. Booke architectures may choose
> to read guest instruction from kvmppc_ld_inst() and to instruct the
> emulation layer either to fail or to emulate again.
>
> emulation_result enum defintion is not accesible from book3 asm headers.
> Move kvmppc_get_last_inst() definitions that require emulation_result
> to source files.
>
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
> v2:
>   - integrated kvmppc_get_last_inst() in book3s code and checked build
>   - addressed cosmetic feedback
>   - please validate book3s functionality!
>
>   arch/powerpc/include/asm/kvm_book3s.h    | 26 --------------------
>   arch/powerpc/include/asm/kvm_booke.h     |  5 ----
>   arch/powerpc/include/asm/kvm_ppc.h       |  2 ++
>   arch/powerpc/kvm/book3s.c                | 32 ++++++++++++++++++++++++
>   arch/powerpc/kvm/book3s.h                |  1 +
>   arch/powerpc/kvm/book3s_64_mmu_hv.c      | 16 +++---------
>   arch/powerpc/kvm/book3s_paired_singles.c | 42 ++++++++++++++++++++------------
>   arch/powerpc/kvm/book3s_pr.c             | 36 +++++++++++++++++----------
>   arch/powerpc/kvm/booke.c                 | 14 +++++++++++
>   arch/powerpc/kvm/booke.h                 |  3 +++
>   arch/powerpc/kvm/e500_mmu_host.c         |  7 ++++++
>   arch/powerpc/kvm/emulate.c               | 18 +++++++++-----
>   arch/powerpc/kvm/powerpc.c               | 10 ++++++--
>   13 files changed, 132 insertions(+), 80 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
> index bb1e38a..e2a89f3 100644
> --- a/arch/powerpc/include/asm/kvm_book3s.h
> +++ b/arch/powerpc/include/asm/kvm_book3s.h
> @@ -273,32 +273,6 @@ static inline bool kvmppc_need_byteswap(struct kvm_vcpu *vcpu)
>   	return (vcpu->arch.shared->msr & MSR_LE) != (MSR_KERNEL & MSR_LE);
>   }
>   
> -static inline u32 kvmppc_get_last_inst_internal(struct kvm_vcpu *vcpu, ulong pc)
> -{
> -	/* Load the instruction manually if it failed to do so in the
> -	 * exit path */
> -	if (vcpu->arch.last_inst == KVM_INST_FETCH_FAILED)
> -		kvmppc_ld(vcpu, &pc, sizeof(u32), &vcpu->arch.last_inst, false);
> -
> -	return kvmppc_need_byteswap(vcpu) ? swab32(vcpu->arch.last_inst) :
> -		vcpu->arch.last_inst;
> -}
> -
> -static inline u32 kvmppc_get_last_inst(struct kvm_vcpu *vcpu)
> -{
> -	return kvmppc_get_last_inst_internal(vcpu, kvmppc_get_pc(vcpu));
> -}
> -
> -/*
> - * Like kvmppc_get_last_inst(), but for fetching a sc instruction.
> - * Because the sc instruction sets SRR0 to point to the following
> - * instruction, we have to fetch from pc - 4.
> - */
> -static inline u32 kvmppc_get_last_sc(struct kvm_vcpu *vcpu)
> -{
> -	return kvmppc_get_last_inst_internal(vcpu, kvmppc_get_pc(vcpu) - 4);
> -}
> -
>   static inline ulong kvmppc_get_fault_dar(struct kvm_vcpu *vcpu)
>   {
>   	return vcpu->arch.fault_dar;
> diff --git a/arch/powerpc/include/asm/kvm_booke.h b/arch/powerpc/include/asm/kvm_booke.h
> index 80d46b5..6db1ca0 100644
> --- a/arch/powerpc/include/asm/kvm_booke.h
> +++ b/arch/powerpc/include/asm/kvm_booke.h
> @@ -69,11 +69,6 @@ static inline bool kvmppc_need_byteswap(struct kvm_vcpu *vcpu)
>   	return false;
>   }
>   
> -static inline u32 kvmppc_get_last_inst(struct kvm_vcpu *vcpu)
> -{
> -	return vcpu->arch.last_inst;
> -}
> -
>   static inline void kvmppc_set_ctr(struct kvm_vcpu *vcpu, ulong val)
>   {
>   	vcpu->arch.ctr = val;
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
> index 4096f16..6e7c358 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -72,6 +72,8 @@ extern int kvmppc_sanity_check(struct kvm_vcpu *vcpu);
>   extern int kvmppc_subarch_vcpu_init(struct kvm_vcpu *vcpu);
>   extern void kvmppc_subarch_vcpu_uninit(struct kvm_vcpu *vcpu);
>   
> +extern int kvmppc_get_last_inst(struct kvm_vcpu *vcpu, u32 *inst);

Phew. Moving this into a separate function sure has some performance 
implications. Was there no way to keep it in a header?

You could just move it into its own .h file which we include after 
kvm_ppc.h. That way everything's available. That would also help me a 
lot with the little endian port where I'm also struggling with header 
file inclusion order and kvmppc_need_byteswap().

> +
>   /* Core-specific hooks */
>   
>   extern void kvmppc_mmu_map(struct kvm_vcpu *vcpu, u64 gvaddr, gpa_t gpaddr,
> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
> index 94e597e..3553735 100644
> --- a/arch/powerpc/kvm/book3s.c
> +++ b/arch/powerpc/kvm/book3s.c
> @@ -463,6 +463,38 @@ mmio:
>   }
>   EXPORT_SYMBOL_GPL(kvmppc_ld);
>   
> +int kvmppc_get_last_inst_internal(struct kvm_vcpu *vcpu, ulong pc, u32 *inst)
> +{
> +	int ret = EMULATE_DONE;
> +
> +	/* Load the instruction manually if it failed to do so in the
> +	 * exit path */
> +	if (vcpu->arch.last_inst == KVM_INST_FETCH_FAILED)
> +		ret = kvmppc_ld(vcpu, &pc, sizeof(u32), &vcpu->arch.last_inst,
> +			false);
> +
> +	*inst = kvmppc_need_byteswap(vcpu) ? swab32(vcpu->arch.last_inst) :
> +		vcpu->arch.last_inst;
> +
> +	return ret;
> +}
> +
> +int kvmppc_get_last_inst(struct kvm_vcpu *vcpu, u32 *inst)
> +{
> +	return kvmppc_get_last_inst_internal(vcpu, kvmppc_get_pc(vcpu), inst);
> +}
> +
> +/*
> + * Like kvmppc_get_last_inst(), but for fetching a sc instruction.
> + * Because the sc instruction sets SRR0 to point to the following
> + * instruction, we have to fetch from pc - 4.
> + */
> +int kvmppc_get_last_sc(struct kvm_vcpu *vcpu, u32 *inst)
> +{
> +	return kvmppc_get_last_inst_internal(vcpu, kvmppc_get_pc(vcpu) - 4,
> +		inst);
> +}
> +
>   int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
>   {
>   	return 0;
> diff --git a/arch/powerpc/kvm/book3s.h b/arch/powerpc/kvm/book3s.h
> index 4bf956c..d85839d 100644
> --- a/arch/powerpc/kvm/book3s.h
> +++ b/arch/powerpc/kvm/book3s.h
> @@ -30,5 +30,6 @@ extern int kvmppc_core_emulate_mfspr_pr(struct kvm_vcpu *vcpu,
>   					int sprn, ulong *spr_val);
>   extern int kvmppc_book3s_init_pr(void);
>   extern void kvmppc_book3s_exit_pr(void);
> +extern int kvmppc_get_last_sc(struct kvm_vcpu *vcpu, u32 *inst);
>   
>   #endif
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> index fb25ebc..7ffcc24 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> @@ -541,21 +541,13 @@ static int instruction_is_store(unsigned int instr)
>   static int kvmppc_hv_emulate_mmio(struct kvm_run *run, struct kvm_vcpu *vcpu,
>   				  unsigned long gpa, gva_t ea, int is_store)
>   {
> -	int ret;
>   	u32 last_inst;
> -	unsigned long srr0 = kvmppc_get_pc(vcpu);
>   
> -	/* We try to load the last instruction.  We don't let
> -	 * emulate_instruction do it as it doesn't check what
> -	 * kvmppc_ld returns.
> +	/*
>   	 * If we fail, we just return to the guest and try executing it again.
>   	 */
> -	if (vcpu->arch.last_inst == KVM_INST_FETCH_FAILED) {
> -		ret = kvmppc_ld(vcpu, &srr0, sizeof(u32), &last_inst, false);
> -		if (ret != EMULATE_DONE || last_inst == KVM_INST_FETCH_FAILED)
> -			return RESUME_GUEST;
> -		vcpu->arch.last_inst = last_inst;
> -	}
> +	if (kvmppc_get_last_inst(vcpu, &last_inst) != EMULATE_DONE)
> +		return RESUME_GUEST;
>   
>   	/*
>   	 * WARNING: We do not know for sure whether the instruction we just
> @@ -569,7 +561,7 @@ static int kvmppc_hv_emulate_mmio(struct kvm_run *run, struct kvm_vcpu *vcpu,
>   	 * we just return and retry the instruction.
>   	 */
>   
> -	if (instruction_is_store(kvmppc_get_last_inst(vcpu)) != !!is_store)
> +	if (instruction_is_store(last_inst) != !!is_store)
>   		return RESUME_GUEST;
>   
>   	/*
> diff --git a/arch/powerpc/kvm/book3s_paired_singles.c b/arch/powerpc/kvm/book3s_paired_singles.c
> index c1abd95..9a6e565 100644
> --- a/arch/powerpc/kvm/book3s_paired_singles.c
> +++ b/arch/powerpc/kvm/book3s_paired_singles.c
> @@ -637,26 +637,36 @@ static int kvmppc_ps_one_in(struct kvm_vcpu *vcpu, bool rc,
>   
>   int kvmppc_emulate_paired_single(struct kvm_run *run, struct kvm_vcpu *vcpu)
>   {
> -	u32 inst = kvmppc_get_last_inst(vcpu);
> -	enum emulation_result emulated = EMULATE_DONE;
> -
> -	int ax_rd = inst_get_field(inst, 6, 10);
> -	int ax_ra = inst_get_field(inst, 11, 15);
> -	int ax_rb = inst_get_field(inst, 16, 20);
> -	int ax_rc = inst_get_field(inst, 21, 25);
> -	short full_d = inst_get_field(inst, 16, 31);
> -
> -	u64 *fpr_d = &VCPU_FPR(vcpu, ax_rd);
> -	u64 *fpr_a = &VCPU_FPR(vcpu, ax_ra);
> -	u64 *fpr_b = &VCPU_FPR(vcpu, ax_rb);
> -	u64 *fpr_c = &VCPU_FPR(vcpu, ax_rc);
> -
> -	bool rcomp = (inst & 1) ? true : false;
> -	u32 cr = kvmppc_get_cr(vcpu);
> +	u32 inst;
> +	enum emulation_result emulated;
> +	int ax_rd, ax_ra, ax_rb, ax_rc;
> +	short full_d;
> +	u64 *fpr_d, *fpr_a, *fpr_b, *fpr_c;
> +
> +	bool rcomp;
> +	u32 cr;
>   #ifdef DEBUG
>   	int i;
>   #endif
>   
> +	emulated = kvmppc_get_last_inst(vcpu, &inst);
> +	if (emulated != EMULATE_DONE)
> +		return emulated;
> +
> +	ax_rd = inst_get_field(inst, 6, 10);
> +	ax_ra = inst_get_field(inst, 11, 15);
> +	ax_rb = inst_get_field(inst, 16, 20);
> +	ax_rc = inst_get_field(inst, 21, 25);
> +	full_d = inst_get_field(inst, 16, 31);
> +
> +	fpr_d = &VCPU_FPR(vcpu, ax_rd);
> +	fpr_a = &VCPU_FPR(vcpu, ax_ra);
> +	fpr_b = &VCPU_FPR(vcpu, ax_rb);
> +	fpr_c = &VCPU_FPR(vcpu, ax_rc);
> +
> +	rcomp = (inst & 1) ? true : false;
> +	cr = kvmppc_get_cr(vcpu);
> +
>   	if (!kvmppc_inst_is_paired_single(vcpu, inst))
>   		return EMULATE_FAIL;
>   
> diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
> index c5c052a..b7fffd1 100644
> --- a/arch/powerpc/kvm/book3s_pr.c
> +++ b/arch/powerpc/kvm/book3s_pr.c
> @@ -608,12 +608,9 @@ void kvmppc_giveup_ext(struct kvm_vcpu *vcpu, ulong msr)
>   
>   static int kvmppc_read_inst(struct kvm_vcpu *vcpu)
>   {
> -	ulong srr0 = kvmppc_get_pc(vcpu);
> -	u32 last_inst = kvmppc_get_last_inst(vcpu);
> -	int ret;
> +	u32 last_inst;
>   
> -	ret = kvmppc_ld(vcpu, &srr0, sizeof(u32), &last_inst, false);
> -	if (ret == -ENOENT) {
> +	if (kvmppc_get_last_inst(vcpu, &last_inst) == -ENOENT) {

ENOENT?

>   		ulong msr = vcpu->arch.shared->msr;
>   
>   		msr = kvmppc_set_field(msr, 33, 33, 1);
> @@ -867,15 +864,18 @@ int kvmppc_handle_exit_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
>   	{
>   		enum emulation_result er;
>   		ulong flags;
> +		u32 last_inst;
>   
>   program_interrupt:
>   		flags = vcpu->arch.shadow_srr1 & 0x1f0000ull;
> +		kvmppc_get_last_inst(vcpu, &last_inst);

No check for the return value?

>   
>   		if (vcpu->arch.shared->msr & MSR_PR) {
>   #ifdef EXIT_DEBUG
> -			printk(KERN_INFO "Userspace triggered 0x700 exception at 0x%lx (0x%x)\n", kvmppc_get_pc(vcpu), kvmppc_get_last_inst(vcpu));
> +			pr_info("Userspace triggered 0x700 exception at\n"
> +			    "0x%lx (0x%x)\n", kvmppc_get_pc(vcpu), last_inst);
>   #endif
> -			if ((kvmppc_get_last_inst(vcpu) & 0xff0007ff) !=
> +			if ((last_inst & 0xff0007ff) !=
>   			    (INS_DCBZ & 0xfffffff7)) {
>   				kvmppc_core_queue_program(vcpu, flags);
>   				r = RESUME_GUEST;
> @@ -894,7 +894,7 @@ program_interrupt:
>   			break;
>   		case EMULATE_FAIL:
>   			printk(KERN_CRIT "%s: emulation at %lx failed (%08x)\n",
> -			       __func__, kvmppc_get_pc(vcpu), kvmppc_get_last_inst(vcpu));
> +			       __func__, kvmppc_get_pc(vcpu), last_inst);
>   			kvmppc_core_queue_program(vcpu, flags);
>   			r = RESUME_GUEST;
>   			break;
> @@ -911,8 +911,12 @@ program_interrupt:
>   		break;
>   	}
>   	case BOOK3S_INTERRUPT_SYSCALL:
> +	{
> +		u32 last_sc;
> +
> +		kvmppc_get_last_sc(vcpu, &last_sc);

No check for the return value?

>   		if (vcpu->arch.papr_enabled &&
> -		    (kvmppc_get_last_sc(vcpu) == 0x44000022) &&
> +		    (last_sc == 0x44000022) &&
>   		    !(vcpu->arch.shared->msr & MSR_PR)) {
>   			/* SC 1 papr hypercalls */
>   			ulong cmd = kvmppc_get_gpr(vcpu, 3);
> @@ -957,6 +961,7 @@ program_interrupt:
>   			r = RESUME_GUEST;
>   		}
>   		break;
> +	}
>   	case BOOK3S_INTERRUPT_FP_UNAVAIL:
>   	case BOOK3S_INTERRUPT_ALTIVEC:
>   	case BOOK3S_INTERRUPT_VSX:
> @@ -985,15 +990,20 @@ program_interrupt:
>   		break;
>   	}
>   	case BOOK3S_INTERRUPT_ALIGNMENT:
> +	{
> +		u32 last_inst;
> +
>   		if (kvmppc_read_inst(vcpu) == EMULATE_DONE) {
> -			vcpu->arch.shared->dsisr = kvmppc_alignment_dsisr(vcpu,
> -				kvmppc_get_last_inst(vcpu));
> -			vcpu->arch.shared->dar = kvmppc_alignment_dar(vcpu,
> -				kvmppc_get_last_inst(vcpu));
> +			kvmppc_get_last_inst(vcpu, &last_inst);

I think with an error returning kvmppc_get_last_inst we can just use 
completely get rid of kvmppc_read_inst() and only use 
kvmppc_get_last_inst() instead.

> +			vcpu->arch.shared->dsisr =
> +				kvmppc_alignment_dsisr(vcpu, last_inst);
> +			vcpu->arch.shared->dar =
> +				kvmppc_alignment_dar(vcpu, last_inst);
>   			kvmppc_book3s_queue_irqprio(vcpu, exit_nr);
>   		}
>   		r = RESUME_GUEST;
>   		break;
> +	}
>   	case BOOK3S_INTERRUPT_MACHINE_CHECK:
>   	case BOOK3S_INTERRUPT_TRACE:
>   		kvmppc_book3s_queue_irqprio(vcpu, exit_nr);
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index ab62109..df25db0 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -752,6 +752,9 @@ static int emulation_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
>   		 * they were actually modified by emulation. */
>   		return RESUME_GUEST_NV;
>   
> +	case EMULATE_AGAIN:
> +		return RESUME_GUEST;
> +
>   	case EMULATE_DO_DCR:
>   		run->exit_reason = KVM_EXIT_DCR;
>   		return RESUME_HOST;
> @@ -1911,6 +1914,17 @@ void kvmppc_core_vcpu_put(struct kvm_vcpu *vcpu)
>   	vcpu->kvm->arch.kvm_ops->vcpu_put(vcpu);
>   }
>   
> +int kvmppc_get_last_inst(struct kvm_vcpu *vcpu, u32 *inst)
> +{
> +	int result = EMULATE_DONE;
> +
> +	if (vcpu->arch.last_inst == KVM_INST_FETCH_FAILED)
> +		result = kvmppc_ld_inst(vcpu, &vcpu->arch.last_inst);
> +	*inst = vcpu->arch.last_inst;

This function looks almost identical to the book3s one. Can we share the 
same code path here? Just always return false for 
kvmppc_needs_byteswap() on booke.


Alex
