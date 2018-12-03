Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B2EC04EB9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 22:43:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5FF020661
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 22:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5FF020661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4380QH007FzDqQB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 09:43:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.65; helo=mail-ot1-f65.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 437ysG1TBTzDqNC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 08:33:06 +1100 (AEDT)
Received: by mail-ot1-f65.google.com with SMTP id w25so13084525otm.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Dec 2018 13:33:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/92DiavR/XOHqaCGpCKXJW+JP+tQRs9C+uVOk6OIp1s=;
 b=SBm6e7CDvbUerZZOpCka9OoqN9t9MyvXHj2fA3SX3GzaVMJZxl8/Y9ElKO7SaGPFCv
 ciOhbTCPvrkZyYagNk6kyTQPqKbxvnc5bwuvrOJ9q6sNbuUaLgPQOcCMTQYSbM0N6rJb
 6qkilL9stS1UrofKXV/fY/QwWCfkHCeeu1B4dJlSJR75FRJuqgvUokPx2+6xM5WXf971
 GIJgvozUhMSrgWBNMqQh5Sud/4tUnMzw5vTN2i/3uBNP4fCCXFQi/ILxv3iZ3Her74In
 4YxA3Fb+UZysZUJd4HMDv5Q9I/eSZXhcSyYn6AbHlSmhfudoN0O+ABbWkMsgpblrcwYo
 vtIg==
X-Gm-Message-State: AA+aEWa9m5aQy2qUHD+gzvX4RL2vJTdnZQ+zPRDMC8jeJzN9LFoMDRwt
 UMzr8+Um2LSWo7R/eB8oXQ==
X-Google-Smtp-Source: AFSGD/VtQ/5gSTtjzeX8q6VwImffvSZJapn9KmJ8qmm7Tc4/yN2d0tyrgec64J8lZNgv4y3KHtwuuA==
X-Received: by 2002:a05:6830:1099:: with SMTP id
 y25mr12304339oto.313.1543872784277; 
 Mon, 03 Dec 2018 13:33:04 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.33.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 13:33:03 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 32/34] dt-bindings: arm: Convert Xilinx board/soc bindings
 to json-schema
Date: Mon,  3 Dec 2018 15:32:21 -0600
Message-Id: <20181203213223.16986-33-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Mark Rutland <mark.rutland@arm.com>, Kumar Gala <kumar.gala@linaro.org>,
 arm@kernel.org, Sean Hudson <darknighte@darknighte.com>,
 Frank Rowand <frowand.list@gmail.com>, Michal Simek <michal.simek@xilinx.com>,
 Grant Likely <grant.likely@arm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
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
 .../devicetree/bindings/arm/xilinx.yaml       | 82 ++++++++++++++++++
 2 files changed, 82 insertions(+), 83 deletions(-)
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
index 000000000000..64cd21b737af
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/xilinx.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/xilinx.yaml#
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
2.19.1

