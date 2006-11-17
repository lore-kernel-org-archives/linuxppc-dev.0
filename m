Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 5/16] cell: spu management xmon routines
From: Michael Ellerman <michael@ellerman.id.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <455D2F9A.7050603@am.sony.com>
References: <455D2F9A.7050603@am.sony.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Vjd9uT1j/Ya5QqvsgKK9"
Date: Fri, 17 Nov 2006 14:50:58 +1100
Message-Id: <1163735458.16815.38.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-Vjd9uT1j/Ya5QqvsgKK9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-11-16 at 19:42 -0800, Geoff Levand wrote:
> This fixes the xmon support to be compatable with the
> split spu platform code.
>=20
>=20
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
>=20
> ---
>=20
> Michael,
>=20
> I split this out so we can discuss it if needed.

Looks ok at least for now. Maybe we could add a FW_FEATURE, or use an
existing one, and just use that in the xmon code to work out whether we
try to dump the pdata as a sony_pdata or of_pdata.


Acked-by: Michael Ellerman <michael@ellerman.id.au>

>  arch/powerpc/xmon/xmon.c |    8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>=20
> Index: cell--common--6/arch/powerpc/xmon/xmon.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- cell--common--6.orig/arch/powerpc/xmon/xmon.c
> +++ cell--common--6/arch/powerpc/xmon/xmon.c
> @@ -2769,8 +2769,6 @@
> =20
>  	DUMP_FIELD(spu, "0x%x", number);
>  	DUMP_FIELD(spu, "%s", name);
> -	DUMP_FIELD(spu, "%s", devnode->full_name);
> -	DUMP_FIELD(spu, "0x%x", nid);
>  	DUMP_FIELD(spu, "0x%lx", local_store_phys);
>  	DUMP_FIELD(spu, "0x%p", local_store);
>  	DUMP_FIELD(spu, "0x%lx", ls_size);
> @@ -2794,12 +2792,8 @@
>  	DUMP_FIELD(spu, "0x%x", problem->spu_runcntl_RW);
>  	DUMP_FIELD(spu, "0x%x", problem->spu_status_R);
>  	DUMP_FIELD(spu, "0x%x", problem->spu_npc_RW);
> -	DUMP_FIELD(spu, "0x%p", priv1);
> -
> -	if (spu->priv1)
> -		DUMP_FIELD(spu, "0x%lx", priv1->mfc_sr1_RW);
> -
>  	DUMP_FIELD(spu, "0x%p", priv2);
> +	DUMP_FIELD(spu, "0x%p", pdata);
>  }
> =20
>  static int do_spu_cmd(void)
--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-Vjd9uT1j/Ya5QqvsgKK9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFXTGidSjSd0sB4dIRAkO7AKCnHChKSX/37uGCpqT6zLsU8wcW1ACeJltP
i3oOkpX0YXJSSCmFv6JZCGY=
=g5LY
-----END PGP SIGNATURE-----

--=-Vjd9uT1j/Ya5QqvsgKK9--
