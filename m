Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40c4sm4P2pzF2Tl
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2018 16:26:20 +1000 (AEST)
Date: Thu, 3 May 2018 16:17:15 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: wei.guo.simon@gmail.com
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 10/11] KVM: PPC: reconstruct LOAD_VMX/STORE_VMX
 instruction mmio emulation with analyse_intr() input
Message-ID: <20180503061715.GK6795@fergus.ozlabs.ibm.com>
References: <1524657284-16706-1-git-send-email-wei.guo.simon@gmail.com>
 <1524657284-16706-11-git-send-email-wei.guo.simon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1524657284-16706-11-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 25, 2018 at 07:54:43PM +0800, wei.guo.simon@gmail.com wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> This patch reconstructs LOAD_VMX/STORE_VMX instruction MMIO emulation with
> analyse_intr() input. When emulating the store, the VMX reg will need to
> be flushed so that the right reg val can be retrieved before writing to
> IO MEM.
> 
> Suggested-by: Paul Mackerras <paulus@ozlabs.org>
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>

This looks fine for lvx and stvx, but now we are also doing something
for the vector element loads and stores (lvebx, stvebx, lvehx, stvehx,
etc.) without having the logic to insert or extract the correct
element in the vector register image.  We need either to generate an
error for the element load/store instructions, or handle them
correctly.

> diff --git a/arch/powerpc/kvm/emulate_loadstore.c b/arch/powerpc/kvm/emulate_loadstore.c
> index 2dbdf9a..0bfee2f 100644
> --- a/arch/powerpc/kvm/emulate_loadstore.c
> +++ b/arch/powerpc/kvm/emulate_loadstore.c
> @@ -160,6 +160,27 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
>  					KVM_MMIO_REG_FPR|op.reg, size, 1);
>  			break;
>  #endif
> +#ifdef CONFIG_ALTIVEC
> +		case LOAD_VMX:
> +			if (kvmppc_check_altivec_disabled(vcpu))
> +				return EMULATE_DONE;
> +
> +			/* VMX access will need to be size aligned */

This comment isn't quite right; it isn't that the address needs to be
size-aligned, it's that the hardware forcibly aligns it.  So I would
say something like /* Hardware enforces alignment of VMX accesses */.

> +			vcpu->arch.vaddr_accessed &= ~((unsigned long)size - 1);
> +			vcpu->arch.paddr_accessed &= ~((unsigned long)size - 1);
> +
> +			if (size == 16) {
> +				vcpu->arch.mmio_vmx_copy_nums = 2;
> +				emulated = kvmppc_handle_load128_by2x64(run,
> +						vcpu, KVM_MMIO_REG_VMX|op.reg,
> +						1);
> +			} else if (size <= 8)
> +				emulated = kvmppc_handle_load(run, vcpu,
> +						KVM_MMIO_REG_VMX|op.reg,
> +						size, 1);
> +
> +			break;
> +#endif
>  		case STORE:
>  			if (op.type & UPDATE) {
>  				vcpu->arch.mmio_ra = op.update_reg;
> @@ -197,6 +218,36 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
>  					VCPU_FPR(vcpu, op.reg), size, 1);
>  			break;
>  #endif
> +#ifdef CONFIG_ALTIVEC
> +		case STORE_VMX:
> +			if (kvmppc_check_altivec_disabled(vcpu))
> +				return EMULATE_DONE;
> +
> +			/* VMX access will need to be size aligned */
> +			vcpu->arch.vaddr_accessed &= ~((unsigned long)size - 1);
> +			vcpu->arch.paddr_accessed &= ~((unsigned long)size - 1);
> +
> +			/* if it is PR KVM, the FP/VEC/VSX registers need to
> +			 * be flushed so that kvmppc_handle_store() can read
> +			 * actual VMX vals from vcpu->arch.
> +			 */
> +			if (!is_kvmppc_hv_enabled(vcpu->kvm))

As before, I suggest just testing that the function pointer isn't
NULL.

> +				vcpu->kvm->arch.kvm_ops->giveup_ext(vcpu,
> +						MSR_VEC);
> +
> +			if (size == 16) {
> +				vcpu->arch.mmio_vmx_copy_nums = 2;
> +				emulated = kvmppc_handle_store128_by2x64(run,
> +						vcpu, op.reg, 1);
> +			} else if (size <= 8) {
> +				u64 val;
> +
> +				kvmppc_get_vmx_data(vcpu, op.reg, &val);
> +				emulated = kvmppc_handle_store(run, vcpu,
> +						val, size, 1);
> +			}
> +			break;
> +#endif
>  		case CACHEOP:
>  			/* Do nothing. The guest is performing dcbi because
>  			 * hardware DMA is not snooped by the dcache, but
> @@ -354,28 +405,6 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
>  			break;
>  #endif /* CONFIG_VSX */
>  
> -#ifdef CONFIG_ALTIVEC
> -		case OP_31_XOP_LVX:
> -			if (kvmppc_check_altivec_disabled(vcpu))
> -				return EMULATE_DONE;
> -			vcpu->arch.vaddr_accessed &= ~0xFULL;
> -			vcpu->arch.paddr_accessed &= ~0xFULL;
> -			vcpu->arch.mmio_vmx_copy_nums = 2;
> -			emulated = kvmppc_handle_load128_by2x64(run, vcpu,
> -					KVM_MMIO_REG_VMX|rt, 1);
> -			break;
> -
> -		case OP_31_XOP_STVX:
> -			if (kvmppc_check_altivec_disabled(vcpu))
> -				return EMULATE_DONE;
> -			vcpu->arch.vaddr_accessed &= ~0xFULL;
> -			vcpu->arch.paddr_accessed &= ~0xFULL;
> -			vcpu->arch.mmio_vmx_copy_nums = 2;
> -			emulated = kvmppc_handle_store128_by2x64(run, vcpu,
> -					rs, 1);
> -			break;
> -#endif /* CONFIG_ALTIVEC */
> -
>  		default:
>  			emulated = EMULATE_FAIL;
>  			break;
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index e724601..000182e 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -1408,7 +1408,7 @@ int kvmppc_handle_load128_by2x64(struct kvm_run *run, struct kvm_vcpu *vcpu,
>  	return emulated;
>  }
>  
> -static inline int kvmppc_get_vmx_data(struct kvm_vcpu *vcpu, int rs, u64 *val)
> +int kvmppc_get_vmx_data(struct kvm_vcpu *vcpu, int rs, u64 *val)
>  {
>  	vector128 vrs = VCPU_VSX_VR(vcpu, rs);
>  	u32 di;
> -- 
> 1.8.3.1

Paul.
