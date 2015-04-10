Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A17951A09FA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 20:02:45 +1000 (AEST)
Date: Fri, 10 Apr 2015 20:02:40 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, <linuxppc-dev@lists.ozlabs.org>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: linux-next: build failure after merge of the powerpc-mpe tree
Message-ID: <20150410200240.13471ce4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/=sTlS/Twty6TfvK4Cu2V34u"; protocol="application/pgp-signature"
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/=sTlS/Twty6TfvK4Cu2V34u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the powerpc-mpe tree, today's linux-next build (powerpc
allyesconfig) failed like this:

mm/gup.c: In function 'gup_pte_range':
mm/gup.c:904:3: error: conversion to non-scalar type requested
   pte_t pte =3D ACCESS_ONCE(*ptep);
   ^
mm/gup.c: In function '__get_user_pages_fast':
mm/gup.c:1194:3: error: conversion to non-scalar type requested
   pgd_t pgd =3D ACCESS_ONCE(*pgdp);
   ^

Caused by commit 4bcad5b3b3ea ("powerpc: Make STRICT_MM_TYPECHECKS a
config option").

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/=sTlS/Twty6TfvK4Cu2V34u
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVJ5/EAAoJEMDTa8Ir7ZwVOdcP+wZWXBwG9EuQrQza4qBLISqS
8Zbe+TaEekn3eyK9cIwBp36HQ8iPTj1TbMHRl9ov7zAmaIeJf3MnGI1yWg7YCrzx
+kYB44+95xLj1fiyPO5jZ4fxIm+eUOlzkO9aCknvH2pApv4J8s//42FwtmxA6iNL
xZtBpKHK5pTSLSdImQfCWXY5d7FurAHXvlv33ceNtgVCuuLBkNmhIB/5F5+zlIA/
JcxEJBZ+gmUc+1ZOBX39o87YU3c6dvJnr9allER+z+rwKbo1F05xpDr+Dv2DZkwd
1Ip0Swg4eekJjV7xRqNtnAErRdHGeWFMLlT4zkivczMYdE2xd1kz9L5ilqFfxLxM
HEQxSlPmWr9ZcsrekTS+fDCQlbZpASLms/XJrQVYdqzpIEWpGMiLkrRq3X/1xO1O
n/m8D6LSFT1u2tQc07VFOLVREqF6vZaoQL0T35xtKfmAiyTin3bRWgg/Q81euMz9
w+WX1sByhk2fcgAvgeme0MtqE07wgTaVrNwfCAJhcD8BF3UoCQyNV3+ziy+TzZWW
p0SI/tN4u2czSq6n4TDSNzzme30BejdZc4kWGMw0UY/MYrMphihpEyxAZ8XS9U5D
UKNDqOZG08l5Q0OchLNyZ4ufA5vLy9HlHAUh3SfWg2xCcfmIUDALY+RkKg/YlKVy
X+mLOD2Bzdz8G9F3HacN
=VR61
-----END PGP SIGNATURE-----

--Sig_/=sTlS/Twty6TfvK4Cu2V34u--
