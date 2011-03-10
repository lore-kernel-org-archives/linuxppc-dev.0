Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 17/18] powerpc/smp: Increase vdso_data->processorCount,
	not just decrease it
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1299566250-10516-18-git-send-email-benh@kernel.crashing.org>
References: <1299566250-10516-1-git-send-email-benh@kernel.crashing.org>
	<1299566250-10516-18-git-send-email-benh@kernel.crashing.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-ZXg78+MP/lcN6P8BDHPt"
Date: Thu, 10 Mar 2011 14:41:07 +1100
Message-ID: <1299728467.6272.49.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-ZXg78+MP/lcN6P8BDHPt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2011-03-08 at 17:37 +1100, Benjamin Herrenschmidt wrote:
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/kernel/smp.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index e337073..6023395 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -551,6 +551,10 @@ void __devinit start_secondary(void *unused)
> =20
>  	secondary_cpu_time_init();
> =20
> +#ifdef CONFIG_PPC64
> +	if (system_state =3D=3D SYSTEM_RUNNING)
> +		vdso_data->processorCount++;
> +#endif

So the SYSTEM_RUNNING check is to avoid clashing with the logic in
smp_setup_cpu_maps() I presume:

arch/powerpc/kernel/setup-common.c:     vdso_data->processorCount =3D num_p=
resent_cpus();


But why not remove that, and let the increment in start_secondary() do
all the work?

With the current code if a cpu is present but fails to come up the count
will be wrong I think.

cheers


--=-ZXg78+MP/lcN6P8BDHPt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk14SFMACgkQdSjSd0sB4dJ9+wCbBQ4uPcBVWKbQjqEBC6hTHjDB
VM4AnRZDraBLD5gpX9d4J7uub0uCeSoU
=9wWp
-----END PGP SIGNATURE-----

--=-ZXg78+MP/lcN6P8BDHPt--
