Return-Path: <bhelgaas@google.com>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
 [209.85.215.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AB628B6FBB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2012 04:35:50 +1000 (EST)
Received: by lagw12 with SMTP id w12so5448236lag.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2012 11:35:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4FBD23BD.6050703@linux.vnet.ibm.com>
References: <4FBC4C92.7080902@jp.fujitsu.com>
 <4FBD23BD.6050703@linux.vnet.ibm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 23 May 2012 12:35:26 -0600
Message-ID: <CAErSpo5G1gFXdQwyjm1uhL41G7gLijbVd6gGkz_k8=XsWdcPNw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] powerpc/PCI: Add pcibios_device_change_notifier
 for powerpc
To: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-pci@vger.kernel.org, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
 linuxppc-dev@lists.ozlabs.org, jbarnes@virtuousgeek.org,
 Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 23, 2012 at 11:51 AM, Jesse Larrew
<jlarrew@linux.vnet.ibm.com> wrote:
> On 05/22/2012 09:33 PM, Hiroo Matsumoto wrote:
>
>> +static int pcibios_device_change_notifier(struct notifier_block *nb,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 unsigned long action, void *data)
>> +{
>> + =A0 =A0 struct pci_dev *dev =3D to_pci_dev(data);
>> +
>
>
>
> In the general case, we don't know what *data contains until we evaluate
> 'action'. This conversion should probably be moved inside the case:
> statement.

We registered it with  "bus_register_notifier(&pci_bus_type, ...)" and
every user of the bus_notifier change passes a "struct device *", so I
think we do know that we have a PCI device.

A future bus_notifier user *could* pass something other than a "struct
device *", but the pattern Hiroo used here ("struct pci_dev *dev =3D
to_pci_dev(data);" before looking at "action") seems pretty common, so
I don't think it's likely.

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
>> + =A0 =A0 .notifier_call =3D pcibios_device_change_notifier,
>> +};
>
>
>
> This is just a nit pick, but I think the naming of
> pcibios_device_change_notifier() is a bit misleading. It doesn't
> actually notify anything, but instead it *handles* notifications.
> Perhaps a better name would be pcibios_device_change_handler() or
> pcibios_device_change_callback()?

Good point.  "_notify()" seems to be a common name, how about
pci_bus_notify()?  It's static to the file, so it doesn't have to be
very unique.

I happened to be merging these patches just now, so I'll make this
change provisionally, pending any more discussion.

Thanks a lot for reviewing this!

Bjorn
