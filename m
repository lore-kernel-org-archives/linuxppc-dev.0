Return-Path: <SRS0=Z2Z0=4A=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FE5C2BA83
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Feb 2020 04:41:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D066F2086A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Feb 2020 04:41:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D066F2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48HRnJ1sJFzDqLK
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Feb 2020 15:41:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=nxp.com
 (client-ip=92.121.34.13; helo=inva020.nxp.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48HRfM5wF9zDqKH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2020 15:35:47 +1100 (AEDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4D5271C71CD;
 Wed, 12 Feb 2020 05:35:44 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 31C391C71C8;
 Wed, 12 Feb 2020 05:35:37 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 88F1F4029B;
 Wed, 12 Feb 2020 12:35:28 +0800 (SGT)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org,
 mark.rutland@arm.com, devicetree@vger.kernel.org
Subject: [PATCH 2/3] ASoC: dt-bindings: fsl_easrc: Add document for EASRC
Date: Wed, 12 Feb 2020 12:30:02 +0800
Message-Id: <1ae9af586a2003e23885ccc7ef58ee2b1dce29f7.1581475981.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1581475981.git.shengjiu.wang@nxp.com>
References: <cover.1581475981.git.shengjiu.wang@nxp.com>
In-Reply-To: <cover.1581475981.git.shengjiu.wang@nxp.com>
References: <cover.1581475981.git.shengjiu.wang@nxp.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

EASRC (Enhanced Asynchronous Sample Rate Converter) is a new
IP module found on i.MX815.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 .../devicetree/bindings/sound/fsl,easrc.txt   | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,easrc.txt

diff --git a/Documentation/devicetree/bindings/sound/fsl,easrc.txt b/Documentation/devicetree/bindings/sound/fsl,easrc.txt
new file mode 100644
index 000000000000..0e8153165e3b
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,easrc.txt
@@ -0,0 +1,57 @@
+NXP Asynchronous Sample Rate Converter (ASRC) Controller
+
+The Asynchronous Sample Rate Converter (ASRC) converts the sampling rate of a
+signal associated with an input clock into a signal associated with a different
+output clock. The driver currently works as a Front End of DPCM with other Back
+Ends Audio controller such as ESAI, SSI and SAI. It has four context to support
+four substreams within totally 32 channels.
+
+Required properties:
+- compatible:                Contains "fsl,imx8mn-easrc".
+
+- reg:                       Offset and length of the register set for the
+			     device.
+
+- interrupts:                Contains the asrc interrupt.
+
+- dmas:                      Generic dma devicetree binding as described in
+		             Documentation/devicetree/bindings/dma/dma.txt.
+
+- dma-names:                 Contains "ctx0_rx", "ctx0_tx",
+				      "ctx1_rx", "ctx1_tx",
+			              "ctx2_rx", "ctx2_tx",
+				      "ctx3_rx", "ctx3_tx".
+
+- clocks:                    Contains an entry for each entry in clock-names.
+
+- clock-names:               "mem" - Peripheral clock to driver module.
+
+- fsl,easrc-ram-script-name: The coefficient table for the filters
+
+- fsl,asrc-rate:             Defines a mutual sample rate used by DPCM Back
+			     Ends.
+
+- fsl,asrc-width:            Defines a mutual sample width used by DPCM Back
+			     Ends.
+
+Example:
+
+easrc: easrc@300C0000 {
+	compatible = "fsl,imx8mn-easrc";
+	reg = <0x0 0x300C0000 0x0 0x10000>;
+	interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&clk IMX8MN_CLK_ASRC_ROOT>;
+	clock-names = "mem";
+	dmas = <&sdma2 16 23 0> , <&sdma2 17 23 0>,
+	       <&sdma2 18 23 0> , <&sdma2 19 23 0>,
+	       <&sdma2 20 23 0> , <&sdma2 21 23 0>,
+	       <&sdma2 22 23 0> , <&sdma2 23 23 0>;
+	dma-names = "ctx0_rx", "ctx0_tx",
+		    "ctx1_rx", "ctx1_tx",
+		    "ctx2_rx", "ctx2_tx",
+		    "ctx3_rx", "ctx3_tx";
+	fsl,easrc-ram-script-name = "imx/easrc/easrc-imx8mn.bin";
+	fsl,asrc-rate  = <8000>;
+	fsl,asrc-width = <16>;
+	status = "disabled";
+};
-- 
2.21.0

