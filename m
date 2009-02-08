Return-Path: <michael@ellerman.id.au>
Subject: Re: [patch] powerpc/ps3: Use hard coded values for LV1 device type
From: Michael Ellerman <michael@ellerman.id.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <498CF52E.4040903@am.sony.com>
References: <498C6C49.1010200@in.ibm.com>  <498CF52E.4040903@am.sony.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-2zWsJziVFUysDEjiLLMk"
Date: Sun, 08 Feb 2009 22:29:50 +1100
Message-Id: <1234092590.10240.4.camel@localhost>
Mime-Version: 1.0
Cc: Mel Gorman <mel@csn.ul.ie>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-2zWsJziVFUysDEjiLLMk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2009-02-06 at 18:42 -0800, Geoff Levand wrote:
> Change the PS3 platform code to use hard coded numbers for its
> LV1 device types.
>=20
> The PS3 platform code was incorrectly using some scsi block
> constants for the device type returned from the LV1 hypervisor.
>=20
> Fixes build errors like these when CONFIG_BLOCK=3Dn:
>=20
>   In file included from include/scsi/scsi.h:12,
>                    from arch/powerpc/platforms/ps3/platform.h:25,
>                    from arch/powerpc/platforms/ps3/setup.c:36:
>   include/scsi/scsi_cmnd.h:27:25: warning: "BLK_MAX_CDB" is not defined
>   include/scsi/scsi_cmnd.h:28:3: error: #error MAX_COMMAND_SIZE can not b=
e bigger than BLK_MAX_CDB
>=20
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> ---
> Ben,
>=20
> Please send upstream for 2.6.29.
>=20
> -Geoff
>=20
>  arch/powerpc/platforms/ps3/platform.h |    8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> --- a/arch/powerpc/platforms/ps3/platform.h
> +++ b/arch/powerpc/platforms/ps3/platform.h
> @@ -22,8 +22,6 @@
>  #define _PS3_PLATFORM_H
> =20
>  #include <linux/rtc.h>
> -#include <scsi/scsi.h>
> -
>  #include <asm/ps3.h>
> =20
>  /* htab */
> @@ -83,12 +81,12 @@ enum ps3_bus_type {
>  };
> =20
>  enum ps3_dev_type {
> -	PS3_DEV_TYPE_STOR_DISK =3D TYPE_DISK,	/* 0 */
> +	PS3_DEV_TYPE_STOR_DISK =3D 0, /* TYPE_DISK */
>  	PS3_DEV_TYPE_SB_GELIC =3D 3,
>  	PS3_DEV_TYPE_SB_USB =3D 4,
> -	PS3_DEV_TYPE_STOR_ROM =3D TYPE_ROM,	/* 5 */
> +	PS3_DEV_TYPE_STOR_ROM =3D 5, /* TYPE_ROM */
>  	PS3_DEV_TYPE_SB_GPIO =3D 6,
> -	PS3_DEV_TYPE_STOR_FLASH =3D TYPE_RBC,	/* 14 */
> +	PS3_DEV_TYPE_STOR_FLASH =3D 14, /* TYPE_RBC */

This looks like you're just papering over the bug, by hardcoding the
same values that are in the scsi header. Or are they really independent,
in which case I'd say the comments are confusing.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-2zWsJziVFUysDEjiLLMk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmOwi4ACgkQdSjSd0sB4dJhVACZAYPYCza7+oitZUhTMgNPKAu0
5FMAn0Xd+7usLLspiOTieWbbNN7GCee2
=T8zu
-----END PGP SIGNATURE-----

--=-2zWsJziVFUysDEjiLLMk--
