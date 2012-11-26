Return-Path: <B41889@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8EC862C007C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2012 16:29:38 +1100 (EST)
Message-ID: <50B2FE56.4080605@freescale.com>
Date: Mon, 26 Nov 2012 13:29:58 +0800
From: Chen Yuanquan-B41889 <B41889@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/pci-hotplug: fix the rescanned pci device's
 dma_set_mask issue
References: <1353644968-29469-1-git-send-email-B41889@freescale.com>
 <455E76A9-ABB3-4FF6-A19E-612E43223C4A@kernel.crashing.org>
In-Reply-To: <455E76A9-ABB3-4FF6-A19E-612E43223C4A@kernel.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, r61911@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/25/2012 08:41 PM, Kumar Gala wrote:
> On Nov 22, 2012, at 10:29 PM, Yuanquan Chen wrote:
>
>> On powerpc arch, dma_ops of rescanned pci device after system's booting up won't be
>> initialized by system, so it will fail to execute the dma_set_mask in the device's
>> driver. Initialize it to solve this issue.
>>
>> Signed-off-by: Yuanquan Chen <B41889@freescale.com>
>> ---
>> arch/powerpc/include/asm/dma-mapping.h |    7 +++++--
>> 1 file changed, 5 insertions(+), 2 deletions(-)
> This is not the right way to get the dma_ops setup.  You need to find some other point for the hotplug scenario to get the dma_ops setup.
>
> - k

Hi Kumar,

I read the code about pci bus scan and rescan. Only the 
pcibios_fixup_bus in pci_scan_child_bus and
pcibios_enable_device in pci_rescan_bus are arch related code. The 
pcibios_fixup_bus won't be called
for the rescanned PCI devices due to the bus->is_added has been set for 
the first scanning at boot time.
So I think it's more reasonable to do the same work as pcibios_fixup_bus 
for rescanned PCI device in
pcibios_enable_device. The patch code is a copy of 
pcibios_setup_bus_devices called by pcibios_fixup_bus,
It can solve the dma_set_mask and irq related issues of rescanned PCI 
device on powerpc arch. What's
your opinion?

Thanks,
yuanquan

diff --git a/arch/powerpc/kernel/pci-common.c 
b/arch/powerpc/kernel/pci-common.c
index 7f94f76..30f7d61 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1496,6 +1496,23 @@ int pcibios_enable_device(struct pci_dev *dev, 
int mask)
                 if (ppc_md.pcibios_enable_device_hook(dev))
                         return -EINVAL;

+       if (!dev->is_added) {
+               set_dev_node(&dev->dev, pcibus_to_node(dev->bus));
+
+               /* Hook up default DMA ops */
+               set_dma_ops(&dev->dev, pci_dma_ops);
+               set_dma_offset(&dev->dev, PCI_DRAM_OFFSET);
+
+               /* Additional platform DMA/iommu setup */
+               if (ppc_md.pci_dma_dev_setup)
+                       ppc_md.pci_dma_dev_setup(dev);
+
+               /* Read default IRQs and fixup if necessary */
+               pci_read_irq_line(dev);
+               if (ppc_md.pci_irq_fixup)
+                       ppc_md.pci_irq_fixup(dev);
+       }
+
         return pci_enable_resources(dev, mask);
  }

>> diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
>> index 7816087..22eae53 100644
>> --- a/arch/powerpc/include/asm/dma-mapping.h
>> +++ b/arch/powerpc/include/asm/dma-mapping.h
>> @@ -126,8 +126,11 @@ static inline int dma_supported(struct device *dev, u64 mask)
>> {
>> 	struct dma_map_ops *dma_ops = get_dma_ops(dev);
>>
>> -	if (unlikely(dma_ops == NULL))
>> -		return 0;
>> +	if (unlikely(dma_ops == NULL)) {
>> +		set_dma_ops(dev, &dma_direct_ops);
>> +		set_dma_offset(dev, PCI_DRAM_OFFSET);
>> +		dma_ops = &dma_direct_ops;
>> +	}
>> 	if (dma_ops->dma_supported == NULL)
>> 		return 1;
>> 	return dma_ops->dma_supported(dev, mask);
>> -- 
>> 1.7.9.5
>>
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
>
>
