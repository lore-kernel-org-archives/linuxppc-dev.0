Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AF6F7DE413
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 02:52:56 +1000 (EST)
Date: Fri, 27 Jun 2008 11:52:43 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH v2] update crypto node definition and device tree instances
Message-Id: <20080627115243.d76e0814.kim.phillips@freescale.com>
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

delete obsolete device-type property, delete model property
(use compatible property instead), prepend "fsl," to Freescale
specific properties. Add nodes to device trees that are missing them,
and fix broken property values in other trees.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
changes from v1: b-w-of.txt:

-    - compatible : Should contain entries for all compatible SEC versions,
-      high to low, e.g., "fsl,sec2.1", "fsl,sec2.0"
+    - compatible : Should contain entries for this and backward compatible
+      SEC versions, high to low, e.g., "fsl,sec2.1", "fsl,sec2.0"

 Documentation/powerpc/booting-without-of.txt |   51 +++++++++++++-------------
 arch/powerpc/boot/dts/mpc8272ads.dts         |   21 ++++-------
 arch/powerpc/boot/dts/mpc8313erdb.dts        |   15 +++-----
 arch/powerpc/boot/dts/mpc8315erdb.dts        |   15 ++++----
 arch/powerpc/boot/dts/mpc832x_mds.dts        |   15 +++-----
 arch/powerpc/boot/dts/mpc832x_rdb.dts        |   15 +++-----
 arch/powerpc/boot/dts/mpc8349emitx.dts       |   12 +++----
 arch/powerpc/boot/dts/mpc8349emitxgp.dts     |   12 +++----
 arch/powerpc/boot/dts/mpc834x_mds.dts        |   15 +++-----
 arch/powerpc/boot/dts/mpc836x_mds.dts        |   13 +++----
 arch/powerpc/boot/dts/mpc8377_mds.dts        |   13 +++----
 arch/powerpc/boot/dts/mpc8377_rdb.dts        |   14 +++----
 arch/powerpc/boot/dts/mpc8378_mds.dts        |   13 +++----
 arch/powerpc/boot/dts/mpc8378_rdb.dts        |   14 +++----
 arch/powerpc/boot/dts/mpc8379_mds.dts        |   13 +++----
 arch/powerpc/boot/dts/mpc8379_rdb.dts        |   14 +++----
 arch/powerpc/boot/dts/mpc8541cds.dts         |   11 ++++++
 arch/powerpc/boot/dts/mpc8544ds.dts          |   11 ++++++
 arch/powerpc/boot/dts/mpc8548cds.dts         |   11 ++++++
 arch/powerpc/boot/dts/mpc8555cds.dts         |   11 ++++++
 arch/powerpc/boot/dts/mpc8568mds.dts         |   14 +++----
 arch/powerpc/boot/dts/mpc8572ds.dts          |   12 ++++++
 arch/powerpc/boot/dts/sbc8349.dts            |   14 +++-----
 arch/powerpc/boot/dts/sbc8548.dts            |   11 ++++++
 arch/powerpc/boot/dts/tqm8541.dts            |   11 ++++++
 arch/powerpc/boot/dts/tqm8555.dts            |   11 ++++++
 26 files changed, 213 insertions(+), 169 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index b68684d..196e694 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1472,9 +1472,8 @@ platforms are moved over to use the flattened-device-tree model.
 
    Required properties:
 
-    - device_type : Should be "crypto"
-    - model : Model of the device.  Should be "SEC1" or "SEC2"
-    - compatible : Should be "talitos"
+    - compatible : Should contain entries for this and backward compatible
+      SEC versions, high to low, e.g., "fsl,sec2.1", "fsl,sec2.0"
     - reg : Offset and length of the register set for the device
     - interrupts : <a b> where a is the interrupt number and b is a
       field that represents an encoding of the sense and level
@@ -1483,27 +1482,29 @@ platforms are moved over to use the flattened-device-tree model.
       controller you have.
     - interrupt-parent : the phandle for the interrupt controller that
       services interrupts for this device.
-    - num-channels : An integer representing the number of channels
+    - fsl,num-channels : An integer representing the number of channels
       available.
-    - channel-fifo-len : An integer representing the number of
+    - fsl,channel-fifo-len : An integer representing the number of
       descriptor pointers each channel fetch fifo can hold.
-    - exec-units-mask : The bitmask representing what execution units
+    - fsl,exec-units-mask : The bitmask representing what execution units
       (EUs) are available. It's a single 32-bit cell. EU information
       should be encoded following the SEC's Descriptor Header Dword
       EU_SEL0 field documentation, i.e. as follows:
 
-        bit 0 = reserved - should be 0
-        bit 1 = set if SEC has the ARC4 EU (AFEU)
-        bit 2 = set if SEC has the DES/3DES EU (DEU)
-        bit 3 = set if SEC has the message digest EU (MDEU)
-        bit 4 = set if SEC has the random number generator EU (RNG)
-        bit 5 = set if SEC has the public key EU (PKEU)
-        bit 6 = set if SEC has the AES EU (AESU)
-        bit 7 = set if SEC has the Kasumi EU (KEU)
+        bit 0  = reserved - should be 0
+        bit 1  = set if SEC has the ARC4 EU (AFEU)
+        bit 2  = set if SEC has the DES/3DES EU (DEU)
+        bit 3  = set if SEC has the message digest EU (MDEU/MDEU-A)
+        bit 4  = set if SEC has the random number generator EU (RNG)
+        bit 5  = set if SEC has the public key EU (PKEU)
+        bit 6  = set if SEC has the AES EU (AESU)
+        bit 7  = set if SEC has the Kasumi EU (KEU)
+        bit 8  = set if SEC has the CRC EU (CRCU)
+        bit 11 = set if SEC has the message digest EU extended alg set (MDEU-B)
 
-      bits 8 through 31 are reserved for future SEC EUs.
+      remaining bits are reserved for future SEC EUs.
 
-    - descriptor-types-mask : The bitmask representing what descriptors
+    - fsl,descriptor-types-mask : The bitmask representing what descriptors
       are available. It's a single 32-bit cell. Descriptor type
       information should be encoded following the SEC's Descriptor
       Header Dword DESC_TYPE field documentation, i.e. as follows:
@@ -1527,16 +1528,14 @@ platforms are moved over to use the flattened-device-tree model.
 
        /* MPC8548E */
        crypto@30000 {
-               device_type = "crypto";
-               model = "SEC2";
-               compatible = "talitos";
-               reg = <30000 10000>;
-               interrupts = <1d 3>;
-               interrupt-parent = <40000>;
-               num-channels = <4>;
-               channel-fifo-len = <18>;
-               exec-units-mask = <000000fe>;
-               descriptor-types-mask = <012b0ebf>;
+               compatible = "fsl,sec2.1", "fsl,sec2.0";
+               reg = <0x30000 0x10000>;
+               interrupts = <29 2>;
+               interrupt-parent = <&mpic>;
+               fsl,num-channels = <4>;
+               fsl,channel-fifo-len = <24>;
+               fsl,exec-units-mask = <0xfe>;
+               fsl,descriptor-types-mask = <0x12b0ebf>;
        };
 
    h) Board Control and Status (BCSR)
diff --git a/arch/powerpc/boot/dts/mpc8272ads.dts b/arch/powerpc/boot/dts/mpc8272ads.dts
index 46e2da3..9a3881d 100644
--- a/arch/powerpc/boot/dts/mpc8272ads.dts
+++ b/arch/powerpc/boot/dts/mpc8272ads.dts
@@ -226,22 +226,15 @@
 			compatible = "fsl,mpc8272-pic", "fsl,cpm2-pic";
 		};
 
-/* May need to remove if on a part without crypto engine */
 		crypto@30000 {
-			device_type = "crypto";
-			model = "SEC2";
-			compatible = "fsl,mpc8272-talitos-sec2",
-			             "fsl,talitos-sec2",
-			             "fsl,talitos",
-			             "talitos";
-			reg = <0x30000 0x10000>;
-			interrupts = <11 8>;
+			compatible = "fsl,sec1.0";
+			reg = <0x40000 0x13000>;
+			interrupts = <47 0x8>;
 			interrupt-parent = <&PIC>;
-			num-channels = <4>;
-			channel-fifo-len = <24>;
-			exec-units-mask = <0x7e>;
-/* desc mask is for rev1.x, we need runtime fixup for >=2.x */
-			descriptor-types-mask = <0x1010ebf>;
+			fsl,num-channels = <4>;
+			fsl,channel-fifo-len = <24>;
+			fsl,exec-units-mask = <0x7e>;
+			fsl,descriptor-types-mask = <0x1010415>;
 		};
 	};
 
diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
index e1f0dca..03edb86 100644
--- a/arch/powerpc/boot/dts/mpc8313erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
@@ -219,17 +219,14 @@
 		};
 
 		crypto@30000 {
-			device_type = "crypto";
-			model = "SEC2";
-			compatible = "talitos";
-			reg = <0x30000 0x7000>;
+			compatible = "fsl,sec2.2", "fsl,sec2.1", "fsl,sec2.0";
+			reg = <0x30000 0x10000>;
 			interrupts = <11 0x8>;
 			interrupt-parent = <&ipic>;
-			/* Rev. 2.2 */
-			num-channels = <1>;
-			channel-fifo-len = <24>;
-			exec-units-mask = <0x0000004c>;
-			descriptor-types-mask = <0x0122003f>;
+			fsl,num-channels = <1>;
+			fsl,channel-fifo-len = <24>;
+			fsl,exec-units-mask = <0x4c>;
+			fsl,descriptor-types-mask = <0x0122003f>;
 		};
 
 		/* IPIC
diff --git a/arch/powerpc/boot/dts/mpc8315erdb.dts b/arch/powerpc/boot/dts/mpc8315erdb.dts
index d7a1ece..e433303 100644
--- a/arch/powerpc/boot/dts/mpc8315erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8315erdb.dts
@@ -206,17 +206,16 @@
 		};
 
 		crypto@30000 {
-			model = "SEC3";
-			device_type = "crypto";
-			compatible = "talitos";
+			compatible = "fsl,sec3.3", "fsl,sec3.1", "fsl,sec3.0",
+				     "fsl,sec2.4", "fsl,sec2.2", "fsl,sec2.1",
+				     "fsl,sec2.0";
 			reg = <0x30000 0x10000>;
 			interrupts = <11 0x8>;
 			interrupt-parent = <&ipic>;
-			/* Rev. 3.0 geometry */
-			num-channels = <4>;
-			channel-fifo-len = <24>;
-			exec-units-mask = <0x000001fe>;
-			descriptor-types-mask = <0x03ab0ebf>;
+			fsl,num-channels = <4>;
+			fsl,channel-fifo-len = <24>;
+			fsl,exec-units-mask = <0x97c>;
+			fsl,descriptor-types-mask = <0x3ab0abf>;
 		};
 
 		sata@18000 {
diff --git a/arch/powerpc/boot/dts/mpc832x_mds.dts b/arch/powerpc/boot/dts/mpc832x_mds.dts
index 539e02f..5462845 100644
--- a/arch/powerpc/boot/dts/mpc832x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
@@ -115,17 +115,14 @@
 		};
 
 		crypto@30000 {
-			device_type = "crypto";
-			model = "SEC2";
-			compatible = "talitos";
-			reg = <0x30000 0x7000>;
+			compatible = "fsl,sec2.2", "fsl,sec2.1", "fsl,sec2.0";
+			reg = <0x30000 0x10000>;
 			interrupts = <11 0x8>;
 			interrupt-parent = <&ipic>;
-			/* Rev. 2.2 */
-			num-channels = <1>;
-			channel-fifo-len = <24>;
-			exec-units-mask = <0x0000004c>;
-			descriptor-types-mask = <0x0122003f>;
+			fsl,num-channels = <1>;
+			fsl,channel-fifo-len = <24>;
+			fsl,exec-units-mask = <0x4c>;
+			fsl,descriptor-types-mask = <0x0122003f>;
 		};
 
 		ipic: pic@700 {
diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
index 179c81c..7fb50ab 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -93,17 +93,14 @@
 		};
 
 		crypto@30000 {
-			device_type = "crypto";
-			model = "SEC2";
-			compatible = "talitos";
-			reg = <0x30000 0x7000>;
+			compatible = "fsl,sec2.2", "fsl,sec2.1", "fsl,sec2.0";
+			reg = <0x30000 0x10000>;
 			interrupts = <11 0x8>;
 			interrupt-parent = <&pic>;
-			/* Rev. 2.2 */
-			num-channels = <1>;
-			channel-fifo-len = <24>;
-			exec-units-mask = <0x0000004c>;
-			descriptor-types-mask = <0x0122003f>;
+			fsl,num-channels = <1>;
+			fsl,channel-fifo-len = <24>;
+			fsl,exec-units-mask = <0x4c>;
+			fsl,descriptor-types-mask = <0x0122003f>;
 		};
 
 		pic:pic@700 {
diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index 9426676..f7a850c 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -178,16 +178,14 @@
 		};
 
 		crypto@30000 {
-			device_type = "crypto";
-			model = "SEC2";
-			compatible = "talitos";
+			compatible = "fsl,sec2.0";
 			reg = <0x30000 0x10000>;
 			interrupts = <11 0x8>;
 			interrupt-parent = <&ipic>;
-			num-channels = <4>;
-			channel-fifo-len = <24>;
-			exec-units-mask = <0x0000007e>;
-			descriptor-types-mask = <0x01010ebf>;
+			fsl,num-channels = <4>;
+			fsl,channel-fifo-len = <24>;
+			fsl,exec-units-mask = <0x7e>;
+			fsl,descriptor-types-mask = <0x01010ebf>;
 		};
 
 		ipic: pic@700 {
diff --git a/arch/powerpc/boot/dts/mpc8349emitxgp.dts b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
index f81d735..b866b47 100644
--- a/arch/powerpc/boot/dts/mpc8349emitxgp.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
@@ -151,16 +151,14 @@
 		};
 
 		crypto@30000 {
-			device_type = "crypto";
-			model = "SEC2";
-			compatible = "talitos";
+			compatible = "fsl,sec2.0";
 			reg = <0x30000 0x10000>;
 			interrupts = <11 0x8>;
 			interrupt-parent = <&ipic>;
-			num-channels = <4>;
-			channel-fifo-len = <24>;
-			exec-units-mask = <0x0000007e>;
-			descriptor-types-mask = <0x01010ebf>;
+			fsl,num-channels = <4>;
+			fsl,channel-fifo-len = <24>;
+			fsl,exec-units-mask = <0x7e>;
+			fsl,descriptor-types-mask = <0x01010ebf>;
 		};
 
 		ipic: pic@700 {
diff --git a/arch/powerpc/boot/dts/mpc834x_mds.dts b/arch/powerpc/boot/dts/mpc834x_mds.dts
index 0199c5c..e0d0753 100644
--- a/arch/powerpc/boot/dts/mpc834x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc834x_mds.dts
@@ -193,20 +193,15 @@
 			interrupt-parent = <&ipic>;
 		};
 
-		/* May need to remove if on a part without crypto engine */
 		crypto@30000 {
-			device_type = "crypto";
-			model = "SEC2";
-			compatible = "talitos";
+			compatible = "fsl,sec2.0";
 			reg = <0x30000 0x10000>;
 			interrupts = <11 0x8>;
 			interrupt-parent = <&ipic>;
-			num-channels = <4>;
-			channel-fifo-len = <24>;
-			exec-units-mask = <0x0000007e>;
-			/* desc mask is for rev2.0,
-			 * we need runtime fixup for >2.0 */
-			descriptor-types-mask = <0x01010ebf>;
+			fsl,num-channels = <4>;
+			fsl,channel-fifo-len = <24>;
+			fsl,exec-units-mask = <0x7e>;
+			fsl,descriptor-types-mask = <0x01010ebf>;
 		};
 
 		/* IPIC
diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
index 8160ff2..69e6564 100644
--- a/arch/powerpc/boot/dts/mpc836x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
@@ -119,17 +119,14 @@
 		};
 
 		crypto@30000 {
-			device_type = "crypto";
-			model = "SEC2";
-			compatible = "talitos";
+			compatible = "fsl,sec2.0";
 			reg = <0x30000 0x10000>;
 			interrupts = <11 0x8>;
 			interrupt-parent = <&ipic>;
-			num-channels = <4>;
-			channel-fifo-len = <24>;
-			exec-units-mask = <0x0000007e>;
-			/* desc mask is for rev1.x, we need runtime fixup for >=2.x */
-			descriptor-types-mask = <0x01010ebf>;
+			fsl,num-channels = <4>;
+			fsl,channel-fifo-len = <24>;
+			fsl,exec-units-mask = <0x7e>;
+			fsl,descriptor-types-mask = <0x01010ebf>;
 		};
 
 		ipic: pic@700 {
diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts b/arch/powerpc/boot/dts/mpc8377_mds.dts
index fea5925..76149b7 100644
--- a/arch/powerpc/boot/dts/mpc8377_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8377_mds.dts
@@ -234,16 +234,15 @@
 		};
 
 		crypto@30000 {
-			model = "SEC3";
-			compatible = "talitos";
+			compatible = "fsl,sec3.0", "fsl,sec2.4", "fsl,sec2.2",
+				     "fsl,sec2.1", "fsl,sec2.0";
 			reg = <0x30000 0x10000>;
 			interrupts = <11 0x8>;
 			interrupt-parent = <&ipic>;
-			/* Rev. 3.0 geometry */
-			num-channels = <4>;
-			channel-fifo-len = <24>;
-			exec-units-mask = <0x000001fe>;
-			descriptor-types-mask = <0x03ab0ebf>;
+			fsl,num-channels = <4>;
+			fsl,channel-fifo-len = <24>;
+			fsl,exec-units-mask = <0x9fe>;
+			fsl,descriptor-types-mask = <0x3ab0ebf>;
 		};
 
 		sdhc@2e000 {
diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts b/arch/powerpc/boot/dts/mpc8377_rdb.dts
index 5bc09ad..58d2472 100644
--- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
@@ -219,17 +219,15 @@
 		};
 
 		crypto@30000 {
-			model = "SEC3";
-			device_type = "crypto";
-			compatible = "talitos";
+			compatible = "fsl,sec3.0", "fsl,sec2.4", "fsl,sec2.2",
+				     "fsl,sec2.1", "fsl,sec2.0";
 			reg = <0x30000 0x10000>;
 			interrupts = <11 0x8>;
 			interrupt-parent = <&ipic>;
-			/* Rev. 3.0 geometry */
-			num-channels = <4>;
-			channel-fifo-len = <24>;
-			exec-units-mask = <0x000001fe>;
-			descriptor-types-mask = <0x03ab0ebf>;
+			fsl,num-channels = <4>;
+			fsl,channel-fifo-len = <24>;
+			fsl,exec-units-mask = <0x9fe>;
+			fsl,descriptor-types-mask = <0x3ab0ebf>;
 		};
 
 		sata@18000 {
diff --git a/arch/powerpc/boot/dts/mpc8378_mds.dts b/arch/powerpc/boot/dts/mpc8378_mds.dts
index 1d6ea08..07a69a6 100644
--- a/arch/powerpc/boot/dts/mpc8378_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8378_mds.dts
@@ -234,16 +234,15 @@
 		};
 
 		crypto@30000 {
-			model = "SEC3";
-			compatible = "talitos";
+			compatible = "fsl,sec3.0", "fsl,sec2.4", "fsl,sec2.2",
+				     "fsl,sec2.1", "fsl,sec2.0";
 			reg = <0x30000 0x10000>;
 			interrupts = <11 0x8>;
 			interrupt-parent = <&ipic>;
-			/* Rev. 3.0 geometry */
-			num-channels = <4>;
-			channel-fifo-len = <24>;
-			exec-units-mask = <0x000001fe>;
-			descriptor-types-mask = <0x03ab0ebf>;
+			fsl,num-channels = <4>;
+			fsl,channel-fifo-len = <24>;
+			fsl,exec-units-mask = <0x9fe>;
+			fsl,descriptor-types-mask = <0x3ab0ebf>;
 		};
 
 		sdhc@2e000 {
diff --git a/arch/powerpc/boot/dts/mpc8378_rdb.dts b/arch/powerpc/boot/dts/mpc8378_rdb.dts
index 711f9a3..6f845d3 100644
--- a/arch/powerpc/boot/dts/mpc8378_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8378_rdb.dts
@@ -219,17 +219,15 @@
 		};
 
 		crypto@30000 {
-			model = "SEC3";
-			device_type = "crypto";
-			compatible = "talitos";
+			compatible = "fsl,sec3.0", "fsl,sec2.4", "fsl,sec2.2",
+				     "fsl,sec2.1", "fsl,sec2.0";
 			reg = <0x30000 0x10000>;
 			interrupts = <11 0x8>;
 			interrupt-parent = <&ipic>;
-			/* Rev. 3.0 geometry */
-			num-channels = <4>;
-			channel-fifo-len = <24>;
-			exec-units-mask = <0x000001fe>;
-			descriptor-types-mask = <0x03ab0ebf>;
+			fsl,num-channels = <4>;
+			fsl,channel-fifo-len = <24>;
+			fsl,exec-units-mask = <0x9fe>;
+			fsl,descriptor-types-mask = <0x3ab0ebf>;
 		};
 
 		/* IPIC
diff --git a/arch/powerpc/boot/dts/mpc8379_mds.dts b/arch/powerpc/boot/dts/mpc8379_mds.dts
index 6f78a9f..4d3bab0 100644
--- a/arch/powerpc/boot/dts/mpc8379_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8379_mds.dts
@@ -234,16 +234,15 @@
 		};
 
 		crypto@30000 {
-			model = "SEC3";
-			compatible = "talitos";
+			compatible = "fsl,sec3.0", "fsl,sec2.4", "fsl,sec2.2",
+				     "fsl,sec2.1", "fsl,sec2.0";
 			reg = <0x30000 0x10000>;
 			interrupts = <11 0x8>;
 			interrupt-parent = <&ipic>;
-			/* Rev. 3.0 geometry */
-			num-channels = <4>;
-			channel-fifo-len = <24>;
-			exec-units-mask = <0x000001fe>;
-			descriptor-types-mask = <0x03ab0ebf>;
+			fsl,num-channels = <4>;
+			fsl,channel-fifo-len = <24>;
+			fsl,exec-units-mask = <0x9fe>;
+			fsl,descriptor-types-mask = <0x3ab0ebf>;
 		};
 
 		sdhc@2e000 {
diff --git a/arch/powerpc/boot/dts/mpc8379_rdb.dts b/arch/powerpc/boot/dts/mpc8379_rdb.dts
index c11ceb7..71619c4 100644
--- a/arch/powerpc/boot/dts/mpc8379_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8379_rdb.dts
@@ -219,17 +219,15 @@
 		};
 
 		crypto@30000 {
-			model = "SEC3";
-			device_type = "crypto";
-			compatible = "talitos";
+			compatible = "fsl,sec3.0", "fsl,sec2.4", "fsl,sec2.2",
+				     "fsl,sec2.1", "fsl,sec2.0";
 			reg = <0x30000 0x10000>;
 			interrupts = <11 0x8>;
 			interrupt-parent = <&ipic>;
-			/* Rev. 3.0 geometry */
-			num-channels = <4>;
-			channel-fifo-len = <24>;
-			exec-units-mask = <0x000001fe>;
-			descriptor-types-mask = <0x03ab0ebf>;
+			fsl,num-channels = <4>;
+			fsl,channel-fifo-len = <24>;
+			fsl,exec-units-mask = <0x9fe>;
+			fsl,descriptor-types-mask = <0x3ab0ebf>;
 		};
 
 		sata@18000 {
diff --git a/arch/powerpc/boot/dts/mpc8541cds.dts b/arch/powerpc/boot/dts/mpc8541cds.dts
index 66192aa..4e7b051 100644
--- a/arch/powerpc/boot/dts/mpc8541cds.dts
+++ b/arch/powerpc/boot/dts/mpc8541cds.dts
@@ -148,6 +148,17 @@
 			interrupt-parent = <&mpic>;
 		};
 
+		crypto@30000 {
+			compatible = "fsl,sec2.0";
+			reg = <0x30000 0x10000>;
+			interrupts = <45 2>;
+			interrupt-parent = <&mpic>;
+			fsl,num-channels = <4>;
+			fsl,channel-fifo-len = <24>;
+			fsl,exec-units-mask = <0x7e>;
+			fsl,descriptor-types-mask = <0x01010ebf>;
+		};
+
 		mpic: pic@40000 {
 			interrupt-controller;
 			#address-cells = <0>;
diff --git a/arch/powerpc/boot/dts/mpc8544ds.dts b/arch/powerpc/boot/dts/mpc8544ds.dts
index 6cf533f..7d3829d 100644
--- a/arch/powerpc/boot/dts/mpc8544ds.dts
+++ b/arch/powerpc/boot/dts/mpc8544ds.dts
@@ -210,6 +210,17 @@
 			fsl,has-rstcr;
 		};
 
+		crypto@30000 {
+			compatible = "fsl,sec2.1", "fsl,sec2.0";
+			reg = <0x30000 0x10000>;
+			interrupts = <45 2>;
+			interrupt-parent = <&mpic>;
+			fsl,num-channels = <4>;
+			fsl,channel-fifo-len = <24>;
+			fsl,exec-units-mask = <0xfe>;
+			fsl,descriptor-types-mask = <0x12b0ebf>;
+		};
+
 		mpic: pic@40000 {
 			interrupt-controller;
 			#address-cells = <0>;
diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/boot/dts/mpc8548cds.dts
index 205598d..8029407 100644
--- a/arch/powerpc/boot/dts/mpc8548cds.dts
+++ b/arch/powerpc/boot/dts/mpc8548cds.dts
@@ -208,6 +208,17 @@
 			fsl,has-rstcr;
 		};
 
+		crypto@30000 {
+			compatible = "fsl,sec2.1", "fsl,sec2.0";
+			reg = <0x30000 0x10000>;
+			interrupts = <45 2>;
+			interrupt-parent = <&mpic>;
+			fsl,num-channels = <4>;
+			fsl,channel-fifo-len = <24>;
+			fsl,exec-units-mask = <0xfe>;
+			fsl,descriptor-types-mask = <0x12b0ebf>;
+		};
+
 		mpic: pic@40000 {
 			interrupt-controller;
 			#address-cells = <0>;
diff --git a/arch/powerpc/boot/dts/mpc8555cds.dts b/arch/powerpc/boot/dts/mpc8555cds.dts
index 7c9d0b1..3a91a03 100644
--- a/arch/powerpc/boot/dts/mpc8555cds.dts
+++ b/arch/powerpc/boot/dts/mpc8555cds.dts
@@ -148,6 +148,17 @@
 			interrupt-parent = <&mpic>;
 		};
 
+		crypto@30000 {
+			compatible = "fsl,sec2.0";
+			reg = <0x30000 0x10000>;
+			interrupts = <45 2>;
+			interrupt-parent = <&mpic>;
+			fsl,num-channels = <4>;
+			fsl,channel-fifo-len = <24>;
+			fsl,exec-units-mask = <0x7e>;
+			fsl,descriptor-types-mask = <0x01010ebf>;
+		};
+
 		mpic: pic@40000 {
 			interrupt-controller;
 			#address-cells = <0>;
diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index d7af8db..c81c18c 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -190,16 +190,14 @@
 		};
 
 		crypto@30000 {
-			device_type = "crypto";
-			model = "SEC2";
-			compatible = "talitos";
-			reg = <0x30000 0xf000>;
+			compatible = "fsl,sec2.1", "fsl,sec2.0";
+			reg = <0x30000 0x10000>;
 			interrupts = <45 2>;
 			interrupt-parent = <&mpic>;
-			num-channels = <4>;
-			channel-fifo-len = <24>;
-			exec-units-mask = <0xfe>;
-			descriptor-types-mask = <0x12b0ebf>;
+			fsl,num-channels = <4>;
+			fsl,channel-fifo-len = <24>;
+			fsl,exec-units-mask = <0xfe>;
+			fsl,descriptor-types-mask = <0x12b0ebf>;
 		};
 
 		mpic: pic@40000 {
diff --git a/arch/powerpc/boot/dts/mpc8572ds.dts b/arch/powerpc/boot/dts/mpc8572ds.dts
index a444e6a..fe732f1 100644
--- a/arch/powerpc/boot/dts/mpc8572ds.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds.dts
@@ -239,6 +239,18 @@
 			interrupt-parent = <&mpic>;
 		};
 
+		crypto@30000 {
+			compatible = "fsl,sec3.0", "fsl,sec2.4", "fsl,sec2.2",
+				     "fsl,sec2.1", "fsl,sec2.0";
+			reg = <0x30000 0x10000>;
+			interrupts = <45 2 58 2>;
+			interrupt-parent = <&mpic>;
+			fsl,num-channels = <4>;
+			fsl,channel-fifo-len = <24>;
+			fsl,exec-units-mask = <0x9fe>;
+			fsl,descriptor-types-mask = <0x3ab0ebf>;
+		};
+
 		mpic: pic@40000 {
 			interrupt-controller;
 			#address-cells = <0>;
diff --git a/arch/powerpc/boot/dts/sbc8349.dts b/arch/powerpc/boot/dts/sbc8349.dts
index 3839d4b..6013ed8 100644
--- a/arch/powerpc/boot/dts/sbc8349.dts
+++ b/arch/powerpc/boot/dts/sbc8349.dts
@@ -186,19 +186,15 @@
 			interrupt-parent = <&ipic>;
 		};
 
-		/* May need to remove if on a part without crypto engine */
 		crypto@30000 {
-			model = "SEC2";
-			compatible = "talitos";
+			compatible = "fsl,sec2.0";
 			reg = <0x30000 0x10000>;
 			interrupts = <11 0x8>;
 			interrupt-parent = <&ipic>;
-			num-channels = <4>;
-			channel-fifo-len = <24>;
-			exec-units-mask = <0x0000007e>;
-			/* desc mask is for rev2.0,
-			 * we need runtime fixup for >2.0 */
-			descriptor-types-mask = <0x01010ebf>;
+			fsl,num-channels = <4>;
+			fsl,channel-fifo-len = <24>;
+			fsl,exec-units-mask = <0x7e>;
+			fsl,descriptor-types-mask = <0x01010ebf>;
 		};
 
 		/* IPIC
diff --git a/arch/powerpc/boot/dts/sbc8548.dts b/arch/powerpc/boot/dts/sbc8548.dts
index d252e38..04a0a55 100644
--- a/arch/powerpc/boot/dts/sbc8548.dts
+++ b/arch/powerpc/boot/dts/sbc8548.dts
@@ -263,6 +263,17 @@
 			fsl,has-rstcr;
 		};
 
+		crypto@30000 {
+			compatible = "fsl,sec2.1", "fsl,sec2.0";
+			reg = <0x30000 0x10000>;
+			interrupts = <45 2>;
+			interrupt-parent = <&mpic>;
+			fsl,num-channels = <4>;
+			fsl,channel-fifo-len = <24>;
+			fsl,exec-units-mask = <0xfe>;
+			fsl,descriptor-types-mask = <0x12b0ebf>;
+		};
+
 		mpic: pic@40000 {
 			interrupt-controller;
 			#address-cells = <0>;
diff --git a/arch/powerpc/boot/dts/tqm8541.dts b/arch/powerpc/boot/dts/tqm8541.dts
index 8241ae3..7ca9a53 100644
--- a/arch/powerpc/boot/dts/tqm8541.dts
+++ b/arch/powerpc/boot/dts/tqm8541.dts
@@ -159,6 +159,17 @@
 			interrupt-parent = <&mpic>;
 		};
 
+		crypto@30000 {
+			compatible = "fsl,sec2.0";
+			reg = <0x30000 0x10000>;
+			interrupts = <45 2>;
+			interrupt-parent = <&mpic>;
+			fsl,num-channels = <4>;
+			fsl,channel-fifo-len = <24>;
+			fsl,exec-units-mask = <0x7e>;
+			fsl,descriptor-types-mask = <0x01010ebf>;
+		};
+
 		mpic: pic@40000 {
 			interrupt-controller;
 			#address-cells = <0>;
diff --git a/arch/powerpc/boot/dts/tqm8555.dts b/arch/powerpc/boot/dts/tqm8555.dts
index 5a57cef..22105ef 100644
--- a/arch/powerpc/boot/dts/tqm8555.dts
+++ b/arch/powerpc/boot/dts/tqm8555.dts
@@ -159,6 +159,17 @@
 			interrupt-parent = <&mpic>;
 		};
 
+		crypto@30000 {
+			compatible = "fsl,sec2.0";
+			reg = <0x30000 0x10000>;
+			interrupts = <45 2>;
+			interrupt-parent = <&mpic>;
+			fsl,num-channels = <4>;
+			fsl,channel-fifo-len = <24>;
+			fsl,exec-units-mask = <0x7e>;
+			fsl,descriptor-types-mask = <0x01010ebf>;
+		};
+
 		mpic: pic@40000 {
 			interrupt-controller;
 			#address-cells = <0>;
-- 
1.5.6
