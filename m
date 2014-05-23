Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D17C11A007D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 22:49:17 +1000 (EST)
Message-ID: <537F43C9.1080503@suse.de>
Date: Fri, 23 May 2014 14:49:13 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 2/3] drivers/vfio: EEH support for VFIO PCI device
References: <1400747034-15045-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400747034-15045-3-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400814653.3289.428.camel@ul30vt.home> <20140523043722.GA11572@shangw>
 <76F750C7-EAA1-455F-A64F-BAB826F66281@suse.de> <20140523073720.GA5929@shangw>
 <537F1BBE.4030503@suse.de> <20140523115509.GA4042@shangw>
 <537F37FA.9090200@suse.de> <20140523124326.GA4778@shangw>
In-Reply-To: <20140523124326.GA4778@shangw>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "aik@ozlabs.ru" <aik@ozlabs.ru>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "qiudayu@linux.vnet.ibm.com" <qiudayu@linux.vnet.ibm.com>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 23.05.14 14:43, Gavin Shan wrote:
> On Fri, May 23, 2014 at 01:58:50PM +0200, Alexander Graf wrote:
>> On 23.05.14 13:55, Gavin Shan wrote:
>>> On Fri, May 23, 2014 at 11:58:22AM +0200, Alexander Graf wrote:
>>>> On 23.05.14 09:37, Gavin Shan wrote:
>>>>> On Fri, May 23, 2014 at 08:55:15AM +0200, Alexander Graf wrote:
>>>>>>> Am 23.05.2014 um 06:37 schrieb Gavin Shan <gwshan@linux.vnet.ibm.com>:
>>>>>>>> On Thu, May 22, 2014 at 09:10:53PM -0600, Alex Williamson wrote:
>>>>>>>>> On Thu, 2014-05-22 at 18:23 +1000, Gavin Shan wrote:
>>>>>>>>> The patch adds new IOCTL commands for VFIO PCI device to support
>>>>>>>>> EEH functionality for PCI devices, which have been passed through
>>>>>>>> >from host to somebody else via VFIO.
>>>>> .../...
>>>>>
>>>>>>>>> +
>>>>>>>>> +/*
>>>>>>>>> + * Reset is the major step to recover problematic PE. The following
>>>>>>>>> + * command helps on that.
>>>>>>>>> + */
>>>>>>>>> +struct vfio_eeh_pe_reset {
>>>>>>>>> +    __u32 argsz;
>>>>>>>>> +    __u32 option;
>>>>>>>>> +};
>>>>>>>>> +
>>>>>>>>> +#define VFIO_EEH_PE_RESET        _IO(VFIO_TYPE, VFIO_BASE + 24)
>>>>>>>>> +
>>>>>>>>> +/*
>>>>>>>>> + * One of the steps for recovery after PE reset is to configure the
>>>>>>>>> + * PCI bridges affected by the PE reset.
>>>>>>>>> + */
>>>>>>>>> +#define VFIO_EEH_PE_CONFIGURE        _IO(VFIO_TYPE, VFIO_BASE + 25)
>>>>>>>> What can the user do differently by making these separate ioctls?
>>>>>>> hrm, I didn't understood as well. Alex.G could have the explaination.
>>>>>> Alex raised the same concern as me: why separate reset and configure? When we want to recover a device, we need a reset call anyway, right?
>>>>>>
>>>>> Ok. With current ioctl commands, "reset+configure" is required to do
>>>>> error recovery. Before the recovery, we also need call "configure"
>>>>> in order to retrieve error log correctly.
>>>> Well, the "configure" ioctl (which is a really bad name for what it
>>>> does btw) currently only restores the BARs which doesn't sound like
>>>> error log retrieval to me.
>>>>
>>> Could you please suggest a better name? I had VFIO_EEH_PE_CONFIGURE because
>>> it's for RTAS call "ibm,configure-pe".
>> VFIO_RESTORE_BARS maybe?
>>
> hrm, It's not better than the original one. Could we just
> have VFIO_EEH_PE_CONFIGURE as all left ioctl command names
> are stick to RTAS call names.
>
> Also, I might add more logic to this function to improve
> reliability. For example, if there're multiple PCI bridges
> included in the PE, I need reset them one by one and ensure
> their PCI link comes up. It's obviously not restoring BARs,
> but configuring PE :-)


VFIO_EEH_RECOVER?

>
>>>>> Also, they corresponds to 2 separate RTAS services: "ibm,set-slot-reset"
>>>>> and "ibm,configure-pe".
>>>> Does a guest always issue both? What's the order it calls them in?
>>>>
>>> For one error, the following RTAS calls was called in general:
>>>
>>> < stop device drivers, no PCI traffic expected during recovery >
>>> ibm,set-eeh-option
>>> ibm,configure-pe
>>> < error log retrival >
>> I see. So the guest retrieves the log via BARs from the device? I
>> guess I'm failing to see what "the log" is.
>>
> well. It seems that I didn't describe it clearly enough. The ioctl
> command was introduced to finish the function that should be done
> with RTAS call "ibm,configure-pe", which is to configure PCI bridges's
> config space correctly. Without that, it's possible that we can't
> access the config space of the subordinate PCI devices of the PCI
> bridges. So we should restore config space for PCI bridges. However,
> we also need restore config space for normal PCI devices because
> userland has some config space registers masked off and can't access
> them all, so it's not reliable to restore config space for normal
> PCI devices from userland.
>
> So the restoring config space of PCI bridges is required, but restoring
> config space for normal devices are a trick here.

So what if user space accesses config space while the device is broken? 
What if it accesses an mmap'ed BAR while the device is in broken state 
and BARs haven't been recovered yet?


Alex
