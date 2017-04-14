Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w4Xzl5hgmzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Apr 2017 08:54:59 +1000 (AEST)
Date: Fri, 14 Apr 2017 17:54:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yongji Xie <elohimes@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alex.williamson@redhat.com,
 gwshan@linux.vnet.ibm.com, aik@ozlabs.ru, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org, zhong@linux.vnet.ibm.com
Subject: Re: [PATCH v10 4/4] PCI: Don't extend device's size when using
 default alignment for all devices
Message-ID: <20170414225452.GC5864@bhelgaas-glaptop.roam.corp.google.com>
References: <1491825494-19331-1-git-send-email-elohimes@gmail.com>
 <1491825494-19331-5-git-send-email-elohimes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491825494-19331-5-git-send-email-elohimes@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 10, 2017 at 07:58:14PM +0800, Yongji Xie wrote:
> Currently we reassign the alignment by extending resources' size in
> pci_reassigndev_resource_alignment(). This could potentially break
> some drivers when the driver uses the size to locate register
> whose length is related to the size. Some examples as below:
> 
> - misc/Hpilo.c:

If you're going to quote filenames, they need to match the actual
files in the tree.  In this case, "hpilo.c", not "Hpilo.c".  Also
"Nes_hw.c" below is incorrect.

> off = pci_resource_len(pdev, bar) - 0x2000;
> 
> - net/ethernet/chelsio/cxgb4/cxgb4_uld.h:
> (pci_resource_len((pdev), 2) - roundup_pow_of_two((vres)->ocq.size))
> 
> - infiniband/hw/nes/Nes_hw.c:
> num_pds = pci_resource_len(nesdev->pcidev, BAR_1) >> PAGE_SHIFT;

This BAR is apparently at least a page in size already, so this only
breaks if we request alignment of more than a page size.

> This risk could be easily prevented before because we only had one way
> (kernel parameter resource_alignment) to touch those codes. And even
> some users may be happy to see the extended size.

Currently, pci_reassigndev_resource_alignment() extends the size of
some resources when we use "pci=resource_alignment=..."  That
certainly breaks places like the ones above.

What do you mean by "some users may be happy to see the extended
size"?  We're increasing a resource size to something larger than what
the BAR actually responds to.  I don't see how that can ever be an
*improvement*.  I can see how most drivers won't care, and a few (like
the ones you cite above) will break.  But I don't see how any driver
could be *helped* by us making the resource larger.

> But now we introduce pcibios_default_alignment() to set default alignment
> for all PCI devices which would also touch those codes. It would be hard
> to prevent the risk in this case. So this patch tries to use
> START_ALIGNMENT to identify the resource's alignment without extending
> the size when the alignment reassigning is caused by the default alignment.
> 
> Signed-off-by: Yongji Xie <elohimes@gmail.com>
> ---
>  drivers/pci/pci.c |   34 ++++++++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 02f1255..358366e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4959,11 +4959,13 @@ resource_size_t __weak pcibios_default_alignment(struct pci_dev *dev)
>  /**
>   * pci_specified_resource_alignment - get resource alignment specified by user.
>   * @dev: the PCI device to get
> + * @resize: whether or not to change resources' size when reassigning alignment
>   *
>   * RETURNS: Resource alignment if it is specified.
>   *          Zero if it is not specified.
>   */
> -static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
> +static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
> +							bool *resize)
>  {
>  	int seg, bus, slot, func, align_order, count;
>  	unsigned short vendor, device, subsystem_vendor, subsystem_device;
> @@ -5005,6 +5007,7 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
>  				(!device || (device == dev->device)) &&
>  				(!subsystem_vendor || (subsystem_vendor == dev->subsystem_vendor)) &&
>  				(!subsystem_device || (subsystem_device == dev->subsystem_device))) {
> +				*resize = true;
>  				if (align_order == -1)
>  					align = PAGE_SIZE;
>  				else
> @@ -5030,6 +5033,7 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
>  				bus == dev->bus->number &&
>  				slot == PCI_SLOT(dev->devfn) &&
>  				func == PCI_FUNC(dev->devfn)) {
> +				*resize = true;
>  				if (align_order == -1)
>  					align = PAGE_SIZE;
>  				else
> @@ -5062,6 +5066,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
>  	struct resource *r;
>  	resource_size_t align, size;
>  	u16 command;
> +	bool resize = false;
>  
>  	/*
>  	 * VF BARs are read-only zero according to SR-IOV spec r1.1, sec
> @@ -5073,7 +5078,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
>  		return;
>  
>  	/* check if specified PCI is target device to reassign */
> -	align = pci_specified_resource_alignment(dev);
> +	align = pci_specified_resource_alignment(dev, &resize);
>  	if (!align)
>  		return;
>  
> @@ -5101,15 +5106,24 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
>  		}
>  
>  		size = resource_size(r);
> -		if (size < align) {
> -			size = align;
> -			dev_info(&dev->dev,
> -				"Rounding up size of resource #%d to %#llx.\n",
> -				i, (unsigned long long)size);
> +		if (resize) {
> +			if (size < align) {
> +				size = align;
> +				dev_info(&dev->dev,
> +					"Rounding up size of resource #%d to %#llx.\n",
> +					i, (unsigned long long)size);
> +			}
> +			r->flags |= IORESOURCE_UNSET;
> +			r->start = 0;
> +		} else {
> +			if (size < align) {
> +				r->flags &= ~IORESOURCE_SIZEALIGN;
> +				r->flags |= IORESOURCE_STARTALIGN |
> +							IORESOURCE_UNSET;
> +				r->start = align;
> +			}

I'm still not happy about the fact that we now have these two cases:

  1) If we increase resource alignment because of the
     "pci=resource_alignment=" parameter, we increase the resource
     size, and

  2) If we increase resource alignment because of
     pcibios_default_alignment(), we use IORESOURCE_STARTALIGN and do
     not increase the resource size.

This makes the code complicated and hard to maintain in the future.
We talked about this earlier [1], but I'm not sure I've figured out
the reason.  Here's my guess:

Let's assume we have a 4K BAR and we're requesting alignment to 64K.
In case 1, we're only changing the alignment for specified devices.
If we used IORESOURCE_STARTALIGN, we would align that 4K BAR of the
specified devices to 64K, but BARs of other devices could still be
assigned in that same 64K page.  Therefore, we must increase the size
to prevent other BARs in the page, even though this might break some
drivers.

But in case 2, we're changing the alignment for *all* devices.  In
this case, we *can* use IORESOURCE_STARTALIGN because we're going to
align *every* BAR of every device to 64K, so no other BARs will be put
in the same page.  And since we didn't change the resource size, we
avoid the problem of breaking drivers.

If that's the reasoning, I'm not 100% sure that the complexity of this
code is worth it.  It took me half a day to come up with this theory.
If we do have to go this route, we *must* include comments along this
line to make it easier next time.

[1] https://lkml.kernel.org/r/20160929115422.GA31048@localhost

>  		}
> -		r->flags |= IORESOURCE_UNSET;
> -		r->end = size - 1;
> -		r->start = 0;
> +		r->end = r->start + size - 1;
>  	}
>  	/* Need to disable bridge's resource window,
>  	 * to enable the kernel to reassign new resource
> -- 
> 1.7.9.5
> 
