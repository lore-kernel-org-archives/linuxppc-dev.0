Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9F29ADDD0B
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2008 03:29:48 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/85xx: Add localbus node in mpc8572ds dts file
Date: Wed,  3 Dec 2008 10:27:37 -0600
Message-Id: <1228321657-19768-1-git-send-email-galak@kernel.crashing.org>
Cc: Haiying Wang <Haiying.Wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Haiying Wang <Haiying.Wang@freescale.com>

Also add NOR and NAND flash partitions for mpc8572ds board

Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/mpc8572ds.dts |  113 +++++++++++++++++++++++++++++++++++
 1 files changed, 113 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8572ds.dts b/arch/powerpc/boot/dts/mpc8572ds.dts
index 4d374ce..13de3f7 100644
--- a/arch/powerpc/boot/dts/mpc8572ds.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds.dts
@@ -64,6 +64,119 @@
 		reg = <0x0 0x0>;	// Filled by U-Boot
 	};
 
+	localbus@ffe05000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8572-elbc", "fsl,elbc", "simple-bus";
+		reg = <0xffe05000 0x1000>;
+		interrupts = <19 2>;
+		interrupt-parent = <&mpic>;
+
+		ranges = <0x0 0x0 0xe8000000 0x08000000
+			  0x1 0x0 0xe0000000 0x08000000
+			  0x2 0x0 0xffa00000 0x00040000
+			  0x3 0x0 0xffdf0000 0x00008000
+			  0x4 0x0 0xffa40000 0x00040000
+			  0x5 0x0 0xffa80000 0x00040000
+			  0x6 0x0 0xffac0000 0x00040000>;
+
+		nor@0,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "cfi-flash";
+			reg = <0x0 0x0 0x8000000>;
+			bank-width = <2>;
+			device-width = <1>;
+
+			ramdisk@0 {
+				reg = <0x0 0x03000000>;
+				readl-only;
+			};
+
+			diagnostic@3000000 {
+				reg = <0x03000000 0x00e00000>;
+				read-only;
+			};
+
+			dink@3e00000 {
+				reg = <0x03e00000 0x00200000>;
+				read-only;
+			};
+
+			kernel@4000000 {
+				reg = <0x04000000 0x00400000>;
+				read-only;
+			};
+
+			jffs2@4400000 {
+				reg = <0x04400000 0x03b00000>;
+			};
+
+			dtb@7f00000 {
+				reg = <0x07f00000 0x00080000>;
+				read-only;
+			};
+
+			u-boot@7f80000 {
+				reg = <0x07f80000 0x00080000>;
+				read-only;
+			};
+		};
+
+		nand@2,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8572-fcm-nand",
+				     "fsl,elbc-fcm-nand";
+			reg = <0x2 0x0 0x40000>;
+
+			u-boot@0 {
+				reg = <0x0 0x02000000>;
+				read-only;
+			};
+
+			jffs2@2000000 {
+				reg = <0x02000000 0x10000000>;
+			};
+
+			ramdisk@12000000 {
+				reg = <0x12000000 0x08000000>;
+				read-only;
+			};
+
+			kernel@1a000000 {
+				reg = <0x1a000000 0x04000000>;
+			};
+
+			dtb@1e000000 {
+				reg = <0x1e000000 0x01000000>;
+				read-only;
+			};
+
+			empty@1f000000 {
+				reg = <0x1f000000 0x21000000>;
+			};
+		};
+
+		nand@4,0 {
+			compatible = "fsl,mpc8572-fcm-nand",
+				     "fsl,elbc-fcm-nand";
+			reg = <0x4 0x0 0x40000>;
+		};
+
+		nand@5,0 {
+			compatible = "fsl,mpc8572-fcm-nand",
+				     "fsl,elbc-fcm-nand";
+			reg = <0x5 0x0 0x40000>;
+		};
+
+		nand@6,0 {
+			compatible = "fsl,mpc8572-fcm-nand",
+				     "fsl,elbc-fcm-nand";
+			reg = <0x6 0x0 0x40000>;
+		};
+	};
+
 	soc8572@ffe00000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.5.6.5
