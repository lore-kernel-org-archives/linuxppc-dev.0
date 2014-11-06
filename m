Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0141.outbound.protection.outlook.com [207.46.100.141])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 492101A01F4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Nov 2014 02:57:32 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <scottwood@Freescale.com>, <yuantian.tang@Freescale.com>,
 <linuxppc-dev@lists.ozlabs.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 1/3] powerpc/dts: Factorize the clock control node
Date: Thu, 6 Nov 2014 09:48:11 -0600
Message-ID: <1415288893-4457-1-git-send-email-Emilian.Medve@Freescale.com>
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

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
Change-Id: I25ce24a25862b4ca460164159867abefe00ccdd1
---

v2: Whitespace fixes

 arch/powerpc/boot/dts/b4860emu.dts             |  4 +-
 arch/powerpc/boot/dts/fsl/b4420si-post.dtsi    | 28 +--------
 arch/powerpc/boot/dts/fsl/b4860si-post.dtsi    | 28 +--------
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi    | 48 +---------------
 arch/powerpc/boot/dts/fsl/p3041si-post.dtsi    | 48 +---------------
 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi    | 48 +---------------
 arch/powerpc/boot/dts/fsl/p5020si-post.dtsi    | 48 +---------------
 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi    | 48 +---------------
 arch/powerpc/boot/dts/fsl/qoriq-clockgen1.dtsi | 78 ++++++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi | 61 ++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi    | 30 +---------
 arch/powerpc/boot/dts/fsl/t2081si-post.dtsi    | 29 +---------
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi    | 29 +---------
 arch/powerpc/boot/dts/t4240emu.dts             |  4 +-
 14 files changed, 163 insertions(+), 368 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-clockgen1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi

diff --git a/arch/powerpc/boot/dts/b4860emu.dts b/arch/powerpc/boot/dts/b4860emu.dts
index 85646b4..2aa5cd3 100644
--- a/arch/powerpc/boot/dts/b4860emu.dts
+++ b/arch/powerpc/boot/dts/b4860emu.dts
@@ -193,9 +193,9 @@
 		fsl,liodn-bits = <12>;
 	};
 
-	clockgen: global-utilities@e1000 {
+/include/ "fsl/qoriq-clockgen2.dtsi"
+	global-utilities@e1000 {
 		compatible = "fsl,b4-clockgen", "fsl,qoriq-clockgen-2.0";
-		reg = <0xe1000 0x1000>;
 	};
 
 /include/ "fsl/qoriq-dma-0.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
index b34c62e..aced374 100644
--- a/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
@@ -80,33 +80,9 @@
 		compatible = "fsl,b4420-device-config", "fsl,qoriq-device-config-2.0";
 	};
 
-	clockgen: global-utilities@e1000 {
+/include/ "qoriq-clockgen2.dtsi"
+	global-utilities@e1000 {
 		compatible = "fsl,b4420-clockgen", "fsl,qoriq-clockgen-2.0";
-		ranges = <0x0 0xe1000 0x1000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		sysclk: sysclk {
-			#clock-cells = <0>;
-			compatible = "fsl,qoriq-sysclk-2.0";
-			clock-output-names = "sysclk";
-		};
-
-		pll0: pll0@800 {
-			#clock-cells = <1>;
-			reg = <0x800 0x4>;
-			compatible = "fsl,qoriq-core-pll-2.0";
-			clocks = <&sysclk>;
-			clock-output-names = "pll0", "pll0-div2", "pll0-div4";
-		};
-
-		pll1: pll1@820 {
-			#clock-cells = <1>;
-			reg = <0x820 0x4>;
-			compatible = "fsl,qoriq-core-pll-2.0";
-			clocks = <&sysclk>;
-			clock-output-names = "pll1", "pll1-div2", "pll1-div4";
-		};
 
 		mux0: mux0@0 {
 			#clock-cells = <0>;
diff --git a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
index 256fac8..3b9bb37 100644
--- a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
@@ -273,33 +273,9 @@
 		compatible = "fsl,b4860-device-config", "fsl,qoriq-device-config-2.0";
 	};
 
-	clockgen: global-utilities@e1000 {
+/include/ "qoriq-clockgen2.dtsi"
+	global-utilities@e1000 {
 		compatible = "fsl,b4860-clockgen", "fsl,qoriq-clockgen-2.0";
-		ranges = <0x0 0xe1000 0x1000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		sysclk: sysclk {
-			#clock-cells = <0>;
-			compatible = "fsl,qoriq-sysclk-2.0";
-			clock-output-names = "sysclk";
-		};
-
-		pll0: pll0@800 {
-			#clock-cells = <1>;
-			reg = <0x800 0x4>;
-			compatible = "fsl,qoriq-core-pll-2.0";
-			clocks = <&sysclk>;
-			clock-output-names = "pll0", "pll0-div2", "pll0-div4";
-		};
-
-		pll1: pll1@820 {
-			#clock-cells = <1>;
-			reg = <0x820 0x4>;
-			compatible = "fsl,qoriq-core-pll-2.0";
-			clocks = <&sysclk>;
-			clock-output-names = "pll1", "pll1-div2", "pll1-div4";
-		};
 
 		mux0: mux0@0 {
 			#clock-cells = <0>;
diff --git a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
index f297514..3320341 100644
--- a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
@@ -313,53 +313,9 @@
 		#sleep-cells = <2>;
 	};
 
-	clockgen: global-utilities@e1000 {
+/include/ "qoriq-clockgen1.dtsi"
+	global-utilities@e1000 {
 		compatible = "fsl,p2041-clockgen", "fsl,qoriq-clockgen-1.0";
-		ranges = <0x0 0xe1000 0x1000>;
-		reg = <0xe1000 0x1000>;
-		clock-frequency = <0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		sysclk: sysclk {
-			#clock-cells = <0>;
-			compatible = "fsl,qoriq-sysclk-1.0";
-			clock-output-names = "sysclk";
-		};
-
-		pll0: pll0@800 {
-			#clock-cells = <1>;
-			reg = <0x800 0x4>;
-			compatible = "fsl,qoriq-core-pll-1.0";
-			clocks = <&sysclk>;
-			clock-output-names = "pll0", "pll0-div2";
-		};
-
-		pll1: pll1@820 {
-			#clock-cells = <1>;
-			reg = <0x820 0x4>;
-			compatible = "fsl,qoriq-core-pll-1.0";
-			clocks = <&sysclk>;
-			clock-output-names = "pll1", "pll1-div2";
-		};
-
-		mux0: mux0@0 {
-			#clock-cells = <0>;
-			reg = <0x0 0x4>;
-			compatible = "fsl,qoriq-core-mux-1.0";
-			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
-			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
-			clock-output-names = "cmux0";
-		};
-
-		mux1: mux1@20 {
-			#clock-cells = <0>;
-			reg = <0x20 0x4>;
-			compatible = "fsl,qoriq-core-mux-1.0";
-			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
-			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
-			clock-output-names = "cmux1";
-		};
 
 		mux2: mux2@40 {
 			#clock-cells = <0>;
diff --git a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
index b3f89ce..b28964f 100644
--- a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
@@ -340,53 +340,9 @@
 		#sleep-cells = <2>;
 	};
 
-	clockgen: global-utilities@e1000 {
+/include/ "qoriq-clockgen1.dtsi"
+	global-utilities@e1000 {
 		compatible = "fsl,p3041-clockgen", "fsl,qoriq-clockgen-1.0";
-		ranges = <0x0 0xe1000 0x1000>;
-		reg = <0xe1000 0x1000>;
-		clock-frequency = <0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		sysclk: sysclk {
-			#clock-cells = <0>;
-			compatible = "fsl,qoriq-sysclk-1.0";
-			clock-output-names = "sysclk";
-		};
-
-		pll0: pll0@800 {
-			#clock-cells = <1>;
-			reg = <0x800 0x4>;
-			compatible = "fsl,qoriq-core-pll-1.0";
-			clocks = <&sysclk>;
-			clock-output-names = "pll0", "pll0-div2";
-		};
-
-		pll1: pll1@820 {
-			#clock-cells = <1>;
-			reg = <0x820 0x4>;
-			compatible = "fsl,qoriq-core-pll-1.0";
-			clocks = <&sysclk>;
-			clock-output-names = "pll1", "pll1-div2";
-		};
-
-		mux0: mux0@0 {
-			#clock-cells = <0>;
-			reg = <0x0 0x4>;
-			compatible = "fsl,qoriq-core-mux-1.0";
-			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
-			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
-			clock-output-names = "cmux0";
-		};
-
-		mux1: mux1@20 {
-			#clock-cells = <0>;
-			reg = <0x20 0x4>;
-			compatible = "fsl,qoriq-core-mux-1.0";
-			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
-			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
-			clock-output-names = "cmux1";
-		};
 
 		mux2: mux2@40 {
 			#clock-cells = <0>;
diff --git a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
index e410b15..eb043a7 100644
--- a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
@@ -360,35 +360,9 @@
 		#sleep-cells = <2>;
 	};
 
-	clockgen: global-utilities@e1000 {
+/include/ "qoriq-clockgen1.dtsi"
+	global-utilities@e1000 {
 		compatible = "fsl,p4080-clockgen", "fsl,qoriq-clockgen-1.0";
-		ranges = <0x0 0xe1000 0x1000>;
-		reg = <0xe1000 0x1000>;
-		clock-frequency = <0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		sysclk: sysclk {
-			#clock-cells = <0>;
-			compatible = "fsl,qoriq-sysclk-1.0";
-			clock-output-names = "sysclk";
-		};
-
-		pll0: pll0@800 {
-			#clock-cells = <1>;
-			reg = <0x800 0x4>;
-			compatible = "fsl,qoriq-core-pll-1.0";
-			clocks = <&sysclk>;
-			clock-output-names = "pll0", "pll0-div2";
-		};
-
-		pll1: pll1@820 {
-			#clock-cells = <1>;
-			reg = <0x820 0x4>;
-			compatible = "fsl,qoriq-core-pll-1.0";
-			clocks = <&sysclk>;
-			clock-output-names = "pll1", "pll1-div2";
-		};
 
 		pll2: pll2@840 {
 			#clock-cells = <1>;
@@ -406,24 +380,6 @@
 			clock-output-names = "pll3", "pll3-div2";
 		};
 
-		mux0: mux0@0 {
-			#clock-cells = <0>;
-			reg = <0x0 0x4>;
-			compatible = "fsl,qoriq-core-mux-1.0";
-			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
-			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
-			clock-output-names = "cmux0";
-		};
-
-		mux1: mux1@20 {
-			#clock-cells = <0>;
-			reg = <0x20 0x4>;
-			compatible = "fsl,qoriq-core-mux-1.0";
-			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
-			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
-			clock-output-names = "cmux1";
-		};
-
 		mux2: mux2@40 {
 			#clock-cells = <0>;
 			reg = <0x40 0x4>;
diff --git a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
index d07c771..b70c8c3 100644
--- a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
@@ -345,53 +345,9 @@
 		#sleep-cells = <2>;
 	};
 
-	clockgen: global-utilities@e1000 {
+/include/ "qoriq-clockgen1.dtsi"
+	global-utilities@e1000 {
 		compatible = "fsl,p5020-clockgen", "fsl,qoriq-clockgen-1.0";
-		ranges = <0x0 0xe1000 0x1000>;
-		reg = <0xe1000 0x1000>;
-		clock-frequency = <0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		sysclk: sysclk {
-			#clock-cells = <0>;
-			compatible = "fsl,qoriq-sysclk-1.0";
-			clock-output-names = "sysclk";
-		};
-
-		pll0: pll0@800 {
-			#clock-cells = <1>;
-			reg = <0x800 0x4>;
-			compatible = "fsl,qoriq-core-pll-1.0";
-			clocks = <&sysclk>;
-			clock-output-names = "pll0", "pll0-div2";
-		};
-
-		pll1: pll1@820 {
-			#clock-cells = <1>;
-			reg = <0x820 0x4>;
-			compatible = "fsl,qoriq-core-pll-1.0";
-			clocks = <&sysclk>;
-			clock-output-names = "pll1", "pll1-div2";
-		};
-
-		mux0: mux0@0 {
-			#clock-cells = <0>;
-			reg = <0x0 0x4>;
-			compatible = "fsl,qoriq-core-mux-1.0";
-			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
-			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
-			clock-output-names = "cmux0";
-		};
-
-		mux1: mux1@20 {
-			#clock-cells = <0>;
-			reg = <0x20 0x4>;
-			compatible = "fsl,qoriq-core-mux-1.0";
-			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
-			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
-			clock-output-names = "cmux1";
-		};
 	};
 
 	rcpm: global-utilities@e2000 {
diff --git a/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi b/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
index 243574b..b459b7e 100644
--- a/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
@@ -305,53 +305,9 @@
 		#sleep-cells = <2>;
 	};
 
-	clockgen: global-utilities@e1000 {
+/include/ "qoriq-clockgen1.dtsi"
+	global-utilities@e1000 {
 		compatible = "fsl,p5040-clockgen", "fsl,qoriq-clockgen-1.0";
-		ranges = <0x0 0xe1000 0x1000>;
-		reg = <0xe1000 0x1000>;
-		clock-frequency = <0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		sysclk: sysclk {
-			#clock-cells = <0>;
-			compatible = "fsl,qoriq-sysclk-1.0";
-			clock-output-names = "sysclk";
-		};
-
-		pll0: pll0@800 {
-			#clock-cells = <1>;
-			reg = <0x800 0x4>;
-			compatible = "fsl,qoriq-core-pll-1.0";
-			clocks = <&sysclk>;
-			clock-output-names = "pll0", "pll0-div2";
-		};
-
-		pll1: pll1@820 {
-			#clock-cells = <1>;
-			reg = <0x820 0x4>;
-			compatible = "fsl,qoriq-core-pll-1.0";
-			clocks = <&sysclk>;
-			clock-output-names = "pll1", "pll1-div2";
-		};
-
-		mux0: mux0@0 {
-			#clock-cells = <0>;
-			reg = <0x0 0x4>;
-			compatible = "fsl,qoriq-core-mux-1.0";
-			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
-			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
-			clock-output-names = "cmux0";
-		};
-
-		mux1: mux1@20 {
-			#clock-cells = <0>;
-			reg = <0x20 0x4>;
-			compatible = "fsl,qoriq-core-mux-1.0";
-			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
-			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
-			clock-output-names = "cmux1";
-		};
 
 		mux2: mux2@40 {
 			#clock-cells = <0>;
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-clockgen1.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-clockgen1.dtsi
new file mode 100644
index 0000000..4871048
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/qoriq-clockgen1.dtsi
@@ -0,0 +1,78 @@
+/*
+ * QorIQ clock control device tree stub [ controller @ offset 0xe1000 ]
+ *
+ * Copyright 2014 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *	 notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *	 notice, this list of conditions and the following disclaimer in the
+ *	 documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *	 names of its contributors may be used to endorse or promote products
+ *	 derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
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
+global-utilities@e1000 {
+	compatible = "fsl,qoriq-clockgen-1.0";
+	ranges = <0x0 0xe1000 0x1000>;
+	reg = <0xe1000 0x1000>;
+	clock-frequency = <0>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	sysclk: sysclk {
+		#clock-cells = <0>;
+		compatible = "fsl,qoriq-sysclk-1.0", "fixed-clock";
+		clock-output-names = "sysclk";
+	};
+	pll0: pll0@800 {
+		#clock-cells = <1>;
+		reg = <0x800 0x4>;
+		compatible = "fsl,qoriq-core-pll-1.0";
+		clocks = <&sysclk>;
+		clock-output-names = "pll0", "pll0-div2";
+	};
+	pll1: pll1@820 {
+		#clock-cells = <1>;
+		reg = <0x820 0x4>;
+		compatible = "fsl,qoriq-core-pll-1.0";
+		clocks = <&sysclk>;
+		clock-output-names = "pll1", "pll1-div2";
+	};
+	mux0: mux0@0 {
+		#clock-cells = <0>;
+		reg = <0x0 0x4>;
+		compatible = "fsl,qoriq-core-mux-1.0";
+		clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
+		clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
+		clock-output-names = "cmux0";
+	};
+	mux1: mux1@20 {
+		#clock-cells = <0>;
+		reg = <0x20 0x4>;
+		compatible = "fsl,qoriq-core-mux-1.0";
+		clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
+		clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
+		clock-output-names = "cmux1";
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi
new file mode 100644
index 0000000..5d18d2a
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi
@@ -0,0 +1,61 @@
+/*
+ * QorIQ clock control device tree stub [ controller @ offset 0xe1000 ]
+ *
+ * Copyright 2014 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *	 notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *	 notice, this list of conditions and the following disclaimer in the
+ *	 documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *	 names of its contributors may be used to endorse or promote products
+ *	 derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
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
+global-utilities@e1000 {
+	compatible = "fsl,qoriq-clockgen-2.0";
+	ranges = <0x0 0xe1000 0x1000>;
+	reg = <0xe1000 0x1000>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	sysclk: sysclk {
+		#clock-cells = <0>;
+		compatible = "fsl,qoriq-sysclk-2.0", "fixed-clock";
+		clock-output-names = "sysclk";
+	};
+	pll0: pll0@800 {
+		#clock-cells = <1>;
+		reg = <0x800 0x4>;
+		compatible = "fsl,qoriq-core-pll-2.0";
+		clocks = <&sysclk>;
+		clock-output-names = "pll0", "pll0-div2", "pll0-div4";
+	};
+	pll1: pll1@820 {
+		#clock-cells = <1>;
+		reg = <0x820 0x4>;
+		compatible = "fsl,qoriq-core-pll-2.0";
+		clocks = <&sysclk>;
+		clock-output-names = "pll1", "pll1-div2", "pll1-div4";
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
index e989b6a..b726be1 100644
--- a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
@@ -432,35 +432,9 @@
 		fsl,liodn-bits = <12>;
 	};
 
-	clockgen: global-utilities@e1000 {
+/include/ "qoriq-clockgen2.dtsi"
+	global-utilities@e1000 {
 		compatible = "fsl,t1040-clockgen", "fsl,qoriq-clockgen-2.0";
-		ranges = <0x0 0xe1000 0x1000>;
-		reg = <0xe1000 0x1000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		sysclk: sysclk {
-			#clock-cells = <0>;
-			compatible = "fsl,qoriq-sysclk-2.0";
-			clock-output-names = "sysclk", "fixed-clock";
-		};
-
-
-		pll0: pll0@800 {
-			#clock-cells = <1>;
-			reg = <0x800 4>;
-			compatible = "fsl,qoriq-core-pll-2.0";
-			clocks = <&sysclk>;
-			clock-output-names = "pll0", "pll0-div2", "pll0-div4";
-		};
-
-		pll1: pll1@820 {
-			#clock-cells = <1>;
-			reg = <0x820 4>;
-			compatible = "fsl,qoriq-core-pll-2.0";
-			clocks = <&sysclk>;
-			clock-output-names = "pll1", "pll1-div2", "pll1-div4";
-		};
 
 		mux0: mux0@0 {
 			#clock-cells = <0>;
diff --git a/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi b/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
index dfbe499..b71dd1c 100644
--- a/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
@@ -553,34 +553,9 @@
 		fsl,liodn-bits = <12>;
 	};
 
-	clockgen: global-utilities@e1000 {
+/include/ "qoriq-clockgen2.dtsi"
+	global-utilities@e1000 {
 		compatible = "fsl,t2080-clockgen", "fsl,qoriq-clockgen-2.0";
-		ranges = <0x0 0xe1000 0x1000>;
-		reg = <0xe1000 0x1000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		sysclk: sysclk {
-			#clock-cells = <0>;
-			compatible = "fsl,qoriq-sysclk-2.0";
-			clock-output-names = "sysclk", "fixed-clock";
-		};
-
-		pll0: pll0@800 {
-			#clock-cells = <1>;
-			reg = <0x800 4>;
-			compatible = "fsl,qoriq-core-pll-2.0";
-			clocks = <&sysclk>;
-			clock-output-names = "pll0", "pll0-div2", "pll0-div4";
-		};
-
-		pll1: pll1@820 {
-			#clock-cells = <1>;
-			reg = <0x820 4>;
-			compatible = "fsl,qoriq-core-pll-2.0";
-			clocks = <&sysclk>;
-			clock-output-names = "pll1", "pll1-div2", "pll1-div4";
-		};
 
 		mux0: mux0@0 {
 			#clock-cells = <0>;
diff --git a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
index d2ecd86..c0fcd6b 100644
--- a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
@@ -1032,34 +1032,9 @@
 		fsl,liodn-bits = <12>;
 	};
 
-	clockgen: global-utilities@e1000 {
+/include/ "qoriq-clockgen2.dtsi"
+	global-utilities@e1000 {
 		compatible = "fsl,t4240-clockgen", "fsl,qoriq-clockgen-2.0";
-		ranges = <0x0 0xe1000 0x1000>;
-		reg = <0xe1000 0x1000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		sysclk: sysclk {
-			#clock-cells = <0>;
-			compatible = "fsl,qoriq-sysclk-2.0";
-			clock-output-names = "sysclk";
-		};
-
-		pll0: pll0@800 {
-			#clock-cells = <1>;
-			reg = <0x800 0x4>;
-			compatible = "fsl,qoriq-core-pll-2.0";
-			clocks = <&sysclk>;
-			clock-output-names = "pll0", "pll0-div2", "pll0-div4";
-		};
-
-		pll1: pll1@820 {
-			#clock-cells = <1>;
-			reg = <0x820 0x4>;
-			compatible = "fsl,qoriq-core-pll-2.0";
-			clocks = <&sysclk>;
-			clock-output-names = "pll1", "pll1-div2", "pll1-div4";
-		};
 
 		pll2: pll2@840 {
 			#clock-cells = <1>;
diff --git a/arch/powerpc/boot/dts/t4240emu.dts b/arch/powerpc/boot/dts/t4240emu.dts
index bc12127a..decaf35 100644
--- a/arch/powerpc/boot/dts/t4240emu.dts
+++ b/arch/powerpc/boot/dts/t4240emu.dts
@@ -250,9 +250,9 @@
 		fsl,liodn-bits = <12>;
 	};
 
-	clockgen: global-utilities@e1000 {
+/include/ "fsl/qoriq-clockgen2.dtsi"
+	global-utilities@e1000 {
 		compatible = "fsl,t4240-clockgen", "fsl,qoriq-clockgen-2.0";
-		reg = <0xe1000 0x1000>;
 	};
 
 /include/ "fsl/qoriq-dma-0.dtsi"
-- 
2.1.3
