Return-Path: <galak@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] powerpc/85xx: Add binding for LAWs and MCM
Date: Mon, 27 Apr 2009 15:38:44 -0500
Message-Id: <1240864725-29003-1-git-send-email-galak@kernel.crashing.org>
Cc: devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The first 4k region of CCSR space is well defined for local access
windows, CCSRBAR, etc.  The second 4k region is well defined as
register for configuring and getting errors for the ECM coherency
module.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 Documentation/powerpc/dts-bindings/ecm.txt |   64 ++++++++++++++++++++++++++++
 1 files changed, 64 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/powerpc/dts-bindings/ecm.txt

diff --git a/Documentation/powerpc/dts-bindings/ecm.txt b/Documentation/powerpc/dts-bindings/ecm.txt
new file mode 100644
index 0000000..f514f29
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/ecm.txt
@@ -0,0 +1,64 @@
+=====================================================================
+E500 LAW & Coherency Module Device Tree Binding
+Copyright (C) 2009 Freescale Semiconductor Inc.
+=====================================================================
+
+Local Access Window (LAW) Node
+
+The LAW node represents the region of CCSR space where local access
+windows are configured.  For ECM based devices this is the first 4k
+of CCSR space that includes CCSRBAR, ALTCBAR, ALTCAR, BPTR, and some
+number of local access windows as specified by fsl,num-laws.
+
+PROPERTIES
+
+  - compatible
+      Usage: required
+      Value type: <string>
+      Definition: Must include "fsl,ecm-law"
+
+  - reg
+      Usage: required
+      Value type: <prop-encoded-array>
+      Definition: A standard property.  The value specifies the
+          physical address offset and length of the CCSR space
+          registers.
+
+  - fsl,num-laws
+      Usage: required
+      Value type: <u32>
+      Definition: The value specifies the number of local access
+          windows for this device.
+
+=====================================================================
+
+E500 Coherency Module Node
+
+The E500 LAW node represents the region of CCSR space where ECM config
+and error reporting registers exist, this is the second 4k (0x1000)
+of CCSR space.
+
+PROPERTIES
+
+  - compatible
+      Usage: required
+      Value type: <string>
+      Definition: Must include "fsl,CHIP-ecm", "fsl,ecm" where
+      CHIP is the processor (mpc8572, mpc8544, etc.)
+
+  - reg
+      Usage: required
+      Value type: <prop-encoded-array>
+      Definition: A standard property.  The value specifies the
+          physical address offset and length of the CCSR space
+          registers.
+
+   - interrupts
+      Usage: required
+      Value type: <prop-encoded-array>
+
+   - interrupt-parent
+      Usage: required
+      Value type: <phandle>
+
+=====================================================================
-- 
1.6.0.6
