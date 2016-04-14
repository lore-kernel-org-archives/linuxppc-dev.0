Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x229.google.com (mail-pa0-x229.google.com
 [IPv6:2607:f8b0:400e:c03::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlmLb1JdszDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 13:27:03 +1000 (AEST)
Received: by mail-pa0-x229.google.com with SMTP id ot11so40578316pab.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 20:27:03 -0700 (PDT)
Subject: Re: [PATCH v8 00/45] powerpc/powernv: PCI hotplug support
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <570DF50F.6010805@ozlabs.ru> <20160413074236.GA28853@gwshan>
 <570E0E13.6080409@ozlabs.ru> <20160413234246.GA5330@gwshan>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
 dja@axtens.net, bhelgaas@google.com, robherring2@gmail.com,
 grant.likely@linaro.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <570F0DFB.9090509@ozlabs.ru>
Date: Thu, 14 Apr 2016 13:26:51 +1000
MIME-Version: 1.0
In-Reply-To: <20160413234246.GA5330@gwshan>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/14/2016 09:42 AM, Gavin Shan wrote:
> On Wed, Apr 13, 2016 at 07:14:59PM +1000, Alexey Kardashevskiy wrote:
>> On 04/13/2016 05:42 PM, Gavin Shan wrote:
>>> On Wed, Apr 13, 2016 at 05:28:15PM +1000, Alexey Kardashevskiy wrote:
>>>> On 02/17/2016 02:43 PM, Gavin Shan wrote:
>>>>> This series of patches rebases on powerpc/next branch, plus below additional
>>>>> patches:
>>>>>
>>>>>     <This series of patches>
>>>>>     <Followup 3 patches from Gavin on SRIOV EEH, which aren't posted>
>>>>>     https://patchwork.ozlabs.org/patch/581315/	(PATCH[1/9] Richard's SRIOV EEH)
>>>>>     https://patchwork.ozlabs.org/patch/582639/	(PATCH[1/1] Gavin's EEH fix)
>>>>>     https://patchwork.ozlabs.org/patch/582093/	(PATCH[1/1] Gavin's EEH fix)
>>>>>     https://patchwork.ozlabs.org/patch/580626/	(PATCH[1/4] Gavin's PCI fix)
>>>>>     https://patchwork.ozlabs.org/patch/580153/	(PATCH[1/1] Andrew's EEH minor fix)
>>>>>     https://patchwork.ozlabs.org/patch/566827/	(PATCH[1/1] Russell's P5IOC2 removal)
>>>>>     https://patchwork.ozlabs.org/patch/534154/	(PATCH[1/7] Richard's SRIOV rework)
>>>>>     commit 388f7b1 ("Linux 4.5-rc3")
>>>>>
>>>>> The series of patches intend to support PCI slot for PowerPC PowerNV platform,
>>>>> which is running on top of skiboot firmware. The patchset requires corresponding
>>>>> changes from skiboot firmware, which is sent to skiboot@lists.ozlabs.org
>>>>> for review. The PCI slots are exposed by skiboot with device node properties,
>>>>> and kernel utilizes those properties to populated PCI slots accordingly.
>>>>>
>>>>> The original PCI infrastructure on PowerNV platform can't support hotplug
>>>>> because the PE is assigned during PHB fixup time, which is called for once
>>>>> during system boot time. For this, the PCI infrastructure on PowerNV platform
>>>>> has been reworked for a lot. After that, the PE and its corresponding resources
>>>>> (IODT, M32DT, M64 segments, DMA32 and bypass window) are assigned upon updating
>>>>> PCI bridge's resources, which might decide PE# assigned to the PE (e.g. M64
>>>>> resources, on P8 strictly speaking). Each PE will maintain a reference count,
>>>>> which is (number of child PCI devices + 1). That indicates when last child PCI
>>>>> device leaves the PE, the PE and its included resources will be relased and put
>>>>> back into free pool again. With this design, the PE will be released when EEH PE
>>>>> is released. PATCH[1 - 23] are related to this part.
>>>>>
>>>>>  From skiboot perspective, PCI slot is providing (hot/fundamental/complete)
>>>>> resets to EEH. The kernel gets to know if skiboot supports various reset on one
>>>>> particular PCI slot through device-tree node. If it does, EEH will utilize the
>>>>> functionality provided by skiboot. Besides, the device-tree nodes have to change
>>>>> in order to support PCI hotplug. For example, when one PCI adapter inserted to
>>>>> one slot, its device-tree node should be added to the system dynamically. Conversely,
>>>>> the device-tree node should be removed from the system when the PCI adapter is going
>>>>> to be offline. Since pci_dn and eeh_dev have same life cyle as PCI device nodes,
>>>>> they should be added/removed accordingly during PCI hotplug. PATCH[24 - 39] are
>>>>> doing the related work.
>>>>>
>>>>> The OF driver is changed to support unflattening FDT blob for sub-stree, which
>>>>> is covered by PATCH[40 - 44].
>>>>>
>>>>> The last one, PATCH[45], is the standalone PCI hotplug driver for PowerPC PowerNV
>>>>> platform.
>>>>>
>>>>> =======
>>>>> Testing
>>>>> =======
>>>>> 1. Unplug adapters behind non-empty slot, then plug them.
>>>>>
>>>>>     1.1 Check status
>>>>>     # cat /sys/bus/pci/slots/C10/address
>>>>>     0003:09:00
>>>>>     # cat /sys/bus/pci/slots/C10/adapter
>>>>>     1
>>>>>     # cat /sys/bus/pci/slots/C10/power
>>>>>     1
>>>>>     # lspci
>>>>>     0003:09:00.0 Ethernet controller: \
>>>>>     Broadcom Corporation NetXtreme BCM5719 Gigabit Ethernet PCIe (rev 01)
>>>>>     0003:09:00.1 Ethernet controller: \
>>>>>     Broadcom Corporation NetXtreme BCM5719 Gigabit Ethernet PCIe (rev 01)
>>>>>     0003:09:00.2 Ethernet controller: \
>>>>>     Broadcom Corporation NetXtreme BCM5719 Gigabit Ethernet PCIe (rev 01)
>>>>>     0003:09:00.3 Ethernet controller: \
>>>>>     Broadcom Corporation NetXtreme BCM5719 Gigabit Ethernet PCIe (rev 01)
>>>>>     # lspci -t
>>>>>     # lspci -t
>>>>>     -+-[0003:00]---00.0-[01-13]----00.0-[02-13]--+-01.0-[03]----00.0
>>>>>      |                                           +-08.0-[04-08]--
>>>>>      |                                           +-09.0-[09]--+-00.0
>>>>>      |                                           |            +-00.1
>>>>>      |                                           |            +-00.2
>>>>>      |                                           |            \-00.3
>>>>>      |                                           +-10.0-[0a-0e]--
>>>>>      |                                           \-11.0-[0f-13]--
>>>>>
>>>>>     1.2 Unplug adapter 0003:09.00.x
>>>>>     # echo 0 > /sys/bus/pci/slots/C10/power
>>>>>     # lspci -t
>>>>>     -+-[0003:00]---00.0-[01-13]----00.0-[02-13]--+-01.0-[03]----00.0
>>>>>      |                                           +-08.0-[04-08]--
>>>>>      |                                           +-09.0-[09]--
>>>>>      |                                           +-10.0-[0a-0e]--
>>>>>      |                                           \-11.0-[0f-13]--
>>>>>
>>>>>     1.3 Plug adapter 0003:09.00.x
>>>>>     # echo 1 > /sys/bus/pci/slots/C10/power
>>>>
>>>>
>>>> Do I understand correctly that the adapter was not physically moved in/out of
>>>> the slot between 1.2 and 1.3?
>>>>
>>>
>>> Correct.
>>
>>
>> This is not right then... Someone should try it, on both P7 and P8.
>>
>
> Do you mean physically pull the adapter out and insert the same
> adapter back? What's the point for the test case?


Because this is what the patchset is for - to replace a physical device on 
a physical machine. Powering on/off the slots via sysfs is just an 
approximation (which is fine when you are debugging), something can go 
wrong and require some work but you do not know it for sure.



-- 
Alexey
