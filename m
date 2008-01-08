Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 76290DDF2D
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 01:29:42 +1100 (EST)
Date: Tue, 8 Jan 2008 17:29:32 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 1/4] [POWERPC] qe_lib and users: get rid of device_types and
	model
Message-ID: <20080108142932.GA11047@localhost.localdomain>
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

Now we're searching for "fsl,qe", "fsl,qe-muram", "fsl,qe-muram-data"
and "fsl,qe-ic".

Per http://ozlabs.org/pipermail/linuxppc-dev/2007-December/048388.html

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 Documentation/powerpc/booting-without-of.txt |    6 ++++--
 arch/powerpc/boot/dts/mpc832x_mds.dts        |   11 ++++++-----
 arch/powerpc/boot/dts/mpc832x_rdb.dts        |   11 ++++++-----
 arch/powerpc/boot/dts/mpc836x_mds.dts        |   11 ++++++-----
 arch/powerpc/boot/dts/mpc8568mds.dts         |   11 ++++++-----
 arch/powerpc/platforms/83xx/mpc832x_mds.c    |   11 +++++++----
 arch/powerpc/platforms/83xx/mpc832x_rdb.c    |   11 +++++++----
 arch/powerpc/platforms/83xx/mpc836x_mds.c    |   11 +++++++----
 arch/powerpc/platforms/85xx/mpc85xx_mds.c    |   16 +++++++++++-----
 arch/powerpc/sysdev/fsl_soc.c                |    5 ++++-
 arch/powerpc/sysdev/qe_lib/qe.c              |   16 +++++++++++++---
 11 files changed, 77 insertions(+), 43 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index ee0209a..ed0b92c 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1770,7 +1770,7 @@ platforms are moved over to use the flattened-device-tree model.
    vii) Multi-User RAM (MURAM)
 
    Required properties:
-   - device_type : should be "muram".
+   - compatible : should be "fsl,cpm-muram", "fsl,qe-muram".
    - mode : the could be "host" or "slave".
    - ranges : Should be defined as specified in 1) to describe the
       translation of MURAM addresses.
@@ -1780,10 +1780,12 @@ platforms are moved over to use the flattened-device-tree model.
    Example:
 
 	muram@10000 {
-		device_type = "muram";
+		compatible = "fsl,cpm-muram", "fsl,qe-muram";
 		ranges = <0 00010000 0000c000>;
 
 		data-only@0{
+			compatible = "fsl,cpm-muram-data",
+				     "fsl,qe-muram-data";
 			reg = <0 c000>;
 		};
 	};
diff --git a/arch/powerpc/boot/dts/mpc832x_mds.dts b/arch/powerpc/boot/dts/mpc832x_mds.dts
index 26ac467..010c8d9 100644
--- a/arch/powerpc/boot/dts/mpc832x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
@@ -175,18 +175,19 @@
 	qe@e0100000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		device_type = "qe";
-		model = "QE";
+		compatible = "fsl,qe";
 		ranges = <0 e0100000 00100000>;
 		reg = <e0100000 480>;
 		brg-frequency = <0>;
 		bus-frequency = <BCD3D80>;
 
 		muram@10000 {
-			device_type = "muram";
+			compatible = "fsl,cpm-muram", "fsl,qe-muram";
 			ranges = <0 00010000 00004000>;
 
 			data-only@0 {
+				compatible = "fsl,cpm-muram-data",
+					     "fsl,qe-muram-data";
 				reg = <0 4000>;
 			};
 		};
@@ -271,9 +272,9 @@
 			};
 		};
 
-		qeic: qeic@80 {
+		qeic: interrupt-controller@80 {
 			interrupt-controller;
-			device_type = "qeic";
+			compatible = "fsl,qe-ic";
 			#address-cells = <0>;
 			#interrupt-cells = <1>;
 			reg = <80 80>;
diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
index 10ff7aa..3a73134 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -165,18 +165,19 @@
 	qe@e0100000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		device_type = "qe";
-		model = "QE";
+		compatible = "fsl,qe";
 		ranges = <0 e0100000 00100000>;
 		reg = <e0100000 480>;
 		brg-frequency = <0>;
 		bus-frequency = <BCD3D80>;
 
 		muram@10000 {
-			device_type = "muram";
+			compatible = "fsl,cpm-muram", "fsl,qe-muram";
 			ranges = <0 00010000 00004000>;
 
 			data-only@0 {
+				compatible = "fsl,cpm-muram-data",
+					     "fsl,qe-muram-data";
 				reg = <0 4000>;
 			};
 		};
@@ -252,9 +253,9 @@
 			};
 		};
 
-		qeic:qeic@80 {
+		qeic:interrupt-controller@80 {
 			interrupt-controller;
-			device_type = "qeic";
+			compatible = "fsl,qe-ic";
 			#address-cells = <0>;
 			#interrupt-cells = <1>;
 			reg = <80 80>;
diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
index fd841b2..2986860 100644
--- a/arch/powerpc/boot/dts/mpc836x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
@@ -206,18 +206,19 @@
 	qe@e0100000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		device_type = "qe";
-		model = "QE";
+		compatible = "fsl,qe";
 		ranges = <0 e0100000 00100000>;
 		reg = <e0100000 480>;
 		brg-frequency = <0>;
 		bus-frequency = <179A7B00>;
 
 		muram@10000 {
-			device_type = "muram";
+			compatible = "fsl,cpm-muram", "fsl,qe-muram";
 			ranges = <0 00010000 0000c000>;
 
 			data-only@0{
+				compatible = "fsl,cpm-muram-data",
+					     "fsl,qe-muram-data";
 				reg = <0 c000>;
 			};
 		};
@@ -304,9 +305,9 @@
 			};
 		};
 
-		qeic: qeic@80 {
+		qeic: interrupt-controller@80 {
 			interrupt-controller;
-			device_type = "qeic";
+			compatible = "fsl,qe-ic";
 			#address-cells = <0>;
 			#interrupt-cells = <1>;
 			reg = <80 80>;
diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index 5818a7c..7440347 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -283,18 +283,19 @@
 	qe@e0080000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		device_type = "qe";
-		model = "QE";
+		compatible = "fsl,qe";
 		ranges = <0 e0080000 00040000>;
 		reg = <e0080000 480>;
 		brg-frequency = <0>;
 		bus-frequency = <179A7B00>;
 
 		muram@10000 {
-			device_type = "muram";
+			compatible = "fsl,cpm-muram", "fsl,qe-muram";
 			ranges = <0 00010000 0000c000>;
 
 			data-only@0{
+				compatible = "fsl,cpm-muram-data",
+					     "fsl,qe-muram-data";
 				reg = <0 c000>;
 			};
 		};
@@ -385,9 +386,9 @@
 			};
 		};
 
-		qeic: qeic@80 {
+		qeic: interrupt-controller@80 {
 			interrupt-controller;
-			device_type = "qeic";
+			compatible = "fsl,qe-ic";
 			#address-cells = <0>;
 			#interrupt-cells = <1>;
 			reg = <80 80>;
diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
index 1e570bb..ec41284 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -105,6 +105,7 @@ static struct of_device_id mpc832x_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
 	{ .type = "qe", },
+	{ .compatible = "fsl,qe", },
 	{},
 };
 
@@ -137,10 +138,12 @@ static void __init mpc832x_sys_init_IRQ(void)
 	of_node_put(np);
 
 #ifdef CONFIG_QUICC_ENGINE
-	np = of_find_node_by_type(NULL, "qeic");
-	if (!np)
-		return;
-
+	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
+	if (!np) {
+		np = of_find_node_by_type(NULL, "qeic");
+		if (!np)
+			return;
+	}
 	qe_ic_init(np, 0, qe_ic_cascade_low_ipic, qe_ic_cascade_high_ipic);
 	of_node_put(np);
 #endif				/* CONFIG_QUICC_ENGINE */
diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index ffb2e93..3025871 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -118,6 +118,7 @@ static struct of_device_id mpc832x_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
 	{ .type = "qe", },
+	{ .compatible = "fsl,qe", },
 	{},
 };
 
@@ -151,10 +152,12 @@ void __init mpc832x_rdb_init_IRQ(void)
 	of_node_put(np);
 
 #ifdef CONFIG_QUICC_ENGINE
-	np = of_find_node_by_type(NULL, "qeic");
-	if (!np)
-		return;
-
+	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
+	if (!np) {
+		np = of_find_node_by_type(NULL, "qeic");
+		if (!np)
+			return;
+	}
 	qe_ic_init(np, 0, qe_ic_cascade_low_ipic, qe_ic_cascade_high_ipic);
 	of_node_put(np);
 #endif				/* CONFIG_QUICC_ENGINE */
diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platforms/83xx/mpc836x_mds.c
index 2ac9890..788291c 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -136,6 +136,7 @@ static struct of_device_id mpc836x_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
 	{ .type = "qe", },
+	{ .compatible = "fsl,qe", },
 	{},
 };
 
@@ -168,10 +169,12 @@ static void __init mpc836x_mds_init_IRQ(void)
 	of_node_put(np);
 
 #ifdef CONFIG_QUICC_ENGINE
-	np = of_find_node_by_type(NULL, "qeic");
-	if (!np)
-		return;
-
+	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
+	if (!np) {
+		np = of_find_node_by_type(NULL, "qeic");
+		if (!np)
+			return;
+	}
 	qe_ic_init(np, 0, qe_ic_cascade_low_ipic, qe_ic_cascade_high_ipic);
 	of_node_put(np);
 #endif				/* CONFIG_QUICC_ENGINE */
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index e6c63a5..4fa6d6c 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -94,7 +94,10 @@ static void __init mpc85xx_mds_setup_arch(void)
 #endif
 
 #ifdef CONFIG_QUICC_ENGINE
-	if ((np = of_find_node_by_name(NULL, "qe")) != NULL) {
+	np = of_find_compatible_node(NULL, NULL, "fsl,qe");
+	if (!np)
+		np = of_find_node_by_name(NULL, "qe");
+	if (np) {
 		qe_reset();
 		of_node_put(np);
 	}
@@ -139,6 +142,7 @@ static struct of_device_id mpc85xx_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
 	{ .type = "qe", },
+	{ .compatible = "fsl,qe", },
 	{},
 };
 
@@ -179,10 +183,12 @@ static void __init mpc85xx_mds_pic_init(void)
 	mpic_init(mpic);
 
 #ifdef CONFIG_QUICC_ENGINE
-	np = of_find_node_by_type(NULL, "qeic");
-	if (!np)
-		return;
-
+	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
+	if (!np) {
+		np = of_find_node_by_type(NULL, "qeic");
+		if (!np)
+			return;
+	}
 	qe_ic_init(np, 0, qe_ic_cascade_muxed_mpic, NULL);
 	of_node_put(np);
 #endif				/* CONFIG_QUICC_ENGINE */
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 4baad80..60d9c4e 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -1226,7 +1226,10 @@ int __init fsl_spi_init(struct spi_board_info *board_infos,
 	const u32 *sysclk;
 
 	/* SPI controller is either clocked from QE or SoC clock */
-	np = of_find_node_by_type(NULL, "qe");
+	np = of_find_compatible_node(NULL, NULL, "fsl,qe");
+	if (!np)
+		np = of_find_node_by_type(NULL, "qe");
+
 	if (!np)
 		np = of_find_node_by_type(NULL, "soc");
 
diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
index 21e0106..cd6cee3 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -68,7 +68,10 @@ phys_addr_t get_qe_base(void)
 	if (qebase != -1)
 		return qebase;
 
-	qe = of_find_node_by_type(NULL, "qe");
+	qe = of_find_compatible_node(NULL, NULL, "fsl,qe");
+	if (!qe)
+		qe = of_find_node_by_type(NULL, "qe");
+
 	if (qe) {
 		unsigned int size;
 		const void *prop = of_get_property(qe, "reg", &size);
@@ -155,7 +158,10 @@ unsigned int get_brg_clk(void)
 	if (brg_clk)
 		return brg_clk;
 
-	qe = of_find_node_by_type(NULL, "qe");
+	qe = of_find_compatible_node(NULL, NULL, "fsl,qe");
+	if (!qe)
+		qe = of_find_node_by_type(NULL, "qe");
+
 	if (qe) {
 		unsigned int size;
 		const u32 *prop = of_get_property(qe, "brg-frequency", &size);
@@ -334,7 +340,11 @@ static void qe_muram_init(void)
 	/* XXX: This is a subset of the available muram. It
 	 * varies with the processor and the microcode patches activated.
 	 */
-	if ((np = of_find_node_by_name(NULL, "data-only")) != NULL) {
+	np = of_find_compatible_node(NULL, NULL, "fsl,qe-muram-data");
+	if (!np)
+		np = of_find_node_by_name(NULL, "data-only");
+
+	if (np) {
 		address = *of_get_address(np, 0, &size, &flags);
 		of_node_put(np);
 		rh_attach_region(&qe_muram_info, address, (int) size);
-- 
1.5.2.2
