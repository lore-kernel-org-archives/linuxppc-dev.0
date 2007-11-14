Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 8E3CADDDFD
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2007 10:21:50 +1100 (EST)
Date: Thu, 15 Nov 2007 10:21:49 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Marian Balakowicz <m8@semihalf.com>
Subject: Re: [PATCH v5 04/13] [POWERPC] Add generic support for simple
	MPC5200 based boards
Message-Id: <20071115102149.898061fb.sfr@canb.auug.org.au>
In-Reply-To: <20071114102115.31052.67271.stgit@hekate.izotz.org>
References: <20071114102115.31052.67271.stgit@hekate.izotz.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__15_Nov_2007_10_21_49_+1100_sI1mhVNd9kC8re9k"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__15_Nov_2007_10_21_49_+1100_sI1mhVNd9kC8re9k
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marian,

On Wed, 14 Nov 2007 11:21:37 +0100 Marian Balakowicz <m8@semihalf.com> wrot=
e:
>
> +++ b/arch/powerpc/platforms/52xx/mpc5200_simple.c
> +#include <asm/time.h>
> +#include <asm/machdep.h>
> +#include <asm/mpc52xx.h>

You still need asm/prom.h because you use of_get_flat_dt_root() and
of_flat_dt_is_compatible().

> +/* list of the supported boards */
> +static const char *board[] __initdata =3D {

Unfortunately you can't use "const" and "__initdata", so just remove the
"const".  (const changes the attributes on the section that __initdata is
stored in.)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__15_Nov_2007_10_21_49_+1100_sI1mhVNd9kC8re9k
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHO4MSTgG2atn1QN8RAmGZAKCMEp29ElecIii92gKo9BjG1gth9QCfUe1K
tU6C5jzvQlRGcsf2otxHWGc=
=dMB7
-----END PGP SIGNATURE-----

--Signature=_Thu__15_Nov_2007_10_21_49_+1100_sI1mhVNd9kC8re9k--
