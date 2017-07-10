Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x5YM16lJTzDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 15:15:25 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6A5DZ9j101073
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 01:15:22 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bjvs2de4p-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 01:15:22 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 10 Jul 2017 15:15:19 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6A5FGXe10223670
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 15:15:16 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6A5FGLo009631
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 15:15:16 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Michael Neuling <michael.neuling@au1.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/mm/radix: Properly clear process table entry
In-Reply-To: <1499517932.3397.22.camel@kernel.crashing.org>
References: <1499517932.3397.22.camel@kernel.crashing.org>
Date: Mon, 10 Jul 2017 10:45:13 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87bmosrhy6.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On radix, the process table entry we want to clear when
> destroying a context is entry 0, not entry 1
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> ---
>  arch/powerpc/mm/mmu_context_book3s64.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
> index 79d8c8a..9404b5e 100644
> --- a/arch/powerpc/mm/mmu_context_book3s64.c
> +++ b/arch/powerpc/mm/mmu_context_book3s64.c
> @@ -226,9 +226,15 @@ void destroy_context(struct mm_struct *mm)
>  	mm->context.cop_lockp = NULL;
>  #endif /* CONFIG_PPC_ICSWX */
>
> -	if (radix_enabled())
> -		process_tb[mm->context.id].prtb1 = 0;
> -	else
> +	if (radix_enabled()) {
> +		/*
> +		 * Radix doesn't have a valid bit in the process table
> +		 * entries. However we know that at least P9 implementation
> +		 * will avoid caching an entry with an invalid RTS field,
> +		 * and 0 is invalid. So this will do.
> +		 */
> +		process_tb[mm->context.id].prtb0 = 0;
> +	} else
>  		subpage_prot_free(mm);
>  	destroy_pagetable_page(mm);
>  	__destroy_context(mm->context.id);
