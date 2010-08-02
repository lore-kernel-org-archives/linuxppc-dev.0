Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 05/11] powerpc/nvram: Completely clear a new partition
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1280710522-6362-6-git-send-email-benh@kernel.crashing.org>
References: <1280710522-6362-1-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-2-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-3-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-4-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-5-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-6-git-send-email-benh@kernel.crashing.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-uUZLRpHPIjd4HjZ6h7Yj"
Date: Mon, 02 Aug 2010 13:50:37 +1000
Message-ID: <1280721037.2491.179.camel@concordia>
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


--=-uUZLRpHPIjd4HjZ6h7Yj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2010-08-02 at 10:55 +1000, Benjamin Herrenschmidt wrote:
> When creating a partition, we clear it entirely rather than
> just the first two words since the previous code was rather
> specific to the pseries log partition format.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/kernel/nvram_64.c |   19 ++++++++++---------
>  1 files changed, 10 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_6=
4.c
> index dd18a5a..7ddeaa6 100644
> --- a/arch/powerpc/kernel/nvram_64.c
> +++ b/arch/powerpc/kernel/nvram_64.c
> @@ -320,7 +320,7 @@ static int __init nvram_create_partition(const char *=
name, int sig,
>  	struct nvram_partition *part;
>  	struct nvram_partition *new_part;
>  	struct nvram_partition *free_part =3D NULL;
> -	int seq_init[2] =3D { 0, 0 };
> +	static char nv_init_vals[16];

Or should we just grab a zeroed page?

>  	loff_t tmp_index;
>  	long size =3D 0;
>  	int rc;
> @@ -379,14 +379,15 @@ static int __init nvram_create_partition(const char=
 *name, int sig,
>  		return rc;
>  	}
> =20
> -	/* make sure and initialize to zero the sequence number and the error
> -	   type logged */
> -	tmp_index =3D new_part->index + NVRAM_HEADER_LEN;
> -	rc =3D ppc_md.nvram_write((char *)&seq_init, sizeof(seq_init), &tmp_ind=
ex);
> -	if (rc <=3D 0) {
> -		printk(KERN_ERR "nvram_create_os_partition: nvram_write "
> -		       "failed (%d)\n", rc);
> -		return rc;
> +	/* Clear the partition */
> +	for (tmp_index =3D new_part->index + NVRAM_HEADER_LEN;
> +	     tmp_index <  ((size - 1) * NVRAM_BLOCK_LEN);
                          ^
Extra whitespace          |

cheers


--=-uUZLRpHPIjd4HjZ6h7Yj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkxWQI0ACgkQdSjSd0sB4dKt1wCgrbasRI0Rs8aRm79NqWYbsOYx
TecAmQHVLSjPPm03TAhwN6DPUyk2TD74
=mCNg
-----END PGP SIGNATURE-----

--=-uUZLRpHPIjd4HjZ6h7Yj--
