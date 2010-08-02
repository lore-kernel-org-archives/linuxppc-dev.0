Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 02/11] powerpc/nvram: More flexible
	nvram_create_partition()
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1280710522-6362-3-git-send-email-benh@kernel.crashing.org>
References: <1280710522-6362-1-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-2-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-3-git-send-email-benh@kernel.crashing.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-cCqduK7Dh7yllG1vHQdD"
Date: Mon, 02 Aug 2010 13:43:27 +1000
Message-ID: <1280720607.2491.175.camel@concordia>
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


--=-cCqduK7Dh7yllG1vHQdD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2010-08-02 at 10:55 +1000, Benjamin Herrenschmidt wrote:
> Replace nvram_create_os_partition() with a variant that takes
> the partition name, signature and size as arguments.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/kernel/nvram_64.c         |   46 +++++++++++++++++++-------=
-----
>  arch/powerpc/platforms/pseries/nvram.c |    6 ++--
>  2 files changed, 31 insertions(+), 21 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_6=
4.c
> index a8154f1..974b3ec 100644
> --- a/arch/powerpc/kernel/nvram_64.c
> +++ b/arch/powerpc/kernel/nvram_64.c
> @@ -307,13 +307,15 @@ static int __init nvram_remove_os_partition(void)
>  	return 0;
>  }
> =20
> -/* nvram_create_os_partition
> - *
> - * Create a OS linux partition to buffer error logs.
> - * Will create a partition starting at the first free
> - * space found if space has enough room.
> +/**
> + * nvram_create_partition - Create a partition in nvram
> + * @name: name of the partition to create
> + * @sig: signature of the partition to create
> + * @req_size: size to allocate preferrably
> + * @min_size: minimum acceptable size (0 means req_size)
>   */
> -static int __init nvram_create_os_partition(void)
> +static int __init nvram_create_partition(const char *name, int sig,
> +					 int req_size, int min_size)
>  {
>  	struct nvram_partition *part;
>  	struct nvram_partition *new_part;
> @@ -322,20 +324,27 @@ static int __init nvram_create_os_partition(void)
>  	loff_t tmp_index;
>  	long size =3D 0;
>  	int rc;
> -=09
> +
> +	/* If no minimum size specified, make it the same as the
> +	 * requested size
> +	 */
> +	if (min_size =3D=3D 0)
> +		min_size =3D req_size;
> +
>  	/* Find a free partition that will give us the maximum needed size=20
>  	   If can't find one that will give us the minimum size needed */
>  	list_for_each_entry(part, &nvram_part->partition, partition) {
>  		if (part->header.signature !=3D NVRAM_SIG_FREE)
>  			continue;
> =20
> -		if (part->header.length >=3D NVRAM_MAX_REQ) {
> -			size =3D NVRAM_MAX_REQ;
> +		if (part->header.length >=3D req_size) {
> +			size =3D req_size;
>  			free_part =3D part;
>  			break;
>  		}
> -		if (!size && part->header.length >=3D NVRAM_MIN_REQ) {
> -			size =3D NVRAM_MIN_REQ;
> +		if (part->header.length > size &&
> +		    part->header.length >=3D min_size) {
> +			size =3D part->header.length;
>  			free_part =3D part;
>  		}

I can't quite convince myself that this is right, but perhaps I just
need a coffee.

> @@ -350,9 +359,9 @@ static int __init nvram_create_os_partition(void)
>  	}
> =20
>  	new_part->index =3D free_part->index;
> -	new_part->header.signature =3D NVRAM_SIG_OS;
> +	new_part->header.signature =3D sig;
>  	new_part->header.length =3D size;
> -	strcpy(new_part->header.name, "ppc64,linux");
> +	strncpy(new_part->header.name, name, 12);

Should we be checking the name fits?

>  	new_part->header.checksum =3D nvram_checksum(&new_part->header);
> =20
>  	rc =3D nvram_write_header(new_part);
> @@ -451,10 +460,10 @@ static int __init nvram_setup_partition(void)
>  	}
>  =09
>  	/* try creating a partition with the free space we have */
> -	rc =3D nvram_create_partition("ppc64,linux", );

That looks odd? Trailing comma.

> -	if (!rc) {
> +	rc =3D 	nvram_create_partition("ppc64,linux", NVRAM_SIG_OS,
> +				       NVRAM_MIN_REQ, NVRAM_MAX_REQ);

Odd whitespace.

> +	if (!rc)
>  		return 0;
> -	}
>  	=09
>  	/* need to free up some space */
>  	rc =3D nvram_remove_os_partition();
> @@ -463,9 +472,10 @@ static int __init nvram_setup_partition(void)
>  	}
>  =09
>  	/* create a partition in this new space */
> -	rc =3D nvram_create_os_partition();
> +	rc =3D 	nvram_create_partition("ppc64,linux", NVRAM_SIG_OS,
> +				       NVRAM_MIN_REQ, NVRAM_MAX_REQ);

And again.

>  	if (rc) {
> -		printk(KERN_ERR "nvram_create_os_partition: Could not find a "
> +		printk(KERN_ERR "nvram_create_partition: Could not find a "
>  		       "NVRAM partition large enough\n");

pr_err("%s: ..", __func__, ..) if you're touching it anyway?

> diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platfo=
rms/pseries/nvram.c
> index f4e4c06..2a1ef5c 100644
> --- a/arch/powerpc/platforms/pseries/nvram.c
> +++ b/arch/powerpc/platforms/pseries/nvram.c
> @@ -22,14 +22,14 @@
>  #include <asm/prom.h>
>  #include <asm/machdep.h>
> =20
> +/* Max bytes to read/write in one go */
> +#define NVRW_CNT 0x20
> +
>  static unsigned int nvram_size;
>  static int nvram_fetch, nvram_store;
>  static char nvram_buf[NVRW_CNT];	/* assume this is in the first 4GB */
>  static DEFINE_SPINLOCK(nvram_lock);
> =20
> -/* Max bytes to read/write in one go */
> -#define NVRW_CNT 0x20
> -

Churn alert, you just moved that hunk there in the previous patch.

cheers



--=-cCqduK7Dh7yllG1vHQdD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkxWPt8ACgkQdSjSd0sB4dJE2QCgzNw0dejgxg8ggaOvZ2NerS2r
pkIAoMJq5rAineMe6MS0ZC2LDTAxo2h4
=sUZi
-----END PGP SIGNATURE-----

--=-cCqduK7Dh7yllG1vHQdD--
