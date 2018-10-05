Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8473C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 18:07:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A4D0213A2
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 18:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4D0213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Rd537088zF3cm
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 04:07:19 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RbZw31B4zF3Sg
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 02:59:35 +1000 (AEST)
Received: by mail-ot1-f66.google.com with SMTP id e18-v6so13357961oti.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 09:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=E0eCUxfOwBpipo7Bw/JN/xoyxB44uKaqnXkAgBBbYjI=;
 b=eO0JVKxqMjInskieqkWr1je1txyAW2GjsVgyFZvn6k6nHyhRLxBBPln0AtwiV+3f+H
 mms55q84uL9J7eNoe8+y2zB7rNriOR/L4r3Kk5O2nvhRSweTk7XW1PvTfNcNlrEGhPwr
 8mQO1FHczPSID86DLigD8hIgDc0a3xftb3vRQ0BKvc9q0XsC1BINRhP67hCJ9x+jIHVE
 UzHYtNEkdoeRV6q0PzSmHr5GEDKA4ASyrUcpm2sfVdZ8y7jhL1ScWjBXXXNFYE7VP8Yh
 ID5VDSBWhM7rjnrRRNiUbAz/yaoLvErfrlhKMbXmQyujoCjBrVbppkOxHxMSP4HbxcUk
 Hfqg==
X-Gm-Message-State: ABuFfogwqms//F5Yqri95A5ljxYFYqUgPV2QqNSWYlEqxNGw8RpV2oxy
 B3nHfKzM3QtZbgThrpIk7g==
X-Google-Smtp-Source: ACcGV63GhuQKbXKe8PjXYhKLenBZA/xlMg2ZGfN2sJ6ULc6jIqbI06Ym0vHif9gRlDyBO+hgkuu5qA==
X-Received: by 2002:a9d:3e54:: with SMTP id h20mr6321692otg.184.1538758773772; 
 Fri, 05 Oct 2018 09:59:33 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49]) by smtp.googlemail.com with ESMTPSA id
 u63-v6sm2904328ota.75.2018.10.05.09.59.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Oct 2018 09:59:33 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 31/36] dt-bindings: arm: Convert SPEAr board/soc bindings to
 json-schema
Date: Fri,  5 Oct 2018 11:58:43 -0500
Message-Id: <20181005165848.3474-32-robh@kernel.org>
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
 Arnd Bergmann <arnd@arndb.de>, Viresh Kumar <vireshk@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Olof Johansson <olof@lixom.net>,
 Frank Rowand <frowand.list@gmail.com>,
 Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Convert SPEAr SoC bindings to DT schema format using json-schema.

Cc: Viresh Kumar <vireshk@kernel.org>
Cc: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/spear.txt         | 26 -------------------
 .../devicetree/bindings/arm/spear.yaml        | 25 ++++++++++++++++++
 2 files changed, 25 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/spear.txt
 create mode 100644 Documentation/devicetree/bindings/arm/spear.yaml

diff --git a/Documentation/devicetree/bindings/arm/spear.txt b/Documentation/devicetree/bindings/arm/spear.txt
deleted file mode 100644
index 0d42949df6c2..000000000000
--- a/Documentation/devicetree/bindings/arm/spear.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-ST SPEAr Platforms Device Tree Bindings
----------------------------------------
-
-Boards with the ST SPEAr600 SoC shall have the following properties:
-Required root node property:
-compatible = "st,spear600";
-
-Boards with the ST SPEAr300 SoC shall have the following properties:
-Required root node property:
-compatible = "st,spear300";
-
-Boards with the ST SPEAr310 SoC shall have the following properties:
-Required root node property:
-compatible = "st,spear310";
-
-Boards with the ST SPEAr320 SoC shall have the following properties:
-Required root node property:
-compatible = "st,spear320";
-
-Boards with the ST SPEAr1310 SoC shall have the following properties:
-Required root node property:
-compatible = "st,spear1310";
-
-Boards with the ST SPEAr1340 SoC shall have the following properties:
-Required root node property:
-compatible = "st,spear1340";
diff --git a/Documentation/devicetree/bindings/arm/spear.yaml b/Documentation/devicetree/bindings/arm/spear.yaml
new file mode 100644
index 000000000000..6ce8ef979390
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/spear.yaml
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: None
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/arm/spear.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ST SPEAr Platforms Device Tree Bindings
+
+maintainers:
+  - Viresh Kumar <vireshk@kernel.org>
+  - Stefan Roese <sr@denx.de>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    items:
+      - enum:
+          - st,spear600
+          - st,spear300
+          - st,spear310
+          - st,spear320
+          - st,spear1310
+          - st,spear1340
+...
-- 
2.17.1

