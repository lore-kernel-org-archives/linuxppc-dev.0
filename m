Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3C892B6FA6
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Aug 2011 21:18:41 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p7RBIbI0024415
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Aug 2011 06:18:38 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/fsl-booke: Handle L1 D-cache parity error correctly
	on e500mc
Date: Sat, 27 Aug 2011 06:18:37 -0500
Message-Id: <1314443917-18515-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If the L1 D-Cache is in write shadow mode the HW will auto-recover the
error.  However we might still log the error and cause a machine check
(if L1CSR0[CPE] - Cache error checking enable).  We should only treat
the non-write shadow case as non-recoverable.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/include/asm/reg_booke.h |    3 +++
 arch/powerpc/kernel/traps.c          |    9 ++++++++-
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index 2d8c920..9856452 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -551,6 +551,9 @@
 #define L1CSR1_ICFI	0x00000002	/* Instr Cache Flash Invalidate */
 #define L1CSR1_ICE	0x00000001	/* Instr Cache Enable */
 
+/* Bit definitions for L1CSR2. */
+#define L1CSR2_DCWS	0x40000000	/* Data Cache write shadow */
+
 /* Bit definitions for L2CSR0. */
 #define L2CSR0_L2E	0x80000000	/* L2 Cache Enable */
 #define L2CSR0_L2PE	0x40000000	/* L2 Cache Parity/ECC Enable */
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 1a01414..a1a40f9 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -457,7 +457,14 @@ int machine_check_e500mc(struct pt_regs *regs)
 
 	if (reason & MCSR_DCPERR_MC) {
 		printk("Data Cache Parity Error\n");
-		recoverable = 0;
+
+		/*
+		 * In write shadow mode we auto-recover from the error, but it
+		 * may still get logged and cause a machine check.  We should
+		 * only treat the non-write shadow case as non-recoverable.
+		 */
+		if (!(mfspr(SPRN_L1CSR2) & L1CSR2_DCWS))
+			recoverable = 0;
 	}
 
 	if (reason & MCSR_L2MMU_MHIT) {
-- 
1.7.3.4
