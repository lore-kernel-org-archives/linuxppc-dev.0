Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id C3671DDEEE
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 11:50:31 +1000 (EST)
Date: Mon, 28 Apr 2008 21:50:29 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [RESEND][PATCH 2/2][POWERPC] PIKA Warp: Update platform code to
	supportRev B boards
Message-ID: <20080428215029.0e38a0d2@lappy.seanm.ca>
In-Reply-To: <20080428214711.240419c3@lappy.seanm.ca>
References: <20080417152251.2bf07219@lappy.seanm.ca>
	<20080428214711.240419c3@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

diff --git a/arch/powerpc/boot/dts/warp.dts b/arch/powerpc/boot/dts/warp.dts
index b04a52e..3e95e99 100644
--- a/arch/powerpc/boot/dts/warp.dts
+++ b/arch/powerpc/boot/dts/warp.dts
@@ -132,40 +132,33 @@
 
 				fpga@2,0 {
 					compatible = "pika,fpga";
-			   		reg = <2 0 2200>;
+			   		reg = <2 0 1000>;
 					interrupts = <18 8>;
 					interrupt-parent = <&UIC0>;
 				};
 
+				fpga@2,4000 {
+					compatible = "pika,fpga-sd";
+					reg = <2 4000 A00>;
+				};
+
 				nor_flash@0,0 {
-					compatible = "amd,s29gl512n", "cfi-flash";
+					compatible = "amd,s29gl032a", "cfi-flash";
 					bank-width = <2>;
-					reg = <0 0 4000000>;
+					reg = <0 0 400000>;
 					#address-cells = <1>;
 					#size-cells = <1>;
-					partition@0 {
-						label = "kernel";
-						reg = <0 180000>;
-					};
-					partition@180000 {
-						label = "root";
-						reg = <180000 3480000>;
-					};
-					partition@3600000 {
-						label = "user";
-						reg = <3600000 900000>;
-					};
-					partition@3f00000 {
+					partition@300000 {
 						label = "fpga";
-						reg = <3f00000 40000>;
+						reg = <300000 40000>;
 					};
-					partition@3f40000 {
+					partition@340000 {
 						label = "env";
-						reg = <3f40000 40000>;
+						reg = <340000 40000>;
 					};
-					partition@3f80000 {
+					partition@380000 {
 						label = "u-boot";
-						reg = <3f80000 80000>;
+						reg = <380000 80000>;
 					};
 				};
 			};
@@ -186,18 +179,45 @@
 				reg = <ef600700 14>;
 				interrupt-parent = <&UIC0>;
 				interrupts = <2 4>;
+				index = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				ad7414@4a {
+					compatible = "adi,ad7414";
+					reg = <4a>;
+					interrupts = <19 8>;
+					interrupt-parent = <&UIC0>;
+				};
 			};
 
 			GPIO0: gpio@ef600b00 {
 				compatible = "ibm,gpio-440ep";
 				reg = <ef600b00 48>;
+				#gpio-cells = <2>;
+				gpio-controller;
 			};
 
 			GPIO1: gpio@ef600c00 {
 				compatible = "ibm,gpio-440ep";
 				reg = <ef600c00 48>;
+				#gpio-cells = <2>;
+				gpio-controller;
+
+				led@31 {
+					compatible = "linux,gpio-led";
+					linux,name = ":green:";
+					gpios = <&GPIO1 31>;
+				};		
+	
+				led@30 {	
+					compatible = "linux,gpio-led";
+					linux,name = ":red:";
+					gpios = <&GPIO1 30>;
+				};
 			};
 
+
 			ZMII0: emac-zmii@ef600d00 {
 				compatible = "ibm,zmii-440ep", "ibm,zmii-440gp", "ibm,zmii";
 				reg = <ef600d00 c>;
