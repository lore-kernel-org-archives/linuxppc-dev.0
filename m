Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 3/4] Simplify rtas_change_msi() error semantics
From: Michael Ellerman <michael@ellerman.id.au>
To: benh@kernel.crashing.org
In-Reply-To: <1191302603.6310.88.camel@pasglop>
References: <3034ec8fd939bd5cfcdb7ac65206ae2771dc9b2c.1190270165.git.michael@ellerman.id.au>
	<fbd88f287ba9d9ca41b5c8da734afd595ae25922.1190270165.git.michael@ellerman.id.au>
	<1191302603.6310.88.camel@pasglop>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-npzAIAfzC4k/n5QLndwh"
Date: Tue, 02 Oct 2007 15:58:10 +1000
Message-Id: <1191304690.6593.8.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-npzAIAfzC4k/n5QLndwh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-10-02 at 15:23 +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2007-09-20 at 16:36 +1000, Michael Ellerman wrote:
> > Currently rtas_change_msi() returns either the error code from RTAS, or=
 if
> > the RTAS call succeeded the number of irqs that were configured by RTAS=
.
> > This makes checking the return value more complicated than it needs to =
be.
> >=20
> > Instead, have rtas_change_msi() check that the number of irqs configure=
d by
> > RTAS is equal to what we requested - and return an error otherwise. Thi=
s makes
> > the return semantics match the usual 0 for success, something else for =
error.
> >=20
> > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
>=20
> Looks allright, just a question tho... what do we do if it fails ? Do we
> try to fallback to a lower number of MSIs ? Or what ? Dead device ?

That's all up to the device driver. In theory the driver could try again
with a lower count - but that might require extra logic in the driver to
handle shared irq handlers etc. In practice I think the current drivers
will just fail.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-npzAIAfzC4k/n5QLndwh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHAd3ydSjSd0sB4dIRAlB1AJ9uoBxX603+ZM80iBQNjBKuPiMKygCgqn4T
UvXFs7rb5Y4fcYnT5cxNi1I=
=iMe3
-----END PGP SIGNATURE-----

--=-npzAIAfzC4k/n5QLndwh--
