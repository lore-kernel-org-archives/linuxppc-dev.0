Return-Path: <B33228@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1outboundpool.messaging.microsoft.com [216.32.181.185])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 45515B6F41
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 28 Apr 2011 18:14:27 +1000 (EST)
Subject: Re: [PATCH] PCI: portdrv: fix irq initialization on FSL pcie host
	controller
From: Xu Lei <B33228@freescale.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <1303458219-31915-1-git-send-email-B33228@freescale.com>
References: <1303458219-31915-1-git-send-email-B33228@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 28 Apr 2011 16:01:11 +0800
Message-ID: <1303977671.1642.742.camel@xulei-desktop>
MIME-Version: 1.0
Cc: linux-pci@vger.kernel.org, kumar.gala@freescale.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


	Any feedback on this patch? Thanks.

On Friday, 2011-04-22 at 15:43 +0800, Lei Xu wrote:
> Root complex ports for Freescale PCIe host controller only receive
> interrupts, so if there is no irq setting for RC, it should not return
> error, otherwise it may result the PCIe host controller is disabled.
> 
> Signed-off-by: Lei Xu <B33228@freescale.com>
> ---
>  drivers/pci/pcie/portdrv_core.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index 595654a..95e64c8 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -209,7 +209,10 @@ static int init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
>  		irqs[i] = irq;
>  	irqs[PCIE_PORT_SERVICE_VC_SHIFT] = -1;
>  
> -	if (irq < 0)
> +	/* Root complex ports for Freescale PCIe host controller only
> +	 * receive interrupts, so if there is no irq setting for RC,
> +	 * it should not return error. */
> +	if ((irq < 0) && (dev->pcie_type != PCI_EXP_TYPE_ROOT_PORT))
>  		return -ENODEV;
>  	return 0;
>  }

-- 
Regards

Lei
