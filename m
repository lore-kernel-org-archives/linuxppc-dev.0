Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1C38DDDEF2
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jul 2008 09:13:17 +1000 (EST)
Date: Fri, 11 Jul 2008 18:04:43 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 4/6] Add fsl,magic-packet to, and clean up, the gianfar
	binding.
Message-ID: <20080711230443.GC3854@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080711230328.GA3835@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 Documentation/powerpc/dts-bindings/fsl/tsec.txt |   31 +++++++++--------------
 1 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/Documentation/powerpc/dts-bindings/fsl/tsec.txt b/Documentation/powerpc/dts-bindings/fsl/tsec.txt
index 583ef6b..cf55fa4 100644
--- a/Documentation/powerpc/dts-bindings/fsl/tsec.txt
+++ b/Documentation/powerpc/dts-bindings/fsl/tsec.txt
@@ -24,46 +24,39 @@ Example:
 
 * Gianfar-compatible ethernet nodes
 
-Required properties:
+Properties:
 
   - device_type : Should be "network"
   - model : Model of the device.  Can be "TSEC", "eTSEC", or "FEC"
   - compatible : Should be "gianfar"
   - reg : Offset and length of the register set for the device
-  - mac-address : List of bytes representing the ethernet address of
+  - local-mac-address : List of bytes representing the ethernet address of
     this controller
-  - interrupts : <a b> where a is the interrupt number and b is a
-    field that represents an encoding of the sense and level
-    information for the interrupt.  This should be encoded based on
-    the information in section 2) depending on the type of interrupt
-    controller you have.
-  - interrupt-parent : the phandle for the interrupt controller that
-    services interrupts for this device.
+  - interrupts : For FEC devices, the first interrupt is the device's
+    interrupt.  For TSEC and eTSEC devices, the first interrupt is
+    transmit, the second is receive, and the third is error.
   - phy-handle : The phandle for the PHY connected to this ethernet
     controller.
   - fixed-link : <a b c d e> where a is emulated phy id - choose any,
     but unique to the all specified fixed-links, b is duplex - 0 half,
     1 full, c is link speed - d#10/d#100/d#1000, d is pause - 0 no
     pause, 1 pause, e is asym_pause - 0 no asym_pause, 1 asym_pause.
-
-Recommended properties:
-
   - phy-connection-type : a string naming the controller/PHY interface type,
     i.e., "mii" (default), "rmii", "gmii", "rgmii", "rgmii-id", "sgmii",
     "tbi", or "rtbi".  This property is only really needed if the connection
     is of type "rgmii-id", as all other connection types are detected by
     hardware.
-
+  - fsl,magic-packet : If present, indicates that the hardware supports
+    waking up via magic packet.
 
 Example:
 	ethernet@24000 {
-		#size-cells = <0>;
 		device_type = "network";
 		model = "TSEC";
 		compatible = "gianfar";
-		reg = <24000 1000>;
-		mac-address = [ 00 E0 0C 00 73 00 ];
-		interrupts = <d 3 e 3 12 3>;
-		interrupt-parent = <40000>;
-		phy-handle = <2452000>
+		reg = <0x24000 0x1000>;
+		local-mac-address = [ 00 E0 0C 00 73 00 ];
+		interrupts = <29 2 30 2 34 2>;
+		interrupt-parent = <&mpic>;
+		phy-handle = <&phy0>
 	};
-- 
1.5.6.rc1.6.gc53ad.dirty
