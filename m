Return-Path: <SRS0=+Gyc=SY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFA9C10F11
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 20:26:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BAA220693
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 20:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BAA220693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nylt3xDTzDqMs
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 06:26:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=jglisse@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nyQZ2vTpzDqKb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 06:11:34 +1000 (AEST)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3F1AFC13070F;
 Mon, 22 Apr 2019 20:11:32 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B7F05D9D4;
 Mon, 22 Apr 2019 20:11:28 +0000 (UTC)
Date: Mon, 22 Apr 2019 16:11:26 -0400
From: Jerome Glisse <jglisse@redhat.com>
To: Laurent Dufour <ldufour@linux.ibm.com>
Subject: Re: [PATCH v12 15/31] mm: introduce
 __lru_cache_add_active_or_unevictable
Message-ID: <20190422201126.GF14666@redhat.com>
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
 <20190416134522.17540-16-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190416134522.17540-16-ldufour@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Mon, 22 Apr 2019 20:11:32 +0000 (UTC)
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

On Tue, Apr 16, 2019 at 03:45:06PM +0200, Laurent Dufour wrote:
> The speculative page fault handler which is run without holding the
> mmap_sem is calling lru_cache_add_active_or_unevictable() but the vm_flags
> is not guaranteed to remain constant.
> Introducing __lru_cache_add_active_or_unevictable() which has the vma flags
> value parameter instead of the vma pointer.
> 
> Acked-by: David Rientjes <rientjes@google.com>
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

> ---
>  include/linux/swap.h | 10 ++++++++--
>  mm/memory.c          |  8 ++++----
>  mm/swap.c            |  6 +++---
>  3 files changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 4bfb5c4ac108..d33b94eb3c69 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -343,8 +343,14 @@ extern void deactivate_file_page(struct page *page);
>  extern void mark_page_lazyfree(struct page *page);
>  extern void swap_setup(void);
>  
> -extern void lru_cache_add_active_or_unevictable(struct page *page,
> -						struct vm_area_struct *vma);
> +extern void __lru_cache_add_active_or_unevictable(struct page *page,
> +						unsigned long vma_flags);
> +
> +static inline void lru_cache_add_active_or_unevictable(struct page *page,
> +						struct vm_area_struct *vma)
> +{
> +	return __lru_cache_add_active_or_unevictable(page, vma->vm_flags);
> +}
>  
>  /* linux/mm/vmscan.c */
>  extern unsigned long zone_reclaimable_pages(struct zone *zone);
> diff --git a/mm/memory.c b/mm/memory.c
> index 56802850e72c..85ec5ce5c0a8 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2347,7 +2347,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>  		ptep_clear_flush_notify(vma, vmf->address, vmf->pte);
>  		page_add_new_anon_rmap(new_page, vma, vmf->address, false);
>  		mem_cgroup_commit_charge(new_page, memcg, false, false);
> -		lru_cache_add_active_or_unevictable(new_page, vma);
> +		__lru_cache_add_active_or_unevictable(new_page, vmf->vma_flags);
>  		/*
>  		 * We call the notify macro here because, when using secondary
>  		 * mmu page tables (such as kvm shadow page tables), we want the
> @@ -2896,7 +2896,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	if (unlikely(page != swapcache && swapcache)) {
>  		page_add_new_anon_rmap(page, vma, vmf->address, false);
>  		mem_cgroup_commit_charge(page, memcg, false, false);
> -		lru_cache_add_active_or_unevictable(page, vma);
> +		__lru_cache_add_active_or_unevictable(page, vmf->vma_flags);
>  	} else {
>  		do_page_add_anon_rmap(page, vma, vmf->address, exclusive);
>  		mem_cgroup_commit_charge(page, memcg, true, false);
> @@ -3048,7 +3048,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>  	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
>  	page_add_new_anon_rmap(page, vma, vmf->address, false);
>  	mem_cgroup_commit_charge(page, memcg, false, false);
> -	lru_cache_add_active_or_unevictable(page, vma);
> +	__lru_cache_add_active_or_unevictable(page, vmf->vma_flags);
>  setpte:
>  	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
>  
> @@ -3327,7 +3327,7 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct mem_cgroup *memcg,
>  		inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
>  		page_add_new_anon_rmap(page, vma, vmf->address, false);
>  		mem_cgroup_commit_charge(page, memcg, false, false);
> -		lru_cache_add_active_or_unevictable(page, vma);
> +		__lru_cache_add_active_or_unevictable(page, vmf->vma_flags);
>  	} else {
>  		inc_mm_counter_fast(vma->vm_mm, mm_counter_file(page));
>  		page_add_file_rmap(page, false);
> diff --git a/mm/swap.c b/mm/swap.c
> index 3a75722e68a9..a55f0505b563 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -450,12 +450,12 @@ void lru_cache_add(struct page *page)
>   * directly back onto it's zone's unevictable list, it does NOT use a
>   * per cpu pagevec.
>   */
> -void lru_cache_add_active_or_unevictable(struct page *page,
> -					 struct vm_area_struct *vma)
> +void __lru_cache_add_active_or_unevictable(struct page *page,
> +					   unsigned long vma_flags)
>  {
>  	VM_BUG_ON_PAGE(PageLRU(page), page);
>  
> -	if (likely((vma->vm_flags & (VM_LOCKED | VM_SPECIAL)) != VM_LOCKED))
> +	if (likely((vma_flags & (VM_LOCKED | VM_SPECIAL)) != VM_LOCKED))
>  		SetPageActive(page);
>  	else if (!TestSetPageMlocked(page)) {
>  		/*
> -- 
> 2.21.0
> 
