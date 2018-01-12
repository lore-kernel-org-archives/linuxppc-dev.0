Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zJ2Xd57dhzF0kL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2018 23:45:37 +1100 (AEDT)
Message-Id: <7335386c97efeb9e55423483762c7990d357b67d.1515759812.git.christophe.leroy@c-s.fr>
In-Reply-To: <bb30d80cc985d7307fa1286c9e6824230698919b.1515759812.git.christophe.leroy@c-s.fr>
References: <bb30d80cc985d7307fa1286c9e6824230698919b.1515759812.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 8/8] powerpc/8xx: Use L1 entry APG to handle _PAGE_ACCESSED
 for CONFIG_SWAP
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri, 12 Jan 2018 13:45:33 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When CONFIG_SWAP is set, the TLB miss handlers have to also take
into account _PAGE_ACCESSED flag. At the moment it is done by
anding _PAGE_ACCESSED into _PAGE_PRESENT using 3 instructions.

This patch uses APG for handling _PAGE_ACCESSED, allowing to
just copy _PAGE_ACCESSED bit into APG field, hence reducing the
action to a single instruction.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/mmu-8xx.h | 34 +++++++++++++++++++++++-----
 arch/powerpc/kernel/head_8xx.S     | 45 +++++++++++++++-----------------------
 arch/powerpc/mm/8xx_mmu.c          |  2 +-
 3 files changed, 47 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-8xx.h b/arch/powerpc/include/asm/mmu-8xx.h
index ae68f6c848d3..ee5591fe6efc 100644
--- a/arch/powerpc/include/asm/mmu-8xx.h
+++ b/arch/powerpc/include/asm/mmu-8xx.h
@@ -34,12 +34,20 @@
  * respectively NA for All or X for Supervisor and no access for User.
  * Then we use the APG to say whether accesses are according to Page rules or
  * "all Supervisor" rules (Access to all)
- * Therefore, we define 2 APG groups. lsb is _PMD_USER
- * 0 => No user => 01 (all accesses performed according to page definition)
- * 1 => User => 00 (all accesses performed as supervisor iaw page definition)
+ * We also use the 2nd APG bit for _PAGE_ACCESSED when having SWAP:
+ * When that bit is not set access is done iaw "all user"
+ * which means no access iaw page rules.
+ * Therefore, we define 4 APG groups. lsb is _PMD_USER, 2nd is _PAGE_ACCESSED
+ * 0x => No access => 11 (all accesses performed as user iaw page definition)
+ * 10 => No user => 01 (all accesses performed according to page definition)
+ * 11 => User => 00 (all accesses performed as supervisor iaw page definition)
  * We define all 16 groups so that all other bits of APG can take any value
  */
+#ifdef CONFIG_SWAP
+#define MI_APG_INIT	0xf4f4f4f4
+#else
 #define MI_APG_INIT	0x44444444
+#endif
 
 /* The effective page number register.  When read, contains the information
  * about the last instruction TLB miss.  When MI_RPN is written, bits in
@@ -107,12 +115,20 @@
  * Supervisor and no access for user and NA for ALL.
  * Then we use the APG to say whether accesses are according to Page rules or
  * "all Supervisor" rules (Access to all)
- * Therefore, we define 2 APG groups. lsb is _PMD_USER
- * 0 => No user => 01 (all accesses performed according to page definition)
- * 1 => User => 00 (all accesses performed as supervisor iaw page definition)
+ * We also use the 2nd APG bit for _PAGE_ACCESSED when having SWAP:
+ * When that bit is not set access is done iaw "all user"
+ * which means no access iaw page rules.
+ * Therefore, we define 4 APG groups. lsb is _PMD_USER, 2nd is _PAGE_ACCESSED
+ * 0x => No access => 11 (all accesses performed as user iaw page definition)
+ * 10 => No user => 01 (all accesses performed according to page definition)
+ * 11 => User => 00 (all accesses performed as supervisor iaw page definition)
  * We define all 16 groups so that all other bits of APG can take any value
  */
+#ifdef CONFIG_SWAP
+#define MD_APG_INIT	0xf4f4f4f4
+#else
 #define MD_APG_INIT	0x44444444
+#endif
 
 /* The effective page number register.  When read, contains the information
  * about the last instruction TLB miss.  When MD_RPN is written, bits in
@@ -164,6 +180,12 @@
  */
 #define SPRN_M_TW	799
 
+/* APGs */
+#define M_APG0		0x00000000
+#define M_APG1		0x00000020
+#define M_APG2		0x00000040
+#define M_APG3		0x00000060
+
 #ifndef __ASSEMBLY__
 typedef struct {
 	unsigned int id;
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index c3b831bb8bad..d8670a37d70c 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -354,14 +354,13 @@ _ENTRY(ITLBMiss_cmp)
 #if defined(ITLB_MISS_KERNEL) || defined(CONFIG_HUGETLB_PAGE)
 	mtcr	r12
 #endif
-	/* Load the MI_TWC with the attributes for this "segment." */
-	mtspr	SPRN_MI_TWC, r11	/* Set segment attributes */
 
 #ifdef CONFIG_SWAP
-	rlwinm	r11, r10, 32-5, _PAGE_PRESENT
-	and	r11, r11, r10
-	rlwimi	r10, r11, 0, _PAGE_PRESENT
+	rlwinm	r11, r10, 31, _PAGE_ACCESSED >> 1
 #endif
+	/* Load the MI_TWC with the attributes for this "segment." */
+	mtspr	SPRN_MI_TWC, r11	/* Set segment attributes */
+
 	li	r11, RPN_PATTERN | 0x200
 	/* The Linux PTE won't go exactly into the MMU TLB.
 	 * Software indicator bits 20 and 23 must be clear.
@@ -472,22 +471,14 @@ _ENTRY(DTLBMiss_jmp)
 	 * above.
 	 */
 	rlwimi	r11, r10, 0, _PAGE_GUARDED
-	mtspr	SPRN_MD_TWC, r11
-
-	/* Both _PAGE_ACCESSED and _PAGE_PRESENT has to be set.
-	 * We also need to know if the insn is a load/store, so:
-	 * Clear _PAGE_PRESENT and load that which will
-	 * trap into DTLB Error with store bit set accordinly.
-	 */
-	/* PRESENT=0x1, ACCESSED=0x20
-	 * r11 = ((r10 & PRESENT) & ((r10 & ACCESSED) >> 5));
-	 * r10 = (r10 & ~PRESENT) | r11;
-	 */
 #ifdef CONFIG_SWAP
-	rlwinm	r11, r10, 32-5, _PAGE_PRESENT
-	and	r11, r11, r10
-	rlwimi	r10, r11, 0, _PAGE_PRESENT
+	/* _PAGE_ACCESSED has to be set. We use second APG bit for that, 0
+	 * on that bit will represent a Non Access group
+	 */
+	rlwinm	r11, r10, 31, _PAGE_ACCESSED >> 1
 #endif
+	mtspr	SPRN_MD_TWC, r11
+
 	/* The Linux PTE won't go exactly into the MMU TLB.
 	 * Software indicator bits 24, 25, 26, and 27 must be
 	 * set.  All other Linux PTE bits control the behavior
@@ -647,8 +638,8 @@ InstructionBreakpoint:
  */
 DTLBMissIMMR:
 	mtcr	r12
-	/* Set 512k byte guarded page and mark it valid */
-	li	r10, MD_PS512K | MD_GUARDED | MD_SVALID
+	/* Set 512k byte guarded page and mark it valid and accessed */
+	li	r10, MD_PS512K | MD_GUARDED | MD_SVALID | M_APG2
 	mtspr	SPRN_MD_TWC, r10
 	mfspr	r10, SPRN_IMMR			/* Get current IMMR */
 	rlwinm	r10, r10, 0, 0xfff80000		/* Get 512 kbytes boundary */
@@ -666,8 +657,8 @@ _ENTRY(dtlb_miss_exit_2)
 
 DTLBMissLinear:
 	mtcr	r12
-	/* Set 8M byte page and mark it valid */
-	li	r11, MD_PS8MEG | MD_SVALID
+	/* Set 8M byte page and mark it valid and accessed */
+	li	r11, MD_PS8MEG | MD_SVALID | M_APG2
 	mtspr	SPRN_MD_TWC, r11
 	rlwinm	r10, r10, 0, 0x0f800000	/* 8xx supports max 256Mb RAM */
 	ori	r10, r10, 0xf0 | MD_SPS16K | _PAGE_PRIVILEGED | _PAGE_DIRTY | \
@@ -685,8 +676,8 @@ _ENTRY(dtlb_miss_exit_3)
 #ifndef CONFIG_PIN_TLB_TEXT
 ITLBMissLinear:
 	mtcr	r12
-	/* Set 8M byte page and mark it valid */
-	li	r11, MI_PS8MEG | MI_SVALID
+	/* Set 8M byte page and mark it valid,accessed */
+	li	r11, MI_PS8MEG | MI_SVALID | M_APG2
 	mtspr	SPRN_MI_TWC, r11
 	rlwinm	r10, r10, 0, 0x0f800000	/* 8xx supports max 256Mb RAM */
 	ori	r10, r10, 0xf0 | MI_SPS16K | _PAGE_PRIVILEGED | _PAGE_DIRTY | \
@@ -969,7 +960,7 @@ initial_mmu:
 	ori	r8, r8, MI_EVALID	/* Mark it valid */
 	mtspr	SPRN_MI_EPN, r8
 	li	r8, MI_PS8MEG /* Set 8M byte page */
-	ori	r8, r8, MI_SVALID	/* Make it valid */
+	ori	r8, r8, MI_SVALID | M_APG2	/* Make it valid, APG 2 */
 	mtspr	SPRN_MI_TWC, r8
 	li	r8, MI_BOOTINIT		/* Create RPN for address 0 */
 	mtspr	SPRN_MI_RPN, r8		/* Store TLB entry */
@@ -996,7 +987,7 @@ initial_mmu:
 	ori	r8, r8, MD_EVALID	/* Mark it valid */
 	mtspr	SPRN_MD_EPN, r8
 	li	r8, MD_PS512K | MD_GUARDED	/* Set 512k byte page */
-	ori	r8, r8, MD_SVALID	/* Make it valid */
+	ori	r8, r8, MD_SVALID | M_APG2	/* Make it valid and accessed */
 	mtspr	SPRN_MD_TWC, r8
 	mr	r8, r9			/* Create paddr for TLB */
 	ori	r8, r8, MI_BOOTINIT|0x2 /* Inhibit cache -- Cort */
diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index 5d53684c2ebd..cf77d755246d 100644
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -79,7 +79,7 @@ void __init MMU_init_hw(void)
 	for (; i < 32 && mem >= LARGE_PAGE_SIZE_8M; i++) {
 		mtspr(SPRN_MD_CTR, ctr | (i << 8));
 		mtspr(SPRN_MD_EPN, (unsigned long)__va(addr) | MD_EVALID);
-		mtspr(SPRN_MD_TWC, MD_PS8MEG | MD_SVALID);
+		mtspr(SPRN_MD_TWC, MD_PS8MEG | MD_SVALID | M_APG2);
 		mtspr(SPRN_MD_RPN, addr | flags | _PAGE_PRESENT);
 		addr += LARGE_PAGE_SIZE_8M;
 		mem -= LARGE_PAGE_SIZE_8M;
-- 
2.13.3
