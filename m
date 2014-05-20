Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6EF491A0814
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 22:25:50 +1000 (EST)
Message-ID: <537B49C9.4000302@suse.de>
Date: Tue, 20 May 2014 14:25:45 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/4] drivers/vfio: New IOCTL command VFIO_EEH_INFO
References: <1400574612-19411-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400574612-19411-4-git-send-email-gwshan@linux.vnet.ibm.com>
 <537B3AA7.7040106@suse.de> <537B3C68.8080102@suse.de>
 <20140520114031.GA20397@shangw> <537B4015.7030404@suse.de>
 <20140520122147.GA26483@shangw>
In-Reply-To: <20140520122147.GA26483@shangw>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: aik@ozlabs.ru, kvm-ppc@vger.kernel.org, alex.williamson@redhat.com,
 qiudayu@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 20.05.14 14:21, Gavin Shan wrote:
> On Tue, May 20, 2014 at 01:44:21PM +0200, Alexander Graf wrote:
>> On 20.05.14 13:40, Gavin Shan wrote:
>>> On Tue, May 20, 2014 at 01:28:40PM +0200, Alexander Graf wrote:
>>>> On 20.05.14 13:21, Alexander Graf wrote:
>>>>> On 20.05.14 10:30, Gavin Shan wrote:
>>>>>> The patch adds new IOCTL command VFIO_EEH_OP to VFIO PCI device
>>>>>> to support EEH functionality for PCI devices, which have been
>>>>>> passed from host to guest via VFIO.
>>>>>>
>>>>>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>>>>> ---
>>>>>>   arch/powerpc/platforms/powernv/Makefile   |   1 +
>>>>>>   arch/powerpc/platforms/powernv/eeh-vfio.c | 445
>>>>>> ++++++++++++++++++++++++++++++
>>>>>>   drivers/vfio/pci/vfio_pci.c               |  24 +-
>>>>>>   drivers/vfio/pci/vfio_pci_private.h       |  16 ++
>>>>>>   include/uapi/linux/vfio.h                 |  43 +++
>>>>>>   5 files changed, 523 insertions(+), 6 deletions(-)
>>>>>>   create mode 100644 arch/powerpc/platforms/powernv/eeh-vfio.c
>>>>> Why doesn't this code live inside the vfio module? If I don't load
>>>>> the vfio module, I don't need that code to waste memory in my
>>>>> kernel, no?
>>> Yes, It saves some memory.
>>>
>>>> So I think from a modeling point of view, you want VFIO code that
>>>> calls reasonably generic helpers inside the kernel to deal with
>>>> errors.
>>>>
>>>> The "generic helpers" don't have anything to do with VFIO. Everything
>>>> that interfaces via ioctls with user space is 100% VFIO code.
>>>>
>>>> The latter should be tristate inside vfio.ko, the former can be =y.
>>>>
>>> The main reason I put eeh-vfio.c to arch/powerpc/platforms/powernv/ is
>>> the source file needs access data structures (struct pnv_phb) defined
>>> in "pci.h" under that directory.
>> Then create a good in-kernel framework from that directory and make
>> use of it from the VFIO code :). But please don't mesh together VFIO,
>> powernv EEH handling and RTAS.
>>
> Yeah. How about this? :-)
>
> - Move eeh-vfio.c to drivers/vfio/pci/
> - From eeh-vfio.c, dereference arch/powerpc/kernel/eeh.c::eeh_ops, which
>    is arch/powerpc/plaforms/powernv/eeh-powernv.c::powernv_eeh_ops. Call

Hrm, I think it'd be nicer to just export individual functions that do 
thing you want to do from eeh.c.


Alex

>    to the corresponding callbacks in "eeh_ops" based on incoming RTAS request.
>
>    The file would be renamed to "vfio_eeh.c" as well after moving to VFIO
>    driver directory.
>
> Thanks,
> Gavin
>
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
