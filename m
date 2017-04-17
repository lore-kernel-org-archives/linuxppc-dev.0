Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w5zs20JgZzDqG1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 17:09:09 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3H78pjW024785
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 03:09:00 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29ufp1fav3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 03:09:00 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 17 Apr 2017 17:08:58 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3H78llU3080678
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 17:08:55 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3H78NFQ029720
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 17:08:23 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC][PATCH] powerpc/mm: convert tlbie to tlbiel when no batch is
 active
In-Reply-To: <20170413051655.26113-1-bsingharora@gmail.com>
References: <20170413051655.26113-1-bsingharora@gmail.com>
Date: Mon, 17 Apr 2017 12:37:56 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87fuh7h5pv.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> writes:

> Do the checks that __flush_tlb_pending() does and check if
> a local flush will do when batch->active is false inside of
> hpte_need_flush(). I've checked the changes with tlbie tracing,
> I see local flushes as applicable now and I've also run
> some basic ltp testcases on top of these changes on a powernv
> machine.
>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> ---
>  arch/powerpc/mm/tlb_hash64.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/mm/tlb_hash64.c b/arch/powerpc/mm/tlb_hash64.c
> index 4517aa4..1268e3a 100644
> --- a/arch/powerpc/mm/tlb_hash64.c
> +++ b/arch/powerpc/mm/tlb_hash64.c
> @@ -93,12 +93,17 @@ void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
>  
>  	/*
>  	 * Check if we have an active batch on this CPU. If not, just
> -	 * flush now and return. For now, we don global invalidates
> -	 * in that case, might be worth testing the mm cpu mask though
> -	 * and decide to use local invalidates instead...
> +	 * flush now and return.
>  	 */
>  	if (!batch->active) {
> -		flush_hash_page(vpn, rpte, psize, ssize, 0);
> +		const struct cpumask *tmp;
> +		int local = 0;
> +
> +		tmp = cpumask_of(smp_processor_id());
> +		if (cpumask_equal(mm_cpumask(mm), tmp))
> +			local = 1;
> +
> +		flush_hash_page(vpn, rpte, psize, ssize, local);

Can you use mm_is_thread_local(). Also switch similar open coded paths
when doing that ?


>  		put_cpu_var(ppc64_tlb_batch);
>  		return;
>  	}
> -- 
> 2.9.3

-aneesh
