Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 1/2] powerpc: pci config cleanup
From: Michael Ellerman <michael@ellerman.id.au>
To: John Rigby <jrigby@freescale.com>
In-Reply-To: <1214425164-1267-2-git-send-email-jrigby@freescale.com>
References: <1214425164-1267-1-git-send-email-jrigby@freescale.com>
	<1214425164-1267-2-git-send-email-jrigby@freescale.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Zjp1vngAAqAjBjYE6Iur"
Date: Thu, 26 Jun 2008 10:53:54 +1000
Message-Id: <1214441634.32022.2.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-Zjp1vngAAqAjBjYE6Iur
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-06-25 at 14:19 -0600, John Rigby wrote:
> change
>     bool "PCI support" if <long ugly expression>
> to
>     bool "PCI support" if PPC_HAS_PCI
>=20
> and add select PPC_HAS_PCI to all the config nodes that
> were previously in the PCI if expression
>=20
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 3934e26..fa9bd91 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -542,11 +542,12 @@ config FSL_LBC
>  config MCA
>  	bool
> =20
> +config PPC_HAS_PCI
> +	bool
> +
>  config PCI
> -	bool "PCI support" if 40x || CPM2 || PPC_83xx || PPC_85xx || PPC_86xx \
> -		|| PPC_MPC52xx || (EMBEDDED && (PPC_PSERIES || PPC_ISERIES)) \
> -		|| PPC_PS3 || 44x
> -	default y if !40x && !CPM2 && !8xx && !PPC_MPC512x && !PPC_83xx \
> +	bool "PCI support" if PPC_HAS_PCI
> +	default y if !40x && !CPM2 && !8xx && !PPC_83xx \
>  		&& !PPC_85xx && !PPC_86xx
>  	default PCI_PERMEDIA if !4xx && !CPM2 && !8xx
>  	default PCI_QSPAN if !4xx && !CPM2 && 8xx

This is backward I think. The bool says whether you get to choose if you
have PCI, not if you have it. It should be called CAN_CHOOSE_PCI or
something.

For example this makes no sense:

> diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platfo=
rms/pseries/Kconfig
> index 07fe5b6..e205066 100644
> --- a/arch/powerpc/platforms/pseries/Kconfig
> +++ b/arch/powerpc/platforms/pseries/Kconfig
> @@ -7,6 +7,7 @@ config PPC_PSERIES
>  	select RTAS_ERROR_LOGGING
>  	select PPC_UDBG_16550
>  	select PPC_NATIVE
> +	select PPC_HAS_PCI if EMBEDDED


cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-Zjp1vngAAqAjBjYE6Iur
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIYuiidSjSd0sB4dIRAqbEAKDDP6ROJAinTWTDp40OHbnHVI2vMACghDN3
0PDJQ9fRO/s9Umzyd1STQLQ=
=JgZu
-----END PGP SIGNATURE-----

--=-Zjp1vngAAqAjBjYE6Iur--
