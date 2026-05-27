Return-Path: <linuxppc-dev+bounces-21610-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E678CD5BD0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 19:08:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQfJz3BWtz2yD6;
	Thu, 28 May 2026 05:08:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779908883;
	cv=none; b=mt1+XrXprGi3kREcESVOpq7hIovE6wIXv2VLx+wrK2i9M6jNMW8wGV6/HOxXrVgq6qHLHXyx7sD5h/vHashD0P1nOmAnbF8s4YybZfRmH9wq5Ju7Y1G2plwnAfggV6c0iQtHlO1W1UNNuoxAMhYXY+XM318tbT4PhCnRu0flpeYB1gU43gf14jBvdHlCTC8wvA/VJvk7w9e6lmt4skdvG5s0IbcIVLAsrdupn2vb9Nv1pASRRf2xqDIYwmQkqpRigxic16K//XBxtdAh/oFDRkFQH4yvH7FDjXpxW/A3Th66tonZd+KBbEam4jvhnXm0k6PzaPqo4MX+Il/8VsKGrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779908883; c=relaxed/relaxed;
	bh=cGeamoObf1qbjghhGJkIscnw/Fsp6/UIlrdZOPEQVao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G8gbd2XqolGfoQD611k075DBggks7bxnsE9obkYG+mMxjxYinRxTYhGOpKPrEOruPQe1o4cQEKIG9Q90l21e4NJ0lWymFsh4b0vn7Nt/vW7JA06COug5Rrhe/wwXKaOxYM1tXzWeHnlIg+KC1NH/mvflvlTHK0n8JaJRhYaeQUPMQpIGLeNoukiOqTqMZQBo5cPIjFUJDu4rwXMVaCA23YGI2b0ElM86GpEbF0PqiGA1k5IkZka9Rm8jIIAAE+hwHSGHH5Dqvh3HO+oWeUrI+L0DU5q7ZQPhm/RpFsifO/6KsbJWnjKdS0e318NoOOXzKxs9szDctb6syaa+NP0dyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=lBe3ZX3V; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=dev.jain@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=lBe3ZX3V;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=dev.jain@arm.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 4201 seconds by postgrey-1.37 at boromir; Thu, 28 May 2026 05:08:00 AEST
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQfJw0X8Kz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2026 05:07:58 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B6942C3D;
	Wed, 27 May 2026 05:24:20 -0700 (PDT)
Received: from [10.164.19.7] (unknown [10.164.19.7])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A70A43F905;
	Wed, 27 May 2026 05:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779884665; bh=UotxsZ+zZr/XhydpYBQL8pv0WmoT4CF/hvzZHlKS1wI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lBe3ZX3VofaulxbGxDNMYHhGSvjPT3XdKH4EXZZetS4djxu0JFRfKn/pdasiSVkNW
	 2Nu5MPl/CJbYh+REJ+3ixRKC6FiHTlZ3FU5o3LG8N2CLRJTSRzn8/IxQ9AL2d/C7tr
	 YIEo8Qurl5gJrZCjR8uegmh+i9jLeQziPgLEAD3w=
Message-ID: <38ee9d6e-4331-48b0-82e4-2e6ae0aee705@arm.com>
Date: Wed, 27 May 2026 17:54:05 +0530
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-unstable RFC v4 4/7] mm/huge_memory: refactor
 copy_huge_pmd()
To: Yin Tirui <yintirui@huawei.com>, Andrew Morton
 <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Juergen Gross <jgross@suse.com>, Jonathan Cameron <jic23@kernel.org>,
 Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Peter Xu <peterx@redhat.com>,
 Luiz Capitulino <luizcap@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>, "Liam R . Howlett"
 <liam@infradead.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Anshuman Khandual
 <anshuman.khandual@arm.com>, Rohan McLure <rmclure@linux.ibm.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>, Alistair Popple <apopple@nvidia.com>,
 Andrew Donnellan <andrew+kernel@donnellan.id.au>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, Baoquan He <bhe@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Coiby Xu <coxu@redhat.com>,
 Dan Williams <djbw@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>,
 Lu Baolu <baolu.lu@linux.intel.com>,
 Conor Dooley <conor.dooley@microchip.com>, Rik van Riel <riel@surriel.com>,
 wangkefeng.wang@huawei.com, chenjun102@huawei.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-pm@vger.kernel.org
References: <20260526145003.88445-1-yintirui@huawei.com>
 <20260526145003.88445-5-yintirui@huawei.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20260526145003.88445-5-yintirui@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 26/05/26 8:20 pm, Yin Tirui wrote:
> Classify the source PMD via pmd_present() and vm_normal_folio_pmd(),
> matching the way the PTE path uses pte_present() and vm_normal_page().
> This moves the present-PMD decision from VMA identity checks to the
> actual PMD/folio state.
> 
> Drop the defensive "if (!pmd_trans_huge(pmd)) goto out_unlock" branch:
> with mmap_write_lock held during fork, it should not occur.

Split this from this patch? This is a functional change so will be better
to review it separately.

> 
> Extract the present-PMD side of copy_huge_pmd() into
> copy_present_huge_pmd(). The helper owns the child pgtable passed by the
> caller: it either deposits the pgtable when installing a copied PMD, or
> frees it on paths that do not install one.
> 
> The child pgtable is now allocated once up front and freed on every skip
> path. This makes file/shmem and PFNMAP/special skip paths take the PMD
> locks and free the preallocated pgtable before returning. These are not
> expected to be hot paths, and the PFNMAP case is reused by the follow-up
> PMD PFNMAP copy support.
> 
> Signed-off-by: Yin Tirui <yintirui@huawei.com>
> ---

Since the series is still marked RFC, I think it would be better to send
the refactor patches separately?

>  mm/huge_memory.c | 175 +++++++++++++++++++++++++----------------------
>  1 file changed, 95 insertions(+), 80 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 9832ee910d5e..3964258ff91d 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1879,6 +1879,82 @@ bool touch_pmd(struct vm_area_struct *vma, unsigned long addr,
>  	return false;
>  }
>  
> +static int copy_present_huge_pmd(
> +		struct mm_struct *dst_mm, struct mm_struct *src_mm,
> +		pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
> +		struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
> +		pmd_t pmd, pgtable_t pgtable, bool *need_split)
> +{
> +	struct folio *src_folio;
> +	bool wrprotect = true;
> +
> +	src_folio = vm_normal_folio_pmd(src_vma, addr, pmd);
> +	if (!src_folio) {
> +		/*
> +		 * When page table lock is held, the huge zero pmd should not be
> +		 * under splitting since we don't split the page itself, only pmd to
> +		 * a page table.
> +		 */
> +		if (is_huge_zero_pmd(pmd)) {
> +			/*
> +			 * mm_get_huge_zero_folio() will never allocate a new
> +			 * folio here, since we already have a zero page to
> +			 * copy. It just takes a reference.
> +			 */
> +			mm_get_huge_zero_folio(dst_mm);
> +			goto set_pmd;
> +		}
> +
> +		/*
> +		 * Making sure it's not a CoW VMA with writable
> +		 * mapping, otherwise it means either the anon page wrongly
> +		 * applied special bit, or we made the PRIVATE mapping be
> +		 * able to wrongly write to the backend MMIO.
> +		 */
> +		VM_WARN_ON_ONCE(is_cow_mapping(src_vma->vm_flags) && pmd_write(pmd));
> +		pte_free(dst_mm, pgtable);
> +		pgtable = NULL;
> +		wrprotect = false;
> +		goto set_pmd;
> +	}
> +
> +	/* File THPs are copied lazily by refaulting. */
> +	if (!folio_test_anon(src_folio)) {
> +		pte_free(dst_mm, pgtable);
> +		return 0;
> +	}


You removed !vma_is_anonymous to condense it into !folio_test_anon.
For private-file mappings that is not true, but okay since PMD mapping
is not supported.

> +
> +	folio_get(src_folio);
> +	if (unlikely(folio_try_dup_anon_rmap_pmd(src_folio,
> +							&src_folio->page,
> +							dst_vma, src_vma))) {
> +		/* Page maybe pinned: split and retry the fault on PTEs. */
> +		folio_put(src_folio);
> +		pte_free(dst_mm, pgtable);
> +		*need_split = true;
> +		return -EAGAIN;
> +	}
> +	add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
> +
> +set_pmd:
> +	if (pgtable) {
> +		mm_inc_nr_ptes(dst_mm);
> +		pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
> +	}
> +
> +	if (wrprotect) {
> +		pmdp_set_wrprotect(src_mm, addr, src_pmd);
> +		if (!userfaultfd_wp(dst_vma))
> +			pmd = pmd_clear_uffd_wp(pmd);
> +		pmd = pmd_wrprotect(pmd);
> +	}
> +
> +	pmd = pmd_mkold(pmd);
> +	set_pmd_at(dst_mm, addr, dst_pmd, pmd);
> +
> +	return 0;
> +}
> +
>  static void copy_huge_non_present_pmd(
>  		struct mm_struct *dst_mm, struct mm_struct *src_mm,
>  		pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
> @@ -1940,104 +2016,43 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>  		  struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
>  {
>  	spinlock_t *dst_ptl, *src_ptl;
> -	struct page *src_page;
> -	struct folio *src_folio;
> -	pmd_t pmd;
>  	pgtable_t pgtable = NULL;
> -	int ret = -ENOMEM;
> -
> -	pmd = pmdp_get_lockless(src_pmd);
> -	if (unlikely(pmd_present(pmd) && pmd_special(pmd) &&
> -		     !is_huge_zero_pmd(pmd))) {
> -		dst_ptl = pmd_lock(dst_mm, dst_pmd);
> -		src_ptl = pmd_lockptr(src_mm, src_pmd);
> -		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
> -		/*
> -		 * No need to recheck the pmd, it can't change with write
> -		 * mmap lock held here.
> -		 *
> -		 * Meanwhile, making sure it's not a CoW VMA with writable
> -		 * mapping, otherwise it means either the anon page wrongly
> -		 * applied special bit, or we made the PRIVATE mapping be
> -		 * able to wrongly write to the backend MMIO.
> -		 */
> -		VM_WARN_ON_ONCE(is_cow_mapping(src_vma->vm_flags) && pmd_write(pmd));
> -		goto set_pmd;
> -	}
> -
> -	/* Skip if can be re-fill on fault */
> -	if (!vma_is_anonymous(dst_vma))
> -		return 0;
> +	bool need_split = false;
> +	int ret = 0;
> +	pmd_t pmd;
>  
>  	pgtable = pte_alloc_one(dst_mm);
>  	if (unlikely(!pgtable))
> -		goto out;
> +		return -ENOMEM;
>  
>  	dst_ptl = pmd_lock(dst_mm, dst_pmd);
>  	src_ptl = pmd_lockptr(src_mm, src_pmd);
>  	spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
>  
> -	ret = -EAGAIN;
>  	pmd = *src_pmd;
>  
> -	if (unlikely(thp_migration_supported() &&
> -		     pmd_is_valid_softleaf(pmd))) {
> -		copy_huge_non_present_pmd(dst_mm, src_mm, dst_pmd, src_pmd, addr,
> +	if (likely(pmd_present(pmd))) {
> +		ret = copy_present_huge_pmd(dst_mm, src_mm, dst_pmd, src_pmd, addr,
> +					  dst_vma, src_vma, pmd, pgtable, &need_split);
> +	} else if (unlikely(thp_migration_supported() && pmd_is_valid_softleaf(pmd))) {
> +		if (unlikely(!vma_is_anonymous(dst_vma)))
> +			pte_free(dst_mm, pgtable);
> +		else
> +			copy_huge_non_present_pmd(dst_mm, src_mm, dst_pmd, src_pmd, addr,
>  					  dst_vma, src_vma, pmd, pgtable);
> -		ret = 0;
> -		goto out_unlock;
> -	}
> -
> -	if (unlikely(!pmd_trans_huge(pmd))) {
> +	} else {
> +		VM_WARN_ONCE(1, "unexpected non-present PMD %llx\n",
> +				(unsigned long long)pmd_val(pmd));
>  		pte_free(dst_mm, pgtable);
> -		goto out_unlock;
> -	}
> -	/*
> -	 * When page table lock is held, the huge zero pmd should not be
> -	 * under splitting since we don't split the page itself, only pmd to
> -	 * a page table.
> -	 */
> -	if (is_huge_zero_pmd(pmd)) {
> -		/*
> -		 * mm_get_huge_zero_folio() will never allocate a new
> -		 * folio here, since we already have a zero page to
> -		 * copy. It just takes a reference.
> -		 */
> -		mm_get_huge_zero_folio(dst_mm);
> -		goto out_zero_page;
> +		ret = -EAGAIN;
>  	}
>  
> -	src_page = pmd_page(pmd);
> -	VM_BUG_ON_PAGE(!PageHead(src_page), src_page);
> -	src_folio = page_folio(src_page);
> +	spin_unlock(src_ptl);
> +	spin_unlock(dst_ptl);
>  
> -	folio_get(src_folio);
> -	if (unlikely(folio_try_dup_anon_rmap_pmd(src_folio, src_page, dst_vma, src_vma))) {
> -		/* Page maybe pinned: split and retry the fault on PTEs. */
> -		folio_put(src_folio);
> -		pte_free(dst_mm, pgtable);
> -		spin_unlock(src_ptl);
> -		spin_unlock(dst_ptl);
> +	if (unlikely(need_split))
>  		__split_huge_pmd(src_vma, src_pmd, addr, false);
> -		return -EAGAIN;
> -	}
> -	add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
> -out_zero_page:
> -	mm_inc_nr_ptes(dst_mm);
> -	pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
> -	pmdp_set_wrprotect(src_mm, addr, src_pmd);
> -	if (!userfaultfd_wp(dst_vma))
> -		pmd = pmd_clear_uffd_wp(pmd);
> -	pmd = pmd_wrprotect(pmd);
> -set_pmd:
> -	pmd = pmd_mkold(pmd);
> -	set_pmd_at(dst_mm, addr, dst_pmd, pmd);
>  
> -	ret = 0;
> -out_unlock:
> -	spin_unlock(src_ptl);
> -	spin_unlock(dst_ptl);
> -out:
>  	return ret;
>  }
>  


