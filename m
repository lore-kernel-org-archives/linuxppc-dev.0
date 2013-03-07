Return-Path: <B37400@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 36EA02C03AA
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Mar 2013 22:28:07 +1100 (EST)
From: Sandeep Singh <Sandeep@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/4] Device Tree bindings for Freescale TDM controller
Date: Thu, 7 Mar 2013 16:57:46 +0530
Message-ID: <1362655668-26721-2-git-send-email-Sandeep@freescale.com>
In-Reply-To: <1362655668-26721-1-git-send-email-Sandeep@freescale.com>
References: <1362655668-26721-1-git-send-email-Sandeep@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Sandeep Singh <Sandeep@freescale.com>,
 Poonam Aggrwal <poonam.aggrwal@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

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
