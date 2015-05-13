Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9EF481A001B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 17:30:27 +1000 (AEST)
Received: by pacyx8 with SMTP id yx8so42005995pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 00:30:25 -0700 (PDT)
Message-ID: <5552FD8A.6030900@ozlabs.ru>
Date: Wed, 13 May 2015 17:30:18 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH kernel v10 11/34] vfio: powerpc/spapr: Moving
 pinning/unpinning to helpers
References: <1431358763-24371-1-git-send-email-aik@ozlabs.ru>
 <1431358763-24371-12-git-send-email-aik@ozlabs.ru>
 <20150513063242.GA9547@gwshan>
In-Reply-To: <20150513063242.GA9547@gwshan>
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

On 05/13/2015 04:32 PM, Gavin Shan wrote:
> On Tue, May 12, 2015 at 01:39:00AM +1000, Alexey Kardashevskiy wrote:
>> This is a pretty mechanical patch to make next patches simpler.
>>
>> New tce_iommu_unuse_page() helper does put_page() now but it might skip
>> that after the memory registering patch applied.
>>
>> As we are here, this removes unnecessary checks for a value returned
>> by pfn_to_page() as it cannot possibly return NULL.
>>
>> This moves tce_iommu_disable() later to let tce_iommu_clear() know if
>> the container has been enabled because if it has not been, then
>> put_page() must not be called on TCEs from the TCE table. This situation
>> is not yet possible but it will after KVM acceleration patchset is
>> applied.
>>
>> This changes code to work with physical addresses rather than linear
>> mapping addresses for better code readability. Following patches will
>> add an xchg() callback for an IOMMU table which will accept/return
>> physical addresses (unlike current tce_build()) which will eliminate
>> redundant conversions.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> [aw: for the vfio related changes]
>> Acked-by: Alex Williamson <alex.williamson@redhat.com>
>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>
>> ---
>> Changes:
>> v9:
>> * changed helpers to work with physical addresses rather than linear
>> (for simplicity - later ::xchg() will receive physical and avoid
>> additional convertions)
>>
>> v6:
>> * tce_get_hva() returns hva via a pointer
>> ---
>> drivers/vfio/vfio_iommu_spapr_tce.c | 61 +++++++++++++++++++++++++------------
>> 1 file changed, 41 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
>> index e21479c..115d5e6 100644
>> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
>> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
>> @@ -191,69 +191,90 @@ static void tce_iommu_release(void *iommu_data)
>> 	struct tce_container *container = iommu_data;
>>
>> 	WARN_ON(container->tbl && !container->tbl->it_group);
>> -	tce_iommu_disable(container);
>>
>> 	if (container->tbl && container->tbl->it_group)
>> 		tce_iommu_detach_group(iommu_data, container->tbl->it_group);
>>
>> +	tce_iommu_disable(container);
>> 	mutex_destroy(&container->lock);
>>
>> 	kfree(container);
>> }
>>
>> +static void tce_iommu_unuse_page(struct tce_container *container,
>> +		unsigned long oldtce)
>> +{
>> +	struct page *page;
>> +
>> +	if (!(oldtce & (TCE_PCI_READ | TCE_PCI_WRITE)))
>> +		return;
>> +
>
> It might be worthy to have a global helper function in iommu.h to check
> if the given TCE entry is empty or not, for better readability. I would
> think the helper function is used here and there :-)

The patchset adds one later, called iommu_tce_direction() ;)

In general, I removed TCE_PCI_READ, TCE_PCI_WRITE from everywhere but 
powernv code and used  enum dma_data_direction instead as these bits are 
SPAPR TCE protocol specific and VFIO IOMMU API or 
arch/powerpc/kernel/iommu.c do not receive/handle these bits, they have 
their own, platform independent.


-- 
Alexey
