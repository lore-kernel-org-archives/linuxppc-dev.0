Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zBC4s0k8QzF0Pm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jan 2018 11:49:49 +1100 (AEDT)
Date: Wed, 3 Jan 2018 11:49:31 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc: System reset avoid interleaving oops using
 die synchronisation
Message-ID: <20180103004931.GJ24581@umbus.fritz.box>
References: <20171223164923.10587-1-npiggin@gmail.com>
 <20171223164923.10587-2-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="W13SgbpmD6bhZUTM"
In-Reply-To: <20171223164923.10587-2-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--W13SgbpmD6bhZUTM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 24, 2017 at 02:49:22AM +1000, Nicholas Piggin wrote:
> The die() oops path contains a serializing lock to prevent oops
> messages from being interleaved. In the case of a system reset
> initiated oops (e.g., qemu nmi command), __die was being called
> which lacks that synchronisation and oops reports could be
> interleaved across CPUs.
>=20
> A recent patch 4388c9b3a6ee7 ("powerpc: Do not send system reset
> request through the oops path") changed this to __die to avoid
> the debugger() call, but there is no real harm to calling it twice
> if the first time fell through. So go back to using die() here.
> This was observed to fix the problem.
>=20
> Fixes: 4388c9b3a6ee7 ("powerpc: Do not send system reset request through =
the oops path")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/kernel/traps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index f3eb61be0d30..109989676776 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -337,7 +337,7 @@ void system_reset_exception(struct pt_regs *regs)
>  	 * No debugger or crash dump registered, print logs then
>  	 * panic.
>  	 */
> -	__die("System Reset", regs, SIGABRT);
> +	die("System Reset", regs, SIGABRT);
> =20
>  	mdelay(2*MSEC_PER_SEC); /* Wait a little while for others to print */
>  	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--W13SgbpmD6bhZUTM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpMKJsACgkQbDjKyiDZ
s5IkqA/+PkVwZIHedn81xG8Wh0veDPuVfsVl+WTMTxqCxP/jQ1jGGds8ShHx1hMq
PZcau4aD6wcP0QvNRRhJWdSBJvtlKtJu90EaW8a/+DRc0QxzUvijDC10mWQk+RDF
6Fc0DJYWLhjBw5P9RcwbyV0axwBY78O4R5baW488z4FLZAlL0OUYh02e7Fyqw1XV
gyIuyT7Nmz4U/AiV5MVyvOqUjTOhF28jafRltC9N4IxHzAdZGBLwR+BfrPsOOKQc
ztGCC8Mt5txGr3aVF2ZskH7eNo3UZ5Uzxu8aaICCKm2siZ46A3//q9RJun1oLslJ
Q06lXO4RbPYp58JM+67IUrE+BCTXO+nl7IymOGwgJYn7ElQ89k+YWPVPtq5AWRy0
zvyI339NQnhlQt46gPat3WjYb5siQWL98nrcmV0BQbpbKh1P4GyvtmQ1a6KKfrFF
wM81FGF2nodD0+4Qhi62IPSlvSTWJI25YJsgDmpd4b0skCnFAjoILouT13uhHbeq
35+2/fefxybIlW60hjCS7gVBZPS4+xXi+YR77KlFiAUpWjbV4lgOlFOJF3DerSqc
62Mn+zMxm9Bx67efieTCFSvqO5DnAiqW+YwpE9LT2/a2DuOCt6SjGC9yAhRQ0bGD
2Nr6Neg23JTk1Tbh7fcOKtAQYm/sVIdI8Fi+NhRSw+nMYVllJ8U=
=F9OB
-----END PGP SIGNATURE-----

--W13SgbpmD6bhZUTM--
