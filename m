Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x81qH3wD8zDqg2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jul 2017 15:44:58 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6E5hqKS038695
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jul 2017 01:44:55 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bpc2hrrwt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jul 2017 01:44:55 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 14 Jul 2017 15:44:52 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6E5ipBC25297018
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jul 2017 15:44:51 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6E5io6x004749
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jul 2017 15:44:50 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/4] powerpc/mm/radix: Avoid flushing the PWC on every
 flush_tlb_range
In-Reply-To: <20170714015258.7933-3-benh@kernel.crashing.org>
References: <20170714015258.7933-1-benh@kernel.crashing.org>
 <20170714015258.7933-3-benh@kernel.crashing.org>
Date: Fri, 14 Jul 2017 11:14:48 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87y3rrpo6n.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> We do that because it's used by THP pmd collapsing, so use
> instead a dedicated flush function.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  .../powerpc/include/asm/book3s/64/tlbflush-radix.h |  1 +
>  arch/powerpc/mm/pgtable-radix.c                    |  5 ++-
>  arch/powerpc/mm/tlb-radix.c                        | 41 +++++++++++++++++++---
>  3 files changed, 41 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
> index 7196999..9b433a6 100644
> --- a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
> +++ b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
> @@ -36,6 +36,7 @@ extern void radix__flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmad
>  #define radix__flush_tlb_page_psize(mm,addr,p) radix__local_flush_tlb_page_psize(mm,addr,p)
>  #endif
>  extern void radix__flush_tlb_pwc(struct mmu_gather *tlb, unsigned long addr);
> +extern void radix__flush_tlb_collapsed_pmd(struct mm_struct *mm, unsigned long addr);
>  extern void radix__flush_tlb_lpid_va(unsigned long lpid, unsigned long gpa,
>  				     unsigned long page_size);
>  extern void radix__flush_tlb_lpid(unsigned long lpid);
> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> index c28165d..83d70f7 100644
> --- a/arch/powerpc/mm/pgtable-radix.c
> +++ b/arch/powerpc/mm/pgtable-radix.c
> @@ -706,9 +706,12 @@ pmd_t radix__pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long addre
>  	 */
>  	pmd = *pmdp;
>  	pmd_clear(pmdp);
> +
>  	/*FIXME!!  Verify whether we need this kick below */
>  	kick_all_cpus_sync();
> -	flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
> +
> +	radix__flush_tlb_collapsed_pmd(vma->vm_mm, address);
> +
>  	return pmd;
>  }
>
> diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
> index f65c928..73d3fbf 100644
> --- a/arch/powerpc/mm/tlb-radix.c
> +++ b/arch/powerpc/mm/tlb-radix.c
> @@ -267,11 +267,7 @@ void radix__flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
>  {
>  	struct mm_struct *mm = vma->vm_mm;
>
> -	/*
> -	 * This is currently used when collapsing THPs so we need to
> -	 * flush the PWC. We should fix this.
> -	 */
> -	radix__flush_all_mm(mm);
> +	radix__flush_tlb_mm(mm);
>  }
>  EXPORT_SYMBOL(radix__flush_tlb_range);
>
> @@ -350,6 +346,41 @@ void radix__flush_tlb_range_psize(struct mm_struct *mm, unsigned long start,
>  	preempt_enable();
>  }
>
> +void radix__flush_tlb_collapsed_pmd(struct mm_struct *mm, unsigned long addr)
> +{
> +	int local = mm_is_thread_local(mm);
> +	unsigned long ap = mmu_get_ap(mmu_virtual_psize);
> +	unsigned long pid, end;
> +
> +
> +	pid = mm ? mm->context.id : 0;
> +	if (unlikely(pid == MMU_NO_CONTEXT))
> +		goto no_context;
> +
> +	/* 4k page size, just blow the world */
> +	if (PAGE_SIZE == 0x1000) {
> +		radix__flush_all_mm(mm);
> +		return;
> +	}

What is special here ? because it is 4096 tlb flushes ?


> +
> +	/* Otherwise first do the PWC */
> +	if (local)
> +		_tlbiel_pid(pid, RIC_FLUSH_PWC);
> +	else
> +		_tlbie_pid(pid, RIC_FLUSH_PWC);
> +
> +	/* Then iterate the pages */
> +	end = addr + HPAGE_PMD_SIZE;
> +	for (; addr < end; addr += PAGE_SIZE) {
> +		if (local)
> +			_tlbiel_va(addr, pid, ap, RIC_FLUSH_TLB);
> +		else
> +			_tlbie_va(addr, pid, ap, RIC_FLUSH_TLB);
> +	}
> +no_context:
> +	preempt_enable();
> +}
> +
>  void radix__flush_tlb_lpid_va(unsigned long lpid, unsigned long gpa,
>  			      unsigned long page_size)
>  {
> -- 
> 2.9.4
