Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 8FCFCDDDEF
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jul 2008 17:03:06 +1000 (EST)
Date: Mon, 14 Jul 2008 17:03:01 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: build error in powerpc tree
Message-Id: <20080714170301.93f940fd.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__14_Jul_2008_17_03_01_+1000_LhbmzSf_ZjEqrDRz"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>,
	Dave Kleikamp <shaggy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__14_Jul_2008_17_03_01_+1000_LhbmzSf_ZjEqrDRz
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ben,

Commit ef3d3246a0d06be622867d21af25f997aeeb105f ("powerpc/mm: Add Strong
Access Ordering support") in the powerpc/{next,master} tree caused the
following in a powerpc allmodconfig build:

usr/include/asm/mman.h requires linux/mm.h, which does not exist in exporte=
d headers

Also, that header file is now using CONFIG_PPC64 which we should not do
in the unprotected (by #ifdef __KERNEL__) part an exported header file,
we should use __powerpc64__ instead.

I suspect all the CONFIG_PPC64 part of the file could be surrounded by
#ifdef __KERNEL__ and the include of <linux/mm.h> could be moved to this
section.  The file should then be changed to unifdef-y from header-y in
the Kbuild file.  (Might have been easier to send a patch :-))

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__14_Jul_2008_17_03_01_+1000_LhbmzSf_ZjEqrDRz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkh6+iUACgkQjjKRsyhoI8y1tgCgt9LLyG1OOjohl8kPsmwd3ILK
chkAnibTJkfcYCrr3AowpKhuxwkmmWGL
=ef2a
-----END PGP SIGNATURE-----

--Signature=_Mon__14_Jul_2008_17_03_01_+1000_LhbmzSf_ZjEqrDRz--
