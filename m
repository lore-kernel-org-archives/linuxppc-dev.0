Return-Path: <b20052@nmglablinux22.freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 060A82C00CB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Aug 2013 21:02:54 +1000 (EST)
From: Shaveta Leekha <shaveta@freescale.com>
To: <devicetree-discuss@lists.ozlabs.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] Add device file bindings for MAPLE
Date: Thu, 1 Aug 2013 16:32:43 +0530
Message-ID: <1375354963-11219-1-git-send-email-shaveta@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shaveta Leekha <shaveta@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Shaveta Leekha <shaveta@freescale.com>
---
 .../devicetree/bindings/powerpc/fsl/maple.txt      |   30 ++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/maple.txt

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/maple.txt b/Documentation/devicetree/bindings/powerpc/fsl/maple.txt
new file mode 100644
index 0000000..da51c5f
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/fsl/maple.txt
@@ -0,0 +1,30 @@
+* Freescale MAPLE Multi Accelerator Platform Engine Baseband 3
+  (MAPLE-B3)device nodes
+
+Supported chips:
+Example: B4860
+
+Required properties:
+
+- compatible:	Should contain "fsl,maple-b3-liodn" as the value
+		This identifies Multi Accelerator Platform Engine
+		Baseband 3 block.This representation is required
+		for doing the PAMU/LIODN programming on the Linux side.
+
+- reg:		offset and length of the register set for the device
+
+Devices that have LIODNs need to specify links to the parent PAMU controller
+(the actual PAMU controller that this device is connected to) and a pointer to
+the LIODN register, if applicable.
+
+- fsl,iommu-parent
+		: <phandle>
+		This property should be present
+
+Example:
+	/* B4860 */
+	maple@800000 {
+		compatible = "fsl,maple-b3-liodn";
+		reg = <0x8000000 0x10000>;
+		fsl,iommu-parent = <&pamu1>;
+	};
-- 
1.7.6.GIT
