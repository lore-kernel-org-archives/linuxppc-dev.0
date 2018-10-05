Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F33C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 17:24:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 966B1208E7
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 17:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 966B1208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Rc840WvDzF3T3
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 03:24:52 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RbZL4wRYzF3Sb
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 02:59:06 +1000 (AEST)
Received: by mail-oi1-f194.google.com with SMTP id k64-v6so10931663oia.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 09:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=zoNxd1sQf4bhVATt8RklSISv1vp3Ut2WaEzmkh9zdXo=;
 b=ugOhlsTFI6SzcfYdZ0UdKZZguEOjTFL3iER1b78KVQwUb3a9u3ekNqSv42UWa6tjrD
 bL8/5KKQMLPV+7Xz8sNWvWJTF5H/FslHioP1s8/z1EmxwhqMQFoz37Tga6BZJgHw94m6
 dA5qWhp0cxObzXWMKqOiVjrqZpJgb1fyGRL+ZroAOssC0un64dMqQPrGBYLDjK2X1+Vx
 yoWdHAqDNJYhU7QK5ehmoUyQMk5COgsQPf6wb/AafVP0kuINpBKq9p4NsZu5tDzhG2A1
 gsGJDR0bfkrodOnZ1t0SwFdP5zo/E8oPB9FNSIvIGrR9FAY4oEu5/OzN1F0vDI4T6geC
 Y5Dw==
X-Gm-Message-State: ABuFfohWfgv7zm6aQrCKtGBaKnC0NDqZ1RypECrh25LfsrBQAxIUcDGk
 lqCDDJiA0tFSZEVV8YyDGA==
X-Google-Smtp-Source: ACcGV60ra+ZWkkDwvIDTvmqyG9Jnx/zX9evmVtVhgTMw12gz5UPPJB/4HBUGFojHd2Df58cLg11pPA==
X-Received: by 2002:aca:754b:: with SMTP id
 q72-v6mr6275729oic.13.1538758744745; 
 Fri, 05 Oct 2018 09:59:04 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49]) by smtp.googlemail.com with ESMTPSA id
 u63-v6sm2904328ota.75.2018.10.05.09.59.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Oct 2018 09:59:03 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 10/36] dt-bindings: altera: Convert clkmgr binding to
 json-schema
Date: Fri,  5 Oct 2018 11:58:22 -0500
Message-Id: <20181005165848.3474-11-robh@kernel.org>
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

Convert Altera clkmgr to DT schema format using json-schema.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../arm/altera/socfpga-clk-manager.txt        | 11 -------
 .../arm/altera/socfpga-clk-manager.yaml       | 30 +++++++++++++++++++
 2 files changed, 30 insertions(+), 11 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.txt
 create mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.yaml

diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.txt
deleted file mode 100644
index 2c28f1d12f45..000000000000
--- a/Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.txt
+++ /dev/null
@@ -1,11 +0,0 @@
-Altera SOCFPGA Clock Manager
-
-Required properties:
-- compatible : "altr,clk-mgr"
-- reg : Should contain base address and length for Clock Manager
-
-Example:
-	 clkmgr@ffd04000 {
-		compatible = "altr,clk-mgr";
-		reg = <0xffd04000 0x1000>;
-	};
diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.yaml b/Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.yaml
new file mode 100644
index 000000000000..37c2cf08fae0
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.yaml
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: None
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/arm/altera/socfpga-clk-manager.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera SOCFPGA Clock Manager
+
+maintainers:
+  - Dinh Nguyen <dinguyen@altera.com>
+description: test
+
+properties:
+  compatible:
+    items:
+      - const: altr,clk-mgr
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+
+examples:
+  - |
+    clkmgr@ffd04000 {
+      compatible = "altr,clk-mgr";
+      reg = <0xffd04000 0x1000>;
+    };
+
+...
-- 
2.17.1

