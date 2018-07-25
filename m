Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41b2NG1RH9zDqnG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 14:30:53 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6P4TNPt114585
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 00:30:51 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kedbahve7-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 00:30:51 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 25 Jul 2018 05:30:49 +0100
Subject: Re: [RFC 4/4] virtio: Add platform specific DMA API translation for
 virito devices
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180720035941.6844-5-khandual@linux.vnet.ibm.com>
 <20180720160550-mutt-send-email-mst@kernel.org>
 <3dd36d8e-3bc8-91ba-cf6d-939495439d2c@linux.vnet.ibm.com>
Cc: robh@kernel.org, srikar@linux.vnet.ibm.com, aik@ozlabs.ru,
 jasowang@redhat.com, linuxram@us.ibm.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 paulus@samba.org, joe@perches.com, linuxppc-dev@lists.ozlabs.org,
 elfring@users.sourceforge.net, haren@linux.vnet.ibm.com,
 david@gibson.dropbear.id.au
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Wed, 25 Jul 2018 10:00:39 +0530
MIME-Version: 1.0
In-Reply-To: <3dd36d8e-3bc8-91ba-cf6d-939495439d2c@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <fb107a1f-2af4-50ae-c7b6-ab14ac4d461b@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/23/2018 07:46 AM, Anshuman Khandual wrote:
> On 07/20/2018 06:45 PM, Michael S. Tsirkin wrote:
>> On Fri, Jul 20, 2018 at 09:29:41AM +0530, Anshuman Khandual wrote:
>>> Subject: Re: [RFC 4/4] virtio: Add platform specific DMA API translation for
>>> virito devices
>>
>> s/virito/virtio/
> 
> Oops, will fix it. Thanks for pointing out.
> 
>>
>>> This adds a hook which a platform can define in order to allow it to
>>> override virtio device's DMA OPS irrespective of whether it has the
>>> flag VIRTIO_F_IOMMU_PLATFORM set or not. We want to use this to do
>>> bounce-buffering of data on the new secure pSeries platform, currently
>>> under development, where a KVM host cannot access all of the memory
>>> space of a secure KVM guest.  The host can only access the pages which
>>> the guest has explicitly requested to be shared with the host, thus
>>> the virtio implementation in the guest has to copy data to and from
>>> shared pages.
>>>
>>> With this hook, the platform code in the secure guest can force the
>>> use of swiotlb for virtio buffers, with a back-end for swiotlb which
>>> will use a pool of pre-allocated shared pages.  Thus all data being
>>> sent or received by virtio devices will be copied through pages which
>>> the host has access to.
>>>
>>> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>>> ---
>>>  arch/powerpc/include/asm/dma-mapping.h | 6 ++++++
>>>  arch/powerpc/platforms/pseries/iommu.c | 6 ++++++
>>>  drivers/virtio/virtio.c                | 7 +++++++
>>>  3 files changed, 19 insertions(+)
>>>
>>> diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
>>> index 8fa3945..bc5a9d3 100644
>>> --- a/arch/powerpc/include/asm/dma-mapping.h
>>> +++ b/arch/powerpc/include/asm/dma-mapping.h
>>> @@ -116,3 +116,9 @@ extern u64 __dma_get_required_mask(struct device *dev);
>>>  
>>>  #endif /* __KERNEL__ */
>>>  #endif	/* _ASM_DMA_MAPPING_H */
>>> +
>>> +#define platform_override_dma_ops platform_override_dma_ops
>>> +
>>> +struct virtio_device;
>>> +
>>> +extern void platform_override_dma_ops(struct virtio_device *vdev);
>>> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
>>> index 06f0296..5773bc7 100644
>>> --- a/arch/powerpc/platforms/pseries/iommu.c
>>> +++ b/arch/powerpc/platforms/pseries/iommu.c
>>> @@ -38,6 +38,7 @@
>>>  #include <linux/of.h>
>>>  #include <linux/iommu.h>
>>>  #include <linux/rculist.h>
>>> +#include <linux/virtio.h>
>>>  #include <asm/io.h>
>>>  #include <asm/prom.h>
>>>  #include <asm/rtas.h>
>>> @@ -1396,3 +1397,8 @@ static int __init disable_multitce(char *str)
>>>  __setup("multitce=", disable_multitce);
>>>  
>>>  machine_subsys_initcall_sync(pseries, tce_iommu_bus_notifier_init);
>>> +
>>> +void platform_override_dma_ops(struct virtio_device *vdev)
>>> +{
>>> +	/* Override vdev->parent.dma_ops if required */
>>> +}
>>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>>> index 6b13987..432c332 100644
>>> --- a/drivers/virtio/virtio.c
>>> +++ b/drivers/virtio/virtio.c
>>> @@ -168,6 +168,12 @@ EXPORT_SYMBOL_GPL(virtio_add_status);
>>>  
>>>  const struct dma_map_ops virtio_direct_dma_ops;
>>>  
>>> +#ifndef platform_override_dma_ops
>>> +static inline void platform_override_dma_ops(struct virtio_device *vdev)
>>> +{
>>> +}
>>> +#endif
>>> +
>>>  int virtio_finalize_features(struct virtio_device *dev)
>>>  {
>>>  	int ret = dev->config->finalize_features(dev);
>>> @@ -179,6 +185,7 @@ int virtio_finalize_features(struct virtio_device *dev)
>>>  	if (virtio_has_iommu_quirk(dev))
>>>  		set_dma_ops(dev->dev.parent, &virtio_direct_dma_ops);
>>>  
>>> +	platform_override_dma_ops(dev);
>>
>> Is there a single place where virtio_has_iommu_quirk is called now?
> 
> Not other than this one. But in the proposed implementation of
> platform_override_dma_ops on powerpc, we will again check on
> virtio_has_iommu_quirk before overriding it with SWIOTLB.
> 
> void platform_override_dma_ops(struct virtio_device *vdev)
> {
>         if (is_ultravisor_platform() && virtio_has_iommu_quirk(vdev))
>                 set_dma_ops(vdev->dev.parent, &swiotlb_dma_ops);
> }
> 
>> If so, we could put this into virtio_has_iommu_quirk then.
> 
> Did you mean platform_override_dma_ops instead ? If so, yes that
> is possible. Default implementation of platform_override_dma_ops
> should just check on VIRTIO_F_IOMMU_PLATFORM feature and override
> with virtio_direct_dma_ops but arch implementation can check on
> what ever else they would like and override appropriately.
> 
> Default platform_override_dma_ops will be like this
> 
> #ifndef platform_override_dma_ops
> static inline void platform_override_dma_ops(struct virtio_device *vdev)
> {
> 	if(!virtio_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM))
> 		set_dma_ops(dev->dev.parent, &virtio_direct_dma_ops);
> }
> #endif
> 
> Proposed powerpc implementation will be like this instead
> 
> void platform_override_dma_ops(struct virtio_device *vdev)
> {
> 	if (virtio_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM))
> 		return;
> 
>         if (is_ultravisor_platform())
>                 set_dma_ops(vdev->dev.parent, &swiotlb_dma_ops);
> 	else
> 		set_dma_ops(dev->dev.parent, &virtio_direct_dma_ops);
> 	
> }
> 
> There is a redundant definition of virtio_has_iommu_quirk in the tools
> directory (tools/virtio/linux/virtio_config.h) which does not seem to
> be used any where. I guess that can be removed without problem.

Does this sound okay ? It will merge patch 3 and 4 into a single one.
On the other hand it also passes the responsibility of dealing with
VIRTIO_F_IOMMU_PLATFORM flag to the architecture callback which might
be bit problematic. Keeping VIRTIO_F_IOMMU_PLATFORM handling in virtio
core at least makes sure that the device has a working DMA ops to fall
back on if the arch hook fails to take care of it somehow.
