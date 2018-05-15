Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40lS3n1tpfzF2sP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 May 2018 16:15:33 +1000 (AEST)
Date: Tue, 15 May 2018 16:07:55 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: wei.guo.simon@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v2 18/30] KVM: PPC: Book3S PR: always fail transaction in
 guest privilege state
Message-ID: <20180515060755.GD28451@fergus.ozlabs.ibm.com>
References: <1519753958-11756-1-git-send-email-wei.guo.simon@gmail.com>
 <1519753958-11756-8-git-send-email-wei.guo.simon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1519753958-11756-8-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 28, 2018 at 01:52:26AM +0800, wei.guo.simon@gmail.com wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> Currently kernel doesn't use transaction memory.
> And there is an issue for privilege guest that:
> tbegin/tsuspend/tresume/tabort TM instructions can impact MSR TM bits
> without trap into PR host. So following code will lead to a false mfmsr
> result:
> 	tbegin	<- MSR bits update to Transaction active.
> 	beq 	<- failover handler branch
> 	mfmsr	<- still read MSR bits from magic page with
> 		transaction inactive.
> 
> It is not an issue for non-privilege guest since its mfmsr is not patched
> with magic page and will always trap into PR host.
> 
> This patch will always fail tbegin attempt for privilege guest, so that
> the above issue is prevented. It is benign since currently (guest) kernel
> doesn't initiate a transaction.
> 
> Test case:
> https://github.com/justdoitqd/publicFiles/blob/master/test_tbegin_pr.c
> 
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
> ---
>  arch/powerpc/include/asm/kvm_book3s.h |  2 ++
>  arch/powerpc/kvm/book3s_emulate.c     | 43 +++++++++++++++++++++++++++++++++++
>  arch/powerpc/kvm/book3s_pr.c          | 11 ++++++++-
>  3 files changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
> index 2ecb6a3..9690280 100644
> --- a/arch/powerpc/include/asm/kvm_book3s.h
> +++ b/arch/powerpc/include/asm/kvm_book3s.h
> @@ -258,9 +258,11 @@ extern void kvmppc_copy_from_svcpu(struct kvm_vcpu *vcpu,
>  #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
>  void kvmppc_save_tm_pr(struct kvm_vcpu *vcpu);
>  void kvmppc_restore_tm_pr(struct kvm_vcpu *vcpu);
> +void kvmppc_restore_tm_sprs(struct kvm_vcpu *vcpu);
>  #else
>  static inline void kvmppc_save_tm_pr(struct kvm_vcpu *vcpu) {}
>  static inline void kvmppc_restore_tm_pr(struct kvm_vcpu *vcpu) {}
> +static inline void kvmppc_restore_tm_sprs(struct kvm_vcpu *vcpu) {}
>  #endif
>  
>  extern int kvm_irq_bypass;
> diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
> index a03533d..90b5f59 100644
> --- a/arch/powerpc/kvm/book3s_emulate.c
> +++ b/arch/powerpc/kvm/book3s_emulate.c
> @@ -23,6 +23,7 @@
>  #include <asm/reg.h>
>  #include <asm/switch_to.h>
>  #include <asm/time.h>
> +#include <asm/tm.h>
>  #include "book3s.h"
>  
>  #define OP_19_XOP_RFID		18
> @@ -47,6 +48,8 @@
>  #define OP_31_XOP_EIOIO		854
>  #define OP_31_XOP_SLBMFEE	915
>  
> +#define OP_31_XOP_TBEGIN	654
> +
>  /* DCBZ is actually 1014, but we patch it to 1010 so we get a trap */
>  #define OP_31_XOP_DCBZ		1010
>  
> @@ -362,6 +365,46 @@ int kvmppc_core_emulate_op_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
>  
>  			break;
>  		}
> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> +		case OP_31_XOP_TBEGIN:
> +		{
> +			if (!cpu_has_feature(CPU_FTR_TM))
> +				break;
> +
> +			if (!(kvmppc_get_msr(vcpu) & MSR_TM)) {
> +				kvmppc_trigger_fac_interrupt(vcpu, FSCR_TM_LG);
> +				emulated = EMULATE_AGAIN;
> +				break;
> +			}
> +
> +			if (!(kvmppc_get_msr(vcpu) & MSR_PR)) {
> +				preempt_disable();
> +				vcpu->arch.cr = (CR0_TBEGIN_FAILURE |
> +				  (vcpu->arch.cr & ~(CR0_MASK << CR0_SHIFT)));
> +
> +				vcpu->arch.texasr = (TEXASR_FS | TEXASR_EX |
> +					(((u64)(TM_CAUSE_EMULATE | TM_CAUSE_PERSISTENT))
> +						 << TEXASR_FC_LG));
> +
> +				if ((inst >> 21) & 0x1)
> +					vcpu->arch.texasr |= TEXASR_ROT;
> +
> +				if (kvmppc_get_msr(vcpu) & MSR_PR)
> +					vcpu->arch.texasr |= TEXASR_PR;

This if statement seems unnecessary, since we only get here when
MSR_PR is clear.

Paul.
