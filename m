Return-Path: <Laurentiu.Tudor@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0144.outbound.protection.outlook.com [207.46.163.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7C7C21A02F4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 01:13:40 +1000 (EST)
From: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH][RESEND] powerpc/85xx: drop hypervisor specific board
 compatibles
Date: Wed, 11 Jun 2014 18:13:19 +0300
Message-ID: <1402499599-24824-1-git-send-email-Laurentiu.Tudor@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

They're almost a duplicate of the boards array
and we can build them at run-time.

Signed-off-by: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
---
 arch/powerpc/platforms/85xx/corenet_generic.c | 49 +++++++++++----------------
 1 file changed, 20 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index 5db1e11..7850988 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -129,28 +129,14 @@ static const char * const boards[] __initconst = {
 	NULL
 };
 
-static const char * const hv_boards[] __initconst = {
-	"fsl,P2041RDB-hv",
-	"fsl,P3041DS-hv",
-	"fsl,OCA4080-hv",
-	"fsl,P4080DS-hv",
-	"fsl,P5020DS-hv",
-	"fsl,P5040DS-hv",
-	"fsl,T4240QDS-hv",
-	"fsl,B4860QDS-hv",
-	"fsl,B4420QDS-hv",
-	"fsl,B4220QDS-hv",
-	"fsl,T1040QDS-hv",
-	"fsl,T1042QDS-hv",
-	NULL
-};
-
 /*
  * Called very early, device-tree isn't unflattened
  */
 static int __init corenet_generic_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
+	char hv_compat[24];
+	int i;
 #ifdef CONFIG_SMP
 	extern struct smp_ops_t smp_85xx_ops;
 #endif
@@ -159,21 +145,26 @@ static int __init corenet_generic_probe(void)
 		return 1;
 
 	/* Check if we're running under the Freescale hypervisor */
-	if (of_flat_dt_match(root, hv_boards)) {
-		ppc_md.init_IRQ = ehv_pic_init;
-		ppc_md.get_irq = ehv_pic_get_irq;
-		ppc_md.restart = fsl_hv_restart;
-		ppc_md.power_off = fsl_hv_halt;
-		ppc_md.halt = fsl_hv_halt;
+	for (i = 0; boards[i]; i++) {
+		snprintf(hv_compat, sizeof(hv_compat), "%s-hv", boards[i]);
+		if (of_flat_dt_is_compatible(root, hv_compat)) {
+			ppc_md.init_IRQ = ehv_pic_init;
+
+			ppc_md.get_irq = ehv_pic_get_irq;
+			ppc_md.restart = fsl_hv_restart;
+			ppc_md.power_off = fsl_hv_halt;
+			ppc_md.halt = fsl_hv_halt;
 #ifdef CONFIG_SMP
-		/*
-		 * Disable the timebase sync operations because we can't write
-		 * to the timebase registers under the hypervisor.
-		  */
-		smp_85xx_ops.give_timebase = NULL;
-		smp_85xx_ops.take_timebase = NULL;
+			/*
+			 * Disable the timebase sync operations because we
+			 * can't write to the timebase registers under the
+			 * hypervisor.
+			 */
+			smp_85xx_ops.give_timebase = NULL;
+			smp_85xx_ops.take_timebase = NULL;
 #endif
-		return 1;
+			return 1;
+		}
 	}
 
 	return 0;
-- 
1.9.2
