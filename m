Return-Path: <B36685@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5E33D2C0093
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2012 13:45:20 +1000 (EST)
From: Liu Shengzhou-B36685 <B36685@freescale.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>
Subject: RE: [PATCH v2] PCI: use dev->irq instead of dev->pin to enable non
 MSI/INTx interrupt
Date: Thu, 26 Jul 2012 03:45:03 +0000
Message-ID: <3F453DDFF675A64A89321A1F35281021771A8B@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1342591614-1840-1-git-send-email-Shengzhou.Liu@freescale.com>
In-Reply-To: <1342591614-1840-1-git-send-email-Shengzhou.Liu@freescale.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Liu Shengzhou-B36685 <B36685@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,=20

A gentle reminder!
Any comments are appreciated.


Regards,
Shengzhou


> -----Original Message-----
> From: Liu Shengzhou-B36685
> Sent: Wednesday, July 18, 2012 2:07 PM
> To: bhelgaas@google.com; linux-pci@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org; Liu Shengzhou-B36685
> Subject: [PATCH v2] PCI: use dev->irq instead of dev->pin to enable non
> MSI/INTx interrupt
>=20
> On some platforms, root port has neither MSI/MSI-X nor INTx interrupt
> generated in RC mode. In this case, we have to use other interrupt(e.g.
> system shared interrupt) for port service irq to have AER, Hot-plug, etc,
> services to work.
>=20
> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> ---
>  drivers/pci/pcie/portdrv_core.c |   16 ++++++++++++----
>  1 files changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_c=
ore.c
> index 75915b3..49acf72 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -200,10 +200,13 @@ static int init_service_irqs(struct pci_dev *dev, i=
nt
> *irqs, int mask)  {
>  	int i, irq =3D -1;
>=20
> -	/* We have to use INTx if MSI cannot be used for PCIe PME or pciehp. */
> +	/*
> +	 * We have to use INTx or other interrupts(e.g. system shared interrupt=
)
> +	 * if MSI cannot be used for PCIe PME or pciehp.
> +	 */
>  	if (((mask & PCIE_PORT_SERVICE_PME) && pcie_pme_no_msi()) ||
>  	    ((mask & PCIE_PORT_SERVICE_HP) && pciehp_no_msi())) {
> -		if (dev->pin)
> +		if (dev->irq)
>  			irq =3D dev->irq;
>  		goto no_msi;
>  	}
> @@ -212,8 +215,13 @@ static int init_service_irqs(struct pci_dev *dev, in=
t
> *irqs, int mask)
>  	if (!pcie_port_enable_msix(dev, irqs, mask))
>  		return 0;
>=20
> -	/* We're not going to use MSI-X, so try MSI and fall back to INTx */
> -	if (!pci_enable_msi(dev) || dev->pin)
> +	/*
> +	 * We're not going to use MSI-X, so try MSI and fall back to INTx.
> +	 * If neither MSI/MSI-X nor INTx available, try other interrupt. (On
> +	 * some platforms, root port doesn't support generating MSI/MSI-X/INTx
> +	 * in RC mode)
> +	 */
> +	if (!pci_enable_msi(dev) || dev->irq)
>  		irq =3D dev->irq;
>=20
>   no_msi:
> --
> 1.6.4
