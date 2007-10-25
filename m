Return-Path: <mgreer@mvista.com>
Date: Thu, 25 Oct 2007 16:39:48 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/2] powerpc: prpmc2800 - Add MTD support
Message-ID: <20071025233948.GA22703@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Mark A. Greer <mgreer@mvista.com>

Create necessary device nodes so that the MTD subsystem recognizes
the MTD entries in the prpmc2800's DTS file.  Also bring MTD section
of the prpmc2800's DTS file up to the current DTS specification.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---
 arch/powerpc/boot/dts/prpmc2800.dts            |   39 +++++++++++----
 arch/powerpc/platforms/embedded6xx/prpmc2800.c |   13 +++++
 2 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/boot/dts/prpmc2800.dts b/arch/powerpc/boot/dts/prpmc2800.dts
index 297dfa5..50fc0a7 100644
--- a/arch/powerpc/boot/dts/prpmc2800.dts
+++ b/arch/powerpc/boot/dts/prpmc2800.dts
@@ -55,17 +55,36 @@
 			  f2000000 f2000000 00040000>;	/* Integrated SRAM */
 
 		flash@a0000000 {
-			device_type = "rom";
-			compatible = "direct-mapped";
-			reg = <a0000000 4000000>; /* Default (64MB) */
-			probe-type = "CFI";
+			compatible = "cfi-flash";
+			reg = <a0000000 04000000>;
 			bank-width = <4>;
-			partitions = <00000000 00100000 /* RO */
-				      00100000 00040001 /* RW */
-				      00140000 00400000 /* RO */
-				      00540000 039c0000 /* RO */
-				      03f00000 00100000>; /* RO */
-			partition-names = "FW Image A", "FW Config Data", "Kernel Image", "Filesystem", "FW Image B";
+			device-width = <2>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			fw@0 {
+				label = "FW Image A";
+				reg = <00000000 00100000>;
+				read-only;
+			};
+			cfg@100000 {
+				label = "FW Config Data";	/* RW */
+				reg = <00100000 00040000>;
+			};
+			kernel@140000 {
+				label = "Kernel Image";
+				reg = <00140000 00400000>;
+				read-only;
+			};
+			fs@540000 {
+				label = "Filesystem";
+				reg = <00540000 039c0000>;
+				read-only;
+			};
+			fw@3f00000 {
+				label = "FW Image B";
+				reg = <03f00000 00100000>;
+				read-only;
+			};
 		};
 
 		mdio {
diff --git a/arch/powerpc/platforms/embedded6xx/prpmc2800.c b/arch/powerpc/platforms/embedded6xx/prpmc2800.c
index e484cac..a356a19 100644
--- a/arch/powerpc/platforms/embedded6xx/prpmc2800.c
+++ b/arch/powerpc/platforms/embedded6xx/prpmc2800.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/seq_file.h>
+#include <linux/of_platform.h>
 
 #include <asm/machdep.h>
 #include <asm/prom.h>
@@ -68,6 +69,18 @@ static void __init prpmc2800_setup_arch(void)
 	printk("Motorola %s\n", prpmc2800_platform_name);
 }
 
+static int __init prpmc2800_register_mtd(void)
+{
+	struct device_node *np = NULL;
+
+	while ((np = of_find_compatible_node(np, NULL, "cfi-flash")) != NULL)
+		of_platform_device_create(np, NULL, NULL);
+
+	of_node_put(np);
+	return 0;
+}
+device_initcall(prpmc2800_register_mtd);
+
 static void prpmc2800_reset_board(void)
 {
 	u32 temp;
