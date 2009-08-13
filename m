Return-Path: <sr@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 52996B6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 14 Aug 2009 00:31:17 +1000 (EST)
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.182])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 80D25DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2009 00:31:14 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] powerpc/44x: Update Arches dts
Date: Thu, 13 Aug 2009 16:30:44 +0200
Message-Id: <1250173844-20692-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds some nodes to the AMCC Arches dts:

- L2 cache support
- NOR FLASH mapping with default partitioning
- I2C HWMON device (AD7414)

Signed-off-by: Stefan Roese <sr@denx.de>
---
 arch/powerpc/boot/dts/arches.dts |   50 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/arches.dts b/arch/powerpc/boot/dts/arches.dts
index d9113b1..414ef8b 100644
--- a/arch/powerpc/boot/dts/arches.dts
+++ b/arch/powerpc/boot/dts/arches.dts
@@ -124,6 +124,16 @@
 		dcr-reg = <0x00c 0x002>;
 	};
 
+	L2C0: l2c {
+		compatible = "ibm,l2-cache-460gt", "ibm,l2-cache";
+		dcr-reg = <0x020 0x008		/* Internal SRAM DCR's */
+			   0x030 0x008>;	/* L2 cache DCR's */
+		cache-line-size = <32>;		/* 32 bytes */
+		cache-size = <262144>;		/* L2, 256K */
+		interrupt-parent = <&UIC1>;
+		interrupts = <11 1>;
+	};
+
 	plb {
 		compatible = "ibm,plb-460gt", "ibm,plb4";
 		#address-cells = <2>;
@@ -168,6 +178,38 @@
 				/* ranges property is supplied by U-Boot */
 				interrupts = <0x6 0x4>;
 				interrupt-parent = <&UIC1>;
+
+				nor_flash@0,0 {
+					compatible = "amd,s29gl256n", "cfi-flash";
+					bank-width = <2>;
+					reg = <0x00000000 0x00000000 0x02000000>;
+					#address-cells = <1>;
+					#size-cells = <1>;
+					partition@0 {
+						label = "kernel";
+						reg = <0x00000000 0x001e0000>;
+					};
+					partition@1e0000 {
+						label = "dtb";
+						reg = <0x001e0000 0x00020000>;
+					};
+					partition@200000 {
+						label = "root";
+						reg = <0x00200000 0x00200000>;
+					};
+					partition@400000 {
+						label = "user";
+						reg = <0x00400000 0x01b60000>;
+					};
+					partition@1f60000 {
+						label = "env";
+						reg = <0x01f60000 0x00040000>;
+					};
+					partition@1fa0000 {
+						label = "u-boot";
+						reg = <0x01fa0000 0x00060000>;
+					};
+				};
 			};
 
 			UART0: serial@ef600300 {
@@ -186,6 +228,14 @@
 				reg = <0xef600700 0x00000014>;
 				interrupt-parent = <&UIC0>;
 				interrupts = <0x2 0x4>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				sttm@4a {
+					compatible = "ad,ad7414";
+					reg = <0x4a>;
+					interrupt-parent = <&UIC1>;
+					interrupts = <0x0 0x8>;
+				};
 			};
 
 			IIC1: i2c@ef600800 {
-- 
1.6.3.4
