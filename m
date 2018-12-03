Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB14C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 21:44:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 092CC206B7
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 21:44:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 092CC206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 437z6J6XRLzDqQq
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 08:44:24 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 437yrc6qDZzDqYn
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 08:32:32 +1100 (AEDT)
Received: by mail-ot1-f67.google.com with SMTP id s5so13106667oth.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Dec 2018 13:32:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EX5Bbxszue3VcY0+K5Qoq6qRkzYBy/6q4QLJhvS89M4=;
 b=SrMAM1SGG0K5kMjgghLsJA8o+9F5Jhi973iRXtJ2/R7dERxtRhJcJrIOo2k2rkJRn4
 +DRUeK5+ccdu1B9cmfN2eCgTxVFP832oPO471YOq0HwSLsZl8xjNDWxTxQCeNvVRobae
 e55hgcXhxKjssqkFx8bkcQH8VtQgufGV0/2NISZI6GlfJM15xD1zo49r6S/o25+fsedD
 D3ZYXgudnptVba3BDfsLX3Ec1Kmb+7Qs2zsoIglZumdDWlJu8KD7nyd0CVqOwGXGSNQ2
 taEq24Td8xqM5kBTufaAZ0LGftEZpKghc6DFNKa0TCXLdvF3dmpnD5TL5iqsF1atWHtL
 uWKA==
X-Gm-Message-State: AA+aEWbd9My3lS4KgeC6VQvD669bRPNkIELh6lc+zc+yvLl3JwVWWjST
 Xhy7BlN0S5WqNy5dXGFy6w==
X-Google-Smtp-Source: AFSGD/WF7Nq4RjBpubQE0Mk/6Ek/fXuMo1qgUM9lgqyh9+USAP97rjhkkMqgQM4pcehTN+upRXCy0Q==
X-Received: by 2002:a9d:620f:: with SMTP id g15mr10489610otj.296.1543872750861; 
 Mon, 03 Dec 2018 13:32:30 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.32.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 13:32:29 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/34] dt-bindings: altera: Convert clkmgr binding to
 json-schema
Date: Mon,  3 Dec 2018 15:31:53 -0600
Message-Id: <20181203213223.16986-5-robh@kernel.org>
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
 Frank Rowand <frowand.list@gmail.com>, Dinh Nguyen <dinguyen@kernel.org>,
 Grant Likely <grant.likely@arm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
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
 .../arm/altera/socfpga-clk-manager.yaml       | 31 +++++++++++++++++++
 2 files changed, 31 insertions(+), 11 deletions(-)
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
index 000000000000..e4131fa42b26
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.yaml
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/altera/socfpga-clk-manager.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera SOCFPGA Clock Manager
+
+maintainers:
+  - Dinh Nguyen <dinguyen@kernel.org>
+
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
2.19.1

