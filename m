Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0141.outbound.protection.outlook.com [207.46.163.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 53C4414009F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Mar 2014 07:52:34 +1100 (EST)
Message-ID: <1395867121.12738.56.camel@snotra.buserror.net>
Subject: Re: [PATCH 3/4] KVM: PPC: Alow kvmppc_get_last_inst() to fail
From: Scott Wood <scottwood@freescale.com>
To: Mihai Caraman <mihai.caraman@freescale.com>
Date: Wed, 26 Mar 2014 15:52:01 -0500
In-Reply-To: <1392913821-4520-3-git-send-email-mihai.caraman@freescale.com>
References: <1392913821-4520-1-git-send-email-mihai.caraman@freescale.com>
 <1392913821-4520-3-git-send-email-mihai.caraman@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-02-20 at 18:30 +0200, Mihai Caraman wrote:
> diff --git a/arch/powerpc/kvm/book3s_paired_singles.c b/arch/powerpc/kvm/book3s_paired_singles.c
> index a59a25a..80c533e 100644
> --- a/arch/powerpc/kvm/book3s_paired_singles.c
> +++ b/arch/powerpc/kvm/book3s_paired_singles.c
> @@ -640,19 +640,24 @@ static int kvmppc_ps_one_in(struct kvm_vcpu *vcpu, bool rc,
>  
>  int kvmppc_emulate_paired_single(struct kvm_run *run, struct kvm_vcpu *vcpu)
>  {
> -	u32 inst = kvmppc_get_last_inst(vcpu);
> +	u32 inst;
>  	enum emulation_result emulated = EMULATE_DONE;
> -
> -	int ax_rd = inst_get_field(inst, 6, 10);
> -	int ax_ra = inst_get_field(inst, 11, 15);
> -	int ax_rb = inst_get_field(inst, 16, 20);
> -	int ax_rc = inst_get_field(inst, 21, 25);
> -	short full_d = inst_get_field(inst, 16, 31);
> -
> -	u64 *fpr_d = &vcpu->arch.fpr[ax_rd];
> -	u64 *fpr_a = &vcpu->arch.fpr[ax_ra];
> -	u64 *fpr_b = &vcpu->arch.fpr[ax_rb];
> -	u64 *fpr_c = &vcpu->arch.fpr[ax_rc];
> +	int ax_rd, ax_ra, ax_rb, ax_rc;
> +	short full_d;
> +	u64 *fpr_d, *fpr_a, *fpr_b, *fpr_c;
> +
> +	kvmppc_get_last_inst(vcpu, &inst);

Should probably check for failure here and elsewhere -- even though it
can't currently fail on book3s, the interface now allows it.

> diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
> index 5b9e906..b0d884d 100644
> --- a/arch/powerpc/kvm/book3s_pr.c
> +++ b/arch/powerpc/kvm/book3s_pr.c
> @@ -624,9 +624,10 @@ void kvmppc_giveup_ext(struct kvm_vcpu *vcpu, ulong msr)
>  static int kvmppc_read_inst(struct kvm_vcpu *vcpu)
>  {
>  	ulong srr0 = kvmppc_get_pc(vcpu);
> -	u32 last_inst = kvmppc_get_last_inst(vcpu);
> +	u32 last_inst;
>  	int ret;
>  
> +	kvmppc_get_last_inst(vcpu, &last_inst);
>  	ret = kvmppc_ld(vcpu, &srr0, sizeof(u32), &last_inst, false);

This isn't new, but this function looks odd to me -- calling
kvmppc_get_last_inst() but ignoring last_inst, then calling kvmppc_ld()
and ignoring anything but failure.  last_inst itself is never read.  And
no comments to explain the weirdness. :-)

I get that kvmppc_get_last_inst() is probably being used for the side
effect of filling in vcpu->arch.last_inst, but why store the return
value without using it?  Why pass the address of it to kvmppc_ld(),
which seems to be used only as an indirect way of determining whether
kvmppc_get_last_inst() failed?  And that whole mechanism becomes
stranger once it becomes possible for kvmppc_get_last_inst() to directly
return failure.

> diff --git a/arch/powerpc/kvm/booke.h b/arch/powerpc/kvm/booke.h
> index 09bfd9b..c7c60c2 100644
> --- a/arch/powerpc/kvm/booke.h
> +++ b/arch/powerpc/kvm/booke.h
> @@ -90,6 +90,9 @@ void kvmppc_vcpu_disable_spe(struct kvm_vcpu *vcpu);
>  void kvmppc_booke_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
>  void kvmppc_booke_vcpu_put(struct kvm_vcpu *vcpu);
>  
> +void kvmppc_core_queue_inst_storage(struct kvm_vcpu *vcpu,
> +                                           ulong esr_flags);

Whitespace

> +
>  enum int_class {
>  	INT_CLASS_NONCRIT,
>  	INT_CLASS_CRIT,
> @@ -123,6 +126,8 @@ extern int kvmppc_core_emulate_mtspr_e500(struct kvm_vcpu *vcpu, int sprn,
>  extern int kvmppc_core_emulate_mfspr_e500(struct kvm_vcpu *vcpu, int sprn,
>  					  ulong *spr_val);
>  
> +extern int kvmppc_ld_inst(struct kvm_vcpu *vcpu, u32 *instr) ;

Whitespace

> diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
> index ecf2247..6025cb7 100644
> --- a/arch/powerpc/kvm/e500_mmu_host.c
> +++ b/arch/powerpc/kvm/e500_mmu_host.c
> @@ -34,6 +34,7 @@
>  #include "e500.h"
>  #include "timing.h"
>  #include "e500_mmu_host.h"
> +#include "booke.h"
>  
>  #include "trace_booke.h"
>  
> @@ -597,6 +598,10 @@ void kvmppc_mmu_map(struct kvm_vcpu *vcpu, u64 eaddr, gpa_t gpaddr,
>  	}
>  }
>  
> +int kvmppc_ld_inst(struct kvm_vcpu *vcpu, u32 *instr) {
> +	return EMULATE_FAIL;
> +};

Brace placement

>  /************* MMU Notifiers *************/
>  
>  int kvm_unmap_hva(struct kvm *kvm, unsigned long hva)
> diff --git a/arch/powerpc/kvm/emulate.c b/arch/powerpc/kvm/emulate.c
> index 2f9a087..24a8e50 100644
> --- a/arch/powerpc/kvm/emulate.c
> +++ b/arch/powerpc/kvm/emulate.c
> @@ -225,19 +225,26 @@ static int kvmppc_emulate_mfspr(struct kvm_vcpu *vcpu, int sprn, int rt)
>   * from opcode tables in the future. */
>  int kvmppc_emulate_instruction(struct kvm_run *run, struct kvm_vcpu *vcpu)
>  {
> -	u32 inst = kvmppc_get_last_inst(vcpu);
> -	int ra = get_ra(inst);
> -	int rs = get_rs(inst);
> -	int rt = get_rt(inst);
> -	int sprn = get_sprn(inst);
> -	enum emulation_result emulated = EMULATE_DONE;
> +	u32 inst;
> +	int ra, rs, rt, sprn;
> +	enum emulation_result emulated;
>  	int advance = 1;
>  
>  	/* this default type might be overwritten by subcategories */
>  	kvmppc_set_exit_type(vcpu, EMULATED_INST_EXITS);
>  
> +	emulated = kvmppc_get_last_inst(vcpu, &inst);
> +	if (emulated != EMULATE_DONE) {
> +		return emulated;
> +	}

Unnecessary braces

-Scott
