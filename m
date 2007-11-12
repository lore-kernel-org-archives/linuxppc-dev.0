Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 0E0B7DDEBD
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Nov 2007 13:21:13 +1100 (EST)
Date: Mon, 12 Nov 2007 13:21:08 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: Do not depend on MAX_ORDER when grouping pages by mobility
Message-Id: <20071112132108.7c98f011.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__12_Nov_2007_13_21_08_+1100_MW1BEK0X86RNiLsm"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__12_Nov_2007_13_21_08_+1100_MW1BEK0X86RNiLsm
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mel,

I discovered recently that a kernel built with ppc64_defconfig no longer
boots on legacy iSeries.  It did in 2.6.23.  I bisected down the commit
d9c2340052278d8eb2ffb16b0484f8f794def4de ("Do not depend on MAX_ORDER
when grouping pages by mobility") which fails while its parent is ok.
Also, an iseries_defconfig kernel will boot.  The reason it seem is
because on PowerPC 64 with CONFIG_HUGETLB_PAGE, HPAGE_SHIFT is not
constant and its value is determined at runtime early.

For legacy iSeries HPAGE_SHIFT remains 0 which means that
HUGETLB_PAGE_ORDER becomes -PAGE_SHIFT and things degenerate badly.

I can enable CONFIG_HUGETLB_PAGE_SIZE_VARIABLE for PowerPC 64, but I
still need to know a good value for HPAGE_SHIFT.  Do you have a
suggestion?  Is there a better way to fix this problem?  There are places
in the PowerPC code that assume that HPAGE_SHIFT =3D=3D 0 means that we have
no huge pages.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__12_Nov_2007_13_21_08_+1100_MW1BEK0X86RNiLsm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHN7ibTgG2atn1QN8RAu/CAJ9bQsKz7XFjF9Nwc5muR+dnqshj2gCcClSc
QgEdMKpbgrq3mfBquKCdB8U=
=yIJl
-----END PGP SIGNATURE-----

--Signature=_Mon__12_Nov_2007_13_21_08_+1100_MW1BEK0X86RNiLsm--
