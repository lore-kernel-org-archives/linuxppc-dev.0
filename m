Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bFPB55hPzDrHr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 22:47:26 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6PCjuMO079308
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 08:47:23 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kesg7g23p-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 08:47:23 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 25 Jul 2018 13:47:21 +0100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/64s: free page table caches at exit_mmap time
In-Reply-To: <20180725095428.22561-1-npiggin@gmail.com>
References: <20180725095428.22561-1-npiggin@gmail.com>
Date: Wed, 25 Jul 2018 18:17:17 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87r2jrv5wq.fsf@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> The kernel page table caches are tied to init_mm, so there is no
> more need for them after userspace is finished.
>

The commit message could be improved with reference to active_mm.

something like?

destroy_context get called when we drop the last reference for mm which
could be much later than the task exit due to other lazy mm reference to
it. We could free the page table cache pages on task exit because they
only cache the userspace page table and kernel thread should not access
the user space address.

The mapping for kernel threads itself is maintained in init_mm and page
table cache for that is attached to init_mm

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/mm/mmu_context_book3s64.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
> index 3bb5cec03d1f..5738c2db751c 100644
> --- a/arch/powerpc/mm/mmu_context_book3s64.c
> +++ b/arch/powerpc/mm/mmu_context_book3s64.c
> @@ -221,7 +221,7 @@ static void pmd_frag_destroy(void *pmd_frag)
>  	}
>  }
>  
> -static void destroy_pagetable_page(struct mm_struct *mm)
> +static void destroy_pagetable_cache(struct mm_struct *mm)
>  {
>  	void *frag;
>  
> @@ -244,13 +244,14 @@ void destroy_context(struct mm_struct *mm)
>  		WARN_ON(process_tb[mm->context.id].prtb0 != 0);
>  	else
>  		subpage_prot_free(mm);
> -	destroy_pagetable_page(mm);
>  	destroy_contexts(&mm->context);
>  	mm->context.id = MMU_NO_CONTEXT;
>  }
>  
>  void arch_exit_mmap(struct mm_struct *mm)
>  {
> +	destroy_pagetable_cache(mm);
> +
>  	if (radix_enabled()) {
>  		/*
>  		 * Radix doesn't have a valid bit in the process table
> -- 
> 2.17.0
