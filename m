Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Add write barrier before enabling DTL flags
From: Michael Ellerman <michael@ellerman.id.au>
To: Jeremy Kerr <jk@ozlabs.org>
In-Reply-To: <1237863308.620048.912148989400.1.gpush@pingu>
References: <1237863308.620048.912148989400.1.gpush@pingu>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-9efXv8MUgvJsw8msZyx7"
Date: Tue, 24 Mar 2009 16:53:26 +1100
Message-Id: <1237874006.6478.284.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-9efXv8MUgvJsw8msZyx7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-03-24 at 13:55 +1100, Jeremy Kerr wrote:
> Currently, we don't enforce any ordering for updates to the lppaca
> when enabling dtl logging, so we may end up enabling logging before the
> index fields have been established.
>=20
> This change adds a smp_wmb() before doing the actual enable.
>=20
> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
>=20
> ---
>  arch/powerpc/platforms/pseries/dtl.c |    4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/arch/powerpc/platforms/pseries/dtl.c b/arch/powerpc/platform=
s/pseries/dtl.c
> index dc9b0f8..fafcaa0 100644
> --- a/arch/powerpc/platforms/pseries/dtl.c
> +++ b/arch/powerpc/platforms/pseries/dtl.c
> @@ -107,6 +107,10 @@ static int dtl_enable(struct dtl *dtl)
>  	/* set our initial buffer indices */
>  	dtl->last_idx =3D lppaca[dtl->cpu].dtl_idx =3D 0;
> =20
> +	/* ensure that our updates to the lppaca fields have occurred before
> +	 * we actually enable the logging */
> +	smp_wmb();

Wouldn't this still be a problem on a UP kernel?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-9efXv8MUgvJsw8msZyx7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAknIdVYACgkQdSjSd0sB4dK4LwCgqzCy7s+LVDRTTrPwgcEu7lHG
akgAnjw/qGLlj5Sb0lYBry6bOOSBvroj
=NHe+
-----END PGP SIGNATURE-----

--=-9efXv8MUgvJsw8msZyx7--
