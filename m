Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401fn35N16zF0tq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 05:06:47 +1100 (AEDT)
Date: Wed, 14 Mar 2018 13:06:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Desnes A. Nunes do Rosario" <desnesn@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 ruscur@russell.cc, aik@ozlabs.ru, david@gibson.dropbear.id.au,
 fbarrat@linux.vnet.ibm.com, brking@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2, pci] pci: Addition of
 PCI_DEV_FLAGS_QUIET_PCI_REALIGN attribute to the PCI subsystem
Message-ID: <20180314180642.GC179719@bhelgaas-glaptop.roam.corp.google.com>
References: <20180314163455.15854-1-desnesn@linux.vnet.ibm.com>
 <20180314163455.15854-2-desnesn@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180314163455.15854-2-desnesn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 14, 2018 at 01:34:54PM -0300, Desnes A. Nunes do Rosario wrote:
> Add PCI_DEV_FLAGS_QUIET_PCI_REALIGN to pci_dev_flags and use it to
> silent PCI realignment messages if the flag is turned on by a driver.
> 
> Signed-off-by: Desnes A. Nunes do Rosario <desnesn@linux.vnet.ibm.com>
> ---
>  drivers/pci/pci.c       | 3 ++-
>  drivers/pci/setup-res.c | 3 ++-
>  include/linux/pci.h     | 2 ++
>  3 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8c71d1a66cdd..be197c944e5f 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5505,7 +5505,8 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
>  		return;
>  	}
>  
> -	pci_info(dev, "Disabling memory decoding and releasing memory resources\n");
> +	if (!(dev->dev_flags & PCI_DEV_FLAGS_QUIET_PCI_REALIGN))
> +		pci_info(dev, "Disabling memory decoding and releasing memory resources\n");
>  	pci_read_config_word(dev, PCI_COMMAND, &command);
>  	command &= ~PCI_COMMAND_MEMORY;
>  	pci_write_config_word(dev, PCI_COMMAND, command);
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index 369d48d6c6f1..00a538def763 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -172,7 +172,8 @@ EXPORT_SYMBOL(pci_claim_resource);
>  
>  void pci_disable_bridge_window(struct pci_dev *dev)
>  {
> -	pci_info(dev, "disabling bridge mem windows\n");
> +	if (!(dev->dev_flags & PCI_DEV_FLAGS_QUIET_PCI_REALIGN))
> +		pci_info(dev, "disabling bridge mem windows\n");

As far as I'm concerned, we can just remove these messages completely.
I don't think there's any real value there.

>  	/* MMIO Base/Limit */
>  	pci_write_config_dword(dev, PCI_MEMORY_BASE, 0x0000fff0);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index e057e8cc63e7..993f9c7dcc00 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -205,6 +205,8 @@ enum pci_dev_flags {
>  	PCI_DEV_FLAGS_NO_FLR_RESET = (__force pci_dev_flags_t) (1 << 10),
>  	/* Don't use Relaxed Ordering for TLPs directed at this device */
>  	PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
> +	/* Silent PCI resource realignment messages */
> +	PCI_DEV_FLAGS_QUIET_PCI_REALIGN = (__force pci_dev_flags_t) (1 << 12),
>  };
>  
>  enum pci_irq_reroute_variant {
> -- 
> 2.14.3
> 
