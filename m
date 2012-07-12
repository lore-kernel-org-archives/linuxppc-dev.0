Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B0C192C020E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2012 22:16:45 +1000 (EST)
Subject: Re: [PATCH][upstream] PCI: Add PCI_DEV_FLAGS_USE_NON_MSI_INTX_IRQ to
 enable non MSI/INTx interrupt
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1342087342-14748-1-git-send-email-Shengzhou.Liu@freescale.com>
Date: Thu, 12 Jul 2012 07:16:36 -0500
Message-Id: <8EB7D5C0-617F-4DDC-AFE1-8E1AF6430417@kernel.crashing.org>
References: <1342087342-14748-1-git-send-email-Shengzhou.Liu@freescale.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
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


On Jul 12, 2012, at 5:02 AM, Shengzhou Liu wrote:

> On some platforms, in RC mode, root port has neither MSI/MSI-X nor =
INTx
> interrupt generated, which are available only in EP mode on those =
platform.
> In this case, we try to use other interrupt for port service driver to =
have
> AER, Hot-plug, etc, services to work. (i.e. there is the shared error =
interrupt
> on platform P1010/P3041/P4080 etc)
>=20
> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> ---
> drivers/pci/pcie/portdrv_core.c |   10 ++++++++--
> drivers/pci/quirks.c            |   12 ++++++++++++
> include/linux/pci.h             |    5 +++++
> 3 files changed, 25 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/pcie/portdrv_core.c =
b/drivers/pci/pcie/portdrv_core.c
> index 75915b3..837ad15 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -212,8 +212,14 @@ static int init_service_irqs(struct pci_dev *dev, =
int *irqs, int mask)
> 	if (!pcie_port_enable_msix(dev, irqs, mask))
> 		return 0;
>=20
> -	/* We're not going to use MSI-X, so try MSI and fall back to =
INTx */
> -	if (!pci_enable_msi(dev) || dev->pin)
> +	/*
> +	 * We're not going to use MSI-X, so try MSI and fall back to =
INTx.
> +	 * Eventually, if neither MSI/MSI-X nor INTx available, try =
other
> +	 * interrupt. (On some platforms, root port doesn't support =
generating
> +	 * MSI/MSI-X/INTx in RC mode)
> +	 */
> +	if (!pci_enable_msi(dev) || dev->pin || ((dev->dev_flags &
> +			PCI_DEV_FLAGS_USE_NON_MSI_INTX_IRQ) && =
dev->irq))
> 		irq =3D dev->irq;
>=20
>  no_msi:
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 2a75216..df54e2f 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2640,6 +2640,18 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, =
0x1083,
> 			quirk_msi_intx_disable_bug);
> #endif /* CONFIG_PCI_MSI */
>=20
> +/*
> + * Under some circumstances, root port has neither MSI/MSI-X nor INTx =
generated,
> + * so try other interrupt if supported.
> + */
> +static void __devinit quirk_enable_non_msi_intx_interrupt(struct =
pci_dev *dev)
> +{
> +	dev->dev_flags |=3D PCI_DEV_FLAGS_USE_NON_MSI_INTX_IRQ;
> +}
> +
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID,
> +				quirk_enable_non_msi_intx_interrupt);
> +

This should be in arch/powerpc not here.  One reason is FSL has other =
PCIe implementations than exists on PPC that have this issue.  (ie the =
i.MXs support PCIe).

I'd put the addition of the quirk in a second patch as well.


> /* Allow manual resource allocation for PCI hotplug bridges
>  * via pci=3Dhpmemsize=3DnnM and pci=3Dhpiosize=3DnnM parameters. For
>  * some PCI-PCI hotplug bridges, like PLX 6254 (former HINT HB6),
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d8c379d..f051a66 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -176,6 +176,11 @@ enum pci_dev_flags {
> 	PCI_DEV_FLAGS_NO_D3 =3D (__force pci_dev_flags_t) 2,
> 	/* Provide indication device is assigned by a Virtual Machine =
Manager */
> 	PCI_DEV_FLAGS_ASSIGNED =3D (__force pci_dev_flags_t) 4,
> +	/*
> +	 * Use other interrupt (i.e. system shared interrupt) when =
MSI/MSI-X
> +	 * and INTx are not supported in RC mode on some platforms.
> +	 */
> +	PCI_DEV_FLAGS_USE_NON_MSI_INTX_IRQ =3D (__force pci_dev_flags_t) =
8,
> };
>=20
> enum pci_irq_reroute_variant {
> --=20
> 1.6.4
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
