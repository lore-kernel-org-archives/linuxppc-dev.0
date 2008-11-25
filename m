Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] [v3] powerpc/4xx: work around CHIP11 errata in a more
	PAGE_SIZE-friendly way
From: Michael Ellerman <michael@ellerman.id.au>
To: Hollis Blanchard <hollisb@us.ibm.com>
In-Reply-To: <1227650039.7434.33.camel@localhost.localdomain>
References: <4b6790c7a989dce8c200000687275224@bga.com>
	<84e16946c1ed4b782568f6492931512a@bga.com>
	<200811141609.44161.hollisb@us.ibm.com>
	<1227557235.17746.25.camel@localhost.localdomain>
	<1227571828.20022.5.camel@localhost>
	<1227650039.7434.33.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-5hM8IVVniPYXfVqhGecf"
Date: Wed, 26 Nov 2008 10:43:51 +1100
Message-Id: <1227656631.8016.4.camel@localhost>
Mime-Version: 1.0
Cc: Milton Miller <miltonm@bga.com>, Wolfgang Denk <wd@denx.de>,
	Ilya Yanok <yanok@emcraft.com>, linux-ppc <linuxppc-dev@ozlabs.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-5hM8IVVniPYXfVqhGecf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-11-25 at 15:53 -0600, Hollis Blanchard wrote:
> On Tue, 2008-11-25 at 11:10 +1100, Michael Ellerman wrote:
> >=20
> > Still, I think it would be better to only set memory_limit when the mem
> > size is not a multiple of the PAGE_SIZE - so that memory_limit retains
> > it's function as both the value of the limit and a boolean.
>=20
> OK, how's this?
>=20
> ppc: force memory size to be a multiple of PAGE_SIZE
>=20
> Ensure that total memory size is page-aligned, because otherwise
> mark_bootmem() gets upset.
>=20
> This error case was triggered by using 64 KiB pages in the kernel while
> arch/powerpc/boot/4xx.c arbitrarily reduced the amount of memory by 4096 =
(to
> work around a chip bug that affects the last 256 bytes of physical memory=
).
>=20
> Signed-off-by: Hollis Blanchard <hollisb@us.ibm.com>
>=20
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -1160,6 +1160,8 @@ static inline void __init phyp_dump_rese
> =20
>  void __init early_init_devtree(void *params)
>  {
> +	unsigned long limit, memsize;
> +
>  	DBG(" -> early_init_devtree(%p)\n", params);
> =20
>  	/* Setup flat device-tree pointer */
> @@ -1200,7 +1202,15 @@ void __init early_init_devtree(void *par
>  	early_reserve_mem();
>  	phyp_dump_reserve_mem();

I was thinking more like the following:

> =20
> -	lmb_enforce_memory_limit(memory_limit);
> +	limit =3D memory_limit;
> +	if (! limit) {
> +		/* Ensure that total memory size is page-aligned, because
> +		 * otherwise mark_bootmem() gets upset. */
> +		lmb_analyze();
                  memsize =3D lmb_phys_mem_size();
		  if(memsize & PAGE_MASK !=3D memsize)
		        limit =3D memsize & PAGE_MASK;
> +	}
> +	lmb_enforce_memory_limit(limit);
> +

So that we never needlessly run through the enforce code with limit =3D
memsize. But maybe it's a bit pedantic.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-5hM8IVVniPYXfVqhGecf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkksjbcACgkQdSjSd0sB4dKRFgCguX0dpz3m2ArYPvWJJtNhw3B7
ys4An3xFJLI+hi9Mg36nxcrdB6mMP6TN
=lTzk
-----END PGP SIGNATURE-----

--=-5hM8IVVniPYXfVqhGecf--
