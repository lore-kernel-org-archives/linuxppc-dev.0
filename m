Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 0EA99DDE03
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 04:10:43 +1100 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 2ED6A8810
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 22:10:54 +0400 (SAMT)
Date: Tue, 11 Mar 2008 20:10:40 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] [POWERPC] fsl_soc: add support for "fsl,
	soc" compatible matching
Message-ID: <20080311171040.GA4684@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

As we've seen, fsl,immr isn't good name for the generic purposes,
because some SOCs use ccsr term. So, for generic matching, "fsl,soc"
is used, whereas "fsl,immr" and "fsl,ccsr" is used for more specific
matching.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 Documentation/powerpc/booting-without-of.txt |   20 +++++------
 arch/powerpc/sysdev/fsl_soc.c                |   51 +++++++++++++++-----------
 2 files changed, 39 insertions(+), 32 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 7b4e8a7..be41a5c 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -32,7 +32,7 @@ Table of Contents
       c) The /cpus/* nodes
       d) the /memory node(s)
       e) The /chosen node
-      f) the /soc<SOCname> node
+      f) the /soc node
 
   IV - "dtc", the device tree compiler
 
@@ -961,20 +961,17 @@ compatibility.
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
+    - compatible : Should be "<cpu>-<immr or ccsr>", "fsl,<immr or ccsr>",
+      "fsl,soc", "simple-bus".
     - ranges : Should be defined as specified in 1) to describe the
       translation of SOC addresses for memory mapped SOC registers.
     - bus-frequency: Contains the bus frequency for the SOC node.
@@ -2913,11 +2910,12 @@ Note that the #address-cells and #size-cells for the SoC node
 in this example have been explicitly listed; these are likely
 not necessary as they are usually the same as the root node.
 
-	soc8540@e0000000 {
+	soc@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		#interrupt-cells = <2>;
-		device_type = "soc";
+		compatible = "fsl,mpc8540-ccsr", "fsl,ccsr", "fsl,soc",
+			     "simple-bus";
 		ranges = <00000000 e0000000 00100000>
 		reg = <e0000000 00003000>;
 		bus-frequency = <0>;
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 2c5388c..7ad9bce 100644
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
+	soc = of_find_compatible_node(NULL, NULL, "fsl,soc");
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
+	soc = of_find_compatible_node(NULL, NULL, "fsl,soc");
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
+		np = of_find_compatible_node(NULL, NULL, "fsl,soc");
+		if (!np) {
+			np = of_find_node_by_type(NULL, "soc");
+			if (!np)
+				return -ENODEV;
+		}
 
 		freq = of_get_property(np, "clock-frequency", &size);
 		if (!freq || size != sizeof(*freq) || *freq == 0) {
-- 
1.5.2.2
