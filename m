Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 6D6DD1A0490
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 20:06:48 +1000 (AEST)
Message-Id: <1bf5ce30a4bfb2004e248406c867417a60ab91de.1429696335.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1429696335.git.christophe.leroy@c-s.fr>
References: <cover.1429696335.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 2/3] powerpc/8xx: Handle PAGE_USER via APG bits
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Date: Wed, 22 Apr 2015 12:06:43 +0200 (CEST)
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use of APG for handling PAGE_USER.

All pages PP exec bits are set to either 000 or 011, which means
respectively RW for Supervisor and no access for User, or RO for
Supervisor and no access for user.

Then we use the APG to say whether accesses are according to
Page rules or "all Supervisor" rules (Access to all)

Therefore, we define 2 APG groups corresponding to _PAGE_USER.
Mx_AP are initialised as follows:
GP0 => No user => 01 (all accesses performed according
				to page definition)
GP1 => User => 00 (all accesses performed as supervisor
                                according to page definition)

This removes the special 8xx handling in pte_update()

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/pgtable-ppc32.h | 19 -------------------
 arch/powerpc/include/asm/pte-8xx.h       | 27 +++++++++------------------
 arch/powerpc/kernel/head_8xx.S           | 21 ++++++++++++---------
 3 files changed, 21 insertions(+), 46 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable-ppc32.h b/arch/powerpc/include/asm/pgtable-ppc32.h
index b3e9a3e..d280fa2 100644
--- a/arch/powerpc/include/asm/pgtable-ppc32.h
+++ b/arch/powerpc/include/asm/pgtable-ppc32.h
@@ -170,24 +170,6 @@ static inline unsigned long pte_update(pte_t *p,
 #ifdef PTE_ATOMIC_UPDATES
 	unsigned long old, tmp;
 
-#ifdef CONFIG_PPC_8xx
-	unsigned long tmp2;
-
-	__asm__ __volatile__("\
-1:	lwarx	%0,0,%4\n\
-	andc	%1,%0,%5\n\
-	or	%1,%1,%6\n\
-	/* 0x200 == Extended encoding, bit 22 */ \
-	/* Bit 22 has to be 1 when _PAGE_USER is unset and _PAGE_RO is set */ \
-	rlwimi	%1,%1,32-1,0x200\n /* get _PAGE_RO */ \
-	rlwinm	%3,%1,32-2,0x200\n /* get _PAGE_USER */ \
-	andc	%1,%1,%3\n\
-	stwcx.	%1,0,%4\n\
-	bne-	1b"
-	: "=&r" (old), "=&r" (tmp), "=m" (*p), "=&r" (tmp2)
-	: "r" (p), "r" (clr), "r" (set), "m" (*p)
-	: "cc" );
-#else /* CONFIG_PPC_8xx */
 	__asm__ __volatile__("\
 1:	lwarx	%0,0,%3\n\
 	andc	%1,%0,%4\n\
@@ -198,7 +180,6 @@ static inline unsigned long pte_update(pte_t *p,
 	: "=&r" (old), "=&r" (tmp), "=m" (*p)
 	: "r" (p), "r" (clr), "r" (set), "m" (*p)
 	: "cc" );
-#endif /* CONFIG_PPC_8xx */
 #else /* PTE_ATOMIC_UPDATES */
 	unsigned long old = pte_val(*p);
 	*p = __pte((old & ~clr) | set);
diff --git a/arch/powerpc/include/asm/pte-8xx.h b/arch/powerpc/include/asm/pte-8xx.h
index c8aacad..7926d4e 100644
--- a/arch/powerpc/include/asm/pte-8xx.h
+++ b/arch/powerpc/include/asm/pte-8xx.h
@@ -35,36 +35,27 @@
 #define _PAGE_SPECIAL	0x0008	/* SW entry, forced to 0 by the TLB miss */
 #define _PAGE_DIRTY	0x0100	/* C: page changed */
 
-/* These 4 software bits must be masked out when the entry is loaded
- * into the TLB, 1 SW bit left(0x0080).
+/* These 4 software bits must be masked out when the L2 entry is loaded
+ * into the TLB.
  */
-#define _PAGE_GUARDED	0x0010	/* software: guarded access */
-#define _PAGE_ACCESSED	0x0020	/* software: page referenced */
-#define _PAGE_WRITETHRU	0x0040	/* software: caching is write through */
+#define _PAGE_GUARDED	0x0010	/* Copied to L1 G entry in DTLB */
+#define _PAGE_USER	0x0020	/* Copied to L1 APG lsb */
+#define _PAGE_ACCESSED	0x0040	/* software: page referenced */
+#define _PAGE_WRITETHRU	0x0080	/* software: caching is write through */
 
-/* Setting any bits in the nibble with the follow two controls will
- * require a TLB exception handler change.  It is assumed unused bits
- * are always zero.
- */
-#define _PAGE_RO	0x0400	/* lsb PP bits */
-#define _PAGE_USER	0x0800	/* msb PP bits */
-/* set when _PAGE_USER is unset and _PAGE_RO is set */
-#define _PAGE_KNLRO	0x0200
+#define _PAGE_RO	0x0600	/* Supervisor RO, User no access */
 
 #define _PMD_PRESENT	0x0001
 #define _PMD_BAD	0x0ff0
 #define _PMD_PAGE_MASK	0x000c
 #define _PMD_PAGE_8M	0x000c
 
-#define _PTE_NONE_MASK _PAGE_KNLRO
-
 /* Until my rework is finished, 8xx still needs atomic PTE updates */
 #define PTE_ATOMIC_UPDATES	1
 
 /* We need to add _PAGE_SHARED to kernel pages */
-#define _PAGE_KERNEL_RO	(_PAGE_SHARED | _PAGE_RO | _PAGE_KNLRO)
-#define _PAGE_KERNEL_ROX	(_PAGE_SHARED | _PAGE_RO | _PAGE_KNLRO | \
-				 _PAGE_EXEC)
+#define _PAGE_KERNEL_RO		(_PAGE_SHARED | _PAGE_RO)
+#define _PAGE_KERNEL_ROX	(_PAGE_SHARED | _PAGE_RO | _PAGE_EXEC)
 #define _PAGE_KERNEL_RW		(_PAGE_SHARED | _PAGE_DIRTY | _PAGE_RW | \
 				 _PAGE_HWWRITE)
 #define _PAGE_KERNEL_RWX	(_PAGE_SHARED | _PAGE_DIRTY | _PAGE_RW | \
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 20c082c..508c645 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -363,12 +363,15 @@ InstructionTLBMiss:
 	rlwimi	r11, r10, 32 - ((PAGE_SHIFT - 2) << 1), (PAGE_SHIFT - 2) << 1, 29
 	lwz	r11, (swapper_pg_dir-PAGE_OFFSET)@l(r11)	/* Get the level 1 entry */
 
-	/* Load the MI_TWC with the attributes for this "segment." */
-	MTSPR_CPU6(SPRN_MI_TWC, r11, r3)	/* Set segment attributes */
-	rlwinm	r11, r11,0,0,19	/* Extract page descriptor page address */
 	/* Extract level 2 index */
 	rlwinm	r10, r10, 32 - (PAGE_SHIFT - 2), 32 - PAGE_SHIFT, 29
-	lwzx	r10, r10, r11	/* Get the pte */
+	rlwimi	r10, r11, 0, 0, 32 - PAGE_SHIFT - 1	/* Add level 2 base */
+	lwz	r10, 0(r10)	/* Get the pte */
+
+	/* Insert the APG into the TWC from the Linux PTE. */
+	rlwimi	r11, r10, 0, 26, 26
+	/* Load the MI_TWC with the attributes for this "segment." */
+	MTSPR_CPU6(SPRN_MI_TWC, r11, r3)	/* Set segment attributes */
 
 #ifdef CONFIG_SWAP
 	rlwinm	r11, r10, 32-5, _PAGE_PRESENT
@@ -377,12 +380,12 @@ InstructionTLBMiss:
 #endif
 	li	r11, RPN_PATTERN
 	/* The Linux PTE won't go exactly into the MMU TLB.
-	 * Software indicator bits 21 and 28 must be clear.
+	 * Software indicator bits 20-23 and 28 must be clear.
 	 * Software indicator bits 24, 25, 26, and 27 must be
 	 * set.  All other Linux PTE bits control the behavior
 	 * of the MMU.
 	 */
-	rlwimi	r10, r11, 0, 0x07f8	/* Set 24-27, clear 21-23,28 */
+	rlwimi	r10, r11, 0, 0x0ff8	/* Set 24-27, clear 20-23,28 */
 	MTSPR_CPU6(SPRN_MI_RPN, r10, r3)	/* Update TLB entry */
 
 	/* Restore registers */
@@ -431,13 +434,13 @@ DataStoreTLBMiss:
 	rlwimi	r10, r11, 0, 0, 32 - PAGE_SHIFT - 1	/* Add level 2 base */
 	lwz	r10, 0(r10)	/* Get the pte */
 
-	/* Insert the Guarded flag into the TWC from the Linux PTE.
-	 * It is bit 27 of both the Linux PTE and the TWC (at least
+	/* Insert the Guarded flag and APG into the TWC from the Linux PTE.
+	 * It is bit 26-27 of both the Linux PTE and the TWC (at least
 	 * I got that right :-).  It will be better when we can put
 	 * this into the Linux pgd/pmd and load it in the operation
 	 * above.
 	 */
-	rlwimi	r11, r10, 0, 27, 27
+	rlwimi	r11, r10, 0, 26, 27
 	/* Insert the WriteThru flag into the TWC from the Linux PTE.
 	 * It is bit 25 in the Linux PTE and bit 30 in the TWC
 	 */
-- 
2.1.0
