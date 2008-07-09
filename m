Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 89FFFDDF4C
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 14:24:44 +1000 (EST)
Date: Wed, 9 Jul 2008 14:24:33 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, <linuxppc-dev@ozlabs.org>
Subject: linux-next: powerpc tree build failure
Message-Id: <20080709142433.a7f75900.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__9_Jul_2008_14_24_33_+1000_c7w6xZMqpgVjXEMT"
Cc: linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__9_Jul_2008_14_24_33_+1000_c7w6xZMqpgVjXEMT
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next build (powerpc ppc64_defconfig) failed like this:

In file included from include2/asm/pgtable.h:13,
                 from include/linux/mm.h:39,
                 from include/linux/mman.h:14,
                 from arch/powerpc/kernel/asm-offsets.c:22:
include2/asm/pgtable-ppc64.h:325: error: redefinition of 'huge_ptep_set_wrp=
rotect'
include2/asm/pgtable-ppc64.h:317: error: previous definition of 'huge_ptep_=
set_wrprotect' was here

Caused by the actual merge of the powerpc tree due to commit
86df86424939d316b1f6cfac1b6204f0c7dee317 ("Correct hash flushing from
huge_ptep_set_wrprotect()") from Linus' tree merging with commit
016b33c4958681c24056abed8ec95844a0da80a3 ("powerpc: Add 64 bit version of
huge_ptep_set_wrprotect") from the powerpc tree.

I fixed it up in the actual merge commit.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__9_Jul_2008_14_24_33_+1000_c7w6xZMqpgVjXEMT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkh0PYEACgkQjjKRsyhoI8yjSACZAXJ0c9hTDCDthapyodPBAFTp
BGoAn2PgYMtXNGS3UgcBFGkq1yBiuL/w
=zue2
-----END PGP SIGNATURE-----

--Signature=_Wed__9_Jul_2008_14_24_33_+1000_c7w6xZMqpgVjXEMT--
