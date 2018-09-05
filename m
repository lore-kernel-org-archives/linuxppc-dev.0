Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42539q45HgzF1nv
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2018 22:37:02 +1000 (AEST)
Message-Id: <256474e6e539263447dae1da9d373cedd8cb22de.1535913369.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1535913369.git.christophe.leroy@c-s.fr>
References: <cover.1535913369.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v1 04/17] powerpc/mm: move some nohash pte helpers in
 nohash/[32:64]/pgtable.h
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 npiggin@gmail.com, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed,  5 Sep 2018 12:36:59 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In order to allow their use in nohash/32/pgtable.h, we have to move the
following helpers in nohash/[32:64]/pgtable.h:
- pte_mkwrite()
- pte_mkdirty()
- pte_mkyoung()
- pte_wrprotect()

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/32/pgtable.h | 28 ++++++++++++++++++++++++++++
 arch/powerpc/include/asm/nohash/64/pgtable.h | 20 ++++++++++++++++++++
 arch/powerpc/include/asm/nohash/pgtable.h    | 28 ----------------------------
 3 files changed, 48 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index a507a65b0866..3ee4ae5d28c3 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -136,6 +136,34 @@ extern int icache_44x_need_flush;
 #define pte_clear(mm, addr, ptep) \
 	do { pte_update(ptep, ~0, 0); } while (0)
 
+static inline pte_t pte_mkwrite(pte_t pte)
+{
+	pte_basic_t ptev;
+
+	ptev = pte_val(pte) & ~_PAGE_RO;
+	ptev |= _PAGE_RW;
+	return __pte(ptev);
+}
+
+static inline pte_t pte_mkdirty(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_DIRTY);
+}
+
+static inline pte_t pte_mkyoung(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_ACCESSED);
+}
+
+static inline pte_t pte_wrprotect(pte_t pte)
+{
+	pte_basic_t ptev;
+
+	ptev = pte_val(pte) & ~(_PAGE_RW | _PAGE_HWWRITE);
+	ptev |= _PAGE_RO;
+	return __pte(ptev);
+}
+
 #define pmd_none(pmd)		(!pmd_val(pmd))
 #define	pmd_bad(pmd)		(pmd_val(pmd) & _PMD_BAD)
 #define	pmd_present(pmd)	(pmd_val(pmd) & _PMD_PRESENT_MASK)
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index 7cd6809f4d33..60d3bdd13ba1 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -94,6 +94,26 @@
 #ifndef __ASSEMBLY__
 /* pte_clear moved to later in this file */
 
+static inline pte_t pte_mkwrite(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_RW);
+}
+
+static inline pte_t pte_mkdirty(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_DIRTY);
+}
+
+static inline pte_t pte_mkyoung(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_ACCESSED);
+}
+
+static inline pte_t pte_wrprotect(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~_PAGE_RW);
+}
+
 #define PMD_BAD_BITS		(PTE_TABLE_SIZE-1)
 #define PUD_BAD_BITS		(PMD_TABLE_SIZE-1)
 
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index 5b82e44c4231..c746e9e784cd 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -77,15 +77,6 @@ static inline unsigned long pte_pfn(pte_t pte)	{
 	return pte_val(pte) >> PTE_RPN_SHIFT; }
 
 /* Generic modifiers for PTE bits */
-static inline pte_t pte_wrprotect(pte_t pte)
-{
-	pte_basic_t ptev;
-
-	ptev = pte_val(pte) & ~(_PAGE_RW | _PAGE_HWWRITE);
-	ptev |= _PAGE_RO;
-	return __pte(ptev);
-}
-
 static inline pte_t pte_mkclean(pte_t pte)
 {
 	return __pte(pte_val(pte) & ~(_PAGE_DIRTY | _PAGE_HWWRITE));
@@ -96,25 +87,6 @@ static inline pte_t pte_mkold(pte_t pte)
 	return __pte(pte_val(pte) & ~_PAGE_ACCESSED);
 }
 
-static inline pte_t pte_mkwrite(pte_t pte)
-{
-	pte_basic_t ptev;
-
-	ptev = pte_val(pte) & ~_PAGE_RO;
-	ptev |= _PAGE_RW;
-	return __pte(ptev);
-}
-
-static inline pte_t pte_mkdirty(pte_t pte)
-{
-	return __pte(pte_val(pte) | _PAGE_DIRTY);
-}
-
-static inline pte_t pte_mkyoung(pte_t pte)
-{
-	return __pte(pte_val(pte) | _PAGE_ACCESSED);
-}
-
 static inline pte_t pte_mkspecial(pte_t pte)
 {
 	return __pte(pte_val(pte) | _PAGE_SPECIAL);
-- 
2.13.3
