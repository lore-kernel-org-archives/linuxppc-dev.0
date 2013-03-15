Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id F2E1B2C008E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Mar 2013 06:41:16 +1100 (EST)
Message-ID: <1363376468.16793.18.camel@ul30vt.home>
Subject: Re: [PATCH 3/3] VFIO: Direct access config reg without capability
From: Alex Williamson <alex.williamson@redhat.com>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Fri, 15 Mar 2013 13:41:08 -0600
In-Reply-To: <1363332390-12754-4-git-send-email-shangw@linux.vnet.ibm.com>
References: <1363332390-12754-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1363332390-12754-4-git-send-email-shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-03-15 at 15:26 +0800, Gavin Shan wrote:
> The config registers in [0, 0x40] is being supported by VFIO. Apart
> from that, the other config registers should be coverred by PCI or
> PCIe capability. However, there might have some PCI devices (be2net)
> who has config registers (0x7c) out of [0, 0x40], and don't have
> corresponding PCI or PCIe capability. VFIO will return 0x0 on reading
> those registers and writing is dropped. It caused the be2net driver
> fails to be loaded because 0x0 returned from its config register 0x7c.
> 
> The patch changes the behaviour so that those config registers out
> of [0, 0x40] and don't have corresponding PCI or PCIe capability
> will be accessed directly.

This basically gives userspace free access to any regions that aren't
covered by known capabilities.  We have no idea what this might expose
on some devices.  I'd like to support be2net, but what's the minimal
access that it needs?  Can we provide 2 or 4 bytes of read-only access
at offset 0x7c for just that device?  Is it always 0x7c?  Let's split
this patch from the series since it's clearly dealing with something
independent.  Thanks,

Alex

> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> ---
>  drivers/vfio/pci/vfio_pci_config.c |   31 ++++++++++++++++++++-----------
>  1 files changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> index 964ff22..5ea3afb 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -1471,18 +1471,27 @@ static ssize_t vfio_config_do_rw(struct vfio_pci_device *vdev, char __user *buf,
>  
>  	cap_id = vdev->pci_config_map[*ppos / 4];
>  
> +	/*
> +	 * Some PCI device config registers might not be coverred by
> +	 * capability and useful. We will enable direct access to
> +	 * those registers.
> +	 */
>  	if (cap_id == PCI_CAP_ID_INVALID) {
> -		if (iswrite)
> -			return ret; /* drop */
> -
> -		/*
> -		 * Per PCI spec 3.0, section 6.1, reads from reserved and
> -		 * unimplemented registers return 0
> -		 */
> -		if (copy_to_user(buf, &val, count))
> -			return -EFAULT;
> -
> -		return ret;
> +		if (iswrite) {
> +			if (copy_from_user(&val, buf, count))
> +				return -EFAULT;
> +			ret = vfio_user_config_write(vdev->pdev, (int)(*ppos),
> +						     val, count);
> +			return ret ? ret : count;
> +		} else {
> +			ret = vfio_user_config_read(vdev->pdev, (int)(*ppos),
> +						    &val, count);
> +			if (ret)
> +				return ret;
> +			if (copy_to_user(buf, &val, count))
> +				return -EFAULT;
> +			return count;
> +		}
>  	}
>  
>  	/*
