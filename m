Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A067DC04EB9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 22:33:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24AFD2087F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 22:33:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24AFD2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4380BM1YWlzDqR5
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 09:32:59 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 437ys83bhZzDqNC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 08:33:00 +1100 (AEDT)
Received: by mail-oi1-f193.google.com with SMTP id h25so12386337oig.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Dec 2018 13:33:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=A1DZ7qanLgT6TNvZv+UGgnb7e+rg6Vx6EWDRxaGp6rc=;
 b=q6WwSo1s3+K99L0XCg/jfwygzZX2gLWsDwGgtNOw3GhjpW0Zs7fMWqfRZstYWw3QHa
 0ekLDRfztxZ0QlgacAMG2Ga/BgMS8EKOQ9yTupAwSNRMIYbyFJafijmYqLY3phx/C+xq
 vU7gPNMRymLCL+7yl2ztQfYojOmXw1A1PzAYhfFVYBU562VEuKlrz3JmTp0HSFei+DfZ
 ILH+vJ1qouLIB6igGAxLTL19SXIgaDHaOOjspoaXR6Mcpz8XNcqFTog6FGRNToKVQ1o7
 MN1DiG51eLiynO4SXKk3dRwmw4FHns6m8t+ccJ+5CBWLHj+38DP+ZPZnu1iwNrpVd2qV
 z1xQ==
X-Gm-Message-State: AA+aEWZCNLEYKT1DOtLic6TBetp2lo7vqr0nQkJE3vwDRC9quY5RoswF
 HtvSoF9FrYe+H8KzZls2wA==
X-Google-Smtp-Source: AFSGD/VXUJP/+4/TsKC9atq6RJWaovkxUtpJGDI/LJRj2Z98TIHCTl1R/TP0ERzJIps1ROa6KSijxA==
X-Received: by 2002:aca:d00a:: with SMTP id h10mr10413699oig.316.1543872778504; 
 Mon, 03 Dec 2018 13:32:58 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.32.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 13:32:57 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 27/34] dt-bindings: arm: Convert CSR SiRF board/soc
 bindings to json-schema
Date: Mon,  3 Dec 2018 15:32:16 -0600
Message-Id: <20181203213223.16986-28-robh@kernel.org>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Barry Song <baohua@kernel.org>,
 Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
 Sean Hudson <darknighte@darknighte.com>, Frank Rowand <frowand.list@gmail.com>,
 Grant Likely <grant.likely@arm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Convert CSR SiRF SoC bindings to DT schema format using json-schema.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Barry Song <baohua@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/sirf.txt          | 11 --------
 .../devicetree/bindings/arm/sirf.yaml         | 27 +++++++++++++++++++
 2 files changed, 27 insertions(+), 11 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/sirf.txt
 create mode 100644 Documentation/devicetree/bindings/arm/sirf.yaml

diff --git a/Documentation/devicetree/bindings/arm/sirf.txt b/Documentation/devicetree/bindings/arm/sirf.txt
deleted file mode 100644
index 7b28ee6fee91..000000000000
--- a/Documentation/devicetree/bindings/arm/sirf.txt
+++ /dev/null
@@ -1,11 +0,0 @@
-CSR SiRFprimaII and SiRFmarco device tree bindings.
-========================================
-
-Required root node properties:
-    - compatible:
-    - "sirf,atlas6-cb" : atlas6 "cb" evaluation board
-    - "sirf,atlas6" : atlas6 device based board
-    - "sirf,atlas7-cb" : atlas7 "cb" evaluation board
-    - "sirf,atlas7" : atlas7 device based board
-    - "sirf,prima2-cb" : prima2 "cb" evaluation board
-    - "sirf,prima2" : prima2 device based board
diff --git a/Documentation/devicetree/bindings/arm/sirf.yaml b/Documentation/devicetree/bindings/arm/sirf.yaml
new file mode 100644
index 000000000000..0b597032c923
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/sirf.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/sirf.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: CSR SiRFprimaII and SiRFmarco device tree bindings.
+
+maintainers:
+  - Binghua Duan <binghua.duan@csr.com>
+  - Barry Song <Baohua.Song@csr.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+          - const: sirf,atlas6-cb
+          - const: sirf,atlas6
+      - items:
+          - const: sirf,atlas7-cb
+          - const: sirf,atlas7
+      - items:
+          - const: sirf,prima2-cb
+          - const: sirf,prima2
+...
-- 
2.19.1

