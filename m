Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH V3 2/2] powerpc,
 perf: BHRB filter configuration should follow the task
In-reply-to: <1370843609-32618-3-git-send-email-khandual@linux.vnet.ibm.com>
References: <1370843609-32618-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1370843609-32618-3-git-send-email-khandual@linux.vnet.ibm.com>
Date: Mon, 24 Jun 2013 17:20:42 +1000
Message-ID: <32432.1372058442@ale.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote:

> When the task moves around the system, the corresponding cpuhw
> per cpu strcuture should be popullated with the BHRB filter
> request value so that PMU could be configured appropriately with
> that during the next call into power_pmu_enable().
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>

benh you might want to fix the spelling mistakes above 

  strcuture -> structure
  popullated -> populated

Otherwise:

Acked-by: Michael Neuling <mikey@neuling.org>


> ---
>  arch/powerpc/perf/core-book3s.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
> index 426180b..48c68a8 100644
> --- a/arch/powerpc/perf/core-book3s.c
> +++ b/arch/powerpc/perf/core-book3s.c
> @@ -1122,8 +1122,11 @@ nocheck:
>  
>  	ret = 0;
>   out:
> -	if (has_branch_stack(event))
> +	if (has_branch_stack(event)) {
>  		power_pmu_bhrb_enable(event);
> +		cpuhw->bhrb_filter = ppmu->bhrb_filter_map(
> +					event->attr.branch_sample_type);
> +	}
>  
>  	perf_pmu_enable(event->pmu);
>  	local_irq_restore(flags);
> -- 
> 1.7.11.7
> 
