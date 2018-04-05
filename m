Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40H0vZ6yGYzF1pr
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Apr 2018 21:28:42 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w35BQEbI113977
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Apr 2018 07:28:38 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2h5jx103xf-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Apr 2018 07:28:38 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 5 Apr 2018 12:28:36 +0100
Subject: Re: [RFC] virtio: Use DMA MAP API for devices without an IOMMU
To: Balbir Singh <bsingharora@gmail.com>
References: <20180405105631.9514-1-khandual@linux.vnet.ibm.com>
 <CAKTCnz=3b56bGKrqCcZOwBsu0yngS_Rw-9TieNLyHgix4eZrAQ@mail.gmail.com>
Cc: robh@kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Joe Perches <joe@perches.com>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 Markus Elfring <elfring@users.sourceforge.net>,
 David Gibson <david@gibson.dropbear.id.au>
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Thu, 5 Apr 2018 16:58:29 +0530
MIME-Version: 1.0
In-Reply-To: <CAKTCnz=3b56bGKrqCcZOwBsu0yngS_Rw-9TieNLyHgix4eZrAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <cd5a975b-87a9-6c2b-3c65-a1c4f54311ef@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/05/2018 04:44 PM, Balbir Singh wrote:
> On Thu, Apr 5, 2018 at 8:56 PM, Anshuman Khandual
> <khandual@linux.vnet.ibm.com> wrote:
>> There are certian platforms which would like to use SWIOTLB based DMA API
>> for bouncing purpose without actually requiring an IOMMU back end. But the
>> virtio core does not allow such mechanism. Right now DMA MAP API is only
>> selected for devices which have an IOMMU and then the QEMU/host back end
>> will process all incoming SG buffer addresses as IOVA instead of simple
>> GPA which is the case for simple bounce buffers after being processed with
>> SWIOTLB API. To enable this usage, it introduces an architecture specific
>> function which will just make virtio core front end select DMA operations
>> structure.
>>
>> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> ---
>> This RFC is just to get some feedback. Please ignore the function call
>> back into the architecture. It can be worked out properly later on. But
>> the question is can we have virtio devices in the guest which would like
>> to use SWIOTLB based (or any custom DMA API based) bounce buffering with
>> out actually being an IOMMU devices emulated by QEMU/host as been with
>> the current VIRTIO_F_IOMMU_PLATFORM virtio flag ?
>>
>>  arch/powerpc/platforms/pseries/iommu.c | 6 ++++++
>>  drivers/virtio/virtio_ring.c           | 4 ++++
>>  include/linux/virtio.h                 | 2 ++
>>  3 files changed, 12 insertions(+)
>>
>> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
>> index 06f02960b439..dd15fbddbe89 100644
>> --- a/arch/powerpc/platforms/pseries/iommu.c
>> +++ b/arch/powerpc/platforms/pseries/iommu.c
>> @@ -1396,3 +1396,9 @@ static int __init disable_multitce(char *str)
>>  __setup("multitce=", disable_multitce);
>>
>>  machine_subsys_initcall_sync(pseries, tce_iommu_bus_notifier_init);
>> +
>> +bool is_virtio_dma_platform(void)
>> +{
>> +       return true;
>> +}
>> +EXPORT_SYMBOL(is_virtio_dma_platform);
>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>> index 71458f493cf8..9f205a79d378 100644
>> --- a/drivers/virtio/virtio_ring.c
>> +++ b/drivers/virtio/virtio_ring.c
>> @@ -144,6 +144,10 @@ struct vring_virtqueue {
>>
>>  static bool vring_use_dma_api(struct virtio_device *vdev)
>>  {
>> +       /* Use DMA API even for virtio devices without an IOMMU */
>> +       if (is_virtio_dma_platform())
>> +               return true;
>> +
>>         if (!virtio_has_iommu_quirk(vdev))
>>                 return true;
>>
>> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
>> index 988c7355bc22..d8bb83d753ea 100644
>> --- a/include/linux/virtio.h
>> +++ b/include/linux/virtio.h
>> @@ -200,6 +200,8 @@ static inline struct virtio_driver *drv_to_virtio(struct device_driver *drv)
>>  int register_virtio_driver(struct virtio_driver *drv);
>>  void unregister_virtio_driver(struct virtio_driver *drv);
>>
>> +extern bool is_virtio_dma_platform(void);
>> +
> 
> Where is the default implementation for non-pseries platforms? Will they compile
> after these changes?

No they wont. This is just a RFC asking for suggestion/feedback on a
particular direction, will clean up the code later on once we agree
on this.
