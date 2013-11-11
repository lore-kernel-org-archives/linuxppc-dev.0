Return-Path: <Yuantian.Tang@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 90A3F2C032F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Nov 2013 21:26:37 +1100 (EST)
From: <Yuantian.Tang@freescale.com>
To: <galak@kernel.crashing.org>
Subject: [PATCH v6] clk: corenet: Adds the clock binding
Date: Mon, 11 Nov 2013 17:41:46 +0800
Message-ID: <1384162906-30730-1-git-send-email-Yuantian.Tang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 Tang Yuantian <Yuantian.Tang@freescale.com>, scottwood@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tang Yuantian <yuantian.tang@freescale.com>

Adds the clock bindings for Freescale PowerPC CoreNet platforms

Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
v6:
	- splited the previous patch into 2 parts, one is for binding(this one),
	  the other is for DTS modification(will submit once this gets accepted)
	- fixed typo
	- refined #clock-cells and clock-output-names properties
	- removed fixed-clock compatible string
v5:
	- refine the binding document
	- update the compatible string
v4:
	- add binding document
	- update compatible string
	- update the reg property
v3:
	- fix typo
v2:
	- add t4240, b4420, b4860 support
	- remove pll/4 clock from p2041, p3041 and p5020 board

 .../devicetree/bindings/clock/corenet-clock.txt    | 123 +++++++++++++++++++++
 1 file changed, 123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/corenet-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/corenet-clock.txt b/Documentation/devicetree/bindings/clock/corenet-clock.txt
new file mode 100644
index 0000000..6a4e15d
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/corenet-clock.txt
@@ -0,0 +1,123 @@
+* Clock Block on Freescale CoreNet Platforms
+
+Freescale CoreNet chips take primary clocking input from the external
+SYSCLK signal. The SYSCLK input (frequency) is multiplied using
+multiple phase locked loops (PLL) to create a variety of frequencies
+which can then be passed to a variety of internal logic, including
+cores and peripheral IP blocks.
+Please refer to the Reference Manual for details.
+
+1. Clock Block Binding
+
+Required properties:
+- compatible: Should include one or more of the following:
+	* "fsl,<chip>-clockgen": for chip specific clock block, here chip
+		could be but not limited to one of the: p2041, p3041, p4080,
+		p5020, p5040, t4240, b4420, b4860
+	* "fsl,qoriq-clockgen-1.0": for chassis 1.0 clocks
+	* "fsl,qoriq-clockgen-2.0": for chassis 2.0 clocks
+	Notes that "fsl,qoriq-clockgen-1.0" and "fsl,qoriq-clockgen-2.0"
+	cannot be included simultaneously.
+- reg: Offset and length of the clock register set
+
+Recommended properties:
+- ranges: Allows valid translation between child's address space and
+	parent's. Must be present if the device has sub-nodes.
+- #address-cells: Specifies the number of cells used to represent
+	physical base addresses.  Must be present if the device has
+	sub-nodes and set to 1 if present
+- #size-cells: Specifies the number of cells used to represent
+	the size of an address. Must be present if the device has
+	sub-nodes and set to 1 if present
+
+2. Clock Provider/Consumer Binding
+
+Most of the bindings are from the common clock binding[1].
+ [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Required properties:
+- compatible : Should include one of the following:
+	* "fsl,qoriq-core-pll-1.0" for core PLL clocks (v1.0)
+    * "fsl,qoriq-core-pll-2.0" for core PLL clocks (v2.0)
+    * "fsl,qoriq-core-mux-1.0" for core mux clocks (v1.0)
+    * "fsl,qoriq-core-mux-2.0" for core mux clocks (v2.0)
+	* "fsl,qoriq-sysclk-1.0": for input system clock (v1.0)
+	* "fsl,qoriq-sysclk-2.0": for input system clock (v2.0)
+- #clock-cells: From common clock binding; indicates the number of
+	output clock. 0 is for "fsl,qoriq-sysclk-[1,2].0" and
+	"fsl,qoriq-core-mux-[1,2].0"; 1 for "fsl,qoriq-core-pll-[1,2].0".
+	If #clock-cells has a value of 1, its clock consumer should specify
+	the desired clock by having the clock ID in its "clocks" phandle
+	cell. The following is a full list IDs:
+	* 0 - equal to the PLL frequency
+	* 1 - equal to the PLL frequency divided by 2
+	* 2 - equal to the PLL frequency divided by 4
+
+Recommended properties:
+- clocks: Should be the phandle of input parent clock
+- clock-names: From common clock binding, indicates the clock name
+- clock-output-names: From common clock binding, indicates the names of
+	output clocks
+- reg: Should be the offset and length of clock block base address.
+	The length should be 4.
+
+Example for clock block and clock provider:
+/ {
+	clockgen: global-utilities@e1000 {
+		compatible = "fsl,p5020-clockgen", "fsl,qoriq-clockgen-1.0";
+		ranges = <0x0 0xe1000 0x1000>;
+		reg = <0xe1000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		sysclk: sysclk {
+			#clock-cells = <0>;
+			compatible = "fsl,qoriq-sysclk-1.0";
+			clock-output-names = "sysclk";
+		}
+
+		pll0: pll0@800 {
+			#clock-cells = <1>;
+			reg = <0x800 0x4>;
+			compatible = "fsl,qoriq-core-pll-1.0";
+			clocks = <&sysclk>;
+			clock-output-names = "pll0", "pll0-div2";
+		};
+
+		pll1: pll1@820 {
+			#clock-cells = <1>;
+			reg = <0x820 0x4>;
+			compatible = "fsl,qoriq-core-pll-1.0";
+			clocks = <&sysclk>;
+			clock-output-names = "pll1", "pll1-div2";
+		};
+
+		mux0: mux0@0 {
+			#clock-cells = <0>;
+			reg = <0x0 0x4>;
+			compatible = "fsl,qoriq-core-mux-1.0";
+			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
+			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
+			clock-output-names = "cmux0";
+		};
+
+		mux1: mux1@20 {
+			#clock-cells = <0>;
+			reg = <0x20 0x4>;
+			compatible = "fsl,qoriq-core-mux-1.0";
+			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
+			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
+			clock-output-names = "cmux1";
+		};
+	};
+  }
+
+Example for clock consumer:
+
+/ {
+	cpu0: PowerPC,e5500@0 {
+		...
+		clocks = <&mux0>;
+		...
+	};
+  }
-- 
1.8.0
