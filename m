Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] add smp_call_function_map and smp_call_function_single
From: Michael Ellerman <michael@ellerman.id.au>
To: Will Schmidt <will_schmidt@vnet.ibm.com>
In-Reply-To: <20070502171234.13831.8483.stgit@farscape.rchland.ibm.com>
References: <20070502171234.13831.8483.stgit@farscape.rchland.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-M3EfaXDWN71yawkPsTw9"
Date: Thu, 03 May 2007 10:53:58 +1000
Message-Id: <1178153638.5338.2.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org,
	Kevin Corry <kevcorry@us.ibm.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-M3EfaXDWN71yawkPsTw9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-05-02 at 12:12 -0500, Will Schmidt wrote:
> Add a new function named smp_call_function_single().  This matches a gene=
ric
> prototype from include/linux/smp.h.
>=20
> Add a function smp_call_function_map().  This is, for the most part, a re=
name
> of smp_call_function, with some added cpumask support.  smp_call_function=
 and
> smp_call_function_single call into smp_call_function_map.
>=20
> Lightly tested on 970mp (blade), power4 and power5.
>=20
> Signed-off-by: Will Schmidt <will_schmidt@vnet.ibm.com>
> cc: Anton Blanchard <anton@samba.org>
> ---
>=20
>  arch/powerpc/kernel/smp.c |   73 ++++++++++++++++++++++++++++++++-------=
------
>  1 files changed, 52 insertions(+), 21 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 924d692..4878588 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -176,10 +176,10 @@ static struct call_data_struct {
>  #define SMP_CALL_TIMEOUT	8
> =20
>  /*
> - * This function sends a 'generic call function' IPI to all other CPUs
> - * in the system.
> + * These functions send a 'generic call function' IPI to other online
> + * CPUS in the system.
>   *
> - * [SUMMARY] Run a function on all other CPUs.
> + * [SUMMARY] Run a function on other CPUs.
>   * <func> The function to run. This must be fast and non-blocking.
>   * <info> An arbitrary pointer to pass to the function.
>   * <nonatomic> currently unused.

While you're there, or as a separate patch, can you fix up this
not-quite-kernel-doc commenting?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-M3EfaXDWN71yawkPsTw9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGOTKmdSjSd0sB4dIRAk/tAKCrUP3u/PcpemW4OI0Lz5qT19ZZMgCcDVIQ
+TBquWpD2brTlDs+7m30dS0=
=+vsK
-----END PGP SIGNATURE-----

--=-M3EfaXDWN71yawkPsTw9--
