Return-Path: <isimatu.yasuaki@jp.fujitsu.com>
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 01AD82C0080
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 16:48:58 +1000 (EST)
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id EE95F3EE0B5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 15:48:55 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id D620345DE7E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 15:48:55 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id BA83E45DEB2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 15:48:55 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id AD7A31DB8038
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 15:48:55 +0900 (JST)
Received: from g01jpexchkw01.g01.fujitsu.local
 (g01jpexchkw01.g01.fujitsu.local [10.0.194.40])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 690F5E08002
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 15:48:55 +0900 (JST)
Message-ID: <4FFD21C2.6000201@jp.fujitsu.com>
Date: Wed, 11 Jul 2012 15:48:34 +0900
From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
MIME-Version: 1.0
To: Wen Congyang <wency@cn.fujitsu.com>
Subject: Re: [RFC PATCH v3 11/13] memory-hotplug : free memmap of
 sparse-vmemmap
References: <4FFAB0A2.8070304@jp.fujitsu.com>
 <4FFAB37F.1060105@jp.fujitsu.com> <4FFD09D5.8010605@cn.fujitsu.com>
 <4FFD14B0.9010606@jp.fujitsu.com> <4FFD1C71.2020404@cn.fujitsu.com>
In-Reply-To: <4FFD1C71.2020404@cn.fujitsu.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, paulus@samba.org,
 minchan.kim@gmail.com, kosaki.motohiro@jp.fujitsu.com, rientjes@google.com,
 cl@linux.com, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org,
 liuj97@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Wen,

2012/07/11 15:25, Wen Congyang wrote:
> At 07/11/2012 01:52 PM, Yasuaki Ishimatsu Wrote:
>> 2012/07/11 14:06, Wen Congyang wrote:
>> Hi Wen,
>>
>>> At 07/09/2012 06:33 PM, Yasuaki Ishimatsu Wrote:
>>>> I don't think that all pages of virtual mapping in removed memory can be
>>>> freed, since page which type is MIX_SECTION_INFO is difficult to free.
>>>> So, the patch only frees page which type is SECTION_INFO at first.
>>>>
>>>> CC: David Rientjes <rientjes@google.com>
>>>> CC: Jiang Liu <liuj97@gmail.com>
>>>> CC: Len Brown <len.brown@intel.com>
>>>> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>>> CC: Paul Mackerras <paulus@samba.org>
>>>> CC: Christoph Lameter <cl@linux.com>
>>>> Cc: Minchan Kim <minchan.kim@gmail.com>
>>>> CC: Andrew Morton <akpm@linux-foundation.org>
>>>> CC: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
>>>> CC: Wen Congyang <wency@cn.fujitsu.com>
>>>> Signed-off-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
>>>>
>>>> ---
>>>>    arch/x86/mm/init_64.c |   91 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>    include/linux/mm.h    |    2 +
>>>>    mm/memory_hotplug.c   |    5 ++
>>>>    mm/sparse.c           |    5 +-
>>>>    4 files changed, 101 insertions(+), 2 deletions(-)
>>>>
>>>> Index: linux-3.5-rc4/include/linux/mm.h
>>>> ===================================================================
>>>> --- linux-3.5-rc4.orig/include/linux/mm.h	2012-07-03 14:22:18.530011567 +0900
>>>> +++ linux-3.5-rc4/include/linux/mm.h	2012-07-03 14:22:20.999983872 +0900
>>>> @@ -1588,6 +1588,8 @@ int vmemmap_populate(struct page *start_
>>>>    void vmemmap_populate_print_last(void);
>>>>    void register_page_bootmem_memmap(unsigned long section_nr, struct page *map,
>>>>    				  unsigned long size);
>>>> +void vmemmap_kfree(struct page *memmpa, unsigned long nr_pages);
>>>> +void vmemmap_free_bootmem(struct page *memmpa, unsigned long nr_pages);
>>>>
>>>>    enum mf_flags {
>>>>    	MF_COUNT_INCREASED = 1 << 0,
>>>> Index: linux-3.5-rc4/mm/sparse.c
>>>> ===================================================================
>>>> --- linux-3.5-rc4.orig/mm/sparse.c	2012-07-03 14:21:45.071429805 +0900
>>>> +++ linux-3.5-rc4/mm/sparse.c	2012-07-03 14:22:21.000983767 +0900
>>>> @@ -614,12 +614,13 @@ static inline struct page *kmalloc_secti
>>>>    	/* This will make the necessary allocations eventually. */
>>>>    	return sparse_mem_map_populate(pnum, nid);
>>>>    }
>>>> -static void __kfree_section_memmap(struct page *memmap, unsigned long nr_pages)
>>>> +static void __kfree_section_memmap(struct page *page, unsigned long nr_pages)
>>>>    {
>>>> -	return; /* XXX: Not implemented yet */
>>>> +	vmemmap_kfree(page, nr_pages);
>>>
>>> Hmm, I think you try to free the memory allocated in kmalloc_section_memmap().
>>
>> Yes.
>>
>>>
>>>>    }
>>>>    static void free_map_bootmem(struct page *page, unsigned long nr_pages)
>>>>    {
>>>> +	vmemmap_free_bootmem(page, nr_pages);
>>>>    }
>>>
>>> Hmm, which function is the memory you try to free allocated in?
>>
>> The function try to free memory allocated from bootmem. The memory has
>> been registered by get_page_bootmem(). So we can free the memory by
>> put_page_bootmem().
> 
> OK, I will read these codes, and check it.
> 
>>
>>>
>>>>    #else
>>>>    static struct page *__kmalloc_section_memmap(unsigned long nr_pages)
>>>> Index: linux-3.5-rc4/arch/x86/mm/init_64.c
>>>> ===================================================================
>>>> --- linux-3.5-rc4.orig/arch/x86/mm/init_64.c	2012-07-03 14:22:18.538011465 +0900
>>>> +++ linux-3.5-rc4/arch/x86/mm/init_64.c	2012-07-03 14:22:21.007983103 +0900
>>>> @@ -978,6 +978,97 @@ vmemmap_populate(struct page *start_page
>>>>    	return 0;
>>>>    }
>>>>
>>>> +unsigned long find_and_clear_pte_page(unsigned long addr, unsigned long end,
>>>> +				      struct page **pp)
>>>> +{
>>>> +	pgd_t *pgd;
>>>> +	pud_t *pud;
>>>> +	pmd_t *pmd;
>>>> +	pte_t *pte;
>>>> +	unsigned long next;
>>>> +
>>>> +	*pp = NULL;
>>>> +
>>>> +	pgd = pgd_offset_k(addr);
>>>> +	if (pgd_none(*pgd))
>>>> +		return (addr + PAGE_SIZE) & PAGE_MASK;
>>>
>>> Hmm, why not goto next pgd?
>>
>> Does it mean "return (addr + PGDIR_SIZE) & PGDIR_MASK"?
>>
>>>
>>>> +
>>>> +	pud = pud_offset(pgd, addr);
>>>> +	if (pud_none(*pud))
>>>> +		return (addr + PAGE_SIZE) & PAGE_MASK;
>>>> +
>>>> +	if (!cpu_has_pse) {
>>>> +		next = (addr + PAGE_SIZE) & PAGE_MASK;
>>>> +		pmd = pmd_offset(pud, addr);
>>>> +		if (pmd_none(*pmd))
>>>> +			return next;
>>>> +
>>>> +		pte = pte_offset_kernel(pmd, addr);
>>>> +		if (pte_none(*pte))
>>>> +			return next;
>>>> +
>>>> +		*pp = pte_page(*pte);
>>>> +		pte_clear(&init_mm, addr, pte);
>>>
>>> I think you should flush tlb here.
>>
>> Thanks, I'll update it.
>>
>>>
>>>> +	} else {
>>>> +		next = pmd_addr_end(addr, end);
>>>> +
>>>> +		pmd = pmd_offset(pud, addr);
>>>> +		if (pmd_none(*pmd))
>>>> +			return next;
>>>> +
>>>> +		*pp = pmd_page(*pmd);
>>>> +		pmd_clear(pmd);
>>>> +	}
>>>> +
>>>> +	return next;
>>>> +}
>>>> +
>>>> +void __meminit
>>>> +vmemmap_kfree(struct page *memmap, unsigned long nr_pages)
>>>> +{
>>>> +	unsigned long addr = (unsigned long)memmap;
>>>> +	unsigned long end = (unsigned long)(memmap + nr_pages);
>>>> +	unsigned long next;
>>>> +	unsigned int order;
>>>> +	struct page *page;
>>>> +
>>>> +	for (; addr < end; addr = next) {
>>>> +		page = NULL;
>>>> +		next = find_and_clear_pte_page(addr, end, &page);
>>>> +		if (!page)
>>>> +			continue;
>>>> +
>>>> +		if (is_vmalloc_addr(page_address(page)))
>>>> +			vfree(page_address(page));
>>>
>>> Hmm, the memory is allocated in vmemmap_alloc_block(), and the address
>>> can not be vmalloc address.
>>
>> Does it mean the if sentence is unnecessary?
>>
>>>
>>>> +		else {
>>>> +			order = next - addr;
>>>> +			free_pages((unsigned long)page_address(page),
>>>> +				   get_order(order));
>>>
>>> OOPS. I think we cannot free pages here.
>>>
>>> sizeof(struct page) is less than PAGE_SIZE. We store more than one struct
>>> page in the same page. If you free it here while the other struct page
>>> is in use, it is very dangerous.
>>
>> The memory has page structures for hot-removed memory. So nobody is using
>> these pages, since the hot-removed memory has been offlined.
> 
> The memory has page structures for hot-removed memory, but it may contain
> page structures for the other hot-added memory.

Yes. There may be such corner case. But when does the corner case appear?
When removed memory is not aligned to PMD_SIZE/PAGE_SIZE, does the corner
case appear? Do you know it?

Thank,
Yasuaki Ishimatsu

> 
> IIUC, If we use sparse-vmemmap, all page structures is stored here.
> 
> Thanks
> Wen Congyang
> 
>>
>>>> +		}
>>>> +	}
>>>> +}
>>>> +
>>>> +void __meminit
>>>> +vmemmap_free_bootmem(struct page *memmap, unsigned long nr_pages)
>>>> +{
>>>> +	unsigned long addr = (unsigned long)memmap;
>>>> +	unsigned long end = (unsigned long)(memmap + nr_pages);
>>>> +	unsigned long next;
>>>> +	struct page *page;
>>>> +	unsigned long magic;
>>>> +
>>>> +	for (; addr < end; addr = next) {
>>>> +		page = NULL;
>>>> +		next = find_and_clear_pte_page(addr, end, &page);
>>>> +		if (!page)
>>>> +			continue;
>>>> +
>>>> +		magic = (unsigned long) page->lru.next;
>>>> +		if (magic == SECTION_INFO)
>>>> +			put_page_bootmem(page);
>>>> +	}
>>>> +}
>>>> +
>>>>    void __meminit
>>>>    register_page_bootmem_memmap(unsigned long section_nr, struct page *start_page,
>>>>    			     unsigned long size)
>>>> Index: linux-3.5-rc4/mm/memory_hotplug.c
>>>> ===================================================================
>>>> --- linux-3.5-rc4.orig/mm/memory_hotplug.c	2012-07-03 14:22:18.522011667 +0900
>>>> +++ linux-3.5-rc4/mm/memory_hotplug.c	2012-07-03 14:22:21.012982694 +0900
>>>> @@ -303,6 +303,8 @@ static int __meminit __add_section(int n
>>>>    #ifdef CONFIG_SPARSEMEM_VMEMMAP
>>>
>>> I think this line can be removed now.
>>
>> I'll update it.
>>
>> Thanks,
>> Yasuaki Ishimatsu
>>
>>>
>>> Thanks
>>> Wen Congyang
>>>
>>>>    static int __remove_section(struct zone *zone, struct mem_section *ms)
>>>>    {
>>>> +	unsigned long flags;
>>>> +	struct pglist_data *pgdat = zone->zone_pgdat;
>>>>    	int ret;
>>>>
>>>>    	if (!valid_section(ms))
>>>> @@ -310,6 +312,9 @@ static int __remove_section(struct zone
>>>>
>>>>    	ret = unregister_memory_section(ms);
>>>>
>>>> +	pgdat_resize_lock(pgdat, &flags);
>>>> +	sparse_remove_one_section(zone, ms);
>>>> +	pgdat_resize_unlock(pgdat, &flags);
>>>>    	return ret;
>>>>    }
>>>>    #else
>>>>
>>>>
>>>
>>
>>
>>
>>
> 
