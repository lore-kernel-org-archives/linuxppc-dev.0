Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 06D1DDDF74
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 02:40:14 +1100 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id E8F318810
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 20:40:22 +0400 (SAMT)
Date: Thu, 24 Jan 2008 18:39:59 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/5] [POWERPC] qe_lib and users: get rid of most device_types
	and model
Message-ID: <20080124153959.GA23246@localhost.localdomain>
References: <20080124151850.GA15190@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080124151850.GA15190@localhost.localdomain>
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

Unfortunately it's still impossible to remove device_type = "qe"
from the existing device trees (except for MPC8360E-RDK), because
older u-boots are looking for it.

Per http://ozlabs.org/pipermail/linuxppc-dev/2007-December/048388.html

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 Documentation/powerpc/booting-without-of.txt |   11 +++--
 arch/powerpc/boot/dts/mpc832x_mds.dts        |    9 ++--
 arch/powerpc/boot/dts/mpc832x_rdb.dts        |   10 +++--
 arch/powerpc/boot/dts/mpc836x_mds.dts        |   10 +++--
 arch/powerpc/boot/dts/mpc836x_rdk.dts        |    1 -
 arch/powerpc/boot/dts/mpc8568mds.dts         |   10 +++--
 arch/powerpc/platforms/83xx/mpc832x_mds.c    |   11 +++--
 arch/powerpc/platforms/83xx/mpc832x_rdb.c    |   11 +++--
 arch/powerpc/platforms/83xx/mpc836x_mds.c    |   11 +++--
 arch/powerpc/platforms/85xx/mpc85xx_mds.c    |   32 ++++++++-----
 arch/powerpc/sysdev/fsl_soc.c                |    5 ++-
 arch/powerpc/sysdev/qe_lib/qe.c              |   63 ++++++++++++++++++--------
 12 files changed, 117 insertions(+), 67 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index da98154..f9545b0 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1543,7 +1543,7 @@ platforms are moved over to use the flattened-device-tree model.
    i) Root QE device
 
    Required properties:
-   - device_type : should be "qe";
+   - compatible : should be "fsl,qe";
    - model : precise model of the QE, Can be "QE", "CPM", or "CPM2"
    - reg : offset and length of the device registers.
    - bus-frequency : the clock frequency for QUICC Engine.
@@ -1557,8 +1557,7 @@ platforms are moved over to use the flattened-device-tree model.
 		#address-cells = <1>;
 		#size-cells = <1>;
 		#interrupt-cells = <2>;
-		device_type = "qe";
-		model = "QE";
+		compatible = "fsl,qe";
 		ranges = <0 e0100000 00100000>;
 		reg = <e0100000 480>;
 		brg-frequency = <0>;
@@ -1781,7 +1780,7 @@ platforms are moved over to use the flattened-device-tree model.
    vii) Multi-User RAM (MURAM)
 
    Required properties:
-   - device_type : should be "muram".
+   - compatible : should be "fsl,qe-muram", "fsl,cpm-muram".
    - mode : the could be "host" or "slave".
    - ranges : Should be defined as specified in 1) to describe the
       translation of MURAM addresses.
@@ -1791,10 +1790,12 @@ platforms are moved over to use the flattened-device-tree model.
    Example:
 
 	muram@10000 {
-		device_type = "muram";
+		compatible = "fsl,qe-muram", "fsl,cpm-muram";
 		ranges = <0 00010000 0000c000>;
 
 		data-only@0{
+			compatible = "fsl,qe-muram-data",
+				     "fsl,cpm-muram-data";
 			reg = <0 c000>;
 		};
 	};
diff --git a/arch/powerpc/boot/dts/mpc832x_mds.dts b/arch/powerpc/boot/dts/mpc832x_mds.dts
index 6902524..e300df4 100644
--- a/arch/powerpc/boot/dts/mpc832x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
@@ -206,17 +206,18 @@
 		#size-cells = <1>;
 		device_type = "qe";
 		compatible = "fsl,qe";
-		model = "QE";
 		ranges = <0 e0100000 00100000>;
 		reg = <e0100000 480>;
 		brg-frequency = <0>;
 		bus-frequency = <BCD3D80>;
 
 		muram@10000 {
-			device_type = "muram";
+			compatible = "fsl,qe-muram", "fsl,cpm-muram";
 			ranges = <0 00010000 00004000>;
 
 			data-only@0 {
+				compatible = "fsl,qe-muram-data",
+					     "fsl,cpm-muram-data";
 				reg = <0 4000>;
 			};
 		};
@@ -320,9 +321,9 @@
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
index 10ff7aa..4d5cfd3 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -166,17 +166,19 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "qe";
-		model = "QE";
+		compatible = "fsl,qe";
 		ranges = <0 e0100000 00100000>;
 		reg = <e0100000 480>;
 		brg-frequency = <0>;
 		bus-frequency = <BCD3D80>;
 
 		muram@10000 {
-			device_type = "muram";
+			compatible = "fsl,qe-muram", "fsl,cpm-muram";
 			ranges = <0 00010000 00004000>;
 
 			data-only@0 {
+				compatible = "fsl,qe-muram-data",
+					     "fsl,cpm-muram-data";
 				reg = <0 4000>;
 			};
 		};
@@ -252,9 +254,9 @@
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
index 2181d2c..9a2581b 100644
--- a/arch/powerpc/boot/dts/mpc836x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
@@ -207,17 +207,19 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "qe";
-		model = "QE";
+		compatible = "fsl,qe";
 		ranges = <0 e0100000 00100000>;
 		reg = <e0100000 480>;
 		brg-frequency = <0>;
 		bus-frequency = <179A7B00>;
 
 		muram@10000 {
-			device_type = "muram";
+			compatible = "fsl,qe-muram", "fsl,cpm-muram";
 			ranges = <0 00010000 0000c000>;
 
 			data-only@0{
+				compatible = "fsl,qe-muram-data",
+					     "fsl,cpm-muram-data";
 				reg = <0 c000>;
 			};
 		};
@@ -303,9 +305,9 @@
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
diff --git a/arch/powerpc/boot/dts/mpc836x_rdk.dts b/arch/powerpc/boot/dts/mpc836x_rdk.dts
index b8f87ac..e244619 100644
--- a/arch/powerpc/boot/dts/mpc836x_rdk.dts
+++ b/arch/powerpc/boot/dts/mpc836x_rdk.dts
@@ -145,7 +145,6 @@
 	qe@e0100000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		device_type = "qe";
 		compatible = "fsl,qe";
 		ranges = <0 0xe0100000 0x100000>;
 		reg = <0xe0100000 0x480>;
diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index 5818a7c..04f5c6f 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -284,17 +284,19 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "qe";
-		model = "QE";
+		compatible = "fsl,qe";
 		ranges = <0 e0080000 00040000>;
 		reg = <e0080000 480>;
 		brg-frequency = <0>;
 		bus-frequency = <179A7B00>;
 
 		muram@10000 {
-			device_type = "muram";
+			compatible = "fsl,qe-muram", "fsl,cpm-muram";
 			ranges = <0 00010000 0000c000>;
 
 			data-only@0{
+				compatible = "fsl,qe-muram-data",
+					     "fsl,cpm-muram-data";
 				reg = <0 c000>;
 			};
 		};
@@ -385,9 +387,9 @@
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
index dbdd4ad..6dbc6ea 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -105,6 +105,7 @@ static struct of_device_id mpc832x_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
 	{ .type = "qe", },
+	{ .compatible = "fsl,qe", },
 	{},
 };
 
@@ -134,10 +135,12 @@ static void __init mpc832x_sys_init_IRQ(void)
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
index 5fddd22..9f0fd88 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -115,6 +115,7 @@ static struct of_device_id mpc832x_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
 	{ .type = "qe", },
+	{ .compatible = "fsl,qe", },
 	{},
 };
 
@@ -145,10 +146,12 @@ void __init mpc832x_rdb_init_IRQ(void)
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
index db491ec..c2e5de6 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -136,6 +136,7 @@ static struct of_device_id mpc836x_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
 	{ .type = "qe", },
+	{ .compatible = "fsl,qe", },
 	{},
 };
 
@@ -165,10 +166,12 @@ static void __init mpc836x_mds_init_IRQ(void)
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
index 4fdf5ab..25f8bc7 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -94,21 +94,25 @@ static void __init mpc85xx_mds_setup_arch(void)
 #endif
 
 #ifdef CONFIG_QUICC_ENGINE
-	if ((np = of_find_node_by_name(NULL, "qe")) != NULL) {
-		qe_reset();
-		of_node_put(np);
+	np = of_find_compatible_node(NULL, NULL, "fsl,qe");
+	if (!np) {
+		np = of_find_node_by_name(NULL, "qe");
+		if (!np)
+			return;
 	}
 
-	if ((np = of_find_node_by_name(NULL, "par_io")) != NULL) {
-		struct device_node *ucc = NULL;
+	qe_reset();
+	of_node_put(np);
+
+	np = of_find_node_by_name(NULL, "par_io");
+	if (np) {
+		struct device_node *ucc;
 
 		par_io_init(np);
 		of_node_put(np);
 
-		for ( ;(ucc = of_find_node_by_name(ucc, "ucc")) != NULL;)
+		for_each_node_by_name(ucc, "ucc")
 			par_io_of_config(ucc);
-
-		of_node_put(ucc);
 	}
 
 	if (bcsr_regs) {
@@ -131,7 +135,6 @@ static void __init mpc85xx_mds_setup_arch(void)
 
 		iounmap(bcsr_regs);
 	}
-
 #endif	/* CONFIG_QUICC_ENGINE */
 }
 
@@ -139,6 +142,7 @@ static struct of_device_id mpc85xx_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
 	{ .type = "qe", },
+	{ .compatible = "fsl,qe", },
 	{},
 };
 
@@ -176,10 +180,12 @@ static void __init mpc85xx_mds_pic_init(void)
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
index f2c0988..26f7d83 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -1276,7 +1276,10 @@ int __init fsl_spi_init(struct spi_board_info *board_infos,
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
index 3925eae..5ef844d 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -65,17 +65,22 @@ static phys_addr_t qebase = -1;
 phys_addr_t get_qe_base(void)
 {
 	struct device_node *qe;
+	unsigned int size;
+	const void *prop;
 
 	if (qebase != -1)
 		return qebase;
 
-	qe = of_find_node_by_type(NULL, "qe");
-	if (qe) {
-		unsigned int size;
-		const void *prop = of_get_property(qe, "reg", &size);
-		qebase = of_translate_address(qe, prop);
-		of_node_put(qe);
-	};
+	qe = of_find_compatible_node(NULL, NULL, "fsl,qe");
+	if (!qe) {
+		qe = of_find_node_by_type(NULL, "qe");
+		if (!qe)
+			return qebase;
+	}
+
+	prop = of_get_property(qe, "reg", &size);
+	qebase = of_translate_address(qe, prop);
+	of_node_put(qe);
 
 	return qebase;
 }
@@ -153,16 +158,26 @@ static unsigned int brg_clk = 0;
 unsigned int get_brg_clk(void)
 {
 	struct device_node *qe;
+	unsigned int size;
+	const u32 *prop;
+
 	if (brg_clk)
 		return brg_clk;
 
-	qe = of_find_node_by_type(NULL, "qe");
-	if (qe) {
-		unsigned int size;
-		const u32 *prop = of_get_property(qe, "brg-frequency", &size);
-		brg_clk = *prop;
-		of_node_put(qe);
-	};
+	qe = of_find_compatible_node(NULL, NULL, "fsl,qe");
+	if (!qe) {
+		qe = of_find_node_by_type(NULL, "qe");
+		if (!qe)
+			return brg_clk;
+	}
+
+	prop = of_get_property(qe, "brg-frequency", &size);
+	if (!prop || size != sizeof(*prop))
+		return brg_clk;
+
+	brg_clk = *prop;
+	of_node_put(qe);
+
 	return brg_clk;
 }
 
@@ -322,7 +337,7 @@ static rh_info_t qe_muram_info;
 static void qe_muram_init(void)
 {
 	struct device_node *np;
-	u32 address;
+	const u32 *address;
 	u64 size;
 	unsigned int flags;
 
@@ -335,11 +350,21 @@ static void qe_muram_init(void)
 	/* XXX: This is a subset of the available muram. It
 	 * varies with the processor and the microcode patches activated.
 	 */
-	if ((np = of_find_node_by_name(NULL, "data-only")) != NULL) {
-		address = *of_get_address(np, 0, &size, &flags);
-		of_node_put(np);
-		rh_attach_region(&qe_muram_info, address, (int) size);
+	np = of_find_compatible_node(NULL, NULL, "fsl,qe-muram-data");
+	if (!np) {
+		np = of_find_node_by_name(NULL, "data-only");
+		if (!np) {
+			WARN_ON(1);
+			return;
+		}
 	}
+
+	address = of_get_address(np, 0, &size, &flags);
+	WARN_ON(!address);
+
+	of_node_put(np);
+	if (address)
+		rh_attach_region(&qe_muram_info, *address, (int)size);
 }
 
 /* This function returns an index into the MURAM area.
-- 
1.5.2.2
