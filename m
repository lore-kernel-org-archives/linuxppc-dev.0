Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BAE13DE007
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 05:19:09 +1000 (EST)
Date: Thu, 3 Jul 2008 14:18:45 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH v3] powerpc: update crypto node definition and device tree
	instances
Message-Id: <20080703141845.af88fd51.kim.phillips@freescale.com>
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
changes from v2: SEC bindings moved to new file, added crypto node to
mpc8536 dts

 Documentation/powerpc/booting-without-of.txt  |   71 -------------------------
 Documentation/powerpc/device-tree/fsl/sec.txt |   69 ++++++++++++++++++++++++
 arch/powerpc/boot/dts/mpc8272ads.dts          |   21 +++-----
 arch/powerpc/boot/dts/mpc8313erdb.dts         |   15 ++---
 arch/powerpc/boot/dts/mpc8315erdb.dts         |   15 +++---
 arch/powerpc/boot/dts/mpc832x_mds.dts         |   15 ++---
 arch/powerpc/boot/dts/mpc832x_rdb.dts         |   16 +++---
 arch/powerpc/boot/dts/mpc8349emitx.dts        |   12 ++---
 arch/powerpc/boot/dts/mpc8349emitxgp.dts      |   12 ++---
 arch/powerpc/boot/dts/mpc834x_mds.dts         |   15 ++----
 arch/powerpc/boot/dts/mpc836x_mds.dts         |   13 ++---
 arch/powerpc/boot/dts/mpc8377_mds.dts         |   13 ++---
 arch/powerpc/boot/dts/mpc8377_rdb.dts         |   14 ++---
 arch/powerpc/boot/dts/mpc8378_mds.dts         |   13 ++---
 arch/powerpc/boot/dts/mpc8378_rdb.dts         |   14 ++---
 arch/powerpc/boot/dts/mpc8379_mds.dts         |   13 ++---
 arch/powerpc/boot/dts/mpc8379_rdb.dts         |   14 ++---
 arch/powerpc/boot/dts/mpc8536ds.dts           |   12 ++++
 arch/powerpc/boot/dts/mpc8541cds.dts          |   11 ++++
 arch/powerpc/boot/dts/mpc8544ds.dts           |   11 ++++
 arch/powerpc/boot/dts/mpc8548cds.dts          |   11 ++++
 arch/powerpc/boot/dts/mpc8555cds.dts          |   11 ++++
 arch/powerpc/boot/dts/mpc8568mds.dts          |   14 ++---
 arch/powerpc/boot/dts/mpc8572ds.dts           |   12 ++++
 arch/powerpc/boot/dts/sbc8349.dts             |   14 ++---
 arch/powerpc/boot/dts/sbc8548.dts             |   11 ++++
 arch/powerpc/boot/dts/tqm8541.dts             |   11 ++++
 arch/powerpc/boot/dts/tqm8555.dts             |   11 ++++
 28 files changed, 270 insertions(+), 214 deletions(-)
 create mode 100644 Documentation/powerpc/device-tree/fsl/sec.txt

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index f6394b5..899b4ea 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1468,77 +1468,6 @@ platforms are moved over to use the flattened-device-tree model.
 	};
 
 
-   g) Freescale SOC SEC Security Engines
-
-   Required properties:
-
-    - device_type : Should be "crypto"
-    - model : Model of the device.  Should be "SEC1" or "SEC2"
-    - compatible : Should be "talitos"
-    - reg : Offset and length of the register set for the device
-    - interrupts : <a b> where a is the interrupt number and b is a
-      field that represents an encoding of the sense and level
-      information for the interrupt.  This should be encoded based on
-      the information in section 2) depending on the type of interrupt
-      controller you have.
-    - interrupt-parent : the phandle for the interrupt controller that
-      services interrupts for this device.
-    - num-channels : An integer representing the number of channels
-      available.
-    - channel-fifo-len : An integer representing the number of
-      descriptor pointers each channel fetch fifo can hold.
-    - exec-units-mask : The bitmask representing what execution units
-      (EUs) are available. It's a single 32-bit cell. EU information
-      should be encoded following the SEC's Descriptor Header Dword
-      EU_SEL0 field documentation, i.e. as follows:
-
-        bit 0 = reserved - should be 0
-        bit 1 = set if SEC has the ARC4 EU (AFEU)
-        bit 2 = set if SEC has the DES/3DES EU (DEU)
-        bit 3 = set if SEC has the message digest EU (MDEU)
-        bit 4 = set if SEC has the random number generator EU (RNG)
-        bit 5 = set if SEC has the public key EU (PKEU)
-        bit 6 = set if SEC has the AES EU (AESU)
-        bit 7 = set if SEC has the Kasumi EU (KEU)
-
-      bits 8 through 31 are reserved for future SEC EUs.
-
-    - descriptor-types-mask : The bitmask representing what descriptors
-      are available. It's a single 32-bit cell. Descriptor type
-      information should be encoded following the SEC's Descriptor
-      Header Dword DESC_TYPE field documentation, i.e. as follows:
-
-        bit 0  = set if SEC supports the aesu_ctr_nonsnoop desc. type
-        bit 1  = set if SEC supports the ipsec_esp descriptor type
-        bit 2  = set if SEC supports the common_nonsnoop desc. type
-        bit 3  = set if SEC supports the 802.11i AES ccmp desc. type
-        bit 4  = set if SEC supports the hmac_snoop_no_afeu desc. type
-        bit 5  = set if SEC supports the srtp descriptor type
-        bit 6  = set if SEC supports the non_hmac_snoop_no_afeu desc.type
-        bit 7  = set if SEC supports the pkeu_assemble descriptor type
-        bit 8  = set if SEC supports the aesu_key_expand_output desc.type
-        bit 9  = set if SEC supports the pkeu_ptmul descriptor type
-        bit 10 = set if SEC supports the common_nonsnoop_afeu desc. type
-        bit 11 = set if SEC supports the pkeu_ptadd_dbl descriptor type
-
-      ..and so on and so forth.
-
-   Example:
-
-       /* MPC8548E */
-       crypto@30000 {
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
-       };
-
    h) Board Control and Status (BCSR)
 
    Required properties:
diff --git a/Documentation/powerpc/device-tree/fsl/sec.txt b/Documentation/powerpc/device-tree/fsl/sec.txt
new file mode 100644
index 0000000..cfaa555
--- /dev/null
+++ b/Documentation/powerpc/device-tree/fsl/sec.txt
@@ -0,0 +1,69 @@
+Freescale SoC SEC Security Engines
+
+Required properties:
+
+- compatible : Should contain entries for this and backward compatible
+  SEC versions, high to low, e.g., "fsl,sec2.1", "fsl,sec2.0"
+- reg : Offset and length of the register set for the device
+- interrupts : <a b> where a is the interrupt number and b is a
+  field that represents an encoding of the sense and level
+  information for the interrupt.  This should be encoded based on
+  the information in section 2) depending on the type of interrupt
+  controller you have.
+- interrupt-parent : the phandle for the interrupt controller that
+  services interrupts for this device.
+- fsl,num-channels : An integer representing the number of channels
+  available.
+- fsl,channel-fifo-len : An integer representing the number of
+  descriptor pointers each channel fetch fifo can hold.
+- fsl,exec-units-mask : The bitmask representing what execution units
+  (EUs) are available. It's a single 32-bit cell. EU information
+  should be encoded following the SEC's Descriptor Header Dword
+  EU_SEL0 field documentation, i.e. as follows:
+
+	bit 0  = reserved - should be 0
+	bit 1  = set if SEC has the ARC4 EU (AFEU)
+	bit 2  = set if SEC has the DES/3DES EU (DEU)
+	bit 3  = set if SEC has the message digest EU (MDEU/MDEU-A)
+	bit 4  = set if SEC has the random number generator EU (RNG)
+	bit 5  = set if SEC has the public key EU (PKEU)
+	bit 6  = set if SEC has the AES EU (AESU)
+	bit 7  = set if SEC has the Kasumi EU (KEU)
+	bit 8  = set if SEC has the CRC EU (CRCU)
+	bit 11 = set if SEC has the message digest EU extended alg set (MDEU-B)
+
+remaining bits are reserved for future SEC EUs.
+
+- fsl,descriptor-types-mask : The bitmask representing what descriptors
+  are available. It's a single 32-bit cell. Descriptor type information
+  should be encoded following the SEC's Descriptor Header Dword DESC_TYPE
+  field documentation, i.e. as follows:
+
+	bit 0  = set if SEC supports the aesu_ctr_nonsnoop desc. type
+	bit 1  = set if SEC supports the ipsec_esp descriptor type
+	bit 2  = set if SEC supports the common_nonsnoop desc. type
+	bit 3  = set if SEC supports the 802.11i AES ccmp desc. type
+	bit 4  = set if SEC supports the hmac_snoop_no_afeu desc. type
+	bit 5  = set if SEC supports the srtp descriptor type
+	bit 6  = set if SEC supports the non_hmac_snoop_no_afeu desc.type
+	bit 7  = set if SEC supports the pkeu_assemble descriptor type
+	bit 8  = set if SEC supports the aesu_key_expand_output desc.type
+	bit 9  = set if SEC supports the pkeu_ptmul descriptor type
+	bit 10 = set if SEC supports the common_nonsnoop_afeu desc. type
+	bit 11 = set if SEC supports the pkeu_ptadd_dbl descriptor type
+
+..and so on and so forth.
+
+Example:
+
+	/* MPC8548E */
+	crypto@30000 {
+		compatible = "fsl,sec2.1", "fsl,sec2.0";
+		reg = <0x30000 0x10000>;
+		interrupts = <29 2>;
+		interrupt-parent = <&mpic>;
+		fsl,num-channels = <4>;
+		fsl,channel-fifo-len = <24>;
+		fsl,exec-units-mask = <0xfe>;
+		fsl,descriptor-types-mask = <0x12b0ebf>;
+	};
diff --git a/arch/powerpc/boot/dts/mpc8272ads.dts b/arch/powerpc/boot/dts/mpc8272ads.dts
index d27f8a7..2a1929a 100644
--- a/arch/powerpc/boot/dts/mpc8272ads.dts
+++ b/arch/powerpc/boot/dts/mpc8272ads.dts
@@ -237,22 +237,15 @@
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
index b206843..3664fb5 100644
--- a/arch/powerpc/boot/dts/mpc8313erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
@@ -254,17 +254,14 @@
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
index a40e806..f704513 100644
--- a/arch/powerpc/boot/dts/mpc8315erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8315erdb.dts
@@ -241,17 +241,16 @@
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
index b5968b6..7345743 100644
--- a/arch/powerpc/boot/dts/mpc832x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
@@ -150,17 +150,14 @@
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
index a798d86..0ebc20f 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -128,17 +128,15 @@
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
+			interrupt-parent = <&pic>;
+			fsl,num-channels = <1>;
+			fsl,channel-fifo-len = <24>;
+			fsl,exec-units-mask = <0x4c>;
+			fsl,descriptor-types-mask = <0x0122003f>;
 		};
 
 		ipic:pic@700 {
diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index fc0f4c9..8dfab56 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -213,16 +213,14 @@
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
index e6afb1d..49ca349 100644
--- a/arch/powerpc/boot/dts/mpc8349emitxgp.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
@@ -186,16 +186,14 @@
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
index 9c75c7c..ba586cb 100644
--- a/arch/powerpc/boot/dts/mpc834x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc834x_mds.dts
@@ -228,20 +228,15 @@
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
index 8e33b15..3701dae 100644
--- a/arch/powerpc/boot/dts/mpc836x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
@@ -154,17 +154,14 @@
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
index 49a38cb..0a700cb 100644
--- a/arch/powerpc/boot/dts/mpc8377_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8377_mds.dts
@@ -269,16 +269,15 @@
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
index 1f45387..ed137aa 100644
--- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
@@ -248,17 +248,15 @@
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
index 99ad49d..29c8c76 100644
--- a/arch/powerpc/boot/dts/mpc8378_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8378_mds.dts
@@ -269,16 +269,15 @@
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
index 44e34d3..34a7f2f 100644
--- a/arch/powerpc/boot/dts/mpc8378_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8378_rdb.dts
@@ -248,17 +248,15 @@
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
index 980be81..d641a89 100644
--- a/arch/powerpc/boot/dts/mpc8379_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8379_mds.dts
@@ -269,16 +269,15 @@
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
index eeedf58..e4d7030 100644
--- a/arch/powerpc/boot/dts/mpc8379_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8379_rdb.dts
@@ -248,17 +248,15 @@
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
diff --git a/arch/powerpc/boot/dts/mpc8536ds.dts b/arch/powerpc/boot/dts/mpc8536ds.dts
index 98ad27a..bf778fd 100644
--- a/arch/powerpc/boot/dts/mpc8536ds.dts
+++ b/arch/powerpc/boot/dts/mpc8536ds.dts
@@ -231,6 +231,18 @@
 			interrupt-parent = <&mpic>;
 		};
 
+		crypto@30000 {
+			compatible = "fsl,sec3.0", "fsl,sec2.4", "fsl,sec2.2",
+				     "fsl,sec2.1", "fsl,sec2.0";
+			reg = <0x30000 0x10000>;
+			interrupts = <11 0x8>;
+			interrupt-parent = <&ipic>;
+			fsl,num-channels = <4>;
+			fsl,channel-fifo-len = <24>;
+			fsl,exec-units-mask = <0x9fe>;
+			fsl,descriptor-types-mask = <0x3ab0ebf>;
+		};
+
 		sata@18000 {
 			compatible = "fsl,mpc8536-sata", "fsl,pq-sata";
 			reg = <0x18000 0x1000>;
diff --git a/arch/powerpc/boot/dts/mpc8541cds.dts b/arch/powerpc/boot/dts/mpc8541cds.dts
index 21ad71b..c4469f1 100644
--- a/arch/powerpc/boot/dts/mpc8541cds.dts
+++ b/arch/powerpc/boot/dts/mpc8541cds.dts
@@ -189,6 +189,17 @@
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
index d1fa6bb..d84466b 100644
--- a/arch/powerpc/boot/dts/mpc8548cds.dts
+++ b/arch/powerpc/boot/dts/mpc8548cds.dts
@@ -249,6 +249,17 @@
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
index 6fc8059..e03a780 100644
--- a/arch/powerpc/boot/dts/mpc8555cds.dts
+++ b/arch/powerpc/boot/dts/mpc8555cds.dts
@@ -189,6 +189,17 @@
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
index be9a289..9c30a34 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -231,16 +231,14 @@
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
index cb06325..08c61e3 100644
--- a/arch/powerpc/boot/dts/mpc8572ds.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds.dts
@@ -321,6 +321,18 @@
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
index 5b76bb2..45f789b 100644
--- a/arch/powerpc/boot/dts/sbc8349.dts
+++ b/arch/powerpc/boot/dts/sbc8349.dts
@@ -221,19 +221,15 @@
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
index 21cbacb..333552b 100644
--- a/arch/powerpc/boot/dts/sbc8548.dts
+++ b/arch/powerpc/boot/dts/sbc8548.dts
@@ -304,6 +304,17 @@
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
index d083a64..d76441e 100644
--- a/arch/powerpc/boot/dts/tqm8541.dts
+++ b/arch/powerpc/boot/dts/tqm8541.dts
@@ -200,6 +200,17 @@
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
index 96b0b94..6f7ea59 100644
--- a/arch/powerpc/boot/dts/tqm8555.dts
+++ b/arch/powerpc/boot/dts/tqm8555.dts
@@ -200,6 +200,17 @@
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
