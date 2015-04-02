Return-Path: <sandeep@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7141D1A096D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 22:03:13 +1100 (AEDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0116.outbound.protection.outlook.com [157.56.110.116])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 818E3140083
 for <linuxppc-dev@ozlabs.org>; Thu,  2 Apr 2015 22:03:12 +1100 (AEDT)
Received: from localhost.localdomain (nmglablinux22.zin33.ap.freescale.net
 [10.232.20.244])
 by tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id t32Alvax002443
 for <linuxppc-dev@ozlabs.org>; Thu, 2 Apr 2015 03:47:59 -0700
From: <sandeep@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [1/3][PATCH][v2] Device Tree bindings for Freescale TDM controller
Date: Thu, 2 Apr 2015 16:17:57 +0530
Message-ID: <1427971677-32395-1-git-send-email-sandeep@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sandeep Singh <sandeep@freescale.com>

This controller is available on many Freescale SOCs like MPC8315, P1020, P1010,
P1022 and P1024

Signed-off-by: Sandeep Singh <Sandeep@freescale.com>
Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
---
 Documentation/devicetree/bindings/tdm/fsl-tdm.txt |   65 +++++++++++++++++++++
 1 files changed, 65 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/tdm/fsl-tdm.txt

diff --git a/Documentation/devicetree/bindings/tdm/fsl-tdm.txt b/Documentation/devicetree/bindings/tdm/fsl-tdm.txt
new file mode 100644
index 0000000..1258b89
--- /dev/null
+++ b/Documentation/devicetree/bindings/tdm/fsl-tdm.txt
@@ -0,0 +1,65 @@
+=====================================================================
+TDM Device Tree Binding
+Copyright (C) 2012 Freescale Semiconductor Inc.
+
+NOTE: The bindings described in this document are preliminary
+and subject to change.
+
+=====================================================================
+TDM (Time Division Multiplexing)
+
+DESCRIPTION
+
+The TDM is full duplex serial port designed to allow various devices including
+digital signal processors (DSPs) to communicate with a variety of serial devices
+including industry standard framers, codecs, other DSPs and microprocessors.
+
+The below properties describe the device tree bindings for Freescale TDM
+controller.
+This TDM controller is available on various Freescale Processors like
+MPC8313, P1020, P1022 and P1010.
+
+PROPERTIES
+
+  - compatible
+      Usage: required
+      Value type: <string>
+      Definition: Should contain "fsl,tdm1.0".
+
+  - reg
+      Usage: required
+      Definition: A standard property. The first reg specifier describes the
+          TDM registers, and the second describes the TDM DMAC registers.
+
+  - clock-frequency
+      Usage: optional
+      Value type: <u32 or u64>
+      Definition: The frequency at which the TDM block is operating.
+
+  - interrupts
+      Usage: required
+      Definition: Definition: Two interrupt specifiers.  The first is TDM
+          error, and the second is TDM EMAC.
+
+  - phy-handle
+      Usage: optional
+      Value type: <phandle>
+      Definition: Phandle of the line controller node or framer node eg. SLIC,
+          E1/T1 etc.
+
+  - fsl,max-time-slots
+      Usage: required
+      Value type: <u32>
+      Definition: Maximum number of 8-bit time slots in one TDM frame.
+          This is the maximum number which TDM hardware supports.
+
+EXAMPLE
+
+	tdm@16000 {
+		compatible = "fsl,tdm1.0";
+		reg = <0x16000 0x200 0x2c000 0x2000>;
+		clock-frequency = <0>;
+		interrupts = <16 8 62 8>;
+		phy-handle = <&zarlink1>;
+		fsl,max-time-slots = <128>;
+	};
-- 
1.7.6.GIT
