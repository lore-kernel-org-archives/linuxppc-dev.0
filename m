Return-Path: <michael@ellerman.id.au>
Subject: Re: [BUG] flash failure with CONFIG_RTAS_FLASH=m
From: Michael Ellerman <michael@ellerman.id.au>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070104180406.6843ead3@localhost.localdomain>
References: <20070104234951.GJ6279@localdomain>
	<20070104180406.6843ead3@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-AUWs/Vk8NznN8YMctLTh"
Date: Mon, 08 Jan 2007 12:09:04 +1100
Message-Id: <1168218544.30064.3.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-AUWs/Vk8NznN8YMctLTh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-01-04 at 18:04 -0600, Olof Johansson wrote:
> On Thu, 4 Jan 2007 17:49:51 -0600 Nathan Lynch <ntl@pobox.com> wrote:
>=20
> > The problem doesn't happen if CONFIG_RTAS_FLASH=3Dy.
> >=20
> > What's the best way to fix this?  Should rtas_firmware_flash_list be
> > defined in some non-modular code and exported?
>=20
> Makes sense to me.
>=20
> You could allocate it dynamically really early (i.e. lmb_alloc) since
> that's the only allocator that we can give limits to where in the
> address range it can allocate. It seems to be overkill in this case
> though, it's just a page worth of data.

There's the ZONE stuff, but it doesn't help us because our ZONE_DMA =3D=3D
all of ram - we'd need to add another ZONE below that, which is generic
code :/

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-AUWs/Vk8NznN8YMctLTh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFoZmvdSjSd0sB4dIRApH9AJ9HI0sUQphwCYyp6RpY4VkqiReV9ACeJJ2Q
0S9bWPQoNcN9HRrKK5OlTAM=
=L6pg
-----END PGP SIGNATURE-----

--=-AUWs/Vk8NznN8YMctLTh--
