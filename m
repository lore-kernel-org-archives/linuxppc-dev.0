Return-Path: <dbaryshkov@gmail.com>
Received: from mail-fx0-f42.google.com (mail-fx0-f42.google.com
	[209.85.161.42]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5B350B71A4
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 23 Jul 2011 05:56:39 +1000 (EST)
Received: by fxe23 with SMTP id 23so5208390fxe.15
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Jul 2011 12:56:35 -0700 (PDT)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Linux PPC Development <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH V2 2/3] powerpc/83xx: consolidate of_platform_bus_probe calls
Date: Fri, 22 Jul 2011 23:55:43 +0400
Message-Id: <1311364544-9413-3-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1311364544-9413-1-git-send-email-dbaryshkov@gmail.com>
References: <1311364544-9413-1-git-send-email-dbaryshkov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

83xx board files have a lot of duplication in
*_declare_of_platform_devices() functions. Merge that into a single
function common to most of the boards.

The only leftover is mpc834x_itx.c board file which explicitly asks for
fsl,pq2pro-localbus, as corresponding bindings don't provide
"simple-bus" compatibility in localbus node.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/powerpc/platforms/83xx/asp834x.c     |   15 +--------------
 arch/powerpc/platforms/83xx/km83xx.c      |   18 +-----------------
 arch/powerpc/platforms/83xx/misc.c        |   17 +++++++++++++++++
 arch/powerpc/platforms/83xx/mpc830x_rdb.c |   13 +------------
 arch/powerpc/platforms/83xx/mpc831x_rdb.c |   14 +-------------
 arch/powerpc/platforms/83xx/mpc832x_mds.c |   18 +-----------------
 arch/powerpc/platforms/83xx/mpc832x_rdb.c |   18 +-----------------
 arch/powerpc/platforms/83xx/mpc834x_itx.c |    3 +--
 arch/powerpc/platforms/83xx/mpc834x_mds.c |   15 +--------------
 arch/powerpc/platforms/83xx/mpc836x_mds.c |   18 +-----------------
 arch/powerpc/platforms/83xx/mpc836x_rdk.c |   11 +----------
 arch/powerpc/platforms/83xx/mpc837x_mds.c |   17 +----------------
 arch/powerpc/platforms/83xx/mpc837x_rdb.c |   18 +-----------------
 arch/powerpc/platforms/83xx/mpc83xx.h     |    1 +
 arch/powerpc/platforms/83xx/sbc834x.c     |   15 +--------------
 15 files changed, 31 insertions(+), 180 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/asp834x.c b/arch/powerpc/platforms/83xx/asp834x.c
index 90b6c06..464ea8e 100644
--- a/arch/powerpc/platforms/83xx/asp834x.c
+++ b/arch/powerpc/platforms/83xx/asp834x.c
@@ -36,20 +36,7 @@ static void __init asp834x_setup_arch(void)
 	mpc834x_usb_cfg();
 }
 
-static struct __initdata of_device_id asp8347_ids[] = {
-	{ .type = "soc", },
-	{ .compatible = "soc", },
-	{ .compatible = "simple-bus", },
-	{ .compatible = "gianfar", },
-	{},
-};
-
-static int __init asp8347_declare_of_platform_devices(void)
-{
-	of_platform_bus_probe(NULL, asp8347_ids, NULL);
-	return 0;
-}
-machine_device_initcall(asp834x, asp8347_declare_of_platform_devices);
+machine_device_initcall(asp834x, mpc83xx_declare_of_platform_devices);
 
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
diff --git a/arch/powerpc/platforms/83xx/km83xx.c b/arch/powerpc/platforms/83xx/km83xx.c
index 28d272a..f82001e 100644
--- a/arch/powerpc/platforms/83xx/km83xx.c
+++ b/arch/powerpc/platforms/83xx/km83xx.c
@@ -122,23 +122,7 @@ static void __init mpc83xx_km_setup_arch(void)
 #endif				/* CONFIG_QUICC_ENGINE */
 }
 
-static struct of_device_id kmpbec83xx_ids[] = {
-	{ .type = "soc", },
-	{ .compatible = "soc", },
-	{ .compatible = "simple-bus", },
-	{ .type = "qe", },
-	{ .compatible = "fsl,qe", },
-	{},
-};
-
-static int __init kmeter_declare_of_platform_devices(void)
-{
-	/* Publish the QE devices */
-	of_platform_bus_probe(NULL, kmpbec83xx_ids, NULL);
-
-	return 0;
-}
-machine_device_initcall(mpc83xx_km, kmeter_declare_of_platform_devices);
+machine_device_initcall(mpc83xx_km, mpc83xx_declare_of_platform_devices);
 
 /* list of the supported boards */
 static char *board[] __initdata = {
diff --git a/arch/powerpc/platforms/83xx/misc.c b/arch/powerpc/platforms/83xx/misc.c
index 4ac60cc..ee4de77 100644
--- a/arch/powerpc/platforms/83xx/misc.c
+++ b/arch/powerpc/platforms/83xx/misc.c
@@ -111,3 +111,20 @@ void __init mpc83xx_ipic_and_qe_init_IRQ(void)
 	mpc83xx_qe_init_IRQ();
 }
 #endif /* CONFIG_QUICC_ENGINE */
+
+static struct of_device_id __initdata of_bus_ids[] = {
+	{ .type = "soc", },
+	{ .compatible = "soc", },
+	{ .compatible = "simple-bus" },
+	{ .compatible = "gianfar" },
+	{ .compatible = "gpio-leds", },
+	{ .type = "qe", },
+	{ .compatible = "fsl,qe", },
+	{},
+};
+
+int __init mpc83xx_declare_of_platform_devices(void)
+{
+	of_platform_bus_probe(NULL, of_bus_ids, NULL);
+	return 0;
+}
diff --git a/arch/powerpc/platforms/83xx/mpc830x_rdb.c b/arch/powerpc/platforms/83xx/mpc830x_rdb.c
index b453c15..ef595f1 100644
--- a/arch/powerpc/platforms/83xx/mpc830x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc830x_rdb.c
@@ -56,18 +56,7 @@ static int __init mpc830x_rdb_probe(void)
 	return of_flat_dt_match(of_get_flat_dt_root(), board);
 }
 
-static struct of_device_id __initdata of_bus_ids[] = {
-	{ .compatible = "simple-bus" },
-	{ .compatible = "gianfar" },
-	{},
-};
-
-static int __init declare_of_platform_devices(void)
-{
-	of_platform_bus_probe(NULL, of_bus_ids, NULL);
-	return 0;
-}
-machine_device_initcall(mpc830x_rdb, declare_of_platform_devices);
+machine_device_initcall(mpc830x_rdb, mpc83xx_declare_of_platform_devices);
 
 define_machine(mpc830x_rdb) {
 	.name			= "MPC830x RDB",
diff --git a/arch/powerpc/platforms/83xx/mpc831x_rdb.c b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
index 386bde8..ce87406 100644
--- a/arch/powerpc/platforms/83xx/mpc831x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
@@ -58,19 +58,7 @@ static int __init mpc831x_rdb_probe(void)
 	return of_flat_dt_match(of_get_flat_dt_root(), board);
 }
 
-static struct of_device_id __initdata of_bus_ids[] = {
-	{ .compatible = "simple-bus" },
-	{ .compatible = "gianfar" },
-	{ .compatible = "gpio-leds", },
-	{},
-};
-
-static int __init declare_of_platform_devices(void)
-{
-	of_platform_bus_probe(NULL, of_bus_ids, NULL);
-	return 0;
-}
-machine_device_initcall(mpc831x_rdb, declare_of_platform_devices);
+machine_device_initcall(mpc831x_rdb, mpc83xx_declare_of_platform_devices);
 
 define_machine(mpc831x_rdb) {
 	.name			= "MPC831x RDB",
diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
index ab60786..668b58e 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -101,23 +101,7 @@ static void __init mpc832x_sys_setup_arch(void)
 #endif				/* CONFIG_QUICC_ENGINE */
 }
 
-static struct of_device_id mpc832x_ids[] = {
-	{ .type = "soc", },
-	{ .compatible = "soc", },
-	{ .compatible = "simple-bus", },
-	{ .type = "qe", },
-	{ .compatible = "fsl,qe", },
-	{},
-};
-
-static int __init mpc832x_declare_of_platform_devices(void)
-{
-	/* Publish the QE devices */
-	of_platform_bus_probe(NULL, mpc832x_ids, NULL);
-
-	return 0;
-}
-machine_device_initcall(mpc832x_mds, mpc832x_declare_of_platform_devices);
+machine_device_initcall(mpc832x_mds, mpc83xx_declare_of_platform_devices);
 
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index ebfecec..e4c7c64 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -218,23 +218,7 @@ static void __init mpc832x_rdb_setup_arch(void)
 #endif				/* CONFIG_QUICC_ENGINE */
 }
 
-static struct of_device_id mpc832x_ids[] = {
-	{ .type = "soc", },
-	{ .compatible = "soc", },
-	{ .compatible = "simple-bus", },
-	{ .type = "qe", },
-	{ .compatible = "fsl,qe", },
-	{},
-};
-
-static int __init mpc832x_declare_of_platform_devices(void)
-{
-	/* Publish the QE devices */
-	of_platform_bus_probe(NULL, mpc832x_ids, NULL);
-
-	return 0;
-}
-machine_device_initcall(mpc832x_rdb, mpc832x_declare_of_platform_devices);
+machine_device_initcall(mpc832x_rdb, mpc83xx_declare_of_platform_devices);
 
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/powerpc/platforms/83xx/mpc834x_itx.c
index 2e2dc73..c853f66 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
@@ -41,13 +41,12 @@
 
 static struct of_device_id __initdata mpc834x_itx_ids[] = {
 	{ .compatible = "fsl,pq2pro-localbus", },
-	{ .compatible = "simple-bus", },
-	{ .compatible = "gianfar", },
 	{},
 };
 
 static int __init mpc834x_itx_declare_of_platform_devices(void)
 {
+	mpc83xx_declare_of_platform_devices();
 	return of_platform_bus_probe(NULL, mpc834x_itx_ids, NULL);
 }
 machine_device_initcall(mpc834x_itx, mpc834x_itx_declare_of_platform_devices);
diff --git a/arch/powerpc/platforms/83xx/mpc834x_mds.c b/arch/powerpc/platforms/83xx/mpc834x_mds.c
index 94702e6..381e94e 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_mds.c
@@ -92,20 +92,7 @@ static void __init mpc834x_mds_setup_arch(void)
 	mpc834xemds_usb_cfg();
 }
 
-static struct of_device_id mpc834x_ids[] = {
-	{ .type = "soc", },
-	{ .compatible = "soc", },
-	{ .compatible = "simple-bus", },
-	{ .compatible = "gianfar", },
-	{},
-};
-
-static int __init mpc834x_declare_of_platform_devices(void)
-{
-	of_platform_bus_probe(NULL, mpc834x_ids, NULL);
-	return 0;
-}
-machine_device_initcall(mpc834x_mds, mpc834x_declare_of_platform_devices);
+machine_device_initcall(mpc834x_mds, mpc83xx_declare_of_platform_devices);
 
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platforms/83xx/mpc836x_mds.c
index c3733bd..2d7437c 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -144,23 +144,7 @@ static void __init mpc836x_mds_setup_arch(void)
 #endif				/* CONFIG_QUICC_ENGINE */
 }
 
-static struct of_device_id mpc836x_ids[] = {
-	{ .type = "soc", },
-	{ .compatible = "soc", },
-	{ .compatible = "simple-bus", },
-	{ .type = "qe", },
-	{ .compatible = "fsl,qe", },
-	{},
-};
-
-static int __init mpc836x_declare_of_platform_devices(void)
-{
-	/* Publish the QE devices */
-	of_platform_bus_probe(NULL, mpc836x_ids, NULL);
-
-	return 0;
-}
-machine_device_initcall(mpc836x_mds, mpc836x_declare_of_platform_devices);
+machine_device_initcall(mpc836x_mds, mpc83xx_declare_of_platform_devices);
 
 #ifdef CONFIG_QE_USB
 static int __init mpc836x_usb_cfg(void)
diff --git a/arch/powerpc/platforms/83xx/mpc836x_rdk.c b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
index cd8f078..fd6f730 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_rdk.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
@@ -27,16 +27,7 @@
 
 #include "mpc83xx.h"
 
-static struct of_device_id __initdata mpc836x_rdk_ids[] = {
-	{ .compatible = "simple-bus", },
-	{},
-};
-
-static int __init mpc836x_rdk_declare_of_platform_devices(void)
-{
-	return of_platform_bus_probe(NULL, mpc836x_rdk_ids, NULL);
-}
-machine_device_initcall(mpc836x_rdk, mpc836x_rdk_declare_of_platform_devices);
+machine_device_initcall(mpc836x_rdk, mpc83xx_declare_of_platform_devices);
 
 static void __init mpc836x_rdk_setup_arch(void)
 {
diff --git a/arch/powerpc/platforms/83xx/mpc837x_mds.c b/arch/powerpc/platforms/83xx/mpc837x_mds.c
index 3be7f3a..7463183 100644
--- a/arch/powerpc/platforms/83xx/mpc837x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc837x_mds.c
@@ -95,22 +95,7 @@ static void __init mpc837x_mds_setup_arch(void)
 	mpc837xmds_usb_cfg();
 }
 
-static struct of_device_id mpc837x_ids[] = {
-	{ .type = "soc", },
-	{ .compatible = "soc", },
-	{ .compatible = "simple-bus", },
-	{ .compatible = "gianfar", },
-	{},
-};
-
-static int __init mpc837x_declare_of_platform_devices(void)
-{
-	/* Publish platform_device */
-	of_platform_bus_probe(NULL, mpc837x_ids, NULL);
-
-	return 0;
-}
-machine_device_initcall(mpc837x_mds, mpc837x_declare_of_platform_devices);
+machine_device_initcall(mpc837x_mds, mpc83xx_declare_of_platform_devices);
 
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
diff --git a/arch/powerpc/platforms/83xx/mpc837x_rdb.c b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
index eebfd81..a4a5336 100644
--- a/arch/powerpc/platforms/83xx/mpc837x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
@@ -67,23 +67,7 @@ static void __init mpc837x_rdb_setup_arch(void)
 	mpc837x_rdb_sd_cfg();
 }
 
-static struct of_device_id mpc837x_ids[] = {
-	{ .type = "soc", },
-	{ .compatible = "soc", },
-	{ .compatible = "simple-bus", },
-	{ .compatible = "gianfar", },
-	{ .compatible = "gpio-leds", },
-	{},
-};
-
-static int __init mpc837x_declare_of_platform_devices(void)
-{
-	/* Publish platform_device */
-	of_platform_bus_probe(NULL, mpc837x_ids, NULL);
-
-	return 0;
-}
-machine_device_initcall(mpc837x_rdb, mpc837x_declare_of_platform_devices);
+machine_device_initcall(mpc837x_rdb, mpc83xx_declare_of_platform_devices);
 
 static const char *board[] __initdata = {
 	"fsl,mpc8377rdb",
diff --git a/arch/powerpc/platforms/83xx/mpc83xx.h b/arch/powerpc/platforms/83xx/mpc83xx.h
index f07751a..a54f6ba 100644
--- a/arch/powerpc/platforms/83xx/mpc83xx.h
+++ b/arch/powerpc/platforms/83xx/mpc83xx.h
@@ -79,5 +79,6 @@ static inline void __init mpc83xx_qe_init_IRQ(void) {}
 #define mpc83xx_ipic_and_qe_init_IRQ mpc83xx_ipic_init_IRQ
 #endif /* CONFIG_QUICC_ENGINE */
 
+extern int mpc83xx_declare_of_platform_devices(void);
 
 #endif				/* __MPC83XX_H__ */
diff --git a/arch/powerpc/platforms/83xx/sbc834x.c b/arch/powerpc/platforms/83xx/sbc834x.c
index 205a28d..3d98bd9 100644
--- a/arch/powerpc/platforms/83xx/sbc834x.c
+++ b/arch/powerpc/platforms/83xx/sbc834x.c
@@ -62,20 +62,7 @@ static void __init sbc834x_setup_arch(void)
 
 }
 
-static struct __initdata of_device_id sbc834x_ids[] = {
-	{ .type = "soc", },
-	{ .compatible = "soc", },
-	{ .compatible = "simple-bus", },
-	{ .compatible = "gianfar", },
-	{},
-};
-
-static int __init sbc834x_declare_of_platform_devices(void)
-{
-	of_platform_bus_probe(NULL, sbc834x_ids, NULL);
-	return 0;
-}
-machine_device_initcall(sbc834x, sbc834x_declare_of_platform_devices);
+machine_device_initcall(sbc834x, mpc83xx_declare_of_platform_devices);
 
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
-- 
1.7.2.5
