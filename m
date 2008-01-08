Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id B1A10DE43A
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 01:30:17 +1100 (EST)
Date: Tue, 8 Jan 2008 17:30:07 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 4/4] [POWERPC] fsl_spi_init and users: stop using device_type
	= "spi"
Message-ID: <20080108143007.GD11047@localhost.localdomain>
References: <20080108142634.GA5989@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080108142634.GA5989@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Also:
- rename "fsl_spi" to "fsl,spi";
- add and use cell-index property, if found;
- split probing code out of fsl_spi_init, thus we can call
  it for legacy device_type probing and new "compatible" probing.

Per http://ozlabs.org/pipermail/linuxppc-dev/2007-December/048388.html

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 Documentation/powerpc/booting-without-of.txt |    8 +-
 arch/powerpc/boot/dts/mpc8313erdb.dts        |    4 +-
 arch/powerpc/boot/dts/mpc832x_mds.dts        |    8 +-
 arch/powerpc/boot/dts/mpc832x_rdb.dts        |    8 +-
 arch/powerpc/boot/dts/mpc8349emitx.dts       |    4 +-
 arch/powerpc/boot/dts/mpc8349emitxgp.dts     |    4 +-
 arch/powerpc/boot/dts/mpc834x_mds.dts        |    4 +-
 arch/powerpc/boot/dts/mpc836x_mds.dts        |    8 +-
 arch/powerpc/boot/dts/mpc8568mds.dts         |    8 +-
 arch/powerpc/sysdev/fsl_soc.c                |   94 ++++++++++++++++----------
 10 files changed, 86 insertions(+), 64 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index ed0b92c..2b30611 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1563,8 +1563,8 @@ platforms are moved over to use the flattened-device-tree model.
    ii) SPI (Serial Peripheral Interface)
 
    Required properties:
-   - device_type : should be "spi".
-   - compatible : should be "fsl_spi".
+   - cell-index : SPI controller index.
+   - compatible : should be "fsl,spi".
    - mode : the SPI operation mode, it can be "cpu" or "cpu-qe".
    - reg : Offset and length of the register set for the device
    - interrupts : <a b> where a is the interrupt number and b is a
@@ -1577,8 +1577,8 @@ platforms are moved over to use the flattened-device-tree model.
 
    Example:
 	spi@4c0 {
-		device_type = "spi";
-		compatible = "fsl_spi";
+		cell-index = <0>;
+		compatible = "fsl,spi";
 		reg = <4c0 40>;
 		interrupts = <82 0>;
 		interrupt-parent = <700>;
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
index cf41194..cc99fb0 100644
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
index 09301c1..c0e5e93 100644
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
index 3eb8f72..be7dfed 100644
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
index 2bc147f..84474cb 100644
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
index 7b13876..cec1ab7 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -1226,42 +1226,17 @@ arch_initcall(cpm_smc_uart_of_init);
 #endif /* CONFIG_8xx */
 #endif /* CONFIG_PPC_CPM_NEW_BINDING */
 
-int __init fsl_spi_init(struct spi_board_info *board_infos,
-			unsigned int num_board_infos,
-			void (*activate_cs)(u8 cs, u8 polarity),
-			void (*deactivate_cs)(u8 cs, u8 polarity))
+static int __init of_fsl_spi_probe(char *type, char *compatible, u32 sysclk,
+				   struct spi_board_info *board_infos,
+				   unsigned int num_board_infos,
+				   void (*activate_cs)(u8 cs, u8 polarity),
+				   void (*deactivate_cs)(u8 cs, u8 polarity))
 {
 	struct device_node *np;
-	unsigned int i;
-	u32 sysclk;
-
-	/* SPI controller is either clocked from QE or SoC clock */
-	sysclk = get_brgfreq();
-	if (sysclk == -1) {
-		const u32 *freq;
-		int size;
-
-		np = of_find_node_by_type(NULL, "soc");
-		if (!np)
-			return -ENODEV;
-
-		freq = of_get_property(np, "clock-frequency", &size);
-		if (!freq || size != sizeof(*freq) || *freq == 0) {
-			freq = of_get_property(np, "bus-frequency", &size);
-			if (!freq || size != sizeof(*freq) || *freq == 0) {
-				of_node_put(np);
-				return -ENODEV;
-			}
-		}
-
-		sysclk = *freq;
-		of_node_put(np);
-	}
+	unsigned int i = 0;
 
-	for (np = NULL, i = 1;
-	     (np = of_find_compatible_node(np, "spi", "fsl_spi")) != NULL;
-	     i++) {
-		int ret = 0;
+	for_each_compatible_node(np, type, compatible) {
+		int ret;
 		unsigned int j;
 		const void *prop;
 		struct resource res[2];
@@ -1280,6 +1255,10 @@ int __init fsl_spi_init(struct spi_board_info *board_infos,
 			goto err;
 		pdata.bus_num = *(u32 *)prop;
 
+		prop = of_get_property(np, "cell-index", NULL);
+		if (prop)
+			i = *(u32 *)prop;
+
 		prop = of_get_property(np, "mode", NULL);
 		if (prop && !strcmp(prop, "cpu-qe"))
 			pdata.qe_mode = 1;
@@ -1290,7 +1269,7 @@ int __init fsl_spi_init(struct spi_board_info *board_infos,
 		}
 
 		if (!pdata.max_chipselect)
-			goto err;
+			continue;
 
 		ret = of_address_to_resource(np, 0, &res[0]);
 		if (ret)
@@ -1317,13 +1296,56 @@ int __init fsl_spi_init(struct spi_board_info *board_infos,
 		if (ret)
 			goto unreg;
 
-		continue;
+		goto next;
 unreg:
 		platform_device_del(pdev);
 err:
-		continue;
+		pr_err("%s: registration failed\n", np->full_name);
+next:
+		i++;
 	}
 
+	return i;
+}
+
+int __init fsl_spi_init(struct spi_board_info *board_infos,
+			unsigned int num_board_infos,
+			void (*activate_cs)(u8 cs, u8 polarity),
+			void (*deactivate_cs)(u8 cs, u8 polarity))
+{
+	u32 sysclk;
+	int ret;
+
+	/* SPI controller is either clocked from QE or SoC clock */
+	sysclk = get_brgfreq();
+	if (sysclk == -1) {
+		struct device_node *np;
+		const u32 *freq;
+		int size;
+
+		np = of_find_node_by_type(NULL, "soc");
+		if (!np)
+			return -ENODEV;
+
+		freq = of_get_property(np, "clock-frequency", &size);
+		if (!freq || size != sizeof(*freq) || *freq == 0) {
+			freq = of_get_property(np, "bus-frequency", &size);
+			if (!freq || size != sizeof(*freq) || *freq == 0) {
+				of_node_put(np);
+				return -ENODEV;
+			}
+		}
+
+		sysclk = *freq;
+		of_node_put(np);
+	}
+
+	ret = of_fsl_spi_probe(NULL, "fsl,spi", sysclk, board_infos,
+			       num_board_infos, activate_cs, deactivate_cs);
+	if (!ret)
+		of_fsl_spi_probe("spi", "fsl_spi", sysclk, board_infos,
+				 num_board_infos, activate_cs, deactivate_cs);
+
 	return spi_register_board_info(board_infos, num_board_infos);
 }
 
-- 
1.5.2.2
