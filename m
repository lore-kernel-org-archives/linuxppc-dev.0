Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 32EC067D15
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Nov 2006 17:09:07 +1100 (EST)
Date: Wed, 8 Nov 2006 00:08:50 -0600 (CST)
From: Andy Fleming <afleming@freescale.com>
To: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] Changed gianfar device tree definition to make it more
	flexible
Message-ID: <Pine.LNX.4.61.0611071707520.6936@ld0175-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The old gianfar node definition used a concept of "models" to
determine the feature bits and interrupt settings to pass to the
driver.  This won't scale well when the hardware designers come
up with new and (hopefully) interesting variants of the eTSEC.
So one goal of this patch is to prepare for that eventuality by
listing the features, rather than inferring them.

Another goal of this patch is to lay the groundwork for adding
support for different interface types to gianfar.  It does this
by adding another field (interface), which specifies the
interfaces (GMII, RGMII, SGMII, etc).

And then, incidentally, some of the code was cleaned up so that
initialization functions will skip devices which encounter
errors, rather than bailing.  The CPM devices were not modified
in this way, as they are more complex.

Finally, all the dts files with gianfar nodes were updated to use
the new feature bits and the new interface field, and the various
MAC address conventions were all accommodated by preserving the
currently-used field, while adding local-mac-address, which will
be used in the future (once u-boot changes have been made).

Signed-off-by: Andrew Fleming <afleming@freescale.com>
---
 Documentation/powerpc/booting-without-of.txt |   31 ++
 arch/powerpc/boot/dts/mpc8349emds.dts        |   14 +
 arch/powerpc/boot/dts/mpc8349emitx.dts       |   11 +
 arch/powerpc/boot/dts/mpc8540ads.dts         |   24 +-
 arch/powerpc/boot/dts/mpc8541cds.dts         |   16 +
 arch/powerpc/boot/dts/mpc8548cds.dts         |   78 ++++-
 arch/powerpc/boot/dts/mpc8555cds.dts         |   16 +
 arch/powerpc/boot/dts/mpc8560ads.dts         |   18 +
 arch/powerpc/boot/dts/mpc8641_hpcn.dts       |   72 ++++-
 arch/powerpc/sysdev/fsl_soc.c                |  414 +++++++++++++++-----------
 include/linux/fsl_devices.h                  |    8 -
 11 files changed, 496 insertions(+), 206 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 27b457c..bb1a402 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1193,6 +1193,7 @@ platforms are moved over to use the flat
 
     - device_type : Should be "network"
     - model : Model of the device.  Can be "TSEC", "eTSEC", or "FEC"
+      (This is deprecated in favor of the feature bits)
     - compatible : Should be "gianfar"
     - reg : Offset and length of the register set for the device
     - mac-address : List of bytes representing the ethernet address of
@@ -1206,6 +1207,30 @@ platforms are moved over to use the flat
       services interrupts for this device.
     - phy-handle : The phandle for the PHY connected to this ethernet
       controller.
+    - interface : The interface this ethernet is using.  Current options are:
+        GMII, MII, RGMII, SGMII, TBI, RMII, and RTBI
+
+  Optional properties (features):
+    - gigabit : Indicates support for 1000 Mbit operation
+    - coalescing : Indicates support for interrupt coalescing
+    - rmon : Indicates support for RMON-style counters
+    - checksumming : Indicates support for hardware TCP/UDP checksumming
+    - vlan-insertion : Indicates support for hardware vlan header insertion
+    - extended-hash : Indicates support for using the Individual
+        Address Hash registers to extend the Group Address Hash registers
+    - padding : Indicates support for padding between the FCB and
+        the frame
+    - filer : Indicates support for the Filer
+    - parseL2 : Indicates support for parsing L2 headers
+    - parseL3 : Indicates support for parsing L3 headers
+    - parseL4 : Indicates support for parsing L4 headers
+    - multi-queue : Indicates support for sending and receiving
+      into multiple queues
+    
+    The "eTSEC" model implements all these features, while the
+    "TSEC" model implements only the first 3.  The "FEC" has none
+    of these features.
+  
 
   Example:
 
@@ -1213,12 +1238,16 @@ platforms are moved over to use the flat
 		#size-cells = <0>;
 		device_type = "network";
 		model = "TSEC";
+		gigabit;
+		coalescing;
+		rmon;
 		compatible = "gianfar";
 		reg = <24000 1000>;
 		mac-address = [ 00 E0 0C 00 73 00 ];
 		interrupts = <d 3 e 3 12 3>;
 		interrupt-parent = <40000>;
 		phy-handle = <2452000>
+		interface = "GMII";
 	};
 
 
@@ -1238,6 +1267,7 @@ platforms are moved over to use the flat
     - reg : The ID number for the phy, usually a small integer
     - linux,phandle :  phandle for this node; likely referenced by an
       ethernet controller node.
+    - flags : PHY-specific flags (defined by the device driver)
 
 
    Example:
@@ -1246,6 +1276,7 @@ platforms are moved over to use the flat
 		linux,phandle = <2452000>
 		interrupt-parent = <40000>;
 		interrupts = <35 1>;
+		flags = <0>;
 		reg = <0>;
 		device_type = "ethernet-phy";
 	};
diff --git a/arch/powerpc/boot/dts/mpc8349emds.dts b/arch/powerpc/boot/dts/mpc8349emds.dts
index efceb34..f6ae4e2 100644
--- a/arch/powerpc/boot/dts/mpc8349emds.dts
+++ b/arch/powerpc/boot/dts/mpc8349emds.dts
@@ -117,6 +117,7 @@
 				linux,phandle = <2452000>;
 				interrupt-parent = <700>;
 				interrupts = <11 2>;
+				flags = <0>;
 				reg = <0>;
 				device_type = "ethernet-phy";
 			};
@@ -124,6 +125,7 @@
 				linux,phandle = <2452001>;
 				interrupt-parent = <700>;
 				interrupts = <12 2>;
+				flags = <0>;
 				reg = <1>;
 				device_type = "ethernet-phy";
 			};
@@ -132,13 +134,17 @@
 		ethernet@24000 {
 			device_type = "network";
 			model = "TSEC";
+			gigabit;
+			coalescing;
+			rmon;
 			compatible = "gianfar";
 			reg = <24000 1000>;
-			address = [ 00 00 00 00 00 00 ];
 			local-mac-address = [ 00 00 00 00 00 00 ];
+			address = [ 00 00 00 00 00 00 ];
 			interrupts = <20 8 21 8 22 8>;
 			interrupt-parent = <700>;
 			phy-handle = <2452000>;
+			interface = "GMII";
 		};
 
 		ethernet@25000 {
@@ -146,13 +152,17 @@
 			#size-cells = <0>;
 			device_type = "network";
 			model = "TSEC";
+			gigabit;
+			coalescing;
+			rmon;
 			compatible = "gianfar";
 			reg = <25000 1000>;
-			address = [ 00 00 00 00 00 00 ];
 			local-mac-address = [ 00 00 00 00 00 00 ];
+			address = [ 00 00 00 00 00 00 ];
 			interrupts = <23 8 24 8 25 8>;
 			interrupt-parent = <700>;
 			phy-handle = <2452001>;
+			interface = "GMII";
 		};
 
 		serial@4500 {
diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index 27807fc..0d3ce51 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -116,6 +116,7 @@
 				linux,phandle = <245201c>;
 				interrupt-parent = <700>;
 				interrupts = <12 2>;
+				flags = <0>;
 				reg = <1c>;
 				device_type = "ethernet-phy";
 			};
@@ -125,6 +126,7 @@
 				linux,phandle = <245201f>;
 				interrupt-parent = <700>;
 				interrupts = <12 2>;
+				flags = <0>;
 				reg = <1f>;
 				device_type = "ethernet-phy";
 			};
@@ -133,13 +135,17 @@
 		ethernet@24000 {
 			device_type = "network";
 			model = "TSEC";
+			gigabit;
+			coalescing;
+			rmon;
 			compatible = "gianfar";
 			reg = <24000 1000>;
-			address = [ 00 00 00 00 00 00 ];
 			local-mac-address = [ 00 00 00 00 00 00 ];
+			address = [ 00 00 00 00 00 00 ];
 			interrupts = <20 8 21 8 22 8>;
 			interrupt-parent = <700>;
 			phy-handle = <245201c>;
+			interface = "GMII";
 		};
 
 		ethernet@25000 {
@@ -147,6 +153,9 @@
 			#size-cells = <0>;
 			device_type = "network";
 			model = "TSEC";
+			gigabit;
+			coalescing;
+			rmon;
 			compatible = "gianfar";
 			reg = <25000 1000>;
 			address = [ 00 00 00 00 00 00 ];
diff --git a/arch/powerpc/boot/dts/mpc8540ads.dts b/arch/powerpc/boot/dts/mpc8540ads.dts
index 5f41c1f..53e187d 100644
--- a/arch/powerpc/boot/dts/mpc8540ads.dts
+++ b/arch/powerpc/boot/dts/mpc8540ads.dts
@@ -73,6 +73,7 @@
 				linux,phandle = <2452000>;
 				interrupt-parent = <40000>;
 				interrupts = <35 1>;
+				flags = <0>;
 				reg = <0>;
 				device_type = "ethernet-phy";
 			};
@@ -80,6 +81,7 @@
 				linux,phandle = <2452001>;
 				interrupt-parent = <40000>;
 				interrupts = <35 1>;
+				flags = <0>;
 				reg = <1>;
 				device_type = "ethernet-phy";
 			};
@@ -87,6 +89,7 @@
 				linux,phandle = <2452003>;
 				interrupt-parent = <40000>;
 				interrupts = <37 1>;
+				flags = <0>;
 				reg = <3>;
 				device_type = "ethernet-phy";
 			};
@@ -97,13 +100,17 @@
 			#size-cells = <0>;
 			device_type = "network";
 			model = "TSEC";
+			gigabit;
+			coalescing;
+			rmon;
 			compatible = "gianfar";
 			reg = <24000 1000>;
-			address = [ 00 E0 0C 00 73 00 ];
-			local-mac-address = [ 00 E0 0C 00 73 00 ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <d 2 e 2 12 2>;
 			interrupt-parent = <40000>;
 			phy-handle = <2452000>;
+			interface = "GMII";
 		};
 
 		ethernet@25000 {
@@ -111,13 +118,17 @@
 			#size-cells = <0>;
 			device_type = "network";
 			model = "TSEC";
+			gigabit;
+			coalescing;
+			rmon;
 			compatible = "gianfar";
 			reg = <25000 1000>;
-			address = [ 00 E0 0C 00 73 01 ];
-			local-mac-address = [ 00 E0 0C 00 73 01 ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <13 2 14 2 18 2>;
 			interrupt-parent = <40000>;
 			phy-handle = <2452001>;
+			interface = "GMII";
 		};
 
 		ethernet@26000 {
@@ -127,11 +138,12 @@
 			model = "FEC";
 			compatible = "gianfar";
 			reg = <26000 1000>;
-			address = [ 00 E0 0C 00 73 02 ];
-			local-mac-address = [ 00 E0 0C 00 73 02 ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <19 2>;
 			interrupt-parent = <40000>;
 			phy-handle = <2452003>;
+			interface = "MII";
 		};
 
 		serial@4500 {
diff --git a/arch/powerpc/boot/dts/mpc8541cds.dts b/arch/powerpc/boot/dts/mpc8541cds.dts
index 7be0bc6..4191621 100644
--- a/arch/powerpc/boot/dts/mpc8541cds.dts
+++ b/arch/powerpc/boot/dts/mpc8541cds.dts
@@ -73,6 +73,7 @@
 				linux,phandle = <2452000>;
 				interrupt-parent = <40000>;
 				interrupts = <35 0>;
+				flags = <0>;
 				reg = <0>;
 				device_type = "ethernet-phy";
 			};
@@ -80,6 +81,7 @@
 				linux,phandle = <2452001>;
 				interrupt-parent = <40000>;
 				interrupts = <35 0>;
+				flags = <0>;
 				reg = <1>;
 				device_type = "ethernet-phy";
 			};
@@ -90,12 +92,17 @@
 			#size-cells = <0>;
 			device_type = "network";
 			model = "TSEC";
+			gigabit;
+			coalescing;
+			rmon;
 			compatible = "gianfar";
 			reg = <24000 1000>;
-			local-mac-address = [ 00 E0 0C 00 73 00 ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <d 2 e 2 12 2>;
 			interrupt-parent = <40000>;
 			phy-handle = <2452000>;
+			interface = "GMII";
 		};
 
 		ethernet@25000 {
@@ -103,12 +110,17 @@
 			#size-cells = <0>;
 			device_type = "network";
 			model = "TSEC";
+			gigabit;
+			coalescing;
+			rmon;
 			compatible = "gianfar";
 			reg = <25000 1000>;
-			local-mac-address = [ 00 E0 0C 00 73 01 ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <13 2 14 2 18 2>;
 			interrupt-parent = <40000>;
 			phy-handle = <2452001>;
+			interface = "GMII";
 		};
 
 		serial@4500 {
diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/boot/dts/mpc8548cds.dts
index 893d795..83451c4 100644
--- a/arch/powerpc/boot/dts/mpc8548cds.dts
+++ b/arch/powerpc/boot/dts/mpc8548cds.dts
@@ -1,5 +1,5 @@
 /*
- * MPC8555 CDS Device Tree Source
+ * MPC8548 CDS Device Tree Source
  *
  * Copyright 2006 Freescale Semiconductor Inc.
  *
@@ -73,6 +73,7 @@
 				linux,phandle = <2452000>;
 				interrupt-parent = <40000>;
 				interrupts = <35 0>;
+				flags = <0>;
 				reg = <0>;
 				device_type = "ethernet-phy";
 			};
@@ -80,6 +81,7 @@
 				linux,phandle = <2452001>;
 				interrupt-parent = <40000>;
 				interrupts = <35 0>;
+				flags = <0>;
 				reg = <1>;
 				device_type = "ethernet-phy";
 			};
@@ -88,6 +90,7 @@
 				linux,phandle = <2452002>;
 				interrupt-parent = <40000>;
 				interrupts = <35 0>;
+				flags = <0>;
 				reg = <2>;
 				device_type = "ethernet-phy";
 			};
@@ -95,6 +98,7 @@
 				linux,phandle = <2452003>;
 				interrupt-parent = <40000>;
 				interrupts = <35 0>;
+				flags = <0>;
 				reg = <3>;
 				device_type = "ethernet-phy";
 			};
@@ -105,12 +109,26 @@
 			#size-cells = <0>;
 			device_type = "network";
 			model = "eTSEC";
+			gigabit;
+			coalescing;
+			rmon;
+			checksumming;
+			vlan;
+			extended-hash;
+			padding;
+			filer;
+			parseL4;
+			parseL3;
+			parseL2;
+			multi-queue;
 			compatible = "gianfar";
 			reg = <24000 1000>;
-			local-mac-address = [ 00 E0 0C 00 73 00 ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <d 2 e 2 12 2>;
 			interrupt-parent = <40000>;
 			phy-handle = <2452000>;
+			interface = "GMII";
 		};
 
 		ethernet@25000 {
@@ -118,41 +136,83 @@
 			#size-cells = <0>;
 			device_type = "network";
 			model = "eTSEC";
+			gigabit;
+			coalescing;
+			rmon;
+			checksumming;
+			vlan;
+			extended-hash;
+			padding;
+			filer;
+			parseL4;
+			parseL3;
+			parseL2;
+			multi-queue;
 			compatible = "gianfar";
 			reg = <25000 1000>;
-			local-mac-address = [ 00 E0 0C 00 73 01 ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <13 2 14 2 18 2>;
 			interrupt-parent = <40000>;
 			phy-handle = <2452001>;
+			interface = "GMII";
 		};
+	/* eTSEC3 and eTSEC4 don't work on older CDS boards
 
 		ethernet@26000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			device_type = "network";
 			model = "eTSEC";
+			gigabit;
+			coalescing;
+			rmon;
+			checksumming;
+			vlan;
+			extended-hash;
+			padding;
+			filer;
+			parseL4;
+			parseL3;
+			parseL2;
+			multi-queue;
 			compatible = "gianfar";
 			reg = <26000 1000>;
-			local-mac-address = [ 00 E0 0C 00 73 02 ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <f 2 10 2 11 2>;
 			interrupt-parent = <40000>;
-			phy-handle = <2452001>;
+			phy-handle = <2452002>;
+			interface = "RGMII";
 		};
 
-/* eTSEC 4 is currently broken
 		ethernet@27000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			device_type = "network";
 			model = "eTSEC";
+			gigabit;
+			coalescing;
+			rmon;
+			checksumming;
+			vlan;
+			extended-hash;
+			padding;
+			filer;
+			parseL4;
+			parseL3;
+			parseL2;
+			multi-queue;
 			compatible = "gianfar";
 			reg = <27000 1000>;
-			local-mac-address = [ 00 E0 0C 00 73 03 ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <15 2 16 2 17 2>;
 			interrupt-parent = <40000>;
-			phy-handle = <2452001>;
+			phy-handle = <2452003>;
+			interface = "RGMII";
 		};
- */
+	*/
 
 		serial@4500 {
 			device_type = "serial";
diff --git a/arch/powerpc/boot/dts/mpc8555cds.dts b/arch/powerpc/boot/dts/mpc8555cds.dts
index 118f5a8..c559aab 100644
--- a/arch/powerpc/boot/dts/mpc8555cds.dts
+++ b/arch/powerpc/boot/dts/mpc8555cds.dts
@@ -73,6 +73,7 @@
 				linux,phandle = <2452000>;
 				interrupt-parent = <40000>;
 				interrupts = <35 0>;
+				flags = <0>;
 				reg = <0>;
 				device_type = "ethernet-phy";
 			};
@@ -80,6 +81,7 @@
 				linux,phandle = <2452001>;
 				interrupt-parent = <40000>;
 				interrupts = <35 0>;
+				flags = <0>;
 				reg = <1>;
 				device_type = "ethernet-phy";
 			};
@@ -90,12 +92,17 @@
 			#size-cells = <0>;
 			device_type = "network";
 			model = "TSEC";
+			gigabit;
+			coalescing;
+			rmon;
 			compatible = "gianfar";
 			reg = <24000 1000>;
-			local-mac-address = [ 00 E0 0C 00 73 00 ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <0d 2 0e 2 12 2>;
 			interrupt-parent = <40000>;
 			phy-handle = <2452000>;
+			interface = "GMII";
 		};
 
 		ethernet@25000 {
@@ -103,12 +110,17 @@
 			#size-cells = <0>;
 			device_type = "network";
 			model = "TSEC";
+			gigabit;
+			coalescing;
+			rmon;
 			compatible = "gianfar";
 			reg = <25000 1000>;
-			local-mac-address = [ 00 E0 0C 00 73 01 ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <13 2 14 2 18 2>;
 			interrupt-parent = <40000>;
 			phy-handle = <2452001>;
+			interface = "GMII";
 		};
 
 		serial@4500 {
diff --git a/arch/powerpc/boot/dts/mpc8560ads.dts b/arch/powerpc/boot/dts/mpc8560ads.dts
index 2b16848..1b73392 100644
--- a/arch/powerpc/boot/dts/mpc8560ads.dts
+++ b/arch/powerpc/boot/dts/mpc8560ads.dts
@@ -65,6 +65,7 @@
 				linux,phandle = <2452000>;
 				interrupt-parent = <40000>;
 				interrupts = <35 1>;
+				flags = <0>;
 				reg = <0>;
 				device_type = "ethernet-phy";
 			};
@@ -72,6 +73,7 @@
 				linux,phandle = <2452001>;
 				interrupt-parent = <40000>;
 				interrupts = <35 1>;
+				flags = <0>;
 				reg = <1>;
 				device_type = "ethernet-phy";
 			};
@@ -79,6 +81,7 @@
 				linux,phandle = <2452002>;
 				interrupt-parent = <40000>;
 				interrupts = <37 1>;
+				flags = <0>;
 				reg = <2>;
 				device_type = "ethernet-phy";
 			};
@@ -86,6 +89,7 @@
 				linux,phandle = <2452003>;
 				interrupt-parent = <40000>;
 				interrupts = <37 1>;
+				flags = <0>;
 				reg = <3>;
 				device_type = "ethernet-phy";
 			};
@@ -94,12 +98,17 @@
 		ethernet@24000 {
 			device_type = "network";
 			model = "TSEC";
+			gigabit;
+			coalescing;
+			rmon;
 			compatible = "gianfar";
 			reg = <24000 1000>;
-			address = [ 00 00 0C 00 00 FD ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <d 2 e 2 12 2>;
 			interrupt-parent = <40000>;
 			phy-handle = <2452000>;
+			interface = "GMII";
 		};
 
 		ethernet@25000 {
@@ -107,12 +116,17 @@
 			#size-cells = <0>;
 			device_type = "network";
 			model = "TSEC";
+			gigabit;
+			coalescing;
+			rmon;
 			compatible = "gianfar";
 			reg = <25000 1000>;
-			address = [ 00 00 0C 00 01 FD ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <13 2 14 2 18 2>;
 			interrupt-parent = <40000>;
 			phy-handle = <2452001>;
+			interface = "GMII";
 		};
 
 		pci@8000 {
diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index f0c7731..0fc46fa 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -91,6 +91,7 @@
 				linux,phandle = <2452000>;
 				interrupt-parent = <40000>;
 				interrupts = <4a 1>;
+				flags = <0>;
 				reg = <0>;
 				device_type = "ethernet-phy";
 			};
@@ -98,6 +99,7 @@
 				linux,phandle = <2452001>;
 				interrupt-parent = <40000>;
 				interrupts = <4a 1>;
+				flags = <0>;
 				reg = <1>;
 				device_type = "ethernet-phy";
 			};
@@ -105,6 +107,7 @@
 				linux,phandle = <2452002>;
 				interrupt-parent = <40000>;
 				interrupts = <4a 1>;
+				flags = <0>;
 				reg = <2>;
 				device_type = "ethernet-phy";
 			};
@@ -112,6 +115,7 @@
 				linux,phandle = <2452003>;
 				interrupt-parent = <40000>;
 				interrupts = <4a 1>;
+				flags = <0>;
 				reg = <3>;
 				device_type = "ethernet-phy";
 			};
@@ -121,52 +125,104 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			device_type = "network";
-			model = "TSEC";
+			model = "eTSEC";
+			gigabit;
+			coalescing;
+			rmon;
+			vlan;
+			extended-hash;
+			padding;
+			filer;
+			parseL4;
+			parseL3;
+			parseL2;
+			multi-queue;
 			compatible = "gianfar";
 			reg = <24000 1000>;
-			mac-address = [ 00 E0 0C 00 73 00 ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <1d 2 1e 2 22 2>;
 			interrupt-parent = <40000>;
 			phy-handle = <2452000>;
+			interface = "GMII";
 		};
 
 		ethernet@25000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			device_type = "network";
-			model = "TSEC";
+			model = "eTSEC";
+			gigabit;
+			coalescing;
+			rmon;
+			vlan;
+			extended-hash;
+			padding;
+			filer;
+			parseL4;
+			parseL3;
+			parseL2;
+			multi-queue;
 			compatible = "gianfar";
 			reg = <25000 1000>;
-			mac-address = [ 00 E0 0C 00 73 01 ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <23 2 24 2 28 2>;
 			interrupt-parent = <40000>;
 			phy-handle = <2452001>;
+			interface = "GMII";
 		};
 		
 		ethernet@26000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			device_type = "network";
-			model = "TSEC";
+			model = "eTSEC";
+			gigabit;
+			coalescing;
+			rmon;
+			vlan;
+			extended-hash;
+			padding;
+			filer;
+			parseL4;
+			parseL3;
+			parseL2;
+			multi-queue;
 			compatible = "gianfar";
 			reg = <26000 1000>;
-			mac-address = [ 00 E0 0C 00 02 FD ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <1F 2 20 2 21 2>;
 			interrupt-parent = <40000>;
 			phy-handle = <2452002>;
+			interface = "GMII";
 		};
 
 		ethernet@27000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			device_type = "network";
-			model = "TSEC";
+			model = "eTSEC";
+			gigabit;
+			coalescing;
+			rmon;
+			vlan;
+			extended-hash;
+			padding;
+			filer;
+			parseL4;
+			parseL3;
+			parseL2;
+			multi-queue;
 			compatible = "gianfar";
 			reg = <27000 1000>;
-			mac-address = [ 00 E0 0C 00 03 FD ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <25 2 26 2 27 2>;
 			interrupt-parent = <40000>;
 			phy-handle = <2452003>;
+			interface = "GMII";
 		};
 		serial@4500 {
 			device_type = "serial";
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index ad31e56..c827c04 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -6,6 +6,9 @@
  * 2006 (c) MontaVista Software, Inc.
  * Vitaly Bordug <vbordug@ru.mvista.com>
  *
+ * 2006 (c) Freescale Semiconductor, Inc
+ * Andy Fleming
+ *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
  * Free Software Foundation;  either version 2 of the  License, or (at your
@@ -178,58 +181,169 @@ static const char *gfar_tx_intr = "tx";
 static const char *gfar_rx_intr = "rx";
 static const char *gfar_err_intr = "error";
 
+/* Returns a bitfield with the appropriate flasgs set,
+ * based on the device tree */
+static int __init gfar_get_flags(struct device_node *np)
+{
+	int device_flags = 0;
+
+	if (get_property(np, "gigabit", NULL) != NULL)
+		device_flags |= FSL_GIANFAR_DEV_HAS_GIGABIT;
+
+	if (get_property(np, "coalescing", NULL) != NULL)
+		device_flags |= FSL_GIANFAR_DEV_HAS_COALESCE;
+
+	if (get_property(np, "rmon", NULL) != NULL)
+		device_flags |= FSL_GIANFAR_DEV_HAS_RMON;
+
+	if (get_property(np, "checksumming", NULL) != NULL)
+		device_flags |= FSL_GIANFAR_DEV_HAS_CSUM;
+
+	if (get_property(np, "vlan", NULL) != NULL)
+		device_flags |= FSL_GIANFAR_DEV_HAS_VLAN;
+
+	if (get_property(np, "extended-hash", NULL) != NULL)
+		device_flags |= FSL_GIANFAR_DEV_HAS_EXTENDED_HASH;
+
+	if (get_property(np, "padding", NULL) != NULL)
+		device_flags |= FSL_GIANFAR_DEV_HAS_PADDING;
+
+	if (get_property(np, "filer", NULL) != NULL)
+		device_flags |= FSL_GIANFAR_DEV_HAS_FILER;
+
+	if (get_property(np, "parseL4", NULL) != NULL)
+		device_flags |= FSL_GIANFAR_DEV_HAS_PARSE_L4;
+
+	if (get_property(np, "parseL3", NULL) != NULL)
+		device_flags |= FSL_GIANFAR_DEV_HAS_PARSE_L3;
+
+	if (get_property(np, "parseL2", NULL) != NULL)
+		device_flags |= FSL_GIANFAR_DEV_HAS_PARSE_L2;
+
+	if (get_property(np, "multi-queue", NULL) != NULL)
+		device_flags |= FSL_GIANFAR_DEV_HAS_MULTI_QUEUE;
+
+	return device_flags;
+}
+
+static struct device_node * __init gfar_get_phy_node(struct device_node *np)
+{
+	const phandle *ph;
+	struct device_node *phy;
+
+	ph = get_property(np, "phy-handle", NULL);
+	if (ph == NULL)
+		return NULL;
+
+	phy = of_find_node_by_phandle(*ph);
+
+	return phy;
+}
+
+/* Set the phy_id field of gfar_data to the address of the PHY
+ * Set the bus_id field of gfar_data to the memory address of the mdio bus
+ * Set the phy_flags field of gfar_data to passed in values
+ *
+ * returns 0 on success
+ */
+static int __init gfar_set_phy_info(struct device_node *np,
+		int *phy_id, int *bus_id, int *phy_flags)
+{
+	struct resource res;
+	struct device_node *phy;
+	struct device_node *mdio;
+	const unsigned int *id;
+	const unsigned int *flags;
+	int ret;
+
+	phy = gfar_get_phy_node(np);
+	if (phy == NULL)
+		return -1;
+
+	/* Get the PHY address, the parent MDIO bus,
+	 * and the phy flags, then release the phy node */
+	id = get_property(phy, "reg", NULL);
+	flags = get_property(phy, "flags", NULL);
+	mdio = of_get_parent(phy);
+
+	/* We're done with the phy node, now */
+	of_node_put(phy);
+
+	/* Set the PHY address */
+	if (id == NULL)
+		return -1;
+
+	*phy_id = *id;
+
+	/* Set the flags */
+	if (flags == NULL)
+		return -1;
+
+	*phy_flags = *flags;
+
+	/* Set the bus id */
+	if (mdio == NULL)
+		return -1;
+
+	ret = of_address_to_resource(mdio, 0, &res);
+	of_node_put(mdio);
+	if (ret)
+		return -1;
+
+	*bus_id = res.start;
 
+	return 0;
+}
+  
 static int __init gfar_of_init(void)
 {
 	struct device_node *np;
-	unsigned int i;
+	unsigned int num;
 	struct platform_device *gfar_dev;
-	struct resource res;
 	int ret;
 
-	for (np = NULL, i = 0;
+	for (np = NULL, num = 0;
 	     (np = of_find_compatible_node(np, "network", "gianfar")) != NULL;
-	     i++) {
+	     num++) {
 		struct resource r[4];
-		struct device_node *phy, *mdio;
 		struct gianfar_platform_data gfar_data;
-		const unsigned int *id;
-		const char *model;
 		const void *mac_addr;
-		const phandle *ph;
-		int n_res = 2;
+		int n_res = 0;
 
 		memset(r, 0, sizeof(r));
 		memset(&gfar_data, 0, sizeof(gfar_data));
 
 		ret = of_address_to_resource(np, 0, &r[0]);
-		if (ret)
-			goto err;
+		if (ret) {
+			printk("gfar %d's address lookup failed\n", num);
+			continue;
+		}
 
-		of_irq_to_resource(np, 0, &r[1]);
+		gfar_data.device_flags = gfar_get_flags(np);
 
-		model = get_property(np, "model", NULL);
+		/* Map all the irq resources, and set n_res to
+		 * the number of irqs plus 1 (which is the total
+		 * number of resources) */
+		while (n_res < 4 &&
+			of_irq_to_resource(np, n_res, &r[++n_res]) != NO_IRQ);
+		if (n_res < 2) {
+			printk("No interrupts found for gfar %d\n", num);
+			continue;
+		}
 
-		/* If we aren't the FEC we have multiple interrupts */
-		if (model && strcasecmp(model, "FEC")) {
+		/* If we have 3 interrupts, name them, and set the flag */
+		if (n_res == 4) {
 			r[1].name = gfar_tx_intr;
-
 			r[2].name = gfar_rx_intr;
-			of_irq_to_resource(np, 1, &r[2]);
-
 			r[3].name = gfar_err_intr;
-			of_irq_to_resource(np, 2, &r[3]);
 
-			n_res += 2;
-		}
-
-		gfar_dev =
-		    platform_device_register_simple("fsl-gianfar", i, &r[0],
-						    n_res);
-
-		if (IS_ERR(gfar_dev)) {
-			ret = PTR_ERR(gfar_dev);
-			goto err;
+			gfar_data.device_flags |=
+				FSL_GIANFAR_DEV_HAS_MULTI_INTR;
+		} else if (n_res != 2) {
+			printk("gfar %d had an unexpected number"
+					"of interrupts (%d)\n",
+					num, n_res-1);
+			continue;
 		}
 
 		mac_addr = get_property(np, "local-mac-address", NULL);
@@ -243,60 +357,31 @@ static int __init gfar_of_init(void)
 		if (mac_addr)
 			memcpy(gfar_data.mac_addr, mac_addr, 6);
 
-		if (model && !strcasecmp(model, "TSEC"))
-			gfar_data.device_flags =
-			    FSL_GIANFAR_DEV_HAS_GIGABIT |
-			    FSL_GIANFAR_DEV_HAS_COALESCE |
-			    FSL_GIANFAR_DEV_HAS_RMON |
-			    FSL_GIANFAR_DEV_HAS_MULTI_INTR;
-		if (model && !strcasecmp(model, "eTSEC"))
-			gfar_data.device_flags =
-			    FSL_GIANFAR_DEV_HAS_GIGABIT |
-			    FSL_GIANFAR_DEV_HAS_COALESCE |
-			    FSL_GIANFAR_DEV_HAS_RMON |
-			    FSL_GIANFAR_DEV_HAS_MULTI_INTR |
-			    FSL_GIANFAR_DEV_HAS_CSUM |
-			    FSL_GIANFAR_DEV_HAS_VLAN |
-			    FSL_GIANFAR_DEV_HAS_EXTENDED_HASH;
-
-		ph = get_property(np, "phy-handle", NULL);
-		phy = of_find_node_by_phandle(*ph);
+		ret = gfar_set_phy_info(np, &gfar_data.phy_id,
+				&gfar_data.bus_id, &gfar_data.phy_flags);
+  		if (ret) {
+			printk("gfar %d failed to set PHY info\n", num);
+			continue;
+  		}
 
-		if (phy == NULL) {
-			ret = -ENODEV;
-			goto unreg;
+		gfar_dev = platform_device_register_simple("fsl-gianfar",
+				num, &r[0], n_res);
+		if (IS_ERR(gfar_dev)) {
+			printk("Failed to register gfar %d due to error %ld\n",
+					num, PTR_ERR(gfar_dev));
+			continue;
 		}
 
-		mdio = of_get_parent(phy);
-
-		id = get_property(phy, "reg", NULL);
-		ret = of_address_to_resource(mdio, 0, &res);
+		ret = platform_device_add_data(gfar_dev, &gfar_data,
+				sizeof(struct gianfar_platform_data));
 		if (ret) {
-			of_node_put(phy);
-			of_node_put(mdio);
-			goto unreg;
+			printk("gfar %d data not added\n", num);
+			platform_device_unregister(gfar_dev);
 		}
-
-		gfar_data.phy_id = *id;
-		gfar_data.bus_id = res.start;
-
-		of_node_put(phy);
-		of_node_put(mdio);
-
-		ret =
-		    platform_device_add_data(gfar_dev, &gfar_data,
-					     sizeof(struct
-						    gianfar_platform_data));
-		if (ret)
-			goto unreg;
 	}
 
 	return 0;
 
-unreg:
-	platform_device_unregister(gfar_dev);
-err:
-	return ret;
 }
 
 arch_initcall(gfar_of_init);
@@ -304,13 +389,13 @@ arch_initcall(gfar_of_init);
 static int __init fsl_i2c_of_init(void)
 {
 	struct device_node *np;
-	unsigned int i;
+	unsigned int num;
 	struct platform_device *i2c_dev;
 	int ret;
 
-	for (np = NULL, i = 0;
+	for (np = NULL, num = 0;
 	     (np = of_find_compatible_node(np, "i2c", "fsl-i2c")) != NULL;
-	     i++) {
+	     num++) {
 		struct resource r[2];
 		struct fsl_i2c_platform_data i2c_data;
 		const unsigned char *flags = NULL;
@@ -319,15 +404,22 @@ static int __init fsl_i2c_of_init(void)
 		memset(&i2c_data, 0, sizeof(i2c_data));
 
 		ret = of_address_to_resource(np, 0, &r[0]);
-		if (ret)
-			goto err;
+		if (ret) {
+			printk("i2c %d could not map registers\n", num);
+			continue;
+		}
 
-		of_irq_to_resource(np, 0, &r[1]);
+		ret = of_irq_to_resource(np, 0, &r[1]);
+		if (ret == NO_IRQ) {
+			printk("i2c %d could not map irq\n", num);
+			continue;
+		}
 
-		i2c_dev = platform_device_register_simple("fsl-i2c", i, r, 2);
+		i2c_dev = platform_device_register_simple("fsl-i2c", num, r, 2);
 		if (IS_ERR(i2c_dev)) {
-			ret = PTR_ERR(i2c_dev);
-			goto err;
+			printk("Failed to register i2c %d due to error %ld\n",
+					num, PTR_ERR(i2c_dev));
+			continue;
 		}
 
 		i2c_data.device_flags = 0;
@@ -339,20 +431,15 @@ static int __init fsl_i2c_of_init(void)
 		if (flags)
 			i2c_data.device_flags |= FSL_I2C_DEV_CLOCK_5200;
 
-		ret =
-		    platform_device_add_data(i2c_dev, &i2c_data,
-					     sizeof(struct
-						    fsl_i2c_platform_data));
-		if (ret)
-			goto unreg;
+		ret = platform_device_add_data(i2c_dev, &i2c_data,
+				     sizeof(struct fsl_i2c_platform_data));
+		if (ret) {
+			printk("i2c %d data not added\n", num);
+			platform_device_unregister(i2c_dev);
+		}
 	}
 
 	return 0;
-
-unreg:
-	platform_device_unregister(i2c_dev);
-err:
-	return ret;
 }
 
 arch_initcall(fsl_i2c_of_init);
@@ -436,41 +523,44 @@ static enum fsl_usb2_phy_modes determine
 	return FSL_USB2_PHY_NONE;
 }
 
-static int __init fsl_usb_of_init(void)
+
+static void fsl_usb_of_init_one(struct device_node *np, unsigned int num,
+		enum fsl_usb2_operating_modes mode)
 {
-	struct device_node *np;
-	unsigned int i;
-	struct platform_device *usb_dev_mph = NULL, *usb_dev_dr = NULL;
+	struct resource r[2];
+	struct fsl_usb2_platform_data usb_data;
+	const unsigned char *prop = NULL;
+	struct platform_device *usb_dev = NULL;
 	int ret;
 
-	for (np = NULL, i = 0;
-	     (np = of_find_compatible_node(np, "usb", "fsl-usb2-mph")) != NULL;
-	     i++) {
-		struct resource r[2];
-		struct fsl_usb2_platform_data usb_data;
-		const unsigned char *prop = NULL;
-
-		memset(&r, 0, sizeof(r));
-		memset(&usb_data, 0, sizeof(usb_data));
+	memset(&r, 0, sizeof(r));
+	memset(&usb_data, 0, sizeof(usb_data));
 
-		ret = of_address_to_resource(np, 0, &r[0]);
-		if (ret)
-			goto err;
+	ret = of_address_to_resource(np, 0, &r[0]);
+	if (ret) {
+		printk("usb %d could not map registers\n", num);
+		return;
+	}
 
-		of_irq_to_resource(np, 0, &r[1]);
+	ret = of_irq_to_resource(np, 0, &r[1]);
+	if (ret == NO_IRQ) {
+		printk("usb %d could not map irq\n", num);
+		return;
+	}
 
-		usb_dev_mph =
-		    platform_device_register_simple("fsl-ehci", i, r, 2);
-		if (IS_ERR(usb_dev_mph)) {
-			ret = PTR_ERR(usb_dev_mph);
-			goto err;
-		}
+	usb_dev = platform_device_register_simple("fsl-ehci", num, r, 2);
+	if (IS_ERR(usb_dev)) {
+		printk("usb %d register failed with error %ld\n",
+				num, PTR_ERR(usb_dev));
+		return;
+	}
 
-		usb_dev_mph->dev.coherent_dma_mask = 0xffffffffUL;
-		usb_dev_mph->dev.dma_mask = &usb_dev_mph->dev.coherent_dma_mask;
+	usb_dev->dev.coherent_dma_mask = 0xffffffffUL;
+	usb_dev->dev.dma_mask = &usb_dev->dev.coherent_dma_mask;
 
-		usb_data.operating_mode = FSL_USB2_MPH_HOST;
+	usb_data.operating_mode = mode;
 
+	if (mode == FSL_USB2_DR_HOST) {
 		prop = get_property(np, "port0", NULL);
 		if (prop)
 			usb_data.port_enables |= FSL_USB2_PORT0_ENABLED;
@@ -478,66 +568,36 @@ static int __init fsl_usb_of_init(void)
 		prop = get_property(np, "port1", NULL);
 		if (prop)
 			usb_data.port_enables |= FSL_USB2_PORT1_ENABLED;
-
-		prop = get_property(np, "phy_type", NULL);
-		usb_data.phy_mode = determine_usb_phy(prop);
-
-		ret =
-		    platform_device_add_data(usb_dev_mph, &usb_data,
-					     sizeof(struct
-						    fsl_usb2_platform_data));
-		if (ret)
-			goto unreg_mph;
 	}
 
-	for (np = NULL;
-	     (np = of_find_compatible_node(np, "usb", "fsl-usb2-dr")) != NULL;
-	     i++) {
-		struct resource r[2];
-		struct fsl_usb2_platform_data usb_data;
-		const unsigned char *prop = NULL;
-
-		memset(&r, 0, sizeof(r));
-		memset(&usb_data, 0, sizeof(usb_data));
+	prop = get_property(np, "phy_type", NULL);
+	usb_data.phy_mode = determine_usb_phy(prop);
 
-		ret = of_address_to_resource(np, 0, &r[0]);
-		if (ret)
-			goto unreg_mph;
+	ret = platform_device_add_data(usb_dev, &usb_data,
+			sizeof(struct fsl_usb2_platform_data));
+	if (ret) {
+		printk("usb %d failed to add data\n", num);
+		platform_device_unregister(usb_dev);
+	}
+}
 
-		of_irq_to_resource(np, 0, &r[1]);
 
-		usb_dev_dr =
-		    platform_device_register_simple("fsl-ehci", i, r, 2);
-		if (IS_ERR(usb_dev_dr)) {
-			ret = PTR_ERR(usb_dev_dr);
-			goto err;
-		}
-
-		usb_dev_dr->dev.coherent_dma_mask = 0xffffffffUL;
-		usb_dev_dr->dev.dma_mask = &usb_dev_dr->dev.coherent_dma_mask;
+static int __init fsl_usb_of_init(void)
+{
+	struct device_node *np;
+	unsigned int num;
 
-		usb_data.operating_mode = FSL_USB2_DR_HOST;
+	for (np = NULL, num = 0;
+	     (np = of_find_compatible_node(np, "usb", "fsl-usb2-mph")) != NULL;
+	     num++)
+		fsl_usb_of_init_one(np, num, FSL_USB2_MPH_HOST);
 
-		prop = get_property(np, "phy_type", NULL);
-		usb_data.phy_mode = determine_usb_phy(prop);
+	for (np = NULL;
+	     (np = of_find_compatible_node(np, "usb", "fsl-usb2-dr")) != NULL;
+	     num++)
+		fsl_usb_of_init_one(np, num, FSL_USB2_DR_HOST);
 
-		ret =
-		    platform_device_add_data(usb_dev_dr, &usb_data,
-					     sizeof(struct
-						    fsl_usb2_platform_data));
-		if (ret)
-			goto unreg_dr;
-	}
 	return 0;
-
-unreg_dr:
-	if (usb_dev_dr)
-		platform_device_unregister(usb_dev_dr);
-unreg_mph:
-	if (usb_dev_mph)
-		platform_device_unregister(usb_dev_mph);
-err:
-	return ret;
 }
 
 arch_initcall(fsl_usb_of_init);
@@ -587,7 +647,11 @@ static int __init fs_enet_of_init(void)
 		r[2].name = fcc_regs_c;
 		fs_enet_data.fcc_regs_c = r[2].start;
 
-		of_irq_to_resource(np, 0, &r[3]);
+		ret = of_irq_to_resource(np, 0, &r[3]);
+		if (ret == NO_IRQ) {
+			ret = -EINVAL;
+			goto err;
+		}
 
 		fs_enet_dev =
 		    platform_device_register_simple("fsl-cpm-fcc", i, &r[0], 4);
@@ -749,7 +813,11 @@ static int __init cpm_uart_of_init(void)
 			goto err;
 		r[1].name = scc_pram;
 
-		of_irq_to_resource(np, 0, &r[2]);
+		ret = of_irq_to_resource(np, 0, &r[2]);
+		if (ret == NO_IRQ) {
+			ret = -EINVAL;
+			goto err;
+		}
 
 		cpm_uart_dev =
 		    platform_device_register_simple("fsl-cpm-scc:uart", i, &r[0], 3);
diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
index 3da29e2..910b0eb 100644
--- a/include/linux/fsl_devices.h
+++ b/include/linux/fsl_devices.h
@@ -49,8 +49,10 @@ struct gianfar_platform_data {
 	u32	device_flags;
 	/* board specific information */
 	u32	board_flags;
+	u32	interface;
 	u32	bus_id;
 	u32	phy_id;
+	u32	phy_flags;
 	u8	mac_addr[6];
 };
 
@@ -68,10 +70,14 @@ #define FSL_GIANFAR_DEV_HAS_CSUM		0x0000
 #define FSL_GIANFAR_DEV_HAS_VLAN		0x00000020
 #define FSL_GIANFAR_DEV_HAS_EXTENDED_HASH	0x00000040
 #define FSL_GIANFAR_DEV_HAS_PADDING		0x00000080
+#define FSL_GIANFAR_DEV_HAS_FILER		0x00000100
+#define FSL_GIANFAR_DEV_HAS_PARSE_L2		0x00000200
+#define FSL_GIANFAR_DEV_HAS_PARSE_L3		0x00000300
+#define FSL_GIANFAR_DEV_HAS_PARSE_L4		0x00000400
+#define FSL_GIANFAR_DEV_HAS_MULTI_QUEUE		0x00000800
 
 /* Flags in gianfar_platform_data */
 #define FSL_GIANFAR_BRD_HAS_PHY_INTR	0x00000001 /* set or use a timer */
-#define FSL_GIANFAR_BRD_IS_REDUCED	0x00000002 /* Set if RGMII, RMII */
 
 struct fsl_i2c_platform_data {
 	/* device specific information */
-- 
1.4.2.3
