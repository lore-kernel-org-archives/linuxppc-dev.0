Return-Path: <matthew.weber@rockwellcollins.com>
Received: from ch3vs02.rockwellcollins.com (ch3vs02.rockwellcollins.com
 [205.175.226.29])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDQ3P16pxzDq72
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 04:10:23 +1000 (AEST)
From: Matt Weber <matthew.weber@rockwellcollins.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Matt Weber <matthew.weber@rockwellcollins.com>,
 Ronak Desai <ronak.desai@rockwellcollins.com>
Subject: [PATCH 1/1] powerpc/traps : Updated MC for E6500 L1D cache err
Date: Thu, 27 Apr 2017 12:59:40 -0500
Message-Id: <1493315980-28480-1-git-send-email-matthew.weber@rockwellcollins.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch updates the machine check handler of Linux kernel to
handle the e6500 architecture case. In e6500 core, L1 Data Cache Write
Shadow Mode (DCWS) register is not implemented but L1 data cache always
runs in write shadow mode. So, on L1 data cache parity errors, hardware
will automatically invalidate the data cache but will still log a
machine check interrupt.

Signed-off-by: Ronak Desai <ronak.desai@rockwellcollins.com>
Signed-off-by: Matthew Weber <matthew.weber@rockwellcollins.com>
---
 arch/powerpc/include/asm/reg_booke.h |  1 +
 arch/powerpc/kernel/traps.c          | 12 ++++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index 737e012..c811128 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -196,6 +196,7 @@
 #define SPRN_DEAR	0x03D	/* Data Error Address Register */
 #define SPRN_ESR	0x03E	/* Exception Syndrome Register */
 #define SPRN_PIR	0x11E	/* Processor Identification Register */
+#define SPRN_PVR	0x11F	/* Processor Version Register */
 #define SPRN_DBSR	0x130	/* Debug Status Register */
 #define SPRN_DBCR0	0x134	/* Debug Control Register 0 */
 #define SPRN_DBCR1	0x135	/* Debug Control Register 1 */
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 76f6045..d5bc3ab 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -504,6 +504,7 @@ int machine_check_47x(struct pt_regs *regs)
 int machine_check_e500mc(struct pt_regs *regs)
 {
 	unsigned long mcsr = mfspr(SPRN_MCSR);
+	unsigned long pvr = mfspr(SPRN_PVR);
 	unsigned long reason = mcsr;
 	int recoverable = 1;
 
@@ -545,8 +546,15 @@ int machine_check_e500mc(struct pt_regs *regs)
 		 * may still get logged and cause a machine check.  We should
 		 * only treat the non-write shadow case as non-recoverable.
 		 */
-		if (!(mfspr(SPRN_L1CSR2) & L1CSR2_DCWS))
-			recoverable = 0;
+		/* On e6500 core, L1 DCWS (Data cache write shadow mode) bit is
+		 * not implemented but L1 data cache is by default configured
+		 * to run in write shadow mode. Hence on data cache parity errors
+		 * HW will automatically invalidate the L1 Data Cache.
+		 */
+		if (PVR_VER(pvr) != PVR_VER_E6500) {
+			if (!(mfspr(SPRN_L1CSR2) & L1CSR2_DCWS))
+				recoverable = 0;
+		}
 	}
 
 	if (reason & MCSR_L2MMU_MHIT) {
-- 
1.9.1
