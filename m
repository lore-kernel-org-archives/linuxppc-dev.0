Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 2E96A1A0A07
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Dec 2014 05:01:16 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Subject: [PATCH 1/4] powerpc32: misuse of accessors to pte_t objects
Message-Id: <20141210180033.71D4A1A5D62@localhost.localdomain>
Date: Wed, 10 Dec 2014 19:00:33 +0100 (CET)
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pte_val() is not meant to be used as L value.
__pte() has to be used to assign value to pte_t.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
 arch/powerpc/include/asm/pgtable.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 316f9a5..5d4fdcc 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -115,24 +115,25 @@ static inline unsigned long pte_pfn(pte_t pte)	{
 
 /* Generic modifiers for PTE bits */
 static inline pte_t pte_wrprotect(pte_t pte) {
-	pte_val(pte) &= ~(_PAGE_RW | _PAGE_HWWRITE); return pte; }
+	pte = __pte(pte_val(pte) & ~(_PAGE_RW | _PAGE_HWWRITE)); return pte; }
 static inline pte_t pte_mkclean(pte_t pte) {
-	pte_val(pte) &= ~(_PAGE_DIRTY | _PAGE_HWWRITE); return pte; }
+	pte = __pte(pte_val(pte) & ~(_PAGE_DIRTY | _PAGE_HWWRITE));
+	return pte; }
 static inline pte_t pte_mkold(pte_t pte) {
-	pte_val(pte) &= ~_PAGE_ACCESSED; return pte; }
+	pte = __pte(pte_val(pte) & ~_PAGE_ACCESSED); return pte; }
 static inline pte_t pte_mkwrite(pte_t pte) {
-	pte_val(pte) |= _PAGE_RW; return pte; }
+	pte = __pte(pte_val(pte) | _PAGE_RW); return pte; }
 static inline pte_t pte_mkdirty(pte_t pte) {
-	pte_val(pte) |= _PAGE_DIRTY; return pte; }
+	pte = __pte(pte_val(pte) | _PAGE_DIRTY); return pte; }
 static inline pte_t pte_mkyoung(pte_t pte) {
-	pte_val(pte) |= _PAGE_ACCESSED; return pte; }
+	pte = __pte(pte_val(pte) | _PAGE_ACCESSED); return pte; }
 static inline pte_t pte_mkspecial(pte_t pte) {
-	pte_val(pte) |= _PAGE_SPECIAL; return pte; }
+	pte = __pte(pte_val(pte) | _PAGE_SPECIAL); return pte; }
 static inline pte_t pte_mkhuge(pte_t pte) {
 	return pte; }
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
-	pte_val(pte) = (pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot);
+	pte = __pte((pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot));
 	return pte;
 }
 
-- 
2.1.0
