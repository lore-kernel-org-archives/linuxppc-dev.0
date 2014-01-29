Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 284C22C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 03:39:39 +1100 (EST)
Message-ID: <52E92EC6.2030607@suse.de>
Date: Wed, 29 Jan 2014 17:39:34 +0100
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 02/10] KVM: PPC: BOOK3S: PR: Emulate virtual timebase
 register
References: <1390927455-3312-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1390927455-3312-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1390927455-3312-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
> virtual time base register is a per vm register and need to saved
> and restored on vm exit and entry. Writing to VTB is not allowed
> in the privileged mode.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>   arch/powerpc/include/asm/kvm_host.h |  1 +
>   arch/powerpc/include/asm/reg.h      |  7 +++++++
>   arch/powerpc/include/asm/time.h     | 12 ++++++++++++
>   arch/powerpc/kvm/book3s_emulate.c   |  3 +++
>   arch/powerpc/kvm/book3s_pr.c        |  3 +++
>   5 files changed, 26 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
> index 0a3785271f34..9ebdd12e50a9 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -508,6 +508,7 @@ struct kvm_vcpu_arch {
>   #endif
>   	/* Time base value when we entered the guest */
>   	u64 entry_tb;
> +	u64 entry_vtb;
>   	u32 tcr;
>   	ulong tsr; /* we need to perform set/clr_bits() which requires ulong */
>   	u32 ivor[64];
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index e789f76c9bc2..6c649355b1e9 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -1161,6 +1161,13 @@
>   #define mtspr(rn, v)	asm volatile("mtspr " __stringify(rn) ",%0" : \
>   				     : "r" ((unsigned long)(v)) \
>   				     : "memory")
> +#ifdef CONFIG_PPC_BOOK3S_64
> +#define mfvtb()		({unsigned long rval;				\
> +			asm volatile("mfspr %0, %1" :			\
> +				     "=r" (rval) : "i" (SPRN_VTB)); rval;})
> +#else
> +#define mfvtb() BUG()
> +#endif

static inline mfvtb(unsigned long)
{
#ifdef CONFIG_PPC_BOOK3S_64
     return mfspr(SPRN_VTB);
#else
     BUG();
#endif
}

is a lot easier to read and get right. But reg.h is Ben's call.

Also could you please give me a pointer to the specification for it? I 
tried to look up vtb in the 2.06 ISA and couldn't find it. Is it a CPU 
specific register?

>   
>   #ifdef __powerpc64__
>   #if defined(CONFIG_PPC_CELL) || defined(CONFIG_PPC_FSL_BOOK3E)
> diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
> index c1f267694acb..1e89dbc665d9 100644
> --- a/arch/powerpc/include/asm/time.h
> +++ b/arch/powerpc/include/asm/time.h
> @@ -101,6 +101,18 @@ static inline u64 get_rtc(void)
>   	return (u64)hi * 1000000000 + lo;
>   }
>   
> +#ifdef CONFIG_PPC_BOOK3S_64
> +static inline u64 get_vtb(void)
> +{
> +	return mfvtb();
> +}
> +#else
> +static inline u64 get_vtb(void)
> +{
> +	return 0;
> +}
> +#endif

Just put the #ifdef inside the function body.

> +
>   #ifdef CONFIG_PPC64
>   static inline u64 get_tb(void)
>   {
> diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
> index e1f1e5e16449..4b58d8a90cb5 100644
> --- a/arch/powerpc/kvm/book3s_emulate.c
> +++ b/arch/powerpc/kvm/book3s_emulate.c
> @@ -528,6 +528,9 @@ int kvmppc_core_emulate_mfspr_pr(struct kvm_vcpu *vcpu, int sprn, ulong *spr_val
>   		 */
>   		*spr_val = vcpu->arch.spurr;
>   		break;
> +	case SPRN_VTB:
> +		*spr_val = vcpu->arch.vtb;
> +		break;
>   	case SPRN_GQR0:
>   	case SPRN_GQR1:
>   	case SPRN_GQR2:
> diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
> index 02231f5193c2..b5598e9cdd09 100644
> --- a/arch/powerpc/kvm/book3s_pr.c
> +++ b/arch/powerpc/kvm/book3s_pr.c
> @@ -120,6 +120,8 @@ void kvmppc_copy_to_svcpu(struct kvmppc_book3s_shadow_vcpu *svcpu,
>   	 * to find the guest purr and spurr value.
>   	 */
>   	vcpu->arch.entry_tb = get_tb();
> +	vcpu->arch.entry_vtb = get_vtb();
> +
>   }
>   
>   /* Copy data touched by real-mode code from shadow vcpu back to vcpu */
> @@ -171,6 +173,7 @@ out:
>   	 */
>   	vcpu->arch.purr += get_tb() - vcpu->arch.entry_tb;
>   	vcpu->arch.spurr += get_tb() - vcpu->arch.entry_tb;
> +	vcpu->arch.vtb += get_vtb() - vcpu->arch.entry_vtb;

I thought it's per vm? That would contradict the per-vcpu logic you're 
implementing here. This way vtb scews with world switches on SMP guests.


Alex
