Return-Path: <ncase@xes-inc.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6B7A2B7159
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 06:37:40 +1000 (EST)
Received: from xes-mad.com (xes-mad.com [216.165.139.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 93B4EDDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 06:37:39 +1000 (EST)
From: Nate Case <ncase@xes-inc.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH -next] powerpc/fsl-booke: Enable L1 cache on
	e500v1/e500v2/e500mc CPUs
Date: Wed, 10 Jun 2009 15:37:28 -0500
Message-Id: <1244666248-23322-1-git-send-email-ncase@xes-inc.com>
Cc: linuxppc-dev@ozlabs.org, Nate Case <ncase@xes-inc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some boot loaders may not enable L1 instruction/data cache.  Check if
data and instruction caches are enabled, and enable them if needed.

Signed-off-by: Nate Case <ncase@xes-inc.com>
---
 arch/powerpc/include/asm/reg_booke.h      |    2 +
 arch/powerpc/kernel/cpu_setup_fsl_booke.S |   49 +++++++++++++++++++++++++++--
 2 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index 601ddbc..6bcf364 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -389,12 +389,14 @@
 #define ICCR_CACHE	1		/* Cacheable */
 
 /* Bit definitions for L1CSR0. */
+#define L1CSR0_CPE	0x00010000	/* Data Cache Parity Enable */
 #define L1CSR0_CLFC	0x00000100	/* Cache Lock Bits Flash Clear */
 #define L1CSR0_DCFI	0x00000002	/* Data Cache Flash Invalidate */
 #define L1CSR0_CFI	0x00000002	/* Cache Flash Invalidate */
 #define L1CSR0_DCE	0x00000001	/* Data Cache Enable */
 
 /* Bit definitions for L1CSR1. */
+#define L1CSR1_CPE	0x00010000	/* Instruction Cache Parity Enable */
 #define L1CSR1_ICLFR	0x00000100	/* Instr Cache Lock Bits Flash Reset */
 #define L1CSR1_ICFI	0x00000002	/* Instr Cache Flash Invalidate */
 #define L1CSR1_ICE	0x00000001	/* Instr Cache Enable */
diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
index eb4b9ad..0adb50a 100644
--- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
+++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
@@ -17,6 +17,40 @@
 #include <asm/cputable.h>
 #include <asm/ppc_asm.h>
 
+_GLOBAL(__e500_icache_setup)
+	mfspr	r0, SPRN_L1CSR1
+	andi.	r3, r0, L1CSR1_ICE
+	bnelr				/* Already enabled */
+	oris	r0, r0, L1CSR1_CPE@h
+	ori	r0, r0, (L1CSR1_ICFI | L1CSR1_ICLFR |  L1CSR1_ICE)
+	mtspr	SPRN_L1CSR1, r0		/* Enable I-Cache */
+	isync
+	blr
+
+_GLOBAL(__e500_dcache_setup)
+	mfspr	r0, SPRN_L1CSR0
+	andi.	r3, r0, L1CSR0_DCE
+	bnelr				/* Already enabled */
+	msync
+	isync
+	li	r0, 0
+	mtspr	SPRN_L1CSR0, r0		/* Disable */
+	msync
+	isync
+	li	r0, (L1CSR0_DCFI | L1CSR0_CLFC)
+	mtspr	SPRN_L1CSR0, r0		/* Invalidate */
+	isync
+1:	mfspr	r0, SPRN_L1CSR0
+	andi.	r3, r0, L1CSR0_CLFC
+	bne+	1b			/* Wait for lock bits reset */
+	oris	r0, r0, L1CSR0_CPE@h
+	ori	r0, r0, L1CSR0_DCE
+	msync
+	isync
+	mtspr	SPRN_L1CSR0, r0		/* Enable */
+	isync
+	blr
+
 _GLOBAL(__setup_cpu_e200)
 	/* enable dedicated debug exception handling resources (Debug APU) */
 	mfspr	r3,SPRN_HID0
@@ -25,7 +59,16 @@ _GLOBAL(__setup_cpu_e200)
 	b	__setup_e200_ivors
 _GLOBAL(__setup_cpu_e500v1)
 _GLOBAL(__setup_cpu_e500v2)
-	b	__setup_e500_ivors
+	mflr	r4
+	bl	__e500_icache_setup
+	bl	__e500_dcache_setup
+	bl	__setup_e500_ivors
+	mtlr	r4
+	blr
 _GLOBAL(__setup_cpu_e500mc)
-	b	__setup_e500mc_ivors
-
+	mflr	r4
+	bl	__e500_icache_setup
+	bl	__e500_dcache_setup
+	bl	__setup_e500mc_ivors
+	mtlr	r4
+	blr
-- 
1.6.0.2
