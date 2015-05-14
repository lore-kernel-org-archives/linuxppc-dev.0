Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
 [209.85.220.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D17D31A03CA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 13:50:14 +1000 (AEST)
Received: by pacwv17 with SMTP id wv17so70779885pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 20:50:12 -0700 (PDT)
Message-ID: <55541B6C.1000903@ozlabs.ru>
Date: Thu, 14 May 2015 13:50:04 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH kernel v10 21/34] powerpc/powernv/ioda2: Add TCE
 invalidation for all attached groups
References: <1431358763-24371-1-git-send-email-aik@ozlabs.ru>
 <1431358763-24371-22-git-send-email-aik@ozlabs.ru>
 <20150514022219.GA32474@gwshan>
In-Reply-To: <20150514022219.GA32474@gwshan>
Content-Type: text/plain; charset=koi8-r; format=flowed
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/14/2015 12:22 PM, Gavin Shan wrote:
> On Tue, May 12, 2015 at 01:39:10AM +1000, Alexey Kardashevskiy wrote:
>> The iommu_table struct keeps a list of IOMMU groups it is used for.
>> At the moment there is just a single group attached but further
>> patches will add TCE table sharing. When sharing is enabled, TCE cache
>> in each PE needs to be invalidated so does the patch.
>>
>> This does not change pnv_pci_ioda1_tce_invalidate() as there is no plan
>> to enable TCE table sharing on PHBs older than IODA2.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>> Changes:
>> v10:
>> * new to the series
>> ---
>> arch/powerpc/platforms/powernv/pci-ioda.c | 35 ++++++++++++++++++++-----------
>> 1 file changed, 23 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index f972e40..8e4987d 100644
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
>> @@ -1763,23 +1764,15 @@ static inline void pnv_pci_ioda2_tvt_invalidate(struct pnv_ioda_pe *pe)
>> 	__raw_writeq(cpu_to_be64(val), pe->tce_inval_reg);
>> }
>>
>> -static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
>> -		unsigned long index, unsigned long npages, bool rm)
>> +static void pnv_pci_ioda2_tce_do_invalidate(unsigned pe_number, bool rm,
>> +		__be64 __iomem *invalidate, unsigned shift,
>> +		unsigned long index, unsigned long npages)
>> {
>> -	struct iommu_table_group_link *tgl = list_first_entry_or_null(
>> -			&tbl->it_group_list, struct iommu_table_group_link,
>> -			next);
>> -	struct pnv_ioda_pe *pe = container_of(tgl->table_group,
>> -			struct pnv_ioda_pe, table_group);
>> 	unsigned long start, end, inc;
>> -	__be64 __iomem *invalidate = rm ?
>> -		(__be64 __iomem *)pe->tce_inval_reg_phys :
>> -		pe->tce_inval_reg;
>> -	const unsigned shift = tbl->it_page_shift;
>>
>> 	/* We'll invalidate DMA address in PE scope */
>> 	start = 0x2ull << 60;
>> -	start |= (pe->pe_number & 0xFF);
>> +	start |= (pe_number & 0xFF);
>> 	end = start;
>>
>> 	/* Figure out the start, end and step */
>> @@ -1797,6 +1790,24 @@ static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
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
>> +			(__be64 __iomem *)pe->tce_inval_reg_phys :
>> +			pe->tce_inval_reg;
>> +
>> +		pnv_pci_ioda2_tce_do_invalidate(pe->pe_number, rm,
>> +			invalidate, tbl->it_page_shift,
>> +			index, npages);
>> +	}
>> +}
>> +
>
> I don't understand this well and need a teaching session: One IOMMU
> table can be connected with multiple IOMMU table groups, each of them
> can be regarded as being equal to one PE. It means one IOMMU table
> can be shared by two PEs. There must be something I missed.

No, this is correct.


> Could you give a teaching session with an example about the IOMMU
> table sharing? :-)

If you do not share tables and you have multiple IOMMU groups passed to 
QEMU, and all actual devices are capable of 64bit DMA, and you have 
multiple PHBs in QEMU (each backed with a 64bit TCE table which is updated 
once at the boot time and never changes) - all these tables will have 
exactly the same content.

Another thing is if you do not want to have multiple PHBs in QEMU, and you 
do not have tables sharing, every H_PUT_TCE request would have to update 
each group's TCE table, not just one. Not very fast approach.

So it seems a useful thing. If you do not want sharing, just add another 
virtual PHB and put vfio-pci devices onto it.


-- 
Alexey
