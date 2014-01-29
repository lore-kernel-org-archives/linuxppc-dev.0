Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1BD652C03D4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 03:40:45 +1100 (EST)
Message-ID: <52E92F08.6020803@suse.de>
Date: Wed, 29 Jan 2014 17:40:40 +0100
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 03/10] KVM: PPC: BOOK3S: PR: Emulate instruction
 counter
References: <1390927455-3312-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1390927455-3312-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1390927455-3312-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
> Writing to IC is not allowed in the privileged mode.

This is not a patch description.

>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>   arch/powerpc/include/asm/kvm_host.h | 1 +
>   arch/powerpc/kvm/book3s_emulate.c   | 3 +++
>   arch/powerpc/kvm/book3s_pr.c        | 2 ++
>   3 files changed, 6 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
> index 9ebdd12e50a9..e0b13aca98e6 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -509,6 +509,7 @@ struct kvm_vcpu_arch {
>   	/* Time base value when we entered the guest */
>   	u64 entry_tb;
>   	u64 entry_vtb;
> +	u64 entry_ic;
>   	u32 tcr;
>   	ulong tsr; /* we need to perform set/clr_bits() which requires ulong */
>   	u32 ivor[64];
> diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
> index 4b58d8a90cb5..abe6f3057e5b 100644
> --- a/arch/powerpc/kvm/book3s_emulate.c
> +++ b/arch/powerpc/kvm/book3s_emulate.c
> @@ -531,6 +531,9 @@ int kvmppc_core_emulate_mfspr_pr(struct kvm_vcpu *vcpu, int sprn, ulong *spr_val
>   	case SPRN_VTB:
>   		*spr_val = vcpu->arch.vtb;
>   		break;
> +	case SPRN_IC:
> +		*spr_val = vcpu->arch.ic;
> +		break;
>   	case SPRN_GQR0:
>   	case SPRN_GQR1:
>   	case SPRN_GQR2:
> diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
> index b5598e9cdd09..51d469f8c9fd 100644
> --- a/arch/powerpc/kvm/book3s_pr.c
> +++ b/arch/powerpc/kvm/book3s_pr.c
> @@ -121,6 +121,7 @@ void kvmppc_copy_to_svcpu(struct kvmppc_book3s_shadow_vcpu *svcpu,
>   	 */
>   	vcpu->arch.entry_tb = get_tb();
>   	vcpu->arch.entry_vtb = get_vtb();
> +	vcpu->arch.entry_ic = mfspr(SPRN_IC);

Is this implemented on all systems?

>   
>   }
>   
> @@ -174,6 +175,7 @@ out:
>   	vcpu->arch.purr += get_tb() - vcpu->arch.entry_tb;
>   	vcpu->arch.spurr += get_tb() - vcpu->arch.entry_tb;
>   	vcpu->arch.vtb += get_vtb() - vcpu->arch.entry_vtb;
> +	vcpu->arch.ic += mfspr(SPRN_IC) - vcpu->arch.entry_ic;

This is getting quite convoluted. How about we act slightly more fuzzy 
and put all of this into vcpu_load/put?


Alex
