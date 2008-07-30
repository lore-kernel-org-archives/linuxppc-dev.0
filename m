Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc/mm: Lockless get_user_pages_fast()
From: Michael Ellerman <michael@ellerman.id.au>
To: benh@kernel.crashing.org
In-Reply-To: <1217391656.11188.292.camel@pasglop>
References: <1217389038.11188.285.camel@pasglop>
	<1217391656.11188.292.camel@pasglop>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Ot6mw7mj69x1fU0O1BlB"
Date: Wed, 30 Jul 2008 15:06:22 +1000
Message-Id: <1217394382.10646.13.camel@localhost>
Mime-Version: 1.0
Cc: Nick Piggin <npiggin@suse.de>, linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-Ot6mw7mj69x1fU0O1BlB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-07-30 at 14:20 +1000, Benjamin Herrenschmidt wrote:
> From: Nick Piggin <npiggin@suse.de>
>=20
> Implement lockless get_user_pages_fast for powerpc.  Page table existence
> is guaranteed with RCU, and speculative page references are used to take =
a
> reference to the pages without having a prior existence guarantee on them=
.

> Index: linux-work/arch/powerpc/mm/gup.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-work/arch/powerpc/mm/gup.c	2008-07-30 14:20:00.000000000 +1000
> @@ -0,0 +1,271 @@
> +/*
> + * Lockless get_user_pages_fast for powerpc
> + *
> + * Copyright (C) 2008 Nick Piggin
> + * Copyright (C) 2008 Novell Inc.
> + */
> +#undef DEBUG
> +
> +#include <linux/sched.h>
> +#include <linux/mm.h>
> +#include <linux/hugetlb.h>
> +#include <linux/vmstat.h>
> +#include <linux/pagemap.h>
> +#include <linux/rwsem.h>
> +#include <asm/pgtable.h>
> +
> +/*
> + * The performance critical leaf functions are made noinline otherwise g=
cc
> + * inlines everything into a single function which results in too much
> + * register pressure.
> + */

This strikes me as something that is liable to change for compiler
version n+1, or n with -fsomething - and might leave us shooting
ourselves in the foot, just a thought.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-Ot6mw7mj69x1fU0O1BlB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIj/bOdSjSd0sB4dIRAr5pAJ9w/nStMw8iJomQ3jROoiyo7ia3SQCfaC9/
VkGt4LTvANPkurtRonoX63c=
=ILOe
-----END PGP SIGNATURE-----

--=-Ot6mw7mj69x1fU0O1BlB--
