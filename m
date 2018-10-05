Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB8DC00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 17:57:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32BEF205C9
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 17:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32BEF205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RcsN5MmMzF1nf
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 03:57:12 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RbZn0sr2zF3TZ
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 02:59:29 +1000 (AEST)
Received: by mail-ot1-f67.google.com with SMTP id k5so559688ote.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 09:59:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=6vZiAwZ/FaAxsaPwcmZJkmnX3wWUiSpbkZC8KjnTZio=;
 b=YgtpAeT1iQ3iYdnYSUrph92as92vRsfARfiZTJtnKJwRKjALCOHgk6BMAZgfmYXPYX
 lmQfE3gOoJJxJ9ESkhsjyHy6iqwyjqzxGfYYmYK/9e9SeO//JsfRpBpFsC1N1/gCzrtS
 hvxVTy21e8ctYHT0okKoytbJFg8OsMOlGkCEKt+hEfYNPkK2e6DXVbIktB8KeeRIupmK
 /pbo/z4UJXVA89SLHgm66gK4GRQMUcNvMfp0wMu4P6pQCAGo++hFGSn+hAGbI1XUFHm+
 RSuduA/CVP9Gz4KphEGTXLxv6FTrXO/quwfOcpsDQoc6X9/YiFae39kDtuRFALIBaCIt
 JAcQ==
X-Gm-Message-State: ABuFfohxoL3vimr4wL1/AOyB3WOTjvvLqxcuJqWvhrTBZSutKSnH1RUm
 km6/6RoFJieFyIvQ0JT+VQ==
X-Google-Smtp-Source: ACcGV61oIaCPXX3iWmlWCBNPXWIsS74bYJ8M1yCyHK9TIJS1AT3bEaX0Qhfzc8FfKFbaoTDJDEl2Cw==
X-Received: by 2002:a9d:2992:: with SMTP id n18mr663229otb.54.1538758767174;
 Fri, 05 Oct 2018 09:59:27 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49]) by smtp.googlemail.com with ESMTPSA id
 u63-v6sm2904328ota.75.2018.10.05.09.59.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Oct 2018 09:59:26 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 26/36] dt-bindings: arm: Convert QCom board/soc bindings to
 json-schema
Date: Fri,  5 Oct 2018 11:58:38 -0500
Message-Id: <20181005165848.3474-27-robh@kernel.org>
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
 Arnd Bergmann <arnd@arndb.de>, David Brown <david.brown@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Andy Gross <andy.gross@linaro.org>, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Olof Johansson <olof@lixom.net>,
 Frank Rowand <frowand.list@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Convert QCom SoC bindings to DT schema format using json-schema.

Cc: Andy Gross <andy.gross@linaro.org>
Cc: David Brown <david.brown@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/qcom.txt          |  57 --------
 .../devicetree/bindings/arm/qcom.yaml         | 125 ++++++++++++++++++
 2 files changed, 125 insertions(+), 57 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/qcom.txt
 create mode 100644 Documentation/devicetree/bindings/arm/qcom.yaml

diff --git a/Documentation/devicetree/bindings/arm/qcom.txt b/Documentation/devicetree/bindings/arm/qcom.txt
deleted file mode 100644
index ee532e705d6c..000000000000
--- a/Documentation/devicetree/bindings/arm/qcom.txt
+++ /dev/null
@@ -1,57 +0,0 @@
-QCOM device tree bindings
--------------------------
-
-Some qcom based bootloaders identify the dtb blob based on a set of
-device properties like SoC and platform and revisions of those components.
-To support this scheme, we encode this information into the board compatible
-string.
-
-Each board must specify a top-level board compatible string with the following
-format:
-
-	compatible = "qcom,<SoC>[-<soc_version>][-<foundry_id>]-<board>[/<subtype>][-<board_version>]"
-
-The 'SoC' and 'board' elements are required. All other elements are optional.
-
-The 'SoC' element must be one of the following strings:
-
-	apq8016
-	apq8074
-	apq8084
-	apq8096
-	msm8916
-	msm8974
-	msm8992
-	msm8994
-	msm8996
-	mdm9615
-	ipq8074
-	sdm845
-
-The 'board' element must be one of the following strings:
-
-	cdp
-	liquid
-	dragonboard
-	mtp
-	sbc
-	hk01
-
-The 'soc_version' and 'board_version' elements take the form of v<Major>.<Minor>
-where the minor number may be omitted when it's zero, i.e.  v1.0 is the same
-as v1. If all versions of the 'board_version' elements match, then a
-wildcard '*' should be used, e.g. 'v*'.
-
-The 'foundry_id' and 'subtype' elements are one or more digits from 0 to 9.
-
-Examples:
-
-	"qcom,msm8916-v1-cdp-pm8916-v2.1"
-
-A CDP board with an msm8916 SoC, version 1 paired with a pm8916 PMIC of version
-2.1.
-
-	"qcom,apq8074-v2.0-2-dragonboard/1-v0.1"
-
-A dragonboard board v0.1 of subtype 1 with an apq8074 SoC version 2, made in
-foundry 2.
diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
new file mode 100644
index 000000000000..d8fcd8deed5c
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -0,0 +1,125 @@
+# SPDX-License-Identifier: None
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/arm/qcom.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: QCOM device tree bindings
+
+maintainers:
+  - Stephen Boyd <sboyd@codeaurora.org>
+
+description: |
+  Some qcom based bootloaders identify the dtb blob based on a set of
+  device properties like SoC and platform and revisions of those components.
+  To support this scheme, we encode this information into the board compatible
+  string.
+
+  Each board must specify a top-level board compatible string with the following
+  format:
+
+  	compatible = "qcom,<SoC>[-<soc_version>][-<foundry_id>]-<board>[/<subtype>][-<board_version>]"
+
+  The 'SoC' and 'board' elements are required. All other elements are optional.
+
+  The 'SoC' element must be one of the following strings:
+
+  	apq8016
+  	apq8074
+  	apq8084
+  	apq8096
+  	msm8916
+  	msm8974
+  	msm8992
+  	msm8994
+  	msm8996
+  	mdm9615
+  	ipq8074
+  	sdm845
+
+  The 'board' element must be one of the following strings:
+
+  	cdp
+  	liquid
+  	dragonboard
+  	mtp
+  	sbc
+  	hk01
+
+  The 'soc_version' and 'board_version' elements take the form of v<Major>.<Minor>
+  where the minor number may be omitted when it's zero, i.e.  v1.0 is the same
+  as v1. If all versions of the 'board_version' elements match, then a
+  wildcard '*' should be used, e.g. 'v*'.
+
+  The 'foundry_id' and 'subtype' elements are one or more digits from 0 to 9.
+
+  Examples:
+
+  	"qcom,msm8916-v1-cdp-pm8916-v2.1"
+
+  A CDP board with an msm8916 SoC, version 1 paired with a pm8916 PMIC of version
+  2.1.
+
+  	"qcom,apq8074-v2.0-2-dragonboard/1-v0.1"
+
+  A dragonboard board v0.1 of subtype 1 with an apq8074 SoC version 2, made in
+  foundry 2.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - qcom,apq8016-sbc
+          - const: qcom,apq8016
+
+      - items:
+          - enum:
+              - qcom,apq8064-cm-qs600
+              - qcom,apq8064-ifc6410
+          - const: qcom,apq8064
+
+      - items:
+          - enum:
+              - qcom,apq8074-dragonboard
+          - const: qcom,apq8074
+
+      - items:
+          - enum:
+              - qcom,apq8060-dragonboard
+              - qcom,msm8660-surf
+          - const: qcom,msm8660
+
+      - items:
+          - enum:
+              - qcom,apq8084-mtp
+              - qcom,apq8084-sbc
+          - const: qcom,apq8084
+
+      - items:
+          - enum:
+              - qcom,msm8960-cdp
+          - const: qcom,msm8960
+
+      - items:
+          - const: qcom,msm8916-mtp/1
+          - const: qcom,msm8916-mtp
+          - const: qcom,msm8916
+
+      - items:
+          - const: qcom,msm8996-mtp
+
+      - items:
+          - const: qcom,ipq4019
+
+      - items:
+          - enum:
+              - qcom,ipq8064-ap148
+          - const: qcom,ipq8064
+
+      - items:
+          - enum:
+              - qcom,ipq8074-hk01
+          - const: qcom,ipq8074
+
+...
-- 
2.17.1

