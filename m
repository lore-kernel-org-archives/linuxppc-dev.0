Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 99EEADDE00
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 19:47:49 +1000 (EST)
Subject: Re: [PATCH] Treat ISI faults as read faults on classic 32-bit PowerPC
From: Johannes Berg <johannes@sipsolutions.net>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <5d56173bee3f9ea0050aa508e7f27cc932af7229.1184104284.git.segher@kernel.crashing.org>
References: <5d56173bee3f9ea0050aa508e7f27cc932af7229.1184104284.git.segher@kernel.crashing.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-R0d+NrjLgoU+BjdnJLSg"
Date: Thu, 12 Jul 2007 11:47:52 +0200
Message-Id: <1184233672.6669.21.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-R0d+NrjLgoU+BjdnJLSg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-07-11 at 20:18 +0200, Segher Boessenkool wrote:
> Some old software on ppc32 executes from pages it hasn't marked
> executable.  Since "classic" hardware doesn't distinguish between
> execute and read accesses, the do_page_fault() code shouldn't
> either.  This makes glibc-2.2 work again on such hardware.
>=20
> Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
> Cc: Scott Wood <scottwood@freescale.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> ---
> Tested by Scott on 32-bit, glibc-2.2.5 and glibc-2.3.3 (no new
> failures and problem solved), needs confirmation from Johannes
> on his glibc-2.4 "---p" testcase.  Could use testing on ppc64
> and BookE too, for good measure.

Acked-by: Johannes Berg <johannes@sipsolutions.net>

I tested this patch and it does fix the problem I was seeing.

> This reverts the previous change and makes the bugfix behave
> more like the arch/ppc code.
>  arch/powerpc/mm/fault.c |   14 ++++++++++----
>  1 files changed, 10 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 115b25f..5d7add0 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -278,14 +278,17 @@ good_area:
>  		goto bad_area;
>  #endif /* CONFIG_8xx */
> =20
> +#ifdef CONFIG_PPC64
>  	if (is_exec) {
> -#if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
>  		/* protection fault */
>  		if (error_code & DSISR_PROTFAULT)
>  			goto bad_area;
>  		if (!(vma->vm_flags & VM_EXEC))
>  			goto bad_area;
> -#else
> +	} else
> +		/* A read or write, code continues below...  */
> +#elsif defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
> +	if (is_exec) {
>  		pte_t *ptep;
>  		pmd_t *pmdp;
> =20
> @@ -310,9 +313,12 @@ good_area:
>  			}
>  			pte_unmap_unlock(ptep, ptl);
>  		}
> +	} else
> +		/* A read or write, code continues below...  */
>  #endif
> -	/* a write */
> -	} else if (is_write) {
> +
> +	/* A read or write.  Classic PPC32 execute is considered a read.  */
> +	if (is_write) {
>  		if (!(vma->vm_flags & VM_WRITE))
>  			goto bad_area;
>  	/* a read */

--=-R0d+NrjLgoU+BjdnJLSg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGlfjH/ETPhpq3jKURAvy9AJ9A/qFGKiJwqH8PCoVF//ZPtQYCDwCgm3sU
A0L1sj4vlP9Y/UnXuzdPK7E=
=pXwj
-----END PGP SIGNATURE-----

--=-R0d+NrjLgoU+BjdnJLSg--
