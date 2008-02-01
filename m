Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id EBD1CDE157
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Feb 2008 02:01:16 +1100 (EST)
Date: Fri, 1 Feb 2008 18:01:17 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] fsl_soc: add support for "fsl,
	immr" compatible matching
Message-ID: <20080201150117.GA26545@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Unfortunately it's still impossible to remove device_type = "soc"
from the existing device tree, because older u-boots are looking for
it.

Neither we can remove model number from the soc name to heal
arch/powerpc/boot/cuboot-85xx.c, because then dts'es will be
incompatible with older u-boots again.

So, just one machine converted so far: MPC8360E-RDK. It's new machine
so we don't care about backward compatibility yet.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 Documentation/powerpc/booting-without-of.txt |   18 ++++------
 arch/powerpc/boot/dts/mpc836x_rdk.dts        |    1 -
 arch/powerpc/sysdev/fsl_soc.c                |   51 +++++++++++++++-----------
 3 files changed, 37 insertions(+), 33 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index b5e46ef..410c847 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -32,7 +32,7 @@ Table of Contents
       c) The /cpus/* nodes
       d) the /memory node(s)
       e) The /chosen node
-      f) the /soc<SOCname> node
+      f) the /soc node
 
   IV - "dtc", the device tree compiler
 
@@ -960,20 +960,16 @@ compatibility.
   under /chosen called interrupt-controller which had a phandle value
   that pointed to the main interrupt controller)
 
-  f) the /soc<SOCname> node
+  f) the /soc node
 
   This node is used to represent a system-on-a-chip (SOC) and must be
   present if the processor is a SOC. The top-level soc node contains
-  information that is global to all devices on the SOC. The node name
-  should contain a unit address for the SOC, which is the base address
-  of the memory-mapped register set for the SOC. The name of an soc
-  node should start with "soc", and the remainder of the name should
-  represent the part number for the soc.  For example, the MPC8540's
-  soc node would be called "soc8540".
+  information that is global to all devices on the SOC. The name of an
+  soc node should be "soc".
 
   Required properties:
 
-    - device_type : Should be "soc"
+    - compatible : Should be "<cpu-specific>-immr", "fsl,immr", "simple-bus"
     - ranges : Should be defined as specified in 1) to describe the
       translation of SOC addresses for memory mapped SOC registers.
     - bus-frequency: Contains the bus frequency for the SOC node.
@@ -2871,11 +2867,11 @@ Note that the #address-cells and #size-cells for the SoC node
 in this example have been explicitly listed; these are likely
 not necessary as they are usually the same as the root node.
 
-	soc8540@e0000000 {
+	soc@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		#interrupt-cells = <2>;
-		device_type = "soc";
+		compatible = "fsl,mpc8540-immr", "fsl,immr", "simple-bus";
 		ranges = <00000000 e0000000 00100000>
 		reg = <e0000000 00003000>;
 		bus-frequency = <0>;
diff --git a/arch/powerpc/boot/dts/mpc836x_rdk.dts b/arch/powerpc/boot/dts/mpc836x_rdk.dts
index b062f9b..e35200a 100644
--- a/arch/powerpc/boot/dts/mpc836x_rdk.dts
+++ b/arch/powerpc/boot/dts/mpc836x_rdk.dts
@@ -57,7 +57,6 @@
 	soc@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		device_type = "soc";
 		compatible = "fsl,mpc8360-immr", "fsl,immr", "simple-bus";
 		ranges = <0 0xe0000000 0x200000>;
 		reg = <0xe0000000 0x200>;
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index e48b20e..721ad2d 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -48,27 +48,31 @@ static phys_addr_t immrbase = -1;
 phys_addr_t get_immrbase(void)
 {
 	struct device_node *soc;
+	int size;
+	u32 naddr;
+	const u32 *prop;
 
 	if (immrbase != -1)
 		return immrbase;
 
-	soc = of_find_node_by_type(NULL, "soc");
-	if (soc) {
-		int size;
-		u32 naddr;
-		const u32 *prop = of_get_property(soc, "#address-cells", &size);
+	soc = of_find_compatible_node(NULL, NULL, "fsl,immr");
+	if (!soc) {
+		soc = of_find_node_by_type(NULL, "soc");
+		if (!soc)
+			return immrbase;
+	}
 
-		if (prop && size == 4)
-			naddr = *prop;
-		else
-			naddr = 2;
+	prop = of_get_property(soc, "#address-cells", &size);
+	if (prop && size == 4)
+		naddr = *prop;
+	else
+		naddr = 2;
 
-		prop = of_get_property(soc, "ranges", &size);
-		if (prop)
-			immrbase = of_translate_address(soc, prop + naddr);
+	prop = of_get_property(soc, "ranges", &size);
+	if (prop)
+		immrbase = of_translate_address(soc, prop + naddr);
 
-		of_node_put(soc);
-	}
+	of_node_put(soc);
 
 	return immrbase;
 }
@@ -528,11 +532,13 @@ static int __init mpc83xx_wdt_init(void)
 		goto nodev;
 	}
 
-	soc = of_find_node_by_type(NULL, "soc");
-
+	soc = of_find_compatible_node(NULL, NULL, "fsl,immr");
 	if (!soc) {
-		ret = -ENODEV;
-		goto nosoc;
+		soc = of_find_node_by_type(NULL, "soc");
+		if (!soc) {
+			ret = -ENODEV;
+			goto nosoc;
+		}
 	}
 
 	freq = of_get_property(soc, "bus-frequency", NULL);
@@ -1375,9 +1381,12 @@ int __init fsl_spi_init(struct spi_board_info *board_infos,
 		const u32 *freq;
 		int size;
 
-		np = of_find_node_by_type(NULL, "soc");
-		if (!np)
-			return -ENODEV;
+		np = of_find_compatible_node(NULL, NULL, "fsl,immr");
+		if (!np) {
+			np = of_find_node_by_type(NULL, "soc");
+			if (!np)
+				return -ENODEV;
+		}
 
 		freq = of_get_property(np, "clock-frequency", &size);
 		if (!freq || size != sizeof(*freq) || *freq == 0) {
-- 
1.5.2.2
