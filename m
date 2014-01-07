Return-Path: <jiang.liu@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by ozlabs.org (Postfix) with ESMTP id 9AC722C00D4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jan 2014 20:04:18 +1100 (EST)
Message-ID: <52CBC0B6.1090904@linux.intel.com>
Date: Tue, 07 Jan 2014 16:54:14 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: Yijing Wang <wangyijing@huawei.com>,
 Dongsheng Wang <dongsheng.wang@freescale.com>,
 bhelgaas@google.com, rjw@rjwysocki.net
Subject: Re: [PATCH 1/2] pci: Fix root port bus->self is NULL
References: <1389081848-26506-1-git-send-email-dongsheng.wang@freescale.com>
 <52CBBA86.7020401@huawei.com>
In-Reply-To: <52CBBA86.7020401@huawei.com>
Content-Type: text/plain; charset=UTF-8
Cc: scottwood@freescale.com, roy.zang@freescale.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, galak@codeaurora.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 2014/1/7 16:27, Yijing Wang wrote:
> On 2014/1/7 16:04, Dongsheng Wang wrote:
>> From: Wang Dongsheng <dongsheng.wang@freescale.com>
>>
>> the root port bus->self always NULL, so put root port pci device
>> into root port bus->self.
>>
>> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 38e403d..7f2d1ab 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -1472,6 +1472,9 @@ int pci_scan_slot(struct pci_bus *bus, int devfn)
>>  	if (!dev->is_added)
>>  		nr++;
>>  
>> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
>> +		bus->self = dev;
> 
> In this case, bus is the pci root bus I think, so why set bus->self = root port ?
> "bus->self" should pointer to the pci device that bridge out this bus.
Yes, this patch seems wrong. If dev is root port, bus should be root
bus, so we shouldn't set root_bus->self = pci_dev_of_root_port.

Actually PCI core has correctly setup pci_bus->self for secondary bus
of PCIe root port.

Thanks!
Gerry

> 
>> +
>>  	for (fn = next_fn(bus, dev, 0); fn > 0; fn = next_fn(bus, dev, fn)) {
>>  		dev = pci_scan_single_device(bus, devfn + fn);
>>  		if (dev) {
>>
> 
> 
