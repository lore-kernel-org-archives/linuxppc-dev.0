Return-Path: <michael@ellerman.id.au>
Subject: Re: [patch 01/18] Cell: Add spu shutdown method
From: Michael Ellerman <michael@ellerman.id.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <46662303.1040606@am.sony.com>
References: <20070606024407.786638029@am.sony.com> >
	<46662303.1040606@am.sony.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-UPOutnJlxQ5IhI0+AONz"
Date: Wed, 06 Jun 2007 14:08:34 +1000
Message-Id: <1181102914.5536.22.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>,
	=?ISO-8859-1?Q?Andr=E9?= Detsch <adetsch@br.ibm.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-UPOutnJlxQ5IhI0+AONz
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-06-05 at 19:59 -0700, Geoff Levand wrote:
> Add a shutdown method to spu_sysdev_class to allow proper spu resource
> cleanup on system shutdown.  This is needed to support kexec on the PS3
> platform.
>=20
> Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> ---
>  arch/powerpc/platforms/cell/spu_base.c |   12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Andr=C3=A9, does this interact with your kexec work at all?

cheers

> --- a/arch/powerpc/platforms/cell/spu_base.c
> +++ b/arch/powerpc/platforms/cell/spu_base.c
> @@ -462,8 +462,18 @@ void spu_free(struct spu *spu)
>  }
>  EXPORT_SYMBOL_GPL(spu_free);
> =20
> +static int spu_shutdown(struct sys_device *sysdev)
> +{
> +	struct spu *spu =3D container_of(sysdev, struct spu, sysdev);
> +
> +	spu_free_irqs(spu);
> +	spu_destroy_spu(spu);
> +	return 0;
> +}
> +
>  struct sysdev_class spu_sysdev_class =3D {
> -	set_kset_name("spu")
> +	set_kset_name("spu"),
> +	.shutdown =3D spu_shutdown,
>  };
> =20
>  int spu_add_sysdev_attr(struct sysdev_attribute *attr)
>=20
--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-UPOutnJlxQ5IhI0+AONz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGZjNCdSjSd0sB4dIRAuBCAJ9mB43l9yzbUYhVkHKIETdc+qo+XQCglxey
UmZ0jT0tS80lsZpNshvkteA=
=c8mX
-----END PGP SIGNATURE-----

--=-UPOutnJlxQ5IhI0+AONz--
