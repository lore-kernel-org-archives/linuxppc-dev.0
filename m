Return-Path: <Emilian.Medve@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5DFA81A04F0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Nov 2014 02:28:10 +1100 (AEDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0111.outbound.protection.outlook.com [157.56.110.111])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 50A7B140079
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Nov 2014 02:28:08 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <scottwood@Freescale.com>, <galak@kernel.crashing.org>, <corbet@lwn.net>,
 <robh+dt@kernel.org>, <ijc+devicetree@hellion.org.uk>,
 <galak@codeaurora.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
 <grant.likely@linaro.org>, <Geoff.Thorpe@Freescale.com>,
 <linuxppc-dev@ozlabs.org>, <devicetree@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: [PATCH v3 4/4] dt/bindings: Introduce the FSL QorIQ DPAA QMan
 portal(s)
Date: Wed, 5 Nov 2014 09:18:54 -0600
Message-ID: <1415200734-6978-5-git-send-email-Emilian.Medve@Freescale.com>
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

Portals are memory mapped interfaces to QMan that allow low-latency,
lock-less interaction by software running on processor cores,
accelerators and network interfaces with the QMan

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
Change-Id: I29764fa8093b5ce65460abc879446795c50d7185
---
 .../devicetree/bindings/soc/fsl/qman-portals.txt   | 154 +++++++++++++++++++++
 1 file changed, 154 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/qman-portals.txt

diff --git a/Documentation/devicetree/bindings/soc/fsl/qman-portals.txt b/Documentation/devicetree/bindings/soc/fsl/qman-portals.txt
new file mode 100644
index 0000000..48c4dae
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/fsl/qman-portals.txt
@@ -0,0 +1,154 @@
+QorIQ DPAA Queue Manager Portals Device Tree Binding
+
+Copyright (C) 2008 - 2014 Freescale Semiconductor Inc.
+
+CONTENTS
+
+	- QMan Portal
+	- QMan Pool Channel
+	- Example
+
+QMan Portal Node
+
+Portals are memory mapped interfaces to QMan that allow low-latency, lock-less
+interaction by software running on processor cores, accelerators and network
+interfaces with the QMan
+
+PROPERTIES
+
+- compatible
+	Usage:		Required
+	Value type:	<stringlist>
+	Definition:	Must include "fsl,qman-portal-<hardware revision>"
+			May include "fsl,<SoC>-qman-portal" or "fsl,qman-portal"
+
+- reg
+	Usage:		Required
+	Value type:	<prop-encoded-array>
+	Definition:	Two regions. The first is the cache-enabled region of
+			the portal. The second is the cache-inhibited region of
+			the portal
+
+- interrupts
+	Usage:		Required
+	Value type:	<prop-encoded-array>
+	Definition:	Standard property
+
+- fsl,liodn
+	Usage:		See pamu.txt
+	Value type:	<prop-encoded-array>
+	Definition:	Two LIODN(s). DQRR LIODN (DLIODN) and Frame LIODN
+			(FLIODN)
+
+- fsl,iommu-parent
+	Usage:		See pamu.txt
+	Value type:	<phandle>
+	Definition:	PAMU property used for dynamic LIODN assignment
+
+	For additional details about the PAMU/LIODN binding(s) see pamu.txt
+
+- fsl,qman-channel-id
+	Usage:		Required
+	Value type:	<u32>
+	Definition:	The hardware index of the channel. This can also be
+			determined by dividing any of the channel's 8 work queue
+			IDs by 8
+
+In addition to these properties the qman-portals should have sub-nodes to
+represent the HW devices/portals that are connected to the software portal
+described here
+
+The currently supported sub-nodes are:
+	* fman0
+	* fman1
+	* pme
+	* crypto
+
+These subnodes should have the following properties:
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
+- dev-handle
+	Usage:		Required
+	Value type:	<phandle>
+	Definition:	The phandle to the particular hardware device that this
+			portal is connected to.
+
+DPAA QMan Pool Channel Nodes
+
+Pool Channels are defined with the following properties.
+
+PROPERTIES
+
+- compatible
+	Usage:		Required
+	Value type:	<stringlist>
+	Definition:	Must include "fsl,qman-pool-channel"
+			May include "fsl,<SoC>-qman-pool-channel"
+
+- fsl,qman-channel-id
+	Usage:		Required
+	Value type:	<u32>
+	Definition:	The hardware index of the channel. This can also be
+			determined by dividing any of the channel's 8 work queue
+			IDs by 8
+
+EXAMPLE
+
+The example below shows a (P4080) QMan portals container/bus node with two portals
+
+	qman-portals@ff4200000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		ranges = <0 0xf 0xf4200000 0x200000>;
+
+		qman-portal@0 {
+			compatible = "fsl,qman-portal-1.2.0", "fsl,qman-portal";
+			reg = <0 0x4000>, <0x100000 0x1000>;
+			interrupts = <104 2 0 0>;
+			fsl,liodn = <1 2>;
+			fsl,qman-channel-id = <0>;
+
+			fman0 {
+				fsl,liodn = <0x21>;
+				dev-handle = <&fman0>;
+			};
+			fman1 {
+				fsl,liodn = <0xa1>;
+				dev-handle = <&fman1>;
+			};
+			crypto {
+				fsl,liodn = <0x41 0x66>;
+				dev-handle = <&crypto>;
+			};
+		};
+		qman-portal@4000 {
+			compatible = "fsl,qman-portal-1.2.0", "fsl,qman-portal";
+			reg = <0x4000 0x4000>, <0x101000 0x1000>;
+			interrupts = <106 2 0 0>;
+			fsl,liodn = <3 4>;
+			fsl,qman-channel-id = <1>;
+
+			fman0 {
+				fsl,liodn = <0x22>;
+				dev-handle = <&fman0>;
+			};
+			fman1 {
+				fsl,liodn = <0xa2>;
+				dev-handle = <&fman1>;
+			};
+			crypto {
+				fsl,liodn = <0x42 0x67>;
+				dev-handle = <&crypto>;
+			};
+		};
+	};
-- 
2.1.3
