Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 5/7] Enable MSI mappings for MPIC
From: Michael Ellerman <michael@ellerman.id.au>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <b876ed7a2f13ad05a04f0aac3b364c9a@bga.com>
References: <20070419073555.01990DDECB@ozlabs.org>
	<0846c0d8efafe7258075826b9c869fea@bga.com>
	<1177200410.6080.26.camel@localhost.localdomain>
	<b876ed7a2f13ad05a04f0aac3b364c9a@bga.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-SwaRWX6fUiHKCXtZIx5h"
Date: Mon, 23 Apr 2007 14:10:54 +1000
Message-Id: <1177301454.3889.29.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>, linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-SwaRWX6fUiHKCXtZIx5h
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2007-04-21 at 23:53 -0500, Milton Miller wrote:
> On Apr 21, 2007, at 7:06 PM, Benjamin Herrenschmidt wrote:
> >> This is just begging to be written in terms of
> >> pci_bus_find_ht_capability.  Well,
> >> we have pci_bus_find_capability, and pci_find_ht_capability, I'm sure
> >> we could
> >> create that.   It also means this and the other nearby functions want
> >> to be
> >> written in terms of a struct pci_bus and config accessors.
> >
> > A lot of that code has to run way before the PCI config stuff is even
> > useable and certainly before the PCI layer data structures have been
> > created.... Sucks but that's how it is for now. We might be able to
> > tweak and delay init of the APICs etc... but I don't think I can be
> > bothered for now as it's a bit of a corner case.
> >
>=20
> I wasn't proposing to make the code wait until the pci layer had
> discovered the ht bridge.  Rather I was thinking that a struct
> pci_bus instance created for the purpose with only ops and maybe
> sysdata initialized.  The purpose being to reuse the generic code.

That'd be nice in a way. Although there'd be scope for breakage from
time to time as PCI changes get made without taking into account this
special case.

> Maybe I'll have to code something up.   Perhaps when I'm a bit
> less overloaded.

All yours :)

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-SwaRWX6fUiHKCXtZIx5h
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGLDHOdSjSd0sB4dIRAvoTAJ0Z/7k0sIy+VN/QzZLQ3rQbWY2xnACgrnE9
SKV91XCMyn9riIgqcGRnnEc=
=sJDi
-----END PGP SIGNATURE-----

--=-SwaRWX6fUiHKCXtZIx5h--
