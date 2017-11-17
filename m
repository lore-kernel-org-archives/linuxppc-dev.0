Return-Path: <aik@ozlabs.ru>
Received: from mail-it0-x242.google.com (mail-it0-x242.google.com
 [IPv6:2607:f8b0:4001:c0b::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ydTVC6c6zzDrK3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 17:58:41 +1100 (AEDT)
Received: by mail-it0-x242.google.com with SMTP id b5so2926526itc.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 22:58:41 -0800 (PST)
Subject: Re: [PATCH kernel] vfio/spapr: Add trace points for map/unmap
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson
 <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
 Shuah Khan <shuahkh@osg.samsung.com>, iommu@lists.linux-foundation.org,
 Joerg Roedel <joro@8bytes.org>
References: <20171027030008.17200-1-aik@ozlabs.ru>
 <8c58fcaa-dedc-e6be-44bf-2cb349ef9e38@ozlabs.ru>
 <20171116171301.6552869b@t450s.home>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <52a19cfb-431f-522b-11de-c1c47f09a4c8@ozlabs.ru>
Date: Fri, 17 Nov 2017 17:58:32 +1100
MIME-Version: 1.0
In-Reply-To: <20171116171301.6552869b@t450s.home>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 17/11/17 11:13, Alex Williamson wrote:
> On Tue, 14 Nov 2017 10:47:12 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> 
>> On 27/10/17 14:00, Alexey Kardashevskiy wrote:
>>> This adds trace_map/trace_unmap tracepoints to spapr driver. Type1 already
>>> uses these via the IOMMU API (iommu_map/__iommu_unmap).
>>>
>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>  
> 
> Is this really legitimate to include tracepoints from a different
> subsystem?>  The vfio type1 backend gets these trace points by virtue of
> it actually using the IOMMU API, it doesn't call them itself.  I'm kind
> of surprised these are actually available to be called from a module.

They are explicitly exported:

EXPORT_TRACEPOINT_SYMBOL_GPL(map);
EXPORT_TRACEPOINT_SYMBOL_GPL(unmap);

I would think this is for things like drivers/vfio/vfio_iommu_spapr_tce.c ,
why else?...


> I suspect the way to do this is probably to define our own tracepoints
> in the vfio/spapr backend or insert tracepoints into the IOMMU layers
> that that code calls into rather than masquerading as tracepoints from
> a different subsystem.  Right?

This makes sense too. But it is going to be just cut-n-paste and some
confusion -
/sys/kernel/debug/tracing/events/iommu/map will still be present but
won't work and
/sys/kernel/debug/tracing/events/vfio/vfio_iommu_spapr_tce/map will.

Judges? :)




>  Thanks,
> 
> Alex
> 
>>> ---
>>>
>>> Example:
>>>  qemu-system-ppc-8655  [096]   724.662740: unmap:                IOMMU: iova=0x000000003ffff000 size=4096 unmapped_size=4096
>>>  qemu-system-ppc-8656  [104]   724.970912: map:                  IOMMU: iova=0x0800000000000000 paddr=0x00007ffef7ff0000 size=65536
>>> ---
>>>  drivers/vfio/vfio_iommu_spapr_tce.c | 12 ++++++++++--
>>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
>>> index 63112c36ab2d..4531486c77c6 100644
>>> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
>>> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
>>> @@ -22,6 +22,7 @@
>>>  #include <linux/vmalloc.h>
>>>  #include <linux/sched/mm.h>
>>>  #include <linux/sched/signal.h>
>>> +#include <trace/events/iommu.h>
>>>  
>>>  #include <asm/iommu.h>
>>>  #include <asm/tce.h>
>>> @@ -502,17 +503,19 @@ static int tce_iommu_clear(struct tce_container *container,
>>>  		struct iommu_table *tbl,
>>>  		unsigned long entry, unsigned long pages)
>>>  {
>>> -	unsigned long oldhpa;
>>> +	unsigned long oldhpa, unmapped, firstentry = entry, totalpages = pages;
>>>  	long ret;
>>>  	enum dma_data_direction direction;
>>>  
>>> -	for ( ; pages; --pages, ++entry) {
>>> +	for (unmapped = 0; pages; --pages, ++entry) {
>>>  		direction = DMA_NONE;
>>>  		oldhpa = 0;
>>>  		ret = iommu_tce_xchg(tbl, entry, &oldhpa, &direction);
>>>  		if (ret)
>>>  			continue;
>>>  
>>> +		++unmapped;
>>> +
>>>  		if (direction == DMA_NONE)
>>>  			continue;
>>>  
>>> @@ -523,6 +526,9 @@ static int tce_iommu_clear(struct tce_container *container,
>>>  
>>>  		tce_iommu_unuse_page(container, oldhpa);
>>>  	}
>>> +	trace_unmap(firstentry << tbl->it_page_shift,
>>> +			totalpages << tbl->it_page_shift,
>>> +			unmapped << tbl->it_page_shift);
>>>  
>>>  	return 0;
>>>  }
>>> @@ -965,6 +971,8 @@ static long tce_iommu_ioctl(void *iommu_data,
>>>  					direction);
>>>  
>>>  		iommu_flush_tce(tbl);
>>> +		if (!ret)
>>> +			trace_map(param.iova, param.vaddr, param.size);
>>>  
>>>  		return ret;
>>>  	}
>>>   
>>
>>
> 


-- 
Alexey
