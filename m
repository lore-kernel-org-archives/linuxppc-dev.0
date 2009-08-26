Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 09E97B7B3E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Aug 2009 00:22:47 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EBB51DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 00:22:46 +1000 (EST)
Subject: Re: PPC driver - generic bus width
From: Michael Ellerman <michael@ellerman.id.au>
To: Alemao <xcarandiru@gmail.com>
In-Reply-To: <d970ff420908260625q2d34bc10p62241218f022b5c2@mail.gmail.com>
References: <d970ff420908260625q2d34bc10p62241218f022b5c2@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-R7omrj8J5QJYbrTxDnX1"
Date: Thu, 27 Aug 2009 00:22:45 +1000
Message-Id: <1251296565.7492.7.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-R7omrj8J5QJYbrTxDnX1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-08-26 at 10:25 -0300, Alemao wrote:
> Hi all,
>=20
> Im trying to develop a driver for my device, and its data bus can be 8, 1=
6
> or 32 bits. This information is passed through the device tree source.
> My code is like this:
>=20
> struct device_info_t {
> 	void (*read)();
> 	void (*write)();
> };
>=20
> static int __devinit device_probe()
> {
> 	prop =3D of_get_property(ofdev->node, "bus-width", &size);
>=20
> 	device->bus_width =3D *prop;
>=20
> 	switch (device->bus_width) {
> 	case 8:
> 		device->read  =3D in_8;
> 		device->write =3D out_8;
> 		break;
> 	case 16:
> 		device->read  =3D in_be16;
> 		device->write =3D out_be16;
> 		break;
> 	case 32:
> 		device->read  =3D in_be32;
> 		device->write =3D out_be32;
> 		break;
> 	default:
> 		break;
> 	}
> }
>=20
> Can someone point me some driver that is doing something similar to the
> ideia shown above?
>=20
> Or what Im doing wrong in my code? Cause Im getting erros (warnings) like=
:
>=20
> cc1: warnings being treated as errors
> drivers/dev_test.c:37: warning: function declaration isn't a prototype
> drivers/dev_test.c:38: warning: function declaration isn't a prototype
> drivers/dev_test.c: In function 'device_probe':
> drivers/dev_test.c:113: warning: assignment from incompatible pointer
> type

I'm not sure about the first two, you don't seem to have pasted all the
source, and you haven't given the line numbers.

The 3rd is probably because the prototype for in_8 etc. doesn't match
your structure.

cheers

--=-R7omrj8J5QJYbrTxDnX1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkqVRTUACgkQdSjSd0sB4dJ88QCeKagn2D+/4kU4qf8u/g0Wsm8T
nnIAnjWR0rqgFiO+T23O91XEc07kFQbI
=/i3Y
-----END PGP SIGNATURE-----

--=-R7omrj8J5QJYbrTxDnX1--
