Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2BDC00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 17:35:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B81220834
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 17:35:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B81220834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RcNC2McXzDqCq
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 03:35:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.194; helo=mail-oi1-f194.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
 [209.85.167.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RbZT5GjbzF3TB
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 02:59:13 +1000 (AEST)
Received: by mail-oi1-f194.google.com with SMTP id w81-v6so10931299oiw.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 09:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CPjyBcDgH3rQvK5Topeu+rZwcMHC70P5llkoEmHzmYE=;
 b=mgrvBSsTjlAVy+Z9ImadFhybUv3x2jRyJLrBkqR3EnmMgLQpvvlmqxXy6XjI6BF78s
 YDK7tg4Uvak6YBOFhHLlxWM5OzN1htBZcHXu3FLIJRJyFJ2Fm0CWpJ3a3WCwZJEaSX8F
 uygD7iM9JRFJHGW4lkR3Jyi1m4IZLGmtlVjnBZ7DFKHXY7gQXwqdUOPKwye39mnvkUQm
 HVLsAmD0VpMPDxnhXmh8Cb4qULVOOYgDBY9aXDfQ0rMe5srHAf5yDGx87b+hCU8zayOv
 pyKDgEAXVl8SNEnX6uIxvE+H7daq0bGsbyB8SV/d38oNGkbL0gGgjrGk4ohVOvb1qdLU
 H05w==
X-Gm-Message-State: ABuFfojoHstUMtroHqNgMGT604XnH36na+fELrN+R6NIjKikAKJ3ptXl
 0ZCfrFz93bnsMuDtqxEs3w==
X-Google-Smtp-Source: ACcGV63zJcemAHN9pGK3CQ96Xg0N80/A72O3lshCWxDxbzkvqiuBxIVevpG07Krmfcy6q/4N8CFL5A==
X-Received: by 2002:aca:3585:: with SMTP id
 c127-v6mr1661072oia.63.1538758751756; 
 Fri, 05 Oct 2018 09:59:11 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49]) by smtp.googlemail.com with ESMTPSA id
 u63-v6sm2904328ota.75.2018.10.05.09.59.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Oct 2018 09:59:11 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 15/36] dt-bindings: arm: Convert Actions Semi bindings to
 jsonschema
Date: Fri,  5 Oct 2018 11:58:27 -0500
Message-Id: <20181005165848.3474-16-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005165848.3474-1-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Mark Rutland <mark.rutland@arm.com>, Tom Rini <trini@konsulko.com>,
 Kumar Gala <kumar.gala@linaro.org>, Grant Likely <glikely@secretlab.ca>,
 Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Olof Johansson <olof@lixom.net>,
 Frank Rowand <frowand.list@gmail.com>,
 =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
 Jonathan Cameron <jic23@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Convert Actions Semi SoC bindings to DT schema format using json-schema.

Cc: "Andreas Färber" <afaerber@suse.de>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/actions.txt       | 56 -------------------
 .../devicetree/bindings/arm/actions.yaml      | 34 +++++++++++
 2 files changed, 34 insertions(+), 56 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/actions.txt
 create mode 100644 Documentation/devicetree/bindings/arm/actions.yaml

diff --git a/Documentation/devicetree/bindings/arm/actions.txt b/Documentation/devicetree/bindings/arm/actions.txt
deleted file mode 100644
index d54f33c4e0da..000000000000
--- a/Documentation/devicetree/bindings/arm/actions.txt
+++ /dev/null
@@ -1,56 +0,0 @@
-Actions Semi platforms device tree bindings
--------------------------------------------
-
-
-S500 SoC
-========
-
-Required root node properties:
-
- - compatible :  must contain "actions,s500"
-
-
-Modules:
-
-Root node property compatible must contain, depending on module:
-
- - LeMaker Guitar: "lemaker,guitar"
-
-
-Boards:
-
-Root node property compatible must contain, depending on board:
-
- - Allo.com Sparky: "allo,sparky"
- - Cubietech CubieBoard6: "cubietech,cubieboard6"
- - LeMaker Guitar Base Board rev. B: "lemaker,guitar-bb-rev-b", "lemaker,guitar"
-
-
-S700 SoC
-========
-
-Required root node properties:
-
-- compatible :  must contain "actions,s700"
-
-
-Boards:
-
-Root node property compatible must contain, depending on board:
-
- - Cubietech CubieBoard7: "cubietech,cubieboard7"
-
-
-S900 SoC
-========
-
-Required root node properties:
-
-- compatible :  must contain "actions,s900"
-
-
-Boards:
-
-Root node property compatible must contain, depending on board:
-
- - uCRobotics Bubblegum-96: "ucrobotics,bubblegum-96"
diff --git a/Documentation/devicetree/bindings/arm/actions.yaml b/Documentation/devicetree/bindings/arm/actions.yaml
new file mode 100644
index 000000000000..af9345a228b4
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/actions.yaml
@@ -0,0 +1,34 @@
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/arm/actions.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Actions Semi platforms device tree bindings
+
+maintainers:
+  - Andreas Färber <afaerber@suse.de>
+
+description: |
+  The Actions Semi S500 is a quad-core ARM Cortex-A9 SoC. The Actions Semi
+  S900 is a quad-core ARM Cortex-A53 SoC.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - lemaker,guitar-bb-rev-b
+          - enum:
+              - lemaker,guitar
+              - allo,sparky
+              - cubietech,cubieboard6
+          - const: actions,s500
+        minItems: 2
+        maxItems: 3
+        additionalItems: false
+      - items:
+          - const: cubietech,cubieboard7
+          - const: actions,s700
+      - items:
+          - const: ucrobotics,bubblegum-96
+          - const: actions,s900
-- 
2.17.1

