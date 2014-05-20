Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 989B01A0883
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 21:28:45 +1000 (EST)
Message-ID: <537B3C68.8080102@suse.de>
Date: Tue, 20 May 2014 13:28:40 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 3/4] drivers/vfio: New IOCTL command VFIO_EEH_INFO
References: <1400574612-19411-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400574612-19411-4-git-send-email-gwshan@linux.vnet.ibm.com>
 <537B3AA7.7040106@suse.de>
In-Reply-To: <537B3AA7.7040106@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: aik@ozlabs.ru, alex.williamson@redhat.com, qiudayu@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 20.05.14 13:21, Alexander Graf wrote:
>
> On 20.05.14 10:30, Gavin Shan wrote:
>> The patch adds new IOCTL command VFIO_EEH_OP to VFIO PCI device
>> to support EEH functionality for PCI devices, which have been
>> passed from host to guest via VFIO.
>>
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/platforms/powernv/Makefile   |   1 +
>>   arch/powerpc/platforms/powernv/eeh-vfio.c | 445 
>> ++++++++++++++++++++++++++++++
>>   drivers/vfio/pci/vfio_pci.c               |  24 +-
>>   drivers/vfio/pci/vfio_pci_private.h       |  16 ++
>>   include/uapi/linux/vfio.h                 |  43 +++
>>   5 files changed, 523 insertions(+), 6 deletions(-)
>>   create mode 100644 arch/powerpc/platforms/powernv/eeh-vfio.c
>
> Why doesn't this code live inside the vfio module? If I don't load the 
> vfio module, I don't need that code to waste memory in my kernel, no?

So I think from a modeling point of view, you want VFIO code that calls 
reasonably generic helpers inside the kernel to deal with errors.

The "generic helpers" don't have anything to do with VFIO. Everything 
that interfaces via ioctls with user space is 100% VFIO code.

The latter should be tristate inside vfio.ko, the former can be =y.


Alex
