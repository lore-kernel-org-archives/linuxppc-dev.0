Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH]: wrap cpu_die() with CONFIG_HOTPLUG_CPU
From: Michael Ellerman <michael@ellerman.id.au>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20061115185743.GH8395@austin.ibm.com>
References: <20061115185743.GH8395@austin.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-CakIupSoEpsjrNBM6ajl"
Date: Thu, 16 Nov 2006 10:58:45 +1100
Message-Id: <1163635125.8805.6.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Srinivasa Ds <srinivasa@in.ibm.com>,
	Nathan Lynch <ntl@pobox.com>, paulus@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-CakIupSoEpsjrNBM6ajl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-11-15 at 12:57 -0600, Linas Vepstas wrote:
>=20
> Paul,
>=20
> Please apply the janitorial patch below. Its not urgent.
> It replaces/obsoletes the previous Subject: [PATCH]:=20
> PowerPC: make sure the rtas stop-self token is defined.
> patch.
>=20
> --linas
>=20
> Per email discussion, it appears that rtas_stop_self()
> and pSeries_mach_cpu_die() should not be compiled if=20
> CONFIG_HOTPLUG_CPU is not defined. This patch adds
> #ifdefs around these bits of code.
>=20
> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>


Thanks for writing it up as a patch. Couple of nit-picky comments below:

> Index: linux-2.6.19-rc4-git3/include/asm-powerpc/rtas.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.19-rc4-git3.orig/include/asm-powerpc/rtas.h	2006-11-01 16:1=
5:46.000000000 -0600
> +++ linux-2.6.19-rc4-git3/include/asm-powerpc/rtas.h	2006-11-15 11:44:24.=
000000000 -0600
> @@ -54,8 +54,6 @@ struct rtas_args {
>  	rtas_arg_t *rets;     /* Pointer to return values in args[]. */
>  }; =20
> =20
> -extern struct rtas_args rtas_stop_self_args;
> -
>  struct rtas_t {
>  	unsigned long entry;		/* physical address pointer */
>  	unsigned long base;		/* physical address pointer */
> @@ -223,7 +221,9 @@ extern int rtas_get_error_log_max(void);
>  extern spinlock_t rtas_data_buf_lock;
>  extern char rtas_data_buf[RTAS_DATA_BUF_SIZE];
> =20
> +#ifdef CONFIG_HOTPLUG_CPU
>  extern void rtas_stop_self(void);
> +#endif

I think we usually don't bother with #ifdef'ing externs, unless you're
providing a no-op implementation for the !CONFIG_FOO case.
=20
>  /* RMO buffer reserved for user-space RTAS use */
>  extern unsigned long rtas_rmo_buf;
> Index: linux-2.6.19-rc4-git3/arch/powerpc/platforms/pseries/setup.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.19-rc4-git3.orig/arch/powerpc/platforms/pseries/setup.c	200=
6-11-01 16:15:09.000000000 -0600
> +++ linux-2.6.19-rc4-git3/arch/powerpc/platforms/pseries/setup.c	2006-11-=
15 11:46:10.000000000 -0600
> @@ -347,6 +347,7 @@ static int __init pSeries_init_panel(voi
>  }
>  arch_initcall(pSeries_init_panel);
> =20
> +#ifdef CONFIG_HOTPLUG_CPU
>  static void pSeries_mach_cpu_die(void)
>  {
>  	local_irq_disable();
> @@ -357,6 +358,7 @@ static void pSeries_mach_cpu_die(void)
>  	BUG();
>  	for(;;);
>  }
  +#else
   #define pSeries_mach_cpu_die NULL
> +#endif

Not sure if that's a good idea, it would save the #ifdef around the
structure assignment below.

>  static int pseries_set_dabr(unsigned long dabr)
>  {
> @@ -558,7 +560,9 @@ define_machine(pseries) {
>  	.power_off		=3D rtas_power_off,
>  	.halt			=3D rtas_halt,
>  	.panic			=3D rtas_os_term,
> +#ifdef CONFIG_HOTPLUG_CPU
>  	.cpu_die		=3D pSeries_mach_cpu_die,
> +#endif
>  	.get_boot_time		=3D rtas_get_boot_time,
>  	.get_rtc_time		=3D rtas_get_rtc_time,
>  	.set_rtc_time		=3D rtas_set_rtc_time,

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-CakIupSoEpsjrNBM6ajl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFW6m0dSjSd0sB4dIRAkFFAJ98KuMi6FWsCWFyekHsjUsFD+5NdgCgmDL1
GXslg4hLGD1cSmNUIdK+cZY=
=zQga
-----END PGP SIGNATURE-----

--=-CakIupSoEpsjrNBM6ajl--
