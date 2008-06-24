Return-Path: <michael@ellerman.id.au>
Subject: Re: Do we still need devtree_lock?
From: Michael Ellerman <michael@ellerman.id.au>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <48617FA4.7070603@freescale.com>
References: <48617FA4.7070603@freescale.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-fIW7cPjqqgivMetp5Vpr"
Date: Wed, 25 Jun 2008 09:25:28 +1000
Message-Id: <1214349928.7273.1.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-fIW7cPjqqgivMetp5Vpr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-06-24 at 18:13 -0500, Timur Tabi wrote:
> I'm trying to write a function that gets a list of all aliases
>=20
> 	aliases {
> 		serial0 =3D &serial0;
> 		serial1 =3D &serial1;
> 		pci0 =3D &pci0;
> 		pci1 =3D &pci1;
> 		pci2 =3D &pci2;
> 	};
>=20
> That is, I do not know which aliases are in the /aliases node, so I need =
a
> function that works somewhat like of_find_property(), but just returns th=
e Nth
> property instead of doing a strcmp.
>=20
> I can't seem to find one, so I probably need to write one.  However, I no=
ticed
> that of_find_property() uses a lock:
>=20
> 	read_lock(&devtree_lock);
> 	for (pp =3D np->properties; pp !=3D 0; pp =3D pp->next) {
> 		if (of_prop_cmp(pp->name, name) =3D=3D 0) {
> 			if (lenp !=3D 0)
> 				*lenp =3D pp->length;
> 			break;
> 		}
> 	}
> 	read_unlock(&devtree_lock);
>=20
> But the comment for devtree_lock says this:
>=20
> extern rwlock_t devtree_lock;	/* temporary while merging */
>=20
> Since arch/ppc is going away, does this meant that the lock can go away d=
o?

You wish :)  That /would/ make life easier.

I think the comment just refers to the extern declaration being in
the .c file, rather than a header - ie. now that the merge is done we
should clean it up and put it in a header.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-fIW7cPjqqgivMetp5Vpr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIYYJodSjSd0sB4dIRAi+LAKDASLbcBMzwP4bedAS3QC14f/96SgCfVuL/
Ij+704kzLEwnZBGi1+hppko=
=Wjj9
-----END PGP SIGNATURE-----

--=-fIW7cPjqqgivMetp5Vpr--
