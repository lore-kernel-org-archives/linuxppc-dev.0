Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6D8FADDF2A
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2009 03:20:14 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n2HGKACD031030
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2009 11:20:10 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: 
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH v4 4/4] powerpc/mm: e300c2/c3/c4 TLB errata workaround
Date: Tue, 17 Mar 2009 11:20:10 -0500
Message-Id: <1237306810-32333-1-git-send-email-galak@kernel.crashing.org>
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

* Moved SPRG4 init into __setup_cpu_603.  Realized we can't do a feature fixup
  of it as early as I had it.

- k

 arch/powerpc/include/asm/mmu.h      |    6 ++++++
 arch/powerpc/kernel/cpu_setup_6xx.S |    4 ++++
 arch/powerpc/kernel/cputable.c      |    9 ++++++---
 arch/powerpc/kernel/head_32.S       |   32 ++++++++++++++++++++++++++++----
 4 files changed, 44 insertions(+), 7 deletions(-)

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
 
diff --git a/arch/powerpc/kernel/cpu_setup_6xx.S b/arch/powerpc/kernel/cpu_setup_6xx.S
index 72d1d73..0ca353f 100644
--- a/arch/powerpc/kernel/cpu_setup_6xx.S
+++ b/arch/powerpc/kernel/cpu_setup_6xx.S
@@ -18,6 +18,10 @@
 
 _GLOBAL(__setup_cpu_603)
 	mflr	r4
+BEGIN_MMU_FTR_SECTION
+	li	r10,0
+	mtspr	SPRN_SPRG4,r10		/* init SW LRU tracking */
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_NEED_DTLB_SW_LRU)
 BEGIN_FTR_SECTION
 	bl	__init_fpu_registers
 END_FTR_SECTION_IFCLR(CPU_FTR_FPU_UNAVAILABLE)
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
index 58dcc7c..54e68c1 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -593,9 +593,21 @@ BEGIN_FTR_SECTION
 	rlwinm	r1,r1,0,~_PAGE_COHERENT	/* clear M (coherence not required) */
 END_FTR_SECTION_IFCLR(CPU_FTR_NEED_COHERENT)
 	mtspr	SPRN_RPA,r1
+	mfspr	r2,SPRN_SRR1		/* Need to restore CR0 */
+	mtcrf	0x80,r2
+BEGIN_MMU_FTR_SECTION
+	li	r0,1
+	mfspr	r1,SPRN_SPRG4
+	rlwinm	r2,r3,20,27,31		/* Get Address bits 15:19 */
+	slw	r0,r0,r2
+	xor	r1,r0,r1
+	srw	r0,r1,r2
+	mtspr   SPRN_SPRG4,r1
+	mfspr	r2,SPRN_SRR1
+	rlwimi	r2,r0,31-14,14,14
+	mtspr   SPRN_SRR1,r2
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_NEED_DTLB_SW_LRU)
 	tlbld	r3
-	mfspr	r3,SPRN_SRR1		/* Need to restore CR0 */
-	mtcrf	0x80,r3
 	rfi
 DataAddressInvalid:
 	mfspr	r3,SPRN_SRR1
@@ -661,9 +673,21 @@ BEGIN_FTR_SECTION
 	rlwinm	r1,r1,0,~_PAGE_COHERENT	/* clear M (coherence not required) */
 END_FTR_SECTION_IFCLR(CPU_FTR_NEED_COHERENT)
 	mtspr	SPRN_RPA,r1
+	mfspr	r2,SPRN_SRR1		/* Need to restore CR0 */
+	mtcrf	0x80,r2
+BEGIN_MMU_FTR_SECTION
+	li	r0,1
+	mfspr	r1,SPRN_SPRG4
+	rlwinm	r2,r3,20,27,31		/* Get Address bits 15:19 */
+	slw	r0,r0,r2
+	xor	r1,r0,r1
+	srw	r0,r1,r2
+	mtspr   SPRN_SPRG4,r1
+	mfspr	r2,SPRN_SRR1
+	rlwimi	r2,r0,31-14,14,14
+	mtspr   SPRN_SRR1,r2
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_NEED_DTLB_SW_LRU)
 	tlbld	r3
-	mfspr	r3,SPRN_SRR1		/* Need to restore CR0 */
-	mtcrf	0x80,r3
 	rfi
 
 #ifndef CONFIG_ALTIVEC
-- 
1.5.6.6
