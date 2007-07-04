Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1CED1DDEFA
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jul 2007 18:35:44 +1000 (EST)
Subject: Re: powerpc stacktrace and lockdep support
From: Johannes Berg <johannes@sipsolutions.net>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20070630085808.GA15386@lst.de>
References: <20070108135458.GA23395@lst.de>
	<1182898073.4769.6.camel@johannes.berg>
	<1182970829.4769.62.camel@johannes.berg>
	<1183047642.3735.0.camel@johannes.berg> <20070630085808.GA15386@lst.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-/SegP9B7kYKvstgIKgVd"
Date: Thu, 05 Jul 2007 00:40:14 +0200
Message-Id: <1183588814.3818.1.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-/SegP9B7kYKvstgIKgVd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2007-06-30 at 10:58 +0200, Christoph Hellwig wrote:
> On Thu, Jun 28, 2007 at 06:20:42PM +0200, Johannes Berg wrote:
> > This one doesn't break 32-bit build by simply disabling irqtrace for
> > 32-bit.
>=20
> This looks really cool to me.  I'd love to see this in 2.6.23.

Hmm. Looks like I just found a case where I forgot to trace in some
place:

[  241.629380] hardirqs last  enabled at (1319): [<c0000000000b3718>] .get_=
page_from_freelist+0x298/0x620
[  241.629714] hardirqs last disabled at (1320): [<c000000000033690>] .nati=
ve_hpte_invalidate+0x60/0x320
[  241.629732] softirqs last  enabled at (1282): [<c000000000059e28>] .__do=
_softirq+0x198/0x1e0
[  241.629748] softirqs last disabled at (1273): [<c00000000000c7e4>] .do_s=
oftirq+0xd4/0xe0

I'll look into it when I get around.

johannes

--=-/SegP9B7kYKvstgIKgVd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGjCHO/ETPhpq3jKURAv13AJ4ma/7vl2PCYIW5QF7hihBjAeIfXgCeMLGA
bDit5af9zmzDrem7T5ZZDLU=
=CGCO
-----END PGP SIGNATURE-----

--=-/SegP9B7kYKvstgIKgVd--
