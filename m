Return-Path: <bhelgaas@google.com>
Received: from mail-wm0-x232.google.com (mail-wm0-x232.google.com
 [IPv6:2a00:1450:400c:c09::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6Kjl1DDVzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 06:34:03 +1000 (AEST)
Received: by mail-wm0-x232.google.com with SMTP id r190so6970211wme.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 13:34:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAONzpcbKzLCgmX0Y6A0B2W_QvG=UTR9GB5VyAWXaq2ZLwJXgcA@mail.gmail.com>
References: <1491825494-19331-1-git-send-email-elohimes@gmail.com>
 <1491825494-19331-5-git-send-email-elohimes@gmail.com>
 <20170414225452.GC5864@bhelgaas-glaptop.roam.corp.google.com>
 <CAONzpcbKzLCgmX0Y6A0B2W_QvG=UTR9GB5VyAWXaq2ZLwJXgcA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 17 Apr 2017 15:33:36 -0500
Message-ID: <CAErSpo79PBMmF-=TDbmfiUzHsV=9mqTaePYHq4wNJ9yRapewjQ@mail.gmail.com>
Subject: Re: [PATCH v10 4/4] PCI: Don't extend device's size when using
 default alignment for all devices
To: Yongji Xie <elohimes@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, "paulus@samba.org" <paulus@samba.org>,
 Li Zhong <zhong@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 17, 2017 at 1:27 AM, Yongji Xie <elohimes@gmail.com> wrote:
> 2017-04-15 6:54 GMT+08:00 Bjorn Helgaas <helgaas@kernel.org>:
>>
>> On Mon, Apr 10, 2017 at 07:58:14PM +0800, Yongji Xie wrote:
>> > Currently we reassign the alignment by extending resources' size in
>> > pci_reassigndev_resource_alignment(). This could potentially break
>> > some drivers when the driver uses the size to locate register
>> > whose length is related to the size. Some examples as below:
>> >
>> > - misc/Hpilo.c:
>>
>> If you're going to quote filenames, they need to match the actual
>> files in the tree.  In this case, "hpilo.c", not "Hpilo.c".  Also
>> "Nes_hw.c" below is incorrect.
>>
>
> Will fix it.
>
>>
>> > off = pci_resource_len(pdev, bar) - 0x2000;
>> >
>> > - net/ethernet/chelsio/cxgb4/cxgb4_uld.h:
>> > (pci_resource_len((pdev), 2) - roundup_pow_of_two((vres)->ocq.size))
>> >
>> > - infiniband/hw/nes/Nes_hw.c:
>> > num_pds = pci_resource_len(nesdev->pcidev, BAR_1) >> PAGE_SHIFT;
>>
>> This BAR is apparently at least a page in size already, so this only
>> breaks if we request alignment of more than a page size.
>>
>
> Oh, yes. I'll remove this one.
>
>> > This risk could be easily prevented before because we only had one way
>> > (kernel parameter resource_alignment) to touch those codes. And even
>> > some users may be happy to see the extended size.
>>
>> Currently, pci_reassigndev_resource_alignment() extends the size of
>> some resources when we use "pci=resource_alignment=..."  That
>> certainly breaks places like the ones above.
>>
>> What do you mean by "some users may be happy to see the extended
>> size"?  We're increasing a resource size to something larger than what
>> the BAR actually responds to.  I don't see how that can ever be an
>> *improvement*.  I can see how most drivers won't care, and a few (like
>> the ones you cite above) will break.  But I don't see how any driver
>> could be *helped* by us making the resource larger.
>>
>
> From commit 32a9a68 (PCI: allow assignment of memory resources with a
> specified alignment), it seems that "pci=resource_alignment" was introduced
> because we want to use PCI pass-through for some page-unaligned devices.
>
> So there might be some cases that users use "pci=resource_alignment" to
> extend the BAR's size then passthrough them. That's why I say "some users
> may be happy to see the extended size". We are not able to passthrough
> the device unless we extend its BARs to PAGE_SIZE.
>
>>
>> > But now we introduce pcibios_default_alignment() to set default
>> > alignment
>> > for all PCI devices which would also touch those codes. It would be hard
>> > to prevent the risk in this case. So this patch tries to use
>> > START_ALIGNMENT to identify the resource's alignment without extending
>> > the size when the alignment reassigning is caused by the default
>> > alignment.
>> >
>> > Signed-off-by: Yongji Xie <elohimes@gmail.com>
>> > ---
>> >  drivers/pci/pci.c |   34 ++++++++++++++++++++++++----------
>> >  1 file changed, 24 insertions(+), 10 deletions(-)
>> >
>> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> > index 02f1255..358366e 100644
>> > --- a/drivers/pci/pci.c
>> > +++ b/drivers/pci/pci.c
>> > @@ -4959,11 +4959,13 @@ resource_size_t __weak
>> > pcibios_default_alignment(struct pci_dev *dev)
>> >  /**
>> >   * pci_specified_resource_alignment - get resource alignment specified
>> > by user.
>> >   * @dev: the PCI device to get
>> > + * @resize: whether or not to change resources' size when reassigning
>> > alignment
>> >   *
>> >   * RETURNS: Resource alignment if it is specified.
>> >   *          Zero if it is not specified.
>> >   */
>> > -static resource_size_t pci_specified_resource_alignment(struct pci_dev
>> > *dev)
>> > +static resource_size_t pci_specified_resource_alignment(struct pci_dev
>> > *dev,
>> > +                                                     bool *resize)
>> >  {
>> >       int seg, bus, slot, func, align_order, count;
>> >       unsigned short vendor, device, subsystem_vendor, subsystem_device;
>> > @@ -5005,6 +5007,7 @@ static resource_size_t
>> > pci_specified_resource_alignment(struct pci_dev *dev)
>> >                               (!device || (device == dev->device)) &&
>> >                               (!subsystem_vendor || (subsystem_vendor ==
>> > dev->subsystem_vendor)) &&
>> >                               (!subsystem_device || (subsystem_device ==
>> > dev->subsystem_device))) {
>> > +                             *resize = true;
>> >                               if (align_order == -1)
>> >                                       align = PAGE_SIZE;
>> >                               else
>> > @@ -5030,6 +5033,7 @@ static resource_size_t
>> > pci_specified_resource_alignment(struct pci_dev *dev)
>> >                               bus == dev->bus->number &&
>> >                               slot == PCI_SLOT(dev->devfn) &&
>> >                               func == PCI_FUNC(dev->devfn)) {
>> > +                             *resize = true;
>> >                               if (align_order == -1)
>> >                                       align = PAGE_SIZE;
>> >                               else
>> > @@ -5062,6 +5066,7 @@ void pci_reassigndev_resource_alignment(struct
>> > pci_dev *dev)
>> >       struct resource *r;
>> >       resource_size_t align, size;
>> >       u16 command;
>> > +     bool resize = false;
>> >
>> >       /*
>> >        * VF BARs are read-only zero according to SR-IOV spec r1.1, sec
>> > @@ -5073,7 +5078,7 @@ void pci_reassigndev_resource_alignment(struct
>> > pci_dev *dev)
>> >               return;
>> >
>> >       /* check if specified PCI is target device to reassign */
>> > -     align = pci_specified_resource_alignment(dev);
>> > +     align = pci_specified_resource_alignment(dev, &resize);
>> >       if (!align)
>> >               return;
>> >
>> > @@ -5101,15 +5106,24 @@ void pci_reassigndev_resource_alignment(struct
>> > pci_dev *dev)
>> >               }
>> >
>> >               size = resource_size(r);
>> > -             if (size < align) {
>> > -                     size = align;
>> > -                     dev_info(&dev->dev,
>> > -                             "Rounding up size of resource #%d to
>> > %#llx.\n",
>> > -                             i, (unsigned long long)size);
>> > +             if (resize) {
>> > +                     if (size < align) {
>> > +                             size = align;
>> > +                             dev_info(&dev->dev,
>> > +                                     "Rounding up size of resource #%d
>> > to %#llx.\n",
>> > +                                     i, (unsigned long long)size);
>> > +                     }
>> > +                     r->flags |= IORESOURCE_UNSET;
>> > +                     r->start = 0;
>> > +             } else {
>> > +                     if (size < align) {
>> > +                             r->flags &= ~IORESOURCE_SIZEALIGN;
>> > +                             r->flags |= IORESOURCE_STARTALIGN |
>> > +                                                     IORESOURCE_UNSET;
>> > +                             r->start = align;
>> > +                     }
>>
>> I'm still not happy about the fact that we now have these two cases:
>>
>>   1) If we increase resource alignment because of the
>>      "pci=resource_alignment=" parameter, we increase the resource
>>      size, and
>>
>>   2) If we increase resource alignment because of
>>      pcibios_default_alignment(), we use IORESOURCE_STARTALIGN and do
>>      not increase the resource size.
>>
>> This makes the code complicated and hard to maintain in the future.
>> We talked about this earlier [1], but I'm not sure I've figured out
>> the reason.  Here's my guess:
>>
>> Let's assume we have a 4K BAR and we're requesting alignment to 64K.
>> In case 1, we're only changing the alignment for specified devices.
>> If we used IORESOURCE_STARTALIGN, we would align that 4K BAR of the
>> specified devices to 64K, but BARs of other devices could still be
>> assigned in that same 64K page.  Therefore, we must increase the size
>> to prevent other BARs in the page, even though this might break some
>> drivers.
>>
>> But in case 2, we're changing the alignment for *all* devices.  In
>> this case, we *can* use IORESOURCE_STARTALIGN because we're going to
>> align *every* BAR of every device to 64K, so no other BARs will be put
>> in the same page.  And since we didn't change the resource size, we
>> avoid the problem of breaking drivers.
>>
>> If that's the reasoning, I'm not 100% sure that the complexity of this
>> code is worth it.  It took me half a day to come up with this theory.
>> If we do have to go this route, we *must* include comments along this
>> line to make it easier next time.
>>
>
> Your guess is exactly correct. We have two problems when we need to change
> one BAR's alignment:
>
> 1) If we extend the BAR's size, we may break the driver
>
> 2) If we only change the alignment without extending size, we have no way to
> prevent other BARs being assigned into the same page.
>
> I failed to come up with a way to use only one way to satisfy the two cases.
> So I handle the two cases separately like those codes. But as you said, this
> makes the code hard to maintain. I think what I can do next is to add some
> comments to make the codes easier to read and maintain. Of course, if
> anybody have a better idea, I'll be happy to see it.

I don't see a better way either.  Let me try to add some comments.
I'll post a patch and you can see what you think.

Bjorn
