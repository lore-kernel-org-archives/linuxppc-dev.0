Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 2EEE5DDF7F
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Apr 2008 04:01:43 +1000 (EST)
Date: Sat, 12 Apr 2008 14:01:40 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/5] Boot code
Message-ID: <20080412140140.6c75cee5@lappy.seanm.ca>
In-Reply-To: <20080412134831.424480cf@lappy.seanm.ca>
References: <20080412134831.424480cf@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>

diff --git a/arch/powerpc/boot/cuboot-warp.c
b/arch/powerpc/boot/cuboot-warp.c index eb108a8..43d7ad9 100644
--- a/arch/powerpc/boot/cuboot-warp.c
+++ b/arch/powerpc/boot/cuboot-warp.c
@@ -10,6 +10,7 @@
 #include "ops.h"
 #include "4xx.h"
 #include "cuboot.h"
+#include "stdio.h"
 
 #define TARGET_4xx
 #define TARGET_44x
@@ -17,14 +18,54 @@
 
 static bd_t bd;
 
-static void warp_fixups(void)
+static void warp_fixup_one_nor(u32 from, u32 to)
 {
-	unsigned long sysclk = 66000000;
+	void *devp;
+	char name[40];
+	u32 v[2];
+
+	sprintf(name, "/plb/opb/ebc/nor_flash@0,0/partition@%x", from);
+
+	devp = finddevice(name);
+	if (!devp)
+		return;
+
+	if (getprop(devp, "reg", v, sizeof(v)) == sizeof(v)) {
+		v[0] = to;
+		setprop(devp, "reg", v, sizeof(v));
+
+		printf("NOR 64M fixup %x -> %x\r\n", from, to);
+	}
+}
+
 
-	ibm440ep_fixup_clocks(sysclk, 11059200, 50000000);
+static void warp_fixups(void)
+{
+	ibm440ep_fixup_clocks(66000000, 11059200, 50000000);
 	ibm4xx_sdram_fixup_memsize();
 	ibm4xx_fixup_ebc_ranges("/plb/opb/ebc");
 	dt_fixup_mac_address_by_alias("ethernet0", bd.bi_enetaddr);
+
+	/* Fixup for 64M flash on Rev A boards. */
+	if (bd.bi_flashsize == 0x4000000) {
+		void *devp;
+		u32 v[3];
+
+		devp = finddevice("/plb/opb/ebc/nor_flash@0,0");
+		if (!devp)
+			return;
+
+		/* Fixup the size */
+		if (getprop(devp, "reg", v, sizeof(v)) == sizeof(v)) {
+			v[2] = bd.bi_flashsize;
+			setprop(devp, "reg", v, sizeof(v));
+		}
+
+		/* Fixup parition offsets */
+		warp_fixup_one_nor(0x300000, 0x3f00000);
+		warp_fixup_one_nor(0x340000, 0x3f40000);
+		warp_fixup_one_nor(0x380000, 0x3f80000);
+	}
 }
 
 
diff --git a/arch/powerpc/boot/dts/warp.dts
b/arch/powerpc/boot/dts/warp.dts index b04a52e..fa070b0 100644
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
-					compatible = "amd,s29gl512n",
"cfi-flash";
+					compatible = "amd,s29gl032a",
"cfi-flash"; bank-width = <2>;
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
@@ -186,6 +179,16 @@
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
