Return-Path: <michael@ellerman.id.au>
Subject: Re: [viro@ftp.linux.org.uk: [PATCH] rpadlpar breakage - fallout of
	struct subsystem removal]
From: Michael Ellerman <michael@ellerman.id.au>
To: Al Viro <viro@ftp.linux.org.uk>
In-Reply-To: <20070515194729.GE4095@ftp.linux.org.uk>
References: <20070515194729.GE4095@ftp.linux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-x4yqFRAmQEj5MnOBT7Eh"
Date: Wed, 16 May 2007 10:49:48 +1000
Message-Id: <1179276588.4120.22.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Greg KH <greg@kroah.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-x4yqFRAmQEj5MnOBT7Eh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-05-15 at 20:47 +0100, Al Viro wrote:
> [oops - typo in Cc in original posting]
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  drivers/pci/hotplug/rpadlpar_sysfs.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/hotplug/rpadlpar_sysfs.c b/drivers/pci/hotplug/r=
padlpar_sysfs.c
> index 6c5be3f..df07606 100644
> --- a/drivers/pci/hotplug/rpadlpar_sysfs.c
> +++ b/drivers/pci/hotplug/rpadlpar_sysfs.c
> @@ -129,8 +129,9 @@ struct kobj_type ktype_dlpar_io =3D {
>  };
> =20
>  struct kset dlpar_io_kset =3D {
> -	.subsys =3D &pci_hotplug_slots_subsys,
> -	.kobj =3D {.name =3D DLPAR_KOBJ_NAME, .ktype=3D&ktype_dlpar_io,},
> +	.kobj =3D {.name =3D DLPAR_KOBJ_NAME,
> +		 .ktype =3D &ktype_dlpar_io,
> +		 .parent =3D &pci_hotplug_slots_subsys.kobj},
>  	.ktype =3D &ktype_dlpar_io,
>  };

That seems to work, I get 'add_slot' and 'remove_slot'
under /sys/bus/pci/slots/control again.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-x4yqFRAmQEj5MnOBT7Eh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGSlUsdSjSd0sB4dIRArH9AKCwvBkVvL9WEY+6UyRTxpYw7wMIeACgiKum
//ghXB0pLMX/6vamlGlZuNU=
=DGRD
-----END PGP SIGNATURE-----

--=-x4yqFRAmQEj5MnOBT7Eh--
