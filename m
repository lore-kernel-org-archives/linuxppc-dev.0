Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f174.google.com (mail-pd0-f174.google.com
 [209.85.192.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 889AA1A001D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 10:53:38 +1000 (AEST)
Received: by pdbnk13 with SMTP id nk13so160285652pdb.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 17:53:35 -0700 (PDT)
Message-ID: <55514F09.4040100@ozlabs.ru>
Date: Tue, 12 May 2015 10:53:29 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 07/21] powerpc/powernv: Release PEs dynamically
References: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1430460188-31343-8-git-send-email-gwshan@linux.vnet.ibm.com>
 <554E00EB.5070802@ozlabs.ru> <20150511062553.GB28073@gwshan>
 <555053F0.1000409@ozlabs.ru> <20150512000308.GC4646@gwshan>
In-Reply-To: <20150512000308.GC4646@gwshan>
Content-Type: text/plain; charset=koi8-r; format=flowed
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/12/2015 10:03 AM, Gavin Shan wrote:
> On Mon, May 11, 2015 at 05:02:08PM +1000, Alexey Kardashevskiy wrote:
>> On 05/11/2015 04:25 PM, Gavin Shan wrote:
>>> On Sat, May 09, 2015 at 10:43:23PM +1000, Alexey Kardashevskiy wrote:
>>>> On 05/01/2015 04:02 PM, Gavin Shan wrote:
>>>>> The original code doesn't support releasing PEs dynamically, meaning
>>>>> that PE and the associated resources (IO, M32, M64 and DMA) can't
>>>>> be released when unplugging a PCI adapter from one hotpluggable slot.
>>>>>
>>>>> The patch takes object oriented methodology, introducs reference
>>>>> count to PE, which is initialized to 1 and increased with 1 when a
>>>>> new PCI device joins the PE. Once the last PCI device leaves the
>>>>> PE, the PE is going to be release together with its associated
>>>>> (IO, M32, M64, DMA) resources.
>>>>
>>>>
>>>> Too little commit log for non-trivial non-cut-n-paste 30KB patch...
>>>>
>>>
>>> Ok. I'll add more details in next revision.
>>>
>>>>>
>>>>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>>>> ---
>>>>>   arch/powerpc/include/asm/pci-bridge.h     |   3 +
>>>>>   arch/powerpc/kernel/pci-hotplug.c         |   5 +
>>>>>   arch/powerpc/platforms/powernv/pci-ioda.c | 658 +++++++++++++++++++-----------
>>>>>   arch/powerpc/platforms/powernv/pci.h      |   4 +-
>>>>>   4 files changed, 432 insertions(+), 238 deletions(-)
>>>>>
>>>>> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
>>>>> index 5367eb3..a6ad4b1 100644
>>>>> --- a/arch/powerpc/include/asm/pci-bridge.h
>>>>> +++ b/arch/powerpc/include/asm/pci-bridge.h
>>>>> @@ -31,6 +31,9 @@ struct pci_controller_ops {
>>>>>   	resource_size_t (*window_alignment)(struct pci_bus *, unsigned long type);
>>>>>   	void		(*setup_bridge)(struct pci_bus *, unsigned long);
>>>>>   	void		(*reset_secondary_bus)(struct pci_dev *dev);
>>>>> +
>>>>> +	/* Called when PCI device is released */
>>>>> +	void		(*release_device)(struct pci_dev *);
>>>>>   };
>>>>>
>>>>>   /*
>>>>> diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
>>>>> index 7ed85a6..0040343 100644
>>>>> --- a/arch/powerpc/kernel/pci-hotplug.c
>>>>> +++ b/arch/powerpc/kernel/pci-hotplug.c
>>>>> @@ -29,6 +29,11 @@
>>>>>    */
>>>>>   void pcibios_release_device(struct pci_dev *dev)
>>>>>   {
>>>>> +	struct pci_controller *hose = pci_bus_to_host(dev->bus);
>>>>> +
>>>>> +	if (hose->controller_ops.release_device)
>>>>> +		hose->controller_ops.release_device(dev);
>>>>> +
>>>>>   	eeh_remove_device(dev);
>>>>>   }
>>>>>
>>>>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>> index 910fb67..ef8c216 100644
>>>>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>> @@ -12,6 +12,8 @@
>>>>>   #undef DEBUG
>>>>>
>>>>>   #include <linux/kernel.h>
>>>>> +#include <linux/atomic.h>
>>>>> +#include <linux/kref.h>
>>>>>   #include <linux/pci.h>
>>>>>   #include <linux/crash_dump.h>
>>>>>   #include <linux/debugfs.h>
>>>>> @@ -47,6 +49,8 @@
>>>>>   /* 256M DMA window, 4K TCE pages, 8 bytes TCE */
>>>>>   #define TCE32_TABLE_SIZE	((0x10000000 / 0x1000) * 8)
>>>>>
>>>>> +static void pnv_ioda_release_pe(struct kref *kref);
>>>>> +
>>>>>   static void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
>>>>>   			    const char *fmt, ...)
>>>>>   {
>>>>> @@ -123,25 +127,400 @@ static inline bool pnv_pci_is_mem_pref_64(unsigned long flags)
>>>>>   		(IORESOURCE_MEM_64 | IORESOURCE_PREFETCH));
>>>>>   }
>>>>>
>>>>> -static void pnv_ioda_reserve_pe(struct pnv_phb *phb, int pe_no)
>>>>> +static inline void pnv_ioda_pe_get(struct pnv_ioda_pe *pe)
>>>>>   {
>>>>> -	if (!(pe_no >= 0 && pe_no < phb->ioda.total_pe)) {
>>>>> -		pr_warn("%s: Invalid PE %d on PHB#%x\n",
>>>>> -			__func__, pe_no, phb->hose->global_number);
>>>>> +	if (!pe)
>>>>> +		return;
>>>>> +
>>>>> +	kref_get(&pe->kref);
>>>>> +}
>>>>> +
>>>>> +static inline void pnv_ioda_pe_put(struct pnv_ioda_pe *pe)
>>>>> +{
>>>>> +	unsigned int count;
>>>>> +
>>>>> +	if (!pe)
>>>>>   		return;
>>>>> +
>>>>> +	/*
>>>>> +	 * The count is initialized to 1 and increased with 1 when
>>>>> +	 * a new PCI device is bound with the PE. Once the last PCI
>>>>> +	 * device is leaving from the PE, the PE is going to be
>>>>> +	 * released.
>>>>> +	 */
>>>>> +	count = atomic_read(&pe->kref.refcount);
>>>>> +	if (count == 2)
>>>>> +		kref_sub(&pe->kref, 2, pnv_ioda_release_pe);
>>>>> +	else
>>>>> +		kref_put(&pe->kref, pnv_ioda_release_pe);
>>>>
>>>>
>>>> What if pnv_ioda_pe_get() gets called between atomic_read() and kref_sub()?
>>>>
>>>
>>> Yeah, that would have problem. But it shouldn't happen because the
>>> PCI devices are joining the parent PE# in strictly serialized mode.
>>> Same thing happens when detaching PCI devices from its parent PE.
>>
>>
>> oookay. Another thing then - why is this kref counter initialized to 1?
>> It would make sense if you did something special when the counter becomes 1
>> after decrement but you do not.
>>
>> Also, this kref thing makes sense if you do kref_put() in multiple places and
>> do not know which one will be the last one so you pass the callback to all of
>> them. Here you do kref_put/sub in one place and you read the counter - so you
>> can call pnv_ioda_release_pe() directly. And it feels like a simple atomic_t
>> would do the job just fine. If you still feel that the counter should start
>>from 1, there are atomic_dec_if_positive() and atomic_inc_not_zero() and
>> others.
>>
>
> It's good question actually. The counter is initialized to 1 when the PE
> is reserved because of M64 requirement or allocated for non-M64 case. If
> we reserve or allocate PE#, there is one thing for sure: the PCI bus has
> one PCI device (including PCI bridge) at least. After the PE# is reserved
> or allocated, the PCI device joins the PE with the result of increasing
> the counter with 1. It means the counter is 2 when PE contains one PCI
> device, and 3 when there're 2 devices. One reason for this design is that
> we just need decrease the counter if we have to release this PE in the
> window between PE reservation/allocation and first PCI device joins. I
> think you're correct that we can call pnv_ioda_release_pe() in this window.
> In this way, the counter is always reflecting the number of PCI devices
> the PE contains.


Good :) I believe it was something different 2-3 versions ago and evolved 
to this so you do not notice it straight away :)


>
>>>>> +}
>>>>> +
>>>>> +static void pnv_pci_release_device(struct pci_dev *pdev)
>>>>> +{
>>>>> +	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
>>>>> +	struct pnv_phb *phb = hose->private_data;
>>>>> +	struct pci_dn *pdn = pci_get_pdn(pdev);
>>>>> +	struct pnv_ioda_pe *pe;
>>>>> +
>>>>> +	if (pdn && pdn->pe_number != IODA_INVALID_PE) {
>>>>> +		pe = &phb->ioda.pe_array[pdn->pe_number];
>>>>> +		pnv_ioda_pe_put(pe);
>>>>> +		pdn->pe_number = IODA_INVALID_PE;
>>>>>   	}
>>>>> +}
>>>>>
>>>>> -	if (test_and_set_bit(pe_no, phb->ioda.pe_alloc)) {
>>>>> -		pr_warn("%s: PE %d was assigned on PHB#%x\n",
>>>>> -			__func__, pe_no, phb->hose->global_number);
>>>>> +static void pnv_ioda_release_pe_dma(struct pnv_ioda_pe *pe)
>>>>> +{
>>>>> +	struct pnv_phb *phb = pe->phb;
>>>>> +	int index, count;
>>>>> +	unsigned long tbl_addr, tbl_size;
>>>>> +
>>>>> +	/* No DMA capability for slave PEs */
>>>>> +	if (pe->flags & PNV_IODA_PE_SLAVE)
>>>>> +		return;
>>>>> +
>>>>> +	/* Bypass DMA window */
>>>>> +	if (phb->type == PNV_PHB_IODA2 &&
>>>>> +	    pe->tce_bypass_enabled &&
>>>>> +	    pe->tce32_table &&
>>>>> +	    pe->tce32_table->set_bypass)
>>>>> +		pe->tce32_table->set_bypass(pe->tce32_table, false);
>>>>> +
>>>>> +	/* 32-bits DMA window */
>>>>> +	count = pe->tce32_seg_end - pe->tce32_seg_start;
>>>>> +	tbl_addr = pe->tce32_table->it_base;
>>>>> +	if (!count)
>>>>>   		return;
>>>>> +
>>>>> +	/* Free IOMMU table */
>>>>> +	iommu_free_table(pe->tce32_table,
>>>>> +			 of_node_full_name(phb->hose->dn));
>>>>> +
>>>>> +	/* Deconfigure TCE table */
>>>>> +	switch (phb->type) {
>>>>> +	case PNV_PHB_IODA1:
>>>>> +		for (index = 0; index < count; index++)
>>>>> +			opal_pci_map_pe_dma_window(phb->opal_id,
>>>>> +						   pe->pe_number,
>>>>> +						   pe->tce32_seg_start + index,
>>>>> +						   1,
>>>>> +						   __pa(tbl_addr) +
>>>>> +						   index * TCE32_TABLE_SIZE,
>>>>> +						   0,
>>>>> +						   0x1000);
>>>>> +		bitmap_clear(phb->ioda.tce32_segmap,
>>>>> +			     pe->tce32_seg_start,
>>>>> +			     count);
>>>>> +		tbl_size = TCE32_TABLE_SIZE * count;
>>>>> +		break;
>>>>> +	case PNV_PHB_IODA2:
>>>>> +		opal_pci_map_pe_dma_window(phb->opal_id,
>>>>> +					   pe->pe_number,
>>>>> +					   pe->pe_number << 1,
>>>>> +					   1,
>>>>> +					   __pa(tbl_addr),
>>>>> +					   0,
>>>>> +					   0x1000);
>>>>> +		tbl_size = (1ul << ilog2(phb->ioda.m32_pci_base));
>>>>> +		tbl_size = (tbl_size >> IOMMU_PAGE_SHIFT_4K) * 8;
>>>>> +		break;
>>>>> +	default:
>>>>> +		pe_warn(pe, "Unsupported PHB type %d\n", phb->type);
>>>>> +		return;
>>>>> +	}
>>>>> +
>>>>> +	/* Free memory of IOMMU table */
>>>>> +	free_pages(tbl_addr, get_order(tbl_size));
>>>>
>>>>
>>>> You just programmed the table address to TVT and then you are releasing the
>>>> pages. It does not seem right, it will leave garbage in TVT. Also, I am
>>>> adding helpers to alloc/free TCE pages in DDW patchset, you could reuse bits
>>> >from there (I'll post v10 soon, you'll be in copy and you'll have to review
>>>> that ;) ).
>>>>
>>>
>>> I assume you're talking about TVE. I don't understand how garbage will be left
>>> in TVE. opal_pci_map_pe_dma_window(), which is handled by skiboot, clear TVE
>>> with zero'ed "tce_table_size". The pages previously allocated for TCE table is
>>> released to buddy system, which can be allocated by somebody else (from buddy
>>> or slab).
>>
>> opal_pci_map_pe_dma_window() takes __pa(tbl_addr) which points to some memory
>> which is still allocated. This value goes to a table (which has 2 entries per
>> PE, one for 32bit DMA window and one for bypass/hugewindow) which PHB uses to
>> get the actual TCE table address. What is the name of this table? :) Anyway,
>> you write an address there and then you call free_pages() so after
>> free_pages(), the value in that TVE/TVT/whatever table is a garbage.
>>
>
> I don't look into your DDW code yet. Before we have DDW patchset, the bypass
> TVE (window) isn't supposed to have corresponding TCE table. I guess you might
> change the behaviour in your DDW patchset and I'll take a close look on that.
> For DMA32 window, which is the name of the table, the TVE is cleared by skiboot
> when having zero "tce_table_size" argument.
>
> 	opal_pci_map_pe_dma_window(phb->opal_id,
> 				   pe->pe_number,
> 				   pe->pe_number << 1,
> 				   1,
> 				   __pa(tbl_addr),
> 				   0,			<<<< "tce_table_size".
> 				   0x1000);


Then please, when you pass tce_table_size==0, also pass zero address/zero 
page size/zero levels, unless you have very good reason to pass non-zero 
values for these. What you have now is confusing - it looks like you are 
initializing the table - it is not obvious that "0" is the size and not 
some flags.

When people see this (which does the same thing, please correct me if I am 
wrong), they do not have questions what you are actually trying to do:

  	opal_pci_map_pe_dma_window(phb->opal_id, pe->pe_number,
  				   pe->pe_number << 1, 0, 0, 0, 0);



-- 
Alexey
