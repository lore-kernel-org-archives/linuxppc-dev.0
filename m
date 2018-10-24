Return-Path: <SRS0=Hff1=NE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A4BC46475
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 02:26:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 059112054F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 02:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 059112054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42fvJC56XkzF379
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 13:26:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=92.121.34.13; helo=inva020.nxp.com; envelope-from=andy.tang@nxp.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
X-Greylist: delayed 422 seconds by postgrey-1.36 at bilbo;
 Wed, 24 Oct 2018 13:22:39 AEDT
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42fvDH2wjhzDrPw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 13:22:39 +1100 (AEDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A47231A00FC;
 Wed, 24 Oct 2018 04:15:34 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 85B681A00E6;
 Wed, 24 Oct 2018 04:15:28 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 6E9D7402A9;
 Wed, 24 Oct 2018 10:15:21 +0800 (SGT)
From: andy.tang@nxp.com
To: sboyd@kernel.org,
	mturquette@baylibre.com,
	oss@buserror.net
Subject: [PATCH 2/3 v2] clk: qoriq: remove legacy bindings and add more
 compatibles
Date: Wed, 24 Oct 2018 10:11:21 +0800
Message-Id: <20181024021122.3942-2-andy.tang@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20181024021122.3942-1-andy.tang@nxp.com>
References: <20181024021122.3942-1-andy.tang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 Yuantian Tang <andy.tang@nxp.com>, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 linux-clk@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Yuantian Tang <andy.tang@nxp.com>

The new bindings will be used, so delete the old bindings.
Add more SOC compatibles as needed as well.

Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
---
v2:
  - involve more chips

 .../devicetree/bindings/clock/qoriq-clock.txt      |  112 +------------------
 1 files changed, 6 insertions(+), 106 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qoriq-clock.txt b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
index 97f46ad..8484d90 100644
--- a/Documentation/devicetree/bindings/clock/qoriq-clock.txt
+++ b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
@@ -28,6 +28,12 @@ Required properties:
 	* "fsl,p4080-clockgen"
 	* "fsl,p5020-clockgen"
 	* "fsl,p5040-clockgen"
+	* "fsl,t1023-clockgen"
+	* "fsl,t1024-clockgen"
+	* "fsl,t1040-clockgen"
+	* "fsl,t1042-clockgen"
+	* "fsl,t2080-clockgen"
+	* "fsl,t2081-clockgen"
 	* "fsl,t4240-clockgen"
 	* "fsl,b4420-clockgen"
 	* "fsl,b4860-clockgen"
@@ -96,109 +102,3 @@ second cell is the clock index for the specified type.
 		...
 	};
 }
-4. Legacy Child Nodes
-
-NOTE: These nodes are deprecated.  Kernels should continue to support
-device trees with these nodes, but new device trees should not use them.
-
-Most of the bindings are from the common clock binding[1].
- [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
-
-Required properties:
-- compatible : Should include one of the following:
-	* "fsl,qoriq-core-pll-1.0" for core PLL clocks (v1.0)
-	* "fsl,qoriq-core-pll-2.0" for core PLL clocks (v2.0)
-	* "fsl,qoriq-core-mux-1.0" for core mux clocks (v1.0)
-	* "fsl,qoriq-core-mux-2.0" for core mux clocks (v2.0)
-	* "fsl,qoriq-sysclk-1.0": for input system clock (v1.0).
-		It takes parent's clock-frequency as its clock.
-	* "fsl,qoriq-sysclk-2.0": for input system clock (v2.0).
-		It takes parent's clock-frequency as its clock.
-	* "fsl,qoriq-platform-pll-1.0" for the platform PLL clock (v1.0)
-	* "fsl,qoriq-platform-pll-2.0" for the platform PLL clock (v2.0)
-- #clock-cells: From common clock binding. The number of cells in a
-	clock-specifier. Should be <0> for "fsl,qoriq-sysclk-[1,2].0"
-	clocks, or <1> for "fsl,qoriq-core-pll-[1,2].0" clocks.
-	For "fsl,qoriq-core-pll-[1,2].0" clocks, the single
-	clock-specifier cell may take the following values:
-	* 0 - equal to the PLL frequency
-	* 1 - equal to the PLL frequency divided by 2
-	* 2 - equal to the PLL frequency divided by 4
-
-Recommended properties:
-- clocks: Should be the phandle of input parent clock
-- clock-names: From common clock binding, indicates the clock name
-- clock-output-names: From common clock binding, indicates the names of
-	output clocks
-- reg: Should be the offset and length of clock block base address.
-	The length should be 4.
-
-Legacy Example:
-/ {
-	clockgen: global-utilities@e1000 {
-		compatible = "fsl,p5020-clockgen", "fsl,qoriq-clockgen-1.0";
-		ranges = <0x0 0xe1000 0x1000>;
-		clock-frequency = <133333333>;
-		reg = <0xe1000 0x1000>;
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
-
-		platform-pll: platform-pll@c00 {
-			#clock-cells = <1>;
-			reg = <0xc00 0x4>;
-			compatible = "fsl,qoriq-platform-pll-1.0";
-			clocks = <&sysclk>;
-			clock-output-names = "platform-pll", "platform-pll-div2";
-		};
-	};
-};
-
-Example for legacy clock consumer:
-
-/ {
-	cpu0: PowerPC,e5500@0 {
-		...
-		clocks = <&mux0>;
-		...
-	};
-};
-- 
1.7.1

