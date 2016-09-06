Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sTCSC706TzDsGT
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Sep 2016 02:56:58 +1000 (AEST)
Date: Tue, 6 Sep 2016 11:56:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alex.williamson@redhat.com,
 paulus@samba.org, aik@ozlabs.ru, gwshan@linux.vnet.ibm.com,
 benh@kernel.crashing.org, mpe@ellerman.id.au, zhong@linux.vnet.ibm.com
Subject: Re: [PATCH v4 3/5] PCI: Do not disable memory decoding in
 pci_reassigndev_resource_alignment()
Message-ID: <20160906165652.GE1214@localhost>
References: <1470980546-2918-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1470980546-2918-4-git-send-email-xyjxie@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1470980546-2918-4-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 12, 2016 at 01:42:24PM +0800, Yongji Xie wrote:
> We should not disable memory decoding when we reassign alignment
> in pci_reassigndev_resource_alignment(). It's meaningless and
> have some side effects. For example, we found it would break
> this kind of P2P bridge:
> 
> 0001:02:02.0 PCI bridge: PLX Technology, Inc. PEX 8718 16-Lane,
> 5-Port PCI Express Gen 3 (8.0 GT/s) Switch (rev aa)

I doubt that turning memory decode off breaks this bridge.  I can
believe that it could cause a problem, but I doubt it would be
specific to this bridge.

I also don't think it's meaningless.  After your patch, we throw away
our knowledge of what the BAR contains when we set "r->start = 0".
But if you leave memory decoding enabled, the device will still
respond at whatever address the BAR contains.  That seems like a
problem.

> And it may also potentially break the PCI devices with mmio_always_on
> bit set.
> 
> Besides, disabling memory decoding is not expected in some fixup
> function such as fixup_vga(). The fixup_vga() read PCI_COMMAND_MEMORY
> to know whether the devices has been initialized by the firmware or
> not. Disabling memory decoding would cause the one initialized by
> firmware may not be set as the default VGA device when more than one
> graphics adapter is present.
> 
> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
> ---
>  drivers/pci/pci.c |    8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b8357d7..caa0894 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5046,7 +5046,6 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
>  	int i;
>  	struct resource *r;
>  	resource_size_t align, size;
> -	u16 command;
>  
>  	/*
>  	 * VF BARs are RO zero according to SR-IOV spec 3.4.1.11. Their
> @@ -5069,12 +5068,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
>  		return;
>  	}
>  
> -	dev_info(&dev->dev,
> -		"Disabling memory decoding and releasing memory resources.\n");
> -	pci_read_config_word(dev, PCI_COMMAND, &command);
> -	command &= ~PCI_COMMAND_MEMORY;
> -	pci_write_config_word(dev, PCI_COMMAND, command);
> -
> +	dev_info(&dev->dev, "Releasing memory resources.\n");
>  	for (i = 0; i < PCI_BRIDGE_RESOURCES; i++) {
>  		r = &dev->resource[i];
>  		if (!(r->flags & IORESOURCE_MEM))
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
