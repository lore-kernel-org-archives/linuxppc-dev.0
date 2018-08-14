Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41qpV46YWjzDrYf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Aug 2018 09:20:12 +1000 (AEST)
Date: Wed, 15 Aug 2018 09:19:45 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Diana Craciun <diana.craciun@nxp.com>
Subject: linux-next: manual merge of the powerpc tree with Linus' tree
Message-ID: <20180815091945.16b2ead9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/eOa9bvzEeNV/i6qES_KhouF"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/eOa9bvzEeNV/i6qES_KhouF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the powerpc tree got a conflict in:

  Documentation/admin-guide/kernel-parameters.txt

between commits:

  05736e4ac13c ("cpu/hotplug: Provide knobs to control SMT")
  506a66f37489 ("Revert "x86/apic: Ignore secondary threads if nosmt=3Dforc=
e"")

from Linus' tree and commit:

  26cb1f36c43e ("Documentation: Add nospectre_v1 parameter")

from the powerpc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/admin-guide/kernel-parameters.txt
index 5a67e409d370,4167bbea51e1..000000000000
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@@ -2761,10 -2687,10 +2761,14 @@@
  	nosmt		[KNL,S390] Disable symmetric multithreading (SMT).
  			Equivalent to smt=3D1.
 =20
 +			[KNL,x86] Disable symmetric multithreading (SMT).
 +			nosmt=3Dforce: Force disable SMT, cannot be undone
 +				     via the sysfs control file.
 +
+ 	nospectre_v1	[PPC] Disable mitigations for Spectre Variant 1 (bounds
+ 			check bypass). With this option data leaks are possible
+ 			in the system.
+=20
  	nospectre_v2	[X86] Disable all mitigations for the Spectre variant 2
  			(indirect branch prediction) vulnerability. System may
  			allow data leaks with this option, which is equivalent

--Sig_/eOa9bvzEeNV/i6qES_KhouF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltzY5EACgkQAVBC80lX
0GxLoAf+ICsDkgWQEtbkv5uSmmzKHAuvyGjRsEdxd6t4UEHyhqH17jOxVNALCnSS
yFf6xCAqDe08T006mSRKtji48cJAwTTzSvidQVlm6+QA0rQMmyzKprxtFQunAYyx
HUl5KhFzL8ZuuASDZcdlRfayt5/Ve4p+Wp5N4YknUpagHQ9XQzoizQUVp+UwSErb
2lyaebPZP4A2SZc4gxndxvlO/pLLpEnzrESzrIb4p1fD3NB0hYvnA7QcSoUmR4v4
KC9gHzcJoFEyqbywZUSxLzEk2qRsjhkfNdUCoJdkwQ9YPM3/ows8g01DgDi/sk49
3dxwTZLuLOGopdzA6SIK6GUdaNrsjA==
=Cpuw
-----END PGP SIGNATURE-----

--Sig_/eOa9bvzEeNV/i6qES_KhouF--
