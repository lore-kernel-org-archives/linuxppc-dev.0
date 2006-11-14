Return-Path: <michael@ellerman.id.au>
Subject: Re: [POWERPC] iSeries: fix slb.c for combined build
From: Michael Ellerman <michael@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20061114125738.8c1dad0d.sfr@canb.auug.org.au>
References: <20061113144918.84647810.sfr@canb.auug.org.au>
	<20061113010330.1d821876@pb15>
	<20061114125738.8c1dad0d.sfr@canb.auug.org.au>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-W6qCSSKzTYzK0KfkvAqK"
Date: Tue, 14 Nov 2006 13:03:25 +1100
Message-Id: <1163469805.8048.56.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, ppc-dev <linuxppc-dev@ozlabs.org>,
	paulus@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-W6qCSSKzTYzK0KfkvAqK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-11-14 at 12:57 +1100, Stephen Rothwell wrote:
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/powerpc/mm/slb.c |   13 ++++++-------
>  1 files changed, 6 insertions(+), 7 deletions(-)
>=20
> This version takes into account Olof's comment.

It's not clear from that patch that you haven't altered the logic for !
ISERIES, but I'll take your word for it ;)

cheers

> --=20
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
>=20
> diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
> index d373391..224e960 100644
> --- a/arch/powerpc/mm/slb.c
> +++ b/arch/powerpc/mm/slb.c
> @@ -23,6 +23,7 @@
>  #include <asm/cputable.h>
>  #include <asm/cacheflush.h>
>  #include <asm/smp.h>
> +#include <asm/firmware.h>
>  #include <linux/compiler.h>
> =20
>  #ifdef DEBUG
> @@ -193,6 +194,7 @@ static inline void patch_slb_encoding(un
>  void slb_initialize(void)
>  {
>  	unsigned long linear_llp, vmalloc_llp, io_llp;
> +	unsigned long lflags, vflags;
>  	static int slb_encoding_inited;
>  	extern unsigned int *slb_miss_kernel_load_linear;
>  	extern unsigned int *slb_miss_kernel_load_io;
> @@ -225,11 +227,12 @@ void slb_initialize(void)
>  #endif
>  	}
> =20
> +	get_paca()->stab_rr =3D SLB_NUM_BOLTED;
> +
>  	/* On iSeries the bolted entries have already been set up by
>  	 * the hypervisor from the lparMap data in head.S */
> -#ifndef CONFIG_PPC_ISERIES
> - {
> -	unsigned long lflags, vflags;
> +	if (firmware_has_feature(FW_FEATURE_ISERIES))
> +		return;
> =20
>  	lflags =3D SLB_VSID_KERNEL | linear_llp;
>  	vflags =3D SLB_VSID_KERNEL | vmalloc_llp;
> @@ -247,8 +250,4 @@ void slb_initialize(void)
>  	 * elsewhere, we'll call _switch() which will bolt in the new
>  	 * one. */
>  	asm volatile("isync":::"memory");
> - }
> -#endif /* CONFIG_PPC_ISERIES */
> -
> -	get_paca()->stab_rr =3D SLB_NUM_BOLTED;
>  }
--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-W6qCSSKzTYzK0KfkvAqK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFWSPtdSjSd0sB4dIRAjTqAKDAQEJyaEkfX+6gE1HmpVlwLA34tQCgjPYU
iYwweXcyeyVEOG1W9sXosuA=
=7C03
-----END PGP SIGNATURE-----

--=-W6qCSSKzTYzK0KfkvAqK--
