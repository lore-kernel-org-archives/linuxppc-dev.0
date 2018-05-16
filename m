Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mWlQ5NRTzF14f
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 10:05:06 +1000 (AEST)
Date: Thu, 17 May 2018 09:52:07 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: wei.guo.simon@gmail.com
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 07/10] KVM: PPC: reimplement LOAD_FP/STORE_FP
 instruction mmio emulation with analyse_intr() input
Message-ID: <20180516235207.GC24778@fergus.ozlabs.ibm.com>
References: <1525674016-6703-1-git-send-email-wei.guo.simon@gmail.com>
 <1525674016-6703-8-git-send-email-wei.guo.simon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1525674016-6703-8-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 07, 2018 at 02:20:13PM +0800, wei.guo.simon@gmail.com wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> This patch reimplements LOAD_FP/STORE_FP instruction MMIO emulation with
> analyse_intr() input. It utilizes the FPCONV/UPDATE properties exported by
> analyse_instr() and invokes kvmppc_handle_load(s)/kvmppc_handle_store()
> accordingly.
> 
> For FP store MMIO emulation, the FP regs need to be flushed firstly so
> that the right FP reg vals can be read from vcpu->arch.fpr, which will
> be stored into MMIO data.
> 
> Suggested-by: Paul Mackerras <paulus@ozlabs.org>
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>

One comment below, otherwise looks good...

>  arch/powerpc/kvm/emulate_loadstore.c | 197 +++++++----------------------------
>  1 file changed, 40 insertions(+), 157 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/emulate_loadstore.c b/arch/powerpc/kvm/emulate_loadstore.c
> index 2a91845..5a6571c 100644
> --- a/arch/powerpc/kvm/emulate_loadstore.c
> +++ b/arch/powerpc/kvm/emulate_loadstore.c
> @@ -138,6 +138,22 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
>  
>  			break;
>  		}
> +#ifdef CONFIG_PPC_FPU
> +		case LOAD_FP:
> +			if (kvmppc_check_fp_disabled(vcpu))
> +				return EMULATE_DONE;
> +
> +			if (op.type & FPCONV)
> +				vcpu->arch.mmio_sp64_extend = 1;
> +
> +			emulated = kvmppc_handle_load(run, vcpu,
> +					KVM_MMIO_REG_FPR|op.reg, size, 1);

You need to check the SIGNEXT flag and call kvmppc_handle_loads if it
is set, because of the lfiwax case:

> -		case OP_31_XOP_LFIWAX:
> -			if (kvmppc_check_fp_disabled(vcpu))
> -				return EMULATE_DONE;
> -			emulated = kvmppc_handle_loads(run, vcpu,
> -				KVM_MMIO_REG_FPR|rt, 4, 1);
> -			break;

Paul.
