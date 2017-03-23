Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vq0jw055KzDq93
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Mar 2017 08:56:03 +1100 (AEDT)
Date: Thu, 23 Mar 2017 16:55:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alex.williamson@redhat.com,
 gwshan@linux.vnet.ibm.com, aik@ozlabs.ru, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org, zhong@linux.vnet.ibm.com
Subject: Re: [PATCH v9 3/3] PCI: Don't extend device's size when using
 default alignment for all devices
Message-ID: <20170323215558.GC23612@bhelgaas-glaptop.roam.corp.google.com>
References: <1487141106-2503-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1487141106-2503-4-git-send-email-xyjxie@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487141106-2503-4-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 15, 2017 at 02:45:06PM +0800, Yongji Xie wrote:
> Currently we reassign the alignment by extending resources' size in
> pci_reassigndev_resource_alignment(). This could potentially break
> some drivers when the driver uses the size to locate register
> whose length is related to the size. Some examples as below:

I understand the motivation to stop changing the resource size.  That
makes good sense.

> - misc\Hpilo.c:

This isn't Windows; please use regular Linux forward slashes here.

> off = pci_resource_len(pdev, bar) - 0x2000;
> 
> - net\ethernet\chelsio\cxgb4\cxgb4_uld.h:
> (pci_resource_len((pdev), 2) - roundup_pow_of_two((vres)->ocq.size))
> 
> - infiniband\hw\nes\Nes_hw.c:
> num_pds = pci_resource_len(nesdev->pcidev, BAR_1) >> PAGE_SHIFT;
> 
> This risk could be easily prevented before because we only had one way
> (kernel parameter resource_alignment) to touch those codes. And even
> some users may be happy to see the extended size.
> 
> But now we define a default alignment for all devices which would also
> touch those codes. It would be hard to prevent the risk in this case. So
> this patch tries to use START_ALIGNMENT to identify the resource's
> alignment without extending the size when the alignment reassigning is
> caused by the default alignment.

But I don't understand the new START_ALIGNMENT case.

> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
> ---
>  drivers/pci/pci.c |   34 ++++++++++++++++++++++++----------
>  1 files changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 2622e9b..0017e5e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4958,7 +4958,8 @@ void pci_ignore_hotplug(struct pci_dev *dev)
>   * RETURNS: Resource alignment if it is specified.
>   *          Zero if it is not specified.

Since there's function doc, please update it to reflect the new
"resize" return parameter.

What does "resize" mean?  I can't figure it out from your code.

>   */
> -static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
> +static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
> +							bool *resize)
>  {
>  	int seg, bus, slot, func, align_order, count;
>  	unsigned short vendor, device, subsystem_vendor, subsystem_device;
> @@ -5002,6 +5003,7 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
>  				(!device || (device == dev->device)) &&
>  				(!subsystem_vendor || (subsystem_vendor == dev->subsystem_vendor)) &&
>  				(!subsystem_device || (subsystem_device == dev->subsystem_device))) {
> +				*resize = true;
>  				if (align_order == -1)
>  					align = PAGE_SIZE;
>  				else
> @@ -5027,6 +5029,7 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
>  				bus == dev->bus->number &&
>  				slot == PCI_SLOT(dev->devfn) &&
>  				func == PCI_FUNC(dev->devfn)) {
> +				*resize = true;
>  				if (align_order == -1)
>  					align = PAGE_SIZE;
>  				else
> @@ -5059,6 +5062,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
>  	struct resource *r;
>  	resource_size_t align, size;
>  	u16 command;
> +	bool resize = false;
>  
>  	/*
>  	 * VF BARs are read-only zero according to SR-IOV spec r1.1, sec
> @@ -5070,7 +5074,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
>  		return;
>  
>  	/* check if specified PCI is target device to reassign */
> -	align = pci_specified_resource_alignment(dev);
> +	align = pci_specified_resource_alignment(dev, &resize);
>  	if (!align)
>  		return;
>  
> @@ -5098,15 +5102,25 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
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
> +			r->end = size - 1;
> +			r->start = 0;
> +		} else {
> +			if (size < align) {
> +				r->flags &= ~IORESOURCE_SIZEALIGN;
> +				r->flags |= IORESOURCE_STARTALIGN |
> +							IORESOURCE_UNSET;
> +				r->start = align;
> +				r->end = r->start + size - 1;

If you have to have two blocks that fiddle with r->start, etc., they
should at least be as similar as possible.  You should have this in
both cases:

  r->end = r->start + size - 1;

> +			}
>  		}
> -		r->flags |= IORESOURCE_UNSET;
> -		r->end = size - 1;
> -		r->start = 0;
>  	}
>  	/* Need to disable bridge's resource window,
>  	 * to enable the kernel to reassign new resource
> -- 
> 1.7.1
> 
