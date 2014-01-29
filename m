Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E478C2C00BF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 03:32:27 +1100 (EST)
Message-ID: <52E92D15.8000901@suse.de>
Date: Wed, 29 Jan 2014 17:32:21 +0100
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 01/10] KVM: PPC: BOOK3S: PR: Fix PURR and SPURR
 emulation
References: <1390927455-3312-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1390927455-3312-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1390927455-3312-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/28/2014 05:44 PM, Aneesh Kumar K.V wrote:
> We definitely don't need to emulate mtspr, because both the registers
> are hypervisor resource.

This patch description doesn't cover what the patch actually does. It 
changes the implementation from "always tell the guest it uses 100%" to 
"give the guest an accurate amount of cpu time spent inside guest context".

Also, I think we either go with full hyp semantics which means we also 
emulate the offset or we go with no hyp awareness in the guest at all 
which means we also don't emulate SPURR which is a hyp privileged register.

Otherwise I like the patch :).


Alex

>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>   arch/powerpc/include/asm/kvm_book3s.h |  2 --
>   arch/powerpc/include/asm/kvm_host.h   |  4 ++--
>   arch/powerpc/kvm/book3s_emulate.c     | 16 ++++++++--------
>   arch/powerpc/kvm/book3s_pr.c          | 10 ++++++++++
>   4 files changed, 20 insertions(+), 12 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
> index bc23b1ba7980..396448afa38b 100644
> --- a/arch/powerpc/include/asm/kvm_book3s.h
> +++ b/arch/powerpc/include/asm/kvm_book3s.h
> @@ -83,8 +83,6 @@ struct kvmppc_vcpu_book3s {
>   	u64 sdr1;
>   	u64 hior;
>   	u64 msr_mask;
> -	u64 purr_offset;
> -	u64 spurr_offset;
>   #ifdef CONFIG_PPC_BOOK3S_32
>   	u32 vsid_pool[VSID_POOL_SIZE];
>   	u32 vsid_next;
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
> index 9a0cdb2c9d58..0a3785271f34 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -506,8 +506,8 @@ struct kvm_vcpu_arch {
>   #ifdef CONFIG_BOOKE
>   	u32 decar;
>   #endif
> -	u32 tbl;
> -	u32 tbu;
> +	/* Time base value when we entered the guest */
> +	u64 entry_tb;
>   	u32 tcr;
>   	ulong tsr; /* we need to perform set/clr_bits() which requires ulong */
>   	u32 ivor[64];
> diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
> index a7d54aa203d0..e1f1e5e16449 100644
> --- a/arch/powerpc/kvm/book3s_emulate.c
> +++ b/arch/powerpc/kvm/book3s_emulate.c
> @@ -422,12 +422,6 @@ int kvmppc_core_emulate_mtspr_pr(struct kvm_vcpu *vcpu, int sprn, ulong spr_val)
>   		    (mfmsr() & MSR_HV))
>   			vcpu->arch.hflags |= BOOK3S_HFLAG_DCBZ32;
>   		break;
> -	case SPRN_PURR:
> -		to_book3s(vcpu)->purr_offset = spr_val - get_tb();
> -		break;
> -	case SPRN_SPURR:
> -		to_book3s(vcpu)->spurr_offset = spr_val - get_tb();
> -		break;
>   	case SPRN_GQR0:
>   	case SPRN_GQR1:
>   	case SPRN_GQR2:
> @@ -523,10 +517,16 @@ int kvmppc_core_emulate_mfspr_pr(struct kvm_vcpu *vcpu, int sprn, ulong *spr_val
>   		*spr_val = 0;
>   		break;
>   	case SPRN_PURR:
> -		*spr_val = get_tb() + to_book3s(vcpu)->purr_offset;
> +		/*
> +		 * On exit we would have updated purr
> +		 */
> +		*spr_val = vcpu->arch.purr;
>   		break;
>   	case SPRN_SPURR:
> -		*spr_val = get_tb() + to_book3s(vcpu)->purr_offset;
> +		/*
> +		 * On exit we would have updated spurr
> +		 */
> +		*spr_val = vcpu->arch.spurr;
>   		break;
>   	case SPRN_GQR0:
>   	case SPRN_GQR1:
> diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
> index fdcbabdfb709..02231f5193c2 100644
> --- a/arch/powerpc/kvm/book3s_pr.c
> +++ b/arch/powerpc/kvm/book3s_pr.c
> @@ -115,6 +115,11 @@ void kvmppc_copy_to_svcpu(struct kvmppc_book3s_shadow_vcpu *svcpu,
>   	svcpu->lr  = vcpu->arch.lr;
>   	svcpu->pc  = vcpu->arch.pc;
>   	svcpu->in_use = true;
> +	/*
> +	 * Now also save the current time base value. We use this
> +	 * to find the guest purr and spurr value.
> +	 */
> +	vcpu->arch.entry_tb = get_tb();
>   }
>   
>   /* Copy data touched by real-mode code from shadow vcpu back to vcpu */
> @@ -161,6 +166,11 @@ void kvmppc_copy_from_svcpu(struct kvm_vcpu *vcpu,
>   
>   out:
>   	preempt_enable();
> +	/*
> +	 * Update purr and spurr using time base
> +	 */
> +	vcpu->arch.purr += get_tb() - vcpu->arch.entry_tb;
> +	vcpu->arch.spurr += get_tb() - vcpu->arch.entry_tb;
>   }
>   
>   static int kvmppc_core_check_requests_pr(struct kvm_vcpu *vcpu)
