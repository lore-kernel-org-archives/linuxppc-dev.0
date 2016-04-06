Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qfrnQ17zhzDq6S
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Apr 2016 13:29:46 +1000 (AEST)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Wed, 6 Apr 2016 13:29:44 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 321E92BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Apr 2016 13:29:42 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u363TXUm000262
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Apr 2016 13:29:42 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u363T8E1000393
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Apr 2016 13:29:09 +1000
Subject: Re: [RFC v5 7/7] vfio-pci: Allow to mmap MSI-X table if interrupt
 remapping is supported
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1459864004-2869-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1459864004-2869-2-git-send-email-xyjxie@linux.vnet.ibm.com>
 <20160406000052.GA4545@gwshan>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-doc@vger.kernel.org, bhelgaas@google.com, corbet@lwn.net,
 aik@ozlabs.ru, alex.williamson@redhat.com, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, warrier@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 eric.auger@linaro.org, will.deacon@arm.com, alistair@popple.id.au,
 ruscur@russell.cc
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Message-ID: <57048270.9040802@linux.vnet.ibm.com>
Date: Wed, 6 Apr 2016 11:28:48 +0800
MIME-Version: 1.0
In-Reply-To: <20160406000052.GA4545@gwshan>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/4/6 8:00, Gavin Shan wrote:
> On Tue, Apr 05, 2016 at 09:46:44PM +0800, Yongji Xie wrote:
>> This patch enables mmapping MSI-X tables if
>> hardware supports interrupt remapping which
>> can ensure that a given pci device can only
>> shoot the MSIs assigned for it.
>>
>> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>> ---
>> drivers/vfio/pci/vfio_pci.c         |    9 +++++++--
>> drivers/vfio/pci/vfio_pci_private.h |    1 +
>> drivers/vfio/pci/vfio_pci_rdwr.c    |    2 +-
>> 3 files changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
>> index c60d790..ef02896 100644
>> --- a/drivers/vfio/pci/vfio_pci.c
>> +++ b/drivers/vfio/pci/vfio_pci.c
>> @@ -201,6 +201,10 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
>> 	} else
>> 		vdev->msix_bar = 0xFF;
>>
>> +	if (iommu_capable(pdev->dev.bus, IOMMU_CAP_INTR_REMAP) ||
>> +		pdev->bus->bus_flags | PCI_BUS_FLAGS_MSI_REMAP)
>> +		vdev->msi_remap = true;
>> +
> I guess you probably need a "&" here. Otherwise, the condition
> is always true.

Yes, you are right. I'll fix it.

>> 	if (!vfio_vga_disabled() && vfio_pci_is_vga(pdev))
>> 		vdev->has_vga = true;
>>
>> @@ -635,7 +639,8 @@ static long vfio_pci_ioctl(void *device_data,
>> 				     VFIO_REGION_INFO_FLAG_WRITE;
>> 			if (vdev->bar_mmap_supported[info.index]) {
>> 				info.flags |= VFIO_REGION_INFO_FLAG_MMAP;
>> -				if (info.index == vdev->msix_bar) {
>> +				if (info.index == vdev->msix_bar &&
>> +						!vdev->msi_remap) {
>> 					ret = msix_sparse_mmap_cap(vdev, &caps);
>> 					if (ret)
>> 						return ret;
>> @@ -1067,7 +1072,7 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
>> 	if (req_start + req_len > phys_len)
>> 		return -EINVAL;
>>
>> -	if (index == vdev->msix_bar) {
>> +	if (index == vdev->msix_bar && !vdev->msi_remap) {
>> 		/*
>> 		 * Disallow mmaps overlapping the MSI-X table; users don't
>> 		 * get to touch this directly.  We could find somewhere
>> diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
>> index 0ea4c62..4f20963 100644
>> --- a/drivers/vfio/pci/vfio_pci_private.h
>> +++ b/drivers/vfio/pci/vfio_pci_private.h
>> @@ -78,6 +78,7 @@ struct vfio_pci_device {
>> 	int			irq_type;
>> 	int			num_regions;
>> 	struct vfio_pci_region	*region;
>> +	bool			msi_remap;
>> 	u8			msi_qmax;
>> 	u8			msix_bar;
>> 	u16			msix_size;
>> diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
>> index 5ffd1d9..606ee3c 100644
>> --- a/drivers/vfio/pci/vfio_pci_rdwr.c
>> +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
>> @@ -164,7 +164,7 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_device *vdev, char __user *buf,
>> 	} else
>> 		io = vdev->barmap[bar];
>>
>> -	if (bar == vdev->msix_bar) {
>> +	if (bar == vdev->msix_bar && !vdev->msi_remap) {
>> 		x_start = vdev->msix_offset;
>> 		x_end = vdev->msix_offset + vdev->msix_size;
>> 	}
> When PCI_BUS_FLAGS_MSI_REMAP is set, the MSIx table can be accessed by
> read/write interface except mmap(). The commit log doesn't mention it.
> It would be better if you have some words about it.
>
> Thanks,
> Gavin
>

OK. I will mention it in commit log.

Thanks,
Yongji

>> -- 
>> 1.7.9.5
>>
