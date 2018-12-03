Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14496C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 22:11:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91C4A20851
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 22:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C4A20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 437zk44VnfzDqNg
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 09:11:56 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 437yrw2PHvzDqbl
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 08:32:48 +1100 (AEDT)
Received: by mail-ot1-f67.google.com with SMTP id k98so13140561otk.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Dec 2018 13:32:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tYVF1/N3KzDGFvlUREOlAA6rOeGKGj1HKQArIj1wxGM=;
 b=UUvBy8QWf+3FuDqbbLxtANw7sHVD6P5W7N/53AxW6YATCffVECOIrIhDS2JdfnHkNN
 MCe7jMN2sElol37d8QOZCU9gXwY9oFDkHlT6BR0xoAAVLzTBjKpeys2BBhfFme0uyFNL
 Bf8F5nVQRA8WJsBOmFkZEiksYWtLJNnP5qjElRTpSkONSqQAobyiq856kRm29cQD5rqo
 sGfgiiB2i5ukC+6Txy7RC/90axmeT/4NbTXSao6CbBTRIa5oqIS797pYavQJnDd1o+Kk
 SOvMJdeYJ1z98pF2nri/oq8yChuTLUfmew538oAJbzK5z9Ib+o8zJGN3ag5qEdulkU34
 jt2g==
X-Gm-Message-State: AA+aEWZGz3J2hcBnXpzeGx42SV+uumoCoYPAb0iSKSycUiTFwcC25w+V
 V6IpAdLx+JcOyXbuQbO7s7kHEhw=
X-Google-Smtp-Source: AFSGD/UBdGfcxoc66a+Wu6V2RgEoWHkXqh+yZgo9RFy4a0rjU9R++UXS7xSpOi4QQ7F/mgJpLl9RLg==
X-Received: by 2002:a9d:348:: with SMTP id 66mr10568044otv.300.1543872766523; 
 Mon, 03 Dec 2018 13:32:46 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.32.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 13:32:45 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/34] dt-bindings: arm: Convert TI davinci board/soc
 bindings to json-schema
Date: Mon,  3 Dec 2018 15:32:06 -0600
Message-Id: <20181203213223.16986-18-robh@kernel.org>
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
 Kevin Hilman <khilman@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Sekhar Nori <nsekhar@ti.com>, Grant Likely <grant.likely@arm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Convert TI Davinci SoC bindings to DT schema format using json-schema.

Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/davinci.txt       | 25 ------------------
 .../bindings/arm/ti/ti,davinci.yaml           | 26 +++++++++++++++++++
 2 files changed, 26 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/davinci.txt
 create mode 100644 Documentation/devicetree/bindings/arm/ti/ti,davinci.yaml

diff --git a/Documentation/devicetree/bindings/arm/davinci.txt b/Documentation/devicetree/bindings/arm/davinci.txt
deleted file mode 100644
index 715622c36260..000000000000
--- a/Documentation/devicetree/bindings/arm/davinci.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Texas Instruments DaVinci Platforms Device Tree Bindings
---------------------------------------------------------
-
-DA850/OMAP-L138/AM18x Evaluation Module (EVM) board
-Required root node properties:
-    - compatible = "ti,da850-evm", "ti,da850";
-
-DA850/OMAP-L138/AM18x L138/C6748 Development Kit (LCDK) board
-Required root node properties:
-    - compatible = "ti,da850-lcdk", "ti,da850";
-
-EnBW AM1808 based CMC board
-Required root node properties:
-    - compatible = "enbw,cmc", "ti,da850;
-
-LEGO MINDSTORMS EV3 (AM1808 based)
-Required root node properties:
-    - compatible = "lego,ev3", "ti,da850";
-
-Generic DaVinci Boards
-----------------------
-
-DA850/OMAP-L138/AM18x generic board
-Required root node properties:
-    - compatible = "ti,da850";
diff --git a/Documentation/devicetree/bindings/arm/ti/ti,davinci.yaml b/Documentation/devicetree/bindings/arm/ti/ti,davinci.yaml
new file mode 100644
index 000000000000..4326d2cfa15d
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/ti/ti,davinci.yaml
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/ti/davinci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments DaVinci Platforms Device Tree Bindings
+
+maintainers:
+  - Sekhar Nori <nsekhar@ti.com>
+
+description:
+  DA850/OMAP-L138/AM18x based boards
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    items:
+      - enum:
+          - ti,da850-evm    # DA850/OMAP-L138/AM18x Evaluation Module (EVM) board
+          - ti,da850-lcdk   # DA850/OMAP-L138/AM18x L138/C6748 Development Kit (LCDK) board
+          - enbw,cmc        # EnBW AM1808 based CMC board
+          - lego,ev3        # LEGO MINDSTORMS EV3 (AM1808 based)
+      - const: ti,da850
+...
-- 
2.19.1

