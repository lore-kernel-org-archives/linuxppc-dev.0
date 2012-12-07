Return-Path: <tangchen@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id 831D82C00C6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2012 17:44:53 +1100 (EST)
Message-ID: <50C19022.9000501@cn.fujitsu.com>
Date: Fri, 07 Dec 2012 14:43:46 +0800
From: Tang Chen <tangchen@cn.fujitsu.com>
MIME-Version: 1.0
To: Wen Congyang <wency@cn.fujitsu.com>
Subject: Re: [Patch v4 09/12] memory-hotplug: remove page table of x86_64
 architecture
References: <1354010422-19648-1-git-send-email-wency@cn.fujitsu.com>
 <1354010422-19648-10-git-send-email-wency@cn.fujitsu.com>
In-Reply-To: <1354010422-19648-10-git-send-email-wency@cn.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, linux-mm@kvack.org,
 paulus@samba.org, sparclinux@vger.kernel.org, Christoph Lameter <cl@linux.com>,
 linux-s390@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org,
 Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>,
 KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
 David Rientjes <rientjes@google.com>, Jiang Liu <liuj97@gmail.com>,
 Len Brown <len.brown@intel.com>, Jiang Liu <jiang.liu@huawei.com>,
 cmetcalf@tilera.com, Jianguo Wu <wujianguo@huawei.com>,
 linux-kernel@vger.kernel.org, Minchan Kim <minchan.kim@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/27/2012 06:00 PM, Wen Congyang wrote:
> For hot removing memory, we sholud remove page table about the memory.
> So the patch searches a page table about the removed memory, and clear
> page table.

(snip)

> +void __meminit
> +kernel_physical_mapping_remove(unsigned long start, unsigned long end)
> +{
> +	unsigned long next;
> +	bool pgd_changed = false;
> +
> +	start = (unsigned long)__va(start);
> +	end = (unsigned long)__va(end);

Hi Wu,

Here, you expect start and end are physical addresses. But in
phys_xxx_remove() function, I think using virtual addresses is just
fine. Functions like pmd_addr_end() and pud_index() only calculate
an offset.

So, would you please tell me if we have to use physical addresses here ?

Thanks. :)

> +
> +	for (; start<  end; start = next) {
> +		pgd_t *pgd = pgd_offset_k(start);
> +		pud_t *pud;
> +
> +		next = pgd_addr_end(start, end);
> +
> +		if (!pgd_present(*pgd))
> +			continue;
> +
> +		pud = map_low_page((pud_t *)pgd_page_vaddr(*pgd));
> +		phys_pud_remove(pud, __pa(start), __pa(next));
> +		if (free_pud_table(pud, pgd))
> +			pgd_changed = true;
> +		unmap_low_page(pud);
> +	}
> +
> +	if (pgd_changed)
> +		sync_global_pgds(start, end - 1);
> +
> +	flush_tlb_all();
> +}
> +
>   #ifdef CONFIG_MEMORY_HOTREMOVE
>   int __ref arch_remove_memory(u64 start, u64 size)
>   {
> @@ -692,6 +921,8 @@ int __ref arch_remove_memory(u64 start, u64 size)
>   	ret = __remove_pages(zone, start_pfn, nr_pages);
>   	WARN_ON_ONCE(ret);
>
> +	kernel_physical_mapping_remove(start, start + size);
> +
>   	return ret;
>   }
>   #endif
