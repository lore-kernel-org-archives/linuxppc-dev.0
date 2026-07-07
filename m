Return-Path: <linuxppc-dev+bounces-23715-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F2CC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 15:19:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvlHw1J5Pz2xKh;
	Wed, 08 Jul 2026 01:19:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783437548;
	cv=none; b=oapjxlt6Ts1o+jGNKrmXtGOiMCqVUYAbTCEnwGHiqZmwJcHHzwmYm9z9e/JoTDSVkMQXLEgMH8fSR5l7fg3gXfweIHgUk6DB06tUZOJWgGLquqjJhB171yMtqc3Rt2RanVZE67tyLwvPs+Dk5H7aA4yuQqtAl1UGUcWBFVeiUPRHO85tUEaDbp0A0KsaZwej5ke49+qLvdv5ghtUuyeDxpLOLB0ShzcRbmwFHYyPUPsDySjlLkgvkupQ9VSJMfsezoqI+ccy7lRJq3BFAguahqNnceouYYRr2/XErdCpC2GLg2kgRQfaoSZrceAEuJHgNjDUVBxtdVxUw1kKafBafA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783437548; c=relaxed/relaxed;
	bh=Bqq8ePT9H9VE1dEU5URVxmwV7voFDUZWfR8BEBmItJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hC/06uRoIu6E7GQvQtQBl3JQ2rFkG5LCVsVFnDNF7N4oUwtA5lphNbdHgbi7OVTB4F92uUXXhk1+6n60uFy4yNtywKbgiy+hjVOH7iwcd/4MUrUL6iiIBiW8VeM9uFXTGSsczCRb6Ehce9Ht6SbGx9ZWNmS4xrabTG+C1jkXZ/BB80sArNzrE/ZbX8oUZ/mXwjVHlKKEEQeppBB+h07zEcPlnpNNt0W95iz4ohoUqlho6pREyqAO2UxE4l1nOIwdx0vxVSMe/6JAFzdifwZYO/Ebe+nbfkuGq6lVU0i217AcLM2mD0PrawfrtKHI67d2k6w5toYFNVgLReP6A4ylhw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eFtYzO+N; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eFtYzO+N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvlHv0G4Nz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 01:19:06 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8E629434B8;
	Tue,  7 Jul 2026 15:19:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B8801F000E9;
	Tue,  7 Jul 2026 15:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783437544;
	bh=Bqq8ePT9H9VE1dEU5URVxmwV7voFDUZWfR8BEBmItJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eFtYzO+N6tQx//zLUjs37Jdr/KL9AUGZECht1kmEr2glyVKXj8jjiKEGsvhUdUy8W
	 chCfiUHUifIPxfWRh40sBvnsnovCbiJNLVxaL94OJyYrw/EACkpf1D21P8j+i4WvO9
	 znQJehBGOSztYJMXLgIi94TwIYi6wQMS+vOlIb6EZjB7oiXN1/ZmIRNK98Ar+43T6u
	 5ClpIyyAqV/qxa1ZMHt0MlJIvteHAOsP670qG3+A+qjDWOPGUsZhf+RdKwrG0PUMfn
	 PstxwVxTZXFARzHmI0Th6bI3ads2eQEH5bnwwGeMgZHy7mfb5NRkQcQfsMl93xFy8/
	 GZu0Dc1cAoRCw==
Date: Tue, 7 Jul 2026 16:18:51 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: David Carlier <devnexen@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Dev Jain <dev.jain@arm.com>, 
	David Hildenbrand <david@kernel.org>, "Liam R . Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Ritesh Harjani <ritesh.list@gmail.com>, 
	syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v8] mm: pgtable: free kernel page tables via RCU to fix
 ptdump UAF
Message-ID: <ak0YI9KjSstnj9rJ@lucifer>
References: <20260706203128.162335-1-devnexen@gmail.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706203128.162335-1-devnexen@gmail.com>

Hi David C,

This has been through a lot of revisions so I think for the sake of expediency
the best solution here is for me to grab this and fiddle with it a bit then post
it out myself.

TO BE VERY CLEAR - I will keep your authorship and attribution :), and simply
stick my name on a Co-developed-by tag.

So this will remain your patch.

Cheers, Lorenzo

On Mon, Jul 06, 2026 at 09:31:27PM +0100, David Carlier wrote:
> ptdump_walk_pgd() walks the kernel page tables under get_online_mems().
> That does not stop vmalloc from freeing a kernel PTE page underneath the
> walk.
>
> When vmap_try_huge_pmd() promotes a range to a huge PMD it collapses the
> existing PTE table and frees it via pmd_free_pte_page(). On x86, riscv and
> powerpc this runs without the init_mm mmap lock; only arm64 takes it, and
> not on the block-split path. So ptdump can dereference a just-freed PTE
> page, which is the use after free syzbot hit in ptdump_pte_entry().
>
> The race is not new. ptdump walks the whole kernel address space, including
> ranges other code is actively mapping, so it reads page tables it does not
> own. Commit 5ba2f0a15564 ("mm: introduce deferred freeing for kernel page
> tables") only widened the window; the Fixes tag points there for that
> reason.
>
> Every other walker works on a range it owns and is the only one mutating
> it: set_memory() on arm64/riscv/loongarch, the arm64 block-split path, the
> openrisc DMA path and the hugetlb_vmemmap remap. Nothing frees those ranges
> concurrently, so they cannot race and do not need RCU. ptdump is the only
> walker that traverses ranges it does not own.
>
> Defer the free by an RCU grace period. pagetable_free_kernel() now frees
> via call_rcu() in both the async and non-async configs. The async path
> still flushes the TLB first, then queues the per-page RCU free. The page
> stays valid until any walk that may have observed it drops its RCU read
> lock.
>
> x86, arm64 and riscv reach pagetable_free_kernel() for the collapsed PTE
> page (the ptdesc carries PT_kernel), so the deferral covers them. powerpc
> uses its own fragment allocator: pte_free_kernel() there frees the page
> synchronously via pte_fragment_free() and the ptdesc is not flagged kernel,
> so defer the kernel case in pte_fragment_free() as well. arm64 also takes
> init_mm.mmap_lock around the free under a static key; that is now redundant
> with the RCU deferral but left in place.
>
> On the read side walk_page_range_debug() walks the init_mm range in bounded
> chunks, taking rcu_read_lock() around each chunk and calling cond_resched()
> between them. It uses the lockless walker as the mmap lock is no longer
> held, and pgd_addr_end() to bound each chunk without overflowing at the top
> of the address space. A walker either sees the cleared PMD and skips, or
> keeps the page alive until it drops the lock. The owned-range walkers are
> unchanged.
>
> Stop taking mmap_write_lock() in ptdump_walk_pgd() for init_mm. It never
> guarded against this free -- most architectures free the collapsed PTE
> table without it -- and RCU now provides the synchronisation. efi_mm and
> current->mm page tables are not RCU-freed, so they keep the mmap write
> lock.
>
> ptdump callbacks run under RCU within a chunk, so they must not sleep. The
> arch note_page() and effective_prot() callbacks only format into the
> preallocated seq_file buffer; the only GFP_KERNEL marker setup runs before
> the walk, and cond_resched() happens between chunks, outside the read lock.
>
> Fixes: 5ba2f0a15564 ("mm: introduce deferred freeing for kernel page tables")
> Reported-by: syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6a287988.39669fcc.33b062.00a0.GAE@google.com/T/
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
> v8: fix four issues raised by the Gemini review of v7 (relayed by Andrew).
>     - the init_mm walk called walk_kernel_page_table_range(), which
>       asserts init_mm.mmap_lock -- but that lock is now dropped; use the
>       lockless walker instead.
>     - only stop taking mmap_write_lock() for init_mm; efi_mm and
>       current->mm are not RCU-freed and keep it.
>     - bound each chunk with pgd_addr_end() so the last chunk does not
>       overflow at the top of the address space.
>     - powerpc frees kernel PTE pages synchronously via pte_fragment_free()
>       and never sets PT_kernel, so it bypassed the RCU deferral; defer the
>       kernel case there too.
> v7: no code change; add version tag and per-revision changelog (Dev).
> v6: chunk the init_mm walk in walk_page_range_debug() and take
>     rcu_read_lock() per chunk (reverting v5's caller-side lock + assert)
>     so the read section stays bounded on large kernel address spaces and
>     can cond_resched() between chunks; drop the now-redundant
>     mmap_write_lock() in ptdump_walk_pgd().
> v5: reframe changelog around the pre-existing race and range ownership;
>     correct the mmap-lock description (arm64 is the exception, not x86);
>     move rcu_read_lock() into ptdump_walk_pgd() and assert it in
>     walk_page_range_debug(); drop walk_kernel_page_table_range_rcu(); fix
>     the pgtable-generic.c comment; document the no-sleep audit of the
>     callbacks.
> v4: defer the free in both the async and non-async configs, not just the
>     async one; add a walk_kernel_page_table_range_rcu() helper.
> v3: take rcu_read_lock() in the init_mm branch of walk_page_range_debug().
> v2: use call_rcu() instead of synchronize_rcu().
>  arch/powerpc/mm/pgtable-frag.c |  7 ++++++-
>  include/linux/mm.h             |  7 -------
>  mm/pagewalk.c                  | 36 +++++++++++++++++++++++++++++-----
>  mm/pgtable-generic.c           | 22 ++++++++++++++++++++-
>  mm/ptdump.c                    | 11 +++++++++--
>  5 files changed, 67 insertions(+), 16 deletions(-)
>
> diff --git a/arch/powerpc/mm/pgtable-frag.c b/arch/powerpc/mm/pgtable-frag.c
> index ae742564a3d5..1e1e88f831f7 100644
> --- a/arch/powerpc/mm/pgtable-frag.c
> +++ b/arch/powerpc/mm/pgtable-frag.c
> @@ -123,7 +123,12 @@ void pte_fragment_free(unsigned long *table, int kernel)
>
>  	BUG_ON(atomic_read(&ptdesc->pt_frag_refcount) <= 0);
>  	if (atomic_dec_and_test(&ptdesc->pt_frag_refcount)) {
> -		if (kernel || !folio_test_clear_active(ptdesc_folio(ptdesc)))
> +		/*
> +		 * Kernel page tables may be walked locklessly under RCU by
> +		 * ptdump, so defer their free by a grace period too, like the
> +		 * lockless-GUP case below for user tables.
> +		 */
> +		if (!kernel && !folio_test_clear_active(ptdesc_folio(ptdesc)))
>  			pte_free_now(&ptdesc->pt_rcu_head);
>  		else
>  			call_rcu(&ptdesc->pt_rcu_head, pte_free_now);
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 485df9c2dbdd..79408a17a1b0 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3695,14 +3695,7 @@ static inline void __pagetable_free(struct ptdesc *pt)
>  	__free_pages(page, compound_order(page));
>  }
>
> -#ifdef CONFIG_ASYNC_KERNEL_PGTABLE_FREE
>  void pagetable_free_kernel(struct ptdesc *pt);
> -#else
> -static inline void pagetable_free_kernel(struct ptdesc *pt)
> -{
> -	__pagetable_free(pt);
> -}
> -#endif
>  /**
>   * pagetable_free - Free pagetables
>   * @pt:	The page table descriptor
> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> index 3ae2586ff45b..fc2fe014ac8c 100644
> --- a/mm/pagewalk.c
> +++ b/mm/pagewalk.c
> @@ -620,7 +620,7 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
>   * Note: Be careful to walk the kernel pages tables, the caller may be need to
>   * take other effective approaches (mmap lock may be insufficient) to prevent
>   * the intermediate kernel page tables belonging to the specified address range
> - * from being freed (e.g. memory hot-remove).
> + * from being freed (e.g. memory hot-remove, vmap huge page promotion).
>   */
>  int walk_kernel_page_table_range(unsigned long start, unsigned long end,
>  		const struct mm_walk_ops *ops, pgd_t *pgd, void *private)
> @@ -643,7 +643,7 @@ int walk_kernel_page_table_range(unsigned long start, unsigned long end,
>   * Use this function to walk the kernel page tables locklessly. It should be
>   * guaranteed that the caller has exclusive access over the range they are
>   * operating on - that there should be no concurrent access, for example,
> - * changing permissions for vmalloc objects.
> + * changing permissions for vmalloc objects, or vmap huge page promotion.
>   */
>  int walk_kernel_page_table_range_lockless(unsigned long start, unsigned long end,
>  		const struct mm_walk_ops *ops, pgd_t *pgd, void *private)
> @@ -692,9 +692,35 @@ int walk_page_range_debug(struct mm_struct *mm, unsigned long start,
>  	};
>
>  	/* For convenience, we allow traversal of kernel mappings. */
> -	if (mm == &init_mm)
> -		return walk_kernel_page_table_range(start, end, ops,
> -						    pgd, private);
> +	if (mm == &init_mm) {
> +		unsigned long addr = start;
> +
> +		/*
> +		 * Walk in bounded chunks so the RCU read lock is never held
> +		 * across the whole kernel address space.  A kernel page table
> +		 * freed via pagetable_free_kernel() stays valid until the walk
> +		 * that may have observed it drops the lock; releasing the lock
> +		 * between chunks is safe as no page table pointer is held
> +		 * across the gap. The mmap lock is not held, so use the
> +		 * lockless walker; RCU, not the lock, keeps the table alive.
> +		 */
> +		while (addr < end) {
> +			unsigned long next = pgd_addr_end(addr, end);
> +			int err;
> +
> +			rcu_read_lock();
> +			err = walk_kernel_page_table_range_lockless(addr, next, ops,
> +								    pgd, private);
> +			rcu_read_unlock();
> +			if (err)
> +				return err;
> +
> +			addr = next;
> +			cond_resched();
> +		}
> +		return 0;
> +	}
> +
>  	if (start >= end || !walk.mm)
>  		return -EINVAL;
>  	if (!check_ops_safe(ops))
> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> index b91b1a98029c..7a32e4821957 100644
> --- a/mm/pgtable-generic.c
> +++ b/mm/pgtable-generic.c
> @@ -410,6 +410,13 @@ pte_t *pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
>  	goto again;
>  }
>
> +static void kernel_pgtable_free_rcu(struct rcu_head *head)
> +{
> +	struct ptdesc *pt = container_of(head, struct ptdesc, pt_rcu_head);
> +
> +	__pagetable_free(pt);
> +}
> +
>  #ifdef CONFIG_ASYNC_KERNEL_PGTABLE_FREE
>  static void kernel_pgtable_work_func(struct work_struct *work);
>
> @@ -434,8 +441,15 @@ static void kernel_pgtable_work_func(struct work_struct *work)
>  	spin_unlock(&kernel_pgtable_work.lock);
>
>  	iommu_sva_invalidate_kva_range(PAGE_OFFSET, TLB_FLUSH_ALL);
> +
> +	/*
> +	 * Debug walkers (ptdump) may walk ranges they do not own and race this
> +	 * free, so they walk under rcu_read_lock(). Free after a grace period:
> +	 * a walker either already saw the cleared PMD, or keeps the page alive
> +	 * until it drops the RCU lock.
> +	 */
>  	list_for_each_entry_safe(pt, next, &page_list, pt_list)
> -		__pagetable_free(pt);
> +		call_rcu(&pt->pt_rcu_head, kernel_pgtable_free_rcu);
>  }
>
>  void pagetable_free_kernel(struct ptdesc *pt)
> @@ -446,4 +460,10 @@ void pagetable_free_kernel(struct ptdesc *pt)
>
>  	schedule_work(&kernel_pgtable_work.work);
>  }
> +#else
> +void pagetable_free_kernel(struct ptdesc *pt)
> +{
> +	/* Defer the free by a grace period; see kernel_pgtable_work_func(). */
> +	call_rcu(&pt->pt_rcu_head, kernel_pgtable_free_rcu);
> +}
>  #endif
> diff --git a/mm/ptdump.c b/mm/ptdump.c
> index 973020000096..537be9995e1a 100644
> --- a/mm/ptdump.c
> +++ b/mm/ptdump.c
> @@ -177,13 +177,20 @@ void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm, pgd_t *pgd)
>  	const struct ptdump_range *range = st->range;
>
>  	get_online_mems();
> -	mmap_write_lock(mm);
> +	/*
> +	 * init_mm is walked locklessly under RCU by walk_page_range_debug().
> +	 * efi_mm / current->mm page tables are not RCU-freed, so hold the
> +	 * mmap write lock to keep them stable against concurrent teardown.
> +	 */
> +	if (mm != &init_mm)
> +		mmap_write_lock(mm);
>  	while (range->start != range->end) {
>  		walk_page_range_debug(mm, range->start, range->end,
>  				      &ptdump_ops, pgd, st);
>  		range++;
>  	}
> -	mmap_write_unlock(mm);
> +	if (mm != &init_mm)
> +		mmap_write_unlock(mm);
>  	put_online_mems();
>
>  	/* Flush out the last page */
> --
> 2.53.0
>

