Return-Path: <Emilian.Medve@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43FC61A025D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Nov 2014 02:28:10 +1100 (AEDT)
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0101.outbound.protection.outlook.com [207.46.100.101])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6BDCB1400D5
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Nov 2014 02:28:09 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <scottwood@Freescale.com>, <galak@kernel.crashing.org>, <corbet@lwn.net>,
 <robh+dt@kernel.org>, <ijc+devicetree@hellion.org.uk>,
 <galak@codeaurora.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
 <grant.likely@linaro.org>, <Geoff.Thorpe@Freescale.com>,
 <linuxppc-dev@ozlabs.org>, <devicetree@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: [PATCH v3 1/4] dt/bindings: Introduce the FSL QorIQ DPAA BMan
Date: Wed, 5 Nov 2014 09:18:51 -0600
Message-ID: <1415200734-6978-2-git-send-email-Emilian.Medve@Freescale.com>
In-Reply-To: <1415200734-6978-1-git-send-email-Emilian.Medve@Freescale.com>
References: <1415200734-6978-1-git-send-email-Emilian.Medve@Freescale.com>
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

The Buffer Manager is part of the Data-Path Acceleration Architecture (DPAA).
BMan supports hardware allocation and deallocation of buffers belonging to
pools originally created by software with configurable depletion thresholds.
This binding covers the CCSR space programming model

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
Change-Id: I3ec479bfb3c91951e96902f091f5d7d2adbef3b2
---
 Documentation/devicetree/bindings/soc/fsl/bman.txt | 125 +++++++++++++++++++++
 1 file changed, 125 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/bman.txt

diff --git a/Documentation/devicetree/bindings/soc/fsl/bman.txt b/Documentation/devicetree/bindings/soc/fsl/bman.txt
new file mode 100644
index 0000000..9f80bf8
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/fsl/bman.txt
@@ -0,0 +1,125 @@
+QorIQ DPAA Buffer Manager Device Tree Bindings
+
+Copyright (C) 2008 - 2014 Freescale Semiconductor Inc.
+
+CONTENTS
+
+	- BMan Node
+	- BMan Private Memory Node
+	- Example
+
+BMan Node
+
+The Buffer Manager is part of the Data-Path Acceleration Architecture (DPAA).
+BMan supports hardware allocation and deallocation of buffers belonging to pools
+originally created by software with configurable depletion thresholds. This
+binding covers the CCSR space programming model
+
+PROPERTIES
+
+- compatible
+	Usage:		Required
+	Value type:	<stringlist>
+	Definition:	Must include "fsl,bman"
+			May include "fsl,<SoC>-bman"
+
+- reg
+	Usage:		Required
+	Value type:	<prop-encoded-array>
+	Definition:	Registers region within the CCSR address space
+
+The BMan revision information is located in the BMAN_IP_REV_1/2 registers which
+are located at offsets 0xbf8 and 0xbfc
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
+Devices connected to a BMan instance via Direct Connect Portals (DCP) must link
+to the respective BMan instance
+
+- fsl,bman
+	Usage:		Required
+	Value type:	<prop-encoded-array>
+	Description:	List of phandle and DCP index pairs, to the BMan instance
+			to which this device is connected via the DCP
+
+BMan Private Memory Node
+
+BMan requires a contiguous range of physical memory used for the backing store
+for BMan Free Buffer Proxy Records (FBPR). This memory is reserved/allocated as a
+node under the /reserved-memory node
+
+The BMan FBPR memory node must be named "bman-fbpr"
+
+PROPERTIES
+
+- compatible
+	Usage:		required
+	Value type:	<stringlist>
+	Definition:	Must inclide "fsl,bman-fbpr"
+
+The following constraints are relevant to the FBPR private memory:
+	- The size must be 2^(size + 1), with size = 11..33. That is 4 KiB to
+	  16 GiB
+	- The alignment must be a muliptle of the memory size
+
+The size of the FBPR must be chosen by observing the hardware features configured
+via the Reset Configuration Word (RCW) and that are relevant to a specific board
+(e.g. number of MAC(s) pinned-out, number of offline/host command FMan ports,
+etc.). The size configured in the DT must reflect the hardware capabilities and
+not the specific needs of an application
+
+For additional details about reserved memory regions see reserved-memory.txt
+
+EXAMPLE
+
+The example below shows a BMan FBPR dynamic allocation memory node
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		bman_fbpr: bman-fbpr {
+			compatible = "fsl,bman-fbpr";
+			alloc-ranges = <0 0 0xf 0xffffffff>;
+			size = <0 0x1000000>;
+			alignment = <0 0x1000000>;
+		};
+	};
+
+The example below shows a (P4080) BMan CCSR-space node
+
+	crypto@300000 {
+		...
+		fsl,bman = <&bman, 2>;
+		...
+	};
+
+	bman: bman@31a000 {
+		compatible = "fsl,bman";
+		reg = <0x31a000 0x1000>;
+		interrupts = <16 2 1 2>;
+		fsl,liodn = <0x17>;
+		memory-region = <&bman_fbpr>;
+	};
+
+	fman@400000 {
+		...
+		fsl,bman = <&bman, 0>;
+		...
+	};
-- 
2.1.3
