Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f172.google.com (mail-pd0-f172.google.com
 [209.85.192.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 275711A0D15
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 20:13:14 +1000 (AEST)
Received: by pdea3 with SMTP id a3so88475562pde.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 May 2015 03:13:12 -0700 (PDT)
Message-ID: <554351B0.8050006@ozlabs.ru>
Date: Fri, 01 May 2015 20:13:04 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel v9 20/32] powerpc/powernv/ioda2: Introduce
 pnv_pci_create_table/pnv_pci_free_table
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-21-git-send-email-aik@ozlabs.ru>
 <20150429043949.GQ32589@voom.redhat.com>
In-Reply-To: <20150429043949.GQ32589@voom.redhat.com>
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

On 04/29/2015 02:39 PM, David Gibson wrote:
> On Sat, Apr 25, 2015 at 10:14:44PM +1000, Alexey Kardashevskiy wrote:
>> This is a part of moving TCE table allocation into an iommu_ops
>> callback to support multiple IOMMU groups per one VFIO container.
>>
>> This moves a table creation window to the file with common powernv-pci
>> helpers as it does not do anything IODA2-specific.
>>
>> This adds pnv_pci_free_table() helper to release the actual TCE table.
>>
>> This enforces window size to be a power of two.
>>
>> This should cause no behavioural change.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>> ---
>> Changes:
>> v9:
>> * moved helpers to the common powernv pci.c file from pci-ioda.c
>> * moved bits from pnv_pci_create_table() to pnv_alloc_tce_table_pages()
>> ---
>>   arch/powerpc/platforms/powernv/pci-ioda.c | 36 ++++++------------
>>   arch/powerpc/platforms/powernv/pci.c      | 61 +++++++++++++++++++++++++++++++
>>   arch/powerpc/platforms/powernv/pci.h      |  4 ++
>>   3 files changed, 76 insertions(+), 25 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index a80be34..b9b3773 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -1307,8 +1307,7 @@ static void pnv_pci_ioda2_release_dma_pe(struct pci_dev *dev, struct pnv_ioda_pe
>>   	if (rc)
>>   		pe_warn(pe, "OPAL error %ld release DMA window\n", rc);
>>
>> -	iommu_reset_table(tbl, of_node_full_name(dev->dev.of_node));
>> -	free_pages(addr, get_order(TCE32_TABLE_SIZE));
>> +	pnv_pci_free_table(tbl);
>>   }
>>
>>   static void pnv_ioda_release_vf_PE(struct pci_dev *pdev, u16 num_vfs)
>> @@ -2039,10 +2038,7 @@ static struct iommu_table_group_ops pnv_pci_ioda2_ops = {
>>   static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>>   				       struct pnv_ioda_pe *pe)
>>   {
>> -	struct page *tce_mem = NULL;
>> -	void *addr;
>>   	struct iommu_table *tbl = &pe->table_group.tables[0];
>> -	unsigned int tce_table_size, end;
>>   	int64_t rc;
>>
>>   	/* We shouldn't already have a 32-bit DMA associated */
>> @@ -2053,29 +2049,20 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>>
>>   	/* The PE will reserve all possible 32-bits space */
>>   	pe->tce32_seg = 0;
>> -	end = (1 << ilog2(phb->ioda.m32_pci_base));
>> -	tce_table_size = (end / 0x1000) * 8;
>>   	pe_info(pe, "Setting up 32-bit TCE table at 0..%08x\n",
>> -		end);
>> +		phb->ioda.m32_pci_base);
>>
>> -	/* Allocate TCE table */
>> -	tce_mem = alloc_pages_node(phb->hose->node, GFP_KERNEL,
>> -				   get_order(tce_table_size));
>> -	if (!tce_mem) {
>> -		pe_err(pe, "Failed to allocate a 32-bit TCE memory\n");
>> -		goto fail;
>> +	rc = pnv_pci_create_table(&pe->table_group, pe->phb->hose->node,
>> +			0, IOMMU_PAGE_SHIFT_4K, phb->ioda.m32_pci_base, tbl);
>> +	if (rc) {
>> +		pe_err(pe, "Failed to create 32-bit TCE table, err %ld", rc);
>> +		return;
>>   	}
>> -	addr = page_address(tce_mem);
>> -	memset(addr, 0, tce_table_size);
>> -
>> -	/* Setup iommu */
>> -	tbl->it_table_group = &pe->table_group;
>> -
>> -	/* Setup linux iommu table */
>> -	pnv_pci_setup_iommu_table(tbl, addr, tce_table_size, 0,
>> -			IOMMU_PAGE_SHIFT_4K);
>>
>>   	tbl->it_ops = &pnv_ioda2_iommu_ops;
>> +
>> +	/* Setup iommu */
>> +	tbl->it_table_group = &pe->table_group;
>>   	iommu_init_table(tbl, phb->hose->node);
>>   #ifdef CONFIG_IOMMU_API
>>   	pe->table_group.ops = &pnv_pci_ioda2_ops;
>> @@ -2121,8 +2108,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>>   fail:
>>   	if (pe->tce32_seg >= 0)
>>   		pe->tce32_seg = -1;
>> -	if (tce_mem)
>> -		__free_pages(tce_mem, get_order(tce_table_size));
>> +	pnv_pci_free_table(tbl);
>>   }
>>
>>   static void pnv_ioda_setup_dma(struct pnv_phb *phb)
>> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
>> index e8802ac..6bcfad5 100644
>> --- a/arch/powerpc/platforms/powernv/pci.c
>> +++ b/arch/powerpc/platforms/powernv/pci.c
>> @@ -20,7 +20,9 @@
>>   #include <linux/io.h>
>>   #include <linux/msi.h>
>>   #include <linux/iommu.h>
>> +#include <linux/memblock.h>
>>
>> +#include <asm/mmzone.h>
>>   #include <asm/sections.h>
>>   #include <asm/io.h>
>>   #include <asm/prom.h>
>> @@ -645,6 +647,65 @@ void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
>>   	tbl->it_type = TCE_PCI;
>>   }
>>
>> +static __be64 *pnv_alloc_tce_table_pages(int nid, unsigned shift,
>> +		unsigned long *tce_table_allocated)
>
> I'm a bit confused by the tce_table_allocated parameter.  What's the
> circumstance where more memory is requested than required, and why
> does it matter to the caller?
>
>> +{
>> +	struct page *tce_mem = NULL;
>> +	__be64 *addr;
>> +	unsigned order = max_t(unsigned, shift, PAGE_SHIFT) - PAGE_SHIFT;
>> +	unsigned long local_allocated = 1UL << (order + PAGE_SHIFT);
>> +
>> +	tce_mem = alloc_pages_node(nid, GFP_KERNEL, order);
>> +	if (!tce_mem) {
>> +		pr_err("Failed to allocate a TCE memory, order=%d\n", order);
>> +		return NULL;
>> +	}
>> +	addr = page_address(tce_mem);
>> +	memset(addr, 0, local_allocated);
>> +	*tce_table_allocated = local_allocated;
>> +
>> +	return addr;
>> +}
>> +
>> +long pnv_pci_create_table(struct iommu_table_group *table_group, int nid,
>> +		__u64 bus_offset, __u32 page_shift, __u64 window_size,
>> +		struct iommu_table *tbl)
>
> The table_group parameter is redundant, isn't it?  It must be equal to
> tbl->table_group, yes?
>
> Or would it make more sense for this function to set
> tbl->table_group?

I removed table_group from here.


>  And for that matter wouldn't it make more sense for
> this to set it_size as well?


Missed this comment. It does set it_size by calling 
pnv_pci_setup_iommu_table().



>> +{
>> +	void *addr;
>> +	unsigned long tce_table_allocated = 0;
>> +	const unsigned window_shift = ilog2(window_size);
>> +	unsigned entries_shift = window_shift - page_shift;
>> +	unsigned table_shift = entries_shift + 3;
>> +	const unsigned long tce_table_size = max(0x1000UL, 1UL << table_shift);
>
> So, here you round up to 4k, the in the alloc function you round up to
> PAGE_SIZE (which may or may not be the same).  It's not clear to me why
> there are two rounds of rounding up.


@tce_table_size will be programmed later into IODA2 via OPAL and OPAL will 
reject a window if it is less than 4K. I'll rework the whole thing just to 
align it to PAGE_SIZE as this is what it really is anyway.




-- 
Alexey
