Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
 [209.85.220.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EBCA71A0BCC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 13:35:18 +1100 (AEDT)
Received: by padcy3 with SMTP id cy3so69923375pad.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2015 19:35:17 -0700 (PDT)
Message-ID: <551CAADF.2020409@ozlabs.ru>
Date: Thu, 02 Apr 2015 13:35:11 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH kernel v7 28/31] powerpc/mmu: Add userspace-to-physical
 addresses translation cache
References: <1427468115-2224-1-git-send-email-aik@ozlabs.ru>	
 <1427468115-2224-29-git-send-email-aik@ozlabs.ru>
 <1427924889.5567.302.camel@redhat.com>
In-Reply-To: <1427924889.5567.302.camel@redhat.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/02/2015 08:48 AM, Alex Williamson wrote:
> On Sat, 2015-03-28 at 01:55 +1100, Alexey Kardashevskiy wrote:
>> We are adding support for DMA memory pre-registration to be used in
>> conjunction with VFIO. The idea is that the userspace which is going to
>> run a guest may want to pre-register a user space memory region so
>> it all gets pinned once and never goes away. Having this done,
>> a hypervisor will not have to pin/unpin pages on every DMA map/unmap
>> request. This is going to help with multiple pinning of the same memory
>> and in-kernel acceleration of DMA requests.
>>
>> This adds a list of memory regions to mm_context_t. Each region consists
>> of a header and a list of physical addresses. This adds API to:
>> 1. register/unregister memory regions;
>> 2. do final cleanup (which puts all pre-registered pages);
>> 3. do userspace to physical address translation;
>> 4. manage a mapped pages counter; when it is zero, it is safe to
>> unregister the region.
>>
>> Multiple registration of the same region is allowed, kref is used to
>> track the number of registrations.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>   arch/powerpc/include/asm/mmu-hash64.h      |   3 +
>>   arch/powerpc/include/asm/mmu_context.h     |  16 +++
>>   arch/powerpc/mm/Makefile                   |   1 +
>>   arch/powerpc/mm/mmu_context_hash64.c       |   6 +
>>   arch/powerpc/mm/mmu_context_hash64_iommu.c | 215 +++++++++++++++++++++++++++++
>>   5 files changed, 241 insertions(+)
>>   create mode 100644 arch/powerpc/mm/mmu_context_hash64_iommu.c
>>
>> diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
>> index 4f13c3e..83214c4 100644
>> --- a/arch/powerpc/include/asm/mmu-hash64.h
>> +++ b/arch/powerpc/include/asm/mmu-hash64.h
>> @@ -535,6 +535,9 @@ typedef struct {
>>   	/* for 4K PTE fragment support */
>>   	void *pte_frag;
>>   #endif
>> +#ifdef CONFIG_SPAPR_TCE_IOMMU
>> +	struct list_head iommu_group_mem_list;
>> +#endif
>>   } mm_context_t;
>>
>>
>> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
>> index 73382eb..3461c91 100644
>> --- a/arch/powerpc/include/asm/mmu_context.h
>> +++ b/arch/powerpc/include/asm/mmu_context.h
>> @@ -16,6 +16,22 @@
>>    */
>>   extern int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
>>   extern void destroy_context(struct mm_struct *mm);
>> +#ifdef CONFIG_SPAPR_TCE_IOMMU
>> +typedef struct mm_iommu_table_group_mem_t mm_iommu_table_group_mem_t;
>> +
>> +extern bool mm_iommu_preregistered(void);
>> +extern long mm_iommu_alloc(unsigned long ua, unsigned long entries,
>> +		mm_iommu_table_group_mem_t **pmem);
>> +extern mm_iommu_table_group_mem_t *mm_iommu_get(unsigned long ua,
>> +		unsigned long entries);
>> +extern long mm_iommu_put(mm_iommu_table_group_mem_t *mem);
>> +extern void mm_iommu_cleanup(mm_context_t *ctx);
>> +extern mm_iommu_table_group_mem_t *mm_iommu_lookup(unsigned long ua,
>> +		unsigned long size);
>> +extern long mm_iommu_ua_to_hpa(mm_iommu_table_group_mem_t *mem,
>> +		unsigned long ua, unsigned long *hpa);
>> +extern long mm_iommu_mapped_update(mm_iommu_table_group_mem_t *mem, bool inc);
>> +#endif
>>
>>   extern void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next);
>>   extern void switch_slb(struct task_struct *tsk, struct mm_struct *mm);
>> diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
>> index 438dcd3..49fbfc7 100644
>> --- a/arch/powerpc/mm/Makefile
>> +++ b/arch/powerpc/mm/Makefile
>> @@ -35,3 +35,4 @@ obj-$(CONFIG_PPC_SUBPAGE_PROT)	+= subpage-prot.o
>>   obj-$(CONFIG_NOT_COHERENT_CACHE) += dma-noncoherent.o
>>   obj-$(CONFIG_HIGHMEM)		+= highmem.o
>>   obj-$(CONFIG_PPC_COPRO_BASE)	+= copro_fault.o
>> +obj-$(CONFIG_SPAPR_TCE_IOMMU)	+= mmu_context_hash64_iommu.o
>> diff --git a/arch/powerpc/mm/mmu_context_hash64.c b/arch/powerpc/mm/mmu_context_hash64.c
>> index 178876ae..eb3080c 100644
>> --- a/arch/powerpc/mm/mmu_context_hash64.c
>> +++ b/arch/powerpc/mm/mmu_context_hash64.c
>> @@ -89,6 +89,9 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
>>   #ifdef CONFIG_PPC_64K_PAGES
>>   	mm->context.pte_frag = NULL;
>>   #endif
>> +#ifdef CONFIG_SPAPR_TCE_IOMMU
>> +	INIT_LIST_HEAD_RCU(&mm->context.iommu_group_mem_list);
>> +#endif
>>   	return 0;
>>   }
>>
>> @@ -132,6 +135,9 @@ static inline void destroy_pagetable_page(struct mm_struct *mm)
>>
>>   void destroy_context(struct mm_struct *mm)
>>   {
>> +#ifdef CONFIG_SPAPR_TCE_IOMMU
>> +	mm_iommu_cleanup(&mm->context);
>> +#endif
>>
>>   #ifdef CONFIG_PPC_ICSWX
>>   	drop_cop(mm->context.acop, mm);
>> diff --git a/arch/powerpc/mm/mmu_context_hash64_iommu.c b/arch/powerpc/mm/mmu_context_hash64_iommu.c
>> new file mode 100644
>> index 0000000..c268c4d
>> --- /dev/null
>> +++ b/arch/powerpc/mm/mmu_context_hash64_iommu.c
>> @@ -0,0 +1,215 @@
>> +/*
>> + *  IOMMU helpers in MMU context.
>> + *
>> + *  Copyright (C) 2015 IBM Corp. <aik@ozlabs.ru>
>> + *
>> + *  This program is free software; you can redistribute it and/or
>> + *  modify it under the terms of the GNU General Public License
>> + *  as published by the Free Software Foundation; either version
>> + *  2 of the License, or (at your option) any later version.
>> + *
>> + */
>> +
>> +#include <linux/sched.h>
>> +#include <linux/slab.h>
>> +#include <linux/rculist.h>
>> +#include <linux/vmalloc.h>
>> +#include <linux/kref.h>
>> +#include <asm/mmu_context.h>
>> +
>> +typedef struct mm_iommu_table_group_mem_t {
>> +	struct list_head next;
>> +	struct rcu_head rcu;
>> +	struct kref kref; /* one reference per VFIO container */
>> +	atomic_t mapped;/* number of currently mapped pages */
>> +	u64 ua; 	/* userspace address */
>> +	u64 entries; 	/* number of entries in hpas[] */
>> +	u64 *hpas;	/* vmalloc'ed */
>> +} mm_iommu_table_group_mem_t;
>> +
>> +bool mm_iommu_preregistered(void)
>> +{
>> +	if (!current || !current->mm)
>> +		return false;
>> +
>> +	return !list_empty(&current->mm->context.iommu_group_mem_list);
>> +}
>> +EXPORT_SYMBOL_GPL(mm_iommu_preregistered);
>> +
>> +long mm_iommu_alloc(unsigned long ua, unsigned long entries,
>> +		mm_iommu_table_group_mem_t **pmem)
>> +{
>> +	mm_iommu_table_group_mem_t *mem;
>> +	long i, j;
>> +	struct page *page = NULL;
>> +
>> +	list_for_each_entry_rcu(mem, &current->mm->context.iommu_group_mem_list,
>> +			next) {
>> +		if ((mem->ua == ua) && (mem->entries == entries))
>> +			return -EBUSY;
>> +
>> +		/* Overlap? */
>> +		if ((mem->ua < (ua + (entries << PAGE_SHIFT))) &&
>> +				(ua < (mem->ua + (mem->entries << PAGE_SHIFT))))
>> +			return -EINVAL;
>> +	}
>> +
>> +	mem = kzalloc(sizeof(*mem), GFP_KERNEL);
>> +	if (!mem)
>> +		return -ENOMEM;
>> +
>> +	mem->hpas = vzalloc(entries * sizeof(mem->hpas[0]));
>> +	if (!mem->hpas) {
>> +		kfree(mem);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	for (i = 0; i < entries; ++i) {
>> +		if (1 != get_user_pages_fast(ua + (i << PAGE_SHIFT),
>> +					1/* pages */, 1/* iswrite */, &page)) {
>> +			for (j = 0; j < i; ++j)
>> +				put_page(pfn_to_page(
>> +						mem->hpas[i] >> PAGE_SHIFT));
>
>
> Pretty sure you want [j] here


Absolutely. Good catch, thanks for the review.


>
>
>> +			vfree(mem->hpas);
>> +			kfree(mem);
>> +			return -EFAULT;
>> +		}
>> +
>> +		mem->hpas[i] = page_to_pfn(page) << PAGE_SHIFT;
>> +	}
>> +
>> +	kref_init(&mem->kref);
>> +	atomic_set(&mem->mapped, 0);
>> +	mem->ua = ua;
>> +	mem->entries = entries;
>> +	*pmem = mem;
>> +
>> +	list_add_rcu(&mem->next, &current->mm->context.iommu_group_mem_list);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(mm_iommu_alloc);
>> +
>> +static void mm_iommu_unpin(mm_iommu_table_group_mem_t *mem)
>> +{
>> +	long i;
>> +	struct page *page = NULL;
>> +
>> +	for (i = 0; i < mem->entries; ++i) {
>> +		if (!mem->hpas[i])
>> +			continue;
>> +
>> +		page = pfn_to_page(mem->hpas[i] >> PAGE_SHIFT);
>> +		if (!page)
>> +			continue;
>> +
>> +		put_page(page);
>> +		mem->hpas[i] = 0;
>> +	}
>> +}
>> +
>> +static void mm_iommu_free(struct rcu_head *head)
>> +{
>> +	mm_iommu_table_group_mem_t *mem = container_of(head,
>> +			mm_iommu_table_group_mem_t, rcu);
>> +
>> +	mm_iommu_unpin(mem);
>> +	vfree(mem->hpas);
>> +	kfree(mem);
>> +}
>> +
>> +static void mm_iommu_release(struct kref *kref)
>> +{
>> +	mm_iommu_table_group_mem_t *mem = container_of(kref,
>> +			mm_iommu_table_group_mem_t, kref);
>> +
>> +	list_del_rcu(&mem->next);
>> +	call_rcu(&mem->rcu, mm_iommu_free);
>> +}
>> +
>> +mm_iommu_table_group_mem_t *mm_iommu_get(unsigned long ua,
>> +		unsigned long entries)
>> +{
>> +	mm_iommu_table_group_mem_t *mem;
>> +
>> +	list_for_each_entry_rcu(mem, &current->mm->context.iommu_group_mem_list,
>> +			next) {
>> +		if ((mem->ua == ua) && (mem->entries == entries)) {
>> +			kref_get(&mem->kref);
>> +			return mem;
>> +		}
>> +	}
>> +
>> +	return NULL;
>> +}
>> +EXPORT_SYMBOL_GPL(mm_iommu_get);
>> +
>> +long mm_iommu_put(mm_iommu_table_group_mem_t *mem)
>> +{
>> +	if (atomic_read(&mem->mapped))
>> +		return -EBUSY;
>> +
>> +	kref_put(&mem->kref, mm_iommu_release);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(mm_iommu_put);
>> +
>> +mm_iommu_table_group_mem_t *mm_iommu_lookup(unsigned long ua,
>> +		unsigned long size)
>> +{
>> +	mm_iommu_table_group_mem_t *mem, *ret = NULL;
>> +
>> +	list_for_each_entry_rcu(mem,
>> +			&current->mm->context.iommu_group_mem_list,
>> +			next) {
>> +		if ((mem->ua <= ua) &&
>> +				(ua + size <= mem->ua +
>> +				 (mem->entries << PAGE_SHIFT))) {
>> +			ret = mem;
>> +			break;
>> +		}
>> +	}
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(mm_iommu_lookup);
>> +
>> +long mm_iommu_ua_to_hpa(mm_iommu_table_group_mem_t *mem,
>> +		unsigned long ua, unsigned long *hpa)
>> +{
>> +	const long entry = (ua - mem->ua) >> PAGE_SHIFT;
>> +	u64 *va = &mem->hpas[entry];
>> +
>> +	if (entry >= mem->entries)
>> +		return -EFAULT;
>> +
>> +	*hpa = *va | (ua & ~PAGE_MASK);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(mm_iommu_ua_to_hpa);
>> +
>> +long mm_iommu_mapped_update(mm_iommu_table_group_mem_t *mem, bool inc)
>> +{
>> +	long ret = 0;
>> +
>> +	if (inc)
>> +		atomic_inc(&mem->mapped);
>> +	else
>> +		ret = atomic_dec_if_positive(&mem->mapped);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(mm_iommu_mapped_update);
>> +
>> +void mm_iommu_cleanup(mm_context_t *ctx)
>> +{
>> +	while (!list_empty(&ctx->iommu_group_mem_list)) {
>> +		mm_iommu_table_group_mem_t *mem;
>> +
>> +		mem = list_first_entry(&ctx->iommu_group_mem_list,
>> +				mm_iommu_table_group_mem_t, next);
>> +		mm_iommu_release(&mem->kref);
>> +	}
>> +}
>
>
>


-- 
Alexey
