Return-Path: <sfr@canb.auug.org.au>
Date: Wed, 2 Apr 2008 23:29:05 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@ozlabs.org>
Subject: Re: [PATCH 2/4] [POWERPC] lockdep stacktrace support
Message-Id: <20080402232905.f7ced10d.sfr@canb.auug.org.au>
In-Reply-To: <20080402075254.24539DDEDD@ozlabs.org>
References: <1207122728.672673.111194574046.qpush@grosgo>
	<20080402075254.24539DDEDD@ozlabs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__2_Apr_2008_23_29_05_+1100_aLo=Znjin=BmCHqk"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__2_Apr_2008_23_29_05_+1100_aLo=Znjin=BmCHqk
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 02 Apr 2008 18:52:10 +1100 Benjamin Herrenschmidt <benh@ozlabs.org>=
 wrote:
>
> +++ linux-work/arch/powerpc/kernel/stacktrace.c	2008-04-02 16:46:07.00000=
0000 +1100
> @@ -0,0 +1,52 @@
> +

Copyight and license statement needed.

> +#include <linux/sched.h>
> +#include <linux/stacktrace.h>

You should include <asm/ptrace.h> for STACK_FRAME_OVERHEAD and struct pt_re=
gs.

> +#ifdef CONFIG_PPC64
> +#define MIN_STACK_FRAME 112     /* same as STACK_FRAME_OVERHEAD, in fact=
 */

So use STACK_FRAME_OVERHEAD?

> +#define FRAME_LR_SAVE   2
> +#define INT_FRAME_SIZE  (sizeof(struct pt_regs) + STACK_FRAME_OVERHEAD +=
 288)
                                                     ^^^^^^^^^^^^^^^^^^^^
Its used here already ...

> +#define REGS_MARKER     0x7265677368657265ul

Maybe we need to put REGS_MARKER into a header file as it already appears
in two assembly files and two C files.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__2_Apr_2008_23_29_05_+1100_aLo=Znjin=BmCHqk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH83wWTgG2atn1QN8RApQPAJ92nOkqIOOiojlX616kQBMjmEPCwgCfVTYH
SHmd7hQAbLo9jcG2I9PK1mY=
=sAuo
-----END PGP SIGNATURE-----

--Signature=_Wed__2_Apr_2008_23_29_05_+1100_aLo=Znjin=BmCHqk--
