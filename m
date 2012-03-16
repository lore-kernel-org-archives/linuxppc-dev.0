Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 155A5B6ED0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 06:20:16 +1100 (EST)
Subject: Re: [PATCH SDK1.2 3/3] powerpc/fsl-pci: Add pci inbound/outbound PM
 support
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1324451458-4644-4-git-send-email-B38951@freescale.com>
Date: Fri, 16 Mar 2012 14:20:13 -0500
Message-Id: <D5034210-5D2D-4A70-A424-4AB219D6CC4D@kernel.crashing.org>
References: <1324451458-4644-1-git-send-email-B38951@freescale.com>
 <1324451458-4644-4-git-send-email-B38951@freescale.com>
To: Jia Hongtao <B38951@freescale.com>
Cc: B11780@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 21, 2011, at 1:10 AM, Jia Hongtao wrote:

> Power supply for PCI inbound/outbound window registers is off when =
system
> go to deep-sleep state. We save the values of registers before suspend
> and restore to registers after resume.
>=20
> Signed-off-by: Jiang Yutang <b14898@freescale.com>
> Signed-off-by: Jia Hongtao <B38951@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> arch/powerpc/include/asm/pci-bridge.h |    6 ++
> arch/powerpc/sysdev/fsl_pci.c         |  108 =
+++++++++++++++++++++++++++++++++
> 2 files changed, 114 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/pci-bridge.h =
b/arch/powerpc/include/asm/pci-bridge.h
> index 882b6aa..c99b40e 100644
> --- a/arch/powerpc/include/asm/pci-bridge.h
> +++ b/arch/powerpc/include/asm/pci-bridge.h
> @@ -92,6 +92,12 @@ struct pci_controller {
>=20
> 	void *private_data;
> #endif	/* CONFIG_PPC64 */
> +
> +#ifdef CONFIG_SUSPEND
> +	struct pci_outbound_window_regs __iomem *pci_pow;
> +	struct pci_inbound_window_regs __iomem *pci_piw;

Why do we need both pointers, we dont you just keep a pointer to 'struct =
ccsr_pci __iomem' ?
Also, is there really a significant speed difference that we need to =
cache the ioremap pointer?  Can we not just do the ioremap() both in =
suspend & resume functions?

> +	void *saved_regs;
> +#endif

Should we just put this under private_data and expose that everywhere =
(ie not just on PPC64)

> };

Also, dont we need to save/restore the setting of PCSRBAR/PEXCSRBAR

>=20
> /* These are used for config access before all the PCI probing
> diff --git a/arch/powerpc/sysdev/fsl_pci.c =
b/arch/powerpc/sysdev/fsl_pci.c
> index e318e9d..046866f 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -756,12 +756,120 @@ static int __devinit fsl_pci_probe(struct =
platform_device *pdev)
> 	return 0;
> }
>=20
> +#ifdef CONFIG_SUSPEND
> +
> +#define PCI_POW_NUMBER	5
> +#define PCI_POW_BIAS	0xc00
> +#define PCI_PIW_NUMBER	3
> +#define PCI_PIW_BIAS	0xda0
> +
> +static int fsl_pci_suspend(struct platform_device *dev, pm_message_t =
state)
> +{
> +	struct pci_controller *hose;
> +	struct pci_outbound_window_regs *pci_saved_pow;
> +	struct pci_inbound_window_regs *pci_saved_piw;
> +	struct resource pci_rsrc;
> +	unsigned int i;
> +
> +	hose =3D pci_find_hose_for_OF_device(dev->dev.of_node);
> +	of_address_to_resource(dev->dev.of_node, 0, &pci_rsrc);
> +
> +	hose->pci_pow =3D ioremap(pci_rsrc.start + PCI_POW_BIAS,
> +			sizeof(struct pci_outbound_window_regs)
> +			* PCI_POW_NUMBER);
> +	if (!hose->pci_pow) {
> +		pr_err("pci_pow ioremap error!\n");
> +		return -ENOMEM;
> +	}
> +
> +	hose->pci_piw =3D ioremap(pci_rsrc.start + PCI_PIW_BIAS,
> +			sizeof(struct pci_inbound_window_regs)
> +			* PCI_PIW_NUMBER);
> +	if (!hose->pci_piw) {
> +		pr_err("pci_piw ioremap error!\n");
> +		goto err1;
> +	}
> +
> +	hose->saved_regs =3D kmalloc(
> +		sizeof(struct pci_outbound_window_regs) * PCI_POW_NUMBER =
+
> +		sizeof(struct pci_inbound_window_regs) * PCI_PIW_NUMBER,
> +		GFP_KERNEL);
> +	if (!hose->saved_regs)
> +		goto err2;
> +
> +	pci_saved_pow =3D hose->saved_regs;
> +	for (i =3D 0; i < PCI_POW_NUMBER; i++) {
> +		pci_saved_pow[i].potar =3D =
in_be32(&hose->pci_pow[i].potar);
> +		pci_saved_pow[i].potear =3D =
in_be32(&hose->pci_pow[i].potear);
> +		pci_saved_pow[i].powbar =3D =
in_be32(&hose->pci_pow[i].powbar);
> +		pci_saved_pow[i].powar =3D =
in_be32(&hose->pci_pow[i].powar);
> +	}
> +
> +	pci_saved_piw =3D (struct pci_inbound_window_regs *)
> +		(pci_saved_pow + PCI_POW_NUMBER);
> +	for (i =3D 0; i < PCI_PIW_NUMBER; i++) {
> +		pci_saved_piw[i].pitar =3D =
in_be32(&hose->pci_piw[i].pitar);
> +		pci_saved_piw[i].piwbar =3D =
in_be32(&hose->pci_piw[i].piwbar);
> +		pci_saved_piw[i].piwbear =3D =
in_be32(&hose->pci_piw[i].piwbear);
> +		pci_saved_piw[i].piwar =3D =
in_be32(&hose->pci_piw[i].piwar);
> +	}
> +
> +	return 0;
> +
> +err2:
> +	iounmap(hose->pci_piw);
> +
> +err1:
> +	iounmap(hose->pci_pow);
> +	return -ENOMEM;
> +}
> +
> +static int fsl_pci_resume(struct platform_device *dev)
> +{
> +	struct pci_controller *hose;
> +	struct pci_outbound_window_regs *pci_saved_pow;
> +	struct pci_inbound_window_regs *pci_saved_piw;
> +	unsigned int i;
> +
> +	hose =3D pci_find_hose_for_OF_device(dev->dev.of_node);
> +	if (!hose->pci_pow || !hose->pci_piw || !hose->saved_regs)
> +		return 0;
> +
> +	pci_saved_pow =3D hose->saved_regs;
> +	for (i =3D 0; i < PCI_POW_NUMBER; i++) {
> +		out_be32(&hose->pci_pow[i].potar, =
pci_saved_pow[i].potar);
> +		out_be32(&hose->pci_pow[i].potear, =
pci_saved_pow[i].potear);
> +		out_be32(&hose->pci_pow[i].powbar, =
pci_saved_pow[i].powbar);
> +		out_be32(&hose->pci_pow[i].powar, =
pci_saved_pow[i].powar);
> +	}
> +	iounmap(hose->pci_pow);
> +
> +	pci_saved_piw =3D (struct pci_inbound_window_regs *)
> +		(pci_saved_pow + PCI_POW_NUMBER);
> +	for (i =3D 0; i < PCI_PIW_NUMBER; i++) {
> +		out_be32(&hose->pci_piw[i].pitar, =
pci_saved_piw[i].pitar);
> +		out_be32(&hose->pci_piw[i].piwbar, =
pci_saved_piw[i].piwbar);
> +		out_be32(&hose->pci_piw[i].piwbear, =
pci_saved_piw[i].piwbear);
> +		out_be32(&hose->pci_piw[i].piwar, =
pci_saved_piw[i].piwar);
> +	}
> +	iounmap(hose->pci_piw);
> +	kfree(hose->saved_regs);
> +	hose->saved_regs =3D NULL;
> +
> +	return 0;
> +}
> +#endif
> +
> static struct platform_driver fsl_pci_driver =3D {
> 	.driver =3D {
> 		.name =3D "fsl-pci",
> 		.of_match_table =3D pci_ids,
> 	},
> 	.probe =3D fsl_pci_probe,
> +#ifdef CONFIG_SUSPEND
> +	.suspend	=3D fsl_pci_suspend,
> +	.resume		=3D fsl_pci_resume,
> +#endif
> };
>=20
> static int __init fsl_pci_init(void)
> --=20
> 1.7.5.1
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
