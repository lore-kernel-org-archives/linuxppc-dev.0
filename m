Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 73A7F67B7A
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Aug 2006 07:30:07 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k73LU69j001280
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Aug 2006 14:30:06 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k73LU5gV002243
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Aug 2006 16:30:05 -0500 (CDT)
Subject: [PATCH] Convert to mac-address for ethernet MAC address data.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1154640338.26770.34.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Thu, 03 Aug 2006 16:25:38 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

onvert to mac-address for ethernet MAC address data.

Also accept "local-mac-address".  However the old "address"
is now obsolete, but accepted for backwards compatibility.
It should be removed after all device trees have been
converted to use "mac-address".

Signed-off-by: Jon Loeliger <jdl@freescale.com>
---
 Documentation/powerpc/booting-without-of.txt |   10 +++++-----
 arch/powerpc/sysdev/fsl_soc.c                |   12 ++++++++++--
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 3c62e66..8c48b8a 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1196,7 +1196,7 @@ platforms are moved over to use the flat
     - model : Model of the device.  Can be "TSEC", "eTSEC", or "FEC"
     - compatible : Should be "gianfar"
     - reg : Offset and length of the register set for the device
-    - address : List of bytes representing the ethernet address of
+    - mac-address : List of bytes representing the ethernet address of
       this controller
     - interrupts : <a b> where a is the interrupt number and b is a
       field that represents an encoding of the sense and level
@@ -1216,7 +1216,7 @@ platforms are moved over to use the flat
 		model = "TSEC";
 		compatible = "gianfar";
 		reg = <24000 1000>;
-		address = [ 00 E0 0C 00 73 00 ];
+		mac-address = [ 00 E0 0C 00 73 00 ];
 		interrupts = <d 3 e 3 12 3>;
 		interrupt-parent = <40000>;
 		phy-handle = <2452000>
@@ -1498,7 +1498,7 @@ not necessary as they are usually the sa
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <24000 1000>;
-			address = [ 00 E0 0C 00 73 00 ];
+			mac-address = [ 00 E0 0C 00 73 00 ];
 			interrupts = <d 3 e 3 12 3>;
 			interrupt-parent = <40000>;
 			phy-handle = <2452000>;
@@ -1511,7 +1511,7 @@ not necessary as they are usually the sa
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <25000 1000>;
-			address = [ 00 E0 0C 00 73 01 ];
+			mac-address = [ 00 E0 0C 00 73 01 ];
 			interrupts = <13 3 14 3 18 3>;
 			interrupt-parent = <40000>;
 			phy-handle = <2452001>;
@@ -1524,7 +1524,7 @@ not necessary as they are usually the sa
 			model = "FEC";
 			compatible = "gianfar";
 			reg = <26000 1000>;
-			address = [ 00 E0 0C 00 73 02 ];
+			mac-address = [ 00 E0 0C 00 73 02 ];
 			interrupts = <19 3>;
 			interrupt-parent = <40000>;
 			phy-handle = <2452002>;
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 4a6aa64..92ba378 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -166,8 +166,16 @@ static int __init gfar_of_init(void)
 			goto err;
 		}
 
-		mac_addr = get_property(np, "address", NULL);
-		memcpy(gfar_data.mac_addr, mac_addr, 6);
+		mac_addr = get_property(np, "local-mac-address", NULL);
+		if (mac_addr == NULL)
+			mac_addr = get_property(np, "mac-address", NULL);
+		if (mac_addr == NULL) {
+			/* Obsolete */
+			mac_addr = get_property(np, "address", NULL);
+		}
+
+		if (mac_addr)
+			memcpy(gfar_data.mac_addr, mac_addr, 6);
 
 		if (model && !strcasecmp(model, "TSEC"))
 			gfar_data.device_flags =
-- 
2006_06_07.01.gittree_pull-dirty
