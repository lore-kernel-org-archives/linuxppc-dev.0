Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 560041A02C2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2015 15:15:30 +1000 (AEST)
In-Reply-To: <1435652431-22024-4-git-send-email-khandual@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, sukadev@linux.vnet.ibm.com, dja@axtens.net
Subject: Re: [3/5] powerpc/perf: Replace last usage of get_cpu_var with
 this_cpu_ptr
Message-Id: <20150727051530.325AE1402C6@ozlabs.org>
Date: Mon, 27 Jul 2015 15:15:30 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-30-06 at 08:20:29 UTC, Anshuman Khandual wrote:
> The commit 69111bac42f5ce ("powerpc: Replace __get_cpu_var uses")
> replaced all usage of get_cpu_var with this_cpu_ptr inside core
> perf event handling on powerpc. But it skipped one of them which
> is being replaced with this patch.

No it replaced all uses of __get_cpu_var(), not get_cpu_var(). The difference
is important.

get_cpu_var() disables preemption for you, so it's only safe to switch to
this_cpu_ptr() if preemption is already disabled. Is it?

cheers

> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
> index f9ecd93..57f2c78 100644
> --- a/arch/powerpc/perf/core-book3s.c
> +++ b/arch/powerpc/perf/core-book3s.c
> @@ -1840,20 +1840,17 @@ static int power_pmu_event_init(struct perf_event *event)
>  	if (check_excludes(ctrs, cflags, n, 1))
>  		return -EINVAL;
>  
> -	cpuhw = &get_cpu_var(cpu_hw_events);
> +	cpuhw = this_cpu_ptr(&cpu_hw_events);
>  	err = power_check_constraints(cpuhw, events, cflags, n + 1);
>  
>  	if (has_branch_stack(event)) {
>  		cpuhw->bhrb_filter = ppmu->bhrb_filter_map(
>  					event->attr.branch_sample_type);
>  
> -		if (cpuhw->bhrb_filter == -1) {
> -			put_cpu_var(cpu_hw_events);
> +		if (cpuhw->bhrb_filter == -1)
>  			return -EOPNOTSUPP;
> -		}
>  	}
>  
> -	put_cpu_var(cpu_hw_events);
>  	if (err)
>  		return -EINVAL;
