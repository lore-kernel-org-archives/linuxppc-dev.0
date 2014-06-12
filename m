Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DE6291A040B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jun 2014 01:15:48 +1000 (EST)
Message-ID: <5399C41F.8010108@suse.de>
Date: Thu, 12 Jun 2014 17:15:43 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Mihai Caraman <mihai.caraman@freescale.com>
Subject: Re: [PATCH 3/4 v3] KVM: PPC: Alow kvmppc_get_last_inst() to fail
References: <1401724216-26486-1-git-send-email-mihai.caraman@freescale.com>
 <1401724216-26486-4-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1401724216-26486-4-git-send-email-mihai.caraman@freescale.com>
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

On 06/02/2014 05:50 PM, Mihai Caraman wrote:
> On book3e, guest last instruction is read on the exit path using load
> external pid (lwepx) dedicated instruction. This load operation may fail
> due to TLB eviction and execute-but-not-read entries.
>
> This patch lay down the path for an alternative solution to read the guest
> last instruction, by allowing kvmppc_get_lat_inst() function to fail.
> Architecture specific implmentations of kvmppc_load_last_inst() may read
> last guest instruction and instruct the emulation layer to re-execute the
> guest in case of failure.
>
> Make kvmppc_get_last_inst() definition common between architectures.
>
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
> v3:
>   - these changes compile on book3s, please validate the functionality and
>     do the necessary adaptations!
>   - rework patch description
>   - add common definition for kvmppc_get_last_inst()
>   - check return values in book3s code
>
> v2:
>   - integrated kvmppc_get_last_inst() in book3s code and checked build
>   - addressed cosmetic feedback
>
>   arch/powerpc/include/asm/kvm_book3s.h    |  28 ++------
>   arch/powerpc/include/asm/kvm_booke.h     |   7 +-
>   arch/powerpc/include/asm/kvm_ppc.h       |  16 +++++
>   arch/powerpc/kvm/book3s_64_mmu_hv.c      |  16 ++---
>   arch/powerpc/kvm/book3s_paired_singles.c |  38 ++++++----
>   arch/powerpc/kvm/book3s_pr.c             | 116 +++++++++++++++++--------------
>   arch/powerpc/kvm/booke.c                 |   3 +
>   arch/powerpc/kvm/e500_mmu_host.c         |   5 ++
>   arch/powerpc/kvm/emulate.c               |  18 +++--
>   arch/powerpc/kvm/powerpc.c               |  10 ++-
>   10 files changed, 142 insertions(+), 115 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
> index f52f656..3409572 100644
> --- a/arch/powerpc/include/asm/kvm_book3s.h
> +++ b/arch/powerpc/include/asm/kvm_book3s.h
> @@ -274,30 +274,14 @@ static inline bool kvmppc_need_byteswap(struct kvm_vcpu *vcpu)
>   	return (kvmppc_get_msr(vcpu) & MSR_LE) != (MSR_KERNEL & MSR_LE);
>   }
>   
> -static inline u32 kvmppc_get_last_inst_internal(struct kvm_vcpu *vcpu, ulong pc)
> +static inline int kvmppc_load_last_inst(struct kvm_vcpu *vcpu, bool prev,

Please make prev an enum :)

> +					 u32 *inst)
>   {
> -	/* Load the instruction manually if it failed to do so in the
> -	 * exit path */
> -	if (vcpu->arch.last_inst == KVM_INST_FETCH_FAILED)
> -		kvmppc_ld(vcpu, &pc, sizeof(u32), &vcpu->arch.last_inst, false);
> +	ulong pc = kvmppc_get_pc(vcpu);
>   
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
> +	if (prev)
> +		pc -= 4;
> +	return kvmppc_ld(vcpu, &pc, sizeof(u32), &vcpu->arch.last_inst, false);
>   }

In this case we're already in the slow path. Can we move this into a .c 
file instead? That would unify it with booke and ...

>   
>   static inline ulong kvmppc_get_fault_dar(struct kvm_vcpu *vcpu)
> diff --git a/arch/powerpc/include/asm/kvm_booke.h b/arch/powerpc/include/asm/kvm_booke.h
> index c7aed61..1e28371 100644
> --- a/arch/powerpc/include/asm/kvm_booke.h
> +++ b/arch/powerpc/include/asm/kvm_booke.h
> @@ -33,6 +33,8 @@
>   #define KVMPPC_INST_EHPRIV_DEBUG	(KVMPPC_INST_EHPRIV | \
>   					 (EHPRIV_OC_DEBUG << EHPRIV_OC_SHIFT))
>   
> +extern int kvmppc_load_last_inst(struct kvm_vcpu *vcpu, bool prev, u32 *inst);

... allow us to move this to a common header file :).

> +
>   static inline void kvmppc_set_gpr(struct kvm_vcpu *vcpu, int num, ulong val)
>   {
>   	vcpu->arch.gpr[num] = val;
> @@ -69,11 +71,6 @@ static inline bool kvmppc_need_byteswap(struct kvm_vcpu *vcpu)
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
> index 4a7cc45..619be2f 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -234,6 +234,22 @@ struct kvmppc_ops {
>   extern struct kvmppc_ops *kvmppc_hv_ops;
>   extern struct kvmppc_ops *kvmppc_pr_ops;
>   
> +static inline int kvmppc_get_last_inst(struct kvm_vcpu *vcpu, bool prev,
> +					u32 *inst)
> +{
> +	int ret = EMULATE_DONE;
> +
> +	/* Load the instruction manually if it failed to do so in the
> +	 * exit path */
> +	if (vcpu->arch.last_inst == KVM_INST_FETCH_FAILED)
> +		ret = kvmppc_load_last_inst(vcpu, prev, &vcpu->arch.last_inst);
> +
> +	*inst = kvmppc_need_byteswap(vcpu) ? swab32(vcpu->arch.last_inst) :
> +		vcpu->arch.last_inst;
> +
> +	return ret;
> +}
> +
>   static inline bool is_kvmppc_hv_enabled(struct kvm *kvm)
>   {
>   	return kvm->arch.kvm_ops == kvmppc_hv_ops;
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> index 8056107..2ffb3dd 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> @@ -530,21 +530,13 @@ static int instruction_is_store(unsigned int instr)
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
> +	if (kvmppc_get_last_inst(vcpu, false, &last_inst) != EMULATE_DONE)
> +		return RESUME_GUEST;
>   
>   	/*
>   	 * WARNING: We do not know for sure whether the instruction we just
> @@ -558,7 +550,7 @@ static int kvmppc_hv_emulate_mmio(struct kvm_run *run, struct kvm_vcpu *vcpu,
>   	 * we just return and retry the instruction.
>   	 */
>   
> -	if (instruction_is_store(kvmppc_get_last_inst(vcpu)) != !!is_store)
> +	if (instruction_is_store(last_inst) != !!is_store)
>   		return RESUME_GUEST;
>   
>   	/*
> diff --git a/arch/powerpc/kvm/book3s_paired_singles.c b/arch/powerpc/kvm/book3s_paired_singles.c
> index 6c8011f..6362ad4 100644
> --- a/arch/powerpc/kvm/book3s_paired_singles.c
> +++ b/arch/powerpc/kvm/book3s_paired_singles.c
> @@ -639,26 +639,36 @@ static int kvmppc_ps_one_in(struct kvm_vcpu *vcpu, bool rc,
>   
>   int kvmppc_emulate_paired_single(struct kvm_run *run, struct kvm_vcpu *vcpu)
>   {
> -	u32 inst = kvmppc_get_last_inst(vcpu);
> +	u32 inst;
>   	enum emulation_result emulated = EMULATE_DONE;
> +	int ax_rd, ax_ra, ax_rb, ax_rc;
> +	short full_d;
> +	u64 *fpr_d, *fpr_a, *fpr_b, *fpr_c;
>   
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
> +	bool rcomp;
> +	u32 cr;
>   #ifdef DEBUG
>   	int i;
>   #endif
>   
> +	emulated = kvmppc_get_last_inst(vcpu, false, &inst);
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
> index 23367a7..48b633c 100644
> --- a/arch/powerpc/kvm/book3s_pr.c
> +++ b/arch/powerpc/kvm/book3s_pr.c
> @@ -637,42 +637,6 @@ static void kvmppc_giveup_fac(struct kvm_vcpu *vcpu, ulong fac)
>   #endif
>   }
>   
> -static int kvmppc_read_inst(struct kvm_vcpu *vcpu)
> -{
> -	ulong srr0 = kvmppc_get_pc(vcpu);
> -	u32 last_inst = kvmppc_get_last_inst(vcpu);
> -	int ret;
> -
> -	ret = kvmppc_ld(vcpu, &srr0, sizeof(u32), &last_inst, false);
> -	if (ret == -ENOENT) {
> -		ulong msr = kvmppc_get_msr(vcpu);
> -
> -		msr = kvmppc_set_field(msr, 33, 33, 1);
> -		msr = kvmppc_set_field(msr, 34, 36, 0);
> -		msr = kvmppc_set_field(msr, 42, 47, 0);
> -		kvmppc_set_msr_fast(vcpu, msr);
> -		kvmppc_book3s_queue_irqprio(vcpu, BOOK3S_INTERRUPT_INST_STORAGE);
> -		return EMULATE_AGAIN;
> -	}
> -
> -	return EMULATE_DONE;
> -}
> -
> -static int kvmppc_check_ext(struct kvm_vcpu *vcpu, unsigned int exit_nr)
> -{
> -
> -	/* Need to do paired single emulation? */
> -	if (!(vcpu->arch.hflags & BOOK3S_HFLAG_PAIRED_SINGLE))
> -		return EMULATE_DONE;
> -
> -	/* Read out the instruction */
> -	if (kvmppc_read_inst(vcpu) == EMULATE_DONE)
> -		/* Need to emulate */
> -		return EMULATE_FAIL;
> -
> -	return EMULATE_AGAIN;
> -}
> -
>   /* Handle external providers (FPU, Altivec, VSX) */
>   static int kvmppc_handle_ext(struct kvm_vcpu *vcpu, unsigned int exit_nr,
>   			     ulong msr)
> @@ -977,15 +941,24 @@ int kvmppc_handle_exit_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
>   	{
>   		enum emulation_result er;
>   		ulong flags;
> +		u32 last_inst;
> +		int emul;
>   
>   program_interrupt:
>   		flags = vcpu->arch.shadow_srr1 & 0x1f0000ull;
>   
> +		emul = kvmppc_get_last_inst(vcpu, false, &last_inst);
> +		if (emul != EMULATE_DONE) {
> +			r = RESUME_GUEST;
> +			break;
> +		}
> +
>   		if (kvmppc_get_msr(vcpu) & MSR_PR) {
>   #ifdef EXIT_DEBUG
> -			printk(KERN_INFO "Userspace triggered 0x700 exception at 0x%lx (0x%x)\n", kvmppc_get_pc(vcpu), kvmppc_get_last_inst(vcpu));
> +			pr_info("Userspace triggered 0x700 exception at\n"

I don't think we want the \n here :).

> +			    "0x%lx (0x%x)\n", kvmppc_get_pc(vcpu), last_inst);
>   #endif
> -			if ((kvmppc_get_last_inst(vcpu) & 0xff0007ff) !=
> +			if ((last_inst & 0xff0007ff) !=
>   			    (INS_DCBZ & 0xfffffff7)) {
>   				kvmppc_core_queue_program(vcpu, flags);
>   				r = RESUME_GUEST;
> @@ -1004,7 +977,7 @@ program_interrupt:
>   			break;
>   		case EMULATE_FAIL:
>   			printk(KERN_CRIT "%s: emulation at %lx failed (%08x)\n",
> -			       __func__, kvmppc_get_pc(vcpu), kvmppc_get_last_inst(vcpu));
> +			       __func__, kvmppc_get_pc(vcpu), last_inst);
>   			kvmppc_core_queue_program(vcpu, flags);
>   			r = RESUME_GUEST;
>   			break;
> @@ -1021,8 +994,25 @@ program_interrupt:
>   		break;
>   	}
>   	case BOOK3S_INTERRUPT_SYSCALL:
> +	{
> +		u32 last_sc;
> +		int emul;
> +
> +		/* Get last sc for papr */
> +		if (vcpu->arch.papr_enabled) {
> +			/*
> +			 * The sc instuction sets SRR0 to point to the next inst
> +			 */
> +			emul = kvmppc_get_last_inst(vcpu, true, &last_sc);
> +			if (emul != EMULATE_DONE) {
> +				kvmppc_set_pc(vcpu, kvmppc_get_pc(vcpu) - 4);
> +				r = RESUME_GUEST;
> +				break;
> +			}
> +		}
> +
>   		if (vcpu->arch.papr_enabled &&
> -		    (kvmppc_get_last_sc(vcpu) == 0x44000022) &&
> +		    (last_sc == 0x44000022) &&
>   		    !(kvmppc_get_msr(vcpu) & MSR_PR)) {
>   			/* SC 1 papr hypercalls */
>   			ulong cmd = kvmppc_get_gpr(vcpu, 3);
> @@ -1067,36 +1057,53 @@ program_interrupt:
>   			r = RESUME_GUEST;
>   		}
>   		break;
> +	}
>   	case BOOK3S_INTERRUPT_FP_UNAVAIL:
>   	case BOOK3S_INTERRUPT_ALTIVEC:
>   	case BOOK3S_INTERRUPT_VSX:
>   	{
>   		int ext_msr = 0;
> +		int emul;
> +		u32 last_inst;
>   
> -		switch (exit_nr) {
> -		case BOOK3S_INTERRUPT_FP_UNAVAIL: ext_msr = MSR_FP;  break;
> -		case BOOK3S_INTERRUPT_ALTIVEC:    ext_msr = MSR_VEC; break;
> -		case BOOK3S_INTERRUPT_VSX:        ext_msr = MSR_VSX; break;
> -		}
> +		if (!(vcpu->arch.hflags & BOOK3S_HFLAG_PAIRED_SINGLE)) {
> +			/* Do paired single emulation */
> +
> +			switch (exit_nr) {
> +			case BOOK3S_INTERRUPT_FP_UNAVAIL:
> +				ext_msr = MSR_FP;
> +				break;
> +
> +			case BOOK3S_INTERRUPT_ALTIVEC:
> +				ext_msr = MSR_VEC;
> +				break;
> +
> +			case BOOK3S_INTERRUPT_VSX:
> +				ext_msr = MSR_VSX;
> +				break;
> +			}
>   
> -		switch (kvmppc_check_ext(vcpu, exit_nr)) {
> -		case EMULATE_DONE:
> -			/* everything ok - let's enable the ext */
>   			r = kvmppc_handle_ext(vcpu, exit_nr, ext_msr);
>   			break;
> -		case EMULATE_FAIL:
> +		}
> +
> +		emul = kvmppc_get_last_inst(vcpu, false, &last_inst);
> +		if (emul == EMULATE_DONE) {
>   			/* we need to emulate this instruction */
>   			goto program_interrupt;
>   			break;
> -		default:
> -			/* nothing to worry about - go again */
> -			break;
> +		} else {
> +			r = RESUME_GUEST;
>   		}
> +
>   		break;
>   	}
>   	case BOOK3S_INTERRUPT_ALIGNMENT:
> -		if (kvmppc_read_inst(vcpu) == EMULATE_DONE) {

Phew - this removes the ability to inject an instruction page fault on 
this path. It's probably ok to do so, but please eliminate 
kvmppc_read_inst() in a separate patch before this one so we can later 
bisect it more easily when it fails.


Alex

> -			u32 last_inst = kvmppc_get_last_inst(vcpu);
> +	{
> +		u32 last_inst;
> +		int emul = kvmppc_get_last_inst(vcpu, false, &last_inst);
> +
> +		if (emul == EMULATE_DONE) {
>   			u32 dsisr;
>   			u64 dar;
>   
> @@ -1110,6 +1117,7 @@ program_interrupt:
>   		}
>   		r = RESUME_GUEST;
>   		break;
> +	}
>   #ifdef CONFIG_PPC_BOOK3S_64
>   	case BOOK3S_INTERRUPT_FAC_UNAVAIL:
>   		kvmppc_handle_fac(vcpu, vcpu->arch.shadow_fscr >> 56);
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index ab62109..34a42b9 100644
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
> diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
> index dd2cc03..f692c12 100644
> --- a/arch/powerpc/kvm/e500_mmu_host.c
> +++ b/arch/powerpc/kvm/e500_mmu_host.c
> @@ -606,6 +606,11 @@ void kvmppc_mmu_map(struct kvm_vcpu *vcpu, u64 eaddr, gpa_t gpaddr,
>   	}
>   }
>   
> +int kvmppc_load_last_inst(struct kvm_vcpu *vcpu, bool prev, u32 *instr)
> +{
> +	return EMULATE_FAIL;
> +}
> +
>   /************* MMU Notifiers *************/
>   
>   int kvm_unmap_hva(struct kvm *kvm, unsigned long hva)
> diff --git a/arch/powerpc/kvm/emulate.c b/arch/powerpc/kvm/emulate.c
> index da86d9b..c5c64b6 100644
> --- a/arch/powerpc/kvm/emulate.c
> +++ b/arch/powerpc/kvm/emulate.c
> @@ -224,19 +224,25 @@ static int kvmppc_emulate_mfspr(struct kvm_vcpu *vcpu, int sprn, int rt)
>    * from opcode tables in the future. */
>   int kvmppc_emulate_instruction(struct kvm_run *run, struct kvm_vcpu *vcpu)
>   {
> -	u32 inst = kvmppc_get_last_inst(vcpu);
> -	int ra = get_ra(inst);
> -	int rs = get_rs(inst);
> -	int rt = get_rt(inst);
> -	int sprn = get_sprn(inst);
> -	enum emulation_result emulated = EMULATE_DONE;
> +	u32 inst;
> +	int ra, rs, rt, sprn;
> +	enum emulation_result emulated;
>   	int advance = 1;
>   
>   	/* this default type might be overwritten by subcategories */
>   	kvmppc_set_exit_type(vcpu, EMULATED_INST_EXITS);
>   
> +	emulated = kvmppc_get_last_inst(vcpu, false, &inst);
> +	if (emulated != EMULATE_DONE)
> +		return emulated;
> +
>   	pr_debug("Emulating opcode %d / %d\n", get_op(inst), get_xop(inst));
>   
> +	ra = get_ra(inst);
> +	rs = get_rs(inst);
> +	rt = get_rt(inst);
> +	sprn = get_sprn(inst);
> +
>   	switch (get_op(inst)) {
>   	case OP_TRAP:
>   #ifdef CONFIG_PPC_BOOK3S
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index bab20f4..1dba84b 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -261,6 +261,9 @@ int kvmppc_emulate_mmio(struct kvm_run *run, struct kvm_vcpu *vcpu)
>   		 * actually modified. */
>   		r = RESUME_GUEST_NV;
>   		break;
> +	case EMULATE_AGAIN:
> +		r = RESUME_GUEST;
> +		break;
>   	case EMULATE_DO_MMIO:
>   		run->exit_reason = KVM_EXIT_MMIO;
>   		/* We must reload nonvolatiles because "update" load/store
> @@ -270,11 +273,14 @@ int kvmppc_emulate_mmio(struct kvm_run *run, struct kvm_vcpu *vcpu)
>   		r = RESUME_HOST_NV;
>   		break;
>   	case EMULATE_FAIL:
> +	{
> +		u32 last_inst;
> +		kvmppc_get_last_inst(vcpu, false, &last_inst);
>   		/* XXX Deliver Program interrupt to guest. */
> -		printk(KERN_EMERG "%s: emulation failed (%08x)\n", __func__,
> -		       kvmppc_get_last_inst(vcpu));
> +		pr_emerg("%s: emulation failed (%08x)\n", __func__, last_inst);
>   		r = RESUME_HOST;
>   		break;
> +	}
>   	default:
>   		WARN_ON(1);
>   		r = RESUME_GUEST;
