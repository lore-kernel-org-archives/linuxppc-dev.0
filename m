Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 1/2] ramdisk: make powerpc allmodconfig build
From: Michael Ellerman <michael@ellerman.id.au>
To: Judith Lebzelter <judith@osdl.org>
In-Reply-To: <20061017180447.GC822@shell0.pdx.osdl.net>
References: <20061017094742.a61c4873.randy.dunlap@oracle.com>
	<20061017180447.GC822@shell0.pdx.osdl.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-A3wdgLwuRAfbaBFvfply"
Date: Wed, 18 Oct 2006 13:10:54 +1000
Message-Id: <1161141055.7906.0.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Randy Dunlap <randy.dunlap@oracle.com>, ppcdev <linuxppc-dev@ozlabs.org>,
	paulus <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-A3wdgLwuRAfbaBFvfply
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-10-17 at 11:04 -0700, Judith Lebzelter wrote:
> Hi Randy,
>=20
> There is another section in that function which depends on=20
> 'CONFIG_BLK_DEV_INITRD' being defined.  Although it does not throw an
> error, it does depend on some of the variables set in this section,
> but not 'rd_size'.  I think for consistancy it might be better to do=20
> somthing like this(below)?  Or else add the same ifdef down there...
>=20
> Judith
>=20
>=20
> Index: 2/linux/arch/powerpc/platforms/iseries/setup.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- 2.orig/linux/arch/powerpc/platforms/iseries/setup.c	2006-10-17 10:49:=
31.423551104 -0700
> +++ 2/linux/arch/powerpc/platforms/iseries/setup.c	2006-10-17 10:52:22.68=
2515784 -0700
> @@ -305,8 +305,10 @@
>  		initrd_end =3D initrd_start + naca.xRamDiskSize * HW_PAGE_SIZE;
>  		initrd_below_start_ok =3D 1;	// ramdisk in kernel space
>  		ROOT_DEV =3D Root_RAM0;
> +#if defined(CONFIG_BLK_DEV_RAM)
>  		if (((rd_size * 1024) / HW_PAGE_SIZE) < naca.xRamDiskSize)
>  			rd_size =3D (naca.xRamDiskSize * HW_PAGE_SIZE) / 1024;
> +#endif /* CONFIG_BLK_DEV_RAM */
>  	} else
>  #endif /* CONFIG_BLK_DEV_INITRD */
>  	{

That code is bogus, we'll remove it entirely.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-A3wdgLwuRAfbaBFvfply
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBFNZs+dSjSd0sB4dIRAlFHAKCiH3mPWH2Rq5jvTqizbUrhsnARDQCdHtGw
awOOfmooWQiyvwzG4J01d8A=
=Ybve
-----END PGP SIGNATURE-----

--=-A3wdgLwuRAfbaBFvfply--
