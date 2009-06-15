Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BD761B713E
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Jun 2009 22:36:02 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AE72CDDDA0
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jun 2009 22:36:02 +1000 (EST)
Subject: Re: [PATCH] powerpc: Add configurable -Werror for arch/powerpc
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1245058807.12400.0.camel@pasglop>
References: <adf502e7c85161d77fdcaca24f55ba6b418c7f04.1244616523.git.michael@ellerman.id.au>
	<1245052241.7705.78.camel@concordia> <1245058807.12400.0.camel@pasglop>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-dxtNa53jM06bg+yX9JkQ"
Date: Mon, 15 Jun 2009 22:36:02 +1000
Message-Id: <1245069362.8735.15.camel@concordia>
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


--=-dxtNa53jM06bg+yX9JkQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2009-06-15 at 19:40 +1000, Benjamin Herrenschmidt wrote:
> > Currently this appears to break only one of the defconfigs, chrp32.
> >=20
> > http://kisskb.ellerman.id.au/kisskb/head/1907/
> >=20
> > And that's a legitimate error AFAICT:
> >=20
> > arch/powerpc/platforms/chrp/setup.c:378: error: the frame size of 1040 =
bytes is larger than 1024 bytes
> >=20
> > From:
> >=20
> > 367 void
> > 368 chrp_event_scan(unsigned long unused)
> > 369 {
> > 370         unsigned char log[1024];
> > 371         int ret =3D 0;
>=20
> I wonder to what extent we could merge that with the pSeries
> event-scan...

Yeah that occured to me, someone with a chrp machine would need to test
it, do we have one?

> We can have a closer look tomorrow. In any case, stack alloc for that is
> indeed fishy.

The obvious patch to make it static doesn't fly because it's called on
every cpu via a timer, so it needs to be a per-cpu at least I think. Or
borrow the pseries trick of calling it on each cpu in succession, or
just borrow the pseries code.

cheers

--=-dxtNa53jM06bg+yX9JkQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAko2QDIACgkQdSjSd0sB4dJopQCfcc6PrkH73j3c+1lRqQ2syZPh
wRsAoMOYMl7tTXFFiR+AvEYYKjmrwVS4
=7bM9
-----END PGP SIGNATURE-----

--=-dxtNa53jM06bg+yX9JkQ--
