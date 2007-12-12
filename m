Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5F95DDDEDB
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 16:19:57 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id lBC5JqWY026058
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 23:19:53 -0600
Date: Tue, 11 Dec 2007 23:18:15 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] FSL: I2C device tree cleanups
Message-ID: <Pine.LNX.4.64.0712112317510.17159@blarg.am.freescale.net>
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

* Removed device_type = "i2c"
* Added missing second I2C controller on MPC8548 CDS, MPC8544 DS
* Added #address-cells, #size-cells, and cell-index where missing

---
 arch/powerpc/boot/dts/kuroboxHD.dts      |    2 +-
 arch/powerpc/boot/dts/kuroboxHG.dts      |    2 +-
 arch/powerpc/boot/dts/lite5200.dts       |    6 ++++--
 arch/powerpc/boot/dts/lite5200b.dts      |    6 ++++--
 arch/powerpc/boot/dts/mpc8313erdb.dts    |    8 ++++++--
 arch/powerpc/boot/dts/mpc832x_mds.dts    |    2 +-
 arch/powerpc/boot/dts/mpc832x_rdb.dts    |    4 +++-
 arch/powerpc/boot/dts/mpc8349emitx.dts   |    8 ++++++--
 arch/powerpc/boot/dts/mpc8349emitxgp.dts |    8 ++++++--
 arch/powerpc/boot/dts/mpc834x_mds.dts    |    4 ++--
 arch/powerpc/boot/dts/mpc836x_mds.dts    |    4 ++--
 arch/powerpc/boot/dts/mpc8540ads.dts     |    4 +++-
 arch/powerpc/boot/dts/mpc8541cds.dts     |    4 +++-
 arch/powerpc/boot/dts/mpc8544ds.dts      |   15 ++++++++++++++-
 arch/powerpc/boot/dts/mpc8548cds.dts     |   15 ++++++++++++++-
 arch/powerpc/boot/dts/mpc8555cds.dts     |    4 +++-
 arch/powerpc/boot/dts/mpc8568mds.dts     |    4 ++--
 arch/powerpc/boot/dts/mpc8572ds.dts      |    8 ++++++--
 arch/powerpc/boot/dts/mpc8610_hpcd.dts   |    8 ++++----
 arch/powerpc/boot/dts/mpc8641_hpcn.dts   |    8 ++++++--
 arch/powerpc/sysdev/fsl_soc.c            |    8 +++-----
 21 files changed, 94 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/boot/dts/kuroboxHD.dts b/arch/powerpc/boot/dts/kuroboxHD.dts
index ec71ab8..1c14dcd 100644
--- a/arch/powerpc/boot/dts/kuroboxHD.dts
+++ b/arch/powerpc/boot/dts/kuroboxHD.dts
@@ -60,7 +60,7 @@ XXXX add flash parts, rtc, ??
 		i2c@80003000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			device_type = "i2c";
+			cell-index = <0>;
 			compatible = "fsl-i2c";
 			reg = <80003000 1000>;
 			interrupts = <5 2>;
diff --git a/arch/powerpc/boot/dts/kuroboxHG.dts b/arch/powerpc/boot/dts/kuroboxHG.dts
index 32ecd23..1b973fa 100644
--- a/arch/powerpc/boot/dts/kuroboxHG.dts
+++ b/arch/powerpc/boot/dts/kuroboxHG.dts
@@ -60,7 +60,7 @@ XXXX add flash parts, rtc, ??
 		i2c@80003000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			device_type = "i2c";
+			cell-index = <0>;
 			compatible = "fsl-i2c";
 			reg = <80003000 1000>;
 			interrupts = <5 2>;
diff --git a/arch/powerpc/boot/dts/lite5200.dts b/arch/powerpc/boot/dts/lite5200.dts
index 6731763..23eeeb1 100644
--- a/arch/powerpc/boot/dts/lite5200.dts
+++ b/arch/powerpc/boot/dts/lite5200.dts
@@ -284,7 +284,8 @@
 		};

 		i2c@3d00 {
-			device_type = "i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
 			compatible = "mpc5200-i2c","fsl-i2c";
 			cell-index = <0>;
 			reg = <3d00 40>;
@@ -294,7 +295,8 @@
 		};

 		i2c@3d40 {
-			device_type = "i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
 			compatible = "mpc5200-i2c","fsl-i2c";
 			cell-index = <1>;
 			reg = <3d40 40>;
diff --git a/arch/powerpc/boot/dts/lite5200b.dts b/arch/powerpc/boot/dts/lite5200b.dts
index b540388..f94e073 100644
--- a/arch/powerpc/boot/dts/lite5200b.dts
+++ b/arch/powerpc/boot/dts/lite5200b.dts
@@ -300,7 +300,8 @@
 		};

 		i2c@3d00 {
-			device_type = "i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
 			compatible = "mpc5200b-i2c","mpc5200-i2c","fsl-i2c";
 			cell-index = <0>;
 			reg = <3d00 40>;
@@ -310,7 +311,8 @@
 		};

 		i2c@3d40 {
-			device_type = "i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
 			compatible = "mpc5200b-i2c","mpc5200-i2c","fsl-i2c";
 			cell-index = <1>;
 			reg = <3d40 40>;
diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
index 9e7eba9..d417f1b 100644
--- a/arch/powerpc/boot/dts/mpc8313erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
@@ -52,7 +52,9 @@
 		};

 		i2c@3000 {
-			device_type = "i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
 			compatible = "fsl-i2c";
 			reg = <3000 100>;
 			interrupts = <e 8>;
@@ -61,7 +63,9 @@
 		};

 		i2c@3100 {
-			device_type = "i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <1>;
 			compatible = "fsl-i2c";
 			reg = <3100 100>;
 			interrupts = <f 8>;
diff --git a/arch/powerpc/boot/dts/mpc832x_mds.dts b/arch/powerpc/boot/dts/mpc832x_mds.dts
index c64f303..f866e81 100644
--- a/arch/powerpc/boot/dts/mpc832x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
@@ -59,7 +59,7 @@
 		i2c@3000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			device_type = "i2c";
+			cell-index = <0>;
 			compatible = "fsl-i2c";
 			reg = <3000 100>;
 			interrupts = <e 8>;
diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
index 388c8a7..91849dd 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -52,7 +52,9 @@
 		};

 		i2c@3000 {
-			device_type = "i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
 			compatible = "fsl-i2c";
 			reg = <3000 100>;
 			interrupts = <e 8>;
diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index 5072f6d..c29e4f4 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -51,7 +51,9 @@
 		};

 		i2c@3000 {
-			device_type = "i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
 			compatible = "fsl-i2c";
 			reg = <3000 100>;
 			interrupts = <e 8>;
@@ -60,7 +62,9 @@
 		};

 		i2c@3100 {
-			device_type = "i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <1>;
 			compatible = "fsl-i2c";
 			reg = <3100 100>;
 			interrupts = <f 8>;
diff --git a/arch/powerpc/boot/dts/mpc8349emitxgp.dts b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
index 074f7a2..6e51d17 100644
--- a/arch/powerpc/boot/dts/mpc8349emitxgp.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
@@ -51,7 +51,9 @@
 		};

 		i2c@3000 {
-			device_type = "i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
 			compatible = "fsl-i2c";
 			reg = <3000 100>;
 			interrupts = <e 8>;
@@ -60,7 +62,9 @@
 		};

 		i2c@3100 {
-			device_type = "i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <1>;
 			compatible = "fsl-i2c";
 			reg = <3100 100>;
 			interrupts = <f 8>;
diff --git a/arch/powerpc/boot/dts/mpc834x_mds.dts b/arch/powerpc/boot/dts/mpc834x_mds.dts
index 49363f8..73311e8 100644
--- a/arch/powerpc/boot/dts/mpc834x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc834x_mds.dts
@@ -59,7 +59,7 @@
 		i2c@3000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			device_type = "i2c";
+			cell-index = <0>;
 			compatible = "fsl-i2c";
 			reg = <3000 100>;
 			interrupts = <e 8>;
@@ -75,7 +75,7 @@
 		i2c@3100 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			device_type = "i2c";
+			cell-index = <1>;
 			compatible = "fsl-i2c";
 			reg = <3100 100>;
 			interrupts = <f 8>;
diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
index 0b2d2b5..8b7d778 100644
--- a/arch/powerpc/boot/dts/mpc836x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
@@ -64,7 +64,7 @@
 		i2c@3000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			device_type = "i2c";
+			cell-index = <0>;
 			compatible = "fsl-i2c";
 			reg = <3000 100>;
 			interrupts = <e 8>;
@@ -80,7 +80,7 @@
 		i2c@3100 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			device_type = "i2c";
+			cell-index = <1>;
 			compatible = "fsl-i2c";
 			reg = <3100 100>;
 			interrupts = <f 8>;
diff --git a/arch/powerpc/boot/dts/mpc8540ads.dts b/arch/powerpc/boot/dts/mpc8540ads.dts
index 6442a71..435a2b6 100644
--- a/arch/powerpc/boot/dts/mpc8540ads.dts
+++ b/arch/powerpc/boot/dts/mpc8540ads.dts
@@ -63,7 +63,9 @@
 		};

 		i2c@3000 {
-			device_type = "i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
 			compatible = "fsl-i2c";
 			reg = <3000 100>;
 			interrupts = <2b 2>;
diff --git a/arch/powerpc/boot/dts/mpc8541cds.dts b/arch/powerpc/boot/dts/mpc8541cds.dts
index f3f4d79..101c0b6 100644
--- a/arch/powerpc/boot/dts/mpc8541cds.dts
+++ b/arch/powerpc/boot/dts/mpc8541cds.dts
@@ -63,7 +63,9 @@
 		};

 		i2c@3000 {
-			device_type = "i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
 			compatible = "fsl-i2c";
 			reg = <3000 100>;
 			interrupts = <2b 2>;
diff --git a/arch/powerpc/boot/dts/mpc8544ds.dts b/arch/powerpc/boot/dts/mpc8544ds.dts
index 6c608de..a81ecca 100644
--- a/arch/powerpc/boot/dts/mpc8544ds.dts
+++ b/arch/powerpc/boot/dts/mpc8544ds.dts
@@ -64,7 +64,9 @@
 		};

 		i2c@3000 {
-			device_type = "i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
 			compatible = "fsl-i2c";
 			reg = <3000 100>;
 			interrupts = <2b 2>;
@@ -72,6 +74,17 @@
 			dfsrr;
 		};

+		i2c@3100 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <1>;
+			compatible = "fsl-i2c";
+			reg = <3100 100>;
+			interrupts = <2b 2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+		};
+
 		mdio@24520 {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/boot/dts/mpc8548cds.dts
index 69ca502..70358dc 100644
--- a/arch/powerpc/boot/dts/mpc8548cds.dts
+++ b/arch/powerpc/boot/dts/mpc8548cds.dts
@@ -63,7 +63,9 @@
 		};

 		i2c@3000 {
-			device_type = "i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
 			compatible = "fsl-i2c";
 			reg = <3000 100>;
 			interrupts = <2b 2>;
@@ -71,6 +73,17 @@
 			dfsrr;
 		};

+		i2c@3100 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <1>;
+			compatible = "fsl-i2c";
+			reg = <3100 100>;
+			interrupts = <2b 2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+		};
+
 		mdio@24520 {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/powerpc/boot/dts/mpc8555cds.dts b/arch/powerpc/boot/dts/mpc8555cds.dts
index 57029cc..1e8bf46 100644
--- a/arch/powerpc/boot/dts/mpc8555cds.dts
+++ b/arch/powerpc/boot/dts/mpc8555cds.dts
@@ -63,7 +63,9 @@
 		};

 		i2c@3000 {
-			device_type = "i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
 			compatible = "fsl-i2c";
 			reg = <3000 100>;
 			interrupts = <2b 2>;
diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index 5439437..d73e5f1 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -74,7 +74,7 @@
 		i2c@3000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			device_type = "i2c";
+			cell-index = <0>;
 			compatible = "fsl-i2c";
 			reg = <3000 100>;
 			interrupts = <2b 2>;
@@ -90,7 +90,7 @@
 		i2c@3100 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			device_type = "i2c";
+			cell-index = <1>;
 			compatible = "fsl-i2c";
 			reg = <3100 100>;
 			interrupts = <2b 2>;
diff --git a/arch/powerpc/boot/dts/mpc8572ds.dts b/arch/powerpc/boot/dts/mpc8572ds.dts
index 0eb44fb..91d15e8 100644
--- a/arch/powerpc/boot/dts/mpc8572ds.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds.dts
@@ -69,7 +69,9 @@
 		};

 		i2c@3000 {
-			device_type = "i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
 			compatible = "fsl-i2c";
 			reg = <3000 100>;
 			interrupts = <2b 2>;
@@ -78,7 +80,9 @@
 		};

 		i2c@3100 {
-			device_type = "i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <1>;
 			compatible = "fsl-i2c";
 			reg = <3100 100>;
 			interrupts = <2b 2>;
diff --git a/arch/powerpc/boot/dts/mpc8610_hpcd.dts b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
index 966edf1..e9c444e 100644
--- a/arch/powerpc/boot/dts/mpc8610_hpcd.dts
+++ b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
@@ -47,10 +47,10 @@
 		bus-frequency = <0>;

 		i2c@3000 {
-			device_type = "i2c";
-			compatible = "fsl-i2c";
 			#address-cells = <1>;
 			#size-cells = <0>;
+			cell-index = <0>;
+			compatible = "fsl-i2c";
 			reg = <3000 100>;
 			interrupts = <2b 2>;
 			interrupt-parent = <&mpic>;
@@ -58,10 +58,10 @@
 		};

 		i2c@3100 {
-			device_type = "i2c";
-			compatible = "fsl-i2c";
 			#address-cells = <1>;
 			#size-cells = <0>;
+			cell-index = <1>;
+			compatible = "fsl-i2c";
 			reg = <3100 100>;
 			interrupts = <2b 2>;
 			interrupt-parent = <&mpic>;
diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index b039f21..dc0efaf 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -69,7 +69,9 @@
 		bus-frequency = <0>;

 		i2c@3000 {
-			device_type = "i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
 			compatible = "fsl-i2c";
 			reg = <3000 100>;
 			interrupts = <2b 2>;
@@ -78,7 +80,9 @@
 		};

 		i2c@3100 {
-			device_type = "i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <1>;
 			compatible = "fsl-i2c";
 			reg = <3100 100>;
 			interrupts = <2b 2>;
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 3ace747..81af4bd 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -390,13 +390,11 @@ static void __init of_register_i2c_devices(struct device_node *adap_node,
 static int __init fsl_i2c_of_init(void)
 {
 	struct device_node *np;
-	unsigned int i;
+	unsigned int i = 0;
 	struct platform_device *i2c_dev;
 	int ret;

-	for (np = NULL, i = 0;
-	     (np = of_find_compatible_node(np, "i2c", "fsl-i2c")) != NULL;
-	     i++) {
+	for_each_compatible_node(np, NULL, "fsl-i2c") {
 		struct resource r[2];
 		struct fsl_i2c_platform_data i2c_data;
 		const unsigned char *flags = NULL;
@@ -432,7 +430,7 @@ static int __init fsl_i2c_of_init(void)
 		if (ret)
 			goto unreg;

-		of_register_i2c_devices(np, i);
+		of_register_i2c_devices(np, i++);
 	}

 	return 0;
-- 
1.5.3.4
