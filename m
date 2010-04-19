Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 3/4] fsl_msi: enable msi sharing through AMP OSes
From: Michael Ellerman <michael@ellerman.id.au>
To: Li Yang <leoli@freescale.com>
In-Reply-To: <1271403278-30091-3-git-send-email-leoli@freescale.com>
References: <1271403278-30091-1-git-send-email-leoli@freescale.com>
	<1271403278-30091-2-git-send-email-leoli@freescale.com>
	<1271403278-30091-3-git-send-email-leoli@freescale.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-2vDbpGizdLl63aivRTNG"
Date: Mon, 19 Apr 2010 12:34:09 +1000
Message-ID: <1271644449.14835.35.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Zhao Chenhui <b26998@freescale.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-2vDbpGizdLl63aivRTNG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2010-04-16 at 15:34 +0800, Li Yang wrote:
> From: Zhao Chenhui <b26998@freescale.com>
>=20
> Make a single PCIe MSI bank shareable through CAMP OSes. The number of
> MSI used by each core can be configured by dts file.
>=20
> Signed-off-by: Zhao Chenhui <b26998@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
>  arch/powerpc/sysdev/fsl_msi.c    |    8 +++++++-
>  arch/powerpc/sysdev/msi_bitmap.c |    4 ++--
>  2 files changed, 9 insertions(+), 3 deletions(-)
..
> diff --git a/arch/powerpc/sysdev/msi_bitmap.c b/arch/powerpc/sysdev/msi_b=
itmap.c
> index 5a32cbe..b41db96 100644
> --- a/arch/powerpc/sysdev/msi_bitmap.c
> +++ b/arch/powerpc/sysdev/msi_bitmap.c
> @@ -95,8 +95,8 @@ int msi_bitmap_reserve_dt_hwirqs(struct msi_bitmap *bmp=
)
>  	/* Format is: (<u32 start> <u32 count>)+ */
>  	len /=3D 2 * sizeof(u32);
>  	for (i =3D 0; i < len; i++, p +=3D 2) {
> -		for (j =3D 0; j < *(p + 1); j++)
> -			bitmap_release_region(bmp->bitmap, *p + j, 0);
> +		for (j =3D *p; j < *(p + 1); j++)
> +			bitmap_release_region(bmp->bitmap, j, 0);
>  	}
> =20
>  	spin_unlock(&bmp->lock);

This looks like a bug fix to the msi bitmap code, is it not? Please
split it into a separate commit with an explanatory changelog.

cheers



--=-2vDbpGizdLl63aivRTNG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkvLwSEACgkQdSjSd0sB4dInRgCgqrgDodW3XtEARVTxftF7qENF
SaEAoMY2VHD7hn+xKGkymh3w3EjXuUCJ
=Bb1J
-----END PGP SIGNATURE-----

--=-2vDbpGizdLl63aivRTNG--
