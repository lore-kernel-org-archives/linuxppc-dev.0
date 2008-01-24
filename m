Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 88B04DE0B7
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 02:40:26 +1100 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 191F98810
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 20:40:34 +0400 (SAMT)
Date: Thu, 24 Jan 2008 18:40:10 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/5] [POWERPC] fsl_soc,
	legacy_serial: add support for "soc" compatible matching
Message-ID: <20080124154010.GE23246@localhost.localdomain>
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

We'll match on "soc" compatible for generic code, and "fsl,soc"
for fsl specific code.

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

I know, this patch will conflict with the legacy serial rework[1].
It's okay though, if [1] will hit galak/powerpc.git first, I'll
simply rebase that patch.

[1] http://ozlabs.org/pipermail/linuxppc-dev/2008-January/050096.html

 Documentation/powerpc/booting-without-of.txt |   18 ++++------
 arch/powerpc/boot/dts/mpc836x_rdk.dts        |    1 -
 arch/powerpc/kernel/legacy_serial.c          |    3 +-
 arch/powerpc/sysdev/fsl_soc.c                |   51 +++++++++++++++-----------
 4 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index bedfdd0..a3b6e2a 100644
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
+    - compatible : Should be "cpu-specific-soc", "soc".
     - ranges : Should be defined as specified in 1) to describe the
       translation of SOC addresses for memory mapped SOC registers.
     - bus-frequency: Contains the bus frequency for the SOC node.
@@ -2713,11 +2709,11 @@ Note that the #address-cells and #size-cells for the SoC node
 in this example have been explicitly listed; these are likely
 not necessary as they are usually the same as the root node.
 
-	soc8540@e0000000 {
+	soc@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		#interrupt-cells = <2>;
-		device_type = "soc";
+		compatible = "fsl,mpc8540-soc", "fsl,soc", "soc";
 		ranges = <00000000 e0000000 00100000>
 		reg = <e0000000 00003000>;
 		bus-frequency = <0>;
diff --git a/arch/powerpc/boot/dts/mpc836x_rdk.dts b/arch/powerpc/boot/dts/mpc836x_rdk.dts
index 6efa5b7..ef739ee 100644
--- a/arch/powerpc/boot/dts/mpc836x_rdk.dts
+++ b/arch/powerpc/boot/dts/mpc836x_rdk.dts
@@ -58,7 +58,6 @@
 	soc@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		device_type = "soc";
 		compatible = "fsl,mpc8360-soc", "fsl,soc", "soc";
 		ranges = <0 0xe0000000 0x100000>;
 		reg = <0xe0000000 0x200>;
diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index 4bfff88..c99d0ae 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -309,7 +309,8 @@ void __init find_legacy_serial_ports(void)
 	/* First fill our array with SOC ports */
 	for_each_compatible_node(np, "serial", "ns16550") {
 		struct device_node *soc = of_get_parent(np);
-		if (soc && !strcmp(soc->type, "soc")) {
+		if (soc && (!strcmp(soc->type, "soc") ||
+				of_device_is_compatible(soc, "soc"))) {
 			index = add_legacy_soc_port(np, np);
 			if (index >= 0 && np == stdout)
 				legacy_serial_console = index;
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index e75fd44..96851ae 100644
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
@@ -1373,9 +1379,12 @@ int __init fsl_spi_init(struct spi_board_info *board_infos,
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
