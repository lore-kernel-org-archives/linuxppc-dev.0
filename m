Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f172.google.com (mail-pd0-f172.google.com
 [209.85.192.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 052011A03CA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 13:54:06 +1000 (AEST)
Received: by pdea3 with SMTP id a3so71602178pde.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 20:54:04 -0700 (PDT)
Message-ID: <55541C55.4060807@ozlabs.ru>
Date: Thu, 14 May 2015 13:53:57 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH kernel v10 23/34] powerpc/iommu/powernv: Release replaced
 TCE
References: <1431358763-24371-1-git-send-email-aik@ozlabs.ru>	<1431358763-24371-24-git-send-email-aik@ozlabs.ru>
 <20150513170048.2c6115c6@thh440s>
In-Reply-To: <20150513170048.2c6115c6@thh440s>
Content-Type: text/plain; charset=koi8-r; format=flowed
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
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

On 05/14/2015 01:00 AM, Thomas Huth wrote:
> On Tue, 12 May 2015 01:39:12 +1000
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>
>> At the moment writing new TCE value to the IOMMU table fails with EBUSY
>> if there is a valid entry already. However PAPR specification allows
>> the guest to write new TCE value without clearing it first.
>>
>> Another problem this patch is addressing is the use of pool locks for
>> external IOMMU users such as VFIO. The pool locks are to protect
>> DMA page allocator rather than entries and since the host kernel does
>> not control what pages are in use, there is no point in pool locks and
>> exchange()+put_page(oldtce) is sufficient to avoid possible races.
>>
>> This adds an exchange() callback to iommu_table_ops which does the same
>> thing as set() plus it returns replaced TCE and DMA direction so
>> the caller can release the pages afterwards. The exchange() receives
>> a physical address unlike set() which receives linear mapping address;
>> and returns a physical address as the clear() does.
>>
>> This implements exchange() for P5IOC2/IODA/IODA2. This adds a requirement
>> for a platform to have exchange() implemented in order to support VFIO.
>>
>> This replaces iommu_tce_build() and iommu_clear_tce() with
>> a single iommu_tce_xchg().
>>
>> This makes sure that TCE permission bits are not set in TCE passed to
>> IOMMU API as those are to be calculated by platform code from
>> DMA direction.
>>
>> This moves SetPageDirty() to the IOMMU code to make it work for both
>> VFIO ioctl interface in in-kernel TCE acceleration (when it becomes
>> available later).
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> [aw: for the vfio related changes]
>> Acked-by: Alex Williamson <alex.williamson@redhat.com>
> [...]
>> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
>> index 6275164..1287d49 100644
>> --- a/arch/powerpc/kernel/iommu.c
>> +++ b/arch/powerpc/kernel/iommu.c
>> @@ -962,10 +962,7 @@ EXPORT_SYMBOL_GPL(iommu_tce_clear_param_check);
>>   int iommu_tce_put_param_check(struct iommu_table *tbl,
>>   		unsigned long ioba, unsigned long tce)
>>   {
>> -	if (!(tce & (TCE_PCI_WRITE | TCE_PCI_READ)))
>> -		return -EINVAL;
>> -
>> -	if (tce & ~(IOMMU_PAGE_MASK(tbl) | TCE_PCI_WRITE | TCE_PCI_READ))
>> +	if (tce & ~IOMMU_PAGE_MASK(tbl))
>>   		return -EINVAL;
>>
>>   	if (ioba & ~IOMMU_PAGE_MASK(tbl))
>> @@ -982,44 +979,16 @@ int iommu_tce_put_param_check(struct iommu_table *tbl,
>>   }
>>   EXPORT_SYMBOL_GPL(iommu_tce_put_param_check);
>>
>> -unsigned long iommu_clear_tce(struct iommu_table *tbl, unsigned long entry)
>> +long iommu_tce_xchg(struct iommu_table *tbl, unsigned long entry,
>> +		unsigned long *hpa, enum dma_data_direction *direction)
>>   {
>> -	unsigned long oldtce;
>> -	struct iommu_pool *pool = get_pool(tbl, entry);
>> +	long ret;
>>
>> -	spin_lock(&(pool->lock));
>> +	ret = tbl->it_ops->exchange(tbl, entry, hpa, direction);
>>
>> -	oldtce = tbl->it_ops->get(tbl, entry);
>> -	if (oldtce & (TCE_PCI_WRITE | TCE_PCI_READ))
>> -		tbl->it_ops->clear(tbl, entry, 1);
>> -	else
>> -		oldtce = 0;
>> -
>> -	spin_unlock(&(pool->lock));
>> -
>> -	return oldtce;
>> -}
>> -EXPORT_SYMBOL_GPL(iommu_clear_tce);
>> -
>> -/*
>> - * hwaddr is a kernel virtual address here (0xc... bazillion),
>> - * tce_build converts it to a physical address.
>> - */
>> -int iommu_tce_build(struct iommu_table *tbl, unsigned long entry,
>> -		unsigned long hwaddr, enum dma_data_direction direction)
>> -{
>> -	int ret = -EBUSY;
>> -	unsigned long oldtce;
>> -	struct iommu_pool *pool = get_pool(tbl, entry);
>> -
>> -	spin_lock(&(pool->lock));
>> -
>> -	oldtce = tbl->it_ops->get(tbl, entry);
>> -	/* Add new entry if it is not busy */
>> -	if (!(oldtce & (TCE_PCI_WRITE | TCE_PCI_READ)))
>> -		ret = tbl->it_ops->set(tbl, entry, 1, hwaddr, direction, NULL);
>> -
>> -	spin_unlock(&(pool->lock));
>> +	if (!ret && ((*direction == DMA_FROM_DEVICE) ||
>> +			(*direction == DMA_BIDIRECTIONAL)))
>
> You could drop some of the parentheses:
>
> 	if (!ret && (*direction == DMA_FROM_DEVICE ||
> 			*direction == DMA_BIDIRECTIONAL))

I really (really) like braces. Is there any kernel code design rule against it?


>
>> +		SetPageDirty(pfn_to_page(*hpa >> PAGE_SHIFT));
>>
>>   	/* if (unlikely(ret))
>>   		pr_err("iommu_tce: %s failed on hwaddr=%lx ioba=%lx kva=%lx ret=%d\n",
> [...]
>> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
>> index 2ead291..0724ec8 100644
>> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
>> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
>> @@ -236,18 +236,11 @@ static void tce_iommu_release(void *iommu_data)
> [...]
>> @@ -405,19 +410,26 @@ static long tce_iommu_ioctl(void *iommu_data,
>>   			return -EINVAL;
>>
>>   		/* iova is checked by the IOMMU API */
>> -		tce = param.vaddr;
>>   		if (param.flags & VFIO_DMA_MAP_FLAG_READ)
>> -			tce |= TCE_PCI_READ;
>> -		if (param.flags & VFIO_DMA_MAP_FLAG_WRITE)
>> -			tce |= TCE_PCI_WRITE;
>> +			if (param.flags & VFIO_DMA_MAP_FLAG_WRITE)
>> +				direction = DMA_BIDIRECTIONAL;
>> +			else
>> +				direction = DMA_TO_DEVICE;
>> +		else
>> +			if (param.flags & VFIO_DMA_MAP_FLAG_WRITE)
>> +				direction = DMA_FROM_DEVICE;
>> +			else
>> +				return -EINVAL;
>
> IMHO some curly braces for the outer if-statement would be really fine
> here.

I believe checkpatch.pl won't like it. There is a check against single 
lines having braces after "if" statements.



>
>> -		ret = iommu_tce_put_param_check(tbl, param.iova, tce);
>> +		ret = iommu_tce_put_param_check(tbl, param.iova, param.vaddr);
>>   		if (ret)
>>   			return ret;
>>
>>   		ret = tce_iommu_build(container, tbl,
>>   				param.iova >> tbl->it_page_shift,
>> -				tce, param.size >> tbl->it_page_shift);
>> +				param.vaddr,
>> +				param.size >> tbl->it_page_shift,
>> +				direction);
>>
>>   		iommu_flush_tce(tbl);
>>
>
>   Thomas
>


-- 
Alexey
