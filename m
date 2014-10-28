Return-Path: <Emilian.Medve@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 892721A0060
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2014 20:24:38 +1100 (AEDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0115.outbound.protection.outlook.com [157.56.111.115])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6BABF140077
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2014 20:24:37 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <scottwood@Freescale.com>, <galak@kernel.crashing.org>, <corbet@lwn.net>,
 <robh+dt@kernel.org>, <ijc+devicetree@hellion.org.uk>,
 <galak@codeaurora.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
 <grant.likely@linaro.org>, <Geoff.Thorpe@Freescale.com>,
 <linuxppc-dev@ozlabs.org>, <devicetree@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: [PATCH v2 3/4] dt/bindings: Introduce the FSL QorIQ DPAA QMan
Date: Tue, 28 Oct 2014 04:15:50 -0500
Message-ID: <1414487751-31568-4-git-send-email-Emilian.Medve@Freescale.com>
In-Reply-To: <1414487751-31568-1-git-send-email-Emilian.Medve@Freescale.com>
References: <1414487751-31568-1-git-send-email-Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Emil Medve <Emilian.Medve@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Queue Manager is part of the Data-Path Acceleration Architecture (DPAA).
QMan supports queuing and QoS scheduling of frames to CPUs, network interfaces
and DPAA logic modules, maintains packet ordering within flows. Besides
providing flow-level queuing, is also responsible for congestion management
functions such as RED/WRED, congestion notifications and tail discards. This
binding covers the CCSR space programming model

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
Change-Id: I3acb223893e42003d6c9dc061db568ec0b10d29b
---
 .../devicetree/bindings/powerpc/fsl/qman.txt       | 133 +++++++++++++++++++++
 1 file changed, 133 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/qman.txt

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/qman.txt b/Documentation/devicetree/bindings/powerpc/fsl/qman.txt
new file mode 100644
index 0000000..a21e097
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/fsl/qman.txt
@@ -0,0 +1,133 @@
+QorIQ DPAA Queue Manager Device Tree Binding
+
+Copyright (C) 2008 - 2014 Freescale Semiconductor Inc.
+
+CONTENTS
+
+	- QMan Node
+	- QMan Private Memory Nodes
+	- Example
+
+QMan Node
+
+PROPERTIES
+
+- compatible
+	Usage:		Required
+	Value type:	<stringlist>
+	Definition:	Must include "fsl,qman"
+			May include "fsl,<SoC>-qman"
+
+- reg
+	Usage:		Required
+	Value type:	<prop-encoded-array>
+	Definition:	Registers region within the CCSR address space
+
+- interrupts
+	Usage:		Required
+	Value type:	<prop-encoded-array>
+	Definition:	Standard property. The error interrupt
+
+- fsl,liodn
+	Usage:		See pamu.txt
+	Value type:	<prop-encoded-array>
+	Definition:	PAMU property used for static LIODN assignment
+
+- fsl,iommu-parent
+	Usage:		See pamu.txt
+	Value type:	<phandle>
+	Definition:	PAMU property used for dynamic LIODN assignment
+
+	For additional details about the PAMU/LIODN binding(s) see pamu.txt
+
+- clocks
+	Usage:		See clock-bindings.txt and qoriq-clock.txt
+	Value type:	<prop-encoded-array>
+	Definition:	Reference input clock. Its frequency is half of the
+			platform clock
+
+QMan Private Memory Nodes
+
+QMan requires two contiguous range of physical memory used for the backing store
+for QMan Frame Queue Descriptor and Packed Frame Descriptor Record. This memory
+is reserved/allocated as a nodes under the /reserved-memory node
+
+The QMan FQD memory node must be named "qman-fqd"
+
+PROPERTIES
+
+- compatible
+	Usage:		required
+	Value type:	<stringlist>
+	Definition:	Must inclide "fsl,qman-fqd"
+
+The QMan PFDR memory node must be named "qman-pfdr"
+
+PROPERTIES
+
+- compatible
+	Usage:		required
+	Value type:	<stringlist>
+	Definition:	Must inclide "fsl,qman-pfdr"
+
+The following constraints are relevant to the FQD and PFDR private memory:
+	- The size must be 2^(size + 1), with size = 11..29. That is 4 KiB to
+	  1 GiB
+	- The alignment must be a muliptle of the memory size
+
+The size of the FQD and PFDP must be chosen by observing the hardware features
+configured via the RCW and that are relevant to a specific board (e.g. number of
+MAC(s) pinned-out, number of offline/host command FMan ports, etc.). The size
+configured in the DT must reflect the hardware capabilities and not the specific
+needs of an application
+
+For additional details about reserved memory regions see reserved-memory.txt
+
+EXAMPLE
+
+The example below shows a QMan FQD and a PFDR dynamic allocation memory nodes
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		qman-fqd {
+			compatible = "fsl,qman-fqd";
+			alloc-ranges = <0 0 0xf 0xffffffff>;
+			size = <0 0x400000>;
+			alignment = <0 0x400000>;
+		};
+		qman-pfdr {
+			compatible = "fsl,qman-pfdr";
+			alloc-ranges = <0 0 0xf 0xffffffff>;
+			size = <0 0x2000000>;
+			alignment = <0 0x2000000>;
+		};
+	};
+
+The example below shows a (P4080) QMan CCSR-space node
+
+	clockgen: global-utilities@e1000 {
+		...
+		sysclk: sysclk {
+			...
+		};
+		...
+		platform_pll: platform-pll@c00 {
+			#clock-cells = <1>;
+			reg = <0xc00 0x4>;
+			compatible = "fsl,qoriq-platform-pll-1.0";
+			clocks = <&sysclk>;
+			clock-output-names = "platform-pll", "platform-pll-div2";
+		};
+		...
+	};
+
+	qman@318000 {
+		compatible = "fsl,qman";
+		reg = <0x318000 0x1000>;
+		interrupts = <16 2 1 3>
+		fsl,liodn = <0x16>;
+		clocks = <&platform_pll 1>;
+	};
-- 
2.1.2
