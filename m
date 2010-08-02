Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 03/11] powerpc/nvram: nvram_create_partitions() now
	uses bytes
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1280710522-6362-4-git-send-email-benh@kernel.crashing.org>
References: <1280710522-6362-1-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-2-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-3-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-4-git-send-email-benh@kernel.crashing.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-tEGKtcoPoaEvys6KZsFI"
Date: Mon, 02 Aug 2010 13:47:02 +1000
Message-ID: <1280720822.2491.177.camel@concordia>
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


--=-tEGKtcoPoaEvys6KZsFI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2010-08-02 at 10:55 +1000, Benjamin Herrenschmidt wrote:
> This converts nvram_create_partition() to use a size in bytes
> rather than blocks. It does the appropriate alignment internally
>=20
> The size passed is also the data size (ie. doesn't include the
> header anymore).
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/kernel/nvram_64.c |   20 ++++++++++++++------
>  1 files changed, 14 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_6=
4.c
> index 974b3ec..b0f2114 100644
> --- a/arch/powerpc/kernel/nvram_64.c
> +++ b/arch/powerpc/kernel/nvram_64.c
> @@ -34,10 +34,10 @@
> =20
>  #undef DEBUG_NVRAM
> =20
> -#define NVRAM_HEADER_LEN 16 /* sizeof(struct nvram_header) */
> -#define NVRAM_BLOCK_LEN 16
> -#define NVRAM_MAX_REQ (2080/NVRAM_BLOCK_LEN)
> -#define NVRAM_MIN_REQ (1056/NVRAM_BLOCK_LEN)
> +#define NVRAM_HEADER_LEN	sizeof(struct nvram_header)
> +#define NVRAM_BLOCK_LEN		NVRAM_HEADER_LEN
> +#define NVRAM_MAX_REQ		2079
> +#define NVRAM_MIN_REQ		1055

You don't change any callers, but that's because they use these #defines
right.

cheers

--=-tEGKtcoPoaEvys6KZsFI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkxWP7YACgkQdSjSd0sB4dK+YQCcDEYJFxj2n34kAvzxQLZeaERs
cyAAnjOa87Sbvig9Fq+mJRL8RDSHQMFM
=xTEZ
-----END PGP SIGNATURE-----

--=-tEGKtcoPoaEvys6KZsFI--
