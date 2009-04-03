Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 81C07DDDEE
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2009 21:58:00 +1100 (EST)
Subject: Re: Interrupt ID number on mpc8347
From: Michael Ellerman <michael@ellerman.id.au>
To: yamazaki seiji <yamazaki.seiji@kk.jp.panasonic.com>
In-Reply-To: <20090403163928.4679.YAMAZAKI.SEIJI@kk.jp.panasonic.com>
References: <20090403163928.4679.YAMAZAKI.SEIJI@kk.jp.panasonic.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-gSA1PcIUZXWoX9Zxer9X"
Date: Fri, 03 Apr 2009 21:57:59 +1100
Message-Id: <1238756279.9595.15.camel@localhost>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-gSA1PcIUZXWoX9Zxer9X
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2009-04-03 at 16:51 +0900, yamazaki seiji wrote:
> I set the Interrupt ID number 17.
> But kernel gives the Interrupt ID number 19.
>=20
> I wont to know the reasen.
> Please tell me.

It's because the irqs are remapped by the kernel, the number in the
device tree is a hardware irq number. The number you're printing out is
a virtual irq number.

of_irq_to_resource() is doing the remapping for you.

You can turn on CONFIG_VIRQ_DEBUG and you'll get a file in debugfs that
shows the mapping between hardware numbers and virtual numbers.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-gSA1PcIUZXWoX9Zxer9X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAknV67cACgkQdSjSd0sB4dJk/ACfcHo9Sw1TE9beaNzhzxHSCd2F
VW4AmQGUabO9TAkzamM9/jtMvxNARtT+
=VY6u
-----END PGP SIGNATURE-----

--=-gSA1PcIUZXWoX9Zxer9X--
