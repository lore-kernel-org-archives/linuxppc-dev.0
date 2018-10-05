Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33465C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 17:13:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5C4220834
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 17:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C4220834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RbtR5h9fzF3d8
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 03:13:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.68; helo=mail-ot1-f68.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RbZB1cMczDrP0
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 02:58:58 +1000 (AEST)
Received: by mail-ot1-f68.google.com with SMTP id l1so28769otj.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 09:58:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=l099Y6jzpfQyO/xPjIXxsAls6PjdHyNSgIgLlrCYeSY=;
 b=J6KGVs+qZuYBcgDBp0LoUeBRGxQY01nF+0i2BZahKKBYRvDSxe04VOikW//dcLxde0
 mV7VUWdn0+CuznRCrG1N90KlQjaLBVVQnD6Hxmn5E3RRkmKS3+4t0zSqpuk5Yr14pds/
 7JLHZe8uRYqg14yc/01y4FMs7BkrTiRkEVMgcWRzrEXJFRhorVYM+cxf5WmFGUvnZdUV
 TP7zO0CNrVLMczonJYPu4R/nmqS+/efdaZPpQKeD1JJHX4PdeYRGiTy7Ex1NOtiQCFzB
 duzRibNfLVhGkOb1k/N26IccvwBBD7aU4tYGlazwUMuZdOQ5kTU96W5S7CyXG9NQuKxw
 GxqQ==
X-Gm-Message-State: ABuFfogkGlNMf9pUsPrpwcE8TAWCRcdKb+KUxb5jrV+DWR72Xm1EUBFV
 FVgsX1tU8L2j8mIvXnkyIw==
X-Google-Smtp-Source: ACcGV62l0YQwi7Faf3P5mBf3+3h16qKtXXtISzEKvg5OrzcWIWvyS1qnLs8Yd/D7bQ2L9gRgY7gqog==
X-Received: by 2002:a9d:654a:: with SMTP id
 q10-v6mr3358223otl.256.1538758735840; 
 Fri, 05 Oct 2018 09:58:55 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49]) by smtp.googlemail.com with ESMTPSA id
 u63-v6sm2904328ota.75.2018.10.05.09.58.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Oct 2018 09:58:55 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 04/36] dt-bindings: arm: fsl: Move DCFG and SCFG bindings to
 their own docs
Date: Fri,  5 Oct 2018 11:58:16 -0500
Message-Id: <20181005165848.3474-5-robh@kernel.org>
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
 Frank Rowand <frowand.list@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In preparation to convert board-level bindings to json-schema, move
various misc SoC bindings out to their own file.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../arm/freescale/fsl,layerscape-dcfg.txt     | 19 +++++++++
 .../arm/freescale/fsl,layerscape-scfg.txt     | 19 +++++++++
 Documentation/devicetree/bindings/arm/fsl.txt | 39 -------------------
 3 files changed, 38 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-dcfg.txt
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-scfg.txt

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-dcfg.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-dcfg.txt
new file mode 100644
index 000000000000..b5cb374dc47d
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-dcfg.txt
@@ -0,0 +1,19 @@
+Freescale DCFG
+
+DCFG is the device configuration unit, that provides general purpose
+configuration and status for the device. Such as setting the secondary
+core start address and release the secondary core from holdoff and startup.
+
+Required properties:
+  - compatible: Should contain a chip-specific compatible string,
+	Chip-specific strings are of the form "fsl,<chip>-dcfg",
+	The following <chip>s are known to be supported:
+	ls1012a, ls1021a, ls1043a, ls1046a, ls2080a.
+
+  - reg : should contain base address and length of DCFG memory-mapped registers
+
+Example:
+	dcfg: dcfg@1ee0000 {
+		compatible = "fsl,ls1021a-dcfg";
+		reg = <0x0 0x1ee0000 0x0 0x10000>;
+	};
diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-scfg.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-scfg.txt
new file mode 100644
index 000000000000..0ab67b0b216d
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-scfg.txt
@@ -0,0 +1,19 @@
+Freescale SCFG
+
+SCFG is the supplemental configuration unit, that provides SoC specific
+configuration and status registers for the chip. Such as getting PEX port
+status.
+
+Required properties:
+  - compatible: Should contain a chip-specific compatible string,
+	Chip-specific strings are of the form "fsl,<chip>-scfg",
+	The following <chip>s are known to be supported:
+	ls1012a, ls1021a, ls1043a, ls1046a, ls2080a.
+
+  - reg: should contain base address and length of SCFG memory-mapped registers
+
+Example:
+	scfg: scfg@1570000 {
+		compatible = "fsl,ls1021a-scfg";
+		reg = <0x0 0x1570000 0x0 0x10000>;
+	};
diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index 8a1baa2b9723..1e775aaa5c5b 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -101,45 +101,6 @@ Freescale LS1021A Platform Device Tree Bindings
 Required root node compatible properties:
   - compatible = "fsl,ls1021a";
 
-Freescale SoC-specific Device Tree Bindings
--------------------------------------------
-
-Freescale SCFG
-  SCFG is the supplemental configuration unit, that provides SoC specific
-configuration and status registers for the chip. Such as getting PEX port
-status.
-  Required properties:
-  - compatible: Should contain a chip-specific compatible string,
-	Chip-specific strings are of the form "fsl,<chip>-scfg",
-	The following <chip>s are known to be supported:
-	ls1012a, ls1021a, ls1043a, ls1046a, ls2080a.
-
-  - reg: should contain base address and length of SCFG memory-mapped registers
-
-Example:
-	scfg: scfg@1570000 {
-		compatible = "fsl,ls1021a-scfg";
-		reg = <0x0 0x1570000 0x0 0x10000>;
-	};
-
-Freescale DCFG
-  DCFG is the device configuration unit, that provides general purpose
-configuration and status for the device. Such as setting the secondary
-core start address and release the secondary core from holdoff and startup.
-  Required properties:
-  - compatible: Should contain a chip-specific compatible string,
-	Chip-specific strings are of the form "fsl,<chip>-dcfg",
-	The following <chip>s are known to be supported:
-	ls1012a, ls1021a, ls1043a, ls1046a, ls2080a.
-
-  - reg : should contain base address and length of DCFG memory-mapped registers
-
-Example:
-	dcfg: dcfg@1ee0000 {
-		compatible = "fsl,ls1021a-dcfg";
-		reg = <0x0 0x1ee0000 0x0 0x10000>;
-	};
-
 Freescale ARMv8 based Layerscape SoC family Device Tree Bindings
 ----------------------------------------------------------------
 
-- 
2.17.1

