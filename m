Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 6392C67D58
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 14:50:24 +1100 (EST)
Date: Mon, 13 Nov 2006 14:50:28 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] iSeries: fix xmon.c for combined build
Message-Id: <20061113145028.70e8e8a0.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/xmon/xmon.c |   52 +++++++++++++++++++++++----------------------
 1 files changed, 27 insertions(+), 25 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 0689c08..d66c3a1 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -39,6 +39,7 @@
 #include <asm/irq_regs.h>
 #include <asm/spu.h>
 #include <asm/spu_priv1.h>
+#include <asm/firmware.h>
 
 #ifdef CONFIG_PPC64
 #include <asm/hvcall.h>
@@ -1567,11 +1568,6 @@ void super_regs(void)
 {
 	int cmd;
 	unsigned long val;
-#ifdef CONFIG_PPC_ISERIES
-	struct paca_struct *ptrPaca = NULL;
-	struct lppaca *ptrLpPaca = NULL;
-	struct ItLpRegSave *ptrLpRegSave = NULL;
-#endif
 
 	cmd = skipbl();
 	if (cmd == '\n') {
@@ -1588,26 +1584,32 @@ void super_regs(void)
 		printf("sp   = "REG"  sprg3= "REG"\n", sp, mfspr(SPRN_SPRG3));
 		printf("toc  = "REG"  dar  = "REG"\n", toc, mfspr(SPRN_DAR));
 #ifdef CONFIG_PPC_ISERIES
-		// Dump out relevant Paca data areas.
-		printf("Paca: \n");
-		ptrPaca = get_paca();
-    
-		printf("  Local Processor Control Area (LpPaca): \n");
-		ptrLpPaca = ptrPaca->lppaca_ptr;
-		printf("    Saved Srr0=%.16lx  Saved Srr1=%.16lx \n",
-		       ptrLpPaca->saved_srr0, ptrLpPaca->saved_srr1);
-		printf("    Saved Gpr3=%.16lx  Saved Gpr4=%.16lx \n",
-		       ptrLpPaca->saved_gpr3, ptrLpPaca->saved_gpr4);
-		printf("    Saved Gpr5=%.16lx \n", ptrLpPaca->saved_gpr5);
-    
-		printf("  Local Processor Register Save Area (LpRegSave): \n");
-		ptrLpRegSave = ptrPaca->reg_save_ptr;
-		printf("    Saved Sprg0=%.16lx  Saved Sprg1=%.16lx \n",
-		       ptrLpRegSave->xSPRG0, ptrLpRegSave->xSPRG0);
-		printf("    Saved Sprg2=%.16lx  Saved Sprg3=%.16lx \n",
-		       ptrLpRegSave->xSPRG2, ptrLpRegSave->xSPRG3);
-		printf("    Saved Msr  =%.16lx  Saved Nia  =%.16lx \n",
-		       ptrLpRegSave->xMSR, ptrLpRegSave->xNIA);
+		if (firmware_has_feature(FW_FEATURE_ISERIES)) {
+			struct paca_struct *ptrPaca;
+			struct lppaca *ptrLpPaca;
+			struct ItLpRegSave *ptrLpRegSave;
+
+			/* Dump out relevant Paca data areas. */
+			printf("Paca: \n");
+			ptrPaca = get_paca();
+
+			printf("  Local Processor Control Area (LpPaca): \n");
+			ptrLpPaca = ptrPaca->lppaca_ptr;
+			printf("    Saved Srr0=%.16lx  Saved Srr1=%.16lx \n",
+			       ptrLpPaca->saved_srr0, ptrLpPaca->saved_srr1);
+			printf("    Saved Gpr3=%.16lx  Saved Gpr4=%.16lx \n",
+			       ptrLpPaca->saved_gpr3, ptrLpPaca->saved_gpr4);
+			printf("    Saved Gpr5=%.16lx \n", ptrLpPaca->saved_gpr5);
+
+			printf("  Local Processor Register Save Area (LpRegSave): \n");
+			ptrLpRegSave = ptrPaca->reg_save_ptr;
+			printf("    Saved Sprg0=%.16lx  Saved Sprg1=%.16lx \n",
+			       ptrLpRegSave->xSPRG0, ptrLpRegSave->xSPRG0);
+			printf("    Saved Sprg2=%.16lx  Saved Sprg3=%.16lx \n",
+			       ptrLpRegSave->xSPRG2, ptrLpRegSave->xSPRG3);
+			printf("    Saved Msr  =%.16lx  Saved Nia  =%.16lx \n",
+			       ptrLpRegSave->xMSR, ptrLpRegSave->xNIA);
+		}
 #endif
 
 		return;
-- 
1.4.3.3
