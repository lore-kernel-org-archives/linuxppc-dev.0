Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 2/4] powerpc: Panic on platform ppc-xicp when
	CONFIG_XICS not set instead of build failure
From: Michael Ellerman <michael@ellerman.id.au>
To: Mel Gorman <mel@csn.ul.ie>
In-Reply-To: <1258459659-11770-3-git-send-email-mel@csn.ul.ie>
References: <1258459659-11770-1-git-send-email-mel@csn.ul.ie>
	<1258459659-11770-3-git-send-email-mel@csn.ul.ie>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-zwbNkCwuxkbKt0k2YRQj"
Date: Tue, 17 Nov 2009 23:45:00 +1100
Message-ID: <1258461900.24093.77.camel@concordia>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-zwbNkCwuxkbKt0k2YRQj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-11-17 at 12:07 +0000, Mel Gorman wrote:
> If CONFIG_XICS is not set but CONFIG_PPC_PSERIES is, then the kernel
> fails to build with
>=20
> arch/powerpc/platforms/pseries/smp.c: In function =E2=80=98smp_init_pseri=
es_xics=E2=80=99:
> arch/powerpc/platforms/pseries/smp.c:202: error: =E2=80=98pSeries_xics_sm=
p_ops=E2=80=99 undeclared (first use in this function)
> arch/powerpc/platforms/pseries/smp.c:202: error: (Each undeclared identif=
ier is reported only once
> arch/powerpc/platforms/pseries/smp.c:202: error: for each function it app=
ears in.)
> make[2]: *** [arch/powerpc/platforms/pseries/smp.o] Error 1
>=20
> As CONFIG_XICS is not always necessary, this patch allows the kernel to
> build but the system will panic at runtime if it is found that XICS is
> required.
>=20
> Signed-off-by: Mel Gorman <mel@csn.ul.ie>
> ---
>  arch/powerpc/platforms/pseries/smp.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platform=
s/pseries/smp.c
> index 440000c..da78ea5 100644
> --- a/arch/powerpc/platforms/pseries/smp.c
> +++ b/arch/powerpc/platforms/pseries/smp.c
> @@ -199,7 +199,11 @@ void __init smp_init_pseries_mpic(void)
> =20
>  void __init smp_init_pseries_xics(void)
>  {
> +#ifdef CONFIG_XICS
>  	smp_ops =3D &pSeries_xics_smp_ops;
> +#else
> +	panic("Support for platform ppc-xicp not configured");
> +#endif
> =20
>  	smp_init_pseries();
>  }

I think it'd be neater to just ifdef the whole block in
pseries_discover_pic(), or move it out and ifdef that. That'd avoid
referencing pseries_xics_init_IRQ() and setup_kexec_cpu_down_xics()
also.

cheers

--=-zwbNkCwuxkbKt0k2YRQj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAksCmssACgkQdSjSd0sB4dLFEQCfeVq096clKy9UBR/mXIRCSXxx
9rIAoLjyQBBwui0Cnb6/XShTgoKwcYZH
=aKPq
-----END PGP SIGNATURE-----

--=-zwbNkCwuxkbKt0k2YRQj--
