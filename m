Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 02/15] powerpc/rtas: Check RTAS presence when testing
	indicators
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1301984051-18413-3-git-send-email-benh@kernel.crashing.org>
References: <1301984051-18413-1-git-send-email-benh@kernel.crashing.org>
	<1301984051-18413-3-git-send-email-benh@kernel.crashing.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-0iqnJIWhc2M44R5mQyPX"
Date: Tue, 05 Apr 2011 16:36:12 +1000
Message-ID: <1301985372.3620.12.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-0iqnJIWhc2M44R5mQyPX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2011-04-05 at 16:13 +1000, Benjamin Herrenschmidt wrote:
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/kernel/rtas.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
> index 2097f2b..c2bfc4d 100644
> --- a/arch/powerpc/kernel/rtas.c
> +++ b/arch/powerpc/kernel/rtas.c
> @@ -591,6 +591,8 @@ bool rtas_indicator_present(int token, int *maxindex)
>  		u32 maxindex;
>  	} *indicators;
> =20
> +	if (!rtas.dev)
> +		return false;
>  	indicators =3D of_get_property(rtas.dev, "rtas-indicators", &proplen);
>  	if (!indicators)
>  		return false;

Why? of_get_property() returns NULL if np is NULL, implemented in
of_find_property(). It doesn't look like a fast path.

cheers

--=-0iqnJIWhc2M44R5mQyPX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk2auFoACgkQdSjSd0sB4dJntwCgqyugHQHiHQ6zxQ2P1aJ4jhYe
hxcAmQEppvsEkFCJ/pKq5laTFJuRgUo5
=mO/z
-----END PGP SIGNATURE-----

--=-0iqnJIWhc2M44R5mQyPX--
