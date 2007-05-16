Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] iseries: fix CONFIG_VIOCONS/CONFIG_VT dependency
From: Michael Ellerman <michael@ellerman.id.au>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070515190343.GA13203@lixom.net>
References: <20070515190343.GA13203@lixom.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-BGHrBgvLVpc43ItY4MEs"
Date: Wed, 16 May 2007 13:41:59 +1000
Message-Id: <1179286919.4120.39.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, sfr@canb.auug.org.au
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-BGHrBgvLVpc43ItY4MEs
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-05-15 at 14:03 -0500, Olof Johansson wrote:
> VT already depends on !VIOCONS, but there's no restriction in the other
> direction. This makes an allyesconfig not build.
>=20
> Switch to a Kconfig dependency instead of a compile-time error.
>=20
>=20
> Signed-off-by: Olof Johansson <olof@lixom.net>
>=20
> diff --git a/arch/powerpc/platforms/iseries/Kconfig b/arch/powerpc/platfo=
rms/iseries/Kconfig
> index 46c3a8e..e48f018 100644
> --- a/arch/powerpc/platforms/iseries/Kconfig
> +++ b/arch/powerpc/platforms/iseries/Kconfig
> @@ -8,6 +8,7 @@ menu "iSeries device drivers"
> =20
>  config VIOCONS
>  	tristate "iSeries Virtual Console Support (Obsolete)"
> +	depends on !VT
>  	help

This context doesn't match linus' or the powerpc tree, I see:

config VIOCONS
        bool "iSeries Virtual Console Support (Obsolete)"
        depends on !HVC_ISERIES
        default n
        help

cheers


--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-BGHrBgvLVpc43ItY4MEs
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGSn2HdSjSd0sB4dIRAoMpAJwJES+RA0xgEo+7P1j4aMhuaOSqkwCgoyjY
vkBKWg2mFub9HVhVSkMpsdE=
=dZsm
-----END PGP SIGNATURE-----

--=-BGHrBgvLVpc43ItY4MEs--
