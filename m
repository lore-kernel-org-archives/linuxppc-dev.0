Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 17177DDFD7
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 23:42:03 +1000 (EST)
Subject: Re: Executing from readablee, no-exec pages
From: Johannes Berg <johannes@sipsolutions.net>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <9E7F4501-6F8F-430B-AC14-8DCDE437A2F9@kernel.crashing.org>
References: <468D68D4.4050704@freescale.com>
	<1183720722.3818.126.camel@johannes.berg>
	<9E7F4501-6F8F-430B-AC14-8DCDE437A2F9@kernel.crashing.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-J6iwYLizIZdBVJ71ETeh"
Date: Fri, 06 Jul 2007 15:43:00 +0200
Message-Id: <1183729380.3779.9.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-J6iwYLizIZdBVJ71ETeh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-07-06 at 15:36 +0200, Segher Boessenkool wrote:

> > Umm, are you sure about this? The "prevent data exception in kernel
> > space" patch came from a test program I had that attempted to =20
> > execute a
> > page with /no permissions/ at all!
>=20
> I haven't looked at the code path in detail, but I believe Scott's
> analysis is correct.  The kernel would merrily let a program run
> code from a page without execute permission (so also from a page
> without any permissions at all); not anymore, after my patch.
>=20
> Programs relying on this behaviour are obviously buggy, but the
> problem is that one of these broken programs is glibc, at least
> some not-all-that-new but also not-all-that-old versions.

Ok I can see how your patch changes that if the page is readable but not
executable and hasn't been faulted in yet, then executing it will kill
the program. However, reading first (prefaulting) and then executing
code on the page will not kill the program.

> Too many negatives, I don't see which way you're arguing :-)

Heh.

> I think you're saying to treat read access as including execute
> access?  I believe that would be too permissive here.

Yeah well what I was trying to say is that there's no point in having
read without execute if prefaulting the page can get you around that.

johannes

--=-J6iwYLizIZdBVJ71ETeh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGjkbj/ETPhpq3jKURAsj7AKCZCaLEk62XHM/weH/LWYjJYJNO3QCfS8Xb
MJXO1ae6uw1RygaBI4sW00Q=
=LFCw
-----END PGP SIGNATURE-----

--=-J6iwYLizIZdBVJ71ETeh--
