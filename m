Return-Path: <bhelgaas@google.com>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
 [209.85.215.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 84441B6F86
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2012 13:08:50 +1000 (EST)
Received: by lagw12 with SMTP id w12so358601lag.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2012 20:08:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1337914811.16119.7.camel@pasglop>
References: <20120523222635.24276.80023.stgit@bhelgaas.mtv.corp.google.com>
 <20120523223700.24276.76804.stgit@bhelgaas.mtv.corp.google.com>
 <1337914811.16119.7.camel@pasglop>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 24 May 2012 21:08:24 -0600
Message-ID: <CAErSpo6W28r4f5pJmZr=ofUAaffiUtOqgXWeabGpr+DmKw+Z+g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] powerpc/PCI: move DMA & IRQ init to device_add()
 notification path
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michal Simek <monstr@monstr.eu>,
 Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>,
 microblaze-uclinux@itee.uq.edu.au,
 Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
 Jesse Larrew <jlarrew@linux.vnet.ibm.com>, jbarnes@virtuousgeek.org,
 Dominik Brodowski <linux@dominikbrodowski.net>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 24, 2012 at 9:00 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2012-05-23 at 16:37 -0600, Bjorn Helgaas wrote:
>> From: Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>
>>
>> PowerPC initialized DMA and IRQ information in the pci_scan_child_bus()
>> -> pcibios_fixup_bus() path. =A0Some hotplug drivers use that path, but
>> others don't, e.g., pciehp, so sometimes hot-added devices are only
>> partly initialized.
>>
>> This patch moves that initialization from pcibios_fixup_bus() to a new
>> pci_bus_notify() called in the pci_bus_add_device() -> device_add() path=
.
>> That means the initialization happens the same way for all PCI devices,
>> whether they are present at boot or hot-added later.
>>
>> Note that powerpc was the only user of pci_fixup_cardbus(), which was
>> used to do this same setup for cardbus devices. =A0That's no longer
>> needed because this setup will now be done in the same device_add()
>> notification path as all other PCI devices.
>
> Hrm. That will require a good deal of testing... Unfortunately I'm out
> for a few weeks getting some surgery and then recovering...
>
> Our PCI code has ancient roots and I wouldn't be surprised if that
> change breaks subtle assumptions made here or there, we'd need to test
> at least on a good range of macs and ibm hotplug stuff.

OK.  Are you worried about cardbus in particular?

This is headed for the 3.6, not 3.5, so we should have plenty of time.
 As soon as everything for the current merge window gets merged and
-next is ready for the next batch, I'll put this in there.

>> Typical failure of a hot-added e1000e device prior to this change:
>>
>> =A0 =A0 # echo 1 > /sys/bus/pci/slots/1/power
>> =A0 =A0 <snip>
>> =A0 =A0 e1000e 0000:03:00.0: enabling device (0000 -> 0002)
>> =A0 =A0 e1000e 0000:03:00.0: No usable DMA configuration, aborting
>> =A0 =A0 e1000e: probe of 0000:03:00.0 failed with error -5
>>
>> Successful initialization after this change:
>>
>> =A0 =A0 # echo 1 > /sys/bus/pci/slots/1/power
>> =A0 =A0 <snip>
>> =A0 =A0 e1000e 0000:03:00.0: enabling device (0000 -> 0002)
>> =A0 =A0 irq: irq 6 on host /soc@ffe00000/msi@41600 mapped to virtual irq=
 27
>> =A0 =A0 e1000e 0000:03:00.0: eth0: (PCI Express:2.5GT/s:Width x1) 00:15:=
17:bf:c0:c9
>> =A0 =A0 e1000e 0000:03:00.0: eth0: Intel(R) PRO/1000 Network Connection
>> =A0 =A0 e1000e 0000:03:00.0: eth0: MAC: 1, PHY: 4, PBA No: D50861-003
>>
>> [bhelgaas: changelog, notifier name, registration can be __init]
>> CC: Dominik Brodowski <linux@dominikbrodowski.net>
>> Signed-off-by: Hiroo MATSUMOTO <matsumoto.hiroo@jp.fujitsu.com>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> ---
>> =A0arch/powerpc/include/asm/pci.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 -
>> =A0arch/powerpc/kernel/pci-common.c =A0 =A0 =A0 =A0 =A0 | =A0 87 +++++++=
+++++++--------------
>> =A0arch/powerpc/kernel/pci_32.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +
>> =A0arch/powerpc/kernel/pci_64.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +
>> =A0arch/powerpc/kernel/pci_of_scan.c =A0 =A0 =A0 =A0 =A0| =A0 =A01
>> =A0arch/powerpc/platforms/pseries/pci_dlpar.c | =A0 =A01
>> =A0drivers/pci/pci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A05 --
>> =A0drivers/pcmcia/cardbus.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A03 -
>> =A0include/linux/pci.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A03 -
>> =A09 files changed, 49 insertions(+), 57 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/p=
ci.h
>> index 6653f27..d6a36a4 100644
>> --- a/arch/powerpc/include/asm/pci.h
>> +++ b/arch/powerpc/include/asm/pci.h
>> @@ -183,10 +183,10 @@ extern void pci_resource_to_user(const struct pci_=
dev *dev, int bar,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0resource_=
size_t *start, resource_size_t *end);
>>
>> =A0extern resource_size_t pcibios_io_space_offset(struct pci_controller =
*hose);
>> -extern void pcibios_setup_bus_devices(struct pci_bus *bus);
>> =A0extern void pcibios_setup_bus_self(struct pci_bus *bus);
>> =A0extern void pcibios_setup_phb_io_space(struct pci_controller *hose);
>> =A0extern void pcibios_scan_phb(struct pci_controller *hose);
>> +extern void pcibios_setup_bus_notifier(void);
>>
>> =A0#endif =A0 =A0 =A0 /* __KERNEL__ */
>> =A0#endif /* __ASM_POWERPC_PCI_H */
>> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-=
common.c
>> index 7320f36..41b39ba 100644
>> --- a/arch/powerpc/kernel/pci-common.c
>> +++ b/arch/powerpc/kernel/pci-common.c
>> @@ -1009,40 +1009,6 @@ void __devinit pcibios_setup_bus_self(struct pci_=
bus *bus)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ppc_md.pci_dma_bus_setup(bus);
>> =A0}
>>
>> -void __devinit pcibios_setup_bus_devices(struct pci_bus *bus)
>> -{
>> - =A0 =A0 struct pci_dev *dev;
>> -
>> - =A0 =A0 pr_debug("PCI: Fixup bus devices %d (%s)\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0bus->number, bus->self ? pci_name(bus->self=
) : "PHB");
>> -
>> - =A0 =A0 list_for_each_entry(dev, &bus->devices, bus_list) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 /* Cardbus can call us to add new devices to a=
 bus, so ignore
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0* those who are already fully discovered
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (dev->is_added)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 /* Fixup NUMA node as it may not be setup yet =
by the generic
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0* code and is needed by the DMA init
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 =A0 =A0 =A0 set_dev_node(&dev->dev, pcibus_to_node(dev->bu=
s));
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 /* Hook up default DMA ops */
>> - =A0 =A0 =A0 =A0 =A0 =A0 set_dma_ops(&dev->dev, pci_dma_ops);
>> - =A0 =A0 =A0 =A0 =A0 =A0 set_dma_offset(&dev->dev, PCI_DRAM_OFFSET);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 /* Additional platform DMA/iommu setup */
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (ppc_md.pci_dma_dev_setup)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ppc_md.pci_dma_dev_setup(dev);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 /* Read default IRQs and fixup if necessary */
>> - =A0 =A0 =A0 =A0 =A0 =A0 pci_read_irq_line(dev);
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (ppc_md.pci_irq_fixup)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ppc_md.pci_irq_fixup(dev);
>> - =A0 =A0 }
>> -}
>> -
>> =A0void pcibios_set_master(struct pci_dev *dev)
>> =A0{
>> =A0 =A0 =A0 /* No special bus mastering setup handling */
>> @@ -1059,19 +1025,9 @@ void __devinit pcibios_fixup_bus(struct pci_bus *=
bus)
>>
>> =A0 =A0 =A0 /* Now fixup the bus bus */
>> =A0 =A0 =A0 pcibios_setup_bus_self(bus);
>> -
>> - =A0 =A0 /* Now fixup devices on that bus */
>> - =A0 =A0 pcibios_setup_bus_devices(bus);
>> =A0}
>> =A0EXPORT_SYMBOL(pcibios_fixup_bus);
>>
>> -void __devinit pci_fixup_cardbus(struct pci_bus *bus)
>> -{
>> - =A0 =A0 /* Now fixup devices on that bus */
>> - =A0 =A0 pcibios_setup_bus_devices(bus);
>> -}
>> -
>> -
>> =A0static int skip_isa_ioresource_align(struct pci_dev *dev)
>> =A0{
>> =A0 =A0 =A0 if (pci_has_flag(PCI_CAN_SKIP_ISA_ALIGN) &&
>> @@ -1685,6 +1641,49 @@ void __devinit pcibios_scan_phb(struct pci_contro=
ller *hose)
>> =A0 =A0 =A0 }
>> =A0}
>>
>> +static int pci_bus_notify(struct notifier_block *nb, unsigned long acti=
on,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *data)
>> +{
>> + =A0 =A0 struct pci_dev *dev =3D to_pci_dev(data);
>> +
>> + =A0 =A0 switch (action) {
>> + =A0 =A0 case BUS_NOTIFY_ADD_DEVICE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Setup OF node pointer in the device */
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev->dev.of_node =3D pci_device_to_OF_node(dev=
);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Fixup NUMA node as it may not be setup yet =
by the generic
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* code and is needed by the DMA init
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 set_dev_node(&dev->dev, pcibus_to_node(dev->bu=
s));
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Hook up default DMA ops */
>> + =A0 =A0 =A0 =A0 =A0 =A0 set_dma_ops(&dev->dev, pci_dma_ops);
>> + =A0 =A0 =A0 =A0 =A0 =A0 set_dma_offset(&dev->dev, PCI_DRAM_OFFSET);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Additional platform DMA/iommu setup */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ppc_md.pci_dma_dev_setup)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ppc_md.pci_dma_dev_setup(dev);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Read default IRQs and fixup if necessary */
>> + =A0 =A0 =A0 =A0 =A0 =A0 pci_read_irq_line(dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ppc_md.pci_irq_fixup)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ppc_md.pci_irq_fixup(dev);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static struct notifier_block device_nb =3D {
>> + =A0 =A0 .notifier_call =3D pci_bus_notify,
>> +};
>> +
>> +void __init pcibios_setup_bus_notifier(void)
>> +{
>> + =A0 =A0 bus_register_notifier(&pci_bus_type, &device_nb);
>> +}
>> +
>> =A0static void fixup_hide_host_resource_fsl(struct pci_dev *dev)
>> =A0{
>> =A0 =A0 =A0 int i, class =3D dev->class >> 8;
>> diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
>> index 4b06ec5..640cc35 100644
>> --- a/arch/powerpc/kernel/pci_32.c
>> +++ b/arch/powerpc/kernel/pci_32.c
>> @@ -231,6 +231,8 @@ static int __init pcibios_init(void)
>>
>> =A0 =A0 =A0 printk(KERN_INFO "PCI: Probing PCI hardware\n");
>>
>> + =A0 =A0 pcibios_setup_bus_notifier();
>> +
>> =A0 =A0 =A0 if (pci_has_flag(PCI_REASSIGN_ALL_BUS))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_assign_all_buses =3D 1;
>>
>> diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
>> index 4ff190f..8b212d3 100644
>> --- a/arch/powerpc/kernel/pci_64.c
>> +++ b/arch/powerpc/kernel/pci_64.c
>> @@ -48,6 +48,8 @@ static int __init pcibios_init(void)
>>
>> =A0 =A0 =A0 printk(KERN_INFO "PCI: Probing PCI hardware\n");
>>
>> + =A0 =A0 pcibios_setup_bus_notifier();
>> +
>> =A0 =A0 =A0 /* For now, override phys_mem_access_prot. If we need it,g
>> =A0 =A0 =A0 =A0* later, we may move that initialization to each ppc_md
>> =A0 =A0 =A0 =A0*/
>> diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci=
_of_scan.c
>> index ae5ea5e..eb09eca 100644
>> --- a/arch/powerpc/kernel/pci_of_scan.c
>> +++ b/arch/powerpc/kernel/pci_of_scan.c
>> @@ -333,7 +333,6 @@ static void __devinit __of_scan_bus(struct device_no=
de *node,
>> =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 if (!rescan_existing)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pcibios_setup_bus_self(bus);
>> - =A0 =A0 pcibios_setup_bus_devices(bus);
>>
>> =A0 =A0 =A0 /* Now scan child busses */
>> =A0 =A0 =A0 list_for_each_entry(dev, &bus->devices, bus_list) {
>> diff --git a/arch/powerpc/platforms/pseries/pci_dlpar.c b/arch/powerpc/p=
latforms/pseries/pci_dlpar.c
>> index 3ccebc8..0b1b6b3 100644
>> --- a/arch/powerpc/platforms/pseries/pci_dlpar.c
>> +++ b/arch/powerpc/platforms/pseries/pci_dlpar.c
>> @@ -120,7 +120,6 @@ void pcibios_add_pci_devices(struct pci_bus * bus)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 num =3D pci_scan_slot(bus, PCI_DEVFN(slotno,=
 0));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!num)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> - =A0 =A0 =A0 =A0 =A0 =A0 pcibios_setup_bus_devices(bus);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 max =3D bus->busn_res.start;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (pass=3D0; pass < 2; pass++)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_for_each_entry(dev, &bu=
s->devices, bus_list) {
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 15d442a..43e0a4f 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -3789,11 +3789,6 @@ int __attribute__ ((weak)) pci_ext_cfg_avail(stru=
ct pci_dev *dev)
>> =A0 =A0 =A0 return 1;
>> =A0}
>>
>> -void __weak pci_fixup_cardbus(struct pci_bus *bus)
>> -{
>> -}
>> -EXPORT_SYMBOL(pci_fixup_cardbus);
>> -
>> =A0static int __init pci_setup(char *str)
>> =A0{
>> =A0 =A0 =A0 while (str) {
>> diff --git a/drivers/pcmcia/cardbus.c b/drivers/pcmcia/cardbus.c
>> index 24caeaf..a980691 100644
>> --- a/drivers/pcmcia/cardbus.c
>> +++ b/drivers/pcmcia/cardbus.c
>> @@ -71,7 +71,6 @@ int __ref cb_alloc(struct pcmcia_socket *s)
>> =A0 =A0 =A0 unsigned int max, pass;
>>
>> =A0 =A0 =A0 s->functions =3D pci_scan_slot(bus, PCI_DEVFN(0, 0));
>> - =A0 =A0 pci_fixup_cardbus(bus);
>>
>> =A0 =A0 =A0 max =3D bus->busn_res.start;
>> =A0 =A0 =A0 for (pass =3D 0; pass < 2; pass++)
>> @@ -85,7 +84,6 @@ int __ref cb_alloc(struct pcmcia_socket *s)
>> =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 pci_bus_size_bridges(bus);
>> =A0 =A0 =A0 pci_bus_assign_resources(bus);
>> - =A0 =A0 cardbus_config_irq_and_cls(bus, s->pci_irq);
>>
>> =A0 =A0 =A0 /* socket specific tune function */
>> =A0 =A0 =A0 if (s->tune_bridge)
>> @@ -93,6 +91,7 @@ int __ref cb_alloc(struct pcmcia_socket *s)
>>
>> =A0 =A0 =A0 pci_enable_bridges(bus);
>> =A0 =A0 =A0 pci_bus_add_devices(bus);
>> + =A0 =A0 cardbus_config_irq_and_cls(bus, s->pci_irq);
>>
>> =A0 =A0 =A0 return 0;
>> =A0}
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index a0e2d7f..3924c02 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -651,9 +651,6 @@ resource_size_t pcibios_align_resource(void *, const=
 struct resource *,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 resource_siz=
e_t);
>> =A0void pcibios_update_irq(struct pci_dev *, int irq);
>>
>> -/* Weak but can be overriden by arch */
>> -void pci_fixup_cardbus(struct pci_bus *);
>> -
>> =A0/* Generic PCI functions used internally */
>>
>> =A0void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_regi=
on *region,
>
>
