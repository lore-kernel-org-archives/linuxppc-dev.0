Return-Path: <bhelgaas@google.com>
Received: from mail-ig0-x230.google.com (mail-ig0-x230.google.com
 [IPv6:2607:f8b0:4001:c05::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 72B9C1A0257
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 08:20:31 +1000 (EST)
Received: by mail-ig0-f176.google.com with SMTP id hn18so4885028igb.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 15:20:27 -0700 (PDT)
Date: Wed, 16 Jul 2014 16:20:24 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH 2/2] PCI/MSI: Remove arch_msi_check_device()
Message-ID: <20140716222024.GE14366@google.com>
References: <cover.1405160163.git.agordeev@redhat.com>
 <1005232855c3af2c0c669818ee63be445389b6ad.1405160163.git.agordeev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1005232855c3af2c0c669818ee63be445389b6ad.1405160163.git.agordeev@redhat.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jul 12, 2014 at 01:21:08PM +0200, Alexander Gordeev wrote:
> There are no archs that override arch_msi_check_device()
> hook. Remove it as it is completely redundant.
> 
> If an arch would need to check MSI/MSI-X possibility for a
> device it should make it within arch_setup_msi_irqs() hook.
> 
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> ---
>  drivers/pci/msi.c   |   49 +++++++++++++------------------------------------
>  include/linux/msi.h |    3 ---
>  2 files changed, 13 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 13f3d30..19ac058 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -56,16 +56,6 @@ void __weak arch_teardown_msi_irq(unsigned int irq)
>  	chip->teardown_irq(chip, irq);
>  }
>  
> -int __weak arch_msi_check_device(struct pci_dev *dev, int nvec, int type)
> -{
> -	struct msi_chip *chip = dev->bus->msi;
> -
> -	if (!chip || !chip->check_device)
> -		return 0;
> -
> -	return chip->check_device(chip, dev, nvec, type);
> -}
> -
>  int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>  {
>  	struct msi_desc *entry;
> @@ -809,22 +799,23 @@ out_free:
>  }
>  
>  /**
> - * pci_msi_check_device - check whether MSI may be enabled on a device
> + * msi_check_device - check whether MSI may be enabled on a device
>   * @dev: pointer to the pci_dev data structure of MSI device function
>   * @nvec: how many MSIs have been requested ?
> - * @type: are we checking for MSI or MSI-X ?
>   *
>   * Look at global flags, the device itself, and its parent buses
>   * to determine if MSI/-X are supported for the device. If MSI/-X is
>   * supported return 0, else return an error code.
>   **/
> -static int pci_msi_check_device(struct pci_dev *dev, int nvec, int type)
> +static int msi_check_device(struct pci_dev *dev, int nvec)

I think "check_device" is a terrible name because it really doesn't
give a clue about what it's doing or what the return value means.
Since you're removing the external usage (arch_msi_check_device) and
this one is static, this would be a good time to fix it.  Maybe
"pci_msi_supported()" or something?

I *love* the idea of getting rid of this much code!

Bjorn
