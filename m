Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EABC04EB9
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 06:47:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F97F214DA
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 06:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jPpg2hkA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F97F214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439R3S2GbvzDr7f
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 17:47:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jPpg2hkA";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439R0L27QczDqk7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2018 17:44:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="jPpg2hkA"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 439R0K4r5wz9s7W;
 Thu,  6 Dec 2018 17:44:17 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1544078657;
 bh=KA7wdu/XaKITc7uOXSgS2CDTxzM9KyNLWBBesTq2rmA=;
 h=Date:From:To:Cc:Subject:From;
 b=jPpg2hkAgjrzWiqHu7HWIN+recVRX9W16R3cjTWSitbUpaLWmtUZLyrg3tX2RjfCI
 KxJ+ik7kEnyUznt2xg9sVw62MMtST+1UR6DDK5biM6ohwnjAMbyfXsqCJr4irSeGh2
 6W3XsIcEA5IObZ+ChG2poTtOZCQuluLWd5GHzfjt8SVFjak3CzKp4iJy+31W3kvJyw
 Wgl0vlQ7K7qH/0JfDPGIicU67eJAp53OiwR9HS0+wAjnnqaz0seZ2jClY5bZ/drPJs
 wrDrFk5zxFKSj3irNqS4JD2KfFNjj65p0U9TRVxgWe4Fv/ktQEFbaXuu37lULseNN9
 5+IbMSJC4bNhA==
Date: Thu, 6 Dec 2018 17:44:17 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: manual merge of the akpm-current tree with the powerpc
 tree
Message-ID: <20181206174417.45fe3e7a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/.zLNjQH4ObXZYR53yJAEYhH"; protocol="application/pgp-signature"
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: "Joel Fernandes \(Google\)" <joel@joelfernandes.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/.zLNjQH4ObXZYR53yJAEYhH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Today's linux-next merge of the akpm-current tree got conflicts in:

  arch/powerpc/include/asm/book3s/32/pgalloc.h
  arch/powerpc/include/asm/nohash/32/pgalloc.h
  arch/powerpc/mm/pgtable-book3s64.c

between commits:

  a95d133c8643 ("powerpc/mm: Move pte_fragment_alloc() to a common location=
")
  32ea4c149990 ("powerpc/mm: Extend pte_fragment functionality to PPC32")

from the powerpc tree and commit:

  913c2d755b39 ("mm: treewide: remove unused address argument from pte_allo=
c functions")

from the akpm-current tree.

I fixed it up (see below, plus the extra merge fix patch) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 6 Dec 2018 17:41:27 +1100
Subject: [PATCH] fix up for "mm: treewide: remove unused address argument f=
rom
 pte_alloc functions"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/mm/pgtable-frag.c | 2 +-
 arch/powerpc/mm/pgtable_32.c   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-frag.c b/arch/powerpc/mm/pgtable-frag.c
index af23a587f019..a7b05214760c 100644
--- a/arch/powerpc/mm/pgtable-frag.c
+++ b/arch/powerpc/mm/pgtable-frag.c
@@ -95,7 +95,7 @@ static pte_t *__alloc_for_ptecache(struct mm_struct *mm, =
int kernel)
 	return (pte_t *)ret;
 }
=20
-pte_t *pte_fragment_alloc(struct mm_struct *mm, unsigned long vmaddr, int =
kernel)
+pte_t *pte_fragment_alloc(struct mm_struct *mm, int kernel)
 {
 	pte_t *pte;
=20
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index deda68e02338..5b1e1adeb4d2 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -48,12 +48,12 @@ __ref pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 	if (!slab_is_available())
 		return memblock_alloc(PTE_FRAG_SIZE, PTE_FRAG_SIZE);
=20
-	return (pte_t *)pte_fragment_alloc(mm, address, 1);
+	return (pte_t *)pte_fragment_alloc(mm, 1);
 }
=20
 pgtable_t pte_alloc_one(struct mm_struct *mm)
 {
-	return (pgtable_t)pte_fragment_alloc(mm, address, 0);
+	return (pgtable_t)pte_fragment_alloc(mm, 0);
 }
=20
 void __iomem *
--=20
2.19.1

--=20
Cheers,
Stephen Rothwell

diff --cc arch/powerpc/include/asm/book3s/32/pgalloc.h
index b5b955eb2fb7,af9e13555d95..000000000000
--- a/arch/powerpc/include/asm/book3s/32/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/32/pgalloc.h
@@@ -56,16 -61,29 +56,16 @@@ static inline void pmd_populate_kernel(
  static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
  				pgtable_t pte_page)
  {
 -	*pmdp =3D __pmd((page_to_pfn(pte_page) << PAGE_SHIFT) | _PMD_PRESENT);
 -}
 -
 -#define pmd_pgtable(pmd) pmd_page(pmd)
 -#else
 -
 -static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp,
 -				       pte_t *pte)
 -{
 -	*pmdp =3D __pmd((unsigned long)pte | _PMD_PRESENT);
 -}
 -
 -static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
 -				pgtable_t pte_page)
 -{
 -	*pmdp =3D __pmd((unsigned long)lowmem_page_address(pte_page) | _PMD_PRES=
ENT);
 +	*pmdp =3D __pmd(__pa(pte_page) | _PMD_PRESENT);
  }
 =20
 -#define pmd_pgtable(pmd) pmd_page(pmd)
 -#endif
 +#define pmd_pgtable(pmd) ((pgtable_t)pmd_page_vaddr(pmd))
 =20
- extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long ad=
dr);
- extern pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long addr);
+ extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm);
+ extern pgtable_t pte_alloc_one(struct mm_struct *mm);
 +void pte_frag_destroy(void *pte_frag);
- pte_t *pte_fragment_alloc(struct mm_struct *mm, unsigned long vmaddr, int=
 kernel);
++pte_t *pte_fragment_alloc(struct mm_struct *mm, int kernel);
 +void pte_fragment_free(unsigned long *table, int kernel);
 =20
  static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
  {
diff --cc arch/powerpc/include/asm/nohash/32/pgalloc.h
index 17963951bdb0,16623f53f0d4..000000000000
--- a/arch/powerpc/include/asm/nohash/32/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/32/pgalloc.h
@@@ -73,17 -77,14 +73,17 @@@ static inline void pmd_populate_kernel(
  static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
  				pgtable_t pte_page)
  {
 -	*pmdp =3D __pmd((unsigned long)lowmem_page_address(pte_page) | _PMD_PRES=
ENT);
 +	*pmdp =3D __pmd((unsigned long)pte_page | _PMD_PRESENT);
  }
 =20
 -#define pmd_pgtable(pmd) pmd_page(pmd)
 +#define pmd_pgtable(pmd) ((pgtable_t)pmd_page_vaddr(pmd))
  #endif
 =20
- extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long ad=
dr);
- extern pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long addr);
+ extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm);
+ extern pgtable_t pte_alloc_one(struct mm_struct *mm);
 +void pte_frag_destroy(void *pte_frag);
- pte_t *pte_fragment_alloc(struct mm_struct *mm, unsigned long vmaddr, int=
 kernel);
++pte_t *pte_fragment_alloc(struct mm_struct *mm, int kernel);
 +void pte_fragment_free(unsigned long *table, int kernel);
 =20
  static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
  {
diff --cc arch/powerpc/mm/pgtable-book3s64.c
index f3c31f5e1026,6f9d434b0a4c..000000000000
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c

--Sig_/.zLNjQH4ObXZYR53yJAEYhH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwIxUEACgkQAVBC80lX
0GxUpAf/farV5+yCU8Lalv6I1lW9uxsa/pfQPJuU4b3PCIZNqPSawTtqgsrbaFJh
WR0GWyPIHQDCFeXLZYvfKoBRnL2jiktDvciFSAGlsYAweko2f/DCXd+1lDcbKf7M
gnaO3XM9uTI4JE1/LXy/CW48nIoAk2wUYTPAXt5cDZmLUUg3PAWA/I0zenj/EDET
YAa9UO2MqW/9jOQMG1IETtLd5DdSXI5nRPShAwSgt68tQwSVhLWHJmJW2p1IiSNT
kYAqEKG7kyyId+eSugQb2b0AoB+Tw1Sx000dOIIyVDy6aZ0dbQQywMRdfStHy3dC
NOJB/4EE916seYmURAhI7k6yvCUMuA==
=oT1P
-----END PGP SIGNATURE-----

--Sig_/.zLNjQH4ObXZYR53yJAEYhH--
