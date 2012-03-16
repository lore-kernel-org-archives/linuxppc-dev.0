Return-Path: <b10812@nmglablinux19.freescale.com>
From: Poonam Aggrwal <poonam.aggrwal@freescale.com>
To: <devicetree-discuss@lists.ozlabs.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] Device Tree Bindings for Freescale TDM controller 
Date: Fri, 16 Mar 2012 07:00:51 +0530
Message-ID: <1331861451-15427-1-git-send-email-poonam.aggrwal@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Sandeep Singh <Sandeep@freescale.com>,
 Poonam Aggrwal <poonam.aggrwal@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Poonam Aggrwal <poonam.aggrwal@freescale.com> 

This TDM controller is available in various Freescale SOCs like MPC8315, P1020,
P1022, P1010.

Signed-off-by: Sandeep Singh <Sandeep@freescale.com>
Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
---
 Documentation/devicetree/bindings/tdm/fsl-tdm.txt |   71 +++++++++++++++++++++
 1 files changed, 71 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/tdm/fsl-tdm.txt

diff --git a/Documentation/devicetree/bindings/tdm/fsl-tdm.txt b/Documentation/devicetree/bindings/tdm/fsl-tdm.txt
new file mode 100644
index 0000000..61431e3
--- /dev/null
+++ b/Documentation/devicetree/bindings/tdm/fsl-tdm.txt
@@ -0,0 +1,71 @@
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
+      Definition: Should contain "fsl,mpc8315-tdm".
+	  So mpc8313 will have compatible = "fsl,mpc8315-tdm";
+	  p1010 will have compatible "fsl,p1010-tdm", "fsl,mpc8315-tdm";
+
+  - reg
+      Usage: required
+      Value type: <tdm-reg-offset tdm-reg-size dmac-reg-offset dmac-reg-size>
+      Definition: A standard property. Specifies the physical address
+	  offset and length of the TDM registers and TDM DMAC registers for
+	  the device.
+
+  - clock-frequency
+      Usage: optional
+      Value type: <u32>
+      Definition: The frequency at which the TDM block is operating.
+
+  - interrupts
+      Usage: required
+      Value type: <tdm-err-intr tdm-err-intr-type dmac-intr dmac-intr-type>
+      Definition: This field defines two interrupt specifiers namely interrupt
+	  number and interrupt type for TDM error and TDM DMAC.
+
+  - phy-handle
+      Usage: optional
+      Value type: <phandle>
+      Definition: Phandle of the line controller node or framer node eg. SLIC,
+	  E1\T1 etc.
+
+  - fsl-max-time-slots
+      Usage: required
+      Value type: <u32>
+      Definition: Maximum number of 8-bit time slots in one TDM frame.
+	  This is the maximum number which TDM hardware supports.
+
+EXAMPLE
+
+	tdm@16000 {
+		device_type = "tdm";
+		compatible = "fsl,p1010-tdm", "fsl,mpc8315-tdm";
+		reg = <0x16000 0x200 0x2c000 0x2000>;
+		clock-frequency = <0>;
+		interrupts = <16 8 62 8>;
+		phy-handle = <zarlink1>
+		fsl-max-time-slots = <128>
+	};
-- 
1.5.6.5
