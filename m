Return-Path: <michael@ellerman.id.au>
Subject: Re: [POWERPC] Allow xmon to build on legacy iSeries
From: Michael Ellerman <michael@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20061130114409.994a661e.sfr@canb.auug.org.au>
References: <20061130114409.994a661e.sfr@canb.auug.org.au>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-oeNLm35F6NuKHCpnrZwJ"
Date: Thu, 30 Nov 2006 12:04:08 +1100
Message-Id: <1164848648.27764.2.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-oeNLm35F6NuKHCpnrZwJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-11-30 at 11:44 +1100, Stephen Rothwell wrote:
> xmon still does not run on iSeries, but this allows us to build a combine=
d
> kernel that includes it.
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/powerpc/Kconfig.debug |    2 +-
>  arch/powerpc/xmon/xmon.c   |    9 +++++++++
>  2 files changed, 10 insertions(+), 1 deletions(-)
>=20
> --=20
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
>=20
> diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
> index ff16063..5cce904 100644
> --- a/arch/powerpc/Kconfig.debug
> +++ b/arch/powerpc/Kconfig.debug
> @@ -77,7 +77,7 @@ config KGDB_CONSOLE
> =20
>  config XMON
>  	bool "Include xmon kernel debugger"
> -	depends on DEBUGGER && !PPC_ISERIES
> +	depends on DEBUGGER
>  	help
>  	  Include in-kernel hooks for the xmon kernel monitor/debugger.
>  	  Unless you are intending to debug the kernel, say N here.
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index 1cf90c8..767b242 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -44,6 +44,7 @@
>  #ifdef CONFIG_PPC64
>  #include <asm/hvcall.h>
>  #include <asm/paca.h>
> +#include <asm/iseries/it_lp_reg_save.h>
>  #endif
> =20
>  #include "nonstdio.h"
> @@ -2580,6 +2581,10 @@ void dump_segments(void)
> =20
>  void xmon_init(int enable)
>  {
> +#ifdef CONFIG_PPC_ISERIES
> +	if (firmware_has_feature(FW_FEATURE_ISERIES))
> +		return;
> +#endif
>  	if (enable) {
>  		__debugger =3D xmon;
>  		__debugger_ipi =3D xmon_ipi;
> @@ -2617,6 +2622,10 @@ static struct sysrq_key_op sysrq_xmon_op =3D
> =20
>  static int __init setup_xmon_sysrq(void)
>  {
> +#ifdef CONFIG_PPC_ISERIES
> +	if (firmware_has_feature(FW_FEATURE_ISERIES))
> +		return 0;
> +#endif
>  	register_sysrq_key('x', &sysrq_xmon_op);
>  	return 0;
>  }

Why the ifdefs around the firmware check? Shouldn't it compile out to
nothing for !ISERIES anyway?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-oeNLm35F6NuKHCpnrZwJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFbi4HdSjSd0sB4dIRAnfqAJ0WQp3zvBppOjUH1TzBsXBWxTyEXwCgvV09
atDkqX4lgc8f29C8s7XXRSY=
=3mrN
-----END PGP SIGNATURE-----

--=-oeNLm35F6NuKHCpnrZwJ--
