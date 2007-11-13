Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id AA61DDDE09
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 11:44:00 +1100 (EST)
Date: Tue, 13 Nov 2007 11:44:01 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: mel@skynet.ie (Mel Gorman)
Subject: Re: Do not depend on MAX_ORDER when grouping pages by mobility
Message-Id: <20071113114401.73d81ce2.sfr@canb.auug.org.au>
In-Reply-To: <20071112155452.GB6653@skynet.ie>
References: <20071112132108.7c98f011.sfr@canb.auug.org.au>
	<20071112155452.GB6653@skynet.ie>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__13_Nov_2007_11_44_01_+1100_O/FaXXonM64cs00Y"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__13_Nov_2007_11_44_01_+1100_O/FaXXonM64cs00Y
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 12 Nov 2007 15:54:53 +0000 mel@skynet.ie (Mel Gorman) wrote:
>
> Ordinarily, the size of a pageblock is determined from the hugepage size.
> On PPC64, the hugepage size is determined at runtime based on the ability
> of the machine. If the machine does not support hugepages, HPAGE_SHIFT is
> 0. This results in pageblock_order being set to -PAGE_SHIFT and a crash
> results shortly afterwards.
>=20
> This patch checks that HPAGE_SHIFT is a sensible value before using the
> hugepage size. If it is 0, MAX_ORDER-1 is used instead as this is a sensi=
ble
> value of pageblock_order.
>=20
> Signed-off-by: Mel Gorman <mel@csn.ul.ie>

Looks good. Legacy iSeries boots fine with this and David Gibson has run
his libhugetlbfs test suite on a Power5+ machine also running the same
kernel (ppc64_defconfig).

I would be good if we could get this in for 2.6.24 (since, as far as
legacy iSeries is concerned, this is a regression from 2.6.23).  I am not
sure what other testing needs to be done.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__13_Nov_2007_11_44_01_+1100_O/FaXXonM64cs00Y
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHOPNWTgG2atn1QN8RAn9lAJ9vnyyXNcj8O7j86uvxwgtru0gmBwCfYAHV
Tvm474VgnZWurMq8NibZgzs=
=MLJt
-----END PGP SIGNATURE-----

--Signature=_Tue__13_Nov_2007_11_44_01_+1100_O/FaXXonM64cs00Y--
