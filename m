Return-Path: <SRS0=+Gyc=SY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6B6C10F11
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 20:19:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F12F920675
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 20:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F12F920675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nybc2Y0lzDqM2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 06:19:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=jglisse@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nyKN5vbKzDqH4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 06:07:02 +1000 (AEST)
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 153B5307D84D;
 Mon, 22 Apr 2019 20:07:00 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 05CC860142;
 Mon, 22 Apr 2019 20:06:55 +0000 (UTC)
Date: Mon, 22 Apr 2019 16:06:54 -0400
From: Jerome Glisse <jglisse@redhat.com>
To: Laurent Dufour <ldufour@linux.ibm.com>
Subject: Re: [PATCH v12 13/31] mm: cache some VMA fields in the vm_fault
 structure
Message-ID: <20190422200654.GD14666@redhat.com>
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
 <20190416134522.17540-14-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190416134522.17540-14-ldufour@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Mon, 22 Apr 2019 20:07:00 +0000 (UTC)
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

On Tue, Apr 16, 2019 at 03:45:04PM +0200, Laurent Dufour wrote:
> When handling speculative page fault, the vma->vm_flags and
> vma->vm_page_prot fields are read once the page table lock is released. So
> there is no more guarantee that these fields would not change in our back.
> They will be saved in the vm_fault structure before the VMA is checked for
> changes.
> 
> In the detail, when we deal with a speculative page fault, the mmap_sem is
> not taken, so parallel VMA's changes can occurred. When a VMA change is
> done which will impact the page fault processing, we assumed that the VMA
> sequence counter will be changed.  In the page fault processing, at the
> time the PTE is locked, we checked the VMA sequence counter to detect
> changes done in our back. If no change is detected we can continue further.
> But this doesn't prevent the VMA to not be changed in our back while the
> PTE is locked. So VMA's fields which are used while the PTE is locked must
> be saved to ensure that we are using *static* values.  This is important
> since the PTE changes will be made on regards to these VMA fields and they
> need to be consistent. This concerns the vma->vm_flags and
> vma->vm_page_prot VMA fields.
> 
> This patch also set the fields in hugetlb_no_page() and
> __collapse_huge_page_swapin even if it is not need for the callee.
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>

I am unsure about something see below, so you might need to update
that one but it would not change the structure of the patch thus:

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

> ---
>  include/linux/mm.h | 10 +++++++--
>  mm/huge_memory.c   |  6 +++---
>  mm/hugetlb.c       |  2 ++
>  mm/khugepaged.c    |  2 ++
>  mm/memory.c        | 53 ++++++++++++++++++++++++----------------------
>  mm/migrate.c       |  2 +-
>  6 files changed, 44 insertions(+), 31 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 5d45b7d8718d..f465bb2b049e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -439,6 +439,12 @@ struct vm_fault {
>  					 * page table to avoid allocation from
>  					 * atomic context.
>  					 */
> +	/*
> +	 * These entries are required when handling speculative page fault.
> +	 * This way the page handling is done using consistent field values.
> +	 */
> +	unsigned long vma_flags;
> +	pgprot_t vma_page_prot;
>  };
>  
>  /* page entry size for vm->huge_fault() */
> @@ -781,9 +787,9 @@ void free_compound_page(struct page *page);
>   * pte_mkwrite.  But get_user_pages can cause write faults for mappings
>   * that do not have writing enabled, when used by access_process_vm.
>   */
> -static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
> +static inline pte_t maybe_mkwrite(pte_t pte, unsigned long vma_flags)
>  {
> -	if (likely(vma->vm_flags & VM_WRITE))
> +	if (likely(vma_flags & VM_WRITE))
>  		pte = pte_mkwrite(pte);
>  	return pte;
>  }
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 823688414d27..865886a689ee 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1244,8 +1244,8 @@ static vm_fault_t do_huge_pmd_wp_page_fallback(struct vm_fault *vmf,
>  
>  	for (i = 0; i < HPAGE_PMD_NR; i++, haddr += PAGE_SIZE) {
>  		pte_t entry;
> -		entry = mk_pte(pages[i], vma->vm_page_prot);
> -		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
> +		entry = mk_pte(pages[i], vmf->vma_page_prot);
> +		entry = maybe_mkwrite(pte_mkdirty(entry), vmf->vma_flags);
>  		memcg = (void *)page_private(pages[i]);
>  		set_page_private(pages[i], 0);
>  		page_add_new_anon_rmap(pages[i], vmf->vma, haddr, false);
> @@ -2228,7 +2228,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>  				entry = pte_swp_mksoft_dirty(entry);
>  		} else {
>  			entry = mk_pte(page + i, READ_ONCE(vma->vm_page_prot));
> -			entry = maybe_mkwrite(entry, vma);
> +			entry = maybe_mkwrite(entry, vma->vm_flags);
>  			if (!write)
>  				entry = pte_wrprotect(entry);
>  			if (!young)
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 109f5de82910..13246da4bc50 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3812,6 +3812,8 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>  				.vma = vma,
>  				.address = haddr,
>  				.flags = flags,
> +				.vma_flags = vma->vm_flags,
> +				.vma_page_prot = vma->vm_page_prot,

Shouldn't you use READ_ONCE ? I doubt compiler will do something creative
with struct initialization but as you are using WRITE_ONCE to update those
fields maybe pairing read with READ_ONCE where the mmap_sem is not always
taken might make sense.

>  				/*
>  				 * Hard to debug if it ends up being
>  				 * used by a callee that assumes
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 6a0cbca3885e..42469037240a 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -888,6 +888,8 @@ static bool __collapse_huge_page_swapin(struct mm_struct *mm,
>  		.flags = FAULT_FLAG_ALLOW_RETRY,
>  		.pmd = pmd,
>  		.pgoff = linear_page_index(vma, address),
> +		.vma_flags = vma->vm_flags,
> +		.vma_page_prot = vma->vm_page_prot,

Same as above.

[...]

>  	return VM_FAULT_FALLBACK;
> @@ -3924,6 +3925,8 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
>  		.flags = flags,
>  		.pgoff = linear_page_index(vma, address),
>  		.gfp_mask = __get_fault_gfp_mask(vma),
> +		.vma_flags = vma->vm_flags,
> +		.vma_page_prot = vma->vm_page_prot,

Same as above

>  	};
>  	unsigned int dirty = flags & FAULT_FLAG_WRITE;
>  	struct mm_struct *mm = vma->vm_mm;
> diff --git a/mm/migrate.c b/mm/migrate.c
> index f2ecc2855a12..a9138093a8e2 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -240,7 +240,7 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
>  		 */
>  		entry = pte_to_swp_entry(*pvmw.pte);
>  		if (is_write_migration_entry(entry))
> -			pte = maybe_mkwrite(pte, vma);
> +			pte = maybe_mkwrite(pte, vma->vm_flags);
>  
>  		if (unlikely(is_zone_device_page(new))) {
>  			if (is_device_private_page(new)) {
> -- 
> 2.21.0
> 
