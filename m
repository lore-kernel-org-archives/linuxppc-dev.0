Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
 [209.85.220.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0DFD61A0895
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2015 12:54:57 +1000 (AEST)
Received: by pacyx8 with SMTP id yx8so4055381pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2015 19:54:55 -0700 (PDT)
Message-ID: <55710F77.3080602@ozlabs.ru>
Date: Fri, 05 Jun 2015 12:54:47 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
CC: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v11 21/34] powerpc/powernv/ioda2: Add TCE
 invalidation for all attached groups
References: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
 <1432889098-22924-22-git-send-email-aik@ozlabs.ru>
 <20150605002748.GB17429@gwshan>
In-Reply-To: <20150605002748.GB17429@gwshan>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/05/2015 10:27 AM, Gavin Shan wrote:
> On Fri, May 29, 2015 at 06:44:45PM +1000, Alexey Kardashevskiy wrote:
>> The iommu_table struct keeps a list of IOMMU groups it is used for.
>> At the moment there is just a single group attached but further
>> patches will add TCE table sharing. When sharing is enabled, TCE cache
>> in each PE needs to be invalidated so does the patch.
>>
>> This does not change pnv_pci_ioda1_tce_invalidate() as there is no plan
>> to enable TCE table sharing on PHBs older than IODA2.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>
>> ---
>> Changes:
>> v10:
>> * new to the series
>> ---
>> arch/powerpc/platforms/powernv/pci-ioda.c | 35 ++++++++++++++++++++-----------
>> 1 file changed, 23 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index 3fd8b18..94fccc8 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -24,6 +24,7 @@
>> #include <linux/msi.h>
>> #include <linux/memblock.h>
>> #include <linux/iommu.h>
>> +#include <linux/rculist.h>
>>
>> #include <asm/sections.h>
>> #include <asm/io.h>
>> @@ -1764,23 +1765,15 @@ static inline void pnv_pci_ioda2_tce_invalidate_entire(struct pnv_ioda_pe *pe)
>> 	__raw_writeq(cpu_to_be64(val), phb->ioda.tce_inval_reg);
>> }
>>
>> -static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
>> -		unsigned long index, unsigned long npages, bool rm)
>> +static void pnv_pci_ioda2_tce_do_invalidate(unsigned pe_number, bool rm,
>> +		__be64 __iomem *invalidate, unsigned shift,
>> +		unsigned long index, unsigned long npages)
>
> The better function name would be: pnv_pci_ioda2_do_tce_invalidate(), and

Ok.


> it seems we needn't "bool rm" any more since "invalidate" has been assigned
> with virtual/real address by caller.


We still need @rm here as different helpers are used for real and virt 
modes - __raw_rm_writeq and __raw_writeq.



>
> Thanks,
> Gavin
>
>> {
>> -	struct iommu_table_group_link *tgl = list_first_entry_or_null(
>> -			&tbl->it_group_list, struct iommu_table_group_link,
>> -			next);
>> -	struct pnv_ioda_pe *pe = container_of(tgl->table_group,
>> -			struct pnv_ioda_pe, table_group);
>> 	unsigned long start, end, inc;
>> -	__be64 __iomem *invalidate = rm ?
>> -		(__be64 __iomem *)pe->phb->ioda.tce_inval_reg_phys :
>> -		pe->phb->ioda.tce_inval_reg;
>> -	const unsigned shift = tbl->it_page_shift;
>>
>> 	/* We'll invalidate DMA address in PE scope */
>> 	start = 0x2ull << 60;
>> -	start |= (pe->pe_number & 0xFF);
>> +	start |= (pe_number & 0xFF);
>> 	end = start;
>>
>> 	/* Figure out the start, end and step */
>> @@ -1798,6 +1791,24 @@ static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
>> 	}
>> }
>>
>> +static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
>> +		unsigned long index, unsigned long npages, bool rm)
>> +{
>> +	struct iommu_table_group_link *tgl;
>> +
>> +	list_for_each_entry_rcu(tgl, &tbl->it_group_list, next) {
>> +		struct pnv_ioda_pe *pe = container_of(tgl->table_group,
>> +				struct pnv_ioda_pe, table_group);
>> +		__be64 __iomem *invalidate = rm ?
>> +			(__be64 __iomem *)pe->phb->ioda.tce_inval_reg_phys :
>> +			pe->phb->ioda.tce_inval_reg;
>> +
>> +		pnv_pci_ioda2_tce_do_invalidate(pe->pe_number, rm,
>> +			invalidate, tbl->it_page_shift,
>> +			index, npages);
>> +	}
>> +}
>> +
>> static int pnv_ioda2_tce_build(struct iommu_table *tbl, long index,
>> 		long npages, unsigned long uaddr,
>> 		enum dma_data_direction direction,
>> --
>> 2.4.0.rc3.8.gfb3e7d5
>>
>


-- 
Alexey
