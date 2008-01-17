Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BF78DDE192
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 09:37:31 +1100 (EST)
Date: Thu, 17 Jan 2008 16:37:51 -0600
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 1/3] mpc8313erdb: Add NAND to device tree, and call
	of_platform_bus_probe().
Message-ID: <20080117223750.GA20697@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
Please apply this series for 2.6.25.

 arch/powerpc/boot/dts/mpc8313erdb.dts     |   39 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/83xx/mpc8313_rdb.c |   13 +++++++++
 2 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
index c5b6665..63955a1 100644
--- a/arch/powerpc/boot/dts/mpc8313erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
@@ -45,10 +45,49 @@
 		reg = <00000000 08000000>;	// 128MB at 0
 	};
 
+	localbus@e0005000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8313-elbc", "fsl,elbc", "simple-bus";
+		reg = <e0005000 1000>;
+		interrupts = <d#77 8>;
+		interrupt-parent = <&ipic>;
+
+		// CS0 and CS1 are swapped when
+		// booting from nand, but the
+		// addresses are the same.
+		ranges = <0 0 fe000000 00800000
+		          1 0 e2800000 00008000
+		          2 0 f0000000 00020000
+		          3 0 fa000000 00008000>;
+
+		nand@1,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8313-fcm-nand",
+			             "fsl,elbc-fcm-nand";
+			reg = <1 0 2000>;
+
+			u-boot@0 {
+				reg = <0 100000>;
+				read-only;
+			};
+
+			kernel@100000 {
+				reg = <100000 300000>;
+			};
+
+			fs@400000 {
+				reg = <400000 1c00000>;
+			};
+		};
+	};
+
 	soc8313@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
+		compatible = "simple-bus";
 		ranges = <0 e0000000 00100000>;
 		reg = <e0000000 00000200>;
 		bus-frequency = <0>;
diff --git a/arch/powerpc/platforms/83xx/mpc8313_rdb.c b/arch/powerpc/platforms/83xx/mpc8313_rdb.c
index 6fb8299..4996b7d 100644
--- a/arch/powerpc/platforms/83xx/mpc8313_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc8313_rdb.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/pci.h>
+#include <linux/of_platform.h>
 
 #include <asm/time.h>
 #include <asm/ipic.h>
@@ -75,6 +76,18 @@ static int __init mpc8313_rdb_probe(void)
 	return of_flat_dt_is_compatible(root, "MPC8313ERDB");
 }
 
+static struct of_device_id __initdata of_bus_ids[] = {
+	{ .compatible = "simple-bus" },
+	{},
+};
+
+static int __init declare_of_platform_devices(void)
+{
+	of_platform_bus_probe(NULL, of_bus_ids, NULL);
+	return 0;
+}
+machine_device_initcall(mpc8313_rdb, declare_of_platform_devices);
+
 define_machine(mpc8313_rdb) {
 	.name			= "MPC8313 RDB",
 	.probe			= mpc8313_rdb_probe,
-- 
1.5.3.8
