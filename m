Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41f5p54gLTzF0xv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2018 14:15:25 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6U4DoBm087085
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2018 00:15:23 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2khr5gw8d3-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2018 00:15:23 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 30 Jul 2018 05:15:20 +0100
Subject: Re: [RFC 2/4] virtio: Override device's DMA OPS with
 virtio_direct_dma_ops selectively
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180720035941.6844-3-khandual@linux.vnet.ibm.com>
 <c443ad8c-fb81-302d-edb2-5521831d38da@linux.vnet.ibm.com>
 <20180729001344-mutt-send-email-mst@kernel.org>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, aik@ozlabs.ru, robh@kernel.org,
 joe@perches.com, elfring@users.sourceforge.net,
 david@gibson.dropbear.id.au, jasowang@redhat.com,
 benh@kernel.crashing.org, mpe@ellerman.id.au, hch@infradead.org,
 linuxram@us.ibm.com, haren@linux.vnet.ibm.com, paulus@samba.org,
 srikar@linux.vnet.ibm.com
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Mon, 30 Jul 2018 09:45:11 +0530
MIME-Version: 1.0
In-Reply-To: <20180729001344-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Message-Id: <1932ff74-dab8-853d-256c-40045e7ad2d9@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/29/2018 02:46 AM, Michael S. Tsirkin wrote:
> On Sat, Jul 28, 2018 at 02:26:24PM +0530, Anshuman Khandual wrote:
>> On 07/20/2018 09:29 AM, Anshuman Khandual wrote:
>>> Now that virtio core always needs all virtio devices to have DMA OPS, we
>>> need to make sure that the structure it points is the right one. In the
>>> absence of VIRTIO_F_IOMMU_PLATFORM flag QEMU expects GPA from guest kernel.
>>> In such case, virtio device must use default virtio_direct_dma_ops DMA OPS
>>> structure which transforms scatter gather buffer addresses as GPA. This
>>> DMA OPS override must happen as early as possible during virtio device
>>> initializatin sequence before virtio core starts using given device's DMA
>>> OPS callbacks for I/O transactions. This change detects device's IOMMU flag
>>> and does the override in case the flag is cleared.
>>>
>>> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>>> ---
>>>  drivers/virtio/virtio.c | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>>> index 7907ad3..6b13987 100644
>>> --- a/drivers/virtio/virtio.c
>>> +++ b/drivers/virtio/virtio.c
>>> @@ -166,6 +166,8 @@ void virtio_add_status(struct virtio_device *dev, unsigned int status)
>>>  }
>>>  EXPORT_SYMBOL_GPL(virtio_add_status);
>>>
>>> +const struct dma_map_ops virtio_direct_dma_ops;
>>> +
>>>  int virtio_finalize_features(struct virtio_device *dev)
>>>  {
>>>  	int ret = dev->config->finalize_features(dev);
>>> @@ -174,6 +176,9 @@ int virtio_finalize_features(struct virtio_device *dev)
>>>  	if (ret)
>>>  		return ret;
>>
>>
>> The previous patch removed the code block for XEN guests which forced
>> the use of DMA API all the time irrespective of VIRTIO_F_IOMMU_PLATFORM
>> flag on the device. Here is what I have removed with patch 2/4 which
>> breaks the existing semantics on XEN guests.
>>
>> -static bool vring_use_dma_api(struct virtio_device *vdev)
>> -{
>> -	if (!virtio_has_iommu_quirk(vdev))
>> -		return true;
>> -
>> -	/* Otherwise, we are left to guess. */
>> -	/*
>> -	 * In theory, it's possible to have a buggy QEMU-supposed
>> -	 * emulated Q35 IOMMU and Xen enabled at the same time.  On
>> -	 * such a configuration, virtio has never worked and will
>> -	 * not work without an even larger kludge.  Instead, enable
>> -	 * the DMA API if we're a Xen guest, which at least allows
>> -	 * all of the sensible Xen configurations to work correctly.
>> -	 */
>> -	if (xen_domain())
>> -		return true;
>> -
>> -	return false;
>> -}
>>
>> XEN guests would not like override with virtio_direct_dma_ops in any
>> case irrespective of the flag VIRTIO_F_IOMMU_PLATFORM. So the existing
>> semantics can be preserved with something like this. It just assumes
>> that dev->dma_ops is non-NULL and a valid one set by the architecture.
>> If required we can add those tests here before skipping the override.
>>
>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>> index 7907ad3..6b13987 100644
>> --- a/drivers/virtio/virtio.c
>> +++ b/drivers/virtio/virtio.c
>> @@ -166,6 +166,8 @@ void virtio_add_status(struct virtio_device *dev, unsigned int status)
>>  }
>>  EXPORT_SYMBOL_GPL(virtio_add_status);
>>
>> +const struct dma_map_ops virtio_direct_dma_ops;
>> +
>>  int virtio_finalize_features(struct virtio_device *dev)
>>  {
>>  	int ret = dev->config->finalize_features(dev);
>> @@ -174,6 +176,9 @@ int virtio_finalize_features(struct virtio_device *dev)
>>  	if (ret)
>>  		return ret;
>> +
>> +	if (xen_domain())
>> +		goto skip_override;
>> +
>> +	if (virtio_has_iommu_quirk(dev))
>> +		set_dma_ops(dev->dev.parent, &virtio_direct_dma_ops);
>> +
>> + skip_override:
>> +
> 
> I prefer normal if scoping as opposed to goto spaghetti pls.
> Better yet move vring_use_dma_api here and use it.
> Less of a chance something will break.

Sure, will move vring_use_dma_api() function in here.
