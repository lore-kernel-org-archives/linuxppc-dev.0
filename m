Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
 [209.85.220.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8F01D1A0033
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 19:56:27 +1000 (AEST)
Received: by pacwv17 with SMTP id wv17so55130799pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 02:56:25 -0700 (PDT)
Message-ID: <5541FC41.9040409@ozlabs.ru>
Date: Thu, 30 Apr 2015 19:56:17 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel v9 23/32] powerpc/powernv/ioda: Define and implement
 DMA table/window management callbacks
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-24-git-send-email-aik@ozlabs.ru>
 <20150429053051.GT32589@voom.redhat.com> <5540A7F4.70903@ozlabs.ru>
 <20150430043750.GH15238@voom.redhat.com>
In-Reply-To: <20150430043750.GH15238@voom.redhat.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/30/2015 02:37 PM, David Gibson wrote:
> On Wed, Apr 29, 2015 at 07:44:20PM +1000, Alexey Kardashevskiy wrote:
>> On 04/29/2015 03:30 PM, David Gibson wrote:
>>> On Sat, Apr 25, 2015 at 10:14:47PM +1000, Alexey Kardashevskiy wrote:
>>>> This extends iommu_table_group_ops by a set of callbacks to support
>>>> dynamic DMA windows management.
>>>>
>>>> create_table() creates a TCE table with specific parameters.
>>>> it receives iommu_table_group to know nodeid in order to allocate
>>>> TCE table memory closer to the PHB. The exact format of allocated
>>>> multi-level table might be also specific to the PHB model (not
>>>> the case now though).
>>>> This callback calculated the DMA window offset on a PCI bus from @num
>>>> and stores it in a just created table.
>>>>
>>>> set_window() sets the window at specified TVT index + @num on PHB.
>>>>
>>>> unset_window() unsets the window from specified TVT.
>>>>
>>>> This adds a free() callback to iommu_table_ops to free the memory
>>>> (potentially a tree of tables) allocated for the TCE table.
>>>
>>> Doesn't the free callback belong with the previous patch introducing
>>> multi-level tables?
>>
>>
>>
>> If I did that, you would say "why is it here if nothing calls it" on
>> "multilevel" patch and "I see the allocation but I do not see memory
>> release" ;)
>
> Yeah, fair enough ;)
>
>> I need some rule of thumb here. I think it is a bit cleaner if the same
>> patch adds a callback for memory allocation and its counterpart, no?
>
> On further consideration, yes, I think you're right.
>
>>>> create_table() and free() are supposed to be called once per
>>>> VFIO container and set_window()/unset_window() are supposed to be
>>>> called for every group in a container.
>>>>
>>>> This adds IOMMU capabilities to iommu_table_group such as default
>>>> 32bit window parameters and others.
>>>>
>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>> ---
>>>>   arch/powerpc/include/asm/iommu.h            | 19 ++++++++
>>>>   arch/powerpc/platforms/powernv/pci-ioda.c   | 75 ++++++++++++++++++++++++++---
>>>>   arch/powerpc/platforms/powernv/pci-p5ioc2.c | 12 +++--
>>>>   3 files changed, 96 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
>>>> index 0f50ee2..7694546 100644
>>>> --- a/arch/powerpc/include/asm/iommu.h
>>>> +++ b/arch/powerpc/include/asm/iommu.h
>>>> @@ -70,6 +70,7 @@ struct iommu_table_ops {
>>>>   	/* get() returns a physical address */
>>>>   	unsigned long (*get)(struct iommu_table *tbl, long index);
>>>>   	void (*flush)(struct iommu_table *tbl);
>>>> +	void (*free)(struct iommu_table *tbl);
>>>>   };
>>>>
>>>>   /* These are used by VIO */
>>>> @@ -148,6 +149,17 @@ extern struct iommu_table *iommu_init_table(struct iommu_table * tbl,
>>>>   struct iommu_table_group;
>>>>
>>>>   struct iommu_table_group_ops {
>>>> +	long (*create_table)(struct iommu_table_group *table_group,
>>>> +			int num,
>>>> +			__u32 page_shift,
>>>> +			__u64 window_size,
>>>> +			__u32 levels,
>>>> +			struct iommu_table *tbl);
>>>> +	long (*set_window)(struct iommu_table_group *table_group,
>>>> +			int num,
>>>> +			struct iommu_table *tblnew);
>>>> +	long (*unset_window)(struct iommu_table_group *table_group,
>>>> +			int num);
>>>>   	/*
>>>>   	 * Switches ownership from the kernel itself to an external
>>>>   	 * user. While onwership is taken, the kernel cannot use IOMMU itself.
>>>> @@ -160,6 +172,13 @@ struct iommu_table_group {
>>>>   #ifdef CONFIG_IOMMU_API
>>>>   	struct iommu_group *group;
>>>>   #endif
>>>> +	/* Some key properties of IOMMU */
>>>> +	__u32 tce32_start;
>>>> +	__u32 tce32_size;
>>>> +	__u64 pgsizes; /* Bitmap of supported page sizes */
>>>> +	__u32 max_dynamic_windows_supported;
>>>> +	__u32 max_levels;
>>>
>>> With this information, table_group seems even more like a bad name.
>>> "iommu_state" maybe?
>>
>>
>> Please, no. We will never come to agreement then :( And "iommu_state" is too
>> general anyway, it won't pass.
>>
>>
>>>>   	struct iommu_table tables[IOMMU_TABLE_GROUP_MAX_TABLES];
>>>>   	struct iommu_table_group_ops *ops;
>>>>   };
>>>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>> index cc1d09c..4828837 100644
>>>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>> @@ -24,6 +24,7 @@
>>>>   #include <linux/msi.h>
>>>>   #include <linux/memblock.h>
>>>>   #include <linux/iommu.h>
>>>> +#include <linux/sizes.h>
>>>>
>>>>   #include <asm/sections.h>
>>>>   #include <asm/io.h>
>>>> @@ -1846,6 +1847,7 @@ static struct iommu_table_ops pnv_ioda2_iommu_ops = {
>>>>   #endif
>>>>   	.clear = pnv_ioda2_tce_free,
>>>>   	.get = pnv_tce_get,
>>>> +	.free = pnv_pci_free_table,
>>>>   };
>>>>
>>>>   static void pnv_pci_ioda_setup_opal_tce_kill(struct pnv_phb *phb,
>>>> @@ -1936,6 +1938,8 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
>>>>   				 TCE_PCI_SWINV_PAIR);
>>>>
>>>>   	tbl->it_ops = &pnv_ioda1_iommu_ops;
>>>> +	pe->table_group.tce32_start = tbl->it_offset << tbl->it_page_shift;
>>>> +	pe->table_group.tce32_size = tbl->it_size << tbl->it_page_shift;
>>>>   	iommu_init_table(tbl, phb->hose->node);
>>>>
>>>>   	if (pe->flags & PNV_IODA_PE_DEV) {
>>>> @@ -1961,7 +1965,7 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
>>>>   }
>>>>
>>>>   static long pnv_pci_ioda2_set_window(struct iommu_table_group *table_group,
>>>> -		struct iommu_table *tbl)
>>>> +		int num, struct iommu_table *tbl)
>>>>   {
>>>>   	struct pnv_ioda_pe *pe = container_of(table_group, struct pnv_ioda_pe,
>>>>   			table_group);
>>>> @@ -1972,9 +1976,10 @@ static long pnv_pci_ioda2_set_window(struct iommu_table_group *table_group,
>>>>   	const __u64 start_addr = tbl->it_offset << tbl->it_page_shift;
>>>>   	const __u64 win_size = tbl->it_size << tbl->it_page_shift;
>>>>
>>>> -	pe_info(pe, "Setting up window at %llx..%llx "
>>>> +	pe_info(pe, "Setting up window#%d at %llx..%llx "
>>>>   			"pgsize=0x%x tablesize=0x%lx "
>>>>   			"levels=%d levelsize=%x\n",
>>>> +			num,
>>>>   			start_addr, start_addr + win_size - 1,
>>>>   			1UL << tbl->it_page_shift, tbl->it_size << 3,
>>>>   			tbl->it_indirect_levels + 1, tbl->it_level_size << 3);
>>>> @@ -1987,7 +1992,7 @@ static long pnv_pci_ioda2_set_window(struct iommu_table_group *table_group,
>>>>   	 */
>>>>   	rc = opal_pci_map_pe_dma_window(phb->opal_id,
>>>>   			pe->pe_number,
>>>> -			pe->pe_number << 1,
>>>> +			(pe->pe_number << 1) + num,
>>>
>>> Heh, yes, well, that makes it rather clear that only 2 tables are possible.
>>>
>>>>   			tbl->it_indirect_levels + 1,
>>>>   			__pa(tbl->it_base),
>>>>   			size << 3,
>>>> @@ -2000,7 +2005,7 @@ static long pnv_pci_ioda2_set_window(struct iommu_table_group *table_group,
>>>>   	pnv_pci_ioda2_tvt_invalidate(pe);
>>>>
>>>>   	/* Store fully initialized *tbl (may be external) in PE */
>>>> -	pe->table_group.tables[0] = *tbl;
>>>> +	pe->table_group.tables[num] = *tbl;
>>>
>>> I'm a bit confused by this whole set_window thing.  Is the idea that
>>> with multiple groups in a container you have multiple table_group s
>>> each with different copies of the iommu_table structures, but pointing
>>> to the same actual TCE entries (it_base)?
>>
>> Yes.
>>
>>> It seems to me not terribly
>>> obvious when you "create" a table and when you "set" a window.
>>
>>
>> A table is not attached anywhere until its address is programmed (in
>> set_window()) to the hardware, it is just a table in memory. For
>> POWER8/IODA2, I create a table before I attach any group to a container,
>> then I program this table to every attached container, right now it is done
>> in container's attach_group(). So later we can hotplug any host PCI device
>> to a container - it will program same TCE table to every new group in the
>> container.
>
> So you "create" once, then "set" it to one or more table_groups?  It
> seems odd that "create" is a table_group callback in that case.


Where else could it be? ppc_md? We are getting rid of these. Some global 
function? We do not want VFIO to know about this. I run out of ideas here.




-- 
Alexey
