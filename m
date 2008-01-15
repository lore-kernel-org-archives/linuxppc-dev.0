Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EDA8BDDDEF
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 02:50:51 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id m0FFokoC022600
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2008 09:50:47 -0600
Date: Tue, 15 Jan 2008 09:48:33 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] 83xx: convert boards to use machine_device_initcall
Message-ID: <Pine.LNX.4.64.0801150948120.29635@blarg.am.freescale.net>
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
 arch/powerpc/platforms/83xx/mpc832x_mds.c |    5 +----
 arch/powerpc/platforms/83xx/mpc832x_rdb.c |   10 ++--------
 arch/powerpc/platforms/83xx/mpc834x_mds.c |    5 +----
 arch/powerpc/platforms/83xx/mpc836x_mds.c |    5 +----
 arch/powerpc/platforms/83xx/mpc837x_mds.c |    5 +----
 5 files changed, 6 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
index 1e570bb..dbdd4ad 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -110,15 +110,12 @@ static struct of_device_id mpc832x_ids[] = {

 static int __init mpc832x_declare_of_platform_devices(void)
 {
-	if (!machine_is(mpc832x_mds))
-		return 0;
-
 	/* Publish the QE devices */
 	of_platform_bus_probe(NULL, mpc832x_ids, NULL);

 	return 0;
 }
-device_initcall(mpc832x_declare_of_platform_devices);
+machine_device_initcall(mpc832x_mds, mpc832x_declare_of_platform_devices);

 static void __init mpc832x_sys_init_IRQ(void)
 {
diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index ffb2e93..5fddd22 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -63,9 +63,6 @@ static struct spi_board_info mpc832x_spi_boardinfo = {

 static int __init mpc832x_spi_init(void)
 {
-	if (!machine_is(mpc832x_rdb))
-		return 0;
-
 	par_io_config_pin(3,  0, 3, 0, 1, 0); /* SPI1 MOSI, I/O */
 	par_io_config_pin(3,  1, 3, 0, 1, 0); /* SPI1 MISO, I/O */
 	par_io_config_pin(3,  2, 3, 0, 1, 0); /* SPI1 CLK,  I/O */
@@ -80,7 +77,7 @@ static int __init mpc832x_spi_init(void)
 			    mpc83xx_spi_deactivate_cs);
 }

-device_initcall(mpc832x_spi_init);
+machine_device_initcall(mpc832x_rdb, mpc832x_spi_init);

 /* ************************************************************************
  *
@@ -123,15 +120,12 @@ static struct of_device_id mpc832x_ids[] = {

 static int __init mpc832x_declare_of_platform_devices(void)
 {
-	if (!machine_is(mpc832x_rdb))
-		return 0;
-
 	/* Publish the QE devices */
 	of_platform_bus_probe(NULL, mpc832x_ids, NULL);

 	return 0;
 }
-device_initcall(mpc832x_declare_of_platform_devices);
+machine_device_initcall(mpc832x_rdb, mpc832x_declare_of_platform_devices);

 void __init mpc832x_rdb_init_IRQ(void)
 {
diff --git a/arch/powerpc/platforms/83xx/mpc834x_mds.c b/arch/powerpc/platforms/83xx/mpc834x_mds.c
index 459fb72..2b8a0a3 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_mds.c
@@ -115,13 +115,10 @@ static struct of_device_id mpc834x_ids[] = {

 static int __init mpc834x_declare_of_platform_devices(void)
 {
-	if (!machine_is(mpc834x_mds))
-		return 0;
-
 	of_platform_bus_probe(NULL, mpc834x_ids, NULL);
 	return 0;
 }
-device_initcall(mpc834x_declare_of_platform_devices);
+machine_device_initcall(mpc834x_mds, mpc834x_declare_of_platform_devices);

 /*
  * Called very early, MMU is off, device-tree isn't unflattened
diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platforms/83xx/mpc836x_mds.c
index 2ac9890..db491ec 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -141,15 +141,12 @@ static struct of_device_id mpc836x_ids[] = {

 static int __init mpc836x_declare_of_platform_devices(void)
 {
-	if (!machine_is(mpc836x_mds))
-		return 0;
-
 	/* Publish the QE devices */
 	of_platform_bus_probe(NULL, mpc836x_ids, NULL);

 	return 0;
 }
-device_initcall(mpc836x_declare_of_platform_devices);
+machine_device_initcall(mpc836x_mds, mpc836x_declare_of_platform_devices);

 static void __init mpc836x_mds_init_IRQ(void)
 {
diff --git a/arch/powerpc/platforms/83xx/mpc837x_mds.c b/arch/powerpc/platforms/83xx/mpc837x_mds.c
index 9cdc32b..cfd0548 100644
--- a/arch/powerpc/platforms/83xx/mpc837x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc837x_mds.c
@@ -50,15 +50,12 @@ static struct of_device_id mpc837x_ids[] = {

 static int __init mpc837x_declare_of_platform_devices(void)
 {
-	if (!machine_is(mpc837x_mds))
-		return 0;
-
 	/* Publish of_device */
 	of_platform_bus_probe(NULL, mpc837x_ids, NULL);

 	return 0;
 }
-device_initcall(mpc837x_declare_of_platform_devices);
+machine_device_initcall(mpc837x_mds, mpc837x_declare_of_platform_devices);

 static void __init mpc837x_mds_init_IRQ(void)
 {
-- 
1.5.3.7
