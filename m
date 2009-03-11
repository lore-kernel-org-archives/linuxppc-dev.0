Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 38F16DDDB6
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 22:46:08 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n2BBk4UC023285
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 06:46:04 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/85xx: Update smp support to handle doorbells and
	non-mpic init
Date: Wed, 11 Mar 2009 06:46:03 -0500
Message-Id: <1236771963-28181-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Use device tree to determine if we actually have an MPIC and use
CPU feature to decide if we should use doorbells for IPIs.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/85xx/smp.c |   43 ++++++++++++++++++++++++++++++-------
 1 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index 79a0df1..cc0b0db 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -21,6 +21,7 @@
 #include <asm/page.h>
 #include <asm/mpic.h>
 #include <asm/cacheflush.h>
+#include <asm/dbell.h>
 
 #include <sysdev/fsl_soc.h>
 
@@ -80,10 +81,8 @@ smp_85xx_kick_cpu(int nr)
 }
 
 static void __init
-smp_85xx_setup_cpu(int cpu_nr)
+smp_85xx_basic_setup(int cpu_nr)
 {
-	mpic_setup_this_cpu();
-
 	/* Clear any pending timer interrupts */
 	mtspr(SPRN_TSR, TSR_ENW | TSR_WIS | TSR_DIS | TSR_FIS);
 
@@ -91,15 +90,43 @@ smp_85xx_setup_cpu(int cpu_nr)
 	mtspr(SPRN_TCR, TCR_DIE);
 }
 
+static void __init
+smp_85xx_setup_cpu(int cpu_nr)
+{
+	mpic_setup_this_cpu();
+
+	smp_85xx_basic_setup(cpu_nr);
+}
+
 struct smp_ops_t smp_85xx_ops = {
-	.message_pass = smp_mpic_message_pass,
-	.probe = smp_mpic_probe,
 	.kick_cpu = smp_85xx_kick_cpu,
-	.setup_cpu = smp_85xx_setup_cpu,
 };
 
-void __init
-mpc85xx_smp_init(void)
+static int __init smp_dummy_probe(void)
 {
+	return NR_CPUS;
+}
+
+void __init mpc85xx_smp_init(void)
+{
+	struct device_node *np;
+
+	smp_85xx_ops.message_pass = NULL;
+
+	np = of_find_node_by_type(NULL, "open-pic");
+	if (np) {
+		smp_85xx_ops.probe = smp_mpic_probe;
+		smp_85xx_ops.setup_cpu = smp_85xx_setup_cpu;
+		smp_85xx_ops.message_pass = smp_mpic_message_pass;
+	} else {
+		smp_85xx_ops.probe = smp_dummy_probe;
+		smp_85xx_ops.setup_cpu = smp_85xx_basic_setup;
+	}
+
+	if (cpu_has_feature(CPU_FTR_DBELL))
+		smp_85xx_ops.message_pass = smp_dbell_message_pass;
+
+	BUG_ON(!smp_85xx_ops.message_pass);
+
 	smp_ops = &smp_85xx_ops;
 }
-- 
1.5.6.6
