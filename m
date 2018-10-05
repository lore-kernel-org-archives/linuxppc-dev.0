Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7006C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 18:16:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 528392054F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 18:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 528392054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RdJ84TdtzF3cf
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 04:16:56 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Rbb35G6JzF3TM
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 02:59:43 +1000 (AEST)
Received: by mail-ot1-f65.google.com with SMTP id i12-v6so13401925otl.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 09:59:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=x4wwXdEDKonGexnyVd35qeAgk07Sz5QTv+CVm/iQtLQ=;
 b=ISlVQy3vai/uRKSmpI1ov8cys7ULHkqP7B6cPWtGPpzrWhwWKFepiFCqigt5vnJ4Oz
 d61jxqH7SWdlVfvdIKsplCnYFsddc4Ac1uFuH2MadycebQvh/O3SlN2eVbjOW7U6YMKG
 CSnUpLsvZfdxsCdF1MIcjg025uJh9REhhWZGv9fsl+jkDqwD0h5mvSwzWupsGXl9jYk+
 gq73uKyNVMqXvRSXOWMwkvKvlEga1U+Yw+ZWIG0TjhyG2VTp37UnUTQQz8glDJqdovgL
 Wb2o+PeaiG2/VqlyigP5jkIm2RMxeENZh2RV3RsGhENYD09gq2kMLSn3W7br7rdlxpu+
 QAug==
X-Gm-Message-State: ABuFfojAPfZBNz1vDf+0+t3sag+VMy+gFftTFclz8WJPe3/RrhMkblVP
 aUdjn/5dCud2ZyXberJ2AD5pGljKMQ==
X-Google-Smtp-Source: ACcGV62S1AKQZmAV3zWVOMRh0ndCFqEhKHvRyIscDJ21z/l9hqDDHWsdLVMK23IDCUwVStCCS9/lxQ==
X-Received: by 2002:a9d:3bc7:: with SMTP id
 k65-v6mr6751836otc.23.1538758780591; 
 Fri, 05 Oct 2018 09:59:40 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49]) by smtp.googlemail.com with ESMTPSA id
 u63-v6sm2904328ota.75.2018.10.05.09.59.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Oct 2018 09:59:40 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 36/36] dt-bindings: arm: Convert ZTE board/soc bindings to
 json-schema
Date: Fri,  5 Oct 2018 11:58:48 -0500
Message-Id: <20181005165848.3474-37-robh@kernel.org>
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
 Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Olof Johansson <olof@lixom.net>,
 Jun Nie <jun.nie@linaro.org>, Baoyou Xie <baoyou.xie@linaro.org>,
 Frank Rowand <frowand.list@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Convert ZTE SoC bindings to DT schema format using json-schema.

Cc: Jun Nie <jun.nie@linaro.org>
Cc: Baoyou Xie <baoyou.xie@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/zte.txt | 14 ----------
 .../devicetree/bindings/arm/zte.yaml          | 26 +++++++++++++++++++
 2 files changed, 26 insertions(+), 14 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/zte.txt
 create mode 100644 Documentation/devicetree/bindings/arm/zte.yaml

diff --git a/Documentation/devicetree/bindings/arm/zte.txt b/Documentation/devicetree/bindings/arm/zte.txt
deleted file mode 100644
index 340612794a37..000000000000
--- a/Documentation/devicetree/bindings/arm/zte.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-ZTE platforms device tree bindings
-
----------------------------------------
--  ZX296702 board:
-    Required root node properties:
-      - compatible = "zte,zx296702-ad1", "zte,zx296702"
-
----------------------------------------
--  ZX296718 SoC:
-    Required root node properties:
-      - compatible = "zte,zx296718"
-
-ZX296718 EVB board:
-      - "zte,zx296718-evb"
diff --git a/Documentation/devicetree/bindings/arm/zte.yaml b/Documentation/devicetree/bindings/arm/zte.yaml
new file mode 100644
index 000000000000..147bd78f27ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/zte.yaml
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: None
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/arm/zte.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ZTE platforms device tree bindings
+
+maintainers:
+  - Jun Nie <jun.nie@linaro.org>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - zte,zx296702-ad1
+          - const: zte,zx296702
+      - items:
+          - enum:
+              - zte,zx296718-evb
+          - const: zte,zx296718
+
+...
-- 
2.17.1

