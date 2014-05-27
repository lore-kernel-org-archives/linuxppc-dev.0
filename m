Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F1DA71A0547
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 May 2014 08:49:19 +1000 (EST)
Message-ID: <5385166A.5060404@suse.de>
Date: Wed, 28 May 2014 00:49:14 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 3/3] drivers/vfio: EEH support for VFIO PCI device
References: <1401180052-6060-1-git-send-email-gwshan@linux.vnet.ibm.com>	
 <1401180052-6060-4-git-send-email-gwshan@linux.vnet.ibm.com>
 <1401214527.3289.611.camel@ul30vt.home>
In-Reply-To: <1401214527.3289.611.camel@ul30vt.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: aik@ozlabs.ru, qiudayu@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 27.05.14 20:15, Alex Williamson wrote:
> On Tue, 2014-05-27 at 18:40 +1000, Gavin Shan wrote:
>> The patch adds new IOCTL commands for sPAPR VFIO container device
>> to support EEH functionality for PCI devices, which have been passed
>> through from host to somebody else via VFIO.
>>
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>>   Documentation/vfio.txt              | 92 ++++++++++++++++++++++++++++++++++++-
>>   drivers/vfio/pci/Makefile           |  1 +
>>   drivers/vfio/pci/vfio_pci.c         | 20 +++++---
>>   drivers/vfio/pci/vfio_pci_eeh.c     | 46 +++++++++++++++++++
>>   drivers/vfio/pci/vfio_pci_private.h |  5 ++
>>   drivers/vfio/vfio_iommu_spapr_tce.c | 85 ++++++++++++++++++++++++++++++++++
>>   include/uapi/linux/vfio.h           | 66 ++++++++++++++++++++++++++
>>   7 files changed, 308 insertions(+), 7 deletions(-)
>>   create mode 100644 drivers/vfio/pci/vfio_pci_eeh.c

[...]

>> +
>> +	return ret;
>> +}
>> +
>>   static long tce_iommu_ioctl(void *iommu_data,
>>   				 unsigned int cmd, unsigned long arg)
>>   {
>> @@ -283,6 +363,11 @@ static long tce_iommu_ioctl(void *iommu_data,
>>   		tce_iommu_disable(container);
>>   		mutex_unlock(&container->lock);
>>   		return 0;
>> +	case VFIO_EEH_PE_SET_OPTION:
>> +	case VFIO_EEH_PE_GET_STATE:
>> +	case VFIO_EEH_PE_RESET:
>> +	case VFIO_EEH_PE_CONFIGURE:
>> +		return tce_iommu_eeh_ioctl(iommu_data, cmd, arg);
> This is where it would have really made sense to have a single
> VFIO_EEH_OP ioctl with a data structure passed to indicate the sub-op.
> AlexG, are you really attached to splitting these out into separate
> ioctls?

I don't see the problem. We need to forward 4 ioctls to a separate piece 
of code, so we forward 4 ioctls to a separate piece of code :). Putting 
them into one ioctl just moves the switch() into another function.


Alex
