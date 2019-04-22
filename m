Return-Path: <SRS0=+Gyc=SY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA176C10F11
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 20:28:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C39620859
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 20:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C39620859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nynX1TWkzDq7c
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 06:28:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=jglisse@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nyVn3ZzFzDqLC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 06:15:13 +1000 (AEST)
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0482930832F4;
 Mon, 22 Apr 2019 20:15:11 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C81C71001DED;
 Mon, 22 Apr 2019 20:15:06 +0000 (UTC)
Date: Mon, 22 Apr 2019 16:15:05 -0400
From: Jerome Glisse <jglisse@redhat.com>
To: Laurent Dufour <ldufour@linux.ibm.com>
Subject: Re: [PATCH v12 16/31] mm: introduce __vm_normal_page()
Message-ID: <20190422201504.GG14666@redhat.com>
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
 <20190416134522.17540-17-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190416134522.17540-17-ldufour@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Mon, 22 Apr 2019 20:15:11 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: jack@suse.cz, sergey.senozhatsky.work@gmail.com, peterz@infradead.org,
 Will Deacon <will.deacon@arm.com>, mhocko@kernel.org, linux-mm@kvack.org,
 paulus@samba.org, Punit Agrawal <punitagrawal@gmail.com>, hpa@zytor.com,
 Michel Lespinasse <walken@google.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrea Arcangeli <aarcange@redhat.com>, ak@linux.intel.com,
 Minchan Kim <minchan@kernel.org>, aneesh.kumar@linux.ibm.com, x86@kernel.org,
 Matthew Wilcox <willy@infradead.org>,
 Daniel Jordan <daniel.m.jordan@oracle.com>, Ingo Molnar <mingo@redhat.com>,
 David Rientjes <rientjes@google.com>, paulmck@linux.vnet.ibm.com,
 Haiyan Song <haiyanx.song@intel.com>, npiggin@gmail.com, sj38.park@gmail.com,
 dave@stgolabs.net, kemi.wang@intel.com, kirill@shutemov.name,
 Thomas Gleixner <tglx@linutronix.de>, zhong jiang <zhongjiang@huawei.com>,
 Ganesh Mahendran <opensource.ganesh@gmail.com>,
 Yang Shi <yang.shi@linux.alibaba.com>, Mike Rapoport <rppt@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 vinayak menon <vinayakm.list@gmail.com>, akpm@linux-foundation.org,
 Tim Chen <tim.c.chen@linux.intel.com>, haren@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Apr 16, 2019 at 03:45:07PM +0200, Laurent Dufour wrote:
> When dealing with the speculative fault path we should use the VMA's field
> cached value stored in the vm_fault structure.
> 
> Currently vm_normal_page() is using the pointer to the VMA to fetch the
> vm_flags value. This patch provides a new __vm_normal_page() which is
> receiving the vm_flags flags value as parameter.
> 
> Note: The speculative path is turned on for architecture providing support
> for special PTE flag. So only the first block of vm_normal_page is used
> during the speculative path.
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

> ---
>  include/linux/mm.h | 18 +++++++++++++++---
>  mm/memory.c        | 21 ++++++++++++---------
>  2 files changed, 27 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index f465bb2b049e..f14b2c9ddfd4 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1421,9 +1421,21 @@ static inline void INIT_VMA(struct vm_area_struct *vma)
>  #endif
>  }
>  
> -struct page *_vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
> -			     pte_t pte, bool with_public_device);
> -#define vm_normal_page(vma, addr, pte) _vm_normal_page(vma, addr, pte, false)
> +struct page *__vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
> +			      pte_t pte, bool with_public_device,
> +			      unsigned long vma_flags);
> +static inline struct page *_vm_normal_page(struct vm_area_struct *vma,
> +					    unsigned long addr, pte_t pte,
> +					    bool with_public_device)
> +{
> +	return __vm_normal_page(vma, addr, pte, with_public_device,
> +				vma->vm_flags);
> +}
> +static inline struct page *vm_normal_page(struct vm_area_struct *vma,
> +					  unsigned long addr, pte_t pte)
> +{
> +	return _vm_normal_page(vma, addr, pte, false);
> +}
>  
>  struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
>  				pmd_t pmd);
> diff --git a/mm/memory.c b/mm/memory.c
> index 85ec5ce5c0a8..be93f2c8ebe0 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -533,7 +533,8 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
>  }
>  
>  /*
> - * vm_normal_page -- This function gets the "struct page" associated with a pte.
> + * __vm_normal_page -- This function gets the "struct page" associated with
> + * a pte.
>   *
>   * "Special" mappings do not wish to be associated with a "struct page" (either
>   * it doesn't exist, or it exists but they don't want to touch it). In this
> @@ -574,8 +575,9 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
>   * PFNMAP mappings in order to support COWable mappings.
>   *
>   */
> -struct page *_vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
> -			     pte_t pte, bool with_public_device)
> +struct page *__vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
> +			      pte_t pte, bool with_public_device,
> +			      unsigned long vma_flags)
>  {
>  	unsigned long pfn = pte_pfn(pte);
>  
> @@ -584,7 +586,7 @@ struct page *_vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
>  			goto check_pfn;
>  		if (vma->vm_ops && vma->vm_ops->find_special_page)
>  			return vma->vm_ops->find_special_page(vma, addr);
> -		if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
> +		if (vma_flags & (VM_PFNMAP | VM_MIXEDMAP))
>  			return NULL;
>  		if (is_zero_pfn(pfn))
>  			return NULL;
> @@ -620,8 +622,8 @@ struct page *_vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
>  
>  	/* !CONFIG_ARCH_HAS_PTE_SPECIAL case follows: */
>  
> -	if (unlikely(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP))) {
> -		if (vma->vm_flags & VM_MIXEDMAP) {
> +	if (unlikely(vma_flags & (VM_PFNMAP|VM_MIXEDMAP))) {
> +		if (vma_flags & VM_MIXEDMAP) {
>  			if (!pfn_valid(pfn))
>  				return NULL;
>  			goto out;
> @@ -630,7 +632,7 @@ struct page *_vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
>  			off = (addr - vma->vm_start) >> PAGE_SHIFT;
>  			if (pfn == vma->vm_pgoff + off)
>  				return NULL;
> -			if (!is_cow_mapping(vma->vm_flags))
> +			if (!is_cow_mapping(vma_flags))
>  				return NULL;
>  		}
>  	}
> @@ -2532,7 +2534,8 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  
> -	vmf->page = vm_normal_page(vma, vmf->address, vmf->orig_pte);
> +	vmf->page = __vm_normal_page(vma, vmf->address, vmf->orig_pte, false,
> +				     vmf->vma_flags);
>  	if (!vmf->page) {
>  		/*
>  		 * VM_MIXEDMAP !pfn_valid() case, or VM_SOFTDIRTY clear on a
> @@ -3706,7 +3709,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>  	ptep_modify_prot_commit(vma, vmf->address, vmf->pte, old_pte, pte);
>  	update_mmu_cache(vma, vmf->address, vmf->pte);
>  
> -	page = vm_normal_page(vma, vmf->address, pte);
> +	page = __vm_normal_page(vma, vmf->address, pte, false, vmf->vma_flags);
>  	if (!page) {
>  		pte_unmap_unlock(vmf->pte, vmf->ptl);
>  		return 0;
> -- 
> 2.21.0
> 
