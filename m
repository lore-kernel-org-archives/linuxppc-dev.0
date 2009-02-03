Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 18FD5DDF3E
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Feb 2009 21:03:24 +1100 (EST)
Date: Tue, 3 Feb 2009 21:03:11 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Sachin P. Sant" <sachinp@in.ibm.com>
Subject: Re: [PowerPC] 2.6.29-rc3-git4 build break : truncated relocation
Message-Id: <20090203210311.45fcad19.sfr@canb.auug.org.au>
In-Reply-To: <49880C42.8060702@in.ibm.com>
References: <49880C42.8060702@in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__3_Feb_2009_21_03_11_+1100_J7rAUZW3+vqg_ifu"
Cc: Mel Gorman <mel@csn.ul.ie>, linuxppc-dev@ozlabs.org,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__3_Feb_2009_21_03_11_+1100_J7rAUZW3+vqg_ifu
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sachin,

To make allyesconfig build currently, you need to turn
CONFIG_PROFILE_ALL_BRANCHES off.  It makes drivers/built-in.o too large
(increases the text size from about 32M to 47M) and the linker can't add
the usual trampolines because we prelink it.

Paulus suggested an old solution, but it seemed to hit a binutils
limitation.  I will have another try ...
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__3_Feb_2009_21_03_11_+1100_J7rAUZW3+vqg_ifu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmIFl8ACgkQjjKRsyhoI8xqHwCgpRxDKaYKHvC80XluboMLhxdt
vSMAoLH8atapb1g27isZWwLEpGF6K3Rn
=PPpU
-----END PGP SIGNATURE-----

--Signature=_Tue__3_Feb_2009_21_03_11_+1100_J7rAUZW3+vqg_ifu--
