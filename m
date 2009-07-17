Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5FB99B70E5
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jul 2009 17:53:47 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 51025DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Jul 2009 17:53:47 +1000 (EST)
Subject: Re: rtas instantiation when commandline contains mem
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Krill <ben@codiert.org>
In-Reply-To: <20090717063620.GC22901@codiert.org>
References: <20090716131246.GB22901@codiert.org>
	<1247783770.27937.61.camel@pasglop>
	<20090717063620.GC22901@codiert.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-aKGSmjiOfl6ud03nGVTe"
Date: Fri, 17 Jul 2009 17:53:46 +1000
Message-Id: <1247817226.19156.5.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-aKGSmjiOfl6ud03nGVTe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2009-07-17 at 08:36 +0200, Benjamin Krill wrote:
> >> the rtas instantiation (prom_init.c) doesn't work correctly if the
> >> kernel parameter "mem=3D" is used. The current code doesn't evaluate
> >> the kernel parameter which causes the issue that alloc_down
> >> allocates somewhere in the "real" memory space. So it can
> >> happen that the allocation space is above "mem=3D".
> >>=20
> >> Commit 2babf5c2ec2f2d5de3e38d20f7df7fd815fd10c9 removes the
> >> evaluation of "mem=3D".
> >
> >Ah yes, we don't constraint prom_init.c to mem=3D, only the kernel
>=20
> Is that with intent? Or should I provide a patch to include it again?

It was, it seemed to me that mem=3Dx was about limiting kernel memory,
which RTAS isn't really. But I guess it depends how you look at it, and
what you're trying to do.

cheers

--=-aKGSmjiOfl6ud03nGVTe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkpgLgoACgkQdSjSd0sB4dLkygCePFdmgJleio4jaCdAqZi2AvLe
qZgAoIQBnddV42Lyy1P3ngv/vc+WsxYO
=/91K
-----END PGP SIGNATURE-----

--=-aKGSmjiOfl6ud03nGVTe--
