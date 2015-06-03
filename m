Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
 [209.85.220.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9FA651A016E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 21:27:20 +1000 (AEST)
Received: by pabqy3 with SMTP id qy3so5308313pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2015 04:27:18 -0700 (PDT)
Message-ID: <556EE48E.7080503@ozlabs.ru>
Date: Wed, 03 Jun 2015 21:27:10 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
CC: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v11 27/34] powerpc/powernv: Implement multilevel
 TCE tables
References: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
 <1432889098-22924-28-git-send-email-aik@ozlabs.ru>
 <20150601235025.GQ22789@voom.redhat.com>
In-Reply-To: <20150601235025.GQ22789@voom.redhat.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/02/2015 09:50 AM, David Gibson wrote:
> On Fri, May 29, 2015 at 06:44:51PM +1000, Alexey Kardashevskiy wrote:
>> TCE tables might get too big in case of 4K IOMMU pages and DDW enabled
>> on huge guests (hundreds of GB of RAM) so the kernel might be unable to
>> allocate contiguous chunk of physical memory to store the TCE table.
>>
>> To address this, POWER8 CPU (actually, IODA2) supports multi-level
>> TCE tables, up to 5 levels which splits the table into a tree of
>> smaller subtables.
>>
>> This adds multi-level TCE tables support to
>> pnv_pci_ioda2_table_alloc_pages() and pnv_pci_ioda2_table_free_pages()
>> helpers.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>> Changes:
>> v10:
>> * fixed multiple comments received for v9
>>
>> v9:
>> * moved from ioda2 to common powernv pci code
>> * fixed cleanup if allocation fails in a middle
>> * removed check for the size - all boundary checks happen in the calling code
>> anyway
>> ---
>>   arch/powerpc/include/asm/iommu.h          |  2 +
>>   arch/powerpc/platforms/powernv/pci-ioda.c | 98 ++++++++++++++++++++++++++++---
>>   arch/powerpc/platforms/powernv/pci.c      | 13 ++++
>>   3 files changed, 104 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
>> index 4636734..706cfc0 100644
>> --- a/arch/powerpc/include/asm/iommu.h
>> +++ b/arch/powerpc/include/asm/iommu.h
>> @@ -96,6 +96,8 @@ struct iommu_pool {
>>   struct iommu_table {
>>   	unsigned long  it_busno;     /* Bus number this table belongs to */
>>   	unsigned long  it_size;      /* Size of iommu table in entries */
>> +	unsigned long  it_indirect_levels;
>> +	unsigned long  it_level_size;
>>   	unsigned long  it_offset;    /* Offset into global table */
>>   	unsigned long  it_base;      /* mapped address of tce table */
>>   	unsigned long  it_index;     /* which iommu table this is */
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index fda01c1..68ffc7a 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -49,6 +49,9 @@
>>   /* 256M DMA window, 4K TCE pages, 8 bytes TCE */
>>   #define TCE32_TABLE_SIZE	((0x10000000 / 0x1000) * 8)
>>
>> +#define POWERNV_IOMMU_DEFAULT_LEVELS	1
>> +#define POWERNV_IOMMU_MAX_LEVELS	5
>> +
>>   static void pnv_pci_ioda2_table_free_pages(struct iommu_table *tbl);
>>
>>   static void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
>> @@ -1975,6 +1978,8 @@ static long pnv_pci_ioda2_set_window(struct iommu_table_group *table_group,
>>   			table_group);
>>   	struct pnv_phb *phb = pe->phb;
>>   	int64_t rc;
>> +	const unsigned long size = tbl->it_indirect_levels ?
>> +			tbl->it_level_size : tbl->it_size;
>>   	const __u64 start_addr = tbl->it_offset << tbl->it_page_shift;
>>   	const __u64 win_size = tbl->it_size << tbl->it_page_shift;
>>
>> @@ -1989,9 +1994,9 @@ static long pnv_pci_ioda2_set_window(struct iommu_table_group *table_group,
>>   	rc = opal_pci_map_pe_dma_window(phb->opal_id,
>>   			pe->pe_number,
>>   			pe->pe_number << 1,
>> -			1,
>> +			tbl->it_indirect_levels + 1,
>>   			__pa(tbl->it_base),
>> -			tbl->it_size << 3,
>> +			size << 3,
>>   			IOMMU_PAGE_SIZE(tbl));
>>   	if (rc) {
>>   		pe_err(pe, "Failed to configure TCE table, err %ld\n", rc);
>> @@ -2071,11 +2076,19 @@ static void pnv_pci_ioda_setup_opal_tce_kill(struct pnv_phb *phb)
>>   	phb->ioda.tce_inval_reg = ioremap(phb->ioda.tce_inval_reg_phys, 8);
>>   }
>>
>> -static __be64 *pnv_pci_ioda2_table_do_alloc_pages(int nid, unsigned shift)
>> +static __be64 *pnv_pci_ioda2_table_do_alloc_pages(int nid, unsigned shift,
>> +		unsigned levels, unsigned long limit,
>> +		unsigned long *tce_table_allocated)
>>   {
>>   	struct page *tce_mem = NULL;
>> -	__be64 *addr;
>> +	__be64 *addr, *tmp;
>>   	unsigned order = max_t(unsigned, shift, PAGE_SHIFT) - PAGE_SHIFT;
>> +	unsigned long local_allocated = 1UL << (order + PAGE_SHIFT);
>> +	unsigned entries = 1UL << (shift - 3);
>> +	long i;
>> +
>> +	if (*tce_table_allocated >= limit)
>> +		return NULL;
>
> I'm not quite clear what case this limit logic is trying to catch.


The function is allocating some amount of entries which may be in one chunk 
of memory and spread between multiple chunks in multiple levels. "limit" is 
the amount of memory for actual TCEs (not intermediate levels). If I do not 
do this, and the user requests 5 levels, and I do not check this, more 
memory will be allocated that actually needed because size of the window is 
limited.



>>
>>   	tce_mem = alloc_pages_node(nid, GFP_KERNEL, order);
>>   	if (!tce_mem) {
>> @@ -2083,31 +2096,69 @@ static __be64 *pnv_pci_ioda2_table_do_alloc_pages(int nid, unsigned shift)
>>   		return NULL;
>>   	}
>>   	addr = page_address(tce_mem);
>> -	memset(addr, 0, 1UL << (order + PAGE_SHIFT));
>> +	memset(addr, 0, local_allocated);
>> +
>> +	--levels;
>> +	if (!levels) {
>> +		*tce_table_allocated += local_allocated;
>> +		return addr;
>> +	}
>> +
>> +	for (i = 0; i < entries; ++i) {
>> +		tmp = pnv_pci_ioda2_table_do_alloc_pages(nid, shift,
>> +				levels, limit, tce_table_allocated);
>> +		if (!tmp)
>> +			break;
>> +
>> +		addr[i] = cpu_to_be64(__pa(tmp) |
>> +				TCE_PCI_READ | TCE_PCI_WRITE);
>> +	}
>>
>>   	return addr;
>>   }
>>
>> +static void pnv_pci_ioda2_table_do_free_pages(unsigned long addr,
>> +		unsigned long size, unsigned level);
>> +
>>   static long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
>> -		__u32 page_shift, __u64 window_size, struct iommu_table *tbl)
>> +		__u32 page_shift, __u64 window_size, __u32 levels,
>> +		struct iommu_table *tbl)
>>   {
>>   	void *addr;
>> +	unsigned long tce_table_allocated = 0, level_shift;
>>   	const unsigned window_shift = ilog2(window_size);
>>   	unsigned entries_shift = window_shift - page_shift;
>>   	unsigned table_shift = max_t(unsigned, entries_shift + 3, PAGE_SHIFT);
>>   	const unsigned long tce_table_size = 1UL << table_shift;
>>
>> +	if (!levels || (levels > POWERNV_IOMMU_MAX_LEVELS))
>> +		return -EINVAL;
>> +
>>   	if ((window_size > memory_hotplug_max()) || !is_power_of_2(window_size))
>>   		return -EINVAL;
>>
>> +	/* Adjust direct table size from window_size and levels */
>> +	entries_shift = (entries_shift + levels - 1) / levels;
>> +	level_shift = entries_shift + 3;
>> +	level_shift = max_t(unsigned, level_shift, PAGE_SHIFT);
>> +
>>   	/* Allocate TCE table */
>> -	addr = pnv_pci_ioda2_table_do_alloc_pages(nid, table_shift);
>> +	addr = pnv_pci_ioda2_table_do_alloc_pages(nid, level_shift,
>> +			levels, tce_table_size, &tce_table_allocated);
>>   	if (!addr)
>>   		return -ENOMEM;
>
> If the do_alloc_pages hits the limit partway through its recursion
> this will leak memory.

Oh, right.


>>
>> +	if (tce_table_size > tce_table_allocated) {
>> +		pnv_pci_ioda2_table_do_free_pages((unsigned long) addr,
>> +				1ULL << (level_shift - 3), levels - 1);
>> +		return -ENOMEM;
>
> The logic here doesn't quite make sense to me.  Is this trying to
> catch the case where do_alloc_pages hit the limit before completing?
> Comparing the total memory allocated by all the levels to the amount
> that would be allocated by a linear table doesn't seem like a useful
> thing to do.

tce_table_size is how much memory we want for actual TCEs. 
tce_table_allocated is how much we managed to allocate. If we allocated 
less than we wanted, then it is a failure.

Only actual (last level) TCEs are counted in tce_table_allocated.



>> +	}
>> +
>>   	/* Setup linux iommu table */
>>   	pnv_pci_setup_iommu_table(tbl, addr, tce_table_size, bus_offset,
>>   			page_shift);
>> +	tbl->it_level_size = 1ULL << (level_shift - 3);
>> +	tbl->it_indirect_levels = levels - 1;
>>
>>   	pr_devel("Created TCE table: ws=%08llx ts=%lx @%08llx\n",
>>   			window_size, tce_table_size, bus_offset);
>> @@ -2115,12 +2166,40 @@ static long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
>>   	return 0;
>>   }
>>
>> +static void pnv_pci_ioda2_table_do_free_pages(unsigned long addr,
>
> Since addr is a virtual address, not a physical one, it should be
> passed as a pointer.

Fair point.


>> +		unsigned long size, unsigned level)
>> +{
>> +	addr &= ~(TCE_PCI_READ | TCE_PCI_WRITE);
>> +
>> +	if (level) {
>> +		long i;
>> +		u64 *tmp = (u64 *) addr;
>> +
>> +		for (i = 0; i < size; ++i) {
>> +			unsigned long hpa = be64_to_cpu(tmp[i]);
>> +
>> +			if (!(hpa & (TCE_PCI_READ | TCE_PCI_WRITE)))
>> +				continue;
>> +
>> +			pnv_pci_ioda2_table_do_free_pages(
>> +					(unsigned long) __va(hpa),
>> +					size, level - 1);
>> +		}
>> +	}
>> +
>> +	free_pages(addr, get_order(size << 3));
>> +}
>> +
>>   static void pnv_pci_ioda2_table_free_pages(struct iommu_table *tbl)
>>   {
>> +	const unsigned long size = tbl->it_indirect_levels ?
>> +			tbl->it_level_size : tbl->it_size;
>> +
>>   	if (!tbl->it_size)
>>   		return;
>>
>> -	free_pages(tbl->it_base, get_order(tbl->it_size << 3));
>> +	pnv_pci_ioda2_table_do_free_pages(tbl->it_base, size,
>> +			tbl->it_indirect_levels);
>>   }
>>
>>   static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>> @@ -2148,7 +2227,8 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>>
>>   	/* Setup linux iommu table */
>>   	rc = pnv_pci_ioda2_table_alloc_pages(pe->phb->hose->node,
>> -			0, IOMMU_PAGE_SHIFT_4K, phb->ioda.m32_pci_base, tbl);
>> +			0, IOMMU_PAGE_SHIFT_4K, phb->ioda.m32_pci_base,
>> +			POWERNV_IOMMU_DEFAULT_LEVELS, tbl);
>>   	if (rc) {
>>   		pe_err(pe, "Failed to create 32-bit TCE table, err %ld", rc);
>>   		goto fail;
>> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
>> index dce3bfd..d4e59f7 100644
>> --- a/arch/powerpc/platforms/powernv/pci.c
>> +++ b/arch/powerpc/platforms/powernv/pci.c
>> @@ -575,6 +575,19 @@ struct pci_ops pnv_pci_ops = {
>>   static __be64 *pnv_tce(struct iommu_table *tbl, long idx)
>>   {
>>   	__be64 *tmp = ((__be64 *)tbl->it_base);
>> +	int  level = tbl->it_indirect_levels;
>> +	const long shift = ilog2(tbl->it_level_size);
>> +	unsigned long mask = (tbl->it_level_size - 1) << (level * shift);
>> +
>> +	while (level) {
>> +		int n = (idx & mask) >> (level * shift);
>> +		unsigned long tce = be64_to_cpu(tmp[n]);
>> +
>> +		tmp = __va(tce & ~(TCE_PCI_READ | TCE_PCI_WRITE));
>> +		idx &= ~mask;
>> +		mask >>= shift;
>> +		--level;
>> +	}
>>
>>   	return tmp + idx;
>>   }
>


-- 
Alexey
