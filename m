Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rDp4r3SZ2zDqKW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 07:11:55 +1000 (AEST)
Date: Tue, 24 May 2016 16:11:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 iommu@lists.linux-foundation.org, alex.williamson@redhat.com,
 bhelgaas@google.com, aik@ozlabs.ru, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, joro@8bytes.org,
 warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, eric.auger@linaro.org,
 will.deacon@arm.com, gwshan@linux.vnet.ibm.com,
 David.Laight@ACULAB.COM, alistair@popple.id.au, ruscur@russell.cc
Subject: Re: [PATCH 2/5] iommu: Set PCI_BUS_FLAGS_MSI_REMAP if IOMMU have
 capability of IRQ remapping
Message-ID: <20160524211149.GC16463@localhost>
References: <1461761010-5452-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1461761010-5452-3-git-send-email-xyjxie@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461761010-5452-3-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 27, 2016 at 08:43:27PM +0800, Yongji Xie wrote:
> The capability of IRQ remapping is abstracted on IOMMU side on
> some archs. There is a existing flag IOMMU_CAP_INTR_REMAP for this.
> 
> To have a universal flag to test this capability for different
> archs on PCI side, we set PCI_BUS_FLAGS_MSI_REMAP for PCI buses
> when IOMMU_CAP_INTR_REMAP is set.
> 
> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
> ---
>  drivers/iommu/iommu.c |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 0e3b009..5d2b6f6 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -813,6 +813,16 @@ struct iommu_group *pci_device_group(struct device *dev)
>  	return group;
>  }
>  
> +static void pci_check_msi_remapping(struct pci_dev *pdev,
> +					const struct iommu_ops *ops)
> +{
> +	struct pci_bus *bus = pdev->bus;
> +
> +	if (ops->capable(IOMMU_CAP_INTR_REMAP) &&
> +		!(bus->bus_flags & PCI_BUS_FLAGS_MSI_REMAP))
> +		bus->bus_flags |= PCI_BUS_FLAGS_MSI_REMAP;
> +}

This looks an awful lot like the pci_bus_check_msi_remapping() you add
elsewhere.  Why do we need both?

>  /**
>   * iommu_group_get_for_dev - Find or create the IOMMU group for a device
>   * @dev: target device
> @@ -871,6 +881,9 @@ static int add_iommu_group(struct device *dev, void *data)
>  	const struct iommu_ops *ops = cb->ops;
>  	int ret;
>  
> +	if (dev_is_pci(dev) && ops->capable)
> +		pci_check_msi_remapping(to_pci_dev(dev), ops);
> +
>  	if (!ops->add_device)
>  		return 0;
>  
> @@ -913,6 +926,8 @@ static int iommu_bus_notifier(struct notifier_block *nb,
>  	 * result in ADD/DEL notifiers to group->notifier
>  	 */
>  	if (action == BUS_NOTIFY_ADD_DEVICE) {
> +		if (dev_is_pci(dev) && ops->capable)
> +			pci_check_msi_remapping(to_pci_dev(dev), ops);

These calls don't smell right either.  Why do we need dev_is_pci()
checks here?  Can't this be done in the PCI probe path somehow, e.g.,
in pci_set_bus_msi_domain() or something?

>  		if (ops->add_device)
>  			return ops->add_device(dev);
>  	} else if (action == BUS_NOTIFY_REMOVED_DEVICE) {
> -- 
> 1.7.9.5
> 
