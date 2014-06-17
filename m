Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0235.outbound.protection.outlook.com [207.46.163.235])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6AD5E1A02B8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 05:18:38 +1000 (EST)
Message-ID: <1403032706.6603.776.camel@snotra.buserror.net>
Subject: Re: [PATCH v3] KVM: PPC: e500mc: Enhance tlb invalidation condition
 on vcpu schedule
From: Scott Wood <scottwood@freescale.com>
To: Mihai Caraman <mihai.caraman@freescale.com>
Date: Tue, 17 Jun 2014 14:18:26 -0500
In-Reply-To: <1403032176-28362-1-git-send-email-mihai.caraman@freescale.com>
References: <1403032176-28362-1-git-send-email-mihai.caraman@freescale.com>
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

On Tue, 2014-06-17 at 22:09 +0300, Mihai Caraman wrote:
> On vcpu schedule, the condition checked for tlb pollution is too loose.
> The tlb entries of a vcpu become polluted (vs stale) only when a different
> vcpu within the same logical partition runs in-between. Optimize the tlb
> invalidation condition keeping last_vcpu_on_cpu per logical partition id.
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
> v3:
>  - use existing logic while keeping last_vcpu_per_cpu per lpid
>  
> v2:
>  - improve patch name and description
>  - add performance results
> 
> 
>  arch/powerpc/kvm/e500mc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/e500mc.c b/arch/powerpc/kvm/e500mc.c
> index 17e4562..95e33e3 100644
> --- a/arch/powerpc/kvm/e500mc.c
> +++ b/arch/powerpc/kvm/e500mc.c
> @@ -110,7 +110,7 @@ void kvmppc_mmu_msr_notify(struct kvm_vcpu *vcpu, u32 old_msr)
>  {
>  }
>  
> -static DEFINE_PER_CPU(struct kvm_vcpu *, last_vcpu_on_cpu);
> +static DEFINE_PER_CPU(struct kvm_vcpu * [KVMPPC_NR_LPIDS], last_vcpu_on_cpu);

Hmm, I didn't know you could express types like that.  Is this special
syntax that only works for typeof?

No space after *

Name should be adjusted to match, something like last_vcpu_of_lpid (with
the _on_cpu being implied by the fact that it's PER_CPU).

-Scott
