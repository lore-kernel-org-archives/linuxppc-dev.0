Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zBC4r75lLzF0Pl
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jan 2018 11:49:48 +1100 (AEDT)
Date: Wed, 3 Jan 2018 11:49:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] powerpc/pseries,ps3: panic flush kernel messages
 before halting system
Message-ID: <20180103004943.GK24581@umbus.fritz.box>
References: <20171223164923.10587-1-npiggin@gmail.com>
 <20171223164923.10587-3-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GvuyDaC2GNSBQusT"
In-Reply-To: <20171223164923.10587-3-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--GvuyDaC2GNSBQusT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 24, 2017 at 02:49:23AM +1000, Nicholas Piggin wrote:
> Platforms with a panic handler that halts the system can have problems
> getting kernel messages out, because the panic notifiers are called
> before kernel/panic.c does its flushing of printk buffers an console
> etc.
>=20
> This was attempted to be solved with commit a3b2cb30f252 ("powerpc: Do
> not call ppc_md.panic in fadump panic notifier"), but that wasn't the
> right approach and caused other problems, and was reverted by commit
> ab9dbf771ff9.
>=20
> Instead, the powernv shutdown paths have already had a similar
> problem, fixed by taking the message flushing sequence from
> kernel/panic.c. That's a little bit ugly, but while we have the code
> duplicated, it will work for this case as well. So have ppc panic
> handlers do the same flushing before they terminate.
>=20
> Without this patch, a qemu pseries_le_defconfig guest stops silently
> when issued the nmi command when xmon is off and no crash dumpers
> enabled. Afterwards, an oops is printed by each CPU as expected.
>=20
> Fixes: ab9dbf771ff9 ("Revert "powerpc: Do not call ppc_md.panic in fadump=
 panic notifier"")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/include/asm/bug.h         |  3 ++-
>  arch/powerpc/kernel/traps.c            | 24 ++++++++++++++++++++++++
>  arch/powerpc/platforms/powernv/opal.c  | 18 ++++--------------
>  arch/powerpc/platforms/ps3/setup.c     |  1 +
>  arch/powerpc/platforms/pseries/setup.c |  8 +++++++-
>  5 files changed, 38 insertions(+), 16 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bu=
g.h
> index 3c04249bcf39..bca101ee1f32 100644
> --- a/arch/powerpc/include/asm/bug.h
> +++ b/arch/powerpc/include/asm/bug.h
> @@ -135,7 +135,8 @@ extern void bad_page_fault(struct pt_regs *, unsigned=
 long, int);
>  extern void _exception(int, struct pt_regs *, int, unsigned long);
>  extern void die(const char *, struct pt_regs *, long);
>  extern bool die_will_crash(void);
> -
> +extern void panic_flush_kmsg_start(void);
> +extern void panic_flush_kmsg_end(void);
>  #endif /* !__ASSEMBLY__ */
> =20
>  #endif /* __KERNEL__ */
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 109989676776..37c1ea9b0642 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -38,6 +38,8 @@
>  #include <linux/ratelimit.h>
>  #include <linux/context_tracking.h>
>  #include <linux/smp.h>
> +#include <linux/console.h>
> +#include <linux/kmsg_dump.h>
> =20
>  #include <asm/emulated_ops.h>
>  #include <asm/pgtable.h>
> @@ -142,6 +144,28 @@ static int die_owner =3D -1;
>  static unsigned int die_nest_count;
>  static int die_counter;
> =20
> +extern void panic_flush_kmsg_start(void)
> +{
> +	/*
> +	 * These are mostly taken from kernel/panic.c, but tries to do
> +	 * relatively minimal work. Don't use delay functions (TB may
> +	 * be broken), don't crash dump (need to set a firmware log),
> +	 * don't run notifiers. We do want to get some information to
> +	 * Linux console.
> +	 */
> +	console_verbose();
> +	bust_spinlocks(1);
> +}
> +
> +extern void panic_flush_kmsg_end(void)
> +{
> +	printk_safe_flush_on_panic();
> +	kmsg_dump(KMSG_DUMP_PANIC);
> +	bust_spinlocks(0);
> +	debug_locks_off();
> +	console_flush_on_panic();
> +}
> +
>  static unsigned long oops_begin(struct pt_regs *regs)
>  {
>  	int cpu;
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platfor=
ms/powernv/opal.c
> index 69b5263fc9e3..c15182765ff5 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -461,24 +461,14 @@ static int opal_recover_mce(struct pt_regs *regs,
> =20
>  void pnv_platform_error_reboot(struct pt_regs *regs, const char *msg)
>  {
> -	/*
> -	 * This is mostly taken from kernel/panic.c, but tries to do
> -	 * relatively minimal work. Don't use delay functions (TB may
> -	 * be broken), don't crash dump (need to set a firmware log),
> -	 * don't run notifiers. We do want to get some information to
> -	 * Linux console.
> -	 */
> -	console_verbose();
> -	bust_spinlocks(1);
> +	panic_flush_kmsg_start();
> +
>  	pr_emerg("Hardware platform error: %s\n", msg);
>  	if (regs)
>  		show_regs(regs);
>  	smp_send_stop();
> -	printk_safe_flush_on_panic();
> -	kmsg_dump(KMSG_DUMP_PANIC);
> -	bust_spinlocks(0);
> -	debug_locks_off();
> -	console_flush_on_panic();
> +
> +	panic_flush_kmsg_end();
> =20
>  	/*
>  	 * Don't bother to shut things down because this will
> diff --git a/arch/powerpc/platforms/ps3/setup.c b/arch/powerpc/platforms/=
ps3/setup.c
> index 6244bc849469..77a37520068d 100644
> --- a/arch/powerpc/platforms/ps3/setup.c
> +++ b/arch/powerpc/platforms/ps3/setup.c
> @@ -113,6 +113,7 @@ static void ps3_panic(char *str)
>  	printk("   System does not reboot automatically.\n");
>  	printk("   Please press POWER button.\n");
>  	printk("\n");
> +	panic_flush_kmsg_end();
> =20
>  	while(1)
>  		lv1_pause(1);
> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platfo=
rms/pseries/setup.c
> index 28b286df0e91..a65843059c38 100644
> --- a/arch/powerpc/platforms/pseries/setup.c
> +++ b/arch/powerpc/platforms/pseries/setup.c
> @@ -498,6 +498,12 @@ static void __init pSeries_setup_arch(void)
>  	ppc_md.pcibios_root_bridge_prepare =3D pseries_root_bridge_prepare;
>  }
> =20
> +static void pSeries_panic(char *str)
> +{
> +	panic_flush_kmsg_end();
> +	rtas_os_term(str);
> +}
> +
>  static int __init pSeries_init_panel(void)
>  {
>  	/* Manually leave the kernel version on the panel. */
> @@ -726,7 +732,7 @@ define_machine(pseries) {
>  	.pcibios_fixup		=3D pSeries_final_fixup,
>  	.restart		=3D rtas_restart,
>  	.halt			=3D rtas_halt,
> -	.panic			=3D rtas_os_term,
> +	.panic			=3D pSeries_panic,
>  	.get_boot_time		=3D rtas_get_boot_time,
>  	.get_rtc_time		=3D rtas_get_rtc_time,
>  	.set_rtc_time		=3D rtas_set_rtc_time,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GvuyDaC2GNSBQusT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpMKKcACgkQbDjKyiDZ
s5LX7g/9H7Bk1117bmksEBFUY6c3cFRuJ0gLTWk7t4HQR7VpPEUAH2xcFl+PFOx5
iREwvdY8cmmWEwmDjOevabKDXWPoP2Jh1H5R0E3E7R5Q78nyEYT/bU/mkKxGbnYm
fviZ8YnfjDIuDZ9a9VswpKcQLhjE5K5jbpIwhWg3VkDjtuyXTH6ui3cvXDf1a+CR
0aFyowS6pOOCwotlOZmBZ84KwxU2Zj/dvQtRn2nm0PiTj7Wx6C0QNGoaRAqMi1gC
IQq5VrNZ4X+B6R+Q2ICsytcCqfPeAsNxTEZLXwzGlzq/eUCGcMyzSyxeo8JjnIfx
Wsmfh1K2HR0T7bs3V4x1ryx6ksN/ej1WANOlO1dcxetS62XeVVbix2dxgPbQ9TuF
0aEb0WGktYWKF2jbkQQUoVju+ILXv0oJh8xRzz4GN1Ca7SjMeWJNoAqFpbj4RR6s
OZA2g65yhZsXnxMWDAnnuU27UiCJSyFo8la5JAnn6fvmCdqd/3BhyQ20XvItLgmq
QnGtGb0pIEXslGG682kkwihR0Ap5Rm8EGwkzC/PogYVc07eazK+L4mPFYvduI0I9
fsqxotL+dyrDEaJEnxdx5d/b7DgLMJ1ELOsREOVsM6oJf+JhA5XWOnN4CLR2Lkvu
moruFd1DqoYjkVysunTv1A/4sxdzJ/58PXdbQ0EZ4HZ/vXY+KrA=
=rfx7
-----END PGP SIGNATURE-----

--GvuyDaC2GNSBQusT--
