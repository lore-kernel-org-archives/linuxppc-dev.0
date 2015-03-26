Return-Path: <chenhui.zhao@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0132.outbound.protection.outlook.com [157.56.110.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 27DB01A011B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 21:33:08 +1100 (AEDT)
From: Chenhui Zhao <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 1/4] powerpc/cache: add cache flush operation for various e500
Date: Thu, 26 Mar 2015 18:18:12 +0800
Message-ID: <1427365095-26396-1-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, linux-kernel@vger.kernel.org,
 Jason.Jin@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Various e500 core have different cache architecture, so they
need different cache flush operations. Therefore, add a callback
function cpu_flush_caches to the struct cpu_spec. The cache flush
operation for the specific kind of e500 is selected at init time.
The callback function will flush all caches inside the current cpu.

Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
---
 arch/powerpc/include/asm/cacheflush.h     |   2 -
 arch/powerpc/include/asm/cputable.h       |  11 +++
 arch/powerpc/kernel/asm-offsets.c         |   3 +
 arch/powerpc/kernel/cpu_setup_fsl_booke.S | 114 +++++++++++++++++++++++++++++-
 arch/powerpc/kernel/cputable.c            |   4 ++
 arch/powerpc/kernel/head_fsl_booke.S      |  74 -------------------
 arch/powerpc/platforms/85xx/smp.c         |   3 +-
 7 files changed, 133 insertions(+), 78 deletions(-)

diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include/asm/cacheflush.h
index 30b35ff..729fde4 100644
--- a/arch/powerpc/include/asm/cacheflush.h
+++ b/arch/powerpc/include/asm/cacheflush.h
@@ -30,8 +30,6 @@ extern void flush_dcache_page(struct page *page);
 #define flush_dcache_mmap_lock(mapping)		do { } while (0)
 #define flush_dcache_mmap_unlock(mapping)	do { } while (0)
 
-extern void __flush_disable_L1(void);
-
 extern void flush_icache_range(unsigned long, unsigned long);
 extern void flush_icache_user_range(struct vm_area_struct *vma,
 				    struct page *page, unsigned long addr,
diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 5cf5a6d..c776efe4 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -43,6 +43,13 @@ extern int machine_check_e500(struct pt_regs *regs);
 extern int machine_check_e200(struct pt_regs *regs);
 extern int machine_check_47x(struct pt_regs *regs);
 
+#if defined(CONFIG_E500) || defined(CONFIG_PPC_E500MC)
+extern void __flush_caches_e500v2(void);
+extern void __flush_caches_e500mc(void);
+extern void __flush_caches_e5500(void);
+extern void __flush_caches_e6500(void);
+#endif
+
 /* NOTE WELL: Update identify_cpu() if fields are added or removed! */
 struct cpu_spec {
 	/* CPU is matched via (PVR & pvr_mask) == pvr_value */
@@ -59,6 +66,10 @@ struct cpu_spec {
 	unsigned int	icache_bsize;
 	unsigned int	dcache_bsize;
 
+#if defined(CONFIG_E500) || defined(CONFIG_PPC_E500MC)
+	/* flush caches inside the current cpu */
+	void (*cpu_flush_caches)(void);
+#endif
 	/* number of performance monitor counters */
 	unsigned int	num_pmcs;
 	enum powerpc_pmc_type pmc_type;
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 4717859..9567930 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -372,6 +372,9 @@ int main(void)
 	DEFINE(CPU_SPEC_FEATURES, offsetof(struct cpu_spec, cpu_features));
 	DEFINE(CPU_SPEC_SETUP, offsetof(struct cpu_spec, cpu_setup));
 	DEFINE(CPU_SPEC_RESTORE, offsetof(struct cpu_spec, cpu_restore));
+#if defined(CONFIG_E500) || defined(CONFIG_PPC_E500MC)
+	DEFINE(CPU_FLUSH_CACHES, offsetof(struct cpu_spec, cpu_flush_caches));
+#endif
 
 	DEFINE(pbe_address, offsetof(struct pbe, address));
 	DEFINE(pbe_orig_address, offsetof(struct pbe, orig_address));
diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
index dddba3e..c8c251f 100644
--- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
+++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
@@ -1,7 +1,7 @@
 /*
  * This file contains low level CPU setup functions.
  * Kumar Gala <galak@kernel.crashing.org>
- * Copyright 2009 Freescale Semiconductor, Inc.
+ * Copyright 2009, 2015 Freescale Semiconductor, Inc.
  *
  * Based on cpu_setup_6xx code by
  * Benjamin Herrenschmidt <benh@kernel.crashing.org>
@@ -13,11 +13,13 @@
  *
  */
 
+#include <asm/page.h>
 #include <asm/processor.h>
 #include <asm/cputable.h>
 #include <asm/ppc_asm.h>
 #include <asm/mmu-book3e.h>
 #include <asm/asm-offsets.h>
+#include <asm/mpc85xx.h>
 
 _GLOBAL(__e500_icache_setup)
 	mfspr	r0, SPRN_L1CSR1
@@ -233,3 +235,113 @@ _GLOBAL(__setup_cpu_e5500)
 	mtlr	r5
 	blr
 #endif
+
+/* flush L1 date cache, it can apply to e500v2, e500mc and e5500 */
+_GLOBAL(flush_dcache_L1)
+	mfmsr	r10
+	wrteei	0
+
+	mfspr	r3,SPRN_L1CFG0
+	rlwinm	r5,r3,9,3	/* Extract cache block size */
+	twlgti	r5,1		/* Only 32 and 64 byte cache blocks
+				 * are currently defined.
+				 */
+	li	r4,32
+	subfic	r6,r5,2		/* r6 = log2(1KiB / cache block size) -
+				 *      log2(number of ways)
+				 */
+	slw	r5,r4,r5	/* r5 = cache block size */
+
+	rlwinm	r7,r3,0,0xff	/* Extract number of KiB in the cache */
+	mulli	r7,r7,13	/* An 8-way cache will require 13
+				 * loads per set.
+				 */
+	slw	r7,r7,r6
+
+	/* save off HID0 and set DCFA */
+	mfspr	r8,SPRN_HID0
+	ori	r9,r8,HID0_DCFA@l
+	mtspr	SPRN_HID0,r9
+	isync
+
+	LOAD_REG_IMMEDIATE(r6, KERNELBASE)
+	mr	r4, r6
+	mtctr	r7
+
+1:	lwz	r3,0(r4)	/* Load... */
+	add	r4,r4,r5
+	bdnz	1b
+
+	msync
+	mr	r4, r6
+	mtctr	r7
+
+1:	dcbf	0,r4		/* ...and flush. */
+	add	r4,r4,r5
+	bdnz	1b
+
+	/* restore HID0 */
+	mtspr	SPRN_HID0,r8
+	isync
+
+	wrtee r10
+
+	blr
+
+has_L2_cache:
+	/* skip L2 cache on P2040/P2040E as they have no L2 cache */
+	mfspr	r3, SPRN_SVR
+	/* shift right by 8 bits and clear E bit of SVR */
+	rlwinm	r4, r3, 24, ~0x800
+
+	lis	r3, SVR_P2040@h
+	ori	r3, r3, SVR_P2040@l
+	cmpw	r4, r3
+	beq	1f
+
+	li	r3, 1
+	blr
+1:
+	li	r3, 0
+	blr
+
+/* flush backside L2 cache */
+flush_backside_L2_cache:
+	mflr	r10
+	bl	has_L2_cache
+	mtlr	r10
+	cmpwi	r3, 0
+	beq	2f
+
+	/* Flush the L2 cache */
+	mfspr	r3, SPRN_L2CSR0
+	ori	r3, r3, L2CSR0_L2FL@l
+	msync
+	isync
+	mtspr	SPRN_L2CSR0,r3
+	isync
+
+	/* check if it is complete */
+1:	mfspr	r3,SPRN_L2CSR0
+	andi.	r3, r3, L2CSR0_L2FL@l
+	bne	1b
+2:
+	blr
+
+_GLOBAL(__flush_caches_e500v2)
+	mflr r0
+	bl	flush_dcache_L1
+	mtlr r0
+	blr
+
+_GLOBAL(__flush_caches_e500mc)
+_GLOBAL(__flush_caches_e5500)
+	mflr r0
+	bl	flush_dcache_L1
+	bl	flush_backside_L2_cache
+	mtlr r0
+	blr
+
+/* L1 Data Cache of e6500 contains no modified data, no flush is required */
+_GLOBAL(__flush_caches_e6500)
+	blr
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index f830468..10e48a7 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -2021,6 +2021,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_e500v2,
 		.machine_check		= machine_check_e500,
 		.platform		= "ppc8548",
+		.cpu_flush_caches	= __flush_caches_e500v2,
 	},
 #else
 	{	/* e500mc */
@@ -2040,6 +2041,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_e500mc,
 		.machine_check		= machine_check_e500mc,
 		.platform		= "ppce500mc",
+		.cpu_flush_caches	= __flush_caches_e500mc,
 	},
 #endif /* CONFIG_PPC_E500MC */
 #endif /* CONFIG_PPC32 */
@@ -2064,6 +2066,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 #endif
 		.machine_check		= machine_check_e500mc,
 		.platform		= "ppce5500",
+		.cpu_flush_caches	= __flush_caches_e5500,
 	},
 	{	/* e6500 */
 		.pvr_mask		= 0xffff0000,
@@ -2086,6 +2089,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 #endif
 		.machine_check		= machine_check_e500mc,
 		.platform		= "ppce6500",
+		.cpu_flush_caches	= __flush_caches_e6500,
 	},
 #endif /* CONFIG_PPC_E500MC */
 #ifdef CONFIG_PPC32
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index fffd1f9..709bc50 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -1075,80 +1075,6 @@ _GLOBAL(set_context)
 	isync			/* Force context change */
 	blr
 
-_GLOBAL(flush_dcache_L1)
-	mfspr	r3,SPRN_L1CFG0
-
-	rlwinm	r5,r3,9,3	/* Extract cache block size */
-	twlgti	r5,1		/* Only 32 and 64 byte cache blocks
-				 * are currently defined.
-				 */
-	li	r4,32
-	subfic	r6,r5,2		/* r6 = log2(1KiB / cache block size) -
-				 *      log2(number of ways)
-				 */
-	slw	r5,r4,r5	/* r5 = cache block size */
-
-	rlwinm	r7,r3,0,0xff	/* Extract number of KiB in the cache */
-	mulli	r7,r7,13	/* An 8-way cache will require 13
-				 * loads per set.
-				 */
-	slw	r7,r7,r6
-
-	/* save off HID0 and set DCFA */
-	mfspr	r8,SPRN_HID0
-	ori	r9,r8,HID0_DCFA@l
-	mtspr	SPRN_HID0,r9
-	isync
-
-	lis	r4,KERNELBASE@h
-	mtctr	r7
-
-1:	lwz	r3,0(r4)	/* Load... */
-	add	r4,r4,r5
-	bdnz	1b
-
-	msync
-	lis	r4,KERNELBASE@h
-	mtctr	r7
-
-1:	dcbf	0,r4		/* ...and flush. */
-	add	r4,r4,r5
-	bdnz	1b
-	
-	/* restore HID0 */
-	mtspr	SPRN_HID0,r8
-	isync
-
-	blr
-
-/* Flush L1 d-cache, invalidate and disable d-cache and i-cache */
-_GLOBAL(__flush_disable_L1)
-	mflr	r10
-	bl	flush_dcache_L1	/* Flush L1 d-cache */
-	mtlr	r10
-
-	mfspr	r4, SPRN_L1CSR0	/* Invalidate and disable d-cache */
-	li	r5, 2
-	rlwimi	r4, r5, 0, 3
-
-	msync
-	isync
-	mtspr	SPRN_L1CSR0, r4
-	isync
-
-1:	mfspr	r4, SPRN_L1CSR0	/* Wait for the invalidate to finish */
-	andi.	r4, r4, 2
-	bne	1b
-
-	mfspr	r4, SPRN_L1CSR1	/* Invalidate and disable i-cache */
-	li	r5, 2
-	rlwimi	r4, r5, 0, 3
-
-	mtspr	SPRN_L1CSR1, r4
-	isync
-
-	blr
-
 #ifdef CONFIG_SMP
 /* When we get here, r24 needs to hold the CPU # */
 	.globl __secondary_start
diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index d7c1e69..fba474f 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -139,7 +139,8 @@ static void smp_85xx_mach_cpu_die(void)
 
 	mtspr(SPRN_TCR, 0);
 
-	__flush_disable_L1();
+	cur_cpu_spec->cpu_flush_caches();
+
 	tmp = (mfspr(SPRN_HID0) & ~(HID0_DOZE|HID0_SLEEP)) | HID0_NAP;
 	mtspr(SPRN_HID0, tmp);
 	isync();
-- 
1.9.1
