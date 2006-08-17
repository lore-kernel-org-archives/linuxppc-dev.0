Return-Path: <jdl@jdl.com>
Received: from jdl.com (mail.jdl.com [66.118.10.122])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A641767BD8
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 23:42:39 +1000 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.44)
	id 1GDi8p-0002Nt-B9
	for linuxppc-dev@ozlabs.org; Thu, 17 Aug 2006 08:42:36 -0500
To: linuxppc-dev@ozlabs.org
Subject: [PATCH resend] Convert to mac-address for ethernet MAC address data.
Date: Thu, 17 Aug 2006 08:42:35 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1GDi8p-0002Nt-B9@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Also accept "local-mac-address".  However the old "address"
is now obsolete, but accepted for backwards compatibility.
It should be removed after all device trees have been
converted to use "mac-address".

Signed-off-by: Jon Loeliger <jdl@freescale.com>
---

This is a resend of
    Submitter	Jon Loeliger
    Date	2006-08-04 07:25:38
    Message ID	<1154640338.26770.34.camel@cashmere.sps.mot.com>

Also found here:
    http://ozlabs.org/pipermail/linuxppc-dev/2006-August/024851.html
    http://patchwork.ozlabs.org/linuxppc/patch?id=6444

And ACK'ed by Kumar here:
    http://ozlabs.org/pipermail/linuxppc-dev/2006-August/025169.html

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
