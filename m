Return-Path: <haokexin@gmail.com>
Received: from mail-yw0-x244.google.com (mail-yw0-x244.google.com
 [IPv6:2607:f8b0:4002:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sJDNQ4Hz5zDrcZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 12:07:34 +1000 (AEST)
Received: by mail-yw0-x244.google.com with SMTP id u134so4425724ywg.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 19:07:34 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	devicetree@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Rob Herring <robh+dt@kernel.org>,
 Scott Wood <oss@buserror.net>
Subject: [PATCH 5/5] powerpc/83xx: enable the default of probe
Date: Tue, 23 Aug 2016 10:06:59 +0800
Message-Id: <1471918019-19472-6-git-send-email-haokexin@gmail.com>
In-Reply-To: <1471918019-19472-1-git-send-email-haokexin@gmail.com>
References: <1471918019-19472-1-git-send-email-haokexin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use the default of probe function of_platform_default_populate_init()
to kill the arch specific duplicated codes.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/platforms/83xx/asp834x.c     |  2 --
 arch/powerpc/platforms/83xx/km83xx.c      |  2 --
 arch/powerpc/platforms/83xx/misc.c        | 25 ++++++++-----------------
 arch/powerpc/platforms/83xx/mpc830x_rdb.c |  2 --
 arch/powerpc/platforms/83xx/mpc831x_rdb.c |  2 --
 arch/powerpc/platforms/83xx/mpc832x_mds.c |  2 --
 arch/powerpc/platforms/83xx/mpc832x_rdb.c |  2 --
 arch/powerpc/platforms/83xx/mpc834x_itx.c | 12 ------------
 arch/powerpc/platforms/83xx/mpc834x_mds.c |  2 --
 arch/powerpc/platforms/83xx/mpc836x_mds.c |  2 --
 arch/powerpc/platforms/83xx/mpc836x_rdk.c |  2 --
 arch/powerpc/platforms/83xx/mpc837x_mds.c |  2 --
 arch/powerpc/platforms/83xx/mpc837x_rdb.c |  2 --
 arch/powerpc/platforms/83xx/mpc83xx.h     |  1 -
 arch/powerpc/platforms/83xx/sbc834x.c     |  2 --
 15 files changed, 8 insertions(+), 54 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/asp834x.c b/arch/powerpc/platforms/83xx/asp834x.c
index 575afd6eb36a..2219a1f8c535 100644
--- a/arch/powerpc/platforms/83xx/asp834x.c
+++ b/arch/powerpc/platforms/83xx/asp834x.c
@@ -34,8 +34,6 @@ static void __init asp834x_setup_arch(void)
 	mpc834x_usb_cfg();
 }
 
-machine_device_initcall(asp834x, mpc83xx_declare_of_platform_devices);
-
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
  */
diff --git a/arch/powerpc/platforms/83xx/km83xx.c b/arch/powerpc/platforms/83xx/km83xx.c
index d8642a4afc74..e2276f12eafe 100644
--- a/arch/powerpc/platforms/83xx/km83xx.c
+++ b/arch/powerpc/platforms/83xx/km83xx.c
@@ -154,8 +154,6 @@ static void __init mpc83xx_km_setup_arch(void)
 #endif	/* CONFIG_QUICC_ENGINE */
 }
 
-machine_device_initcall(mpc83xx_km, mpc83xx_declare_of_platform_devices);
-
 /* list of the supported boards */
 static char *board[] __initdata = {
 	"Keymile,KMETER1",
diff --git a/arch/powerpc/platforms/83xx/misc.c b/arch/powerpc/platforms/83xx/misc.c
index d75c9816a5c9..4a88edd51d1a 100644
--- a/arch/powerpc/platforms/83xx/misc.c
+++ b/arch/powerpc/platforms/83xx/misc.c
@@ -114,23 +114,6 @@ void __init mpc83xx_ipic_and_qe_init_IRQ(void)
 }
 #endif /* CONFIG_QUICC_ENGINE */
 
-static const struct of_device_id of_bus_ids[] __initconst = {
-	{ .type = "soc", },
-	{ .compatible = "soc", },
-	{ .compatible = "simple-bus" },
-	{ .compatible = "gianfar" },
-	{ .compatible = "gpio-leds", },
-	{ .type = "qe", },
-	{ .compatible = "fsl,qe", },
-	{},
-};
-
-int __init mpc83xx_declare_of_platform_devices(void)
-{
-	of_platform_bus_probe(NULL, of_bus_ids, NULL);
-	return 0;
-}
-
 #ifdef CONFIG_PCI
 void __init mpc83xx_setup_pci(void)
 {
@@ -149,4 +132,12 @@ void __init mpc83xx_setup_arch(void)
 		ppc_md.progress("mpc83xx_setup_arch()", 0);
 
 	mpc83xx_setup_pci();
+	arch_enable_default_of_probe();
 }
+
+BUS_OF_DECLARE_TYPE(type_soc, "soc");
+BUS_OF_DECLARE_TYPE(type_qe, "qe");
+BUS_OF_DECLARE_COMPAT(simple_bus, "simple-bus");
+BUS_OF_DECLARE_COMPAT(gianfar, "gianfar");
+BUS_OF_DECLARE_COMPAT(gpio_leds, "gpio-leds");
+BUS_OF_DECLARE_COMPAT(qe, "fsl,qe");
diff --git a/arch/powerpc/platforms/83xx/mpc830x_rdb.c b/arch/powerpc/platforms/83xx/mpc830x_rdb.c
index 272c41c387b9..0d073102cfbb 100644
--- a/arch/powerpc/platforms/83xx/mpc830x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc830x_rdb.c
@@ -46,8 +46,6 @@ static int __init mpc830x_rdb_probe(void)
 	return of_device_compatible_match(of_root, board);
 }
 
-machine_device_initcall(mpc830x_rdb, mpc83xx_declare_of_platform_devices);
-
 define_machine(mpc830x_rdb) {
 	.name			= "MPC830x RDB",
 	.probe			= mpc830x_rdb_probe,
diff --git a/arch/powerpc/platforms/83xx/mpc831x_rdb.c b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
index fd80fd570e67..16926fb95592 100644
--- a/arch/powerpc/platforms/83xx/mpc831x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
@@ -46,8 +46,6 @@ static int __init mpc831x_rdb_probe(void)
 	return of_device_compatible_match(of_root, board);
 }
 
-machine_device_initcall(mpc831x_rdb, mpc83xx_declare_of_platform_devices);
-
 define_machine(mpc831x_rdb) {
 	.name			= "MPC831x RDB",
 	.probe			= mpc831x_rdb_probe,
diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
index bb7b25acf26f..01c0602347a7 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -92,8 +92,6 @@ static void __init mpc832x_sys_setup_arch(void)
 #endif				/* CONFIG_QUICC_ENGINE */
 }
 
-machine_device_initcall(mpc832x_mds, mpc83xx_declare_of_platform_devices);
-
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
  */
diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index 09d1bbf25b5d..4626d909e7fa 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -210,8 +210,6 @@ static void __init mpc832x_rdb_setup_arch(void)
 #endif				/* CONFIG_QUICC_ENGINE */
 }
 
-machine_device_initcall(mpc832x_rdb, mpc83xx_declare_of_platform_devices);
-
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
  */
diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/powerpc/platforms/83xx/mpc834x_itx.c
index 73a5267df497..60717eb6b029 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
@@ -38,18 +38,6 @@
 
 #include "mpc83xx.h"
 
-static const struct of_device_id mpc834x_itx_ids[] __initconst = {
-	{ .compatible = "fsl,pq2pro-localbus", },
-	{},
-};
-
-static int __init mpc834x_itx_declare_of_platform_devices(void)
-{
-	mpc83xx_declare_of_platform_devices();
-	return of_platform_bus_probe(NULL, mpc834x_itx_ids, NULL);
-}
-machine_device_initcall(mpc834x_itx, mpc834x_itx_declare_of_platform_devices);
-
 /* ************************************************************************
  *
  * Setup the architecture
diff --git a/arch/powerpc/platforms/83xx/mpc834x_mds.c b/arch/powerpc/platforms/83xx/mpc834x_mds.c
index 009cfc18a4ee..64ba2f8eab9f 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_mds.c
@@ -81,8 +81,6 @@ static void __init mpc834x_mds_setup_arch(void)
 	mpc834xemds_usb_cfg();
 }
 
-machine_device_initcall(mpc834x_mds, mpc83xx_declare_of_platform_devices);
-
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
  */
diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platforms/83xx/mpc836x_mds.c
index 4fc3051c2b2e..0cc26696ca06 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -135,8 +135,6 @@ static void __init mpc836x_mds_setup_arch(void)
 #endif				/* CONFIG_QUICC_ENGINE */
 }
 
-machine_device_initcall(mpc836x_mds, mpc83xx_declare_of_platform_devices);
-
 #ifdef CONFIG_QE_USB
 static int __init mpc836x_usb_cfg(void)
 {
diff --git a/arch/powerpc/platforms/83xx/mpc836x_rdk.c b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
index 93f024fd9b45..ac36ea02c0a2 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_rdk.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
@@ -27,8 +27,6 @@
 
 #include "mpc83xx.h"
 
-machine_device_initcall(mpc836x_rdk, mpc83xx_declare_of_platform_devices);
-
 static void __init mpc836x_rdk_setup_arch(void)
 {
 	mpc83xx_setup_arch();
diff --git a/arch/powerpc/platforms/83xx/mpc837x_mds.c b/arch/powerpc/platforms/83xx/mpc837x_mds.c
index 3b34cc1f626c..2e4f29190844 100644
--- a/arch/powerpc/platforms/83xx/mpc837x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc837x_mds.c
@@ -83,8 +83,6 @@ static void __init mpc837x_mds_setup_arch(void)
 	mpc837xmds_usb_cfg();
 }
 
-machine_device_initcall(mpc837x_mds, mpc83xx_declare_of_platform_devices);
-
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
  */
diff --git a/arch/powerpc/platforms/83xx/mpc837x_rdb.c b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
index 0c55fa6af2d5..9d0c9c6af736 100644
--- a/arch/powerpc/platforms/83xx/mpc837x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
@@ -55,8 +55,6 @@ static void __init mpc837x_rdb_setup_arch(void)
 	mpc837x_rdb_sd_cfg();
 }
 
-machine_device_initcall(mpc837x_rdb, mpc83xx_declare_of_platform_devices);
-
 static const char * const board[] __initconst = {
 	"fsl,mpc8377rdb",
 	"fsl,mpc8378rdb",
diff --git a/arch/powerpc/platforms/83xx/mpc83xx.h b/arch/powerpc/platforms/83xx/mpc83xx.h
index 636eb9d0401a..77f9658aa22e 100644
--- a/arch/powerpc/platforms/83xx/mpc83xx.h
+++ b/arch/powerpc/platforms/83xx/mpc83xx.h
@@ -85,7 +85,6 @@ extern void mpc83xx_setup_pci(void);
 #define mpc83xx_setup_pci()	do {} while (0)
 #endif
 
-extern int mpc83xx_declare_of_platform_devices(void);
 extern void mpc83xx_setup_arch(void);
 
 #endif				/* __MPC83XX_H__ */
diff --git a/arch/powerpc/platforms/83xx/sbc834x.c b/arch/powerpc/platforms/83xx/sbc834x.c
index cb4bdabfdf1c..e750a0ed644a 100644
--- a/arch/powerpc/platforms/83xx/sbc834x.c
+++ b/arch/powerpc/platforms/83xx/sbc834x.c
@@ -50,8 +50,6 @@ static void __init sbc834x_setup_arch(void)
 	mpc83xx_setup_arch();
 }
 
-machine_device_initcall(sbc834x, mpc83xx_declare_of_platform_devices);
-
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
  */
-- 
2.5.5
