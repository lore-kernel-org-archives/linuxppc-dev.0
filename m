Return-Path: <B35336@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ED463B6EE6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2012 20:32:09 +1100 (EST)
From: Zhao Chenhui-B35336 <B35336@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH 2/9] powerpc/mpc85xxcds: Fix PCI I/O space resource of
 PCI bridge
Date: Wed, 7 Mar 2012 09:31:55 +0000
Message-ID: <7AA2FF042C086D469F577FA6723434DA015EEA@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1331024805-15926-1-git-send-email-chenhui.zhao@freescale.com>
 <7FB9C27D-621B-4DF0-BFE0-CBF2D49B52D6@kernel.crashing.org>
In-Reply-To: <7FB9C27D-621B-4DF0-BFE0-CBF2D49B52D6@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/p=
latforms/85xx/mpc85xx_cds.c
> > index 40f03da..c009c5b 100644
> > --- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
> > +++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
> > @@ -3,7 +3,7 @@
> >  *
> >  * Maintained by Kumar Gala (see MAINTAINERS for contact information)
> >  *
> > - * Copyright 2005 Freescale Semiconductor Inc.
> > + * Copyright 2005, 2011-2012 Freescale Semiconductor Inc.
> >  *
> >  * This program is free software; you can redistribute  it and/or modif=
y it
> >  * under  the terms of  the GNU General  Public License as published by=
 the
> > @@ -158,6 +158,31 @@ DECLARE_PCI_FIXUP_EARLY(0x1957, 0x3fff, skip_fake_=
bridge);
> > DECLARE_PCI_FIXUP_EARLY(0x3fff, 0x1957, skip_fake_bridge);
> > DECLARE_PCI_FIXUP_EARLY(0xff3f, 0x5719, skip_fake_bridge);
> >
> > +/*
> > + * Fix Tsi310 PCI-X bridge resource.
> > + * Force the bridge to open a window from 0x0000-0x1fff in PCI I/O spa=
ce.
> > + * This allows legacy I/O(i8259, etc) on the VIA southbridge to be acc=
essed.
> > + */
>=20
> This comment and the code don't make sense.  Why is the bridge described =
as Tsi310 in comments but the
> vendor ID is IBM ?

This chip is from IBM originally, and bought by IDT.
The vendor ID is IBM, but the part number is Tsi310(IDT).

-Chenhui

>=20
> > +void mpc85xx_cds_fixup_bus(struct pci_bus *bus)
> > +{
> > +	struct pci_dev *dev =3D bus->self;
> > +	struct resource *res =3D bus->resource[0];
> > +
> > +	if (dev !=3D NULL &&
> > +	    dev->vendor =3D=3D PCI_VENDOR_ID_IBM &&
> > +	    dev->device =3D=3D PCI_DEVICE_ID_IBM_PCIX_BRIDGE) {
> > +		if (res) {
> > +			res->start =3D 0;
> > +			res->end   =3D 0x1fff;
> > +			res->flags =3D IORESOURCE_IO;
> > +			pr_info("mpc85xx_cds: PCI bridge resource fixup applied\n");
> > +			pr_info("mpc85xx_cds: %pR\n", res);
> > +		}
> > +	}
> > +
> > +	fsl_pcibios_fixup_bus(bus);
> > +}
