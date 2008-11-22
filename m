Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] IB/ehca: Fix lockdep failures for shca_list_lock
From: Michael Ellerman <michael@ellerman.id.au>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1227283347.3599.8.camel@johannes.berg>
References: <200806061835.43802.fenkes@de.ibm.com>
	<48499C11.7030504@gmail.com>  <200811211637.15300.fenkes@de.ibm.com>
	<1227283347.3599.8.camel@johannes.berg>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-wGTLu2HDVlWeitLDaXUm"
Date: Sat, 22 Nov 2008 14:41:08 +1100
Message-Id: <1227325268.10134.2.camel@localhost>
Mime-Version: 1.0
Cc: Joachim Fenkes <fenkes@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
	OF-EWG <ewg@lists.openfabrics.org>, LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>,
	OF-General <general@lists.openfabrics.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-wGTLu2HDVlWeitLDaXUm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2008-11-21 at 17:02 +0100, Johannes Berg wrote:
> On Fri, 2008-11-21 at 16:37 +0100, Joachim Fenkes wrote:
>=20
> > +	u64 flags;
>=20
> > -	spin_lock(&shca_list_lock);
> > +	spin_lock_irqsave(&shca_list_lock, flags);
>=20
> That's wrong and I think will give a warning on all machines where
> u64 !=3D unsigned long. Might not particularly matter in this case.

Crud, sorry.

> Also, generally it seems wrong to say "fix lockdep failure" when the
> patch really fixes a bug that lockdep happened to find.

True. I guess it should be "fix locking error found with lockdep", to
make it clear no one has actually hit the bug.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-wGTLu2HDVlWeitLDaXUm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkknf1QACgkQdSjSd0sB4dLuegCfdD9QaCxGcfpr0dLLsdDw8aCy
znQAoKjg+uaMRKR7noZNuoq2/rhEX2Ed
=+IXW
-----END PGP SIGNATURE-----

--=-wGTLu2HDVlWeitLDaXUm--
