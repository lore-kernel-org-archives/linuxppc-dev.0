Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] [v3] powerpc/4xx: work around CHIP11 errata in a more
	PAGE_SIZE-friendly way
From: Michael Ellerman <michael@ellerman.id.au>
To: Hollis Blanchard <hollisb@us.ibm.com>
In-Reply-To: <1227557235.17746.25.camel@localhost.localdomain>
References: <4b6790c7a989dce8c200000687275224@bga.com>
	<84e16946c1ed4b782568f6492931512a@bga.com>
	<200811141609.44161.hollisb@us.ibm.com>
	<1227557235.17746.25.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-QTZOR8VqaJtq43VWoXMH"
Date: Tue, 25 Nov 2008 11:10:28 +1100
Message-Id: <1227571828.20022.5.camel@localhost>
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


--=-QTZOR8VqaJtq43VWoXMH
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-11-24 at 14:07 -0600, Hollis Blanchard wrote:
> On Fri, 2008-11-14 at 16:09 -0600, Hollis Blanchard wrote:
> >=20
> > If this is all too much, then I'm close to giving up and burning a
> > 64KB page, which requires only ALIGN_DOWN() in the kernel.
>=20
> ppc: force memory size to be a multiple of PAGE_SIZE
>=20
> Ensure that total memory size is page-aligned, because otherwise
> bootmem.c gets upset.
>=20
> This error case was triggered by using 64 KiB pages in the kernel while
> arch/powerpc/boot/4xx.c arbitrarily reduced the amount of memory by 4096 =
(to
> work around the "CHIP11" errata which affects the last 256 bytes of physi=
cal memory).
>=20
> Signed-off-by: Hollis Blanchard <hollisb@us.ibm.com>
> ---
> This is on a common code path, and lmb_enforce_memory_limit() will now
> always take action, so wider testing would be good.
>=20
> This patch supercedes http://patchwork.ozlabs.org/patch/8211/ .
>=20
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -1200,6 +1200,11 @@ void __init early_init_devtree(void *par
>  	early_reserve_mem();
>  	phyp_dump_reserve_mem();
> =20
> +	/* Ensure that total memory size is page-aligned, because otherwise
> +	 * bootmem.c gets upset. */
> +	lmb_analyze();
> +	memory_limit =3D lmb_phys_mem_size() & PAGE_MASK;

All of the current code using memory_limit looks like it'll be safe with
this change, although there are several cases of this we could remove:

if (memory_limit && <some other condition>)

Because memory_limit will now always be true.

Still, I think it would be better to only set memory_limit when the mem
size is not a multiple of the PAGE_SIZE - so that memory_limit retains
it's function as both the value of the limit and a boolean.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-QTZOR8VqaJtq43VWoXMH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkrQnQACgkQdSjSd0sB4dL5tQCfZwshklvLovD4NiD/ULTft8Oy
8pEAniVaRA2e4KwsbQURYITR/fvqOABC
=QGFM
-----END PGP SIGNATURE-----

--=-QTZOR8VqaJtq43VWoXMH--
