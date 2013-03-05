Return-Path: <B08248@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7C5EE2C0364
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2013 09:39:21 +1100 (EST)
From: Stuart Yoder <stuart.yoder@freescale.com>
To: <galak@kernel.crashing.org>
Subject: [PATCH][v3] powerpc/e6500: Add architecture categories for e6500 cores
Date: Tue, 5 Mar 2013 16:39:08 -0600
Message-ID: <1362523149-19393-1-git-send-email-stuart.yoder@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, Stuart Yoder <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Stuart Yoder <stuart.yoder@freescale.com>

-also define a binding for fsl,eref-* properties

Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
---

-v3
   -converted EREF specific properties to fsl,eref-*

 .../devicetree/bindings/powerpc/fsl/cpus.txt       |   21 +++++++
 arch/powerpc/boot/dts/fsl/e6500_power_isa.dtsi     |   65 ++++++++++++++++++++
 2 files changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/cpus.txt
 create mode 100644 arch/powerpc/boot/dts/fsl/e6500_power_isa.dtsi

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/cpus.txt b/Documentation/devicetree/bindings/powerpc/fsl/cpus.txt
new file mode 100644
index 0000000..79dadf1
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/fsl/cpus.txt
@@ -0,0 +1,21 @@
+===================================================================
+Power Architecture CPU Binding
+Copyright 2013 Freescale Semiconductor Inc.
+
+Power Architecture CPUs in Freescale SOCs are represented in device trees as per the
+definition in ePAPR.
+
+In addition to the ePAPR definitions, the properties defined below may be present
+on CPU nodes.
+
+PROPERTIES
+
+   - fsl,eref-*
+        Usage: optional
+        Value type: <empty>
+        Definition: The EREF (EREF: A Programmer.s Reference Manual for Freescale Power Architecture)
+        defines the architecture for Freescale Power CPUs.  The EREF defines some architecture categories
+        not defined by the Power ISA.  For these EREF-specific categories, the existence of a property
+        named fsl,eref-[CAT], where [CAT] is the abbreviated category name with all uppercase letters
+        converted to lowercase, indicates that the category is supported by the implementation.
+
diff --git a/arch/powerpc/boot/dts/fsl/e6500_power_isa.dtsi b/arch/powerpc/boot/dts/fsl/e6500_power_isa.dtsi
new file mode 100644
index 0000000..a912dbe
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/e6500_power_isa.dtsi
@@ -0,0 +1,65 @@
+/*
+ * e6500 Power ISA Device Tree Source (include)
+ *
+ * Copyright 2013 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor "AS IS" AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+/ {
+	cpus {
+		power-isa-version = "2.06";
+		power-isa-b;		// Base
+		power-isa-e;		// Embedded
+		power-isa-atb;		// Alternate Time Base
+		power-isa-cs;		// Cache Specification
+		power-isa-ds;		// Decorated Storage
+		power-isa-e.ed;		// Embedded.Enhanced Debug
+		power-isa-e.pd;		// Embedded.External PID
+		power-isa-e.hv;		// Embedded.Hypervisor
+		power-isa-e.le;		// Embedded.Little-Endian
+		power-isa-e.pm;		// Embedded.Performance Monitor
+		power-isa-e.pc;		// Embedded.Processor Control
+		power-isa-ecl;		// Embedded Cache Locking
+		power-isa-exp;		// External Proxy
+		power-isa-fp;		// Floating Point
+		power-isa-fp.r;		// Floating Point.Record
+		power-isa-mmc;		// Memory Coherence
+		power-isa-scpm;		// Store Conditional Page Mobility
+		power-isa-wt;		// Wait
+		power-isa-64;		// 64-bit
+		power-isa-e.pt;		// Embedded.Page Table
+		power-isa-e.hv.lrat;	// Embedded.Hypervisor.LRAT
+		power-isa-e.em;		// Embedded Multi-Threading
+		power-isa-v;		// Vector (AltiVec)
+		fsl,eref-er;		// Enhanced Reservations (Load and Reserve and Store Cond.)
+		fsl,eref-deo;		// Data Cache Extended Operations
+		mmu-type = "power-embedded";
+	};
+};
-- 
1.7.9.7
