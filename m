Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 84E86DDF19
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 02:27:51 +1000 (EST)
Received: from [10.50.1.88] (rhino.az.mvista.com [10.50.1.88])
	by hermes.mvista.com (Postfix) with ESMTP id 9C67E1CF56
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 09:27:50 -0700 (PDT)
Subject: [PATCH 2/5] Add legacy devices to mpc8641_hpcn.dts
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
In-Reply-To: <1179245829.8132.100.camel@rhino>
References: <1179245829.8132.100.camel@rhino>
Content-Type: text/plain
Date: Tue, 15 May 2007 09:27:50 -0700
Message-Id: <1179246470.8132.112.camel@rhino>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds device nodes for the ISA devices on the MPC8641 HPCN to the
dts.  Additionally, it moves the node for the i8259 to the isa bus,
since the i8259 is actually on that bus.


Signed-off-by: Wade Farnsworth <wfarnsworth@mvista.com>

---

 arch/powerpc/boot/dts/mpc8641_hpcn.dts |   48 ++++++++++++++++++-----
 1 file changed, 38 insertions(+), 10 deletions(-)

Index: linux-2.6-8641/arch/powerpc/boot/dts/mpc8641_hpcn.dts
===================================================================
--- linux-2.6-8641.orig/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ linux-2.6-8641/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -285,17 +285,45 @@
 				f800 0 0 3 &i8259 0 0
 				f800 0 0 4 &i8259 0 0
 				>;
-			i8259: i8259@4d0 {
-				clock-frequency = <0>;
-				interrupt-controller;
-				device_type = "interrupt-controller";
-				#address-cells = <0>;
+
+			isa@f0 {
+				device_type = "isa";
 				#interrupt-cells = <2>;
-				built-in;
-				compatible = "chrp,iic";
-                	        big-endian;
-				interrupts = <49 2>;
-				interrupt-parent = <&mpic>;
+				#size-cells = <1>;
+				#address-cells = <2>;
+				reg = <f000 0 0 0 0>;
+				ranges = <1 0 01000000 0 0 00001000>;
+				interrupt-parent = <4d0>;
+
+				8042@60 {
+					device_type = "8042";
+					reg = <1 60 1 1 64 1>;
+					interrupts = <1 3 c 3>;
+					interrupt-parent = <4d0>;
+				};
+
+				rtc@70 {
+					device_type = "rtc";
+					reg = <1 70 2>;
+				};
+
+				gpio@400 {
+					device_type = "gpio";
+					reg = <1 400 80>;
+				};
+
+				i8259: i8259@4d0 {
+					clock-frequency = <0>;
+					interrupt-controller;
+					device_type = "interrupt-controller";
+					#address-cells = <0>;
+					#interrupt-cells = <2>;
+					built-in;
+					compatible = "chrp,iic";
+                	        	big-endian;
+					interrupts = <49 2>;
+					interrupt-parent = <&mpic>;
+				};
 			};
 
 		};
