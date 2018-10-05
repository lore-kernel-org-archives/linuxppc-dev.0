Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F611C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 18:15:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CF9B2054F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 18:15:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CF9B2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RdG53wTjzDqfJ
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 04:15:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.67; helo=mail-ot1-f67.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Rbb11ZYszF3TS
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 02:59:41 +1000 (AEST)
Received: by mail-ot1-f67.google.com with SMTP id l1so30792otj.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 09:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=K6DS5KOWh37k/+Xlr9IAvySrcc8KgKImzo5J4g96Byg=;
 b=XrqQXr0pqre3QNztWbVP/PME+Y6ihP6dS5PMTVxl2XSYXlK/TfkZNh6iP3azXLDIL8
 NnJvLni//oRhYBWWR6iRLL+oxLH9IOLlLXg9mcXICQugVn3PGXxJz4nz7Ik7SERzusRC
 x4lWCMyNx8CHYrZ+nAwVV166wMplREElvNZvoEj3Jsw2dRhRhNKHASLbXNSHpYKyoJKc
 WzNKrAVb551iaP6acSa6CoEuY68yDEVxThU4P+nWy4iY2D/qmobyLE0Zd9EknFuBemzF
 9dMhOCXJx0rNsWj9gcUIo2CuFucwhdXhWer4x1J66HAoZG3PYEWi7xtbtzL6KSuuTh2V
 th6g==
X-Gm-Message-State: ABuFfogpqFRFPYrztaG5fpatwbuV2JDvkNTjR3cpC2SoK9vfH6NitkS7
 FKLL87sbFwa5y4XsC6E9HA==
X-Google-Smtp-Source: ACcGV60OL1OoEijnN9sBEBjMyOAIGNgusrIAHLn3X0DLf4SbPDK+weRwtqhH72w++lIlwNjzEkCtcg==
X-Received: by 2002:a9d:2e30:: with SMTP id q45mr6730173otb.69.1538758779232; 
 Fri, 05 Oct 2018 09:59:39 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49]) by smtp.googlemail.com with ESMTPSA id
 u63-v6sm2904328ota.75.2018.10.05.09.59.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Oct 2018 09:59:38 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 35/36] dt-bindings: arm: Convert Xilinx board/soc bindings to
 json-schema
Date: Fri,  5 Oct 2018 11:58:47 -0500
Message-Id: <20181005165848.3474-36-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005165848.3474-1-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Tom Rini <trini@konsulko.com>,
 Kumar Gala <kumar.gala@linaro.org>, Grant Likely <glikely@secretlab.ca>,
 Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michal Simek <michal.simek@xilinx.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Olof Johansson <olof@lixom.net>,
 Frank Rowand <frowand.list@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Convert Xilinx SoC bindings to DT schema format using json-schema.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/xilinx.txt        | 83 -------------------
 .../devicetree/bindings/arm/xilinx.yaml       | 81 ++++++++++++++++++
 2 files changed, 81 insertions(+), 83 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/xilinx.txt
 create mode 100644 Documentation/devicetree/bindings/arm/xilinx.yaml

diff --git a/Documentation/devicetree/bindings/arm/xilinx.txt b/Documentation/devicetree/bindings/arm/xilinx.txt
deleted file mode 100644
index 26fe5ecc4332..000000000000
--- a/Documentation/devicetree/bindings/arm/xilinx.txt
+++ /dev/null
@@ -1,83 +0,0 @@
-Xilinx Zynq Platforms Device Tree Bindings
-
-Boards with Zynq-7000 SOC based on an ARM Cortex A9 processor
-shall have the following properties.
-
-Required root node properties:
-    - compatible = "xlnx,zynq-7000";
-
-Additional compatible strings:
-
-- Adapteva Parallella board
-  "adapteva,parallella"
-
-- Avnet MicroZed board
-  "avnet,zynq-microzed"
-  "xlnx,zynq-microzed"
-
-- Avnet ZedBoard board
-  "avnet,zynq-zed"
-  "xlnx,zynq-zed"
-
-- Digilent Zybo board
-  "digilent,zynq-zybo"
-
-- Digilent Zybo Z7 board
-  "digilent,zynq-zybo-z7"
-
-- Xilinx CC108 internal board
-  "xlnx,zynq-cc108"
-
-- Xilinx ZC702 internal board
-  "xlnx,zynq-zc702"
-
-- Xilinx ZC706 internal board
-  "xlnx,zynq-zc706"
-
-- Xilinx ZC770 internal board, with different FMC cards
-  "xlnx,zynq-zc770-xm010"
-  "xlnx,zynq-zc770-xm011"
-  "xlnx,zynq-zc770-xm012"
-  "xlnx,zynq-zc770-xm013"
-
----------------------------------------------------------------
-
-Xilinx Zynq UltraScale+ MPSoC Platforms Device Tree Bindings
-
-Boards with ZynqMP SOC based on an ARM Cortex A53 processor
-shall have the following properties.
-
-Required root node properties:
-    - compatible = "xlnx,zynqmp";
-
-
-Additional compatible strings:
-
-- Xilinx internal board zc1232
-  "xlnx,zynqmp-zc1232-revA", "xlnx,zynqmp-zc1232"
-
-- Xilinx internal board zc1254
-  "xlnx,zynqmp-zc1254-revA", "xlnx,zynqmp-zc1254"
-
-- Xilinx internal board zc1275
-  "xlnx,zynqmp-zc1275-revA", "xlnx,zynqmp-zc1275"
-
-- Xilinx internal board zc1751
-  "xlnx,zynqmp-zc1751"
-
-- Xilinx 96boards compatible board zcu100
-  "xlnx,zynqmp-zcu100-revC", "xlnx,zynqmp-zcu100"
-
-- Xilinx evaluation board zcu102
-  "xlnx,zynqmp-zcu102-revA", "xlnx,zynqmp-zcu102"
-  "xlnx,zynqmp-zcu102-revB", "xlnx,zynqmp-zcu102"
-  "xlnx,zynqmp-zcu102-rev1.0", "xlnx,zynqmp-zcu102"
-
-- Xilinx evaluation board zcu104
-  "xlnx,zynqmp-zcu104-revA", "xlnx,zynqmp-zcu104"
-
-- Xilinx evaluation board zcu106
-  "xlnx,zynqmp-zcu106-revA", "xlnx,zynqmp-zcu106"
-
-- Xilinx evaluation board zcu111
-  "xlnx,zynqmp-zcu111-revA", "xlnx,zynqmp-zcu111"
diff --git a/Documentation/devicetree/bindings/arm/xilinx.yaml b/Documentation/devicetree/bindings/arm/xilinx.yaml
new file mode 100644
index 000000000000..dd227bccf015
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/xilinx.yaml
@@ -0,0 +1,81 @@
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/arm/xilinx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Zynq Platforms Device Tree Bindings
+
+maintainers:
+  - Michal Simek <michal.simek@xilinx.com>
+
+description: |
+  Xilinx boards with Zynq-7000 SOC or Zynq UltraScale+ MPSoC
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - adapteva,parallella
+              - digilent,zynq-zybo
+              - digilent,zynq-zybo-z7
+              - xlnx,zynq-cc108
+              - xlnx,zynq-zc702
+              - xlnx,zynq-zc706
+              - xlnx,zynq-zc770-xm010
+              - xlnx,zynq-zc770-xm011
+              - xlnx,zynq-zc770-xm012
+              - xlnx,zynq-zc770-xm013
+          - const: xlnx,zynq-7000
+
+      - items:
+          - const: avnet,zynq-microzed
+          - const: xlnx,zynq-microzed
+          - const: xlnx,zynq-7000
+
+      - items:
+          - const: avnet,zynq-zed
+          - const: xlnx,zynq-zed
+          - const: xlnx,zynq-7000
+
+      - items:
+          - enum:
+              - xlnx,zynqmp-zc1751
+          - const: xlnx,zynqmp
+
+      - description: Xilinx internal board zc1232
+        items:
+          - const: xlnx,zynqmp-zc1232-revA
+          - const: xlnx,zynqmp-zc1232
+          - const: xlnx,zynqmp
+
+      - description: Xilinx internal board zc1254
+        items:
+          - const: xlnx,zynqmp-zc1254-revA
+          - const: xlnx,zynqmp-zc1254
+          - const: xlnx,zynqmp
+
+      - description: Xilinx internal board zc1275
+        items:
+          - const: xlnx,zynqmp-zc1275-revA
+          - const: xlnx,zynqmp-zc1275
+          - const: xlnx,zynqmp
+
+      - description: Xilinx 96boards compatible board zcu100
+        items:
+          - const: xlnx,zynqmp-zcu100-revC
+          - const: xlnx,zynqmp-zcu100
+          - const: xlnx,zynqmp
+
+      - description: Xilinx evaluation board zcu102
+        items:
+          - enum:
+              - xlnx,zynqmp-zcu102-revA
+              - xlnx,zynqmp-zcu102-revB
+              - xlnx,zynqmp-zcu102-rev1.0
+          - const: xlnx,zynqmp-zcu102
+          - const: xlnx,zynqmp
+
+...
-- 
2.17.1

