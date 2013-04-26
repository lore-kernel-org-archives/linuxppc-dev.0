Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/7] powerpc: Initialise PMU related regs on Power8
Date: Fri, 26 Apr 2013 15:28:22 +1000
Message-Id: <1366954108-27081-1-git-send-email-michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For both HV and guest kernels, intialise PMU regs to something sane.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/include/asm/reg.h        |    6 ++++++
 arch/powerpc/kernel/cpu_setup_power.S |   21 ++++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 4ae2d44..5735ebb 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -271,6 +271,7 @@
 #define SPRN_HFSCR	0xbe	/* HV=1 Facility Status & Control Register */
 #define   HFSCR_TAR	(1 << (63-55)) /* Enable Target Address Register */
 #define   HFSCR_TM	(1 << (63-58)) /* Enable Transactional Memory */
+#define   HFSCR_PM	(1 << (63-60)) /* Enable prob/priv access to PMU SPRs */
 #define   HFSCR_DSCR	(1 << (63-61)) /* Enable Data Stream Control Register */
 #define   HFSCR_VECVSX	(1 << (63-62)) /* Enable VMX/VSX  */
 #define   HFSCR_FP	(1 << (63-63)) /* Enable Floating Point */
@@ -637,6 +638,7 @@
 #define   MMCR0_FCWAIT	0x00000002UL /* freeze counter in WAIT state */
 #define   MMCR0_FCHV	0x00000001UL /* freeze conditions in hypervisor mode */
 #define SPRN_MMCR1	798
+#define SPRN_MMCR2	769
 #define SPRN_MMCRA	0x312
 #define   MMCRA_SDSYNC	0x80000000UL /* SDAR synced with SIAR */
 #define   MMCRA_SDAR_DCACHE_MISS 0x40000000UL
@@ -655,6 +657,10 @@
 #define   POWER7P_MMCRA_SIAR_VALID 0x10000000	/* P7+ SIAR contents valid */
 #define   POWER7P_MMCRA_SDAR_VALID 0x08000000	/* P7+ SDAR contents valid */
 
+#define SPRN_MMCRH	316	/* Hypervisor monitor mode control register */
+#define SPRN_MMCRS	894	/* Supervisor monitor mode control register */
+#define SPRN_MMCRC	851	/* Core monitor mode control register */
+
 #define SPRN_PMC1	787
 #define SPRN_PMC2	788
 #define SPRN_PMC3	789
diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
index 2e6ad11..02a6945 100644
--- a/arch/powerpc/kernel/cpu_setup_power.S
+++ b/arch/powerpc/kernel/cpu_setup_power.S
@@ -49,6 +49,7 @@ _GLOBAL(__restore_cpu_power7)
 _GLOBAL(__setup_cpu_power8)
 	mflr	r11
 	bl	__init_FSCR
+	bl	__init_PMU
 	bl	__init_hvmode_206
 	mtlr	r11
 	beqlr
@@ -59,12 +60,14 @@ _GLOBAL(__setup_cpu_power8)
 	bl	__init_LPCR
 	bl	__init_HFSCR
 	bl	__init_TLB
+	bl	__init_PMU_HV
 	mtlr	r11
 	blr
 
 _GLOBAL(__restore_cpu_power8)
 	mflr	r11
 	bl	__init_FSCR
+	bl	__init_PMU
 	mfmsr	r3
 	rldicl.	r0,r3,4,63
 	beqlr
@@ -75,6 +78,7 @@ _GLOBAL(__restore_cpu_power8)
 	bl	__init_LPCR
 	bl	__init_HFSCR
 	bl	__init_TLB
+	bl	__init_PMU_HV
 	mtlr	r11
 	blr
 
@@ -124,7 +128,7 @@ __init_FSCR:
 
 __init_HFSCR:
 	mfspr	r3,SPRN_HFSCR
-	ori	r3,r3,HFSCR_TAR|HFSCR_TM|HFSCR_DSCR|HFSCR_VECVSX|HFSCR_FP
+	ori	r3,r3,HFSCR_TAR|HFSCR_TM|HFSCR_DSCR|HFSCR_VECVSX|HFSCR_FP|HFSCR_PM
 	mtspr	SPRN_HFSCR,r3
 	blr
 
@@ -139,3 +143,18 @@ __init_TLB:
 	bdnz	2b
 	ptesync
 1:	blr
+
+__init_PMU_HV:
+	li	r5,0
+	mtspr	SPRN_MMCRC,r5
+	mtspr	SPRN_MMCRH,r5
+	blr
+
+__init_PMU:
+	li	r5,0
+	mtspr	SPRN_MMCRS,r5
+	mtspr	SPRN_MMCRA,r5
+	mtspr	SPRN_MMCR0,r5
+	mtspr	SPRN_MMCR1,r5
+	mtspr	SPRN_MMCR2,r5
+	blr
-- 
1.7.10.4
