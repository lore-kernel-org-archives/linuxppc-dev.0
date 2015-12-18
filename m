Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409F11A1A1E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Dec 2015 16:33:52 +1100 (AEDT)
Date: Fri, 18 Dec 2015 16:33:51 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 <linuxppc-dev@lists.ozlabs.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, "Aneesh Kumar
 K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: linux-next: manual merge of the akpm-current tree with the powerpc
 tree
Message-ID: <20151218163351.5bfd2def@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Andrew,

Today's linux-next merge of the akpm-current tree got a conflict in:

  arch/powerpc/include/asm/pgtable.h

between commit:

  ee4889c7bc2a ("powerpc/mm: Don't have generic headers introduce functions touching pte bits")

from the powerpc tree and commit:

  e0e8474c0d55 ("mm, dax, gpu: convert vm_insert_mixed to pfn_t")

from the akpm-current tree.

I fixed it up (the code being changed was moved from this file - I added
the fix up patch below) and can carry the fix as necessary (no action
is required).

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 18 Dec 2015 16:30:47 +1100
Subject: [PATCH] mm, dax, gpu: merge fix for convert vm_insert_mixed to pfn_t

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h | 1 +
 arch/powerpc/include/asm/book3s/64/hash.h    | 1 +
 arch/powerpc/include/asm/nohash/pgtable.h    | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 38b33dcfcc9d..3ed3303c1295 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -313,6 +313,7 @@ static inline int pte_present(pte_t pte)
  * Even if PTEs can be unsigned long long, a PFN is always an unsigned
  * long for now.
  */
+#define pfn_pte pfn_pte
 static inline pte_t pfn_pte(unsigned long pfn, pgprot_t pgprot)
 {
 	return __pte(((pte_basic_t)(pfn) << PTE_RPN_SHIFT) |
diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 9e861b4378bd..6ab967d0da00 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -410,6 +410,7 @@ static inline int pte_present(pte_t pte)
  * Even if PTEs can be unsigned long long, a PFN is always an unsigned
  * long for now.
  */
+#define pfn_pte pfn_pte
 static inline pte_t pfn_pte(unsigned long pfn, pgprot_t pgprot)
 {
 	return __pte(((pte_basic_t)(pfn) << PTE_RPN_SHIFT) |
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index 1263c22d60d8..11e3767216c0 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -49,6 +49,7 @@ static inline int pte_present(pte_t pte)
  * Even if PTEs can be unsigned long long, a PFN is always an unsigned
  * long for now.
  */
+#define pfn_pte pfn_pte
 static inline pte_t pfn_pte(unsigned long pfn, pgprot_t pgprot) {
 	return __pte(((pte_basic_t)(pfn) << PTE_RPN_SHIFT) |
 		     pgprot_val(pgprot)); }
-- 
2.6.2

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
