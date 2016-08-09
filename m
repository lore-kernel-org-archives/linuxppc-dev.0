Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7hVN3TxyzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 14:43:08 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id y134so162917pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Aug 2016 21:43:08 -0700 (PDT)
Subject: Re: [PATCH kernel 05/15] powerpc/iommu: Stop using @current in
 mm_iommu_xxx
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
References: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
 <1470213656-1042-6-git-send-email-aik@ozlabs.ru>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <cb29b1f1-8ba0-56e5-004c-59d38bbcd3ba@gmail.com>
Date: Tue, 9 Aug 2016 14:43:00 +1000
MIME-Version: 1.0
In-Reply-To: <1470213656-1042-6-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 03/08/16 18:40, Alexey Kardashevskiy wrote:
> In some situations the userspace memory context may live longer than
> the userspace process itself so if we need to do proper memory context
> cleanup, we better cache @mm and use it later when the process is gone
> (@current or @current->mm are NULL).
> 
> This changes mm_iommu_xxx API to receive mm_struct instead of using one
> from @current.
> 
> This is needed by the following patch to do proper cleanup in time.
> This depends on "powerpc/powernv/ioda: Fix endianness when reading TCEs"
> to do proper cleanup via tce_iommu_clear() patch.
> 
> To keep API consistent, this replaces mm_context_t with mm_struct;
> we stick to mm_struct as mm_iommu_adjust_locked_vm() helper needs
> access to &mm->mmap_sem.
> 
> This should cause no behavioral change.
> 

Looks good, minor nits below

Acked-by: Balbir Singh <bsingharora@gmail.com>

> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/include/asm/mmu_context.h | 20 +++++++------
>  arch/powerpc/kernel/setup-common.c     |  2 +-
>  arch/powerpc/mm/mmu_context_book3s64.c |  4 +--
>  arch/powerpc/mm/mmu_context_iommu.c    | 54 ++++++++++++++--------------------
>  drivers/vfio/vfio_iommu_spapr_tce.c    | 41 ++++++++++++++++----------
>  5 files changed, 62 insertions(+), 59 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
> index 9d2cd0c..b85cc7b 100644
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -18,16 +18,18 @@ extern void destroy_context(struct mm_struct *mm);
>  #ifdef CONFIG_SPAPR_TCE_IOMMU
>  struct mm_iommu_table_group_mem_t;
>  
> -extern bool mm_iommu_preregistered(void);
> -extern long mm_iommu_get(unsigned long ua, unsigned long entries,
> +extern bool mm_iommu_preregistered(struct mm_struct *mm);
> +extern long mm_iommu_get(struct mm_struct *mm,
> +		unsigned long ua, unsigned long entries,
>  		struct mm_iommu_table_group_mem_t **pmem);
> -extern long mm_iommu_put(struct mm_iommu_table_group_mem_t *mem);
> -extern void mm_iommu_init(mm_context_t *ctx);
> -extern void mm_iommu_cleanup(mm_context_t *ctx);
> -extern struct mm_iommu_table_group_mem_t *mm_iommu_lookup(unsigned long ua,
> -		unsigned long size);
> -extern struct mm_iommu_table_group_mem_t *mm_iommu_find(unsigned long ua,
> -		unsigned long entries);
> +extern long mm_iommu_put(struct mm_struct *mm,
> +		struct mm_iommu_table_group_mem_t *mem);
> +extern void mm_iommu_init(struct mm_struct *mm);
> +extern void mm_iommu_cleanup(struct mm_struct *mm);
> +extern struct mm_iommu_table_group_mem_t *mm_iommu_lookup(struct mm_struct *mm,
> +		unsigned long ua, unsigned long size);
> +extern struct mm_iommu_table_group_mem_t *mm_iommu_find(struct mm_struct *mm,
> +		unsigned long ua, unsigned long entries);
>  extern long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
>  		unsigned long ua, unsigned long *hpa);
>  extern long mm_iommu_mapped_inc(struct mm_iommu_table_group_mem_t *mem);
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index 714b4ba..e90b68a 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -905,7 +905,7 @@ void __init setup_arch(char **cmdline_p)
>  	init_mm.context.pte_frag = NULL;
>  #endif
>  #ifdef CONFIG_SPAPR_TCE_IOMMU
> -	mm_iommu_init(&init_mm.context);
> +	mm_iommu_init(&init_mm);
>  #endif
>  	irqstack_early_init();
>  	exc_lvl_early_init();
> diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
> index b114f8b..ad82735 100644
> --- a/arch/powerpc/mm/mmu_context_book3s64.c
> +++ b/arch/powerpc/mm/mmu_context_book3s64.c
> @@ -115,7 +115,7 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
>  	mm->context.pte_frag = NULL;
>  #endif
>  #ifdef CONFIG_SPAPR_TCE_IOMMU
> -	mm_iommu_init(&mm->context);
> +	mm_iommu_init(mm);
>  #endif
>  	return 0;
>  }
> @@ -160,7 +160,7 @@ static inline void destroy_pagetable_page(struct mm_struct *mm)
>  void destroy_context(struct mm_struct *mm)
>  {
>  #ifdef CONFIG_SPAPR_TCE_IOMMU
> -	mm_iommu_cleanup(&mm->context);
> +	mm_iommu_cleanup(mm);
>  #endif
>  
>  #ifdef CONFIG_PPC_ICSWX
> diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
> index da6a216..ee6685b 100644
> --- a/arch/powerpc/mm/mmu_context_iommu.c
> +++ b/arch/powerpc/mm/mmu_context_iommu.c
> @@ -53,7 +53,7 @@ static long mm_iommu_adjust_locked_vm(struct mm_struct *mm,
>  	}
>  
>  	pr_debug("[%d] RLIMIT_MEMLOCK HASH64 %c%ld %ld/%ld\n",
> -			current->pid,
> +			current ? current->pid : 0,
>  			incr ? '+' : '-',
>  			npages << PAGE_SHIFT,
>  			mm->locked_vm << PAGE_SHIFT,
> @@ -63,28 +63,22 @@ static long mm_iommu_adjust_locked_vm(struct mm_struct *mm,
>  	return ret;
>  }
>  
> -bool mm_iommu_preregistered(void)
> +bool mm_iommu_preregistered(struct mm_struct *mm)
>  {
> -	if (!current || !current->mm)
> -		return false;
> -
> -	return !list_empty(&current->mm->context.iommu_group_mem_list);
> +	return !list_empty(&mm->context.iommu_group_mem_list);
>  }
>  EXPORT_SYMBOL_GPL(mm_iommu_preregistered);
>  
> -long mm_iommu_get(unsigned long ua, unsigned long entries,
> +long mm_iommu_get(struct mm_struct *mm, unsigned long ua, unsigned long entries,
>  		struct mm_iommu_table_group_mem_t **pmem)
>  {
>  	struct mm_iommu_table_group_mem_t *mem;
>  	long i, j, ret = 0, locked_entries = 0;
>  	struct page *page = NULL;
>  
> -	if (!current || !current->mm)
> -		return -ESRCH; /* process exited */

VM_BUG_ON(mm == NULL)?

> -
>  	mutex_lock(&mem_list_mutex);
>  
> -	list_for_each_entry_rcu(mem, &current->mm->context.iommu_group_mem_list,
> +	list_for_each_entry_rcu(mem, &mm->context.iommu_group_mem_list,
>  			next) {
>  		if ((mem->ua == ua) && (mem->entries == entries)) {
>  			++mem->used;
> @@ -102,7 +96,7 @@ long mm_iommu_get(unsigned long ua, unsigned long entries,
>  
>  	}
>  
> -	ret = mm_iommu_adjust_locked_vm(current->mm, entries, true);
> +	ret = mm_iommu_adjust_locked_vm(mm, entries, true);
>  	if (ret)
>  		goto unlock_exit;
>  
> @@ -142,11 +136,11 @@ long mm_iommu_get(unsigned long ua, unsigned long entries,
>  	mem->entries = entries;
>  	*pmem = mem;
>  
> -	list_add_rcu(&mem->next, &current->mm->context.iommu_group_mem_list);
> +	list_add_rcu(&mem->next, &mm->context.iommu_group_mem_list);
>  
>  unlock_exit:
>  	if (locked_entries && ret)
> -		mm_iommu_adjust_locked_vm(current->mm, locked_entries, false);
> +		mm_iommu_adjust_locked_vm(mm, locked_entries, false);
>  
>  	mutex_unlock(&mem_list_mutex);
>  
> @@ -191,16 +185,13 @@ static void mm_iommu_free(struct rcu_head *head)
>  static void mm_iommu_release(struct mm_iommu_table_group_mem_t *mem)
>  {
>  	list_del_rcu(&mem->next);
> -	mm_iommu_adjust_locked_vm(current->mm, mem->entries, false);
>  	call_rcu(&mem->rcu, mm_iommu_free);
>  }
>  
> -long mm_iommu_put(struct mm_iommu_table_group_mem_t *mem)
> +long mm_iommu_put(struct mm_struct *mm, struct mm_iommu_table_group_mem_t *mem)
>  {
>  	long ret = 0;
>  
> -	if (!current || !current->mm)
> -		return -ESRCH; /* process exited */
>  
>  	mutex_lock(&mem_list_mutex);
>  
> @@ -224,6 +215,8 @@ long mm_iommu_put(struct mm_iommu_table_group_mem_t *mem)
>  	/* @mapped became 0 so now mappings are disabled, release the region */
>  	mm_iommu_release(mem);
>  
> +	mm_iommu_adjust_locked_vm(mm, mem->entries, false);
> +
>  unlock_exit:
>  	mutex_unlock(&mem_list_mutex);
>  
> @@ -231,14 +224,12 @@ unlock_exit:
>  }
>  EXPORT_SYMBOL_GPL(mm_iommu_put);
>  
> -struct mm_iommu_table_group_mem_t *mm_iommu_lookup(unsigned long ua,
> -		unsigned long size)
> +struct mm_iommu_table_group_mem_t *mm_iommu_lookup(struct mm_struct *mm,
> +		unsigned long ua, unsigned long size)
>  {
>  	struct mm_iommu_table_group_mem_t *mem, *ret = NULL;
>  
> -	list_for_each_entry_rcu(mem,
> -			&current->mm->context.iommu_group_mem_list,
> -			next) {
> +	list_for_each_entry_rcu(mem, &mm->context.iommu_group_mem_list, next) {
>  		if ((mem->ua <= ua) &&
>  				(ua + size <= mem->ua +
>  				 (mem->entries << PAGE_SHIFT))) {
> @@ -251,14 +242,12 @@ struct mm_iommu_table_group_mem_t *mm_iommu_lookup(unsigned long ua,
>  }
>  EXPORT_SYMBOL_GPL(mm_iommu_lookup);
>  
> -struct mm_iommu_table_group_mem_t *mm_iommu_find(unsigned long ua,
> -		unsigned long entries)
> +struct mm_iommu_table_group_mem_t *mm_iommu_find(struct mm_struct *mm,
> +		unsigned long ua, unsigned long entries)
>  {
>  	struct mm_iommu_table_group_mem_t *mem, *ret = NULL;
>  
> -	list_for_each_entry_rcu(mem,
> -			&current->mm->context.iommu_group_mem_list,
> -			next) {
> +	list_for_each_entry_rcu(mem, &mm->context.iommu_group_mem_list, next) {
>  		if ((mem->ua == ua) && (mem->entries == entries)) {
>  			ret = mem;
>  			break;
> @@ -300,16 +289,17 @@ void mm_iommu_mapped_dec(struct mm_iommu_table_group_mem_t *mem)
>  }
>  EXPORT_SYMBOL_GPL(mm_iommu_mapped_dec);
>  
> -void mm_iommu_init(mm_context_t *ctx)
> +void mm_iommu_init(struct mm_struct *mm)
>  {
> -	INIT_LIST_HEAD_RCU(&ctx->iommu_group_mem_list);
> +	INIT_LIST_HEAD_RCU(&mm->context.iommu_group_mem_list);
>  }
>  
> -void mm_iommu_cleanup(mm_context_t *ctx)
> +void mm_iommu_cleanup(struct mm_struct *mm)
>  {
>  	struct mm_iommu_table_group_mem_t *mem, *tmp;
>  
> -	list_for_each_entry_safe(mem, tmp, &ctx->iommu_group_mem_list, next) {
> +	list_for_each_entry_safe(mem, tmp, &mm->context.iommu_group_mem_list,
> +			next) {
>  		list_del_rcu(&mem->next);
>  		mm_iommu_do_free(mem);
>  	}
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
> index 80378dd..9752e77 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -98,6 +98,7 @@ struct tce_container {
>  	bool enabled;
>  	bool v2;
>  	unsigned long locked_pages;
> +	struct mm_struct *mm;
>  	struct iommu_table *tables[IOMMU_TABLE_GROUP_MAX_TABLES];
>  	struct list_head group_list;
>  };
> @@ -110,11 +111,11 @@ static long tce_iommu_unregister_pages(struct tce_container *container,
>  	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK))
>  		return -EINVAL;
>  
> -	mem = mm_iommu_find(vaddr, size >> PAGE_SHIFT);
> +	mem = mm_iommu_find(container->mm, vaddr, size >> PAGE_SHIFT);
>  	if (!mem)
>  		return -ENOENT;
>  
> -	return mm_iommu_put(mem);
> +	return mm_iommu_put(container->mm, mem);
>  }
>  
>  static long tce_iommu_register_pages(struct tce_container *container,
> @@ -128,10 +129,17 @@ static long tce_iommu_register_pages(struct tce_container *container,
>  			((vaddr + size) < vaddr))
>  		return -EINVAL;
>  
> -	ret = mm_iommu_get(vaddr, entries, &mem);
> +	if (!container->mm) {
> +		if (!current->mm)
> +			return -ESRCH; /* process exited */

You may even want to check for PF_EXITING and ignore those tasks?

> +
> +		atomic_inc(&current->mm->mm_count);
> +		container->mm = current->mm;
> +	}
> +
> +	ret = mm_iommu_get(container->mm, vaddr, entries, &mem);
>  	if (ret)
>  		return ret;
> -
>  	container->enabled = true;
>  
>  	return 0;
> @@ -354,6 +362,8 @@ static void tce_iommu_release(void *iommu_data)
>  		tce_iommu_free_table(tbl);
>  	}
>  
> +	if (container->mm)
> +		mmdrop(container->mm);
>  	tce_iommu_disable(container);
>  	mutex_destroy(&container->lock);
>  
> @@ -369,13 +379,14 @@ static void tce_iommu_unuse_page(struct tce_container *container,
>  	put_page(page);
>  }
>  
> -static int tce_iommu_prereg_ua_to_hpa(unsigned long tce, unsigned long size,
> +static int tce_iommu_prereg_ua_to_hpa(struct tce_container *container,
> +		unsigned long tce, unsigned long size,
>  		unsigned long *phpa, struct mm_iommu_table_group_mem_t **pmem)
>  {
>  	long ret = 0;
>  	struct mm_iommu_table_group_mem_t *mem;
>  
> -	mem = mm_iommu_lookup(tce, size);
> +	mem = mm_iommu_lookup(container->mm, tce, size);
>  	if (!mem)
>  		return -EINVAL;
>  
> @@ -388,18 +399,18 @@ static int tce_iommu_prereg_ua_to_hpa(unsigned long tce, unsigned long size,
>  	return 0;
>  }
>  
> -static void tce_iommu_unuse_page_v2(struct iommu_table *tbl,
> -		unsigned long entry)
> +static void tce_iommu_unuse_page_v2(struct tce_container *container,
> +		struct iommu_table *tbl, unsigned long entry)
>  {
>  	struct mm_iommu_table_group_mem_t *mem = NULL;
>  	int ret;
>  	unsigned long hpa = 0;
>  	unsigned long *pua = IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
>  
> -	if (!pua || !current || !current->mm)
> +	if (!pua)
>  		return;
>  
> -	ret = tce_iommu_prereg_ua_to_hpa(*pua, IOMMU_PAGE_SIZE(tbl),
> +	ret = tce_iommu_prereg_ua_to_hpa(container, *pua, IOMMU_PAGE_SIZE(tbl),
>  			&hpa, &mem);
>  	if (ret)
>  		pr_debug("%s: tce %lx at #%lx was not cached, ret=%d\n",
> @@ -429,7 +440,7 @@ static int tce_iommu_clear(struct tce_container *container,
>  			continue;
>  
>  		if (container->v2) {
> -			tce_iommu_unuse_page_v2(tbl, entry);
> +			tce_iommu_unuse_page_v2(container, tbl, entry);
>  			continue;
>  		}
>  
> @@ -514,8 +525,8 @@ static long tce_iommu_build_v2(struct tce_container *container,
>  		unsigned long *pua = IOMMU_TABLE_USERSPACE_ENTRY(tbl,
>  				entry + i);
>  
> -		ret = tce_iommu_prereg_ua_to_hpa(tce, IOMMU_PAGE_SIZE(tbl),
> -				&hpa, &mem);
> +		ret = tce_iommu_prereg_ua_to_hpa(container,
> +				tce, IOMMU_PAGE_SIZE(tbl), &hpa, &mem);
>  		if (ret)
>  			break;
>  
> @@ -536,7 +547,7 @@ static long tce_iommu_build_v2(struct tce_container *container,
>  		ret = iommu_tce_xchg(tbl, entry + i, &hpa, &dirtmp);
>  		if (ret) {
>  			/* dirtmp cannot be DMA_NONE here */
> -			tce_iommu_unuse_page_v2(tbl, entry + i);
> +			tce_iommu_unuse_page_v2(container, tbl, entry + i);
>  			pr_err("iommu_tce: %s failed ioba=%lx, tce=%lx, ret=%ld\n",
>  					__func__, entry << tbl->it_page_shift,
>  					tce, ret);
> @@ -544,7 +555,7 @@ static long tce_iommu_build_v2(struct tce_container *container,
>  		}
>  
>  		if (dirtmp != DMA_NONE)
> -			tce_iommu_unuse_page_v2(tbl, entry + i);
> +			tce_iommu_unuse_page_v2(container, tbl, entry + i);
>  
>  		*pua = tce;
>  
> 
