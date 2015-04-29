Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f50.google.com (mail-pa0-f50.google.com
 [209.85.220.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B34CA1A01BA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 19:51:30 +1000 (AEST)
Received: by pabtp1 with SMTP id tp1so23323990pab.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 02:51:29 -0700 (PDT)
Message-ID: <5540A999.9060507@ozlabs.ru>
Date: Wed, 29 Apr 2015 19:51:21 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel v9 18/32] powerpc/iommu/powernv: Release replaced
 TCE
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-19-git-send-email-aik@ozlabs.ru>
 <20150429041808.GO32589@voom.redhat.com>
In-Reply-To: <20150429041808.GO32589@voom.redhat.com>
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

On 04/29/2015 02:18 PM, David Gibson wrote:
> On Sat, Apr 25, 2015 at 10:14:42PM +1000, Alexey Kardashevskiy wrote:
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
>> IOMMU API as those are to be calculated by platform code from DMA direction.
>>
>> This moves SetPageDirty() to the IOMMU code to make it work for both
>> VFIO ioctl interface in in-kernel TCE acceleration (when it becomes
>> available later).
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> [aw: for the vfio related changes]
>> Acked-by: Alex Williamson <alex.williamson@redhat.com>
>
> This looks mostly good, but there are couple of details that need fixing.
>


[...]

>> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
>> index ba75aa5..e8802ac 100644
>> --- a/arch/powerpc/platforms/powernv/pci.c
>> +++ b/arch/powerpc/platforms/powernv/pci.c
>> @@ -598,6 +598,23 @@ int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
>>   	return 0;
>>   }
>>
>> +#ifdef CONFIG_IOMMU_API
>> +int pnv_tce_xchg(struct iommu_table *tbl, long index,
>> +		unsigned long *tce, enum dma_data_direction *direction)
>> +{
>> +	u64 proto_tce = iommu_direction_to_tce_perm(*direction);
>> +	unsigned long newtce = *tce | proto_tce;
>> +	unsigned long idx = index - tbl->it_offset;
>
> Should this have a BUG_ON or WARN_ON if the supplied tce has bits set
> below the page mask?


Why? The caller checks these bits, do we really need to duplicate it here?


>> +	*tce = xchg(pnv_tce(tbl, idx), cpu_to_be64(newtce));
>> +	*tce = be64_to_cpu(*tce);
>> +	*direction = iommu_tce_direction(*tce);
>> +	*tce &= ~(TCE_PCI_READ | TCE_PCI_WRITE);
>> +
>> +	return 0;
>> +}
>> +#endif



-- 
Alexey
