Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 1/4 V3] MSI support on 83xx/85xx/86xx board
From: Michael Ellerman <michael@ellerman.id.au>
To: Jason Jin <Jason.jin@freescale.com>
In-Reply-To: <1209973634-1699-1-git-send-email-Jason.jin@freescale.com>
References: <1209973634-1699-1-git-send-email-Jason.jin@freescale.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-B7+EK6rYITs7PrCM7VuE"
Date: Mon, 05 May 2008 21:24:26 +1000
Message-Id: <1209986666.7163.14.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-B7+EK6rYITs7PrCM7VuE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-05-05 at 15:47 +0800, Jason Jin wrote:
> This MSI driver can be used on 83xx/85xx/86xx board.
> In this driver, virtual interrupt host and chip were
> setup. There are 256 MSI interrupts in this host, Every 32
> MSI interrupts cascaded to one IPIC/MPIC interrupt.
> The chip was treated as edge sensitive and some necessary
> functions were setup for this chip.
>=20
> Before using the MSI interrupt, PCI/PCIE device need to
> ask for a MSI interrupt in the 256 MSI interrupts. A 256bit
> bitmap show which MSI interrupt was used, reserve bit in
> the bitmap can be used to force the device use some designate
> MSI interrupt in the 256 MSI interrupts. Sometimes this is useful
> for testing the all the MSI interrupts. The msi-available-ranges
> property in the dts file was used for this purpose.
>=20
> Signed-off-by: Jason Jin <Jason.jin@freescale.com>


Hi Jason,

Just a couple of comments below:

> diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.=
c
> new file mode 100644
> index 0000000..c53f716
> --- /dev/null
> +++ b/arch/powerpc/sysdev/fsl_msi.c
> @@ -0,0 +1,442 @@
> +/*
> + * Copyright (C) 2007-2008 Freescale Semiconductor, Inc. All rights rese=
rved.
> + *
> + * Author: Tony Li <tony.li@freescale.com>
> + *	   Jason Jin <Jason.jin@freescale.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; version 2 of the
> + * License.
> + *
> + */
> +#include <linux/irq.h>
> +#include <linux/bootmem.h>
> +#include <linux/bitmap.h>
> +#include <linux/msi.h>
> +#include <linux/pci.h>
> +#include <linux/of_platform.h>
> +#include <sysdev/fsl_soc.h>
> +#include <asm/prom.h>
> +#include <asm/hw_irq.h>
> +#include <asm/ppc-pci.h>
> +#include "fsl_msi.h"
> +
> +struct fsl_msi_feature {
> +	u32 fsl_pic_ip;
> +	u32 msiir_offset;
> +};
> +
> +/* A bit ugly, can we get this from the pci_dev somehow? */

This comment is old (from my code) and should go.

> +static struct fsl_msi *fsl_msi;
> +
> +static inline u32 fsl_msi_read(u32 __iomem *base, unsigned int reg)
> +{
> +	return in_be32(base + (reg >> 2));
> +}
> +
> +static inline void fsl_msi_write(u32 __iomem *base,
> +				unsigned int reg, u32 value)
> +{
> +	out_be32(base + (reg >> 2), value);
> +}
> +
> +/*
> + * We do not need this actually. The MSIR register has been read once
> + * in the cascade interrupt. So, this MSI interrupt has been acked
> +*/
> +static void fsl_msi_end_irq(unsigned int virq)
> +{
> +}
> +
> +static struct irq_chip fsl_msi_chip =3D {
> +	.mask		=3D mask_msi_irq,
> +	.unmask		=3D unmask_msi_irq,
> +	.ack		=3D fsl_msi_end_irq,
> +	.typename	=3D " FSL-MSI  ",
> +};
> +
> +static int fsl_msi_host_match(struct irq_host *h, struct device_node *no=
de)
> +{
> +	/* Exact match, unless node is NULL */
> +	return h->of_node =3D=3D NULL || h->of_node =3D=3D node;
> +}

Are you sure you want this as your match routine? It looks wrong to me.
You won't ever create a fsl_msi in your probe routine unless you have a
device node, so AFAICT the of_node =3D=3D NULL is only ever going to match
some _other_ irqhost.


> diff --git a/arch/powerpc/sysdev/fsl_msi.h b/arch/powerpc/sysdev/fsl_msi.=
h
> new file mode 100644
> index 0000000..0449c96
> --- /dev/null
> +++ b/arch/powerpc/sysdev/fsl_msi.h
> @@ -0,0 +1,31 @@
> +#ifndef _POWERPC_SYSDEV_FSL_MSI_H
> +#define _POWERPC_SYSDEV_FSL_MSI_H


This should have a copyright header.

> +#define NR_MSI_REG		8
> +#define IRQS_PER_MSI_REG	32
> +#define NR_MSI_IRQS	(NR_MSI_REG * IRQS_PER_MSI_REG)
> +
> +#define FSL_PIC_IP_MASK	0x0000000F
> +#define FSL_PIC_IP_MPIC	0x00000001
> +#define FSL_PIC_IP_IPIC	0x00000002
> +
> +struct fsl_msi {
> +	/* Device node of the MSI interrupt*/
> +	struct device_node *of_node;
> +
> +	struct irq_host *irqhost;
> +
> +	unsigned long cascade_irq;
> +
> +	u32 msi_addr_lo;
> +	u32 msi_addr_hi;
> +	void __iomem *msi_regs;
> +	u32 feature;
> +
> +	unsigned long *fsl_msi_bitmap;
> +	spinlock_t bitmap_lock;
> +	const char *name;

I don't see where this is used?


cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-B7+EK6rYITs7PrCM7VuE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIHu5qdSjSd0sB4dIRAjhkAJ4oIe/xLtMoJN9Hr3nYBRQ3jLE+NQCeLb+/
FxbTL5XiSrRqp1rqkiKBZ2A=
=H+HX
-----END PGP SIGNATURE-----

--=-B7+EK6rYITs7PrCM7VuE--
