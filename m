Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 11/16] Use of_get_next_child() in eeh_restore_bars()
From: Michael Ellerman <michael@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20071026172909.f7a085e9.sfr@canb.auug.org.au>
References: <80449d4682309dbf8cf80816be4f381fe875f3d1.1193381582.git.michael@ellerman.id.au>
	<ef7facd658919117aa7c693b4eeb12241ca859d8.1193381582.git.michael@ellerman.id.au>
	<20071026172909.f7a085e9.sfr@canb.auug.org.au>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-M4pbEIJtwlmmVNcOcKHk"
Date: Mon, 29 Oct 2007 14:46:13 +1100
Message-Id: <1193629573.7280.11.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, "David S.Miller" <davem@davemloft.net>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-M4pbEIJtwlmmVNcOcKHk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On Fri, 2007-10-26 at 17:29 +1000, Stephen Rothwell wrote:
> On Fri, 26 Oct 2007 16:54:43 +1000 (EST) Michael Ellerman <michael@ellerm=
an.id.au> wrote:
> >
> > +++ b/arch/powerpc/platforms/pseries/eeh.c
> > @@ -841,11 +841,8 @@ void eeh_restore_bars(struct pci_dn *pdn)
> >  	if ((pdn->eeh_mode & EEH_MODE_SUPPORTED) && !IS_BRIDGE(pdn->class_cod=
e))
> >  		__restore_bars (pdn);
> > =20
> > -	dn =3D pdn->node->child;
> > -	while (dn) {
> > +	for (dn =3D NULL; (dn =3D of_get_next_child(pdn->node, dn));)
>=20
> Just wondering if we need
>=20
> #define for_each_child_node(dn, parent) \
> 	for (dn =3D of_get_next_child(parent, NULL); dn; \
> 		dn =3D of_get_next_child(parent, dn))

Hmm, perhaps. I count ~30 places we could use it under arch/powerpc, and
about another ~20 in drivers/.

If no one objects, I guess I'll get to it, sigh ... another Yak.

Should we perhaps make it for_each_child_device_node() ?
Otherwise it's slightly non obvious what kind of node it's talking
about, especially in driver code.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-M4pbEIJtwlmmVNcOcKHk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHJVeFdSjSd0sB4dIRAsrxAJ0fT/uwpYmSTvcF1XaQZp3sAHM2GwCeJl4o
Ge98MaWEgKhw1XPv1XLuRXg=
=hlF/
-----END PGP SIGNATURE-----

--=-M4pbEIJtwlmmVNcOcKHk--
