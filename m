Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40m96s1bpHzF1RY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 20:05:41 +1000 (AEST)
Message-Id: <fe81beb9d8a891e4645729d1d05fb2be9e6e2c20.1526464250.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1526464250.git.christophe.leroy@c-s.fr>
References: <cover.1526464250.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 07/14] powerpc/8xx: set GUARDED attribute in the PMD
 directly
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 16 May 2018 12:05:37 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On the 8xx, the GUARDED attribute of the pages is managed in the
L1 entry, therefore to avoid having to copy it into L1 entry
at each TLB miss, we set it in the PMD.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/32/pte-8xx.h |  3 ++-
 arch/powerpc/kernel/head_8xx.S               | 18 +++++++-----------
 arch/powerpc/platforms/Kconfig.cputype       |  1 +
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
index f04cb46ae8a1..a9a2919251e0 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
@@ -47,10 +47,11 @@
 #define _PAGE_RO	0x0600	/* Supervisor RO, User no access */
 
 #define _PMD_PRESENT	0x0001
-#define _PMD_BAD	0x0fd0
+#define _PMD_BAD	0x0fc0
 #define _PMD_PAGE_MASK	0x000c
 #define _PMD_PAGE_8M	0x000c
 #define _PMD_PAGE_512K	0x0004
+#define _PMD_GUARDED	0x0010
 #define _PMD_USER	0x0020	/* APG 1 */
 
 /* Until my rework is finished, 8xx still needs atomic PTE updates */
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index c3b831bb8bad..85b017c67e11 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -345,6 +345,10 @@ _ENTRY(ITLBMiss_cmp)
 	rlwinm	r10, r10, 32 - (PAGE_SHIFT - 2), 32 - PAGE_SHIFT, 29
 #ifdef CONFIG_HUGETLB_PAGE
 	mtcr	r11
+#endif
+	/* Load the MI_TWC with the attributes for this "segment." */
+	mtspr	SPRN_MI_TWC, r11	/* Set segment attributes */
+#ifdef CONFIG_HUGETLB_PAGE
 	bt-	28, 10f		/* bit 28 = Large page (8M) */
 	bt-	29, 20f		/* bit 29 = Large page (8M or 512k) */
 #endif
@@ -354,8 +358,6 @@ _ENTRY(ITLBMiss_cmp)
 #if defined(ITLB_MISS_KERNEL) || defined(CONFIG_HUGETLB_PAGE)
 	mtcr	r12
 #endif
-	/* Load the MI_TWC with the attributes for this "segment." */
-	mtspr	SPRN_MI_TWC, r11	/* Set segment attributes */
 
 #ifdef CONFIG_SWAP
 	rlwinm	r11, r10, 32-5, _PAGE_PRESENT
@@ -457,6 +459,9 @@ _ENTRY(DTLBMiss_jmp)
 	rlwinm	r10, r10, 32 - (PAGE_SHIFT - 2), 32 - PAGE_SHIFT, 29
 #ifdef CONFIG_HUGETLB_PAGE
 	mtcr	r11
+#endif
+	mtspr	SPRN_MD_TWC, r11
+#ifdef CONFIG_HUGETLB_PAGE
 	bt-	28, 10f		/* bit 28 = Large page (8M) */
 	bt-	29, 20f		/* bit 29 = Large page (8M or 512k) */
 #endif
@@ -465,15 +470,6 @@ _ENTRY(DTLBMiss_jmp)
 4:
 	mtcr	r12
 
-	/* Insert the Guarded flag into the TWC from the Linux PTE.
-	 * It is bit 27 of both the Linux PTE and the TWC (at least
-	 * I got that right :-).  It will be better when we can put
-	 * this into the Linux pgd/pmd and load it in the operation
-	 * above.
-	 */
-	rlwimi	r11, r10, 0, _PAGE_GUARDED
-	mtspr	SPRN_MD_TWC, r11
-
 	/* Both _PAGE_ACCESSED and _PAGE_PRESENT has to be set.
 	 * We also need to know if the insn is a load/store, so:
 	 * Clear _PAGE_PRESENT and load that which will
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index ba6b4c86b637..8606fa253089 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -34,6 +34,7 @@ config PPC_8xx
 	bool "Freescale 8xx"
 	select FSL_SOC
 	select SYS_SUPPORTS_HUGETLBFS
+	select PPC_GUARDED_PAGE_IN_PMD
 
 config 40x
 	bool "AMCC 40x"
-- 
2.13.3
