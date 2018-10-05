Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533E7C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 18:03:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA9FC2064A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 18:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA9FC2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Rcn51nWwzF3cL
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 03:53:29 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RbZk3Tv3zF3TC
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 02:59:26 +1000 (AEST)
Received: by mail-ot1-f66.google.com with SMTP id h26-v6so13361201otl.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 09:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=y7aoVKyFfwtD/XX+mmuwaVWhSjIowWCZ6eMMY+0377c=;
 b=Z6vKNcGAjv+rrooAGF9nm0yJE6WckJSDerFzWWoPxq2XatLx+v1lA31mVny29l7i7T
 RZGbkZsYo/Omra7S7t6VM9+eOhosQnj/2U24oikDfDC/fIhXTjk02Jo6V0w8VGopjudF
 ylvlnVnpiTMEj/VCcbYzPQPm2opLGtQWgZrVsiM5nCXclaCJohVjN9ZnCEquYOe4MyDQ
 m3V03hxgIoGGNZN4graowtKumdm5HZeoqcp+DTk2yClbfg9bv41ppxj+DtLQTcH1tDtX
 fM4FWn+Bq/A5DTml/1JrbD+2AnRZ5fpLnwlgWFNB82nAqyzClnA7CapH0g1rXp3Yb7+A
 8kcw==
X-Gm-Message-State: ABuFfoh3fJHzWM0GfJSWTJGge+7lLOHc6CmTcZ57mKDCeZ7Us4IjJ5iY
 6cC0k65aGjkWOZQPCXGcXQ==
X-Google-Smtp-Source: ACcGV63AXxjp9n2DA/7x8LwESe3X3ifNCO5wYGtNbwqG0vh+OYNB0OLz/egD72iUV3+eY0J8UGJKuQ==
X-Received: by 2002:a9d:2af:: with SMTP id 44-v6mr6580039otl.244.1538758764568; 
 Fri, 05 Oct 2018 09:59:24 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49]) by smtp.googlemail.com with ESMTPSA id
 u63-v6sm2904328ota.75.2018.10.05.09.59.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Oct 2018 09:59:23 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 24/36] dt-bindings: arm: Convert TI nspire board/soc bindings
 to json-schema
Date: Fri,  5 Oct 2018 11:58:36 -0500
Message-Id: <20181005165848.3474-25-robh@kernel.org>
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
 Bjorn Andersson <bjorn.andersson@linaro.org>, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Olof Johansson <olof@lixom.net>,
 Frank Rowand <frowand.list@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Convert TI NSpire SoC bindings to DT schema format using json-schema.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/nspire.txt        | 14 -----------
 .../devicetree/bindings/arm/ti/nspire.yaml    | 24 +++++++++++++++++++
 2 files changed, 24 insertions(+), 14 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/nspire.txt
 create mode 100644 Documentation/devicetree/bindings/arm/ti/nspire.yaml

diff --git a/Documentation/devicetree/bindings/arm/nspire.txt b/Documentation/devicetree/bindings/arm/nspire.txt
deleted file mode 100644
index 4d08518bd176..000000000000
--- a/Documentation/devicetree/bindings/arm/nspire.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-TI-NSPIRE calculators
-
-Required properties:
-- compatible: Compatible property value should contain "ti,nspire".
-	CX models should have "ti,nspire-cx"
-	Touchpad models should have "ti,nspire-tp"
-	Clickpad models should have "ti,nspire-clp"
-
-Example:
-
-/ {
-	model = "TI-NSPIRE CX";
-	compatible = "ti,nspire-cx";
-	...
diff --git a/Documentation/devicetree/bindings/arm/ti/nspire.yaml b/Documentation/devicetree/bindings/arm/ti/nspire.yaml
new file mode 100644
index 000000000000..882f79f95942
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/ti/nspire.yaml
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: None
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/arm/nspire.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI-NSPIRE calculators
+
+maintainers:
+  - Daniel Tang <dt.tangr@gmail.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    items:
+      - enum:
+          # CX models
+          - ti,nspire-cx
+          # Touchpad models
+          - ti,nspire-tp
+          # Clickpad models
+          - ti,nspire-clp
+...
-- 
2.17.1

