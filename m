Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E9AC04EB9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 22:22:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EA58206B7
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 22:22:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EA58206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 437zy62XmtzDqQP
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 09:22:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.66; helo=mail-ot1-f66.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 437ys33D0bzDqNC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 08:32:55 +1100 (AEDT)
Received: by mail-ot1-f66.google.com with SMTP id u16so13121501otk.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Dec 2018 13:32:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rQZ8kmJGiAe3meOL8n5CuJdjh4Pdt4Z51xZK+7KE3Xk=;
 b=bRHMRSrc5SEvlUCyxUkjlC7FEYbeYd/6qoz9ehtOur9Chh3Ve2arA8vvRPM0K87afc
 y16n+5mcMY8hHYVZpPzS199pwm4dTf1qU36Nm+tmS7XHOkokzbrgPMM/pNFbx5jN2wVw
 FpCniUS3czfs2Ch26f6SDwDxMHvx96a5zG1t5MuCsGG95fFB3WYsUzkRp8nMuGtttGg9
 mQiGGn6xTFUQaGRBc1tSWJRQo3GV/C+mmglexLTVB6QHkWEatAU5c6UXdf1BNNdbgSHp
 DYBpngDQ3TQZWwFeTPahJk1rqghHftxhbkuVxg9pM/ARlAHPRg+kRG9nfiDTtLrOldsN
 ESAQ==
X-Gm-Message-State: AA+aEWacw8JXdPBf/ksjZF7S5J/41LOmpX/Vk80B5a1HX83+ILlVNVEP
 nX+FTLJ05G63OfrIIoUiRQ==
X-Google-Smtp-Source: AFSGD/XMa0kBRnoWR5AxYuedsAPrfI6e6I59G8+Z57rVk564hdCQ0IkmYLCjev7urA2vAx9c/b5eXA==
X-Received: by 2002:a9d:346:: with SMTP id 64mr11642597otv.90.1543872772572;
 Mon, 03 Dec 2018 13:32:52 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.32.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 13:32:51 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 22/34] dt-bindings: arm: Convert QCom board/soc bindings to
 json-schema
Date: Mon,  3 Dec 2018 15:32:11 -0600
Message-Id: <20181203213223.16986-23-robh@kernel.org>
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
 Frank Rowand <frowand.list@gmail.com>, David Brown <david.brown@linaro.org>,
 Grant Likely <grant.likely@arm.com>, Andy Gross <andy.gross@linaro.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
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
index 000000000000..f6316ab66385
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -0,0 +1,125 @@
+# SPDX-License-Identifier: GPL-2.0
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
2.19.1

