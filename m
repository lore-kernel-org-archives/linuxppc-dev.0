Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F203C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 03:24:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 135D72086C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 03:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 135D72086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444fvz4GzxzDqKP
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 14:24:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=92.121.34.13; helo=inva020.nxp.com;
 envelope-from=xiaowei.bao@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444ft72hV9zDqKJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 14:22:38 +1100 (AEDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F14741A0164;
 Thu, 21 Feb 2019 04:22:35 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F0C6B1A0315;
 Thu, 21 Feb 2019 04:22:26 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 703AB402F7;
 Thu, 21 Feb 2019 11:22:15 +0800 (SGT)
From: Xiaowei Bao <xiaowei.bao@nxp.com>
To: bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
 shawnguo@kernel.org, leoyang.li@nxp.com, kishon@ti.com,
 lorenzo.pieralisi@arm.com, arnd@arndb.de, gregkh@linuxfoundation.org,
 minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
 kstewart@linuxfoundation.org, pombredanne@nexb.com,
 shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCHv7 2/4] arm64: dts: Add the PCIE EP node in dts
Date: Thu, 21 Feb 2019 11:16:18 +0800
Message-Id: <20190221031620.43554-2-xiaowei.bao@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190221031620.43554-1-xiaowei.bao@nxp.com>
References: <20190221031620.43554-1-xiaowei.bao@nxp.com>
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
Cc: Xiaowei Bao <xiaowei.bao@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add the PCIE EP node in dts for ls1046a.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
Reviewed-by: Minghuan Lian <minghuan.lian@nxp.com>
Reviewed-by: Zhiqiang Hou <zhiqiang.hou@nxp.com>
Reviewed-by: Rob Herring <robh+dt@kernel.org>
---
v2:
 - Add the SoC specific compatibles. 
v3:
 - no change
v4:
 - no change
v5:
 - change the OB win number due to the RM update.
v6:
 - no change
v7:
 - no change

 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi |   34 +++++++++++++++++++++++-
 1 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 9a2106e..576262e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -657,6 +657,17 @@
 			status = "disabled";
 		};
 
+		pcie_ep@3400000 {
+			compatible = "fsl,ls1046a-pcie-ep","fsl,ls-pcie-ep";
+			reg = <0x00 0x03400000 0x0 0x00100000
+				0x40 0x00000000 0x8 0x00000000>;
+			reg-names = "regs", "addr_space";
+			num-ib-windows = <6>;
+			num-ob-windows = <8>;
+			num-lanes = <2>;
+			status = "disabled";
+		};
+
 		pcie@3500000 {
 			compatible = "fsl,ls1046a-pcie";
 			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
@@ -683,6 +694,17 @@
 			status = "disabled";
 		};
 
+		pcie_ep@3500000 {
+			compatible = "fsl,ls1046a-pcie-ep","fsl,ls-pcie-ep";
+			reg = <0x00 0x03500000 0x0 0x00100000
+				0x48 0x00000000 0x8 0x00000000>;
+			reg-names = "regs", "addr_space";
+			num-ib-windows = <6>;
+			num-ob-windows = <8>;
+			num-lanes = <2>;
+			status = "disabled";
+		};
+
 		pcie@3600000 {
 			compatible = "fsl,ls1046a-pcie";
 			reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
@@ -709,6 +731,17 @@
 			status = "disabled";
 		};
 
+		pcie_ep@3600000 {
+			compatible = "fsl,ls1046a-pcie-ep", "fsl,ls-pcie-ep";
+			reg = <0x00 0x03600000 0x0 0x00100000
+				0x50 0x00000000 0x8 0x00000000>;
+			reg-names = "regs", "addr_space";
+			num-ib-windows = <6>;
+			num-ob-windows = <8>;
+			num-lanes = <2>;
+			status = "disabled";
+		};
+
 		qdma: dma-controller@8380000 {
 			compatible = "fsl,ls1046a-qdma", "fsl,ls1021a-qdma";
 			reg = <0x0 0x8380000 0x0 0x1000>, /* Controller regs */
@@ -729,7 +762,6 @@
 			queue-sizes = <64 64>;
 			big-endian;
 		};
-
 	};
 
 	reserved-memory {
-- 
1.7.1

