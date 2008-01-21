Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 753E8DDE30
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 05:59:23 +1100 (EST)
Received: from pd3mr6so.prod.shaw.ca (pd3mr6so-qfe3.prod.shaw.ca [10.0.141.21])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JV000J4BCPUXED0@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 21 Jan 2008 11:58:42 -0700 (MST)
Received: from pn2ml6so.prod.shaw.ca ([10.0.121.150])
	by pd3mr6so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JV000C6BCPSP6B0@pd3mr6so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Mon, 21 Jan 2008 11:58:43 -0700 (MST)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JV000H46CPRKH60@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 21 Jan 2008 11:58:39 -0700 (MST)
Date: Mon, 21 Jan 2008 11:58:12 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 2/2] [POWERPC] 8xxx and embedded6xx: Use machine_*_initcall()
	hooks in platform code
In-reply-to: <20080121185806.13486.56429.stgit@trillian.secretlab.ca>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Message-id: <20080121185812.13486.68032.stgit@trillian.secretlab.ca>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20080121185806.13486.56429.stgit@trillian.secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/platforms/82xx/mpc8272_ads.c    |    5 +----
 arch/powerpc/platforms/82xx/pq2fads.c        |    5 +----
 arch/powerpc/platforms/83xx/mpc832x_mds.c    |    5 +----
 arch/powerpc/platforms/83xx/mpc832x_rdb.c    |   11 ++---------
 arch/powerpc/platforms/83xx/mpc834x_mds.c    |    5 +----
 arch/powerpc/platforms/83xx/mpc836x_mds.c    |    5 +----
 arch/powerpc/platforms/83xx/mpc837x_mds.c    |    5 +----
 arch/powerpc/platforms/85xx/mpc85xx_ads.c    |    5 +----
 arch/powerpc/platforms/85xx/mpc85xx_cds.c    |    6 +-----
 arch/powerpc/platforms/85xx/mpc85xx_mds.c    |    5 +----
 arch/powerpc/platforms/embedded6xx/ls_uart.c |    5 +----
 11 files changed, 12 insertions(+), 50 deletions(-)

diff --git a/arch/powerpc/platforms/82xx/mpc8272_ads.c b/arch/powerpc/platforms/82xx/mpc8272_ads.c
index fd83440..3fce6b3 100644
--- a/arch/powerpc/platforms/82xx/mpc8272_ads.c
+++ b/arch/powerpc/platforms/82xx/mpc8272_ads.c
@@ -165,14 +165,11 @@ static struct of_device_id __initdata of_bus_ids[] = {
 
 static int __init declare_of_platform_devices(void)
 {
-	if (!machine_is(mpc8272_ads))
-		return 0;
-
 	/* Publish the QE devices */
 	of_platform_bus_probe(NULL, of_bus_ids, NULL);
 	return 0;
 }
-device_initcall(declare_of_platform_devices);
+machine_device_initcall(mpc8272_ads, declare_of_platform_devices);
 
 /*
  * Called very early, device-tree isn't unflattened
diff --git a/arch/powerpc/platforms/82xx/pq2fads.c b/arch/powerpc/platforms/82xx/pq2fads.c
index 1be5005..68196e3 100644
--- a/arch/powerpc/platforms/82xx/pq2fads.c
+++ b/arch/powerpc/platforms/82xx/pq2fads.c
@@ -176,14 +176,11 @@ static struct of_device_id __initdata of_bus_ids[] = {
 
 static int __init declare_of_platform_devices(void)
 {
-	if (!machine_is(pq2fads))
-		return 0;
-
 	/* Publish the QE devices */
 	of_platform_bus_probe(NULL, of_bus_ids, NULL);
 	return 0;
 }
-device_initcall(declare_of_platform_devices);
+machine_device_initcall(pq2fads, declare_of_platform_devices);
 
 define_machine(pq2fads)
 {
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
index ffb2e93..1b57028 100644
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
@@ -79,8 +76,7 @@ static int __init mpc832x_spi_init(void)
 			    mpc83xx_spi_activate_cs,
 			    mpc83xx_spi_deactivate_cs);
 }
-
-device_initcall(mpc832x_spi_init);
+machine_device_initcall(mpc832x_rdb, mpc832x_spi_init);
 
 /* ************************************************************************
  *
@@ -123,15 +119,12 @@ static struct of_device_id mpc832x_ids[] = {
 
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
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index bccdc25..a3fa1b0 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -233,13 +233,10 @@ static struct of_device_id __initdata of_bus_ids[] = {
 
 static int __init declare_of_platform_devices(void)
 {
-	if (!machine_is(mpc85xx_ads))
-		return 0;
-
 	of_platform_bus_probe(NULL, of_bus_ids, NULL);
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
index e6c63a5..9f4f3aa 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -144,15 +144,12 @@ static struct of_device_id mpc85xx_ids[] = {
 
 static int __init mpc85xx_publish_devices(void)
 {
-	if (!machine_is(mpc85xx_mds))
-		return 0;
-
 	/* Publish the QE devices */
 	of_platform_bus_probe(NULL,mpc85xx_ids,NULL);
 
 	return 0;
 }
-device_initcall(mpc85xx_publish_devices);
+machine_device_initcall(mpc85xx_mds, mpc85xx_publish_devices);
 
 static void __init mpc85xx_mds_pic_init(void)
 {
diff --git a/arch/powerpc/platforms/embedded6xx/ls_uart.c b/arch/powerpc/platforms/embedded6xx/ls_uart.c
index c99264c..9d891bd 100644
--- a/arch/powerpc/platforms/embedded6xx/ls_uart.c
+++ b/arch/powerpc/platforms/embedded6xx/ls_uart.c
@@ -117,9 +117,6 @@ static int __init ls_uarts_init(void)
 	phys_addr_t phys_addr;
 	int len;
 
-	if (!machine_is(linkstation))
-		return 0;
-
 	avr = of_find_node_by_path("/soc10x/serial@80004500");
 	if (!avr)
 		return -EINVAL;
@@ -142,4 +139,4 @@ static int __init ls_uarts_init(void)
 	return 0;
 }
 
-late_initcall(ls_uarts_init);
+machine_late_initcall(linkstation, ls_uarts_init);
