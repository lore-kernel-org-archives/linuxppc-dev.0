Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 1F71FDDE1E
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 14:15:25 +1000 (EST)
Date: Tue, 12 Jun 2007 14:15:09 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: arnd@arndb.de
Subject: Re: [patch 06/10] powerpc: multiplatformize embedded6xx Kconfig
Message-Id: <20070612141509.4c4f6cc8.sfr@canb.auug.org.au>
In-Reply-To: <20070611233354.289486461@arndb.de>
References: <20070611232824.489103547@arndb.de>
	<20070611233354.289486461@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__12_Jun_2007_14_15_09_+1000_fh9YHxnHDNiwTcoj"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__12_Jun_2007_14_15_09_+1000_fh9YHxnHDNiwTcoj
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 12 Jun 2007 01:28:30 +0200 arnd@arndb.de wrote:
>
> The existing embedded 6xx platforms will happily coexist
> with each other in a single kernel if you let them.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Index: linux-2.6/arch/powerpc/platforms/embedded6xx/Kconfig
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/arch/powerpc/platforms/embedded6xx/Kconfig
> +++ linux-2.6/arch/powerpc/platforms/embedded6xx/Kconfig
> @@ -1,9 +1,10 @@
> -choice
> -	prompt "Machine Type"
> -	depends on EMBEDDED6xx
> +config EMBEDDED6xx
> +	bool "Embedded 6xx"
> =20
>  config LINKSTATION
>  	bool "Linkstation / Kurobox(HG) from Buffalo"
> +	depends on EMBEDDED6xx
> +	depends on (BROKEN || BROKEN_ON_SMP)

Would this be a separate fix?

>  	select MPIC
>  	select FSL_SOC
>  	select PPC_UDBG_16550 if SERIAL_8250
> @@ -17,6 +18,8 @@ config LINKSTATION
> =20
>  config MPC7448HPC2
>  	bool "Freescale MPC7448HPC2(Taiga)"
> +	depends on EMBEDDED6xx
> +	depends on (BROKEN || BROKEN_ON_SMP)

And this?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__12_Jun_2007_14_15_09_+1000_fh9YHxnHDNiwTcoj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGbh3ZFdBgD/zoJvwRAuU1AJ0aRydnbwK4j5dUOXwDdr2uUlYo1QCfZM7R
MRRWn3sCsWpyLzL/d6tVPNU=
=cUsV
-----END PGP SIGNATURE-----

--Signature=_Tue__12_Jun_2007_14_15_09_+1000_fh9YHxnHDNiwTcoj--
