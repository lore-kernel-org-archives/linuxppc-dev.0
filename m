Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 200671400AC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 16:50:10 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Tue, 29 Apr 2014 12:20:00 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 5764C1258053
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 12:18:49 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3T6o4fr5833152
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 12:20:05 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3T6nvVE027489
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 12:19:57 +0530
Date: Tue, 29 Apr 2014 14:49:55 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@au1.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/powernv: reduce multi-hit of
 iommu_add_device()
Message-ID: <20140429064955.GA5066@richard>
References: <1398219993-6326-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <535E5924.8040503@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <535E5924.8040503@au1.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 28, 2014 at 11:35:32PM +1000, Alexey Kardashevskiy wrote:
>On 04/23/2014 12:26 PM, Wei Yang wrote:
>> During the EEH hotplug event, iommu_add_device() will be invoked three times
>> and two of them will trigger warning or error.
>> 
>> The three times to invoke the iommu_add_device() are:
>> 
>>     pci_device_add
>>        ...
>>        set_iommu_table_base_and_group   <- 1st time, fail
>>     device_add
>>        ...
>>        tce_iommu_bus_notifier           <- 2nd time, succees
>>     pcibios_add_pci_devices
>>        ...
>>        pcibios_setup_bus_devices        <- 3rd time, re-attach
>> 
>> The first time fails, since the dev->kobj->sd is not initialized. The
>> dev->kobj->sd is initialized in device_add().
>> The third time's warning is triggered by the re-attach of the iommu_group.
>> 
>> After applying this patch, the error
>
>Nack.
>
>The patch still seems incorrect and we actually need to remove
>tce_iommu_bus_notifier completely as pcibios_setup_bus_devices is called
>from another notifier anyway. Could you please test it?
>
>

Hi, Alexey,

Nice to see your comment. Let me show what I got fist.

Generally, when kernel enumerate on the pci device, following functions will
be invoked.

     pci_device_add
        pcibios_setup_bus_device
        ...
        set_iommu_table_base_and_group   
     device_add
        ...
        tce_iommu_bus_notifier           
     pcibios_fixp_bus
        pcibios_add_pci_devices
        ...
        pcibios_setup_bus_devices        

>From the call flow, we see for a normall pci device, the
pcibios_setup_bus_device() will be invoked twice.

At the bootup time, none of them succeed to setup the dma, since the PE is not
assigned or the tbl is not set. The iommu tbl and group is setup in
pnv_pci_ioda_setup_DMA().

This call flow maintains the same when EEH error happens on Bus PE, while the
behavior is a little different. 

     pci_device_add
        pcibios_setup_bus_device
        ...
        set_iommu_table_base_and_group   <- fail, kobj->sd is not initialized
     device_add
        ...
        tce_iommu_bus_notifier           <- succeed
     pcibios_fixp_bus
        pcibios_add_pci_devices
        ...
        pcibios_setup_bus_devices        <- warning, re-attach

While this call flow will change a little on a VF. For a VF,
pcibios_fixp_bus() will not be invoked. Current behavior is this.

     pci_device_add
        pcibios_setup_bus_device
        ...
        set_iommu_table_base_and_group   <- fail, kobj->sd is not initialized
     device_add
        ...
        tce_iommu_bus_notifier           <- succeed

And if an EEH error happens just on a VF, I believe the same call flow should
go for recovery. (This is not set down, still under discussion with Gavin.)

My conclusion is:
1. remove the tce_iommu_bus_notifier completely will make the VF not work.
   So I choose to revert the code and attach make the iommu group attachment
   just happens in one place.

BTW, I know my patch is not a perfect one. For a PF, the tbl will still be set
twice. I am not sure why we need to invoke pcibios_setup_device() twice on a
PF, maybe some platform need to fixup some thing after the pci_bus is added.
So I don't remove one of them to solve the problem.

If you have a better idea, I am glad to take it.

-- 
Richard Yang
Help you, Help me
