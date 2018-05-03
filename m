Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40c4sn11cQzF2Tk
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2018 16:26:21 +1000 (AEST)
Date: Thu, 3 May 2018 15:46:01 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: wei.guo.simon@gmail.com
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 02/11] KVM: PPC: mov nip/ctr/lr/xer registers to pt_regs
 in kvm_vcpu_arch
Message-ID: <20180503054600.GC6795@fergus.ozlabs.ibm.com>
References: <1524657284-16706-1-git-send-email-wei.guo.simon@gmail.com>
 <1524657284-16706-3-git-send-email-wei.guo.simon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1524657284-16706-3-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 25, 2018 at 07:54:35PM +0800, wei.guo.simon@gmail.com wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> This patch moves nip/ctr/lr/xer registers from scattered places in
> kvm_vcpu_arch to pt_regs structure.
> 
> cr register is "unsigned long" in pt_regs and u32 in vcpu->arch.
> It will need more consideration and may move in later patches.
> 
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>

Mostly looks fine; some nits below.

> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
> index e8a78a5..731f7d4 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -431,14 +431,14 @@ int main(void)
>  #ifdef CONFIG_ALTIVEC
>  	OFFSET(VCPU_VRS, kvm_vcpu, arch.vr.vr);
>  #endif
> -	OFFSET(VCPU_XER, kvm_vcpu, arch.xer);
> -	OFFSET(VCPU_CTR, kvm_vcpu, arch.ctr);
> -	OFFSET(VCPU_LR, kvm_vcpu, arch.lr);
> +	OFFSET(VCPU_XER, kvm_vcpu, arch.regs.xer);
> +	OFFSET(VCPU_CTR, kvm_vcpu, arch.regs.ctr);
> +	OFFSET(VCPU_LR, kvm_vcpu, arch.regs.link);
>  #ifdef CONFIG_PPC_BOOK3S
>  	OFFSET(VCPU_TAR, kvm_vcpu, arch.tar);
>  #endif
> -	OFFSET(VCPU_CR, kvm_vcpu, arch.cr);
> -	OFFSET(VCPU_PC, kvm_vcpu, arch.nip);

This should be arch.pc; arch.nip doesn't exist.

> +	OFFSET(VCPU_CR, kvm_vcpu, arch.regs.ccr);

I thought the patch description said you weren't moving CR at this
stage?

> +	OFFSET(VCPU_PC, kvm_vcpu, arch.regs.nip);
>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
>  	OFFSET(VCPU_MSR, kvm_vcpu, arch.shregs.msr);
>  	OFFSET(VCPU_SRR0, kvm_vcpu, arch.shregs.srr0);
> @@ -693,11 +693,11 @@ int main(void)
>  #endif /* CONFIG_PPC_BOOK3S_64 */
>  
>  #else /* CONFIG_PPC_BOOK3S */
> -	OFFSET(VCPU_CR, kvm_vcpu, arch.cr);
> -	OFFSET(VCPU_XER, kvm_vcpu, arch.xer);
> -	OFFSET(VCPU_LR, kvm_vcpu, arch.lr);
> -	OFFSET(VCPU_CTR, kvm_vcpu, arch.ctr);
> -	OFFSET(VCPU_PC, kvm_vcpu, arch.pc);
> +	OFFSET(VCPU_CR, kvm_vcpu, arch.regs.ccr);

Once again VCPU_CR should not be changed.

> +	OFFSET(VCPU_XER, kvm_vcpu, arch.regs.xer);
> +	OFFSET(VCPU_LR, kvm_vcpu, arch.regs.link);
> +	OFFSET(VCPU_CTR, kvm_vcpu, arch.regs.ctr);
> +	OFFSET(VCPU_PC, kvm_vcpu, arch.regs.nip);
>  	OFFSET(VCPU_SPRG9, kvm_vcpu, arch.sprg9);
>  	OFFSET(VCPU_LAST_INST, kvm_vcpu, arch.last_inst);
>  	OFFSET(VCPU_FAULT_DEAR, kvm_vcpu, arch.fault_dear);

Paul.
