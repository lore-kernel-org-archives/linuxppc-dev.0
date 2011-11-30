Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 22D921007D1
 for <linuxppc-dev@ozlabs.org>; Thu,  1 Dec 2011 03:19:25 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: <kumar.gala@freescale.com>, <benh@kernel.crashing.org>,
 <scottwood@freescale.com>, <dbaryshkov@gmail.com>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/85xx: don't call of_platform_bus_probe() twice
Date: Wed, 30 Nov 2011 10:19:17 -0600
Message-ID: <1322669957-8259-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 46d026ac ("powerpc/85xx: consolidate of_platform_bus_probe calls")
replaced platform-specific of_device_id tables with a single function
that probes the most of the busses in 85xx device trees.  If a specific
platform needed additional busses probed, then it could call
of_platform_bus_probe() again.  Typically, the additional platform-specific
busses are children of existing busses that have already been probed.
of_platform_bus_probe() does not handle those child busses automatically.

Unfortunately, this doesn't actually work.  The second (platform-specific)
call to of_platform_bus_probe() never finds any of the busses it's asked
to find.

To remedy this, the platform-specific of_device_id tables are eliminated,
and their entries are merged into mpc85xx_common_ids[], so that all busses
are probed at once.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/platforms/85xx/common.c      |    6 ++++++
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |   11 +----------
 arch/powerpc/platforms/85xx/p1022_ds.c    |   13 +------------
 3 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/common.c b/arch/powerpc/platforms/85xx/common.c
index 9fef530..67dac22 100644
--- a/arch/powerpc/platforms/85xx/common.c
+++ b/arch/powerpc/platforms/85xx/common.c
@@ -21,6 +21,12 @@ static struct of_device_id __initdata mpc85xx_common_ids[] = {
 	{ .compatible = "fsl,qe", },
 	{ .compatible = "fsl,cpm2", },
 	{ .compatible = "fsl,srio", },
+	/* So that the DMA channel nodes can be probed individually: */
+	{ .compatible = "fsl,eloplus-dma", },
+	/* For the PMC driver */
+	{ .compatible = "fsl,mpc8548-guts", },
+	/* Probably unnecessary? */
+	{ .compatible = "gpio-leds", },
 	{},
 };
 
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 495cfd9..4a555ee 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -410,12 +410,6 @@ static int __init board_fixups(void)
 machine_arch_initcall(mpc8568_mds, board_fixups);
 machine_arch_initcall(mpc8569_mds, board_fixups);
 
-static struct of_device_id mpc85xx_ids[] = {
-	{ .compatible = "fsl,mpc8548-guts", },
-	{ .compatible = "gpio-leds", },
-	{},
-};
-
 static int __init mpc85xx_publish_devices(void)
 {
 	if (machine_is(mpc8568_mds))
@@ -423,10 +417,7 @@ static int __init mpc85xx_publish_devices(void)
 	if (machine_is(mpc8569_mds))
 		simple_gpiochip_init("fsl,mpc8569mds-bcsr-gpio");
 
-	mpc85xx_common_publish_devices();
-	of_platform_bus_probe(NULL, mpc85xx_ids, NULL);
-
-	return 0;
+	return mpc85xx_common_publish_devices();
 }
 
 machine_device_initcall(mpc8568_mds, mpc85xx_publish_devices);
diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index 2bf4342..ea6190b 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -326,18 +326,7 @@ static void __init p1022_ds_setup_arch(void)
 	pr_info("Freescale P1022 DS reference board\n");
 }
 
-static struct of_device_id __initdata p1022_ds_ids[] = {
-	/* So that the DMA channel nodes can be probed individually: */
-	{ .compatible = "fsl,eloplus-dma", },
-	{},
-};
-
-static int __init p1022_ds_publish_devices(void)
-{
-	mpc85xx_common_publish_devices();
-	return of_platform_bus_probe(NULL, p1022_ds_ids, NULL);
-}
-machine_device_initcall(p1022_ds, p1022_ds_publish_devices);
+machine_device_initcall(p1022_ds, mpc85xx_common_publish_devices);
 
 machine_arch_initcall(p1022_ds, swiotlb_setup_bus_notifier);
 
-- 
1.7.3.4
