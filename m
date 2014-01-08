Return-Path: <jiang.liu@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by ozlabs.org (Postfix) with ESMTP id 6ED302C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jan 2014 13:33:17 +1100 (EST)
Message-ID: <52CCB8E9.6020501@linux.intel.com>
Date: Wed, 08 Jan 2014 10:33:13 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>,
 Yijing Wang <wangyijing@huawei.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] pci: Fix root port bus->self is NULL
References: <1389081848-26506-1-git-send-email-dongsheng.wang@freescale.com>
 <52CBBA86.7020401@huawei.com> <52CBC0B6.1090904@linux.intel.com>
 <80033eb36b0f40d682aeecc8b99dbd95@BN1PR03MB188.namprd03.prod.outlook.com>
In-Reply-To: <80033eb36b0f40d682aeecc8b99dbd95@BN1PR03MB188.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Cc: Scott Wood <scottwood@freescale.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "galak@codeaurora.org" <galak@codeaurora.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 2014/1/7 17:51, Dongsheng.Wang@freescale.com wrote:
>>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c index
>>>> 38e403d..7f2d1ab 100644
>>>> --- a/drivers/pci/probe.c
>>>> +++ b/drivers/pci/probe.c
>>>> @@ -1472,6 +1472,9 @@ int pci_scan_slot(struct pci_bus *bus, int devfn)
>>>>  	if (!dev->is_added)
>>>>  		nr++;
>>>>
>>>> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
>>>> +		bus->self = dev;
>>>
>>> In this case, bus is the pci root bus I think, so why set bus->self = root
>> port ?
>>> "bus->self" should pointer to the pci device that bridge out this bus.
>> Yes, this patch seems wrong. If dev is root port, bus should be root bus, so we
>> shouldn't set root_bus->self = pci_dev_of_root_port.
>>
> Why the root bus->self pointer to the bridge?
> If child bus create from root bus, the child->self will get the bridge(root port) pci device.
> 
>> Actually PCI core has correctly setup pci_bus->self for secondary bus of PCIe
>> root port.
> Yes, right. But the root-bus->self is NULL. I think the root bus should get root port
> pci device for itself. If there is no bridge at board how to get the root port device?
Hi Dongsheng,
	PCI root bus represents PCI host bridge, which has no
corresponding PCI device.

> 
> -Dongsheng
> 
>>
>> Thanks!
>> Gerry
>>
> 
