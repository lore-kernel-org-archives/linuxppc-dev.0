Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] [POWERPC] Fix return value check logic
From: Michael Ellerman <michael@ellerman.id.au>
To: Emil Medve <Emilian.Medve@Freescale.com>
In-Reply-To: <1211485762-29637-1-git-send-email-Emilian.Medve@Freescale.com>
References: <1211485762-29637-1-git-send-email-Emilian.Medve@Freescale.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Qicx5JNaaF7hr9NmJIav"
Date: Fri, 23 May 2008 11:13:10 +1000
Message-Id: <1211505190.7671.6.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linuxppc-embedded@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-Qicx5JNaaF7hr9NmJIav
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-05-22 at 14:49 -0500, Emil Medve wrote:
> debugfs_create_file() return a non-NULL (non-zero) value in case of succe=
ss
>=20
> This fixes this non-critical boot-time debuging error message:
>=20
> [    1.316386] calling  irq_debugfs_init+0x0/0x50
> [    1.316399] initcall irq_debugfs_init+0x0/0x50 returned -12 after 0 ms=
ecs
> [    1.316411] initcall irq_debugfs_init+0x0/0x50 returned with error cod=
e -12
>=20
> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
> ---
>=20
> $ scripts/checkpatch.pl 0001--POWERPC-Fix-return-value-check-logic.patch=20
> total: 0 errors, 0 warnings, 8 lines checked
>=20
> 0001--POWERPC-Fix-return-value-check-logic.patch has no obvious style pro=
blems and is ready for submission.
>=20
>  arch/powerpc/kernel/irq.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index 2f73f70..bcc249d 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -1073,7 +1073,7 @@ static const struct file_operations virq_debug_fops=
 =3D {
>  static int __init irq_debugfs_init(void)
>  {
>  	if (debugfs_create_file("virq_mapping", S_IRUGO, powerpc_debugfs_root,
> -				 NULL, &virq_debug_fops))
> +				 NULL, &virq_debug_fops) =3D=3D NULL)
>  		return -ENOMEM;

That won't work if CONFIG_DEBUG_FS is not defined, because in that case
debugfs_create_file() returns -ENODEV. I guess the whole virq debug code
should be wrapped in #ifdef CONFIG_DEBUG_FS.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-Qicx5JNaaF7hr9NmJIav
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBINhomdSjSd0sB4dIRAllQAKCaj8JYxpSZsrRDFinO3BZEVj736gCgu6DW
9PzEOU8mcCKjN8yR2Z+SL0k=
=C1vG
-----END PGP SIGNATURE-----

--=-Qicx5JNaaF7hr9NmJIav--
