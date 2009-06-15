Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8895BB718C
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Jun 2009 17:50:42 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 794D8DDD04
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jun 2009 17:50:42 +1000 (EST)
Subject: Re: [PATCH] powerpc: Add configurable -Werror for arch/powerpc
From: Michael Ellerman <michael@ellerman.id.au>
To: BenjaminHerrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <adf502e7c85161d77fdcaca24f55ba6b418c7f04.1244616523.git.michael@ellerman.id.au>
References: <adf502e7c85161d77fdcaca24f55ba6b418c7f04.1244616523.git.michael@ellerman.id.au>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-f4hHTSzMe/yKqm7k209f"
Date: Mon, 15 Jun 2009 17:50:41 +1000
Message-Id: <1245052241.7705.78.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-f4hHTSzMe/yKqm7k209f
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-06-10 at 16:48 +1000, Michael Ellerman wrote:
> Add the option to build the code under arch/powerpc with -Werror.
>=20
> The intention is to make it harder for people to inadvertantly introduce
> warnings in the arch/powerpc code. It needs to be configurable so that
> if a warning is introduced, people can easily work around it while it's
> being fixed.
>=20
> The option is a negative, ie. don't enable -Werror, so that it will be
> turned on for allyes and allmodconfig builds.
>=20
> The default is n, in the hope that developers will build with -Werror,
> that will probably lead to some build breaks, I am prepared to be flamed.

Currently this appears to break only one of the defconfigs, chrp32.

http://kisskb.ellerman.id.au/kisskb/head/1907/

And that's a legitimate error AFAICT:

arch/powerpc/platforms/chrp/setup.c:378: error: the frame size of 1040 byte=
s is larger than 1024 bytes

From:

367 void
368 chrp_event_scan(unsigned long unused)
369 {
370         unsigned char log[1024];
371         int ret =3D 0;


cheers

--=-f4hHTSzMe/yKqm7k209f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAko1/VEACgkQdSjSd0sB4dLdJACcDp5qzRjDsUIVnL/OFxfAPCIB
SbAAnRQCqQssrXv1ApN6Qrdwa3Z9CJTj
=1GzX
-----END PGP SIGNATURE-----

--=-f4hHTSzMe/yKqm7k209f--
