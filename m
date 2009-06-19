Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by bilbo.ozlabs.org (Postfix) with ESMTP id E995AB71D0
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 16:30:24 +1000 (EST)
Date: Fri, 19 Jun 2009 16:30:21 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: linux-next: origin tree build failure
Message-Id: <20090619163021.8ae4c588.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__19_Jun_2009_16_30_21_+1000_7ObvBuuUABKfXRC3"
Cc: Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, linux-next@vger.kernel.org,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-kernel@vger.kernel.org, Geert
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Fri__19_Jun_2009_16_30_21_+1000_7ObvBuuUABKfXRC3
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next build (powerpc64, gcc 4.1.3) failed like this:

drivers/video/logo/logo_linux_mono.c:11: error: logo_linux_mono_data causes=
 a section type conflict

Caused by commit ae52bb2384f721562f15f719de1acb8e934733cb ("fbdev: move
logo externs to header file") but probably really a compiler bug as gcc
4.3 and 4.4 do not get this error.  I have reverted that commit for
today, but we really need some workaround as gcc 4.1.3 is not uncommon.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__19_Jun_2009_16_30_21_+1000_7ObvBuuUABKfXRC3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAko7MH0ACgkQjjKRsyhoI8x+8wCfQ4lW8oNK9v1Uun0tG3nOmVVe
iFUAn2r5XwH1dhJ2b7MaFSQaDFV8TLiW
=B0ex
-----END PGP SIGNATURE-----

--Signature=_Fri__19_Jun_2009_16_30_21_+1000_7ObvBuuUABKfXRC3--
