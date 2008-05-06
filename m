Return-Path: <Jason.Jin@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3A701DDF51
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 19:24:13 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m469O1DW025361
	for <linuxppc-dev@ozlabs.org>; Tue, 6 May 2008 02:24:02 -0700 (MST)
Received: from zch01exm27.fsl.freescale.net (zch01exm27.ap.freescale.net
	[10.192.129.223])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m469NpWV020347
	for <linuxppc-dev@ozlabs.org>; Tue, 6 May 2008 04:23:58 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 1/4 V3] MSI support on 83xx/85xx/86xx board
Date: Tue, 6 May 2008 17:23:48 +0800
Message-ID: <CC27DED0F8F39E48A7E75FD768688B7A8C1398@zch01exm27.fsl.freescale.net>
In-Reply-To: <1209986666.7163.14.camel@localhost>
References: <1209973634-1699-1-git-send-email-Jason.jin@freescale.com>
	<1209986666.7163.14.camel@localhost>
From: "Jin Zhengxiong" <Jason.Jin@freescale.com>
To: <michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Micheal,

Thank you for your comments.
I'll send the new version according to feedback.

Jason

> -----Original Message-----
> From: Michael Ellerman [mailto:michael@ellerman.id.au]=20
> Sent: Monday, May 05, 2008 7:24 PM
> To: Jin Zhengxiong
> Cc: galak@kernel.crashing.org; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH 1/4 V3] MSI support on 83xx/85xx/86xx board
>=20
> On Mon, 2008-05-05 at 15:47 +0800, Jason Jin wrote:
> > This MSI driver can be used on 83xx/85xx/86xx board.
> > In this driver, virtual interrupt host and chip were setup.=20
> There are=20
> > 256 MSI interrupts in this host, Every 32 MSI interrupts=20
> cascaded to=20
> > one IPIC/MPIC interrupt.
> > The chip was treated as edge sensitive and some necessary functions=20
> > were setup for this chip.
> >=20
> > Before using the MSI interrupt, PCI/PCIE device need to ask=20
> for a MSI=20
> > interrupt in the 256 MSI interrupts. A 256bit bitmap show which MSI=20
> > interrupt was used, reserve bit in the bitmap can be used=20
> to force the=20
> > device use some designate MSI interrupt in the 256 MSI interrupts.=20
> > Sometimes this is useful for testing the all the MSI=20
> interrupts. The=20
> > msi-available-ranges property in the dts file was used for this=20
> > purpose.
> >=20
> > Signed-off-by: Jason Jin <Jason.jin@freescale.com>
>=20
>=20
> Hi Jason,
>=20
> Just a couple of comments below:
>=20
> > diff --git a/arch/powerpc/sysdev/fsl_msi.c=20
> > b/arch/powerpc/sysdev/fsl_msi.c new file mode 100644 index=20
> > 0000000..c53f716
> > --- /dev/null
> > +++ b/arch/powerpc/sysdev/fsl_msi.c
> > @@ -0,0 +1,442 @@
> > +/*
> > + * Copyright (C) 2007-2008 Freescale Semiconductor, Inc.=20
> All rights reserved.
> > + *
> > + * Author: Tony Li <tony.li@freescale.com>
> > + *	   Jason Jin <Jason.jin@freescale.com>
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * as published by the Free Software Foundation; version 2 of the
> > + * License.
> > + *
> > + */
> > +#include <linux/irq.h>
> > +#include <linux/bootmem.h>
> > +#include <linux/bitmap.h>
> > +#include <linux/msi.h>
> > +#include <linux/pci.h>
> > +#include <linux/of_platform.h>
> > +#include <sysdev/fsl_soc.h>
> > +#include <asm/prom.h>
> > +#include <asm/hw_irq.h>
> > +#include <asm/ppc-pci.h>
> > +#include "fsl_msi.h"
> > +
> > +struct fsl_msi_feature {
> > +	u32 fsl_pic_ip;
> > +	u32 msiir_offset;
> > +};
> > +
> > +/* A bit ugly, can we get this from the pci_dev somehow? */
>=20
> This comment is old (from my code) and should go.
>=20
> > +static struct fsl_msi *fsl_msi;
> > +
> > +static inline u32 fsl_msi_read(u32 __iomem *base, unsigned=20
> int reg) {
> > +	return in_be32(base + (reg >> 2));
> > +}
> > +
> > +static inline void fsl_msi_write(u32 __iomem *base,
> > +				unsigned int reg, u32 value)
> > +{
> > +	out_be32(base + (reg >> 2), value);
> > +}
> > +
> > +/*
> > + * We do not need this actually. The MSIR register has=20
> been read once
> > + * in the cascade interrupt. So, this MSI interrupt has=20
> been acked */=20
> > +static void fsl_msi_end_irq(unsigned int virq) { }
> > +
> > +static struct irq_chip fsl_msi_chip =3D {
> > +	.mask		=3D mask_msi_irq,
> > +	.unmask		=3D unmask_msi_irq,
> > +	.ack		=3D fsl_msi_end_irq,
> > +	.typename	=3D " FSL-MSI  ",
> > +};
> > +
> > +static int fsl_msi_host_match(struct irq_host *h, struct=20
> device_node=20
> > +*node) {
> > +	/* Exact match, unless node is NULL */
> > +	return h->of_node =3D=3D NULL || h->of_node =3D=3D node; }
>=20
> Are you sure you want this as your match routine? It looks=20
> wrong to me.
> You won't ever create a fsl_msi in your probe routine unless=20
> you have a device node, so AFAICT the of_node =3D=3D NULL is only=20
> ever going to match some _other_ irqhost.
>=20
>=20
> > diff --git a/arch/powerpc/sysdev/fsl_msi.h=20
> > b/arch/powerpc/sysdev/fsl_msi.h new file mode 100644 index=20
> > 0000000..0449c96
> > --- /dev/null
> > +++ b/arch/powerpc/sysdev/fsl_msi.h
> > @@ -0,0 +1,31 @@
> > +#ifndef _POWERPC_SYSDEV_FSL_MSI_H
> > +#define _POWERPC_SYSDEV_FSL_MSI_H
>=20
>=20
> This should have a copyright header.
>=20
> > +#define NR_MSI_REG		8
> > +#define IRQS_PER_MSI_REG	32
> > +#define NR_MSI_IRQS	(NR_MSI_REG * IRQS_PER_MSI_REG)
> > +
> > +#define FSL_PIC_IP_MASK	0x0000000F
> > +#define FSL_PIC_IP_MPIC	0x00000001
> > +#define FSL_PIC_IP_IPIC	0x00000002
> > +
> > +struct fsl_msi {
> > +	/* Device node of the MSI interrupt*/
> > +	struct device_node *of_node;
> > +
> > +	struct irq_host *irqhost;
> > +
> > +	unsigned long cascade_irq;
> > +
> > +	u32 msi_addr_lo;
> > +	u32 msi_addr_hi;
> > +	void __iomem *msi_regs;
> > +	u32 feature;
> > +
> > +	unsigned long *fsl_msi_bitmap;
> > +	spinlock_t bitmap_lock;
> > +	const char *name;
>=20
> I don't see where this is used?
>=20
>=20
> cheers
>=20
> --
> Michael Ellerman
> OzLabs, IBM Australia Development Lab
>=20
> wwweb: http://michael.ellerman.id.au
> phone: +61 2 6212 1183 (tie line 70 21183)
>=20
> We do not inherit the earth from our ancestors, we borrow it=20
> from our children. - S.M.A.R.T Person
>=20
