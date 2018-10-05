Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53897C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 17:52:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20447205C9
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 17:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20447205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Rcl55MBQzF3bf
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 03:51:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.195; helo=mail-oi1-f195.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com
 [209.85.167.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RbZj4WxFzF3T3
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 02:59:25 +1000 (AEST)
Received: by mail-oi1-f195.google.com with SMTP id e17-v6so10957001oib.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 09:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=wn48U+ico/dYcmpUsy+6xSiWO0JyQssECtz/dnTzc3k=;
 b=ipQmad+etl9e6c9chTH8ahQHoe8xDjGENiIN3cIrxN0g902ON45EpGUHjYX/hSiBM7
 KKwqLso46OT5ImcrjmG6LMubIQIh2sXDdXNR1ZWQUbE74lWPcUQE4pVffooUW2KpmGgt
 06RGX52u+w0TBiDhcC1CkPZRAdQAdQlzBokmj6ObSK81piL39NTmjpgjilk1oQX03Zu1
 oKppGA8go3Wr0hHAYsWBd7HMbQI59b4LC8xI0RRRCwVLfYaYAI8C+YxDg7WRa64gUL2M
 KqITKX4UpWGsZqXjTkaQwYpQyBXaLeFqJdiFC1o8AcpryyHG5x5ELRpLCti2TBIkdTty
 40IQ==
X-Gm-Message-State: ABuFfoi1pCqgtP2CZcfg82j1DqZ9lOxIfpgOqjig4AWZPJBaHxizgHoZ
 j81qhZwOINimjvGJLSgi9A==
X-Google-Smtp-Source: ACcGV62vtMB8j/XzqDkUC/d52vsjzdV4cWrOjqi/nMv5wNLNVLO+MhZA7buUFefORGdvEzHZQZCHOA==
X-Received: by 2002:a54:4085:: with SMTP id
 i5-v6mr6046550oii.302.1538758763169; 
 Fri, 05 Oct 2018 09:59:23 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49]) by smtp.googlemail.com with ESMTPSA id
 u63-v6sm2904328ota.75.2018.10.05.09.59.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Oct 2018 09:59:22 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 23/36] dt-bindings: arm: Convert MediaTek board/soc bindings
 to json-schema
Date: Fri,  5 Oct 2018 11:58:35 -0500
Message-Id: <20181005165848.3474-24-robh@kernel.org>
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
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Olof Johansson <olof@lixom.net>,
 linux-mediatek@lists.infradead.org, Frank Rowand <frowand.list@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Convert MediaTek SoC bindings to DT schema format using json-schema.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/mediatek.txt      | 79 -----------------
 .../devicetree/bindings/arm/mediatek.yaml     | 85 +++++++++++++++++++
 2 files changed, 85 insertions(+), 79 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek.yaml

diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
deleted file mode 100644
index 8f260e5cfd16..000000000000
--- a/Documentation/devicetree/bindings/arm/mediatek.txt
+++ /dev/null
@@ -1,79 +0,0 @@
-MediaTek SoC based Platforms Device Tree Bindings
-
-Boards with a MediaTek SoC shall have the following property:
-
-Required root node property:
-
-compatible: Must contain one of
-   "mediatek,mt2701"
-   "mediatek,mt2712"
-   "mediatek,mt6580"
-   "mediatek,mt6589"
-   "mediatek,mt6592"
-   "mediatek,mt6755"
-   "mediatek,mt6765"
-   "mediatek,mt6795"
-   "mediatek,mt6797"
-   "mediatek,mt7622"
-   "mediatek,mt7623" which is referred to MT7623N SoC
-   "mediatek,mt7623a"
-   "mediatek,mt8127"
-   "mediatek,mt8135"
-   "mediatek,mt8173"
-
-
-Supported boards:
-
-- Evaluation board for MT2701:
-    Required root node properties:
-      - compatible = "mediatek,mt2701-evb", "mediatek,mt2701";
-- Evaluation board for MT2712:
-    Required root node properties:
-      - compatible = "mediatek,mt2712-evb", "mediatek,mt2712";
-- Evaluation board for MT6580:
-    Required root node properties:
-      - compatible = "mediatek,mt6580-evbp1", "mediatek,mt6580";
-- bq Aquaris5 smart phone:
-    Required root node properties:
-      - compatible = "mundoreader,bq-aquaris5", "mediatek,mt6589";
-- Evaluation board for MT6592:
-    Required root node properties:
-      - compatible = "mediatek,mt6592-evb", "mediatek,mt6592";
-- Evaluation phone for MT6755(Helio P10):
-    Required root node properties:
-      - compatible = "mediatek,mt6755-evb", "mediatek,mt6755";
-- Evaluation board for MT6765(Helio P22):
-    Required root node properties:
-      - compatible = "mediatek,mt6765-evb", "mediatek,mt6765";
-- Evaluation board for MT6795(Helio X10):
-    Required root node properties:
-      - compatible = "mediatek,mt6795-evb", "mediatek,mt6795";
-- Evaluation board for MT6797(Helio X20):
-    Required root node properties:
-      - compatible = "mediatek,mt6797-evb", "mediatek,mt6797";
-- Mediatek X20 Development Board:
-    Required root node properties:
-      - compatible = "archermind,mt6797-x20-dev", "mediatek,mt6797";
-- Reference board variant 1 for MT7622:
-    Required root node properties:
-      - compatible = "mediatek,mt7622-rfb1", "mediatek,mt7622";
-- Reference board for MT7623a with eMMC:
-    Required root node properties:
-      - compatible = "mediatek,mt7623a-rfb-emmc", "mediatek,mt7623";
-- Reference board for MT7623a with NAND:
-    Required root node properties:
-      - compatible = "mediatek,mt7623a-rfb-nand", "mediatek,mt7623";
-- Reference board for MT7623n with eMMC:
-    Required root node properties:
-      - compatible = "mediatek,mt7623n-rfb-emmc", "mediatek,mt7623";
-- Bananapi BPI-R2 board:
-      - compatible = "bananapi,bpi-r2", "mediatek,mt7623";
-- MTK mt8127 tablet moose EVB:
-    Required root node properties:
-      - compatible = "mediatek,mt8127-moose", "mediatek,mt8127";
-- MTK mt8135 tablet EVB:
-    Required root node properties:
-      - compatible = "mediatek,mt8135-evbp1", "mediatek,mt8135";
-- MTK mt8173 tablet EVB:
-    Required root node properties:
-      - compatible = "mediatek,mt8173-evb", "mediatek,mt8173";
diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
new file mode 100644
index 000000000000..861af7c66ac5
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: None
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/arm/mediatek.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek SoC based Platforms Device Tree Bindings
+
+maintainers:
+  - Sean Wang <sean.wang@mediatek.com>
+  - Matthias Brugger <matthias.bgg@gmail.com>
+description: |
+  Boards with a MediaTek SoC shall have the following properties.
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - mediatek,mt2701-evb
+          - const: mediatek,mt2701
+
+      - items:
+          - enum:
+              - mediatek,mt2712-evb
+          - const: mediatek,mt2712
+      - items:
+          - enum:
+              - mediatek,mt6580-evbp1
+          - const: mediatek,mt6580
+      - items:
+          - enum:
+              - mundoreader,bq-aquaris5
+          - const: mediatek,mt6589
+      - items:
+          - enum:
+              - mediatek,mt6592-evb
+          - const: mediatek,mt6592
+      - items:
+          - enum:
+              - mediatek,mt6755-evb
+          - const: mediatek,mt6755
+      - items:
+          - enum:
+              - mediatek,mt6765-evb
+          - const: mediatek,mt6765
+      - items:
+          - enum:
+              - mediatek,mt6795-evb
+          - const: mediatek,mt6795
+      - items:
+          - enum:
+              - archermind,mt6797-x20-dev
+              - mediatek,mt6797-evb
+          - const: mediatek,mt6797
+      - items:
+          - enum:
+              - mediatek,mt7622-rfb1
+          - const: mediatek,mt7622
+      - items:
+          - enum:
+              - mediatek,mt7623a-rfb-emmc
+              - mediatek,mt7623a-rfb-nand
+              - mediatek,mt7623n-rfb-emmc
+              - bananapi,bpi-r2
+          - const: mediatek,mt7623
+        description: Also referred to as MT7623N SoC
+
+      - items:
+          - const: mediatek,mt7623a
+      - items:
+          - enum:
+              - mediatek,mt8127-moose
+          - const: mediatek,mt8127
+      - items:
+          - enum:
+              - mediatek,mt8135-evbp1
+          - const: mediatek,mt8135
+      - items:
+          - enum:
+              - mediatek,mt8173-evb
+          - const: mediatek,mt8173
+...
-- 
2.17.1

