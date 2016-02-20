Return-Path: <ben@decadent.org.uk>
Received: from shadbolt.e.decadent.org.uk (shadbolt.e.decadent.org.uk
 [88.96.1.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EC2821A0A00
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Feb 2016 05:17:38 +1100 (AEDT)
Received: from ben by shadbolt.decadent.org.uk with local (Exim 4.84)
 (envelope-from <ben@decadent.org.uk>) id 1aXBnh-0004Oj-2J
 for linuxppc-dev@lists.ozlabs.org; Sat, 20 Feb 2016 17:58:38 +0000
Date: Sat, 20 Feb 2016 17:58:37 +0000
From: Ben Hutchings <ben@decadent.org.uk>
To: linuxppc-dev@lists.ozlabs.org
Message-ID: <20160220175836.GA14491@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Subject: powerpc/mm: Fix HAVE_ARCH_SOFT_DIRTY dependencies
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Soft dirty bit support was only implemented for 64-bit Book3S, and
32-bit configurations currently fail to build.

Fixes: 7207f43665b8 ("powerpc/mm: Add page soft dirty tracking")
References: https://buildd.debian.org/status/fetch.php?pkg=3Dlinux&arch=3Dp=
owerpc&ver=3D4.5%7Erc4-1%7Eexp1&stamp=3D1455791718
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -557,7 +557,7 @@ choice
=20
 config PPC_4K_PAGES
 	bool "4k page size"
-	select HAVE_ARCH_SOFT_DIRTY if CHECKPOINT_RESTORE && PPC_BOOK3S
+	select HAVE_ARCH_SOFT_DIRTY if CHECKPOINT_RESTORE && PPC_BOOK3S_64
=20
 config PPC_16K_PAGES
 	bool "16k page size"
@@ -566,7 +566,7 @@ config PPC_16K_PAGES
 config PPC_64K_PAGES
 	bool "64k page size"
 	depends on !PPC_FSL_BOOK3E && (44x || PPC_STD_MMU_64 || PPC_BOOK3E_64)
-	select HAVE_ARCH_SOFT_DIRTY if CHECKPOINT_RESTORE && PPC_BOOK3S
+	select HAVE_ARCH_SOFT_DIRTY if CHECKPOINT_RESTORE && PPC_BOOK3S_64
=20
 config PPC_256K_PAGES
 	bool "256k page size"

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBVsipTOe/yOyVhhEJAQqnoxAA0xl6oBz23XjkSGY8o5KEIz+A6qYF4kOe
euOgg/AjqHRmS1EBpWOkdBNy7EumiNSAKKDZDdb9ldGbDTOUg14bZMbyqGevWP91
B/aH1WkLe89F3f4pH8sppVHPTQzcCuPbzTePLe4171A4ShxXNI+ynFSkbI68Bmyn
8MLuj1rYIkNs0i0qnqWSkXDgzTXNLs8bZEEtZzJVYpXqOoCqM4miMbyT9oI5McCM
5oTr2UGnlkMetUdVt63m+/eu2R20jKPkvnJ5D892XlcD1VuvVMkm3pciePIS/ird
Snu2HoO0aw6aATgJxkFfETG7IfzCu8kt2UB/lz8AXpl+HERM8oZzvDPG77FomS1i
1aQj8J5g83B92SjI2HxCqPIWB7yc2W+GxCEN49F0nROfSgXxAcAbAIaaQy6PIh2B
51TbaSmhbLq5+g6cIzWGho9Fm73D2bZYAuya1dbWJzP/kZtufSXBZZmY20ebY2oR
NGC3XSLrrE4Xys+0Lv5vNLpfmBLMJWrbRJLVxIcCtZZEJrKzJ9TvZEGVedSMVOV4
b35ibSwuHbq7ihFa+EPh0K2DUT+MKoupveF8gfS39+ZomLH2IgllKgGqZqL/yS1G
OQus97OGmI/Ra9c9g0SaOQfX54DGqJh8G8xIT3+Ham0QjkGodbd2unIY/4e1Z6FM
uMBWZaAps44=
=v+Ci
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
