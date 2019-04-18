Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFF4C10F14
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 22:50:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9D4020693
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 22:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9D4020693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lZ7p0LhfzDqVl
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 08:50:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=jglisse@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lZ6F0ZXCzDqRx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2019 08:49:06 +1000 (AEST)
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 766808665A;
 Thu, 18 Apr 2019 22:49:03 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 344A1600C5;
 Thu, 18 Apr 2019 22:48:59 +0000 (UTC)
Date: Thu, 18 Apr 2019 18:48:57 -0400
From: Jerome Glisse <jglisse@redhat.com>
To: Laurent Dufour <ldufour@linux.ibm.com>
Subject: Re: [PATCH v12 09/31] mm: VMA sequence count
Message-ID: <20190418224857.GI11645@redhat.com>
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
 <20190416134522.17540-10-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190416134522.17540-10-ldufour@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Thu, 18 Apr 2019 22:49:04 +0000 (UTC)
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

On Tue, Apr 16, 2019 at 03:45:00PM +0200, Laurent Dufour wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Wrap the VMA modifications (vma_adjust/unmap_page_range) with sequence
> counts such that we can easily test if a VMA is changed.
> 
> The calls to vm_write_begin/end() in unmap_page_range() are
> used to detect when a VMA is being unmap and thus that new page fault
> should not be satisfied for this VMA. If the seqcount hasn't changed when
> the page table are locked, this means we are safe to satisfy the page
> fault.
> 
> The flip side is that we cannot distinguish between a vma_adjust() and
> the unmap_page_range() -- where with the former we could have
> re-checked the vma bounds against the address.
> 
> The VMA's sequence counter is also used to detect change to various VMA's
> fields used during the page fault handling, such as:
>  - vm_start, vm_end
>  - vm_pgoff
>  - vm_flags, vm_page_prot
>  - vm_policy

^ All above are under mmap write lock ?

>  - anon_vma

^ This is either under mmap write lock or under page table lock

So my question is do we need the complexity of seqcount_t for this ?

It seems that using regular int as counter and also relying on vm_flags
when vma is unmap should do the trick.

vma_delete(struct vm_area_struct *vma)
{
    ...
    /*
     * Make sure the vma is mark as invalid ie neither read nor write
     * so that speculative fault back off. A racing speculative fault
     * will either see the flags as 0 or the new seqcount.
     */
    vma->vm_flags = 0;
    smp_wmb();
    vma->seqcount++;
    ...
}

Then:
speculative_fault_begin(struct vm_area_struct *vma,
                        struct spec_vmf *spvmf)
{
    ...
    spvmf->seqcount = vma->seqcount;
    smp_rmb();
    spvmf->vm_flags = vma->vm_flags;
    if (!spvmf->vm_flags) {
        // Back off the vma is dying ...
        ...
    }
}

bool speculative_fault_commit(struct vm_area_struct *vma,
                              struct spec_vmf *spvmf)
{
    ...
    seqcount = vma->seqcount;
    smp_rmb();
    vm_flags = vma->vm_flags;

    if (spvmf->vm_flags != vm_flags || seqcount != spvmf->seqcount) {
        // Something did change for the vma
        return false;
    }
    return true;
}

This would also avoid the lockdep issue described below. But maybe what
i propose is stupid and i will see it after further reviewing thing.


Cheers,
Jérôme


> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> [Port to 4.12 kernel]
> [Build depends on CONFIG_SPECULATIVE_PAGE_FAULT]
> [Introduce vm_write_* inline function depending on
>  CONFIG_SPECULATIVE_PAGE_FAULT]
> [Fix lock dependency between mapping->i_mmap_rwsem and vma->vm_sequence by
>  using vm_raw_write* functions]
> [Fix a lock dependency warning in mmap_region() when entering the error
>  path]
> [move sequence initialisation INIT_VMA()]
> [Review the patch description about unmap_page_range()]
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
> ---
>  include/linux/mm.h       | 44 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/mm_types.h |  3 +++
>  mm/memory.c              |  2 ++
>  mm/mmap.c                | 30 +++++++++++++++++++++++++++
>  4 files changed, 79 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 2ceb1d2869a6..906b9e06f18e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1410,6 +1410,9 @@ struct zap_details {
>  static inline void INIT_VMA(struct vm_area_struct *vma)
>  {
>  	INIT_LIST_HEAD(&vma->anon_vma_chain);
> +#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
> +	seqcount_init(&vma->vm_sequence);
> +#endif
>  }
>  
>  struct page *_vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
> @@ -1534,6 +1537,47 @@ static inline void unmap_shared_mapping_range(struct address_space *mapping,
>  	unmap_mapping_range(mapping, holebegin, holelen, 0);
>  }
>  
> +#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
> +static inline void vm_write_begin(struct vm_area_struct *vma)
> +{
> +	write_seqcount_begin(&vma->vm_sequence);
> +}
> +static inline void vm_write_begin_nested(struct vm_area_struct *vma,
> +					 int subclass)
> +{
> +	write_seqcount_begin_nested(&vma->vm_sequence, subclass);
> +}
> +static inline void vm_write_end(struct vm_area_struct *vma)
> +{
> +	write_seqcount_end(&vma->vm_sequence);
> +}
> +static inline void vm_raw_write_begin(struct vm_area_struct *vma)
> +{
> +	raw_write_seqcount_begin(&vma->vm_sequence);
> +}
> +static inline void vm_raw_write_end(struct vm_area_struct *vma)
> +{
> +	raw_write_seqcount_end(&vma->vm_sequence);
> +}
> +#else
> +static inline void vm_write_begin(struct vm_area_struct *vma)
> +{
> +}
> +static inline void vm_write_begin_nested(struct vm_area_struct *vma,
> +					 int subclass)
> +{
> +}
> +static inline void vm_write_end(struct vm_area_struct *vma)
> +{
> +}
> +static inline void vm_raw_write_begin(struct vm_area_struct *vma)
> +{
> +}
> +static inline void vm_raw_write_end(struct vm_area_struct *vma)
> +{
> +}
> +#endif /* CONFIG_SPECULATIVE_PAGE_FAULT */
> +
>  extern int access_process_vm(struct task_struct *tsk, unsigned long addr,
>  		void *buf, int len, unsigned int gup_flags);
>  extern int access_remote_vm(struct mm_struct *mm, unsigned long addr,
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index fd7d38ee2e33..e78f72eb2576 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -337,6 +337,9 @@ struct vm_area_struct {
>  	struct mempolicy *vm_policy;	/* NUMA policy for the VMA */
>  #endif
>  	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
> +#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
> +	seqcount_t vm_sequence;
> +#endif
>  } __randomize_layout;
>  
>  struct core_thread {
> diff --git a/mm/memory.c b/mm/memory.c
> index d5bebca47d98..423fa8ea0569 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1256,6 +1256,7 @@ void unmap_page_range(struct mmu_gather *tlb,
>  	unsigned long next;
>  
>  	BUG_ON(addr >= end);
> +	vm_write_begin(vma);
>  	tlb_start_vma(tlb, vma);
>  	pgd = pgd_offset(vma->vm_mm, addr);
>  	do {
> @@ -1265,6 +1266,7 @@ void unmap_page_range(struct mmu_gather *tlb,
>  		next = zap_p4d_range(tlb, vma, pgd, addr, next, details);
>  	} while (pgd++, addr = next, addr != end);
>  	tlb_end_vma(tlb, vma);
> +	vm_write_end(vma);
>  }
>  
>  
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 5ad3a3228d76..a4e4d52a5148 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -726,6 +726,30 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
>  	long adjust_next = 0;
>  	int remove_next = 0;
>  
> +	/*
> +	 * Why using vm_raw_write*() functions here to avoid lockdep's warning ?
> +	 *
> +	 * Locked is complaining about a theoretical lock dependency, involving
> +	 * 3 locks:
> +	 *   mapping->i_mmap_rwsem --> vma->vm_sequence --> fs_reclaim
> +	 *
> +	 * Here are the major path leading to this dependency :
> +	 *  1. __vma_adjust() mmap_sem  -> vm_sequence -> i_mmap_rwsem
> +	 *  2. move_vmap() mmap_sem -> vm_sequence -> fs_reclaim
> +	 *  3. __alloc_pages_nodemask() fs_reclaim -> i_mmap_rwsem
> +	 *  4. unmap_mapping_range() i_mmap_rwsem -> vm_sequence
> +	 *
> +	 * So there is no way to solve this easily, especially because in
> +	 * unmap_mapping_range() the i_mmap_rwsem is grab while the impacted
> +	 * VMAs are not yet known.
> +	 * However, the way the vm_seq is used is guarantying that we will
> +	 * never block on it since we just check for its value and never wait
> +	 * for it to move, see vma_has_changed() and handle_speculative_fault().
> +	 */
> +	vm_raw_write_begin(vma);
> +	if (next)
> +		vm_raw_write_begin(next);
> +
>  	if (next && !insert) {
>  		struct vm_area_struct *exporter = NULL, *importer = NULL;
>  
> @@ -950,6 +974,8 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
>  			 * "vma->vm_next" gap must be updated.
>  			 */
>  			next = vma->vm_next;
> +			if (next)
> +				vm_raw_write_begin(next);
>  		} else {
>  			/*
>  			 * For the scope of the comment "next" and
> @@ -996,6 +1022,10 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
>  	if (insert && file)
>  		uprobe_mmap(insert);
>  
> +	if (next && next != vma)
> +		vm_raw_write_end(next);
> +	vm_raw_write_end(vma);
> +
>  	validate_mm(mm);
>  
>  	return 0;
> -- 
> 2.21.0
> 
