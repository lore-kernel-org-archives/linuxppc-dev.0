Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 19D6EB7CC2
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Mar 2010 08:42:53 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org
Subject: [PATCH] powerpc/fsl: add device tree binding for QE firmware
Date: Tue, 23 Mar 2010 16:42:32 -0500
Message-Id: <1269380552-10418-1-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Define a binding for embedding a QE firmware blob into the device tree.  Also
define a new property for the QE node that links to a firmware node.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 .../powerpc/dts-bindings/fsl/cpm_qe/qe.txt         |   50 ++++++++++++++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe.txt b/Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe.txt
index 6e37be1..d9d6431 100644
--- a/Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe.txt
+++ b/Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe.txt
@@ -20,6 +20,14 @@ Required properties:
 - fsl,qe-num-riscs: define how many RISC engines the QE has.
 - fsl,qe-num-snums: define how many serial number(SNUM) the QE can use for the
   threads.
+- fsl,firmware-phandle:
+    Usage: required
+    Value type: <phandle>
+    Definition: Points to a firmware node (see "QE Firmware Node" below)
+        that contains the firmware that should be uploaded for this QE.
+        The compatible property for the firmware node should say,
+        "fsl,qe-firmware".
+
 
 Recommended properties
 - brg-frequency : the internal clock source frequency for baud-rate
@@ -59,3 +67,45 @@ Example:
 		reg = <0 c000>;
 	};
      };
+
+* QE Firmware Node
+
+This node defines a firmware binary that is embedded in the device tree, for
+the purpose of passing the firmware from bootloader to the kernel, or from
+the hypervisor to the guest.
+
+The firmware node itself contains the firmware binary contents, a compatible
+property, and any firmware-specific properties.  The node itself can be located
+anywhere, but should probably be placed at the top level.  The QE node
+that needs the firmware should define a property that links to the firmware
+node's phandle.
+
+This node is typically not defined in the DTS.  Instead, the boot loader
+normally creates the node from scratch, using a firmware binary that is already
+located in non-volatile storage or transferred from a tftp server.
+
+Required properties:
+  - compatible
+      Usage: required
+      Value type: <string>
+      Definition: A standard property.  Specify a string that indicates what
+          kind of firmware it is.  For QE, this should be "fsl,qe-firmware".
+
+   - fsl,firmware
+      Usage: required
+      Value type: <prop-encoded-array>, encoded as an array of bytes
+      Definition: A standard property.  This property contains the firmware
+          binary "blob".
+
+Example:
+	qe@e0080000 {
+		compatible = "fsl,qe";
+		fsl,firmware-phandle = <&qe_firmware>;
+		...
+	}
+
+	qe_firmware:qe-firmware {
+		compatible = "fsl,qe-firmware";
+		fsl,firmware = <0x70 0xcd 0x00 0x00 0x01 0x46 0x45 0x63 ...>
+	}
+
-- 
1.6.5
