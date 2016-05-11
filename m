Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r4fXZ1p83zDqDV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 01:04:14 +1000 (AEST)
Message-Id: <865bc7a0aab24fac591d903960a6e1aa2f7f623f.1462052179.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1462052179.git.christophe.leroy@c-s.fr>
References: <cover.1462052179.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 7/7] powerpc/8xx: add CONFIG_PIN_TLB_IMMR
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 11 May 2016 17:04:10 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CONFIG_PIN_TLB maps IMMR area and the first 24 Mbytes of memory.
In some circunstances it might be more interesting to not map
IMMR and to map 32 Mbytes of memory instead.

Therefore we add config option CONFIG_PIN_TLB_IMMR to select if
IMMR shall be pinned or not, hence whether we pin 24 or 32 Mbytes of RAM

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v2: No change

 arch/powerpc/Kconfig           |  5 +++++
 arch/powerpc/kernel/head_8xx.S | 10 ++++++----
 arch/powerpc/mm/8xx_mmu.c      | 12 ++++++++----
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8bff540..3bd6dd9 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -1054,6 +1054,11 @@ config CONSISTENT_SIZE
 config PIN_TLB
 	bool "Pinned Kernel TLBs (860 ONLY)"
 	depends on ADVANCED_OPTIONS && 8xx
+
+config PIN_TLB_IMMR
+	bool "Pinned TLB for IMMR"
+	depends on PIN_TLB
+	default y
 endmenu
 
 if PPC64
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index b8602e5..a157632 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -414,11 +414,11 @@ DataStoreTLBMiss:
 	 */
 	mfspr	r11, SPRN_MD_EPN
 	rlwinm	r11, r11, 16, 0xfff8
-#ifndef CONFIG_PIN_TLB
+#ifndef CONFIG_PIN_TLB_IMMR
 	cmpli	cr0, r11, VIRT_IMMR_BASE@h
 #endif
 	cmpli	cr7, r11, PAGE_OFFSET@h
-#ifndef CONFIG_PIN_TLB
+#ifndef CONFIG_PIN_TLB_IMMR
 _ENTRY(DTLBMiss_jmp)
 	beq-	DTLBMissIMMR
 #endif
@@ -819,7 +819,6 @@ initial_mmu:
 
 #ifdef CONFIG_PIN_TLB
 	oris	r10, r10, MD_RSV4I@h
-	ori	r10, r10, 0x1c00
 	mtspr	SPRN_MD_CTR, r10	/* Set data TLB control */
 #endif
 
@@ -843,7 +842,10 @@ initial_mmu:
 	/* Map a 512k page for the IMMR to get the processor
 	 * internal registers (among other things).
 	 */
-#ifdef CONFIG_PIN_TLB
+#ifdef CONFIG_PIN_TLB_IMMR
+	ori	r10, r10, 0x1c00
+	mtspr	SPRN_MD_CTR, r10
+
 	mfspr	r9, 638			/* Get current IMMR */
 	andis.	r9, r9, 0xfff8		/* Get 512 kbytes boundary */
 
diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index 0f0a83e..6c5025e 100644
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -61,11 +61,15 @@ void __init MMU_init_hw(void)
 #ifdef CONFIG_PIN_TLB
 	unsigned long ctr = mfspr(SPRN_MD_CTR) & 0xfe000000;
 	unsigned long flags = 0xf0 | MD_SPS16K | _PAGE_SHARED | _PAGE_DIRTY;
-	int i;
+#ifdef CONFIG_PIN_TLB_IMMR
+	int i = 29;
+#else
+	int i = 28;
+#endif
 	unsigned long addr = 0;
 	unsigned long mem = total_lowmem;
 
-	for (i = 29; i < 32 && mem >= LARGE_PAGE_SIZE_8M; i++) {
+	for (; i < 32 && mem >= LARGE_PAGE_SIZE_8M; i++) {
 		mtspr(SPRN_MD_CTR, ctr | (i << 8));
 		mtspr(SPRN_MD_EPN, (unsigned long)__va(addr) | MD_EVALID);
 		mtspr(SPRN_MD_TWC, MD_PS8MEG | MD_SVALID);
@@ -88,7 +92,7 @@ static void mmu_mapin_immr(void)
 }
 
 /* Address of instructions to patch */
-#ifndef CONFIG_PIN_TLB
+#ifndef CONFIG_PIN_TLB_IMMR
 extern unsigned int DTLBMiss_jmp;
 #endif
 extern unsigned int DTLBMiss_cmp, FixupDAR_cmp;
@@ -109,7 +113,7 @@ unsigned long __init mmu_mapin_ram(unsigned long top)
 	if (__map_without_ltlbs) {
 		mapped = 0;
 		mmu_mapin_immr();
-#ifndef CONFIG_PIN_TLB
+#ifndef CONFIG_PIN_TLB_IMMR
 		patch_instruction(&DTLBMiss_jmp, PPC_INST_NOP);
 #endif
 	} else {
-- 
2.1.0
