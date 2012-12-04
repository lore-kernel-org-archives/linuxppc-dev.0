Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D9D062C03A1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Dec 2012 01:33:07 +1100 (EST)
Subject: Re: [PATCH] powerpc/pci-hotplug: fix the rescanned pci device's
 dma_set_mask issue
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <42C14AFA-42D6-498D-9B38-A02CEAC2D0BA@kernel.crashing.org>
Date: Tue, 4 Dec 2012 08:32:56 -0600
Message-Id: <3D08FBCB-926B-47BC-A2EB-1AFF3B1856BE@kernel.crashing.org>
References: <1353644968-29469-1-git-send-email-B41889@freescale.com>
 <455E76A9-ABB3-4FF6-A19E-612E43223C4A@kernel.crashing.org>
 <50B5782A.4050308@freescale.com>
 <42C14AFA-42D6-498D-9B38-A02CEAC2D0BA@kernel.crashing.org>
To: Chen Yuanquan-B41889 <B41889@freescale.com>
Cc: "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 28, 2012, at 11:34 AM, Kumar Gala wrote:

>=20
> On Nov 27, 2012, at 8:34 PM, Chen Yuanquan-B41889 wrote:
>=20
>> On 11/25/2012 08:41 PM, Kumar Gala wrote:
>>> On Nov 22, 2012, at 10:29 PM, Yuanquan Chen wrote:
>>>=20
>>>> On powerpc arch, dma_ops of rescanned pci device after system's =
booting up won't be
>>>> initialized by system, so it will fail to execute the dma_set_mask =
in the device's
>>>> driver. Initialize it to solve this issue.
>>>>=20
>>>> Signed-off-by: Yuanquan Chen <B41889@freescale.com>
>>>> ---
>>>> arch/powerpc/include/asm/dma-mapping.h |    7 +++++--
>>>> 1 file changed, 5 insertions(+), 2 deletions(-)
>>> This is not the right way to get the dma_ops setup.  You need to =
find some other point for the hotplug scenario to get the dma_ops setup.
>>>=20
>>> - k
>>=20
>> Hi Kumar,
>>=20
>> I read the code about pci bus scan and rescan. Only the =
pcibios_fixup_bus in pci_scan_child_bus and
>> pcibios_enable_device in pci_rescan_bus are arch related code. The =
pcibios_fixup_bus won't be called
>> for the rescanned PCI devices due to the bus->is_added has been set =
for the first scanning at boot time.
>> So I think it's more reasonable to do the same work as =
pcibios_fixup_bus for rescanned PCI device in
>> pcibios_enable_device. The patch code is a copy of =
pcibios_setup_bus_devices called by pcibios_fixup_bus,
>> It can solve the dma_set_mask and irq related issues of rescanned PCI =
device on powerpc arch. What's
>> your opinion?
>>=20
>> Thanks,
>> yuanquan
>>=20
>> diff --git a/arch/powerpc/kernel/pci-common.c =
b/arch/powerpc/kernel/pci-common.c
>> index 7f94f76..30f7d61 100644
>> --- a/arch/powerpc/kernel/pci-common.c
>> +++ b/arch/powerpc/kernel/pci-common.c
>> @@ -1496,6 +1496,23 @@ int pcibios_enable_device(struct pci_dev *dev, =
int mask)
>>               if (ppc_md.pcibios_enable_device_hook(dev))
>>                       return -EINVAL;
>>=20
>> +       if (!dev->is_added) {
>> +               set_dev_node(&dev->dev, pcibus_to_node(dev->bus));
>> +
>> +               /* Hook up default DMA ops */
>> +               set_dma_ops(&dev->dev, pci_dma_ops);
>> +               set_dma_offset(&dev->dev, PCI_DRAM_OFFSET);
>> +
>> +               /* Additional platform DMA/iommu setup */
>> +               if (ppc_md.pci_dma_dev_setup)
>> +                       ppc_md.pci_dma_dev_setup(dev);
>> +
>> +               /* Read default IRQs and fixup if necessary */
>> +               pci_read_irq_line(dev);
>> +               if (ppc_md.pci_irq_fixup)
>> +                       ppc_md.pci_irq_fixup(dev);
>> +       }
>> +
>>       return pci_enable_resources(dev, mask);
>> }
>>=20
>=20
> This looks better than the first patch..  I'm surprised that the IBM =
guys don't run into a similar issue with their hotplug support.
>=20
> Maybe Ben or someone else will comment.
>=20
> - k

How about you post this as a clean patch, will be easier to get Ben to =
comment on that.

- k=
