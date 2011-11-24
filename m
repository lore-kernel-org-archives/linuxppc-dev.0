Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 71504B7010
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Nov 2011 18:08:53 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pAO78ltB001982
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Nov 2011 01:08:49 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] powerpc/85xx: Additional consolidate
 of_platform_bus_probe calls
Date: Thu, 24 Nov 2011 01:08:46 -0600
Message-Id: <1322118527-14348-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

P1010RDB & P1023RDS can use the new mpc85xx_common_publish_devices().
Also move 'fsl,srio' into the list of standard buses.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/85xx/mpc85xx_common.c |    1 +
 arch/powerpc/platforms/85xx/mpc85xx_mds.c    |    1 -
 arch/powerpc/platforms/85xx/p1010rdb.c       |   15 +++------------
 arch/powerpc/platforms/85xx/p1023_rds.c      |   19 +++----------------
 4 files changed, 7 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_common.c b/arch/powerpc/platforms/85xx/mpc85xx_common.c
index fe40668..9fef530 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_common.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_common.c
@@ -20,6 +20,7 @@ static struct of_device_id __initdata mpc85xx_common_ids[] = {
 	{ .compatible = "gianfar", },
 	{ .compatible = "fsl,qe", },
 	{ .compatible = "fsl,cpm2", },
+	{ .compatible = "fsl,srio", },
 	{},
 };
 
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 38cb473..495cfd9 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -411,7 +411,6 @@ machine_arch_initcall(mpc8568_mds, board_fixups);
 machine_arch_initcall(mpc8569_mds, board_fixups);
 
 static struct of_device_id mpc85xx_ids[] = {
-	{ .compatible = "fsl,srio", },
 	{ .compatible = "fsl,mpc8548-guts", },
 	{ .compatible = "gpio-leds", },
 	{},
diff --git a/arch/powerpc/platforms/85xx/p1010rdb.c b/arch/powerpc/platforms/85xx/p1010rdb.c
index d7387fa..2f479f8 100644
--- a/arch/powerpc/platforms/85xx/p1010rdb.c
+++ b/arch/powerpc/platforms/85xx/p1010rdb.c
@@ -28,6 +28,8 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
+#include "mpc85xx.h"
+
 void __init p1010_rdb_pic_init(void)
 {
 	struct mpic *mpic;
@@ -81,18 +83,7 @@ static void __init p1010_rdb_setup_arch(void)
 	printk(KERN_INFO "P1010 RDB board from Freescale Semiconductor\n");
 }
 
-static struct of_device_id __initdata p1010rdb_ids[] = {
-	{ .type = "soc", },
-	{ .compatible = "soc", },
-	{ .compatible = "simple-bus", },
-	{},
-};
-
-static int __init p1010rdb_publish_devices(void)
-{
-	return of_platform_bus_probe(NULL, p1010rdb_ids, NULL);
-}
-machine_device_initcall(p1010_rdb, p1010rdb_publish_devices);
+machine_device_initcall(p1010_rdb, mpc85xx_common_publish_devices);
 machine_arch_initcall(p1010_rdb, swiotlb_setup_bus_notifier);
 
 /*
diff --git a/arch/powerpc/platforms/85xx/p1023_rds.c b/arch/powerpc/platforms/85xx/p1023_rds.c
index 835e0b3..e76c4dc 100644
--- a/arch/powerpc/platforms/85xx/p1023_rds.c
+++ b/arch/powerpc/platforms/85xx/p1023_rds.c
@@ -34,6 +34,8 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
+#include "mpc85xx.h"
+
 /* ************************************************************************
  *
  * Setup the architecture
@@ -92,22 +94,7 @@ static void __init mpc85xx_rds_setup_arch(void)
 #endif
 }
 
-static struct of_device_id p1023_ids[] = {
-	{ .type = "soc", },
-	{ .compatible = "soc", },
-	{ .compatible = "simple-bus", },
-	{},
-};
-
-
-static int __init p1023_publish_devices(void)
-{
-	of_platform_bus_probe(NULL, p1023_ids, NULL);
-
-	return 0;
-}
-
-machine_device_initcall(p1023_rds, p1023_publish_devices);
+machine_device_initcall(p1023_rds, mpc85xx_common_publish_devices);
 
 static void __init mpc85xx_rds_pic_init(void)
 {
-- 
1.7.3.4
