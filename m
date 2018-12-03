Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E178C04EBF
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 22:47:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EF432145D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 22:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EF432145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4380W95VqWzDqbp
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 09:47:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.193; helo=mail-oi1-f193.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com
 [209.85.167.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 437ysJ2W7BzDqL8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 08:33:08 +1100 (AEDT)
Received: by mail-oi1-f193.google.com with SMTP id c206so12387831oib.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Dec 2018 13:33:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bmY97rqmVLH/aYhI9MMshRrLQb1X3srsPldhSeApmNY=;
 b=BtFwhkIDL3Y9mnFB/Guej1kk87nQXhAqUKXJMBtWz6hVejx3V1yQoQVXVIG6Scf4Co
 781/iM90QZJSZNplLknW1wu2L9cGLVlBpkQoIfe73BO+hn5IdbL4F63fWezMpdQwlovu
 uabSK8TVa3WTzLNepSOoWHynawXFXMxPzWbSaNcFPg/S2hHOcbQz2SLMoqIVCIIYCIAs
 NyFjtH3Xc9l3dfr05MqLXqJp8g67bshO68Ees+Kx2Q4DNPzdoZ1MwsjBZTIjBRiNqCzu
 W+uYgag8Zqjylh6U56VahKujBbUyee3It8QVgVuRt2WZJsetELmqlDQox25/RuD/qpOr
 w38A==
X-Gm-Message-State: AA+aEWZRTmvIit6wXHqbw8oyY1/+mvfZYGvHWt32MdgN1g77g7gWbmQn
 rQ6xFRvZt+PHxdjD4F8RyQ==
X-Google-Smtp-Source: AFSGD/VCt7hGvmZxKqKvQyo6sGAvlI0gmsrPJbiXunL2+nUrFgxM5xIaK1eaMkx9Ocdoag5aHiHaLQ==
X-Received: by 2002:a05:6808:287:: with SMTP id
 z7mr8198529oic.233.1543872786508; 
 Mon, 03 Dec 2018 13:33:06 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.33.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 13:33:05 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 34/34] dt-bindings: arm: Convert ZTE board/soc bindings to
 json-schema
Date: Mon,  3 Dec 2018 15:32:23 -0600
Message-Id: <20181203213223.16986-35-robh@kernel.org>
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
 Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@arm.com>,
 Shawn Guo <shawnguo@kernel.org>, Jun Nie <jun.nie@linaro.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Convert ZTE SoC bindings to DT schema format using json-schema.

Cc: Jun Nie <jun.nie@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Acked-by: Shawn Guo <shawnguo@kernel.org>
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
index 000000000000..2d3fefdccdff
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/zte.yaml
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/zte.yaml#
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
2.19.1

