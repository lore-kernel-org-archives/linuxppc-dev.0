Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 7532BDDE1E
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 09:51:26 +1100 (EST)
Received: from pd3mr2so.prod.shaw.ca
	(pd3mr2so-qfe3.prod.shaw.ca [10.0.141.178]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JSC00MLJCTNY530@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 30 Nov 2007 15:51:23 -0700 (MST)
Received: from pn2ml5so.prod.shaw.ca ([10.0.121.149])
	by pd3mr2so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JSC00FESCTFLP90@pd3mr2so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Fri, 30 Nov 2007 15:51:24 -0700 (MST)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JSC00KL4CTE1X71@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 30 Nov 2007 15:51:14 -0700 (MST)
Date: Fri, 30 Nov 2007 15:51:16 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [RFC/PATCH] Add a device_initcall to machdep_calls
To: linuxppc-dev@ozlabs.org, vitb@kernel.crashing.org,
	galak@kernel.crashing.org, olof@lixom.net, jwboyer@linux.vnet.ibm.com,
	benh@kernel.crashing.org
Message-id: <20071130225043.12499.86364.stgit@trillian.secretlab.ca>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Add a device_initcall hook to machdep_calls so that platform code doesn't
need to register device_initcalls that must first check what platform
it is running on.

This should (slightly) speed boot time on kernels that support a lot of
boards and make device_initcall hooks slightly simpler to implement
because the platform doesn't need to be tested when called.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

Please comment; I think this is a good change, but I'd like some feedback.

Cheers,
g.

 arch/powerpc/kernel/setup-common.c           |   11 +++++++++++
 arch/powerpc/platforms/40x/kilauea.c         |    5 +----
 arch/powerpc/platforms/40x/virtex.c          |    5 +----
 arch/powerpc/platforms/40x/walnut.c          |    5 +----
 arch/powerpc/platforms/44x/bamboo.c          |    5 +----
 arch/powerpc/platforms/44x/ebony.c           |    5 +----
 arch/powerpc/platforms/44x/sequoia.c         |    5 +----
 arch/powerpc/platforms/82xx/mpc8272_ads.c    |    6 ++----
 arch/powerpc/platforms/82xx/pq2fads.c        |    5 +----
 arch/powerpc/platforms/83xx/mpc832x_mds.c    |    5 +----
 arch/powerpc/platforms/83xx/mpc832x_rdb.c    |   14 +++-----------
 arch/powerpc/platforms/83xx/mpc834x_itx.c    |    5 +----
 arch/powerpc/platforms/83xx/mpc836x_mds.c    |    5 +----
 arch/powerpc/platforms/85xx/mpc85xx_ads.c    |    5 +----
 arch/powerpc/platforms/85xx/mpc85xx_cds.c    |    9 +++------
 arch/powerpc/platforms/85xx/mpc85xx_mds.c    |    5 +----
 arch/powerpc/platforms/8xx/ep88xc.c          |    5 ++---
 arch/powerpc/platforms/8xx/mpc885ads_setup.c |    5 ++---
 arch/powerpc/platforms/cell/setup.c          |    5 +----
 arch/powerpc/platforms/celleb/setup.c        |    5 +----
 arch/powerpc/platforms/pasemi/setup.c        |   11 ++---------
 arch/powerpc/platforms/powermac/setup.c      |    9 +--------
 include/asm-powerpc/machdep.h                |    1 +
 23 files changed, 41 insertions(+), 100 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 2de00f8..6fef005 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -610,3 +610,14 @@ static int powerpc_debugfs_init(void)
 }
 arch_initcall(powerpc_debugfs_init);
 #endif
+
+/* device init hook.  Allow platforms to provide a device init function */
+static int __init ppc_init_device(void)
+{
+	/* call platform device init */
+	if (ppc_md.init_device)
+		return ppc_md.init_device();
+	return 0;
+}
+device_initcall(ppc_init_device);
+
diff --git a/arch/powerpc/platforms/40x/kilauea.c b/arch/powerpc/platforms/40x/kilauea.c
index 1bffdbd..f2bb028 100644
--- a/arch/powerpc/platforms/40x/kilauea.c
+++ b/arch/powerpc/platforms/40x/kilauea.c
@@ -29,14 +29,10 @@ static struct of_device_id kilauea_of_bus[] = {
 
 static int __init kilauea_device_probe(void)
 {
-	if (!machine_is(kilauea))
-		return 0;
-
 	of_platform_bus_probe(NULL, kilauea_of_bus, NULL);
 
 	return 0;
 }
-device_initcall(kilauea_device_probe);
 
 static int __init kilauea_probe(void)
 {
@@ -52,6 +48,7 @@ define_machine(kilauea) {
 	.name 				= "Kilauea",
 	.probe 				= kilauea_probe,
 	.progress 			= udbg_progress,
+	.init_device			= kilauea_device_probe,
 	.init_IRQ 			= uic_init_tree,
 	.get_irq 			= uic_get_irq,
 	.calibrate_decr			= generic_calibrate_decr,
diff --git a/arch/powerpc/platforms/40x/virtex.c b/arch/powerpc/platforms/40x/virtex.c
index 14bbc32..76403f8 100644
--- a/arch/powerpc/platforms/40x/virtex.c
+++ b/arch/powerpc/platforms/40x/virtex.c
@@ -17,14 +17,10 @@
 
 static int __init virtex_device_probe(void)
 {
-	if (!machine_is(virtex))
-		return 0;
-
 	of_platform_bus_probe(NULL, NULL, NULL);
 
 	return 0;
 }
-device_initcall(virtex_device_probe);
 
 static int __init virtex_probe(void)
 {
@@ -39,6 +35,7 @@ static int __init virtex_probe(void)
 define_machine(virtex) {
 	.name			= "Xilinx Virtex",
 	.probe			= virtex_probe,
+	.init_device		= virtex_device_probe,
 	.init_IRQ		= xilinx_intc_init_tree,
 	.get_irq		= xilinx_intc_get_irq,
 	.calibrate_decr		= generic_calibrate_decr,
diff --git a/arch/powerpc/platforms/40x/walnut.c b/arch/powerpc/platforms/40x/walnut.c
index ff6db24..3786aeb 100644
--- a/arch/powerpc/platforms/40x/walnut.c
+++ b/arch/powerpc/platforms/40x/walnut.c
@@ -34,15 +34,11 @@ static struct of_device_id walnut_of_bus[] = {
 
 static int __init walnut_device_probe(void)
 {
-	if (!machine_is(walnut))
-		return 0;
-
 	/* FIXME: do bus probe here */
 	of_platform_bus_probe(NULL, walnut_of_bus, NULL);
 
 	return 0;
 }
-device_initcall(walnut_device_probe);
 
 static int __init walnut_probe(void)
 {
@@ -58,6 +54,7 @@ define_machine(walnut) {
 	.name			= "Walnut",
 	.probe			= walnut_probe,
 	.progress		= udbg_progress,
+	.init_device		= walnut_device_probe,
 	.init_IRQ		= uic_init_tree,
 	.get_irq		= uic_get_irq,
 	.calibrate_decr	= generic_calibrate_decr,
diff --git a/arch/powerpc/platforms/44x/bamboo.c b/arch/powerpc/platforms/44x/bamboo.c
index be23f11..1aa3c3f 100644
--- a/arch/powerpc/platforms/44x/bamboo.c
+++ b/arch/powerpc/platforms/44x/bamboo.c
@@ -32,14 +32,10 @@ static struct of_device_id bamboo_of_bus[] = {
 
 static int __init bamboo_device_probe(void)
 {
-	if (!machine_is(bamboo))
-		return 0;
-
 	of_platform_bus_probe(NULL, bamboo_of_bus, NULL);
 
 	return 0;
 }
-device_initcall(bamboo_device_probe);
 
 static int __init bamboo_probe(void)
 {
@@ -55,6 +51,7 @@ define_machine(bamboo) {
 	.name 				= "Bamboo",
 	.probe 				= bamboo_probe,
 	.progress 			= udbg_progress,
+	.init_device			= bamboo_device_probe,
 	.init_IRQ 			= uic_init_tree,
 	.get_irq 			= uic_get_irq,
 	.restart			= ppc44x_reset_system,
diff --git a/arch/powerpc/platforms/44x/ebony.c b/arch/powerpc/platforms/44x/ebony.c
index 6cd3476..d32065a 100644
--- a/arch/powerpc/platforms/44x/ebony.c
+++ b/arch/powerpc/platforms/44x/ebony.c
@@ -36,14 +36,10 @@ static struct of_device_id ebony_of_bus[] = {
 
 static int __init ebony_device_probe(void)
 {
-	if (!machine_is(ebony))
-		return 0;
-
 	of_platform_bus_probe(NULL, ebony_of_bus, NULL);
 
 	return 0;
 }
-device_initcall(ebony_device_probe);
 
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
@@ -62,6 +58,7 @@ define_machine(ebony) {
 	.name			= "Ebony",
 	.probe			= ebony_probe,
 	.progress		= udbg_progress,
+	.init_device		= ebony_device_probe,
 	.init_IRQ		= uic_init_tree,
 	.get_irq		= uic_get_irq,
 	.restart		= ppc44x_reset_system,
diff --git a/arch/powerpc/platforms/44x/sequoia.c b/arch/powerpc/platforms/44x/sequoia.c
index 21a9dd1..9166a3d 100644
--- a/arch/powerpc/platforms/44x/sequoia.c
+++ b/arch/powerpc/platforms/44x/sequoia.c
@@ -32,14 +32,10 @@ static struct of_device_id sequoia_of_bus[] = {
 
 static int __init sequoia_device_probe(void)
 {
-	if (!machine_is(sequoia))
-		return 0;
-
 	of_platform_bus_probe(NULL, sequoia_of_bus, NULL);
 
 	return 0;
 }
-device_initcall(sequoia_device_probe);
 
 static int __init sequoia_probe(void)
 {
@@ -55,6 +51,7 @@ define_machine(sequoia) {
 	.name 				= "Sequoia",
 	.probe 				= sequoia_probe,
 	.progress 			= udbg_progress,
+	.init_device			= sequioa_device_probe,
 	.init_IRQ 			= uic_init_tree,
 	.get_irq 			= uic_get_irq,
 	.restart			= ppc44x_reset_system,
diff --git a/arch/powerpc/platforms/82xx/mpc8272_ads.c b/arch/powerpc/platforms/82xx/mpc8272_ads.c
index fd83440..044a215 100644
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
+
 	return 0;
 }
-device_initcall(declare_of_platform_devices);
 
 /*
  * Called very early, device-tree isn't unflattened
@@ -188,6 +185,7 @@ define_machine(mpc8272_ads)
 	.name = "Freescale MPC8272 ADS",
 	.probe = mpc8272_ads_probe,
 	.setup_arch = mpc8272_ads_setup_arch,
+	.init_device = declare_of_platform_devices,
 	.init_IRQ = mpc8272_ads_pic_init,
 	.get_irq = cpm2_get_irq,
 	.calibrate_decr = generic_calibrate_decr,
diff --git a/arch/powerpc/platforms/82xx/pq2fads.c b/arch/powerpc/platforms/82xx/pq2fads.c
index 4f457a9..9535a37 100644
--- a/arch/powerpc/platforms/82xx/pq2fads.c
+++ b/arch/powerpc/platforms/82xx/pq2fads.c
@@ -176,20 +176,17 @@ static struct of_device_id __initdata of_bus_ids[] = {
 
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
 
 define_machine(pq2fads)
 {
 	.name = "Freescale PQ2FADS",
 	.probe = pq2fads_probe,
 	.setup_arch = pq2fads_setup_arch,
+	.init_device = declare_of_platform_devices,
 	.init_IRQ = pq2fads_pic_init,
 	.get_irq = cpm2_get_irq,
 	.calibrate_decr = generic_calibrate_decr,
diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
index a19d9b6..f45046a 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -110,15 +110,11 @@ static struct of_device_id mpc832x_ids[] = {
 
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
 
 static void __init mpc832x_sys_init_IRQ(void)
 {
@@ -150,6 +146,7 @@ define_machine(mpc832x_mds) {
 	.name 		= "MPC832x MDS",
 	.probe 		= mpc832x_sys_probe,
 	.setup_arch 	= mpc832x_sys_setup_arch,
+	.init_device	= mpc832x_declare_of_platform_devices,
 	.init_IRQ 	= mpc832x_sys_init_IRQ,
 	.get_irq 	= ipic_get_irq,
 	.restart 	= mpc83xx_restart,
diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index 8e7492e..0f30372 100644
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
@@ -80,8 +77,6 @@ static int __init mpc832x_spi_init(void)
 			    mpc83xx_spi_deactivate_cs);
 }
 
-device_initcall(mpc832x_spi_init);
-
 /* ************************************************************************
  *
  * Setup the architecture
@@ -121,17 +116,13 @@ static struct of_device_id mpc832x_ids[] = {
 	{},
 };
 
-static int __init mpc832x_declare_of_platform_devices(void)
+static int __init mpc832x_rdb_init_device(void)
 {
-	if (!machine_is(mpc832x_rdb))
-		return 0;
-
 	/* Publish the QE devices */
 	of_platform_bus_probe(NULL, mpc832x_ids, NULL);
 
-	return 0;
+	return mpc832x_spi_init();
 }
-device_initcall(mpc832x_declare_of_platform_devices);
 
 void __init mpc832x_rdb_init_IRQ(void)
 {
@@ -163,6 +154,7 @@ define_machine(mpc832x_rdb) {
 	.name		= "MPC832x RDB",
 	.probe		= mpc832x_rdb_probe,
 	.setup_arch	= mpc832x_rdb_setup_arch,
+	.init_device	= mpc832x_rdb_init_device,
 	.init_IRQ	= mpc832x_rdb_init_IRQ,
 	.get_irq	= ipic_get_irq,
 	.restart	= mpc83xx_restart,
diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/powerpc/platforms/83xx/mpc834x_itx.c
index 909f9a9..4312240 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
@@ -64,14 +64,10 @@ static void __init mpc834x_itx_setup_arch(void)
 
 static int __init mpc834x_itx_declare_of_platform_devices(void)
 {
-	if (!machine_is(mpc834x_itx))
-		return 0;
-
 	of_platform_bus_probe(NULL, NULL, NULL);
 
 	return 0;
 }
-device_initcall(mpc834x_itx_declare_of_platform_devices);
 
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
@@ -87,6 +83,7 @@ define_machine(mpc834x_itx) {
 	.name			= "MPC834x ITX",
 	.probe			= mpc834x_itx_probe,
 	.setup_arch		= mpc834x_itx_setup_arch,
+	.init_device		= mpc834x_itx_declare_of_platform_devices,
 	.init_IRQ		= mpc83xx_init_IRQ,
 	.get_irq		= ipic_get_irq,
 	.restart		= mpc83xx_restart,
diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platforms/83xx/mpc836x_mds.c
index 67a61ac..2fd7d6a 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -141,15 +141,11 @@ static struct of_device_id mpc836x_ids[] = {
 
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
 
 static void __init mpc836x_mds_init_IRQ(void)
 {
@@ -181,6 +177,7 @@ define_machine(mpc836x_mds) {
 	.name		= "MPC836x MDS",
 	.probe		= mpc836x_mds_probe,
 	.setup_arch	= mpc836x_mds_setup_arch,
+	.init_device	= mpc836x_declare_of_platform_devices,
 	.init_IRQ	= mpc836x_mds_init_IRQ,
 	.get_irq	= ipic_get_irq,
 	.restart	= mpc83xx_restart,
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index bccdc25..9fdfed5 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -233,13 +233,9 @@ static struct of_device_id __initdata of_bus_ids[] = {
 
 static int __init declare_of_platform_devices(void)
 {
-	if (!machine_is(mpc85xx_ads))
-		return 0;
-
 	of_platform_bus_probe(NULL, of_bus_ids, NULL);
 	return 0;
 }
-device_initcall(declare_of_platform_devices);
 
 /*
  * Called very early, device-tree isn't unflattened
@@ -255,6 +251,7 @@ define_machine(mpc85xx_ads) {
 	.name			= "MPC85xx ADS",
 	.probe			= mpc85xx_ads_probe,
 	.setup_arch		= mpc85xx_ads_setup_arch,
+	.init_device		= declare_of_platform_device,
 	.init_IRQ		= mpc85xx_ads_pic_init,
 	.show_cpuinfo		= mpc85xx_ads_show_cpuinfo,
 	.get_irq		= mpic_get_irq,
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index 4d063ee..35a2ec4 100644
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
@@ -262,9 +259,6 @@ static int mpc85xx_cds_8259_attach(void)
 
 	return 0;
 }
-
-device_initcall(mpc85xx_cds_8259_attach);
-
 #endif /* CONFIG_PPC_I8259 */
 
 /*
@@ -343,6 +337,9 @@ define_machine(mpc85xx_cds) {
 	.name		= "MPC85xx CDS",
 	.probe		= mpc85xx_cds_probe,
 	.setup_arch	= mpc85xx_cds_setup_arch,
+#if defined(CONFIG_PPC_I8259) && defined(CONFIG_PCI)
+	.init_device	= mpc85xx_cds_8259_attach,
+#endif
 	.init_IRQ	= mpc85xx_cds_pic_init,
 	.show_cpuinfo	= mpc85xx_cds_show_cpuinfo,
 	.get_irq	= mpic_get_irq,
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 61b3eed..b759387 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -144,15 +144,11 @@ static struct of_device_id mpc85xx_ids[] = {
 
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
 
 static void __init mpc85xx_mds_pic_init(void)
 {
@@ -199,6 +195,7 @@ define_machine(mpc85xx_mds) {
 	.name		= "MPC85xx MDS",
 	.probe		= mpc85xx_mds_probe,
 	.setup_arch	= mpc85xx_mds_setup_arch,
+	.init_device	= mpc85xx_publish_devices,
 	.init_IRQ	= mpc85xx_mds_pic_init,
 	.get_irq	= mpic_get_irq,
 	.restart	= fsl_rstcr_restart,
diff --git a/arch/powerpc/platforms/8xx/ep88xc.c b/arch/powerpc/platforms/8xx/ep88xc.c
index c518b6c..0d49e1c 100644
--- a/arch/powerpc/platforms/8xx/ep88xc.c
+++ b/arch/powerpc/platforms/8xx/ep88xc.c
@@ -155,17 +155,16 @@ static struct of_device_id __initdata of_bus_ids[] = {
 static int __init declare_of_platform_devices(void)
 {
 	/* Publish the QE devices */
-	if (machine_is(ep88xc))
-		of_platform_bus_probe(NULL, of_bus_ids, NULL);
+	of_platform_bus_probe(NULL, of_bus_ids, NULL);
 
 	return 0;
 }
-device_initcall(declare_of_platform_devices);
 
 define_machine(ep88xc) {
 	.name = "Embedded Planet EP88xC",
 	.probe = ep88xc_probe,
 	.setup_arch = ep88xc_setup_arch,
+	.init_device = declare_of_platform_devices,
 	.init_IRQ = m8xx_pic_init,
 	.get_irq	= mpc8xx_get_irq,
 	.restart = mpc8xx_restart,
diff --git a/arch/powerpc/platforms/8xx/mpc885ads_setup.c b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
index 2cf1b6a..9f88fe6 100644
--- a/arch/powerpc/platforms/8xx/mpc885ads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
@@ -264,17 +264,16 @@ static struct of_device_id __initdata of_bus_ids[] = {
 static int __init declare_of_platform_devices(void)
 {
 	/* Publish the QE devices */
-	if (machine_is(mpc885_ads))
-		of_platform_bus_probe(NULL, of_bus_ids, NULL);
+	of_platform_bus_probe(NULL, of_bus_ids, NULL);
 
 	return 0;
 }
-device_initcall(declare_of_platform_devices);
 
 define_machine(mpc885_ads) {
 	.name			= "Freescale MPC885 ADS",
 	.probe			= mpc885ads_probe,
 	.setup_arch		= mpc885ads_setup_arch,
+	.init_device		= declare_of_platform_devices,
 	.init_IRQ		= m8xx_pic_init,
 	.get_irq		= mpc8xx_get_irq,
 	.restart		= mpc8xx_restart,
diff --git a/arch/powerpc/platforms/cell/setup.c b/arch/powerpc/platforms/cell/setup.c
index 98e7ef8..b0579c8 100644
--- a/arch/powerpc/platforms/cell/setup.c
+++ b/arch/powerpc/platforms/cell/setup.c
@@ -85,9 +85,6 @@ static int __init cell_publish_devices(void)
 {
 	int node;
 
-	if (!machine_is(cell))
-		return 0;
-
 	/* Publish OF platform devices for southbridge IOs */
 	of_platform_bus_probe(NULL, NULL, NULL);
 
@@ -101,7 +98,6 @@ static int __init cell_publish_devices(void)
 	}
 	return 0;
 }
-device_initcall(cell_publish_devices);
 
 static void cell_mpic_cascade(unsigned int irq, struct irq_desc *desc)
 {
@@ -208,6 +204,7 @@ define_machine(cell) {
 	.set_rtc_time		= rtas_set_rtc_time,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= cell_progress,
+	.init_device		= cell_publish_devices,
 	.init_IRQ       	= cell_init_irq,
 	.pci_setup_phb		= rtas_setup_phb,
 #ifdef CONFIG_KEXEC
diff --git a/arch/powerpc/platforms/celleb/setup.c b/arch/powerpc/platforms/celleb/setup.c
index ddfb35a..9d7a993 100644
--- a/arch/powerpc/platforms/celleb/setup.c
+++ b/arch/powerpc/platforms/celleb/setup.c
@@ -127,9 +127,6 @@ static struct of_device_id celleb_bus_ids[] __initdata = {
 
 static int __init celleb_publish_devices(void)
 {
-	if (!machine_is(celleb))
-		return 0;
-
 	/* Publish OF platform devices for southbridge IOs */
 	of_platform_bus_probe(NULL, celleb_bus_ids, NULL);
 
@@ -137,7 +134,6 @@ static int __init celleb_publish_devices(void)
 
 	return 0;
 }
-device_initcall(celleb_publish_devices);
 
 define_machine(celleb) {
 	.name			= "Cell Reference Set",
@@ -156,6 +152,7 @@ define_machine(celleb) {
 	.nvram_read		= beat_nvram_read,
 	.nvram_write		= beat_nvram_write,
 	.set_dabr		= beat_set_xdabr,
+	.init_device		= celleb_publish_devices,
 	.init_IRQ		= beatic_init_IRQ,
 	.get_irq		= beatic_get_irq,
 	.pci_probe_mode 	= celleb_pci_probe_mode,
diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index 3d62060..5bd2325 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -126,9 +126,6 @@ static int __init pas_setup_mce_regs(void)
 	struct pci_dev *dev;
 	int reg;
 
-	if (!machine_is(pasemi))
-		return -ENODEV;
-
 	/* Remap various SoC status registers for use by the MCE handler */
 
 	reg = 0;
@@ -172,7 +169,6 @@ static int __init pas_setup_mce_regs(void)
 
 	return 0;
 }
-device_initcall(pas_setup_mce_regs);
 
 static __init void pas_init_IRQ(void)
 {
@@ -369,9 +365,7 @@ static struct of_device_id pasemi_bus_ids[] = {
 
 static int __init pasemi_publish_devices(void)
 {
-	if (!machine_is(pasemi))
-		return 0;
-
+	pas_setup_mce_regs();
 	pasemi_pcmcia_init();
 
 	/* Publish OF platform devices for SDC and other non-PCI devices */
@@ -379,8 +373,6 @@ static int __init pasemi_publish_devices(void)
 
 	return 0;
 }
-device_initcall(pasemi_publish_devices);
-
 
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
@@ -404,6 +396,7 @@ define_machine(pasemi) {
 	.probe			= pas_probe,
 	.setup_arch		= pas_setup_arch,
 	.init_early		= pas_init_early,
+	.init_device		= pasemi_publish_devices,
 	.init_IRQ		= pas_init_IRQ,
 	.get_irq		= mpic_get_irq,
 	.restart		= pas_restart,
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 02c5330..a0c5a6c 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -532,12 +532,6 @@ static int __init pmac_declare_of_platform_devices(void)
 {
 	struct device_node *np;
 
-	if (machine_is(chrp))
-		return -1;
-
-	if (!machine_is(powermac))
-		return 0;
-
 	np = of_find_node_by_name(NULL, "valkyrie");
 	if (np)
 		of_platform_device_create(np, "valkyrie", NULL);
@@ -553,8 +547,6 @@ static int __init pmac_declare_of_platform_devices(void)
 	return 0;
 }
 
-device_initcall(pmac_declare_of_platform_devices);
-
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
  */
@@ -672,6 +664,7 @@ define_machine(powermac) {
 	.setup_arch		= pmac_setup_arch,
 	.init_early		= pmac_init_early,
 	.show_cpuinfo		= pmac_show_cpuinfo,
+	.init_device		= pmac_declare_of_platform_devices,
 	.init_IRQ		= pmac_pic_init,
 	.get_irq		= NULL,	/* changed later */
 	.pci_irq_fixup		= pmac_pci_irq_fixup,
diff --git a/include/asm-powerpc/machdep.h b/include/asm-powerpc/machdep.h
index 6968f43..39532c0 100644
--- a/include/asm-powerpc/machdep.h
+++ b/include/asm-powerpc/machdep.h
@@ -101,6 +101,7 @@ struct machdep_calls {
 	int		(*probe)(void);
 	void		(*setup_arch)(void); /* Optional, may be NULL */
 	void		(*init_early)(void);
+	int		(*init_device)(void); /* Optional, may be NULL */
 	/* Optional, may be NULL. */
 	void		(*show_cpuinfo)(struct seq_file *m);
 	void		(*show_percpuinfo)(struct seq_file *m, int i);
