Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 2/7] Powerpc MSI infrastructure
From: Michael Ellerman <michael@ellerman.id.au>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <5978bcffcf3b9348ebd4349ba8c2730a@bga.com>
References: <20070419073553.5F2ABDDE3C@ozlabs.org>
	<5978bcffcf3b9348ebd4349ba8c2730a@bga.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-uPtll8TONIgwd2CEDz2A"
Date: Mon, 23 Apr 2007 14:28:26 +1000
Message-Id: <1177302506.3889.38.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-uPtll8TONIgwd2CEDz2A
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2007-04-21 at 18:15 -0500, Milton Miller wrote:
> On Apr 19, 2007, Michael Ellerman wrote:
> > This patch provides the architecture specific hooks to support MSI on
> > powerpc. We implement the newly added arch_setup_msi_irqs() and
> > arch_teardown_msi_irqs(), and then delegate to ppc_md routines.
> >
>=20
> > Index: msi-new/arch/powerpc/kernel/msi.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- /dev/null
> > +++ msi-new/arch/powerpc/kernel/msi.c
> > @@ -0,0 +1,38 @@
> > +/*
> > + * Copyright 2006-2007, Michael Ellerman, IBM Corporation.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * as published by the Free Software Foundation; either version
> > + * 2 of the License, or (at your option) any later version.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/msi.h>
> > +
> > +#include <asm/machdep.h>
> > +
> > +int arch_msi_check_device(struct pci_dev* dev, int nvec, int type)
> > +{
> > +	if (ppc_md.msi_check_device) {
> > +		pr_debug("msi: Using platform check routine.\n");
> > +		return ppc_md.msi_check_device(dev, nvec, type);
> > +	}
> > +
> > +	if (!ppc_md.setup_msi_irqs || !ppc_md.teardown_msi_irqs) {
> > +		pr_debug("msi: Platform doesn't provide MSI callbacks.\n");
> > +		return -ENOSYS;
> > +	}
>=20
> Should we not do this check first?  Or do you expect some platform
> to fill out these hooks in the check call above?  Othewise we will
> branch to function pointer NULL.

Not really. More a case of if you provide check then you'd better get
your act together and provide the others. I'll rearrange it to be safer.

>=20
> > +
> > +        return 0;
> > +}
> > +
> > +int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
> > +{
> > +	return ppc_md.setup_msi_irqs(dev, nvec, type);
> > +}
> > +
> > +void arch_teardown_msi_irqs(struct pci_dev *dev)
> > +{
> > +	return ppc_md.teardown_msi_irqs(dev);
> > +}
>=20
>=20
> > Index: msi-new/arch/powerpc/kernel/Makefile
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- msi-new.orig/arch/powerpc/kernel/Makefile
> > +++ msi-new/arch/powerpc/kernel/Makefile
>=20
> > +obj-$(CONFIG_PCI_MSI)		+=3D msi.o
>=20
>=20
> Do we really need a new file for these simple hooks?  It doesn't look
> like anthing else is going to be added to it either.   I'd prefer to
> just do an ifdef in pci.c.   Hmmm, we don't seem to have that, but
> these are soo small I'd include machdep.h and put them inline in
> asm-powerpc/pci.h.

I'd rather leave it as is. We can't have them inline, because they're
already defined in drivers/pci/msi.c. And having the CONFIG logic in the
Makefile is cleaner than #ifdef goo. Also it might grow one day, if we
make the hooks per pci_dev or per bus rather than in ppc_md.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-uPtll8TONIgwd2CEDz2A
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGLDXqdSjSd0sB4dIRAqsJAJ9o54NikRPsVdF6gjLZkSyqJ0gaYgCeIwWK
GGRhoDwRHgDWOSBkosYS43s=
=Wehj
-----END PGP SIGNATURE-----

--=-uPtll8TONIgwd2CEDz2A--
