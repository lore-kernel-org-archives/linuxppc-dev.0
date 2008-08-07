Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 6/8] powerpc: set up OF properties for ppc32 kdump
From: Michael Ellerman <michael@ellerman.id.au>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080801141425.GF1161@polina.dev.rtsoft.ru>
References: <20080801141306.GA29127@polina.dev.rtsoft.ru>
	<20080801141425.GF1161@polina.dev.rtsoft.ru>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-V+k8D+APz1WPMvwLfdbr"
Date: Thu, 07 Aug 2008 20:47:31 +1000
Message-Id: <1218106051.7914.12.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-V+k8D+APz1WPMvwLfdbr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2008-08-01 at 18:14 +0400, Anton Vorontsov wrote:
> From: Dale Farnsworth <dale@farnsworth.org>
>=20
> Refactor the setting of kexec OF properties, moving the common code
> from machine_kexec_64.c to machine_kexec.c where it can be used on
> both ppc64 and ppc32.  This will be needed for kdump to work on ppc32
> platforms.

Hi Anton,

> diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/ma=
chine_kexec.c
> index ac42cfb..bfef717 100644
> --- a/arch/powerpc/kernel/machine_kexec.c
> +++ b/arch/powerpc/kernel/machine_kexec.c
> @@ -117,6 +117,7 @@ int overlaps_crashkernel(unsigned long start, unsigne=
d long size)
> =20

>  static int __init kexec_setup(void)
>  {
>  	struct device_node *node;
> @@ -135,6 +171,8 @@ static int __init kexec_setup(void)
>  	kernel_end =3D __pa(_end);
>  	prom_add_property(node, &kernel_end_prop);
> =20
> +	export_crashk_values(node);
> +
>  	of_node_put(node);
>  	return 0;
>  }
> diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel=
/machine_kexec_64.c
> index c30678d..2aab296 100644
> --- a/arch/powerpc/kernel/machine_kexec_64.c
> +++ b/arch/powerpc/kernel/machine_kexec_64.c
...

> -
>  static int __init kexec_setup(void)
>  {
>  	export_htab_values();
> -	export_crashk_values();
>  	return 0;
>  }
>  __initcall(kexec_setup);

This leaves us with two routines called kexec_setup(), do you mind
getting rid of this one and making export_htab_values() an initcall
directly.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-V+k8D+APz1WPMvwLfdbr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBImtLDdSjSd0sB4dIRAhQhAKDAbH/uceFvDwBz0CzVCme7QloWAwCgnaGE
nxg+Iv79fBhm3y2viIEaw4Q=
=LJgh
-----END PGP SIGNATURE-----

--=-V+k8D+APz1WPMvwLfdbr--
