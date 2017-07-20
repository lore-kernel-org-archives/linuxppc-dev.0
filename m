Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xCdjT1jb3zDrFh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 12:52:28 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6K2mbdZ095957
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 22:52:26 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2btcceykx8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 22:52:26 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 20 Jul 2017 12:52:23 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6K2qLX927000884
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 12:52:21 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6K2qDqv011397
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 12:52:13 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/4] powerpc/mm/radix: Improve TLB/PWC flushes
In-Reply-To: <20170719044907.21703-2-benh@kernel.crashing.org>
References: <20170719044907.21703-1-benh@kernel.crashing.org>
 <20170719044907.21703-2-benh@kernel.crashing.org>
Date: Thu, 20 Jul 2017 08:22:14 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87lgnjrfa9.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> At the moment we have to rather sub-optimal flushing behaviours:
>
>  - flush_tlb_mm() will flush the PWC which is unnecessary (for example
>    when doing a fork)
>
>  - A large unmap will call flush_tlb_pwc() multiple times causing us
>    to perform that fairly expensive operation repeatedly. This happens
>    often in batches of 3 on every new process.
>
> So we change flush_tlb_mm() to only flush the TLB, and we use the
> existing "need_flush_all" flag in struct mmu_gather to indicate
> that the PWC needs flushing.
>
> Unfortunately, flush_tlb_range() still needs to do a full flush
> for now as it's used by the THP collapsing. We will fix that later.
>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  .../powerpc/include/asm/book3s/64/tlbflush-radix.h |  4 +-
>  arch/powerpc/mm/tlb-radix.c                        | 66 +++++++++-------------
>  2 files changed, 28 insertions(+), 42 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
> index cc7fbde4f53c..7196999cdc82 100644
> --- a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
> +++ b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
> @@ -22,22 +22,20 @@ extern void radix__flush_tlb_kernel_range(unsigned long start, unsigned long end
>
>  extern void radix__local_flush_tlb_mm(struct mm_struct *mm);
>  extern void radix__local_flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
> -extern void radix__local_flush_tlb_pwc(struct mmu_gather *tlb, unsigned long addr);
>  extern void radix__local_flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmaddr,
>  					      int psize);
>  extern void radix__tlb_flush(struct mmu_gather *tlb);
>  #ifdef CONFIG_SMP
>  extern void radix__flush_tlb_mm(struct mm_struct *mm);
>  extern void radix__flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
> -extern void radix__flush_tlb_pwc(struct mmu_gather *tlb, unsigned long addr);
>  extern void radix__flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmaddr,
>  					int psize);
>  #else
>  #define radix__flush_tlb_mm(mm)		radix__local_flush_tlb_mm(mm)
>  #define radix__flush_tlb_page(vma,addr)	radix__local_flush_tlb_page(vma,addr)
>  #define radix__flush_tlb_page_psize(mm,addr,p) radix__local_flush_tlb_page_psize(mm,addr,p)
> -#define radix__flush_tlb_pwc(tlb, addr)	radix__local_flush_tlb_pwc(tlb, addr)
>  #endif
> +extern void radix__flush_tlb_pwc(struct mmu_gather *tlb, unsigned long addr);
>  extern void radix__flush_tlb_lpid_va(unsigned long lpid, unsigned long gpa,
>  				     unsigned long page_size);
>  extern void radix__flush_tlb_lpid(unsigned long lpid);
> diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
> index 2f2967a2db93..28f339cdd836 100644
> --- a/arch/powerpc/mm/tlb-radix.c
> +++ b/arch/powerpc/mm/tlb-radix.c
> @@ -68,17 +68,6 @@ static inline void _tlbiel_pid(unsigned long pid, unsigned long ric)
>  	asm volatile(PPC_INVALIDATE_ERAT "; isync" : : :"memory");
>  }
>
> -static inline void tlbiel_pwc(unsigned long pid)
> -{
> -	asm volatile("ptesync": : :"memory");
> -
> -	/* For PWC flush, we don't look at set number */
> -	__tlbiel_pid(pid, 0, RIC_FLUSH_PWC);
> -
> -	asm volatile("ptesync": : :"memory");
> -	asm volatile(PPC_INVALIDATE_ERAT "; isync" : : :"memory");
> -}
> -
>  static inline void _tlbie_pid(unsigned long pid, unsigned long ric)
>  {
>  	unsigned long rb,rs,prs,r;
> @@ -149,31 +138,23 @@ void radix__local_flush_tlb_mm(struct mm_struct *mm)
>  	preempt_disable();
>  	pid = mm->context.id;
>  	if (pid != MMU_NO_CONTEXT)
> -		_tlbiel_pid(pid, RIC_FLUSH_ALL);
> +		_tlbiel_pid(pid, RIC_FLUSH_TLB);
>  	preempt_enable();
>  }
>  EXPORT_SYMBOL(radix__local_flush_tlb_mm);
>
> -void radix__local_flush_tlb_pwc(struct mmu_gather *tlb, unsigned long addr)
> +#ifndef CONFIG_SMP
> +static void radix__local_flush_all_mm(struct mm_struct *mm)
>  {
>  	unsigned long pid;
> -	struct mm_struct *mm = tlb->mm;
> -	/*
> -	 * If we are doing a full mm flush, we will do a tlb flush
> -	 * with RIC_FLUSH_ALL later.
> -	 */
> -	if (tlb->fullmm)
> -		return;
>
>  	preempt_disable();
> -
>  	pid = mm->context.id;
>  	if (pid != MMU_NO_CONTEXT)
> -		tlbiel_pwc(pid);
> -
> +		_tlbiel_pid(pid, RIC_FLUSH_ALL);
>  	preempt_enable();
>  }
> -EXPORT_SYMBOL(radix__local_flush_tlb_pwc);
> +#endif /* CONFIG_SMP */
>
>  void radix__local_flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmaddr,
>  				       int psize)
> @@ -211,38 +192,35 @@ void radix__flush_tlb_mm(struct mm_struct *mm)
>  		goto no_context;
>
>  	if (!mm_is_thread_local(mm))
> -		_tlbie_pid(pid, RIC_FLUSH_ALL);
> +		_tlbie_pid(pid, RIC_FLUSH_TLB);
>  	else
> -		_tlbiel_pid(pid, RIC_FLUSH_ALL);
> +		_tlbiel_pid(pid, RIC_FLUSH_TLB);
>  no_context:
>  	preempt_enable();
>  }
>  EXPORT_SYMBOL(radix__flush_tlb_mm);
>
> -void radix__flush_tlb_pwc(struct mmu_gather *tlb, unsigned long addr)
> +static void radix__flush_all_mm(struct mm_struct *mm)
>  {
>  	unsigned long pid;
> -	struct mm_struct *mm = tlb->mm;
>
> -	/*
> -	 * If we are doing a full mm flush, we will do a tlb flush
> -	 * with RIC_FLUSH_ALL later.
> -	 */
> -	if (tlb->fullmm)
> -		return;
>  	preempt_disable();
> -
>  	pid = mm->context.id;
>  	if (unlikely(pid == MMU_NO_CONTEXT))
>  		goto no_context;
>
>  	if (!mm_is_thread_local(mm))
> -		_tlbie_pid(pid, RIC_FLUSH_PWC);
> +		_tlbie_pid(pid, RIC_FLUSH_ALL);
>  	else
> -		tlbiel_pwc(pid);
> +		_tlbiel_pid(pid, RIC_FLUSH_ALL);
>  no_context:
>  	preempt_enable();
>  }
> +
> +void radix__flush_tlb_pwc(struct mmu_gather *tlb, unsigned long addr)
> +{
> +	tlb->need_flush_all = 1;
> +}
>  EXPORT_SYMBOL(radix__flush_tlb_pwc);
>
>  void radix__flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmaddr,
> @@ -274,6 +252,8 @@ void radix__flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
>  }
>  EXPORT_SYMBOL(radix__flush_tlb_page);
>
> +#else /* CONFIG_SMP */
> +#define radix__flush_all_mm radix__local_flush_all_mm
>  #endif /* CONFIG_SMP */
>
>  void radix__flush_tlb_kernel_range(unsigned long start, unsigned long end)
> @@ -291,7 +271,12 @@ void radix__flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
>
>  {
>  	struct mm_struct *mm = vma->vm_mm;
> -	radix__flush_tlb_mm(mm);
> +
> +	/*
> +	 * This is currently used when collapsing THPs so we need to
> +	 * flush the PWC. We should fix this.
> +	 */
> +	radix__flush_all_mm(mm);
>  }
>  EXPORT_SYMBOL(radix__flush_tlb_range);
>
> @@ -322,7 +307,10 @@ void radix__tlb_flush(struct mmu_gather *tlb)
>  	 */
>  	if (psize != -1 && !tlb->fullmm && !tlb->need_flush_all)
>  		radix__flush_tlb_range_psize(mm, tlb->start, tlb->end, psize);
> -	else
> +	else if (tlb->need_flush_all) {
> +		tlb->need_flush_all = 0;
> +		radix__flush_all_mm(mm);
> +	} else
>  		radix__flush_tlb_mm(mm);
>  }
>
> -- 
> 2.13.3
