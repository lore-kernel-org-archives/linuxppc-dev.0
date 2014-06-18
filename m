Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0243.outbound.protection.outlook.com [207.46.163.243])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 630971A02A8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jun 2014 03:22:07 +1000 (EST)
Message-ID: <1403112114.12851.54.camel@snotra.buserror.net>
Subject: Re: [PATCH v4] KVM: PPC: e500mc: Enhance tlb invalidation condition
 on vcpu schedule
From: Scott Wood <scottwood@freescale.com>
To: Mihai Caraman <mihai.caraman@freescale.com>
Date: Wed, 18 Jun 2014 12:21:54 -0500
In-Reply-To: <1403075722-11151-1-git-send-email-mihai.caraman@freescale.com>
References: <1403075722-11151-1-git-send-email-mihai.caraman@freescale.com>
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

On Wed, 2014-06-18 at 10:15 +0300, Mihai Caraman wrote:
> On vcpu schedule, the condition checked for tlb pollution is too loose.
> The tlb entries of a vcpu become polluted (vs stale) only when a different
> vcpu within the same logical partition runs in-between. Optimize the tlb
> invalidation condition keeping last_vcpu per logical partition id.
> 
> With the new invalidation condition, a guest shows 4% performance improvement
> on P5020DS while running a memory stress application with the cpu oversubscribed,
> the other guest running a cpu intensive workload.
> 
> Guest - old invalidation condition
>   real 3.89
>   user 3.87
>   sys 0.01
> 
> Guest - enhanced invalidation condition
>   real 3.75
>   user 3.73
>   sys 0.01
> 
> Host
>   real 3.70
>   user 1.85
>   sys 0.00
> 
> The memory stress application accesses 4KB pages backed by 75% of available
> TLB0 entries:
> 
> char foo[ENTRIES][4096] __attribute__ ((aligned (4096)));
> 
> int main()
> {
> 	char bar;
> 	int i, j;
> 
> 	for (i = 0; i < ITERATIONS; i++)
>         	for (j = 0; j < ENTRIES; j++)
>             		bar = foo[j][0];
> 
> 	return 0;
> }
> 
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> Cc: Scott Wood <scottwood@freescale.com>
> ---
> v4:
>  - rename last_vcpu_on_cpu to last_vcpu_of_lpid
>  - use "*[" syntax despite checkpatch error
>  
> v3:
>  - use existing logic while keeping last_cpu per lpid
> 
>  arch/powerpc/kvm/e500mc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/e500mc.c b/arch/powerpc/kvm/e500mc.c
> index 17e4562..690499d 100644
> --- a/arch/powerpc/kvm/e500mc.c
> +++ b/arch/powerpc/kvm/e500mc.c
> @@ -110,7 +110,7 @@ void kvmppc_mmu_msr_notify(struct kvm_vcpu *vcpu, u32 old_msr)
>  {
>  }
>  
> -static DEFINE_PER_CPU(struct kvm_vcpu *, last_vcpu_on_cpu);
> +static DEFINE_PER_CPU(struct kvm_vcpu *[KVMPPC_NR_LPIDS], last_vcpu_of_lpid);
>  
>  static void kvmppc_core_vcpu_load_e500mc(struct kvm_vcpu *vcpu, int cpu)
>  {
> @@ -141,9 +141,9 @@ static void kvmppc_core_vcpu_load_e500mc(struct kvm_vcpu *vcpu, int cpu)
>  	mtspr(SPRN_GESR, vcpu->arch.shared->esr);
>  
>  	if (vcpu->arch.oldpir != mfspr(SPRN_PIR) ||
> -	    __get_cpu_var(last_vcpu_on_cpu) != vcpu) {
> +	    __get_cpu_var(last_vcpu_of_lpid)[vcpu->kvm->arch.lpid] != vcpu) {
>  		kvmppc_e500_tlbil_all(vcpu_e500);
> -		__get_cpu_var(last_vcpu_on_cpu) = vcpu;
> +		__get_cpu_var(last_vcpu_of_lpid)[vcpu->kvm->arch.lpid] = vcpu;
>  	}
>  
>  	kvmppc_load_guest_fp(vcpu);

Reviewed-by: Scott Wood <scottwood@freescale.com>

-Scott
