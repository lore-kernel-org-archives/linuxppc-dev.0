Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 237E1DDEC1
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 07:35:36 +1100 (EST)
Date: Wed, 19 Dec 2007 23:37:48 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 1/4] [POWERPC] qe_lib and users: get rid of device_type and
	model
Message-ID: <20071219203748.GA20861@localhost.localdomain>
References: <20071219203447.GA18285@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071219203447.GA18285@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now we're searching for "fsl,qe", "fsl,qe-muram", "fsl,qe-muram-data".

Per http://ozlabs.org/pipermail/linuxppc-dev/2007-December/048388.html

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc832x_mds.dts |    6 +++---
 arch/powerpc/boot/dts/mpc832x_rdb.dts |    6 +++---
 arch/powerpc/boot/dts/mpc836x_mds.dts |    6 +++---
 arch/powerpc/boot/dts/mpc8568mds.dts  |    6 +++---
 arch/powerpc/sysdev/fsl_soc.c         |    2 +-
 arch/powerpc/sysdev/qe_lib/qe.c       |    7 ++++---
 6 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc832x_mds.dts b/arch/powerpc/boot/dts/mpc832x_mds.dts
index 26ac467..ef8cd1e 100644
--- a/arch/powerpc/boot/dts/mpc832x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
@@ -175,18 +175,18 @@
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
+			compatible = "fsl,qe-muram";
 			ranges = <0 00010000 00004000>;
 
 			data-only@0 {
+				compatible = "fsl,qe-muram-data";
 				reg = <0 4000>;
 			};
 		};
diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
index 10ff7aa..7c4f028 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -165,18 +165,18 @@
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
+			compatible = "fsl,qe-muram";
 			ranges = <0 00010000 00004000>;
 
 			data-only@0 {
+				compatible = "fsl,qe-muram-data";
 				reg = <0 4000>;
 			};
 		};
diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
index fd841b2..5c73786 100644
--- a/arch/powerpc/boot/dts/mpc836x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
@@ -206,18 +206,18 @@
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
+			device_type = "fsl,qe-muram";
 			ranges = <0 00010000 0000c000>;
 
 			data-only@0{
+				device_type = "fsl,qe-muram-data";
 				reg = <0 c000>;
 			};
 		};
diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index 5818a7c..7ad4b9f 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -283,18 +283,18 @@
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
+			compatible = "fsl,qe-muram";
 			ranges = <0 00010000 0000c000>;
 
 			data-only@0{
+				compatible = "fsl,qe-muram-data";
 				reg = <0 c000>;
 			};
 		};
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 4baad80..044dd7f 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -1226,7 +1226,7 @@ int __init fsl_spi_init(struct spi_board_info *board_infos,
 	const u32 *sysclk;
 
 	/* SPI controller is either clocked from QE or SoC clock */
-	np = of_find_node_by_type(NULL, "qe");
+	np = of_find_compatible_node(NULL, NULL, "fsl,qe");
 	if (!np)
 		np = of_find_node_by_type(NULL, "soc");
 
diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
index 21e0106..4af71e1 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -68,7 +68,7 @@ phys_addr_t get_qe_base(void)
 	if (qebase != -1)
 		return qebase;
 
-	qe = of_find_node_by_type(NULL, "qe");
+	qe = of_find_compatible_node(NULL, NULL, "fsl,qe");
 	if (qe) {
 		unsigned int size;
 		const void *prop = of_get_property(qe, "reg", &size);
@@ -155,7 +155,7 @@ unsigned int get_brg_clk(void)
 	if (brg_clk)
 		return brg_clk;
 
-	qe = of_find_node_by_type(NULL, "qe");
+	qe = of_find_compatible_node(NULL, NULL, "fsl,qe");
 	if (qe) {
 		unsigned int size;
 		const u32 *prop = of_get_property(qe, "brg-frequency", &size);
@@ -334,7 +334,8 @@ static void qe_muram_init(void)
 	/* XXX: This is a subset of the available muram. It
 	 * varies with the processor and the microcode patches activated.
 	 */
-	if ((np = of_find_node_by_name(NULL, "data-only")) != NULL) {
+	np = of_find_compatible_node(NULL, NULL, "fsl,qe-muram-data");
+	if (np) {
 		address = *of_get_address(np, 0, &size, &flags);
 		of_node_put(np);
 		rh_attach_region(&qe_muram_info, address, (int) size);
-- 
1.5.2.2
