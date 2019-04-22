Return-Path: <SRS0=+Gyc=SY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C51C10F11
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 19:47:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B528621906
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 19:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B528621906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nxvB3YVJzDqMH
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 05:47:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=jglisse@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nxpk1QyNzDq7F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 05:43:55 +1000 (AEST)
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 90A613092652;
 Mon, 22 Apr 2019 19:43:52 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B4DD5D720;
 Mon, 22 Apr 2019 19:43:47 +0000 (UTC)
Date: Mon, 22 Apr 2019 15:43:45 -0400
From: Jerome Glisse <jglisse@redhat.com>
To: Laurent Dufour <ldufour@linux.ibm.com>
Subject: Re: [PATCH v12 10/31] mm: protect VMA modifications using VMA
 sequence count
Message-ID: <20190422194345.GA14666@redhat.com>
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
 <20190416134522.17540-11-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190416134522.17540-11-ldufour@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Mon, 22 Apr 2019 19:43:53 +0000 (UTC)
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

On Tue, Apr 16, 2019 at 03:45:01PM +0200, Laurent Dufour wrote:
> The VMA sequence count has been introduced to allow fast detection of
> VMA modification when running a page fault handler without holding
> the mmap_sem.
> 
> This patch provides protection against the VMA modification done in :
> 	- madvise()
> 	- mpol_rebind_policy()
> 	- vma_replace_policy()
> 	- change_prot_numa()
> 	- mlock(), munlock()
> 	- mprotect()
> 	- mmap_region()
> 	- collapse_huge_page()
> 	- userfaultd registering services
> 
> In addition, VMA fields which will be read during the speculative fault
> path needs to be written using WRITE_ONCE to prevent write to be split
> and intermediate values to be pushed to other CPUs.
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

> ---
>  fs/proc/task_mmu.c |  5 ++++-
>  fs/userfaultfd.c   | 17 ++++++++++++----
>  mm/khugepaged.c    |  3 +++
>  mm/madvise.c       |  6 +++++-
>  mm/mempolicy.c     | 51 ++++++++++++++++++++++++++++++----------------
>  mm/mlock.c         | 13 +++++++-----
>  mm/mmap.c          | 28 ++++++++++++++++---------
>  mm/mprotect.c      |  4 +++-
>  mm/swap_state.c    | 10 ++++++---
>  9 files changed, 95 insertions(+), 42 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 01d4eb0e6bd1..0864c050b2de 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1162,8 +1162,11 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
>  					goto out_mm;
>  				}
>  				for (vma = mm->mmap; vma; vma = vma->vm_next) {
> -					vma->vm_flags &= ~VM_SOFTDIRTY;
> +					vm_write_begin(vma);
> +					WRITE_ONCE(vma->vm_flags,
> +						 vma->vm_flags & ~VM_SOFTDIRTY);
>  					vma_set_page_prot(vma);
> +					vm_write_end(vma);
>  				}
>  				downgrade_write(&mm->mmap_sem);
>  				break;
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 3b30301c90ec..2e0f98cadd81 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -667,8 +667,11 @@ int dup_userfaultfd(struct vm_area_struct *vma, struct list_head *fcs)
>  
>  	octx = vma->vm_userfaultfd_ctx.ctx;
>  	if (!octx || !(octx->features & UFFD_FEATURE_EVENT_FORK)) {
> +		vm_write_begin(vma);
>  		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
> -		vma->vm_flags &= ~(VM_UFFD_WP | VM_UFFD_MISSING);
> +		WRITE_ONCE(vma->vm_flags,
> +			   vma->vm_flags & ~(VM_UFFD_WP | VM_UFFD_MISSING));
> +		vm_write_end(vma);
>  		return 0;
>  	}
>  
> @@ -908,8 +911,10 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
>  			vma = prev;
>  		else
>  			prev = vma;
> -		vma->vm_flags = new_flags;
> +		vm_write_begin(vma);
> +		WRITE_ONCE(vma->vm_flags, new_flags);
>  		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
> +		vm_write_end(vma);
>  	}
>  skip_mm:
>  	up_write(&mm->mmap_sem);
> @@ -1474,8 +1479,10 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  		 * the next vma was merged into the current one and
>  		 * the current one has not been updated yet.
>  		 */
> -		vma->vm_flags = new_flags;
> +		vm_write_begin(vma);
> +		WRITE_ONCE(vma->vm_flags, new_flags);
>  		vma->vm_userfaultfd_ctx.ctx = ctx;
> +		vm_write_end(vma);
>  
>  	skip:
>  		prev = vma;
> @@ -1636,8 +1643,10 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  		 * the next vma was merged into the current one and
>  		 * the current one has not been updated yet.
>  		 */
> -		vma->vm_flags = new_flags;
> +		vm_write_begin(vma);
> +		WRITE_ONCE(vma->vm_flags, new_flags);
>  		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
> +		vm_write_end(vma);
>  
>  	skip:
>  		prev = vma;
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index a335f7c1fac4..6a0cbca3885e 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1011,6 +1011,7 @@ static void collapse_huge_page(struct mm_struct *mm,
>  	if (mm_find_pmd(mm, address) != pmd)
>  		goto out;
>  
> +	vm_write_begin(vma);
>  	anon_vma_lock_write(vma->anon_vma);
>  
>  	pte = pte_offset_map(pmd, address);
> @@ -1046,6 +1047,7 @@ static void collapse_huge_page(struct mm_struct *mm,
>  		pmd_populate(mm, pmd, pmd_pgtable(_pmd));
>  		spin_unlock(pmd_ptl);
>  		anon_vma_unlock_write(vma->anon_vma);
> +		vm_write_end(vma);
>  		result = SCAN_FAIL;
>  		goto out;
>  	}
> @@ -1081,6 +1083,7 @@ static void collapse_huge_page(struct mm_struct *mm,
>  	set_pmd_at(mm, address, pmd, _pmd);
>  	update_mmu_cache_pmd(vma, address, pmd);
>  	spin_unlock(pmd_ptl);
> +	vm_write_end(vma);
>  
>  	*hpage = NULL;
>  
> diff --git a/mm/madvise.c b/mm/madvise.c
> index a692d2a893b5..6cf07dc546fc 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -184,7 +184,9 @@ static long madvise_behavior(struct vm_area_struct *vma,
>  	/*
>  	 * vm_flags is protected by the mmap_sem held in write mode.
>  	 */
> -	vma->vm_flags = new_flags;
> +	vm_write_begin(vma);
> +	WRITE_ONCE(vma->vm_flags, new_flags);
> +	vm_write_end(vma);
>  out:
>  	return error;
>  }
> @@ -450,9 +452,11 @@ static void madvise_free_page_range(struct mmu_gather *tlb,
>  		.private = tlb,
>  	};
>  
> +	vm_write_begin(vma);
>  	tlb_start_vma(tlb, vma);
>  	walk_page_range(addr, end, &free_walk);
>  	tlb_end_vma(tlb, vma);
> +	vm_write_end(vma);
>  }
>  
>  static int madvise_free_single_vma(struct vm_area_struct *vma,
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 2219e747df49..94c103c5034a 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -380,8 +380,11 @@ void mpol_rebind_mm(struct mm_struct *mm, nodemask_t *new)
>  	struct vm_area_struct *vma;
>  
>  	down_write(&mm->mmap_sem);
> -	for (vma = mm->mmap; vma; vma = vma->vm_next)
> +	for (vma = mm->mmap; vma; vma = vma->vm_next) {
> +		vm_write_begin(vma);
>  		mpol_rebind_policy(vma->vm_policy, new);
> +		vm_write_end(vma);
> +	}
>  	up_write(&mm->mmap_sem);
>  }
>  
> @@ -575,9 +578,11 @@ unsigned long change_prot_numa(struct vm_area_struct *vma,
>  {
>  	int nr_updated;
>  
> +	vm_write_begin(vma);
>  	nr_updated = change_protection(vma, addr, end, PAGE_NONE, 0, 1);
>  	if (nr_updated)
>  		count_vm_numa_events(NUMA_PTE_UPDATES, nr_updated);
> +	vm_write_end(vma);
>  
>  	return nr_updated;
>  }
> @@ -683,6 +688,7 @@ static int vma_replace_policy(struct vm_area_struct *vma,
>  	if (IS_ERR(new))
>  		return PTR_ERR(new);
>  
> +	vm_write_begin(vma);
>  	if (vma->vm_ops && vma->vm_ops->set_policy) {
>  		err = vma->vm_ops->set_policy(vma, new);
>  		if (err)
> @@ -690,11 +696,17 @@ static int vma_replace_policy(struct vm_area_struct *vma,
>  	}
>  
>  	old = vma->vm_policy;
> -	vma->vm_policy = new; /* protected by mmap_sem */
> +	/*
> +	 * The speculative page fault handler accesses this field without
> +	 * hodling the mmap_sem.
> +	 */
> +	WRITE_ONCE(vma->vm_policy,  new);
> +	vm_write_end(vma);
>  	mpol_put(old);
>  
>  	return 0;
>   err_out:
> +	vm_write_end(vma);
>  	mpol_put(new);
>  	return err;
>  }
> @@ -1654,23 +1666,28 @@ COMPAT_SYSCALL_DEFINE4(migrate_pages, compat_pid_t, pid,
>  struct mempolicy *__get_vma_policy(struct vm_area_struct *vma,
>  						unsigned long addr)
>  {
> -	struct mempolicy *pol = NULL;
> +	struct mempolicy *pol;
>  
> -	if (vma) {
> -		if (vma->vm_ops && vma->vm_ops->get_policy) {
> -			pol = vma->vm_ops->get_policy(vma, addr);
> -		} else if (vma->vm_policy) {
> -			pol = vma->vm_policy;
> +	if (!vma)
> +		return NULL;
>  
> -			/*
> -			 * shmem_alloc_page() passes MPOL_F_SHARED policy with
> -			 * a pseudo vma whose vma->vm_ops=NULL. Take a reference
> -			 * count on these policies which will be dropped by
> -			 * mpol_cond_put() later
> -			 */
> -			if (mpol_needs_cond_ref(pol))
> -				mpol_get(pol);
> -		}
> +	if (vma->vm_ops && vma->vm_ops->get_policy)
> +		return vma->vm_ops->get_policy(vma, addr);
> +
> +	/*
> +	 * This could be called without holding the mmap_sem in the
> +	 * speculative page fault handler's path.
> +	 */
> +	pol = READ_ONCE(vma->vm_policy);
> +	if (pol) {
> +		/*
> +		 * shmem_alloc_page() passes MPOL_F_SHARED policy with
> +		 * a pseudo vma whose vma->vm_ops=NULL. Take a reference
> +		 * count on these policies which will be dropped by
> +		 * mpol_cond_put() later
> +		 */
> +		if (mpol_needs_cond_ref(pol))
> +			mpol_get(pol);
>  	}
>  
>  	return pol;
> diff --git a/mm/mlock.c b/mm/mlock.c
> index 080f3b36415b..f390903d9bbb 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -445,7 +445,9 @@ static unsigned long __munlock_pagevec_fill(struct pagevec *pvec,
>  void munlock_vma_pages_range(struct vm_area_struct *vma,
>  			     unsigned long start, unsigned long end)
>  {
> -	vma->vm_flags &= VM_LOCKED_CLEAR_MASK;
> +	vm_write_begin(vma);
> +	WRITE_ONCE(vma->vm_flags, vma->vm_flags & VM_LOCKED_CLEAR_MASK);
> +	vm_write_end(vma);
>  
>  	while (start < end) {
>  		struct page *page;
> @@ -569,10 +571,11 @@ static int mlock_fixup(struct vm_area_struct *vma, struct vm_area_struct **prev,
>  	 * It's okay if try_to_unmap_one unmaps a page just after we
>  	 * set VM_LOCKED, populate_vma_page_range will bring it back.
>  	 */
> -
> -	if (lock)
> -		vma->vm_flags = newflags;
> -	else
> +	if (lock) {
> +		vm_write_begin(vma);
> +		WRITE_ONCE(vma->vm_flags, newflags);
> +		vm_write_end(vma);
> +	} else
>  		munlock_vma_pages_range(vma, start, end);
>  
>  out:
> diff --git a/mm/mmap.c b/mm/mmap.c
> index a4e4d52a5148..b77ec0149249 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -877,17 +877,18 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
>  	}
>  
>  	if (start != vma->vm_start) {
> -		vma->vm_start = start;
> +		WRITE_ONCE(vma->vm_start, start);
>  		start_changed = true;
>  	}
>  	if (end != vma->vm_end) {
> -		vma->vm_end = end;
> +		WRITE_ONCE(vma->vm_end, end);
>  		end_changed = true;
>  	}
> -	vma->vm_pgoff = pgoff;
> +	WRITE_ONCE(vma->vm_pgoff, pgoff);
>  	if (adjust_next) {
> -		next->vm_start += adjust_next << PAGE_SHIFT;
> -		next->vm_pgoff += adjust_next;
> +		WRITE_ONCE(next->vm_start,
> +			   next->vm_start + (adjust_next << PAGE_SHIFT));
> +		WRITE_ONCE(next->vm_pgoff, next->vm_pgoff + adjust_next);
>  	}
>  
>  	if (root) {
> @@ -1850,12 +1851,14 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  out:
>  	perf_event_mmap(vma);
>  
> +	vm_write_begin(vma);
>  	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
>  	if (vm_flags & VM_LOCKED) {
>  		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
>  					is_vm_hugetlb_page(vma) ||
>  					vma == get_gate_vma(current->mm))
> -			vma->vm_flags &= VM_LOCKED_CLEAR_MASK;
> +			WRITE_ONCE(vma->vm_flags,
> +				   vma->vm_flags &= VM_LOCKED_CLEAR_MASK);
>  		else
>  			mm->locked_vm += (len >> PAGE_SHIFT);
>  	}
> @@ -1870,9 +1873,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	 * then new mapped in-place (which must be aimed as
>  	 * a completely new data area).
>  	 */
> -	vma->vm_flags |= VM_SOFTDIRTY;
> +	WRITE_ONCE(vma->vm_flags, vma->vm_flags | VM_SOFTDIRTY);
>  
>  	vma_set_page_prot(vma);
> +	vm_write_end(vma);
>  
>  	return addr;
>  
> @@ -2430,7 +2434,9 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
>  					mm->locked_vm += grow;
>  				vm_stat_account(mm, vma->vm_flags, grow);
>  				anon_vma_interval_tree_pre_update_vma(vma);
> -				vma->vm_end = address;
> +				vm_write_begin(vma);
> +				WRITE_ONCE(vma->vm_end, address);
> +				vm_write_end(vma);
>  				anon_vma_interval_tree_post_update_vma(vma);
>  				if (vma->vm_next)
>  					vma_gap_update(vma->vm_next);
> @@ -2510,8 +2516,10 @@ int expand_downwards(struct vm_area_struct *vma,
>  					mm->locked_vm += grow;
>  				vm_stat_account(mm, vma->vm_flags, grow);
>  				anon_vma_interval_tree_pre_update_vma(vma);
> -				vma->vm_start = address;
> -				vma->vm_pgoff -= grow;
> +				vm_write_begin(vma);
> +				WRITE_ONCE(vma->vm_start, address);
> +				WRITE_ONCE(vma->vm_pgoff, vma->vm_pgoff - grow);
> +				vm_write_end(vma);
>  				anon_vma_interval_tree_post_update_vma(vma);
>  				vma_gap_update(vma);
>  				spin_unlock(&mm->page_table_lock);
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 65242f1e4457..78fce873ca3a 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -427,12 +427,14 @@ mprotect_fixup(struct vm_area_struct *vma, struct vm_area_struct **pprev,
>  	 * vm_flags and vm_page_prot are protected by the mmap_sem
>  	 * held in write mode.
>  	 */
> -	vma->vm_flags = newflags;
> +	vm_write_begin(vma);
> +	WRITE_ONCE(vma->vm_flags, newflags);
>  	dirty_accountable = vma_wants_writenotify(vma, vma->vm_page_prot);
>  	vma_set_page_prot(vma);
>  
>  	change_protection(vma, start, end, vma->vm_page_prot,
>  			  dirty_accountable, 0);
> +	vm_write_end(vma);
>  
>  	/*
>  	 * Private VM_LOCKED VMA becoming writable: trigger COW to avoid major
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index eb714165afd2..c45f9122b457 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -523,7 +523,11 @@ static unsigned long swapin_nr_pages(unsigned long offset)
>   * This has been extended to use the NUMA policies from the mm triggering
>   * the readahead.
>   *
> - * Caller must hold read mmap_sem if vmf->vma is not NULL.
> + * Caller must hold down_read on the vma->vm_mm if vmf->vma is not NULL.
> + * This is needed to ensure the VMA will not be freed in our back. In the case
> + * of the speculative page fault handler, this cannot happen, even if we don't
> + * hold the mmap_sem. Callees are assumed to take care of reading VMA's fields
> + * using READ_ONCE() to read consistent values.
>   */
>  struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
>  				struct vm_fault *vmf)
> @@ -624,9 +628,9 @@ static inline void swap_ra_clamp_pfn(struct vm_area_struct *vma,
>  				     unsigned long *start,
>  				     unsigned long *end)
>  {
> -	*start = max3(lpfn, PFN_DOWN(vma->vm_start),
> +	*start = max3(lpfn, PFN_DOWN(READ_ONCE(vma->vm_start)),
>  		      PFN_DOWN(faddr & PMD_MASK));
> -	*end = min3(rpfn, PFN_DOWN(vma->vm_end),
> +	*end = min3(rpfn, PFN_DOWN(READ_ONCE(vma->vm_end)),
>  		    PFN_DOWN((faddr & PMD_MASK) + PMD_SIZE));
>  }
>  
> -- 
> 2.21.0
> 
