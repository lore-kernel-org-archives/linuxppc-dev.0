Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5AAABDDF59
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2009 00:02:26 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: david.jander@protonic.nl
Subject: [RFC][PATCH v4] powerpc/mm: e300c2/c3/c4 TLB errata workaround
Date: Mon, 16 Mar 2009 08:02:18 -0500
Message-Id: <1237208538-32597-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, wd@denx.de, gunnar@genesi-usa.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Complete workaround for DTLB errata in e300c2/c3/c4 processors.

Due to the bug, the hardware-implemented LRU algorythm always goes to way
1 of the TLB. This fix implements the proposed software workaround in
form of a LRW table for chosing the TLB-way.

Based on patch from David Jander <david@protonic.nl>

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/include/asm/mmu.h |    6 ++++++
 arch/powerpc/kernel/cputable.c |    9 ++++++---
 arch/powerpc/kernel/head_32.S  |   32 ++++++++++++++++++++++++++++----
 3 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 10476a8..cbf1543 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -46,6 +46,12 @@
  */
 #define MMU_FTR_LOCK_BCAST_INVAL	ASM_CONST(0x00100000)
 
+/* This indicates that the processor doesn't handle way selection
+ * properly and needs SW to track and update the LRU state.  This
+ * is specific to an errata on e300c2/c3/c4 class parts
+ */
+#define MMU_FTR_NEED_DTLB_SW_LRU	ASM_CONST(0x00200000)
+
 #ifndef __ASSEMBLY__
 #include <asm/cputable.h>
 
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index ccea243..cd1b687 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1090,7 +1090,8 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_name		= "e300c2",
 		.cpu_features		= CPU_FTRS_E300C2,
 		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
-		.mmu_features		= MMU_FTR_USE_HIGH_BATS,
+		.mmu_features		= MMU_FTR_USE_HIGH_BATS |
+			MMU_FTR_NEED_DTLB_SW_LRU,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_603,
@@ -1103,7 +1104,8 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_name		= "e300c3",
 		.cpu_features		= CPU_FTRS_E300,
 		.cpu_user_features	= COMMON_USER,
-		.mmu_features		= MMU_FTR_USE_HIGH_BATS,
+		.mmu_features		= MMU_FTR_USE_HIGH_BATS |
+			MMU_FTR_NEED_DTLB_SW_LRU,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_603,
@@ -1118,7 +1120,8 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_name		= "e300c4",
 		.cpu_features		= CPU_FTRS_E300,
 		.cpu_user_features	= COMMON_USER,
-		.mmu_features		= MMU_FTR_USE_HIGH_BATS,
+		.mmu_features		= MMU_FTR_USE_HIGH_BATS |
+			MMU_FTR_NEED_DTLB_SW_LRU,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_603,
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index b6c5955..d59771d 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -587,9 +587,19 @@ DataLoadTLBMiss:
 	ori	r1,r1,0xe04		/* clear out reserved bits */
 	andc	r1,r0,r1		/* PP = user? (rw&dirty? 2: 3): 0 */
 	mtspr	SPRN_RPA,r1
+	mfspr	r2,SPRN_SRR1		/* Need to restore CR0 */
+	mtcrf	0x80,r2
+BEGIN_MMU_FTR_SECTION
+	li	r0,1
+	lwz	r1,sw_way_lru@l(0)
+	rlwinm	r3,r3,19,25,29		/* Get Address bits 19:15 */
+	slw	r0,r0,r3
+	xor	r1,r0,r1
+	srw	r0,r1,r3
+	stw	r1,sw_way_lru@l(0)
+	rlwimi	r2,r0,31-14,14,14
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_NEED_DTLB_SW_LRU)
 	tlbld	r3
-	mfspr	r3,SPRN_SRR1		/* Need to restore CR0 */
-	mtcrf	0x80,r3
 	rfi
 DataAddressInvalid:
 	mfspr	r3,SPRN_SRR1
@@ -652,11 +662,25 @@ DataStoreTLBMiss:
 	li	r1,0xe05		/* clear out reserved bits & PP lsb */
 	andc	r1,r0,r1		/* PP = user? 2: 0 */
 	mtspr	SPRN_RPA,r1
+	mfspr	r2,SPRN_SRR1		/* Need to restore CR0 */
+	mtcrf	0x80,r2
+BEGIN_MMU_FTR_SECTION
+	li	r0,1
+	lwz	r1,sw_way_lru@l(0)
+	rlwinm	r3,r3,19,25,29		/* Get Address bits 19:15 */
+	slw	r0,r0,r3
+	xor	r1,r0,r1
+	srw	r0,r1,r3
+	stw	r1,sw_way_lru@l(0)
+	rlwimi	r2,r0,31-14,14,14
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_NEED_DTLB_SW_LRU)
 	tlbld	r3
-	mfspr	r3,SPRN_SRR1		/* Need to restore CR0 */
-	mtcrf	0x80,r3
 	rfi
 
+	.balign	L1_CACHE_BYTES
+sw_way_lru:
+	.long 0
+
 #ifndef CONFIG_ALTIVEC
 #define altivec_assist_exception	unknown_exception
 #endif
-- 
1.5.6.6
