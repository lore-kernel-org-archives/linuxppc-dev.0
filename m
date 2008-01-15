Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 28B90DDEF0
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 02:50:28 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id m0FFoNvs022562
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2008 09:50:24 -0600
Date: Tue, 15 Jan 2008 09:48:10 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] 85xx: convert boards to use machine_device_initcall
Message-ID: <Pine.LNX.4.64.0801150947540.29635@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

---
 arch/powerpc/platforms/85xx/mpc85xx_ads.c |    6 ++----
 arch/powerpc/platforms/85xx/mpc85xx_cds.c |    6 +-----
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |    7 ++-----
 3 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index bccdc25..eb0a46b 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -233,13 +233,11 @@ static struct of_device_id __initdata of_bus_ids[] = {

 static int __init declare_of_platform_devices(void)
 {
-	if (!machine_is(mpc85xx_ads))
-		return 0;
-
 	of_platform_bus_probe(NULL, of_bus_ids, NULL);
+
 	return 0;
 }
-device_initcall(declare_of_platform_devices);
+machine_device_initcall(mpc85xx_ads, declare_of_platform_devices);

 /*
  * Called very early, device-tree isn't unflattened
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index 4d063ee..8b1de78 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -222,9 +222,6 @@ static int mpc85xx_cds_8259_attach(void)
 	struct device_node *cascade_node = NULL;
 	int cascade_irq;

-	if (!machine_is(mpc85xx_cds))
-		return 0;
-
 	/* Initialize the i8259 controller */
 	for_each_node_by_type(np, "interrupt-controller")
 		if (of_device_is_compatible(np, "chrp,iic")) {
@@ -262,8 +259,7 @@ static int mpc85xx_cds_8259_attach(void)

 	return 0;
 }
-
-device_initcall(mpc85xx_cds_8259_attach);
+machine_device_initcall(mpc85xx_cds, mpc85xx_cds_8259_attach);

 #endif /* CONFIG_PPC_I8259 */

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index e6c63a5..4fdf5ab 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -144,15 +144,12 @@ static struct of_device_id mpc85xx_ids[] = {

 static int __init mpc85xx_publish_devices(void)
 {
-	if (!machine_is(mpc85xx_mds))
-		return 0;
-
 	/* Publish the QE devices */
-	of_platform_bus_probe(NULL,mpc85xx_ids,NULL);
+	of_platform_bus_probe(NULL, mpc85xx_ids, NULL);

 	return 0;
 }
-device_initcall(mpc85xx_publish_devices);
+machine_device_initcall(mpc85xx_mds, mpc85xx_publish_devices);

 static void __init mpc85xx_mds_pic_init(void)
 {
-- 
1.5.3.7
