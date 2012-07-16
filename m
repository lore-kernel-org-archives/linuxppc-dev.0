Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 608E72C00B0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2012 01:47:41 +1000 (EST)
Message-ID: <50043790.6090605@freescale.com>
Date: Mon, 16 Jul 2012 10:47:28 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Subject: Re: [PATCH 1/2 v2] PCI: Add PCI_DEV_FLAGS_USE_NON_MSI_INTX_IRQ to
 enable non MSI/INTx interrupt
References: <1342409487-28256-1-git-send-email-Shengzhou.Liu@freescale.com>
In-Reply-To: <1342409487-28256-1-git-send-email-Shengzhou.Liu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/15/2012 10:31 PM, Shengzhou Liu wrote:
> On some platforms, in RC mode, root port has neither MSI/MSI-X nor INTx
> interrupt generated, which are available only in EP mode on those platform.
> In this case, we try to use other interrupt for port service driver to have
> AER, Hot-plug, etc, services to work.
> 
> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> ---
> v2: separated platform-specific part to arch/powerpc/sysdev.
> 
>  drivers/pci/pcie/portdrv_core.c |   10 ++++++++--
>  drivers/pci/quirks.c            |    9 +++++++++
>  include/linux/pci.h             |    5 +++++
>  3 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index 75915b3..837ad15 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -212,8 +212,14 @@ static int init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
>  	if (!pcie_port_enable_msix(dev, irqs, mask))
>  		return 0;
>  
> -	/* We're not going to use MSI-X, so try MSI and fall back to INTx */
> -	if (!pci_enable_msi(dev) || dev->pin)
> +	/*
> +	 * We're not going to use MSI-X, so try MSI and fall back to INTx.
> +	 * Eventually, if neither MSI/MSI-X nor INTx available, try other
> +	 * interrupt. (On some platforms, root port doesn't support generating
> +	 * MSI/MSI-X/INTx in RC mode)
> +	 */
> +	if (!pci_enable_msi(dev) || dev->pin || ((dev->dev_flags &
> +			PCI_DEV_FLAGS_USE_NON_MSI_INTX_IRQ) && dev->irq))
>  		irq = dev->irq;

I didn't see a response on the question about what would happen if we
did this unconditionally (i.e. just s/dev->pin/dev->irq/ in the original
code).  We should avoid introducing flags like this unless there's a
good reason.

Maybe submit a patch that does it unconditionally, and see if that draws
a complaint.

-Scott
