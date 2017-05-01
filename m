Return-Path: <matthew.weber@rockwellcollins.com>
Received: from secvs02.rockwellcollins.com (secvs02.rockwellcollins.com
 [205.175.225.241])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wGmbn5V8vzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 May 2017 00:13:07 +1000 (AEST)
From: Matt Weber <matthew.weber@rockwellcollins.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Matt Weber <matthew.weber@rockwellcollins.com>,
 Ronak Desai <ronak.desai@rockwellcollins.com>
Subject: [PATCH 1/1] powerpc/traps : Updated MC for E6500 L1D cache err
Date: Mon,  1 May 2017 08:56:03 -0500
Message-Id: <1493646963-51940-1-git-send-email-matthew.weber@rockwellcollins.com>
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
 arch/powerpc/kernel/traps.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 76f6045..f656277 100644
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
+		/* On e6500 core, L1 DCWS (Data cache write shadow mode) bit
+		 * is not implemented but L1 data cache always runs in write
+		 * shadow mode. Hence on data cache parity errors HW will
+		 * automatically invalidate the L1 Data Cache.
+		 */
+		if (PVR_VER(pvr) != PVR_VER_E6500) {
+			if (!(mfspr(SPRN_L1CSR2) & L1CSR2_DCWS))
+				recoverable = 0;
+		}
 	}
 
 	if (reason & MCSR_L2MMU_MHIT) {
-- 
1.9.1
