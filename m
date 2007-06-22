Return-Path: <michael@ellerman.id.au>
Subject: Re: Move iSeries_tb_recal from do_settimeofday() into it's own
	late_initcall.
From: Michael Ellerman <michael@ellerman.id.au>
To: Tony Breeds <tony@bakeyournoodle.com>
In-Reply-To: <20070622054324.GV9768@bakeyournoodle.com>
References: <20070622054324.GV9768@bakeyournoodle.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-addJEiHTjse1xSN8yMv2"
Date: Fri, 22 Jun 2007 16:13:56 +1000
Message-Id: <1182492836.5760.10.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-addJEiHTjse1xSN8yMv2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-06-22 at 15:43 +1000, Tony Breeds wrote:
> Move iSeries_tb_recal from do_settimeofday() into it's own late_initcall.
>=20
> Currently iSeries will recalibrate the cputime_factors, from the first
> settimeofday() call.
>=20
> It seems the reason for doing this is to ensure a resaonable time delta a=
fter
> time_init().  On current kernels (with udev), this call is made 40-60 sec=
onds
> into the boot process, by moving it to a late initcall it is called
> approximately 5 seconds after time_init() is called.  This is sufficient =
to
> recalibrate the timebase.

Gutsy :)

The safer option would be to have the init call schedule work for 40-60
seconds after boot, but it's up to you :)

>=20
>=20
>=20
> Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
> CC: Stephen Rothwell <sfr@canb.auug.org.au>
>=20
> ---
>=20
>  arch/powerpc/kernel/time.c             |   30 +++++++++++++++----------
>  arch/powerpc/platforms/iseries/setup.c |    7 +----
>  include/asm-powerpc/time.h             |    4 +++
>  3 files changed, 25 insertions(+), 16 deletions(-)
>=20
> Index: working/arch/powerpc/kernel/time.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- working.orig/arch/powerpc/kernel/time.c	2007-06-22 11:02:24.000000000=
 +1000
> +++ working/arch/powerpc/kernel/time.c	2007-06-22 11:40:44.000000000 +100=
0
> @@ -77,9 +77,8 @@
>  /* keep track of when we need to update the rtc */
>  time_t last_rtc_update;
>  #ifdef CONFIG_PPC_ISERIES
> -unsigned long iSeries_recal_titan =3D 0;
> -unsigned long iSeries_recal_tb =3D 0;=20
> -static unsigned long first_settimeofday =3D 1;
> +static unsigned long __initdata iSeries_recal_titan;
> +static signed long __initdata iSeries_recal_tb;
>  #endif

While you're at it, can you de-camelcase the names? Same comment
elsewhere.

>  /* The decrementer counts down by 128 every 128ns on a 601. */
> @@ -551,10 +550,15 @@ EXPORT_SYMBOL(profile_pc);
>   * returned by the service processor for the timebase frequency. =20
>   */
> =20
> -static void iSeries_tb_recal(void)
> +static int __init iSeries_tb_recal(void)
>  {
>  	struct div_result divres;
>  	unsigned long titan, tb;
> +
> +	/* Make sure we only run on iSeries */
> +	if (!firmware_has_feature(FW_FEATURE_ISERIES))
> +		return -ENODEV;

Is ENODEV the magic "init-call didn't actually fail" value? You don't
want anything in the log.

> +
>  	tb =3D get_tb();
>  	titan =3D HvCallXm_loadTod();
>  	if ( iSeries_recal_titan ) {
> @@ -595,8 +599,18 @@ static void iSeries_tb_recal(void)
>  	}
>  	iSeries_recal_titan =3D titan;
>  	iSeries_recal_tb =3D tb;
> +
> +	return 0;
>  }
> -#endif
> +late_initcall(iSeries_tb_recal);
> +
> +/* Called from platforms/iseries/setup.c:iSeries_init_early() */

The comment is only going to be wrong once someone moves something
around. Better still, why not put this code in setup.c?

> +void __init iSeries_time_init_early(void)
> +{
> +	iSeries_recal_tb =3D get_tb();
> +	iSeries_recal_titan =3D HvCallXm_loadTod();
> +}
> +#endif /* CONFIG_PPC_ISERIES */
> =20
>  /*
>   * For iSeries shared processors, we have to let the hypervisor
> @@ -760,12 +774,6 @@ int do_settimeofday(struct timespec *tv)
>  	 * to the RTC again, or write to the RTC but then they don't call
>  	 * settimeofday to perform this operation.
>  	 */
> -#ifdef CONFIG_PPC_ISERIES
> -	if (firmware_has_feature(FW_FEATURE_ISERIES) && first_settimeofday) {
> -		iSeries_tb_recal();
> -		first_settimeofday =3D 0;
> -	}
> -#endif
> =20
>  	/* Make userspace gettimeofday spin until we're done. */
>  	++vdso_data->tb_update_count;
> Index: working/arch/powerpc/platforms/iseries/setup.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- working.orig/arch/powerpc/platforms/iseries/setup.c	2007-06-22 11:02:=
42.000000000 +1000
> +++ working/arch/powerpc/platforms/iseries/setup.c	2007-06-22 11:10:04.00=
0000000 +1000
> @@ -79,8 +79,6 @@ extern void iSeries_pci_final_fixup(void
>  static void iSeries_pci_final_fixup(void) { }
>  #endif
> =20
> -extern unsigned long iSeries_recal_tb;
> -extern unsigned long iSeries_recal_titan;
> =20
>  struct MemoryBlock {
>  	unsigned long absStart;
> @@ -292,9 +290,8 @@ static void __init iSeries_init_early(vo
>  {
>  	DBG(" -> iSeries_init_early()\n");
> =20
> -	iSeries_recal_tb =3D get_tb();
> -	iSeries_recal_titan =3D HvCallXm_loadTod();
> -
> +	/* Snapshot the timebase, for use in later recalibration */
> +	iSeries_time_init_early();

Newline here please :)

>  	/*
>  	 * Initialize the DMA/TCE management
>  	 */
> Index: working/include/asm-powerpc/time.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- working.orig/include/asm-powerpc/time.h	2007-06-22 11:03:37.000000000=
 +1000
> +++ working/include/asm-powerpc/time.h	2007-06-22 11:40:59.000000000 +100=
0
> @@ -240,5 +240,9 @@ extern void snapshot_timebases(void);
>  #define snapshot_timebases()			do { } while (0)
>  #endif
> =20
> +#ifdef CONFIG_PPC_ISERIES
> +extern void iSeries_time_init_early(void);
> +#endif

I don't think we bother with #ifdef around externs, unless you're
providing a no-op version.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-addJEiHTjse1xSN8yMv2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGe2ikdSjSd0sB4dIRAqMxAKCcHumrxICzLJUDp7M29zUV7trVYwCdF2A9
RNGnHtFygQ25kE+Xu8m3Ag4=
=5Xcx
-----END PGP SIGNATURE-----

--=-addJEiHTjse1xSN8yMv2--
