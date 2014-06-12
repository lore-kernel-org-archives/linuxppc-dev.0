Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2AF9B1A0039
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jun 2014 03:04:45 +1000 (EST)
Message-ID: <5399DDA8.5060404@suse.de>
Date: Thu, 12 Jun 2014 19:04:40 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Mihai Caraman <mihai.caraman@freescale.com>
Subject: Re: [PATCH] KVM: PPC: e500mc: Relax tlb invalidation condition on
 vcpu schedule
References: <1402581610-16585-1-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1402581610-16585-1-git-send-email-mihai.caraman@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/12/2014 04:00 PM, Mihai Caraman wrote:
> On vcpu schedule, the condition checked for tlb pollution is too tight.
> The tlb entries of one vcpu are polluted when a different vcpu from the
> same partition runs in-between. Relax the current tlb invalidation
> condition taking into account the lpid.
>
> Signed-off-by: Mihai Caraman <mihai.caraman <at> freescale.com>

Your mailer is broken? :)
This really should be an @.

I think this should work. Scott, please ack.


Alex

> Cc: Scott Wood <scottwood <at> freescale.com>
> ---
>   arch/powerpc/kvm/e500mc.c | 20 +++++++++++++++++---
>   1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/kvm/e500mc.c b/arch/powerpc/kvm/e500mc.c
> index 17e4562..2e0cd69 100644
> --- a/arch/powerpc/kvm/e500mc.c
> +++ b/arch/powerpc/kvm/e500mc.c
> @@ -111,10 +111,12 @@ void kvmppc_mmu_msr_notify(struct kvm_vcpu *vcpu, u32 old_msr)
>   }
>   
>   static DEFINE_PER_CPU(struct kvm_vcpu *, last_vcpu_on_cpu);
> +static DEFINE_PER_CPU(int, last_lpid_on_cpu);
>   
>   static void kvmppc_core_vcpu_load_e500mc(struct kvm_vcpu *vcpu, int cpu)
>   {
>   	struct kvmppc_vcpu_e500 *vcpu_e500 = to_e500(vcpu);
> +	bool update_last = false, inval_tlb = false;
>   
>   	kvmppc_booke_vcpu_load(vcpu, cpu);
>   
> @@ -140,12 +142,24 @@ static void kvmppc_core_vcpu_load_e500mc(struct kvm_vcpu *vcpu, int cpu)
>   	mtspr(SPRN_GDEAR, vcpu->arch.shared->dar);
>   	mtspr(SPRN_GESR, vcpu->arch.shared->esr);
>   
> -	if (vcpu->arch.oldpir != mfspr(SPRN_PIR) ||
> -	    __get_cpu_var(last_vcpu_on_cpu) != vcpu) {
> -		kvmppc_e500_tlbil_all(vcpu_e500);
> +	if (vcpu->arch.oldpir != mfspr(SPRN_PIR)) {
> +		/* tlb entries deprecated */
> +		inval_tlb = update_last = true;
> +	} else if (__get_cpu_var(last_vcpu_on_cpu) != vcpu) {
> +		update_last = true;
> +		/* tlb entries polluted */
> +		inval_tlb = __get_cpu_var(last_lpid_on_cpu) ==
> +			    vcpu->kvm->arch.lpid;
> +	}
> +
> +	if (update_last) {
>   		__get_cpu_var(last_vcpu_on_cpu) = vcpu;
> +		__get_cpu_var(last_lpid_on_cpu) = vcpu->kvm->arch.lpid;
>   	}
>   
> +	if (inval_tlb)
> +		kvmppc_e500_tlbil_all(vcpu_e500);
> +
>   	kvmppc_load_guest_fp(vcpu);
>   }
>   
