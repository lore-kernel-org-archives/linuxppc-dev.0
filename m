Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41vrTH67SpzF0hg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 23:03:30 +1000 (AEST)
Message-Id: <8097a1d32403ea47d076803e9070869badfe24bc.1534856426.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/nohash: fix pte_access_permitted()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 stable@vger.kernel.org
Date: Tue, 21 Aug 2018 13:03:23 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 5769beaf180a8 ("powerpc/mm: Add proper pte access check helper
for other platforms") replaced generic pte_access_permitted() by an
arch specific one.

The generic one is defined as
(pte_present(pte) && (!(write) || pte_write(pte)))

The arch specific one is open coded checking that _PAGE_USER and
_PAGE_WRITE (_PAGE_RW) flags are set, but lacking to check that
_PAGE_RO and _PAGE_PRIVILEGED are unset, leading to a useless test
on targets like the 8xx which defines _PAGE_RW and _PAGE_USER as 0.

Commit 5fa5b16be5b31 ("powerpc/mm/hugetlb: Use pte_access_permitted
for hugetlb access check") replaced some tests performed with
pte helpers by a call to pte_access_permitted(), leading to the same
issue.

This patch rewrites powerpc/nohash pte_access_permitted()
using pte helpers.

Fixes: 5769beaf180a8 ("powerpc/mm: Add proper pte access check helper for other platforms")
Fixes: 5fa5b16be5b31 ("powerpc/mm/hugetlb: Use pte_access_permitted for hugetlb access check")
Cc: stable@vger.kernel.org # v4.15+
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/pgtable.h | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index 2160be2e4339..b321c82b3624 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -51,17 +51,14 @@ static inline int pte_present(pte_t pte)
 #define pte_access_permitted pte_access_permitted
 static inline bool pte_access_permitted(pte_t pte, bool write)
 {
-	unsigned long pteval = pte_val(pte);
 	/*
 	 * A read-only access is controlled by _PAGE_USER bit.
 	 * We have _PAGE_READ set for WRITE and EXECUTE
 	 */
-	unsigned long need_pte_bits = _PAGE_PRESENT | _PAGE_USER;
-
-	if (write)
-		need_pte_bits |= _PAGE_WRITE;
+	if (!pte_present(pte) || !pte_user(pte) || !pte_read(pte))
+		return false;
 
-	if ((pteval & need_pte_bits) != need_pte_bits)
+	if (write && !pte_write(pte))
 		return false;
 
 	return true;
-- 
2.13.3
