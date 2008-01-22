Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 9BEBCDDE9F
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 04:04:09 +1100 (EST)
Subject: [PATCH 1/2] Add flash node to mpc8641_hpcn.dts
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 22 Jan 2008 09:38:37 -0700
Message-Id: <1201019917.5716.154.camel@rhino>
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

Add flash and partition information to mpc8641_hpcn.dts

Signed-off-by: Wade Farnsworth <wfarnsworth@mvista.com>

---
 arch/powerpc/boot/dts/mpc8641_hpcn.dts |   27 +++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 
diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index a719179..679e857 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -457,4 +457,31 @@
 				  0 00100000>;
 		};
 	};
+
+	flash@ff800000 {
+		compatible = "cfi-flash";
+		reg = <ff800000 00800000>;
+		bank-width = <2>;
+		device-width = <2>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		partition@0 {
+			label = "kernel";
+			reg = <00000000 00300000>;
+		};
+		partition@300000 {
+			label = "firmware b";
+			reg = <00300000 00100000>;
+			read-only;
+		};
+		partition@400000 {
+			label = "fs";
+			reg = <00400000 00300000>;
+		};
+		partition@700000 {
+			label = "firmware a";
+			reg = <00700000 00100000>;
+			read-only;
+		};
+	};
 };
