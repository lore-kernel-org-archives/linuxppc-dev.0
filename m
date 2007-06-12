Return-Path: <michael@ellerman.id.au>
Subject: Re: [RFC/PATCH 4/4] Add support for MSI on Axon-based Cell systems
From: Michael Ellerman <michael@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <e098552c6ae6fa48212a951ec644b80f@kernel.crashing.org>
References: <f0cd638495b96585dec513f41335154e60675813.1180961962.git.michael@ellerman.id.au>
	<200706082126.23435.arnd@arndb.de>
	<65a522813f1b95748a3acc0c05e0285c@kernel.crashing.org>
	<200706082201.26308.arnd@arndb.de>
	<e098552c6ae6fa48212a951ec644b80f@kernel.crashing.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-6Rh5r1K/ih1VdCnBFTnb"
Date: Tue, 12 Jun 2007 12:30:04 +1000
Message-Id: <1181615404.17771.9.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-6Rh5r1K/ih1VdCnBFTnb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-06-08 at 22:06 +0200, Segher Boessenkool wrote:
> >> That wasn't my question though?
> >
> > Sorry, I misread this. The of_node_get is done because we keep
> > a reference to the device node in the axon_msic struct. There is
> > no module_exit function in the driver that could clean up the
> > axon_msic, so we must never have an of_node_put as far as I
> > understand.
>=20
> >>>>>> +               if (axon_msi_setup_one(of_node_get(node)) =3D=3D 0=
)
> >>>>>> +                       found++;
>=20
> What if axon_msi_setup_one() returns an error?  Sounds
> to me like the get() should be inside that function no
> matter what?

It drops the ref if there's an error.

> If the reference counting isn't obvious, it is obviously
> wrong ;-)

But if it is obvious it may well be unobviously wrong, which is
better? ;)

I'll rework it.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-6Rh5r1K/ih1VdCnBFTnb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGbgUrdSjSd0sB4dIRAmtuAJ4ncLgNyanPeljSxSmkY6d60vdPOwCfd5RB
h7FL/BnKK4YmsgKcEJWcEbk=
=WV7C
-----END PGP SIGNATURE-----

--=-6Rh5r1K/ih1VdCnBFTnb--
