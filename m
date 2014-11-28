Return-Path: <madalin.bucur@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0113.outbound.protection.outlook.com [157.56.111.113])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AAE6E1A0B92
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Nov 2014 21:24:54 +1100 (AEDT)
From: Madalin Bucur <madalin.bucur@freescale.com>
To: <devicetree@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <netdev@vger.kernel.org>
Subject: [PATCH] Documentation: bindings: net: DPAA corenet binding document
Date: Fri, 28 Nov 2014 12:10:26 +0200
Message-ID: <1417169426-11823-1-git-send-email-madalin.bucur@freescale.com>
Reply-To: <madalin.bucur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Igal.Liberman@freescale.com,
 Emilian.Medve@freescale.com, Madalin Bucur <madalin.bucur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add the device tree binding document for the DPAA corenet node
and DPAA Ethernet nodes.

Signed-off-by: Madalin Bucur <madalin.bucur@freescale.com>
---
 Documentation/devicetree/bindings/net/fsl-dpaa.txt | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/fsl-dpaa.txt

diff --git a/Documentation/devicetree/bindings/net/fsl-dpaa.txt b/Documentation/devicetree/bindings/net/fsl-dpaa.txt
new file mode 100644
index 0000000..822c668
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/fsl-dpaa.txt
@@ -0,0 +1,31 @@
+*DPAA corenet
+
+The corenet bus containing all DPAA Ethernet nodes.
+
+Required property
+ - compatible: string property.  Must include "fsl,dpaa". Can include
+   also "fsl,<SoC>-dpaa".
+
+Example:
+
+fsl,dpaa {
+        compatible = "fsl,p4080-dpaa", "fsl,dpaa";
+};
+
+*DPAA Ethernet
+
+DPAA Ethernet implements an Ethernet interface on top of the functionality
+offered by the DPAA accelerators: QMan, BMan, FMan. It contains a reference
+to the FMan MAC node used (dTSEC, TGEC, MEMAC). This construct is used by
+u-boot for the boot-time device tree fix-up.
+
+Required properties
+ - compatible: standard string property. Must include "fsl,dpa-ethernet".
+ - fsl,fman-mac: phandle that references a node describing the used DPAA MAC.
+
+Example:
+
+ethernet0 {
+        compatible = "fsl,dpa-ethernet";
+        fsl,fman-mac = <&enet0>;
+};
-- 
1.7.11.7
