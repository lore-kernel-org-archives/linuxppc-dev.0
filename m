Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F04FEDDDA9
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Apr 2009 07:59:30 +1100 (EST)
Date: Fri, 3 Apr 2009 15:58:46 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH] pq2fads: Update device tree for use with device-tree-aware
	u-boot.
Message-ID: <20090403205846.GA20155@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add aliases, and correct CS0 offset to match how u-boot
programs it (this was not a problem with cuImage because
the wrapper would reprogram the localbus to match the device
tree).

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/dts/pq2fads.dts |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/boot/dts/pq2fads.dts b/arch/powerpc/boot/dts/pq2fads.dts
index b2d6109..0bb6693 100644
--- a/arch/powerpc/boot/dts/pq2fads.dts
+++ b/arch/powerpc/boot/dts/pq2fads.dts
@@ -17,6 +17,14 @@
 	#address-cells = <1>;
 	#size-cells = <1>;
 
+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -45,7 +53,7 @@
 		#size-cells = <1>;
 		reg = <0xf0010100 0x60>;
 
-		ranges = <0x0 0x0 0xfe000000 0x800000
+		ranges = <0x0 0x0 0xff800000 0x800000
 		          0x1 0x0 0xf4500000 0x8000
 		          0x8 0x0 0xf8200000 0x8000>;
 
@@ -71,7 +79,7 @@
 		};
 	};
 
-	pci@f0010800 {
+	pci0: pci@f0010800 {
 		device_type = "pci";
 		reg = <0xf0010800 0x10c 0xf00101ac 0x8 0xf00101c4 0x8>;
 		compatible = "fsl,mpc8280-pci", "fsl,pq2-pci";
@@ -142,7 +150,7 @@
 				reg = <0x119f0 0x10 0x115f0 0x10>;
 			};
 
-			serial@11a00 {
+			serial0: serial@11a00 {
 				device_type = "serial";
 				compatible = "fsl,mpc8280-scc-uart",
 				             "fsl,cpm2-scc-uart";
@@ -153,7 +161,7 @@
 				fsl,cpm-command = <0x800000>;
 			};
 
-			serial@11a20 {
+			serial1: serial@11a20 {
 				device_type = "serial";
 				compatible = "fsl,mpc8280-scc-uart",
 				             "fsl,cpm2-scc-uart";
@@ -164,7 +172,7 @@
 				fsl,cpm-command = <0x4a00000>;
 			};
 
-			ethernet@11320 {
+			enet0: ethernet@11320 {
 				device_type = "network";
 				compatible = "fsl,mpc8280-fcc-enet",
 				             "fsl,cpm2-fcc-enet";
@@ -176,7 +184,7 @@
 				fsl,cpm-command = <0x16200300>;
 			};
 
-			ethernet@11340 {
+			enet1: ethernet@11340 {
 				device_type = "network";
 				compatible = "fsl,mpc8280-fcc-enet",
 				             "fsl,cpm2-fcc-enet";
-- 
1.5.6.rc1.6.gc53ad.dirty
