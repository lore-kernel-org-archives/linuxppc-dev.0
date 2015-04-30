Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
 [209.85.220.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 17B751A0259
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 12:58:21 +1000 (AEST)
Received: by pacwv17 with SMTP id wv17so45953972pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 19:58:19 -0700 (PDT)
Message-ID: <55419A44.9080804@ozlabs.ru>
Date: Thu, 30 Apr 2015 12:58:12 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel v9 15/32] powerpc/powernv/ioda/ioda2: Rework TCE
 invalidation in tce_build()/tce_free()
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-16-git-send-email-aik@ozlabs.ru>
 <20150429031802.GL32589@voom.redhat.com>
In-Reply-To: <20150429031802.GL32589@voom.redhat.com>
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

On 04/29/2015 01:18 PM, David Gibson wrote:
> On Sat, Apr 25, 2015 at 10:14:39PM +1000, Alexey Kardashevskiy wrote:
>> The pnv_pci_ioda_tce_invalidate() helper invalidates TCE cache. It is
>> supposed to be called on IODA1/2 and not called on p5ioc2. It receives
>> start and end host addresses of TCE table.
>>
>> IODA2 actually needs PCI addresses to invalidate the cache. Those
>> can be calculated from host addresses but since we are going
>> to implement multi-level TCE tables, calculating PCI address from
>> a host address might get either tricky or ugly as TCE table remains flat
>> on PCI bus but not in RAM.
>>
>> This moves pnv_pci_ioda_tce_invalidate() from generic pnv_tce_build/
>> pnt_tce_free and defines IODA1/2-specific callbacks which call generic
>> ones and do PHB-model-specific TCE cache invalidation. P5IOC2 keeps
>> using generic callbacks as before.
>>
>> This changes pnv_pci_ioda2_tce_invalidate() to receives TCE index and
>> number of pages which are PCI addresses shifted by IOMMU page shift.
>>
>> No change in behaviour is expected.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>> Changes:
>> v9:
>> * removed confusing comment from commit log about unintentional calling of
>> pnv_pci_ioda_tce_invalidate()
>> * moved mechanical changes away to "powerpc/iommu: Move tce_xxx callbacks from ppc_md to iommu_table"
>> * fixed bug with broken invalidation in pnv_pci_ioda2_tce_invalidate -
>> @index includes @tbl->it_offset but old code added it anyway which later broke
>> DDW
>> ---
>>   arch/powerpc/platforms/powernv/pci-ioda.c | 86 +++++++++++++++++++++----------
>>   arch/powerpc/platforms/powernv/pci.c      | 17 ++----
>>   2 files changed, 64 insertions(+), 39 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index 718d5cc..f070c44 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -1665,18 +1665,20 @@ static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe,
>>   	}
>>   }
>>
>> -static void pnv_pci_ioda1_tce_invalidate(struct pnv_ioda_pe *pe,
>> -					 struct iommu_table *tbl,
>> -					 __be64 *startp, __be64 *endp, bool rm)
>> +static void pnv_pci_ioda1_tce_invalidate(struct iommu_table *tbl,
>> +		unsigned long index, unsigned long npages, bool rm)
>>   {
>> +	struct pnv_ioda_pe *pe = container_of(tbl->it_table_group,
>> +			struct pnv_ioda_pe, table_group);
>>   	__be64 __iomem *invalidate = rm ?
>>   		(__be64 __iomem *)pe->tce_inval_reg_phys :
>>   		(__be64 __iomem *)tbl->it_index;
>>   	unsigned long start, end, inc;
>>   	const unsigned shift = tbl->it_page_shift;
>>
>> -	start = __pa(startp);
>> -	end = __pa(endp);
>> +	start = __pa((__be64 *)tbl->it_base + index - tbl->it_offset);
>> +	end = __pa((__be64 *)tbl->it_base + index - tbl->it_offset +
>> +			npages - 1);
>
> This doesn't look right.  The arguments to __pa don't appear to be
> addresses (since index and if_offset are in units of (TCE) pages, not
> bytes).


tbl->it_base is an address and it is casted to __be64* which means:

(char*)tbl->it_base + (index - tbl->it_offset)*sizeof(__be64).

Which seems to be correct (I just removed extra braces compared to the old 
code), no?


>
>>
>>   	/* BML uses this case for p6/p7/galaxy2: Shift addr and put in node */
>>   	if (tbl->it_busno) {
>> @@ -1712,16 +1714,40 @@ static void pnv_pci_ioda1_tce_invalidate(struct pnv_ioda_pe *pe,
>>   	 */
>>   }
>>
>> +static int pnv_ioda1_tce_build(struct iommu_table *tbl, long index,
>> +		long npages, unsigned long uaddr,
>> +		enum dma_data_direction direction,
>> +		struct dma_attrs *attrs)
>> +{
>> +	long ret = pnv_tce_build(tbl, index, npages, uaddr, direction,
>> +			attrs);
>> +
>> +	if (!ret && (tbl->it_type & TCE_PCI_SWINV_CREATE))
>> +		pnv_pci_ioda1_tce_invalidate(tbl, index, npages, false);
>> +
>> +	return ret;
>> +}
>> +
>> +static void pnv_ioda1_tce_free(struct iommu_table *tbl, long index,
>> +		long npages)
>> +{
>> +	pnv_tce_free(tbl, index, npages);
>> +
>> +	if (tbl->it_type & TCE_PCI_SWINV_FREE)
>> +		pnv_pci_ioda1_tce_invalidate(tbl, index, npages, false);
>> +}
>> +
>>   static struct iommu_table_ops pnv_ioda1_iommu_ops = {
>> -	.set = pnv_tce_build,
>> -	.clear = pnv_tce_free,
>> +	.set = pnv_ioda1_tce_build,
>> +	.clear = pnv_ioda1_tce_free,
>>   	.get = pnv_tce_get,
>>   };
>>
>> -static void pnv_pci_ioda2_tce_invalidate(struct pnv_ioda_pe *pe,
>> -					 struct iommu_table *tbl,
>> -					 __be64 *startp, __be64 *endp, bool rm)
>> +static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
>> +		unsigned long index, unsigned long npages, bool rm)
>>   {
>> +	struct pnv_ioda_pe *pe = container_of(tbl->it_table_group,
>> +			struct pnv_ioda_pe, table_group);
>>   	unsigned long start, end, inc;
>>   	__be64 __iomem *invalidate = rm ?
>>   		(__be64 __iomem *)pe->tce_inval_reg_phys :
>> @@ -1734,10 +1760,8 @@ static void pnv_pci_ioda2_tce_invalidate(struct pnv_ioda_pe *pe,
>>   	end = start;
>>
>>   	/* Figure out the start, end and step */
>> -	inc = tbl->it_offset + (((u64)startp - tbl->it_base) / sizeof(u64));
>> -	start |= (inc << shift);
>> -	inc = tbl->it_offset + (((u64)endp - tbl->it_base) / sizeof(u64));
>> -	end |= (inc << shift);
>> +	start |= (index << shift);
>> +	end |= ((index + npages - 1) << shift);
>>   	inc = (0x1ull << shift);
>>   	mb();
>>
>> @@ -1750,22 +1774,32 @@ static void pnv_pci_ioda2_tce_invalidate(struct pnv_ioda_pe *pe,
>>   	}
>>   }
>>
>> -void pnv_pci_ioda_tce_invalidate(struct iommu_table *tbl,
>> -				 __be64 *startp, __be64 *endp, bool rm)
>> +static int pnv_ioda2_tce_build(struct iommu_table *tbl, long index,
>> +		long npages, unsigned long uaddr,
>> +		enum dma_data_direction direction,
>> +		struct dma_attrs *attrs)
>>   {
>> -	struct pnv_ioda_pe *pe = container_of(tbl->it_table_group,
>> -			struct pnv_ioda_pe, table_group);
>> -	struct pnv_phb *phb = pe->phb;
>> -
>> -	if (phb->type == PNV_PHB_IODA1)
>> -		pnv_pci_ioda1_tce_invalidate(pe, tbl, startp, endp, rm);
>> -	else
>> -		pnv_pci_ioda2_tce_invalidate(pe, tbl, startp, endp, rm);
>> +	long ret = pnv_tce_build(tbl, index, npages, uaddr, direction,
>> +			attrs);
>> +
>> +	if (!ret && (tbl->it_type & TCE_PCI_SWINV_CREATE))
>> +		pnv_pci_ioda2_tce_invalidate(tbl, index, npages, false);
>> +
>> +	return ret;
>> +}
>> +
>> +static void pnv_ioda2_tce_free(struct iommu_table *tbl, long index,
>> +		long npages)
>> +{
>> +	pnv_tce_free(tbl, index, npages);
>> +
>> +	if (tbl->it_type & TCE_PCI_SWINV_FREE)
>> +		pnv_pci_ioda2_tce_invalidate(tbl, index, npages, false);
>>   }
>>
>>   static struct iommu_table_ops pnv_ioda2_iommu_ops = {
>> -	.set = pnv_tce_build,
>> -	.clear = pnv_tce_free,
>> +	.set = pnv_ioda2_tce_build,
>> +	.clear = pnv_ioda2_tce_free,
>>   	.get = pnv_tce_get,
>>   };
>>
>> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
>> index 4c3bbb1..84b4ea4 100644
>> --- a/arch/powerpc/platforms/powernv/pci.c
>> +++ b/arch/powerpc/platforms/powernv/pci.c
>> @@ -577,37 +577,28 @@ int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
>>   		struct dma_attrs *attrs)
>>   {
>>   	u64 proto_tce = iommu_direction_to_tce_perm(direction);
>> -	__be64 *tcep, *tces;
>> +	__be64 *tcep;
>>   	u64 rpn;
>>
>> -	tces = tcep = ((__be64 *)tbl->it_base) + index - tbl->it_offset;
>> +	tcep = ((__be64 *)tbl->it_base) + index - tbl->it_offset;
>>   	rpn = __pa(uaddr) >> tbl->it_page_shift;
>>
>>   	while (npages--)
>>   		*(tcep++) = cpu_to_be64(proto_tce |
>>   				(rpn++ << tbl->it_page_shift));
>>
>> -	/* Some implementations won't cache invalid TCEs and thus may not
>> -	 * need that flush. We'll probably turn it_type into a bit mask
>> -	 * of flags if that becomes the case
>> -	 */
>> -	if (tbl->it_type & TCE_PCI_SWINV_CREATE)
>> -		pnv_pci_ioda_tce_invalidate(tbl, tces, tcep - 1, false);
>>
>>   	return 0;
>>   }
>>
>>   void pnv_tce_free(struct iommu_table *tbl, long index, long npages)
>>   {
>> -	__be64 *tcep, *tces;
>> +	__be64 *tcep;
>>
>> -	tces = tcep = ((__be64 *)tbl->it_base) + index - tbl->it_offset;
>> +	tcep = ((__be64 *)tbl->it_base) + index - tbl->it_offset;
>>
>>   	while (npages--)
>>   		*(tcep++) = cpu_to_be64(0);
>> -
>> -	if (tbl->it_type & TCE_PCI_SWINV_FREE)
>> -		pnv_pci_ioda_tce_invalidate(tbl, tces, tcep - 1, false);
>>   }
>>
>>   unsigned long pnv_tce_get(struct iommu_table *tbl, long index)
>


-- 
Alexey
