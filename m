Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97583C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 17:39:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 257CC20834
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 17:39:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 257CC20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RcSl1Yw9zF3bW
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 03:39:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.195; helo=mail-oi1-f195.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com
 [209.85.167.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RbZX2mwwzDrJl
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 02:59:16 +1000 (AEST)
Received: by mail-oi1-f195.google.com with SMTP id a203-v6so10981845oib.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 09:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=O3XM1RBhY4v1WmTiSPBtIk0ka+l440+ODBKqqXu90pw=;
 b=hlrMZP4Wtvyf7Q4nNcElYDjkp91mqghiy3JXeX8sNwL8bqauoLe83r47Y+P5iQG6v7
 abrstijJv360G1Fli6XRyt/ufGGrGlhV9jalOjN7kyoEqQr0xpcP5MyrQiqnwxc8ITPz
 oAwIMqVaGNECqKC3uG0elsQcunkt6RxRKwcV6xhSwe99PtQMEs+5GNlSg0hy1RYEGQjp
 d5roHRcbfrBZrQSaJ8RDQe+4Rf96ZN5S7D5xXm1uip75H4frptslBFJq6Nm9xjldnrdY
 ox8bxvvrY+VUHzhFdRT6OsSF62/teAcVwUFZPlgZlbCWMjpWMQTvlOj4myHTsIlHA9eI
 Zyqg==
X-Gm-Message-State: ABuFfohB3ksejE+FVpMiipJhxZyw0NmWUc14mW4skpiU1SgzJjiSsVRY
 xuXbfvDYKTkmLpWvZ72UpQ==
X-Google-Smtp-Source: ACcGV60AgRw3R5LJgV1x9+oI865q5N6/ndRU9D+ZWO2QIsss0NXUboNGgrxCF+DjBK6gh3Q57fTXXg==
X-Received: by 2002:aca:490b:: with SMTP id
 w11-v6mr5885174oia.126.1538758754465; 
 Fri, 05 Oct 2018 09:59:14 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49]) by smtp.googlemail.com with ESMTPSA id
 u63-v6sm2904328ota.75.2018.10.05.09.59.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Oct 2018 09:59:13 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 17/36] dt-bindings: arm: Convert Altera board/soc bindings to
 json-schema
Date: Fri,  5 Oct 2018 11:58:29 -0500
Message-Id: <20181005165848.3474-18-robh@kernel.org>
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
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Dinh Nguyen <dinguyen@kernel.org>, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Olof Johansson <olof@lixom.net>,
 Frank Rowand <frowand.list@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Convert Altera SoC bindings to DT schema format using json-schema.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/altera.txt        | 14 -------------
 .../devicetree/bindings/arm/altera.yaml       | 20 +++++++++++++++++++
 2 files changed, 20 insertions(+), 14 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/altera.txt
 create mode 100644 Documentation/devicetree/bindings/arm/altera.yaml

diff --git a/Documentation/devicetree/bindings/arm/altera.txt b/Documentation/devicetree/bindings/arm/altera.txt
deleted file mode 100644
index 558735aacca8..000000000000
--- a/Documentation/devicetree/bindings/arm/altera.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-Altera's SoCFPGA platform device tree bindings
----------------------------------------------
-
-Boards with Cyclone 5 SoC:
-Required root node properties:
-compatible = "altr,socfpga-cyclone5", "altr,socfpga";
-
-Boards with Arria 5 SoC:
-Required root node properties:
-compatible = "altr,socfpga-arria5", "altr,socfpga";
-
-Boards with Arria 10 SoC:
-Required root node properties:
-compatible = "altr,socfpga-arria10", "altr,socfpga";
diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
new file mode 100644
index 000000000000..0fc6564badc3
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: None
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/arm/altera.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera's SoCFPGA platform device tree bindings
+
+maintainers:
+  - Dinh Nguyen <dinguyen@opensource.altera.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+        - altr,socfpga-cyclone5
+        - altr,socfpga-arria5
+        - altr,socfpga-arria10
+      - const: altr,socfpga
+...
-- 
2.17.1

