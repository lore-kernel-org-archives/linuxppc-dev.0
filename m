Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 3/3] powerpc perf_event: Add alignment-faults and
	emulation-faults software events
From: Michael Ellerman <michael@ellerman.id.au>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20091018111300.GM4808@kryten>
References: <20091018110929.GK4808@kryten> <20091018111126.GL4808@kryten>
	<20091018111300.GM4808@kryten>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-ZZtt9XYGfs4yRBQtKZhE"
Date: Mon, 19 Oct 2009 10:50:05 +1100
Message-Id: <1255909805.4192.5.camel@concordia>
Mime-Version: 1.0
Cc: a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, mingo@elte.hu
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-ZZtt9XYGfs4yRBQtKZhE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2009-10-18 at 22:13 +1100, Anton Blanchard wrote:
> Hook up the alignment-faults and emulation-faults events for powerpc.
>=20
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>=20
> Index: linux.trees.git/arch/powerpc/include/asm/emulated_ops.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux.trees.git.orig/arch/powerpc/include/asm/emulated_ops.h	2009-09-=
22 13:45:07.000000000 +1000
> +++ linux.trees.git/arch/powerpc/include/asm/emulated_ops.h	2009-09-22 13=
:45:27.000000000 +1000
> @@ -19,6 +19,7 @@
>  #define _ASM_POWERPC_EMULATED_OPS_H
> =20
>  #include <asm/atomic.h>
> +#include <linux/perf_event.h>
> =20
>=20
>  #ifdef CONFIG_PPC_EMULATED_STATS
> @@ -71,7 +72,18 @@ extern void ppc_warn_emulated_print(cons
> =20
>  #endif /* !CONFIG_PPC_EMULATED_STATS */
> =20
> -#define PPC_WARN_EMULATED(type, regs)	__PPC_WARN_EMULATED(type)
> -#define PPC_WARN_ALIGNMENT(type, regs)	__PPC_WARN_EMULATED(type)
> +#define PPC_WARN_EMULATED(type, regs)					\
> +	do {								\
> +		perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS,		\
> +			1, 0, regs, 0);					\
> +		__PPC_WARN_EMULATED(type);				\
> +	} while (0)
> +
> +#define PPC_WARN_ALIGNMENT(type, regs)					\
> +	do {								\
> +		perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS,		\
> +			1, 0, regs, regs->dar);				\
> +		__PPC_WARN_EMULATED(type);				\
> +	} while (0)

Does that work with perfxxx configured off?

cheers

--=-ZZtt9XYGfs4yRBQtKZhE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkrbqakACgkQdSjSd0sB4dKPQQCeItH0ghULWUJ4WmGRMpUgG79k
RFoAn3RBua1T2wFfb2ey9eL5jDw4M3oZ
=8rqU
-----END PGP SIGNATURE-----

--=-ZZtt9XYGfs4yRBQtKZhE--
