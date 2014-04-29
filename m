Return-Path: <aik@ozlabs.ru>
Received: from mail-ig0-f180.google.com (mail-ig0-f180.google.com
 [209.85.213.180])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CB2051400FE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 23:11:24 +1000 (EST)
Received: by mail-ig0-f180.google.com with SMTP id c1so248290igq.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 06:11:13 -0700 (PDT)
Message-ID: <535FA4E9.9050403@ozlabs.ru>
Date: Tue, 29 Apr 2014 23:11:05 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Wei Yang <weiyang@linux.vnet.ibm.com>,
 Alexey Kardashevskiy <aik@au1.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/powernv: reduce multi-hit of
 iommu_add_device()
References: <1398219993-6326-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <535E5924.8040503@au1.ibm.com> <20140429064955.GA5066@richard>
 <535F5B04.5000102@au1.ibm.com> <20140429093719.GB8028@richard>
In-Reply-To: <20140429093719.GB8028@richard>
Content-Type: text/plain; charset=KOI8-R
Cc: linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/29/2014 07:37 PM, Wei Yang wrote:
> On Tue, Apr 29, 2014 at 05:55:48PM +1000, Alexey Kardashevskiy wrote:
>> On 04/29/2014 04:49 PM, Wei Yang wrote:
>>> On Mon, Apr 28, 2014 at 11:35:32PM +1000, Alexey Kardashevskiy wrote:
>>>> On 04/23/2014 12:26 PM, Wei Yang wrote:
>>>>> During the EEH hotplug event, iommu_add_device() will be invoked three times
>>>>> and two of them will trigger warning or error.
>>>>>
>>>>> The three times to invoke the iommu_add_device() are:
>>>>>
>>>>>     pci_device_add
>>>>>        ...
>>>>>        set_iommu_table_base_and_group   <- 1st time, fail
>>>>>     device_add
>>>>>        ...
>>>>>        tce_iommu_bus_notifier           <- 2nd time, succees
>>>>>     pcibios_add_pci_devices
>>>>>        ...
>>>>>        pcibios_setup_bus_devices        <- 3rd time, re-attach
>>>>>
>>>>> The first time fails, since the dev->kobj->sd is not initialized. The
>>>>> dev->kobj->sd is initialized in device_add().
>>>>> The third time's warning is triggered by the re-attach of the iommu_group.
>>>>>
>>>>> After applying this patch, the error
>>>>
>>>> Nack.
>>>>
>>>> The patch still seems incorrect and we actually need to remove
>>>> tce_iommu_bus_notifier completely as pcibios_setup_bus_devices is called
>>> >from another notifier anyway. Could you please test it?
>>>>
>>>>
>>>
>>> Hi, Alexey,
>>>
>>> Nice to see your comment. Let me show what I got fist.
>>>
>>> Generally, when kernel enumerate on the pci device, following functions will
>>> be invoked.
>>>
>>>      pci_device_add
>>>         pcibios_setup_bus_device
>>>         ...
>>>         set_iommu_table_base_and_group   
>>>      device_add
>>>         ...
>>>         tce_iommu_bus_notifier           
>>>      pcibios_fixp_bus
>>>         pcibios_add_pci_devices
>>>         ...
>>>         pcibios_setup_bus_devices        
>>>
>>> >From the call flow, we see for a normall pci device, the
>>> pcibios_setup_bus_device() will be invoked twice.
>>
>>
>> tce_iommu_bus_notifier should not be called for devices during boot-time
>> PCI discovery as the discovery is done from subsys_initcall handler and
>> tce_iommu_bus_notifier is registered as subsys_initcall_sync. Are you sure
>> this is happening? You should see warnings as for PF's EEH but you do not
>> say that.
>>
> 
> Let me make it clearer. I list the call flow for general purpose to show the
> sequence of the call flow.
> 
> The tce_iommu_bus_notifier is not invoked at the boot time. And none of them
> do real thing at boot time.
> 
> I don't understand your last sentence. I see warning and error during EEH
> hotplug. If necessary, I will add this in the commit log.
> 
>>
>>> At the bootup time, none of them succeed to setup the dma, since the PE is not
>>> assigned or the tbl is not set. The iommu tbl and group is setup in
>>> pnv_pci_ioda_setup_DMA().
>>>
>>> This call flow maintains the same when EEH error happens on Bus PE, while the
>>> behavior is a little different. 
>>>
>>>      pci_device_add
>>>         pcibios_setup_bus_device
>>>         ...
>>>         set_iommu_table_base_and_group   <- fail, kobj->sd is not initialized
>>
>>
>> Sorry, what is uninitialized? The only kobj here is the one in iommu_group
>> and it must have been taken care of before adding a device.
> 
> pci_dev->dev->kobj->sd.
> 
> I have explained this in previous discussion. This kobj->sd is initialized in
> device_add().
> 
>>
>>
>>>      device_add
>>>         ...
>>>         tce_iommu_bus_notifier           <- succeed
>>>      pcibios_fixp_bus
>>>         pcibios_add_pci_devices
>>>         ...
>>>         pcibios_setup_bus_devices        <- warning, re-attach
>>
>>
>> This is why I am suggesting getting rid of tce_iommu_bus_notifier - we will
>> avoid the warning.
> 
> Then how about the first time's error?


What do you call "first time error" here?


>>> While this call flow will change a little on a VF. For a VF,
>>> pcibios_fixp_bus() will not be invoked. Current behavior is this.
>>
>>
>> You meant pcibios_fixup_bus? I would expect it to get called (from
>> pci_rescan_bus() or something like that?) and this seems to be the problem
>> here.
> 
> When EEH happens and hotplug the pci bus, we need to do the pci_scan_bridge()
> which will do the pcibios_fixup_bus().

Are you talking now about EEH on PF (physical function) or EEH on VF
(virtual function)?

Are you calling pci_scan_bridge()


> So you suggest to remove it? This is the generic code.


I suggest removing tce_iommu_bus_notifier only. It must go. It was my
mistake at the first place.


>> How are VFs added in terms of code flow? Is there any git tree to look at?
>>
> 
> VF add code flow is a generic code in drivers/pci/iov.c, virtfn_add().

virtfn_add -> pci_device_add -> pcibios_add_device -> pcibios_setup_device
-> ppc_md.pci_dma_dev_setup -> pnv_pci_dma_dev_setup ->
pnv_pci_ioda_dma_dev_setup ->
set_iommu_table_base.


What part of this is missing?


> 
>>
>>
>>>      pci_device_add
>>>         pcibios_setup_bus_device
>>>         ...
>>>         set_iommu_table_base_and_group   <- fail, kobj->sd is not initialized
>>>      device_add
>>>         ...
>>>         tce_iommu_bus_notifier           <- succeed
>>>
>>> And if an EEH error happens just on a VF, I believe the same call flow should
>>> go for recovery. (This is not set down, still under discussion with Gavin.)
>>>
>>> My conclusion is:
>>> 1. remove the tce_iommu_bus_notifier completely will make the VF not work.
>>>    So I choose to revert the code and attach make the iommu group attachment
>>>    just happens in one place.
>>>
>>> BTW, I know my patch is not a perfect one. For a PF, the tbl will still be set
>>> twice. I am not sure why we need to invoke pcibios_setup_device() twice on a
>>> PF, maybe some platform need to fixup some thing after the pci_bus is added.
>>> So I don't remove one of them to solve the problem.
>>>
>>> If you have a better idea, I am glad to take it.



-- 
Alexey
