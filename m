Return-Path: <SRS0=pi+/=NQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CD4C0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 08:53:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 490E220819
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 08:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 490E220819
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42pRKp6lYMzF10j
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 19:53:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=92.121.34.13; helo=inva020.nxp.com;
 envelope-from=xiaowei.bao@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42pRHH6xJ9zDrPb
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Nov 2018 19:51:22 +1100 (AEDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C04BD1A012F;
 Mon,  5 Nov 2018 09:51:18 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6A8C11A009E;
 Mon,  5 Nov 2018 09:51:08 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E9C2B402DF;
 Mon,  5 Nov 2018 16:50:55 +0800 (SGT)
From: Xiaowei Bao <xiaowei.bao@nxp.com>
To: bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
 shawnguo@kernel.org, leoyang.li@nxp.com, kishon@ti.com,
 lorenzo.pieralisi@arm.com, arnd@arndb.de, gregkh@linuxfoundation.org,
 minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
 kstewart@linuxfoundation.org, cyrille.pitchen@free-electrons.com,
 pombredanne@nexb.com, shawn.lin@rock-chips.com, niklas.cassel@axis.com,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCHv2 1/6] arm64: dts: Add the status property disable PCIe
Date: Mon,  5 Nov 2018 16:46:48 +0800
Message-Id: <20181105084653.26597-1-xiaowei.bao@nxp.com>
X-Mailer: git-send-email 2.14.1
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
Cc: Bao Xiaowei <xiaowei.bao@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Bao Xiaowei <xiaowei.bao@nxp.com>

Add the status property disable the PCIe, the property will be enable
by bootloader.

Signed-off-by: Bao Xiaowei <xiaowei.bao@nxp.com>
---
v2:
 - no change

 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi |    1 +
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi |    3 +++
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi |    3 +++
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi |    3 +++
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi |    4 ++++
 5 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 5da732f..21f2b3b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -496,6 +496,7 @@
 					<0000 0 0 2 &gic 0 111 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic 0 112 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic 0 113 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 3fed504..760d510 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -683,6 +683,7 @@
 					<0000 0 0 2 &gic 0 111 0x4>,
 					<0000 0 0 3 &gic 0 112 0x4>,
 					<0000 0 0 4 &gic 0 113 0x4>;
+			status = "disabled";
 		};
 
 		pcie@3500000 {
@@ -708,6 +709,7 @@
 					<0000 0 0 2 &gic 0 121 0x4>,
 					<0000 0 0 3 &gic 0 122 0x4>,
 					<0000 0 0 4 &gic 0 123 0x4>;
+			status = "disabled";
 		};
 
 		pcie@3600000 {
@@ -733,6 +735,7 @@
 					<0000 0 0 2 &gic 0 155 0x4>,
 					<0000 0 0 3 &gic 0 156 0x4>,
 					<0000 0 0 4 &gic 0 157 0x4>;
+			status = "disabled";
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 51cbd50..64d334c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -652,6 +652,7 @@
 					<0000 0 0 2 &gic GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
 		};
 
 		pcie@3500000 {
@@ -677,6 +678,7 @@
 					<0000 0 0 2 &gic GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
 		};
 
 		pcie@3600000 {
@@ -702,6 +704,7 @@
 					<0000 0 0 2 &gic GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
 		};
 
 	};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index a07f612..9deb9cb 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -533,6 +533,7 @@
 					<0000 0 0 2 &gic 0 0 0 110 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic 0 0 0 111 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic 0 0 0 112 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
 		};
 
 		pcie@3500000 {
@@ -557,6 +558,7 @@
 					<0000 0 0 2 &gic 0 0 0 115 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic 0 0 0 116 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic 0 0 0 117 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
 		};
 
 		pcie@3600000 {
@@ -581,6 +583,7 @@
 					<0000 0 0 2 &gic 0 0 0 120 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic 0 0 0 121 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic 0 0 0 122 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
 		};
 
 		cluster1_core0_watchdog: wdt@c000000 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index d188774..5732e3b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -648,6 +648,7 @@
 					<0000 0 0 2 &gic 0 0 0 110 4>,
 					<0000 0 0 3 &gic 0 0 0 111 4>,
 					<0000 0 0 4 &gic 0 0 0 112 4>;
+			status = "disabled";
 		};
 
 		pcie2: pcie@3500000 {
@@ -669,6 +670,7 @@
 					<0000 0 0 2 &gic 0 0 0 115 4>,
 					<0000 0 0 3 &gic 0 0 0 116 4>,
 					<0000 0 0 4 &gic 0 0 0 117 4>;
+			status = "disabled";
 		};
 
 		pcie3: pcie@3600000 {
@@ -690,6 +692,7 @@
 					<0000 0 0 2 &gic 0 0 0 120 4>,
 					<0000 0 0 3 &gic 0 0 0 121 4>,
 					<0000 0 0 4 &gic 0 0 0 122 4>;
+			status = "disabled";
 		};
 
 		pcie4: pcie@3700000 {
@@ -711,6 +714,7 @@
 					<0000 0 0 2 &gic 0 0 0 125 4>,
 					<0000 0 0 3 &gic 0 0 0 126 4>,
 					<0000 0 0 4 &gic 0 0 0 127 4>;
+			status = "disabled";
 		};
 
 		sata0: sata@3200000 {
-- 
1.7.1

