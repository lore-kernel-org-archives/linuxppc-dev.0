Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B9772B6F9D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 23:16:41 +1100 (EST)
Subject: Re: [PATCH 2/9] powerpc/mpc85xxcds: Fix PCI I/O space resource of PCI
 bridge
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1331024805-15926-1-git-send-email-chenhui.zhao@freescale.com>
Date: Tue, 6 Mar 2012 06:15:59 -0600
Message-Id: <7FB9C27D-621B-4DF0-BFE0-CBF2D49B52D6@kernel.crashing.org>
References: <1331024805-15926-1-git-send-email-chenhui.zhao@freescale.com>
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 6, 2012, at 3:06 AM, Zhao Chenhui wrote:

> From: chenhui zhao <chenhui.zhao@freescale.com>
>=20
> There is a PCI bridge(Tsi310) between the MPC8548 and a VIA
> southbridge chip.
>=20
> The bootloader sets the PCI bridge to open a window from 0x0000
> to 0x1fff on the PCI I/O space. But the kernel can't set the I/O
> resource. In the routine pci_read_bridge_io(), if the base which
> is read from PCI_IO_BASE is equal to zero, the routine don't set
> the I/O resource of the child bus.
>=20
> To allow the legacy I/O space on the VIA southbridge to be accessed,
> use the fixup to fix the PCI I/O space of the PCI bridge.
>=20
> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> arch/powerpc/platforms/85xx/mpc85xx_cds.c |   29 =
+++++++++++++++++++++++++++--
> 1 files changed, 27 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c =
b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
> index 40f03da..c009c5b 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
> @@ -3,7 +3,7 @@
>  *
>  * Maintained by Kumar Gala (see MAINTAINERS for contact information)
>  *
> - * Copyright 2005 Freescale Semiconductor Inc.
> + * Copyright 2005, 2011-2012 Freescale Semiconductor Inc.
>  *
>  * This program is free software; you can redistribute  it and/or =
modify it
>  * under  the terms of  the GNU General  Public License as published =
by the
> @@ -158,6 +158,31 @@ DECLARE_PCI_FIXUP_EARLY(0x1957, 0x3fff, =
skip_fake_bridge);
> DECLARE_PCI_FIXUP_EARLY(0x3fff, 0x1957, skip_fake_bridge);
> DECLARE_PCI_FIXUP_EARLY(0xff3f, 0x5719, skip_fake_bridge);
>=20
> +/*
> + * Fix Tsi310 PCI-X bridge resource.
> + * Force the bridge to open a window from 0x0000-0x1fff in PCI I/O =
space.
> + * This allows legacy I/O(i8259, etc) on the VIA southbridge to be =
accessed.
> + */

This comment and the code don't make sense.  Why is the bridge described =
as Tsi310 in comments but the vendor ID is IBM ?

> +void mpc85xx_cds_fixup_bus(struct pci_bus *bus)
> +{
> +	struct pci_dev *dev =3D bus->self;
> +	struct resource *res =3D bus->resource[0];
> +
> +	if (dev !=3D NULL &&
> +	    dev->vendor =3D=3D PCI_VENDOR_ID_IBM &&
> +	    dev->device =3D=3D PCI_DEVICE_ID_IBM_PCIX_BRIDGE) {
> +		if (res) {
> +			res->start =3D 0;
> +			res->end   =3D 0x1fff;
> +			res->flags =3D IORESOURCE_IO;
> +			pr_info("mpc85xx_cds: PCI bridge resource fixup =
applied\n");
> +			pr_info("mpc85xx_cds: %pR\n", res);
> +		}
> +	}
> +
> +	fsl_pcibios_fixup_bus(bus);
> +}
> +
> #ifdef CONFIG_PPC_I8259
> static void mpc85xx_8259_cascade_handler(unsigned int irq,
> 					 struct irq_desc *desc)
> @@ -323,7 +348,7 @@ define_machine(mpc85xx_cds) {
> 	.get_irq	=3D mpic_get_irq,
> #ifdef CONFIG_PCI
> 	.restart	=3D mpc85xx_cds_restart,
> -	.pcibios_fixup_bus	=3D fsl_pcibios_fixup_bus,
> +	.pcibios_fixup_bus	=3D mpc85xx_cds_fixup_bus,
> #else
> 	.restart	=3D fsl_rstcr_restart,
> #endif
> --=20
> 1.6.4.1
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
