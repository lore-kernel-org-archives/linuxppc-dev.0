Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zJ2XY5bnqzF0jx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2018 23:45:33 +1100 (AEDT)
Message-Id: <6a51c1b7f55120b48028127a7977cfa09f844ec8.1515759812.git.christophe.leroy@c-s.fr>
In-Reply-To: <bb30d80cc985d7307fa1286c9e6824230698919b.1515759812.git.christophe.leroy@c-s.fr>
References: <bb30d80cc985d7307fa1286c9e6824230698919b.1515759812.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 6/8] powerpc/mm: Introduce _PAGE_NA
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri, 12 Jan 2018 13:45:29 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Today, PAGE_NONE is defined as a page not having _PAGE_USER.
In some circunstances, when the CPU supports it, it might be
better to be able to flag a page with NO ACCESS.

In a following patch, the 8xx will switch user access being flagged
in the PMD, therefore it will not be possible anymore to use
_PAGE_USER as a way to flag a page with no access.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h |  1 +
 arch/powerpc/include/asm/nohash/32/pgtable.h |  2 +-
 arch/powerpc/include/asm/pte-common.h        |  7 +++++--
 arch/powerpc/mm/dump_linuxpagetables.c       | 18 +++++++++++-------
 4 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index db38050e1a98..f1c43d9b0773 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -14,6 +14,7 @@
  */
 #define _PAGE_BIT_SWAP_TYPE	0
 
+#define _PAGE_NA		0
 #define _PAGE_RO		0
 #define _PAGE_USER		0
 
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index cc2bfec3aa3b..504a3c36ce5c 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -282,7 +282,7 @@ static inline void __ptep_set_access_flags(struct mm_struct *mm,
 {
 	unsigned long set = pte_val(entry) &
 		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
-	unsigned long clr = ~pte_val(entry) & _PAGE_RO;
+	unsigned long clr = ~pte_val(entry) & (_PAGE_RO | _PAGE_NA);
 
 	pte_update(ptep, clr, set);
 }
diff --git a/arch/powerpc/include/asm/pte-common.h b/arch/powerpc/include/asm/pte-common.h
index 0e6595a1b9d8..426a902816c5 100644
--- a/arch/powerpc/include/asm/pte-common.h
+++ b/arch/powerpc/include/asm/pte-common.h
@@ -50,6 +50,9 @@
 #define _PAGE_USER 0
 #endif
 #endif
+#ifndef _PAGE_NA
+#define _PAGE_NA 0
+#endif
 
 #ifndef _PMD_PRESENT_MASK
 #define _PMD_PRESENT_MASK	_PMD_PRESENT
@@ -122,7 +125,7 @@ static inline bool pte_user(pte_t pte)
 /* Mask of bits returned by pte_pgprot() */
 #define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT | _PAGE_NO_CACHE | \
 			 _PAGE_WRITETHRU | _PAGE_ENDIAN | _PAGE_4K_PFN | \
-			 _PAGE_USER | _PAGE_ACCESSED | _PAGE_RO | \
+			 _PAGE_USER | _PAGE_ACCESSED | _PAGE_RO | _PAGE_NA | \
 			 _PAGE_PRIVILEGED | \
 			 _PAGE_RW | _PAGE_HWWRITE | _PAGE_DIRTY | _PAGE_EXEC)
 
@@ -150,7 +153,7 @@ static inline bool pte_user(pte_t pte)
  *
  * Note due to the way vm flags are laid out, the bits are XWR
  */
-#define PAGE_NONE	__pgprot(_PAGE_BASE)
+#define PAGE_NONE	__pgprot(_PAGE_BASE | _PAGE_NA)
 #define PAGE_SHARED	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW)
 #define PAGE_SHARED_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW | \
 				 _PAGE_EXEC)
diff --git a/arch/powerpc/mm/dump_linuxpagetables.c b/arch/powerpc/mm/dump_linuxpagetables.c
index d9547e1ec5ef..4e8c6e593276 100644
--- a/arch/powerpc/mm/dump_linuxpagetables.c
+++ b/arch/powerpc/mm/dump_linuxpagetables.c
@@ -117,16 +117,20 @@ static const struct flag_info flag_array[] = {
 		.set	= "user",
 		.clear	= "    ",
 	}, {
-#if _PAGE_RO == 0
-		.mask	= _PAGE_RW,
+		.mask	= _PAGE_RW | _PAGE_RO | _PAGE_NA,
 		.val	= _PAGE_RW,
-#else
-		.mask	= _PAGE_RO,
-		.val	= 0,
-#endif
 		.set	= "rw",
-		.clear	= "ro",
 	}, {
+		.mask	= _PAGE_RW | _PAGE_RO | _PAGE_NA,
+		.val	= _PAGE_RO,
+		.set	= "ro",
+	}, {
+#if _PAGE_NA != 0
+		.mask	= _PAGE_RW | _PAGE_RO | _PAGE_NA,
+		.val	= _PAGE_RO,
+		.set	= "na",
+	}, {
+#endif
 		.mask	= _PAGE_EXEC,
 		.val	= _PAGE_EXEC,
 		.set	= " X ",
-- 
2.13.3
