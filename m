Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yBCpW3gH0zDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 21:22:11 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9AAJsmN072880
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 06:22:08 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dgurr9wpr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 06:22:08 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 10 Oct 2017 06:22:07 -0400
Subject: Re: [PATCH] powerpc/64s/radix: fix preempt imbalance in TLB flush
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20171010101641.5714-1-npiggin@gmail.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 10 Oct 2017 15:52:02 +0530
MIME-Version: 1.0
In-Reply-To: <20171010101641.5714-1-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <d243ba10-5e46-c86a-be89-64737257e903@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 10/10/2017 03:46 PM, Nicholas Piggin wrote:
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   arch/powerpc/mm/tlb-radix.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
> index b3e849c4886e..de414460287a 100644
> --- a/arch/powerpc/mm/tlb-radix.c
> +++ b/arch/powerpc/mm/tlb-radix.c
> @@ -358,7 +358,7 @@ void radix__flush_tlb_collapsed_pmd(struct mm_struct *mm, unsigned long addr)
>   	unsigned long ap = mmu_get_ap(mmu_virtual_psize);
>   	unsigned long pid, end;
> 
> -
> +	preempt_disable();
>   	pid = mm ? mm->context.id : 0;
>   	if (unlikely(pid == MMU_NO_CONTEXT))
>   		goto no_context;
> @@ -366,6 +366,7 @@ void radix__flush_tlb_collapsed_pmd(struct mm_struct *mm, unsigned long addr)
>   	/* 4k page size, just blow the world */
>   	if (PAGE_SIZE == 0x1000) {
>   		radix__flush_all_mm(mm);
> +		preempt_enable();
>   		return;
>   	}
> 

Can't we do a preempt_disable before the if (local) check?. That way we 
don't need that prempt_enable in that PAGE_SIZE==0x1000 path.We already 
do disable/enable correctly in radix__flush_all_mm(mm)

-aneesh
