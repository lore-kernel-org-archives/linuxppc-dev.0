Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40c4sp2Cf3zF2Tk
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2018 16:26:22 +1000 (AEST)
Date: Thu, 3 May 2018 16:08:17 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: wei.guo.simon@gmail.com
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 08/11] KVM: PPC: add giveup_ext() hook for PPC KVM ops
Message-ID: <20180503060817.GI6795@fergus.ozlabs.ibm.com>
References: <1524657284-16706-1-git-send-email-wei.guo.simon@gmail.com>
 <1524657284-16706-9-git-send-email-wei.guo.simon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1524657284-16706-9-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 25, 2018 at 07:54:41PM +0800, wei.guo.simon@gmail.com wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> Currently HV will save math regs(FP/VEC/VSX) when trap into host. But
> PR KVM will only save math regs when qemu task switch out of CPU.
> 
> To emulate FP/VEC/VSX load, PR KVM need to flush math regs firstly and
> then be able to update saved VCPU FPR/VEC/VSX area reasonably.
> 
> This patch adds the giveup_ext() to KVM ops (an empty one for HV KVM)
> and kvmppc_complete_mmio_load() can invoke that hook to flush math
> regs accordingly.
> 
> Math regs flush is also necessary for STORE, which will be covered
> in later patch within this patch series.
> 
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>

I don't see where you have provided a function for Book E.

I would suggest you only set the function pointer to non-NULL when the
function is actually needed, i.e. for PR KVM.

It seems to me that this means that emulation of FP/VMX/VSX loads is
currently broken for PR KVM for the case where kvm_io_bus_read() is
able to supply the data, and the emulation of FP/VMX/VSX stores is
broken for PR KVM for all cases.  Do you agree?

> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 5b875ba..7eb5507 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -2084,6 +2084,10 @@ static int kvmhv_set_smt_mode(struct kvm *kvm, unsigned long smt_mode,
>  	return err;
>  }
>  
> +static void kvmhv_giveup_ext(struct kvm_vcpu *vcpu, ulong msr)
> +{
> +}
> +
>  static void unpin_vpa(struct kvm *kvm, struct kvmppc_vpa *vpa)
>  {
>  	if (vpa->pinned_addr)
> @@ -4398,6 +4402,7 @@ static int kvmhv_configure_mmu(struct kvm *kvm, struct kvm_ppc_mmuv3_cfg *cfg)
>  	.configure_mmu = kvmhv_configure_mmu,
>  	.get_rmmu_info = kvmhv_get_rmmu_info,
>  	.set_smt_mode = kvmhv_set_smt_mode,
> +	.giveup_ext = kvmhv_giveup_ext,
>  };
>  
>  static int kvm_init_subcore_bitmap(void)

I think HV KVM could leave this pointer as NULL, and then...

> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 17f0315..e724601 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -1061,6 +1061,9 @@ static void kvmppc_complete_mmio_load(struct kvm_vcpu *vcpu,
>  		kvmppc_set_gpr(vcpu, vcpu->arch.io_gpr, gpr);
>  		break;
>  	case KVM_MMIO_REG_FPR:
> +		if (!is_kvmppc_hv_enabled(vcpu->kvm))
> +			vcpu->kvm->arch.kvm_ops->giveup_ext(vcpu, MSR_FP);
> +

This could become
		if (vcpu->kvm->arch.kvm_ops->giveup_ext)
			vcpu->kvm->arch.kvm_ops->giveup_ext(vcpu, MSR_FP);

and you wouldn't need to fix Book E explicitly.

Paul.
