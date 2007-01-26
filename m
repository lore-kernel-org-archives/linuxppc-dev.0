Return-Path: <michael@ellerman.id.au>
Subject: Re: [RFC/PATCH 5/16] Ops based MSI implementation
From: Michael Ellerman <michael@ellerman.id.au>
To: Greg KH <greg@kroah.com>
In-Reply-To: <20070125215209.GA3126@kroah.com>
References: <1169714047.65693.647693675533.qpush@cradle>
	<20070125083411.5D935DE2FD@ozlabs.org>
	<20070125215209.GA3126@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-eTFtnMI6rqw65+AIiq85"
Date: Fri, 26 Jan 2007 12:02:30 +1100
Message-Id: <1169773350.25005.18.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Brice Goglin <brice@myri.com>, shaohua.li@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz,
	"David S. Miller" <davem@davemloft.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-eTFtnMI6rqw65+AIiq85
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-01-25 at 13:52 -0800, Greg KH wrote:
> On Thu, Jan 25, 2007 at 07:34:09PM +1100, Michael Ellerman wrote:
> > --- /dev/null
> > +++ msi/include/linux/msi-ops.h
> > @@ -0,0 +1,168 @@
> > +/*
> > + * Copyright 2006-2007, Michael Ellerman, IBM Corporation.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * as published by the Free Software Foundation; either version
> > + * 2 of the License, or (at your option) any later version.
>=20
> Are you sure of the "any later version" part?

Not 100%. I copied it from an existing file in arch/powerpc, and I
haven't heard anything about changing the boiler plate - but I'll see if
anyone knows. I'm not really interested in starting a GPLv2 vs GPLv3
debate :)

> > + */
> > +
> > +#ifndef LINUX_MSI_OPS_H
> > +#define LINUX_MSI_OPS_H
> > +
> > +#ifdef __KERNEL__
> > +#ifndef __ASSEMBLY__
>=20
> These two ifdefs aren't needed.

OK. I thought __KERNEL__ was for hiding things from userspace, but I
haven't been following the header developments.=20

> > +#include <linux/pci.h>
> > +#include <linux/msi.h>
>=20
> Why not just put this structure in the msi.h file?

Yeah OK I'll put it in there.

> > +
> > +/*
> > + * MSI and MSI-X although different in some details, are also similar =
in
> > + * many respects, and ultimately achieve the same end. Given that, thi=
s code
> > + * tries as far as possible to implement both MSI and MSI-X with a min=
imum
> > + * of code duplication. We will use "MSI" to refer to both MSI and MSI=
-X,
> > + * except where it is important to differentiate between the two.
> > + *
> > + * Enabling MSI for a device can be broken down into:
> > + *  1) Checking the device can support the type/number of MSIs request=
ed.
> > + *  2) Allocating irqs for the MSIs and setting up the irq_descs.
> > + *  3) Writing the appropriate configuration to the device and enablin=
g MSIs.
> > + *
> > + * To implement that we have the following callbacks:
> > + *  1) check(pdev, num, msix_entries, type)
> > + *  2) alloc(pdev, num, msix_entries, type)
> > + *  3) enable(pdev, num, msix_entries, type)
> > + *	a) setup_msi_msg(pdev, msix_entry, msi_msg, type)
> > + *
> > + * We give platforms full control over the enable step. However many
> > + * platforms will simply want to program the device using standard PCI
> > + * accessors. These platforms can use a generic enable callback and de=
fine
> > + * a setup_msi_msg() callback which simply fills in the "magic" addres=
s and
> > + * data values. Other platforms may leave setup_msi_msg() empty.
> > + *
> > + * Disabling MSI requires:
> > + *  1) Disabling MSI on the device.
> > + *  2) Freeing the irqs and any associated accounting information.
> > + *
> > + * Which maps directly to the two callbacks:
> > + *  1) disable(pdev, num, msix_entries, type)
> > + *  2) free(pdev, num, msix_entries, type)
> > + */
>=20
>=20
> Please use the proper kernel-doc format so the tools pick up this
> documentation automatically.

Will do.

> > +#define msi_debug(fmt, args...)	\
> > +	pr_debug("MSI:%s:%d: " fmt, __FUNCTION__, __LINE__, ## args)
>=20
> Please use dev_dbg(), it makes it easier to track which device is being
> referenced.

OK. My only gripe with dev_dbg() is it doesn't handle a NULL dev, which
means you have to be very careful where you use it. There's at least one
spot in the MSI code where I call msi_debug() with a possibly NULL pdev.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-eTFtnMI6rqw65+AIiq85
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFuVMmdSjSd0sB4dIRAgqJAJ9IvisA4PmknevlhaA4ju3RnfRtBQCfXHI3
hk+i22IUdkmGYJhBcRVI7Ms=
=IA5x
-----END PGP SIGNATURE-----

--=-eTFtnMI6rqw65+AIiq85--
