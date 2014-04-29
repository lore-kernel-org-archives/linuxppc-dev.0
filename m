Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 84540140110
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 19:38:25 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Tue, 29 Apr 2014 19:38:24 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 03E302CE8047
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 19:38:23 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3T9c7Ff11927906
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 19:38:08 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3T9bMT0017109
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 19:37:22 +1000
Date: Tue, 29 Apr 2014 17:37:20 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@au1.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/powernv: reduce multi-hit of
 iommu_add_device()
Message-ID: <20140429093719.GB8028@richard>
References: <1398219993-6326-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <535E5924.8040503@au1.ibm.com> <20140429064955.GA5066@richard>
 <535F5B04.5000102@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <535F5B04.5000102@au1.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 gwshan@linux.vnet.ibm.com
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 29, 2014 at 05:55:48PM +1000, Alexey Kardashevskiy wrote:
>On 04/29/2014 04:49 PM, Wei Yang wrote:
>> On Mon, Apr 28, 2014 at 11:35:32PM +1000, Alexey Kardashevskiy wrote:
>>> On 04/23/2014 12:26 PM, Wei Yang wrote:
>>>> During the EEH hotplug event, iommu_add_device() will be invoked three times
>>>> and two of them will trigger warning or error.
>>>>
>>>> The three times to invoke the iommu_add_device() are:
>>>>
>>>>     pci_device_add
>>>>        ...
>>>>        set_iommu_table_base_and_group   <- 1st time, fail
>>>>     device_add
>>>>        ...
>>>>        tce_iommu_bus_notifier           <- 2nd time, succees
>>>>     pcibios_add_pci_devices
>>>>        ...
>>>>        pcibios_setup_bus_devices        <- 3rd time, re-attach
>>>>
>>>> The first time fails, since the dev->kobj->sd is not initialized. The
>>>> dev->kobj->sd is initialized in device_add().
>>>> The third time's warning is triggered by the re-attach of the iommu_group.
>>>>
>>>> After applying this patch, the error
>>>
>>> Nack.
>>>
>>> The patch still seems incorrect and we actually need to remove
>>> tce_iommu_bus_notifier completely as pcibios_setup_bus_devices is called
>>>from another notifier anyway. Could you please test it?
>>>
>>>
>> 
>> Hi, Alexey,
>> 
>> Nice to see your comment. Let me show what I got fist.
>> 
>> Generally, when kernel enumerate on the pci device, following functions will
>> be invoked.
>> 
>>      pci_device_add
>>         pcibios_setup_bus_device
>>         ...
>>         set_iommu_table_base_and_group   
>>      device_add
>>         ...
>>         tce_iommu_bus_notifier           
>>      pcibios_fixp_bus
>>         pcibios_add_pci_devices
>>         ...
>>         pcibios_setup_bus_devices        
>> 
>>>From the call flow, we see for a normall pci device, the
>> pcibios_setup_bus_device() will be invoked twice.
>
>
>tce_iommu_bus_notifier should not be called for devices during boot-time
>PCI discovery as the discovery is done from subsys_initcall handler and
>tce_iommu_bus_notifier is registered as subsys_initcall_sync. Are you sure
>this is happening? You should see warnings as for PF's EEH but you do not
>say that.
>

Let me make it clearer. I list the call flow for general purpose to show the
sequence of the call flow.

The tce_iommu_bus_notifier is not invoked at the boot time. And none of them
do real thing at boot time.

I don't understand your last sentence. I see warning and error during EEH
hotplug. If necessary, I will add this in the commit log.

>
>> At the bootup time, none of them succeed to setup the dma, since the PE is not
>> assigned or the tbl is not set. The iommu tbl and group is setup in
>> pnv_pci_ioda_setup_DMA().
>> 
>> This call flow maintains the same when EEH error happens on Bus PE, while the
>> behavior is a little different. 
>> 
>>      pci_device_add
>>         pcibios_setup_bus_device
>>         ...
>>         set_iommu_table_base_and_group   <- fail, kobj->sd is not initialized
>
>
>Sorry, what is uninitialized? The only kobj here is the one in iommu_group
>and it must have been taken care of before adding a device.

pci_dev->dev->kobj->sd.

I have explained this in previous discussion. This kobj->sd is initialized in
device_add().

>
>
>>      device_add
>>         ...
>>         tce_iommu_bus_notifier           <- succeed
>>      pcibios_fixp_bus
>>         pcibios_add_pci_devices
>>         ...
>>         pcibios_setup_bus_devices        <- warning, re-attach
>
>
>This is why I am suggesting getting rid of tce_iommu_bus_notifier - we will
>avoid the warning.

Then how about the first time's error?

>
>
>> While this call flow will change a little on a VF. For a VF,
>> pcibios_fixp_bus() will not be invoked. Current behavior is this.
>
>
>You meant pcibios_fixup_bus? I would expect it to get called (from
>pci_rescan_bus() or something like that?) and this seems to be the problem
>here.

When EEH happens and hotplug the pci bus, we need to do the pci_scan_bridge()
which will do the pcibios_fixup_bus().

So you suggest to remove it? This is the generic code.

>
>How are VFs added in terms of code flow? Is there any git tree to look at?
>

VF add code flow is a generic code in drivers/pci/iov.c, virtfn_add().

>
>
>>      pci_device_add
>>         pcibios_setup_bus_device
>>         ...
>>         set_iommu_table_base_and_group   <- fail, kobj->sd is not initialized
>>      device_add
>>         ...
>>         tce_iommu_bus_notifier           <- succeed
>> 
>> And if an EEH error happens just on a VF, I believe the same call flow should
>> go for recovery. (This is not set down, still under discussion with Gavin.)
>> 
>> My conclusion is:
>> 1. remove the tce_iommu_bus_notifier completely will make the VF not work.
>>    So I choose to revert the code and attach make the iommu group attachment
>>    just happens in one place.
>> 
>> BTW, I know my patch is not a perfect one. For a PF, the tbl will still be set
>> twice. I am not sure why we need to invoke pcibios_setup_device() twice on a
>> PF, maybe some platform need to fixup some thing after the pci_bus is added.
>> So I don't remove one of them to solve the problem.
>> 
>> If you have a better idea, I am glad to take it.
>> 
>
>
>-- 
>Alexey Kardashevskiy
>IBM OzLabs, LTC Team
>
>e-mail: aik@au1.ibm.com
>notes: Alexey Kardashevskiy/Australia/IBM

-- 
Richard Yang
Help you, Help me
