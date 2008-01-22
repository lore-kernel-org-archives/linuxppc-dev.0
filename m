Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id C651FDDEA3
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 07:13:41 +1100 (EST)
Subject: [PATCH v2 1/2] Add localbus and flash nodes to mpc8641_hpcn.dts
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1201019917.5716.154.camel@rhino>
References: <1201019917.5716.154.camel@rhino>
Content-Type: text/plain
Date: Tue, 22 Jan 2008 13:13:39 -0700
Message-Id: <1201032819.5716.170.camel@rhino>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add local bus, flash, and MTD partition nodes to mpc8641_hpcn.dts

Also add compatible field for the soc node, so that it will be picked up
by of_platform_bus_probe().

Signed-off-by: Wade Farnsworth <wfarnsworth@mvista.com>

---
Updated per Kumar's comments.

 arch/powerpc/boot/dts/mpc8641_hpcn.dts |   42 +++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index a719179..556a9ca 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -60,10 +60,52 @@
 		reg = <00000000 40000000>;	// 1G at 0x0
 	};
 
+	localbus@f8005000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8641-localbus", "simple-bus";
+		reg = <f8005000 1000>;
+		interrupts = <13 2>;
+		interrupt-parent = <&mpic>;
+
+		ranges = <0 0 ff800000 00800000
+			  1 0 fe000000 01000000
+			  2 0 f8200000 00100000
+			  3 0 f8100000 00100000>;
+
+		flash@0,0 {
+			compatible = "cfi-flash";
+			reg = <0 0 00800000>;
+			bank-width = <2>;
+			device-width = <2>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition@0 {
+				label = "kernel";
+				reg = <00000000 00300000>;
+			};
+			partition@300000 {
+				label = "firmware b";
+				reg = <00300000 00100000>;
+				read-only;
+			};
+			partition@400000 {
+				label = "fs";
+				reg = <00400000 00300000>;
+			};
+			partition@700000 {
+				label = "firmware a";
+				reg = <00700000 00100000>;
+				read-only;
+			};
+		};
+	};
+
 	soc8641@f8000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
+		compatible = "simple-bus";
 		ranges = <00000000 f8000000 00100000>;
 		reg = <f8000000 00001000>;	// CCSRBAR
 		bus-frequency = <0>;
