Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 36C34DE054
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 07:31:35 +1100 (EST)
Date: Thu, 20 Dec 2007 23:33:40 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH v2 4/4] [POWERPC] fsl_spi_init and users: stop using
	device_type = "spi"
Message-ID: <20071220203340.GD19553@localhost.localdomain>
References: <20071220202714.GA18471@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071220202714.GA18471@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

..also rename "fsl_spi" to "fsl,spi" and add cell-index property.

Per http://ozlabs.org/pipermail/linuxppc-dev/2007-December/048388.html

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8313erdb.dts    |    4 ++--
 arch/powerpc/boot/dts/mpc832x_mds.dts    |    8 ++++----
 arch/powerpc/boot/dts/mpc832x_rdb.dts    |    8 ++++----
 arch/powerpc/boot/dts/mpc8349emitx.dts   |    4 ++--
 arch/powerpc/boot/dts/mpc8349emitxgp.dts |    4 ++--
 arch/powerpc/boot/dts/mpc834x_mds.dts    |    4 ++--
 arch/powerpc/boot/dts/mpc836x_mds.dts    |    8 ++++----
 arch/powerpc/boot/dts/mpc8568mds.dts     |    8 ++++----
 arch/powerpc/sysdev/fsl_soc.c            |   23 +++++++++++++++++------
 9 files changed, 41 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
index c5b6665..a0492b6 100644
--- a/arch/powerpc/boot/dts/mpc8313erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
@@ -82,8 +82,8 @@
 		};
 
 		spi@7000 {
-			device_type = "spi";
-			compatible = "fsl_spi";
+			cell-index = <0>;
+			compatible = "fsl,spi";
 			reg = <7000 1000>;
 			interrupts = <10 8>;
 			interrupt-parent = < &ipic >;
diff --git a/arch/powerpc/boot/dts/mpc832x_mds.dts b/arch/powerpc/boot/dts/mpc832x_mds.dts
index 8844d30..36ecd39 100644
--- a/arch/powerpc/boot/dts/mpc832x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
@@ -193,8 +193,8 @@
 		};
 
 		spi@4c0 {
-			device_type = "spi";
-			compatible = "fsl_spi";
+			cell-index = <0>;
+			compatible = "fsl,spi";
 			reg = <4c0 40>;
 			interrupts = <2>;
 			interrupt-parent = < &qeic >;
@@ -202,8 +202,8 @@
 		};
 
 		spi@500 {
-			device_type = "spi";
-			compatible = "fsl_spi";
+			cell-index = <1>;
+			compatible = "fsl,spi";
 			reg = <500 40>;
 			interrupts = <1>;
 			interrupt-parent = < &qeic >;
diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
index a7a2e45..ce63b13 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -183,8 +183,8 @@
 		};
 
 		spi@4c0 {
-			device_type = "spi";
-			compatible = "fsl_spi";
+			cell-index = <0>;
+			compatible = "fsl,spi";
 			reg = <4c0 40>;
 			interrupts = <2>;
 			interrupt-parent = <&qeic>;
@@ -192,8 +192,8 @@
 		};
 
 		spi@500 {
-			device_type = "spi";
-			compatible = "fsl_spi";
+			cell-index = <1>;
+			compatible = "fsl,spi";
 			reg = <500 40>;
 			interrupts = <1>;
 			interrupt-parent = <&qeic>;
diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index e354f26..f8fc5f6 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -82,8 +82,8 @@
 		};
 
 		spi@7000 {
-			device_type = "spi";
-			compatible = "fsl_spi";
+			cell-index = <0>;
+			compatible = "fsl,spi";
 			reg = <7000 1000>;
 			interrupts = <10 8>;
 			interrupt-parent = < &ipic >;
diff --git a/arch/powerpc/boot/dts/mpc8349emitxgp.dts b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
index ebdf0b7..666650c 100644
--- a/arch/powerpc/boot/dts/mpc8349emitxgp.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
@@ -80,8 +80,8 @@
 		};
 
 		spi@7000 {
-			device_type = "spi";
-			compatible = "fsl_spi";
+			cell-index = <0>;
+			compatible = "fsl,spi";
 			reg = <7000 1000>;
 			interrupts = <10 8>;
 			interrupt-parent = < &ipic >;
diff --git a/arch/powerpc/boot/dts/mpc834x_mds.dts b/arch/powerpc/boot/dts/mpc834x_mds.dts
index 0ba13eb..6ed36a1 100644
--- a/arch/powerpc/boot/dts/mpc834x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc834x_mds.dts
@@ -93,8 +93,8 @@
 		};
 
 		spi@7000 {
-			device_type = "spi";
-			compatible = "fsl_spi";
+			cell-index = <0>;
+			compatible = "fsl,spi";
 			reg = <7000 1000>;
 			interrupts = <10 8>;
 			interrupt-parent = < &ipic >;
diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
index 5f0b427..7801e66 100644
--- a/arch/powerpc/boot/dts/mpc836x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
@@ -224,8 +224,8 @@
 		};
 
 		spi@4c0 {
-			device_type = "spi";
-			compatible = "fsl_spi";
+			cell-index = <0>;
+			compatible = "fsl,spi";
 			reg = <4c0 40>;
 			interrupts = <2>;
 			interrupt-parent = < &qeic >;
@@ -233,8 +233,8 @@
 		};
 
 		spi@500 {
-			device_type = "spi";
-			compatible = "fsl_spi";
+			cell-index = <1>;
+			compatible = "fsl,spi";
 			reg = <500 40>;
 			interrupts = <1>;
 			interrupt-parent = < &qeic >;
diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index ea70010..2a0ba5f 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -301,8 +301,8 @@
 		};
 
 		spi@4c0 {
-			device_type = "spi";
-			compatible = "fsl_spi";
+			cell-index = <0>;
+			compatible = "fsl,spi";
 			reg = <4c0 40>;
 			interrupts = <2>;
 			interrupt-parent = <&qeic>;
@@ -310,8 +310,8 @@
 		};
 
 		spi@500 {
-			device_type = "spi";
-			compatible = "fsl_spi";
+			cell-index = <1>;
+			compatible = "fsl,spi";
 			reg = <500 40>;
 			interrupts = <1>;
 			interrupt-parent = <&qeic>;
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index f04d5cc..44737ff 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -1227,7 +1227,8 @@ int __init fsl_spi_init(struct spi_board_info *board_infos,
 			void (*deactivate_cs)(u8 cs, u8 polarity))
 {
 	struct device_node *np;
-	unsigned int i;
+	struct device_node *last_np = NULL;
+	unsigned int i = 0;
 	u32 sysclk;
 
 	/* SPI controller is either clocked from QE or SoC clock */
@@ -1249,10 +1250,8 @@ int __init fsl_spi_init(struct spi_board_info *board_infos,
 		of_node_put(np);
 	}
 
-	for (np = NULL, i = 1;
-	     (np = of_find_compatible_node(np, "spi", "fsl_spi")) != NULL;
-	     i++) {
-		int ret = 0;
+	while (1) {
+		int ret;
 		unsigned int j;
 		const void *prop;
 		struct resource res[2];
@@ -1262,6 +1261,14 @@ int __init fsl_spi_init(struct spi_board_info *board_infos,
 			.deactivate_cs = deactivate_cs,
 		};
 
+		np = of_find_compatible_node(last_np, NULL, "fsl,spi");
+		if (!np) {
+			np = of_find_compatible_node(last_np, "spi", "fsl_spi");
+			if (!np)
+				break;
+		}
+		last_np = np;
+
 		memset(res, 0, sizeof(res));
 
 		pdata.sysclk = sysclk;
@@ -1271,6 +1278,10 @@ int __init fsl_spi_init(struct spi_board_info *board_infos,
 			goto err;
 		pdata.bus_num = *(u32 *)prop;
 
+		prop = of_get_property(np, "cell-index", NULL);
+		if (prop)
+			i = *(u32 *)prop;
+
 		prop = of_get_property(np, "mode", NULL);
 		if (prop && !strcmp(prop, "cpu-qe"))
 			pdata.qe_mode = 1;
@@ -1313,8 +1324,8 @@ unreg:
 		platform_device_del(pdev);
 err:
 next:
+		i++;
 		of_node_put(np);
-		continue;
 	}
 
 	return spi_register_board_info(board_infos, num_board_infos);
-- 
1.5.2.2
