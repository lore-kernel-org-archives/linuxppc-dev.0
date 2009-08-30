Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 75BF4B7FA5
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 31 Aug 2009 05:37:28 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id AF0FADDD04
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Aug 2009 05:37:27 +1000 (EST)
Date: Sun, 30 Aug 2009 23:37:26 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 5/5] powerpc/83xx: Add power management support for MPC83xx
	QE boards
Message-ID: <20090830193726.GE17519@oksana.dev.rtsoft.ru>
References: <20090830193625.GA14693@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090830193625.GA14693@oksana.dev.rtsoft.ru>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Simply add power management controller nodes and sleep properties.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/kmeter1.dts     |    7 +++++++
 arch/powerpc/boot/dts/mpc832x_mds.dts |    9 +++++++++
 arch/powerpc/boot/dts/mpc832x_rdb.dts |    9 +++++++++
 arch/powerpc/boot/dts/mpc836x_mds.dts |    9 +++++++++
 arch/powerpc/boot/dts/mpc836x_rdk.dts |    9 +++++++++
 5 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/kmeter1.dts b/arch/powerpc/boot/dts/kmeter1.dts
index 167044f..65b8b4f 100644
--- a/arch/powerpc/boot/dts/kmeter1.dts
+++ b/arch/powerpc/boot/dts/kmeter1.dts
@@ -59,6 +59,13 @@
 		reg = <0xe0000000 0x00000200>;
 		bus-frequency = <0>;	/* Filled in by U-Boot */
 
+		pmc: power@b00 {
+			compatible = "fsl,mpc8360-pmc", "fsl,mpc8349-pmc";
+			reg = <0xb00 0x100 0xa00 0x100>;
+			interrupts = <80 0x8>;
+			interrupt-parent = <&ipic>;
+		};
+
 		i2c@3000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/powerpc/boot/dts/mpc832x_mds.dts b/arch/powerpc/boot/dts/mpc832x_mds.dts
index 436c9c6..05ad8c9 100644
--- a/arch/powerpc/boot/dts/mpc832x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
@@ -79,6 +79,13 @@
 			reg = <0x200 0x100>;
 		};
 
+		pmc: power@b00 {
+			compatible = "fsl,mpc8323-pmc", "fsl,mpc8349-pmc";
+			reg = <0xb00 0x100 0xa00 0x100>;
+			interrupts = <80 0x8>;
+			interrupt-parent = <&ipic>;
+		};
+
 		i2c@3000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -163,6 +170,7 @@
 			fsl,channel-fifo-len = <24>;
 			fsl,exec-units-mask = <0x4c>;
 			fsl,descriptor-types-mask = <0x0122003f>;
+			sleep = <&pmc 0x03000000>;
 		};
 
 		ipic: pic@700 {
@@ -428,5 +436,6 @@
 		       0xe0008300 0x8>;		/* config space access registers */
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
+		sleep = <&pmc 0x00010000>;
 	};
 };
diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
index 9a0952f..f4fadb2 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -62,6 +62,13 @@
 			reg = <0x200 0x100>;
 		};
 
+		pmc: power@b00 {
+			compatible = "fsl,mpc8323-pmc", "fsl,mpc8349-pmc";
+			reg = <0xb00 0x100 0xa00 0x100>;
+			interrupts = <80 0x8>;
+			interrupt-parent = <&ipic>;
+		};
+
 		i2c@3000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -141,6 +148,7 @@
 			fsl,channel-fifo-len = <24>;
 			fsl,exec-units-mask = <0x4c>;
 			fsl,descriptor-types-mask = <0x0122003f>;
+			sleep = <&pmc 0x03000000>;
 		};
 
 		ipic:pic@700 {
@@ -360,5 +368,6 @@
 		       0xe0008300 0x8>;		/* config space access registers */
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
+		sleep = <&pmc 0x00010000>;
 	};
 };
diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
index 39ff4c8..45cfa1c 100644
--- a/arch/powerpc/boot/dts/mpc836x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
@@ -99,6 +99,13 @@
 			reg = <0x200 0x100>;
 		};
 
+		pmc: power@b00 {
+			compatible = "fsl,mpc8360-pmc", "fsl,mpc8349-pmc";
+			reg = <0xb00 0x100 0xa00 0x100>;
+			interrupts = <80 0x8>;
+			interrupt-parent = <&ipic>;
+		};
+
 		i2c@3000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -194,6 +201,7 @@
 			fsl,channel-fifo-len = <24>;
 			fsl,exec-units-mask = <0x7e>;
 			fsl,descriptor-types-mask = <0x01010ebf>;
+			sleep = <&pmc 0x03000000>;
 		};
 
 		ipic: pic@700 {
@@ -470,5 +478,6 @@
 		       0xe0008300 0x8>;		/* config space access registers */
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
+		sleep = <&pmc 0x00010000>;
 	};
 };
diff --git a/arch/powerpc/boot/dts/mpc836x_rdk.dts b/arch/powerpc/boot/dts/mpc836x_rdk.dts
index 6315d6f..bdf4459 100644
--- a/arch/powerpc/boot/dts/mpc836x_rdk.dts
+++ b/arch/powerpc/boot/dts/mpc836x_rdk.dts
@@ -71,6 +71,13 @@
 			reg = <0x200 0x100>;
 		};
 
+		pmc: power@b00 {
+			compatible = "fsl,mpc8360-pmc", "fsl,mpc8349-pmc";
+			reg = <0xb00 0x100 0xa00 0x100>;
+			interrupts = <80 0x8>;
+			interrupt-parent = <&ipic>;
+		};
+
 		i2c@3000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -161,6 +168,7 @@
 			fsl,channel-fifo-len = <24>;
 			fsl,exec-units-mask = <0x7e>;
 			fsl,descriptor-types-mask = <0x01010ebf>;
+			sleep = <&pmc 0x03000000>;
 		};
 
 		ipic: interrupt-controller@700 {
@@ -455,6 +463,7 @@
 				 0xa800 0 0 2 &ipic 20 8
 				 0xa800 0 0 3 &ipic 21 8
 				 0xa800 0 0 4 &ipic 18 8>;
+		sleep = <&pmc 0x00010000>;
 		/* filled by u-boot */
 		bus-range = <0 0>;
 		clock-frequency = <0>;
-- 
1.6.3.3
