Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06B3C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 17:14:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5883A2147C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 17:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5883A2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RbwX1V1HzF3c0
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 03:14:52 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RbZC130zzF3Sb
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 02:58:59 +1000 (AEST)
Received: by mail-ot1-f66.google.com with SMTP id w67so13337471ota.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 09:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=KNhjzAmt9eL8NLGjn9GDrypvo+dbuTO/DTaZ2Q51w5I=;
 b=nJEX7T0es9MuLWPgXFUcAh75O7dA9rEq9Db+w/GsonxwYPas0Bet0Y2UbLFK2/HqLV
 FDimtuOc+5TyJNq+VN70ajMpRn9vMTvUMvD3qr9YDvlyD5WcsxtFc2hzswipE5TjXHF2
 SCA7ANEw8Wz9IcRRk5FPfVGlHuaOhKi8Ldg42/0OI0mrBeblBbwgdb0btIZe0JUzTYrD
 RfrBVJHCYBtdxVUjuPJ1YFGwoMG9k1RVf7z6F63c/RGgRbxgjjnwG9wBTw5iStJsSCre
 wduT5xrd4+WUkfRO1dwY49mfkLYbYy29ld00kGE00FyLfgQjPc2qDNQsg/vTZMODgJoR
 Ufww==
X-Gm-Message-State: ABuFfohIbutwly58c2yWC73wRXQyYOkTMg180X7Nx/y0KWeT016Fow7q
 B5KWeCGQabzdAnoS63ODJw==
X-Google-Smtp-Source: ACcGV62Je/ETbvgrDS7rzpSWf8K9xd6NJR1QgZyS4XEDITS6zSOp2Xf3bFcVmBY6L9CproEcaS4GCg==
X-Received: by 2002:a9d:2372:: with SMTP id k47mr6624858otd.98.1538758737220; 
 Fri, 05 Oct 2018 09:58:57 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49]) by smtp.googlemail.com with ESMTPSA id
 u63-v6sm2904328ota.75.2018.10.05.09.58.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Oct 2018 09:58:56 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 05/36] dt-bindings: arm: renesas: Move 'renesas,
 prr' binding to its own doc
Date: Fri,  5 Oct 2018 11:58:17 -0500
Message-Id: <20181005165848.3474-6-robh@kernel.org>
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
 Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms@verge.net.au>,
 Linus Walleij <linus.walleij@linaro.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 linux-renesas-soc@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Olof Johansson <olof@lixom.net>,
 Frank Rowand <frowand.list@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In preparation to convert board-level bindings to json-schema, move
various misc SoC bindings out to their own file.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/renesas,prr.txt    | 18 ++++++++++++++++++
 .../devicetree/bindings/arm/shmobile.txt       | 18 ------------------
 2 files changed, 18 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/renesas,prr.txt

diff --git a/Documentation/devicetree/bindings/arm/renesas,prr.txt b/Documentation/devicetree/bindings/arm/renesas,prr.txt
new file mode 100644
index 000000000000..5000bf492f70
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/renesas,prr.txt
@@ -0,0 +1,18 @@
+Renesas Product Register
+
+Most Renesas ARM SoCs have a Product Register that allows to retrieve SoC
+product and revision information.  If present, a device node for this register
+should be added.
+
+Required properties:
+  - compatible: Must be "renesas,prr".
+  - reg: Base address and length of the register block.
+
+
+Examples
+--------
+
+	prr: chipid@ff000044 {
+		compatible = "renesas,prr";
+		reg = <0 0xff000044 0 4>;
+	};
diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 89b4a389fbc7..619b765e5bee 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -141,21 +141,3 @@ Boards:
     compatible = "renesas,v3msk", "renesas,r8a77970"
   - Wheat (RTP0RC7792ASKB0000JE)
     compatible = "renesas,wheat", "renesas,r8a7792"
-
-
-Most Renesas ARM SoCs have a Product Register that allows to retrieve SoC
-product and revision information.  If present, a device node for this register
-should be added.
-
-Required properties:
-  - compatible: Must be "renesas,prr".
-  - reg: Base address and length of the register block.
-
-
-Examples
---------
-
-	prr: chipid@ff000044 {
-		compatible = "renesas,prr";
-		reg = <0 0xff000044 0 4>;
-	};
-- 
2.17.1

