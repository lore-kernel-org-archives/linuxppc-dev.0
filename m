Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EE1C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 21:59:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 396BD20850
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 21:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 396BD20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 437zRf22JdzDqQ4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 08:59:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.196; helo=mail-oi1-f196.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 437yrm5vWPzDqWs
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 08:32:40 +1100 (AEDT)
Received: by mail-oi1-f196.google.com with SMTP id b141so12332333oii.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Dec 2018 13:32:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7ekJXPkH8vDQKH6Ka6Zw4d6P9Suv20xxzhFNrwmwfqI=;
 b=C5H+hA+yMDJn2DtMUpzDVTfsAK5qGhUKDrGoU+JKipS6aAWlkKuXN+ztPTbYQqz+Fm
 JZDgyXE2FxWvSM0cGiH/exVWBV2lwa9OHw+aIuWo36mwg1l1v9gHQXG7gOh32EDOxiHs
 tU+dBsZ/bJOI1iz1vMQlzXbzeHBH4AKrBpmyMzhkwKmIY9omHCQGVcRPtFcDJid4ax9v
 D95CDwAqMWZLMcw5T4zMHJJp26r2OYBNe8OUJ+ghHCf5SrHyOJxxyq4KvuJ4Cikpk7hW
 RfKHKYdf/VUc+HOH50M02Q1RNCI6It6UNQvt2HGX0baWlLxKSLIfjtLz+E9jJU5rdU8I
 RI1A==
X-Gm-Message-State: AA+aEWbMSsEsrLSLeALmqtYWoTA8AWECqw4WXgslW7nZXLLlcXtPMbWb
 OOkPs9d2Lc15vzxmncciip5iX0s=
X-Google-Smtp-Source: AFSGD/VGqOggC/Ka1IFU2DFVSWF9kf0xVvODZsOQESAjd7vG+XHk/5PwWPdPnnsW1F/cu/6lIETVjg==
X-Received: by 2002:aca:c186:: with SMTP id r128mr11602926oif.52.1543872758963; 
 Mon, 03 Dec 2018 13:32:38 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.32.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 13:32:38 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/34] dt-bindings: arm: Convert Alpine board/soc bindings
 to json-schema
Date: Mon,  3 Dec 2018 15:32:00 -0600
Message-Id: <20181203213223.16986-12-robh@kernel.org>
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
 Frank Rowand <frowand.list@gmail.com>,
 Antoine Tenart <antoine.tenart@free-electrons.com>,
 Grant Likely <grant.likely@arm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org,
 Tsahee Zidenberg <tsahee@annapurnalabs.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Convert Alpine SoC bindings to DT schema format using json-schema.

Cc: Tsahee Zidenberg <tsahee@annapurnalabs.com>
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/al,alpine.txt     | 16 --------------
 .../devicetree/bindings/arm/al,alpine.yaml    | 21 +++++++++++++++++++
 2 files changed, 21 insertions(+), 16 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/al,alpine.txt
 create mode 100644 Documentation/devicetree/bindings/arm/al,alpine.yaml

diff --git a/Documentation/devicetree/bindings/arm/al,alpine.txt b/Documentation/devicetree/bindings/arm/al,alpine.txt
deleted file mode 100644
index d00debe2e86f..000000000000
--- a/Documentation/devicetree/bindings/arm/al,alpine.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-Annapurna Labs Alpine Platform Device Tree Bindings
----------------------------------------------------------------
-
-Boards in the Alpine family shall have the following properties:
-
-* Required root node properties:
-compatible: must contain "al,alpine"
-
-* Example:
-
-/ {
-	model = "Annapurna Labs Alpine Dev Board";
-	compatible = "al,alpine";
-
-	...
-}
diff --git a/Documentation/devicetree/bindings/arm/al,alpine.yaml b/Documentation/devicetree/bindings/arm/al,alpine.yaml
new file mode 100644
index 000000000000..82e2fafdfece
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/al,alpine.yaml
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/al,alpine.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Annapurna Labs Alpine Platform Device Tree Bindings
+
+maintainers:
+  - Tsahee Zidenberg <tsahee@annapurnalabs.com>
+description: test
+
+properties:
+  compatible:
+    items:
+      - const: al,alpine
+  model:
+    items:
+      - const: "Annapurna Labs Alpine Dev Board"
+
+...
-- 
2.19.1

