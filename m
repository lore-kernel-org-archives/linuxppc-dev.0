Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27262C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 17:16:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E7AB206B2
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 17:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E7AB206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Rbyw4HRLzF3TZ
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 03:16:56 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RbZD46j5zF3TM
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 02:59:00 +1000 (AEST)
Received: by mail-ot1-f68.google.com with SMTP id i12-v6so13400081otl.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 09:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=OlNXSrgQVk4KWBLGVdUP3P75RriHc27c3ag6VlOGG+E=;
 b=YCG5TLybqf/VG2UOTKbwmElu1RDQs74bB1rcQBJPdYnFJc2A7e0l1u5TeyYfA05chG
 kqTdb3RL38C8/+T34t9G8V9rPMU+HnUW3xS5U+yJkqS9Km/XloO6CqRqaZXfnJbCK0D0
 usr5s1r7mTYY/XNmJRSbYEDY5xEDV+VQZRJiGj/5yWYp24jt3xPFiCYdcG35UbRhRKBj
 EBZsyPS1cJF0V+4XhtNTbCQd+YtgVGcKkYuVLeQLwEk1bu4KSWZYuYKlRP4JkbgPXz4V
 F493NbczHJrZqaTX1QKDsR568tl9Wkv1aHjz8B19D/PRZ+a79fo16Y6gEvcqdHQf8pbm
 nMIA==
X-Gm-Message-State: ABuFfoiO9oF5nqki7W5ke3CWxjMOPgnpV+uD+CDsj/liFhy4fEFdfa4E
 V/oWo6cgKinZrSGggcrfJA==
X-Google-Smtp-Source: ACcGV60n79/HNJX/EEj0rfwdyJNxIcfyWNN9Ix/fcSf/Nkn3tJSBKa9rN2uBiVO0IYH8lG+CETwG7Q==
X-Received: by 2002:a9d:48b9:: with SMTP id d54mr6766139otf.144.1538758738565; 
 Fri, 05 Oct 2018 09:58:58 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49]) by smtp.googlemail.com with ESMTPSA id
 u63-v6sm2904328ota.75.2018.10.05.09.58.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Oct 2018 09:58:58 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 06/36] dt-bindings: arm: zte: Move sysctrl bindings to their
 own doc
Date: Fri,  5 Oct 2018 11:58:18 -0500
Message-Id: <20181005165848.3474-7-robh@kernel.org>
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

In preparation to convert board-level bindings to json-schema, move
various misc SoC bindings out to their own file.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Jun Nie <jun.nie@linaro.org>
Cc: Baoyou Xie <baoyou.xie@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/zte-sysctrl.txt   | 30 +++++++++++++++++++
 Documentation/devicetree/bindings/arm/zte.txt | 27 +----------------
 2 files changed, 31 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/zte-sysctrl.txt

diff --git a/Documentation/devicetree/bindings/arm/zte-sysctrl.txt b/Documentation/devicetree/bindings/arm/zte-sysctrl.txt
new file mode 100644
index 000000000000..7e66b7f7ba96
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/zte-sysctrl.txt
@@ -0,0 +1,30 @@
+ZTE sysctrl Registers
+
+Registers for 'zte,zx296702' SoC:
+
+System management required properties:
+      - compatible = "zte,sysctrl"
+
+Low power management required properties:
+      - compatible = "zte,zx296702-pcu"
+
+Bus matrix required properties:
+      - compatible = "zte,zx-bus-matrix"
+
+
+Registers for 'zte,zx296718' SoC:
+
+System management required properties:
+      - compatible = "zte,zx296718-aon-sysctrl"
+      - compatible = "zte,zx296718-sysctrl"
+
+Example:
+aon_sysctrl: aon-sysctrl@116000 {
+	compatible = "zte,zx296718-aon-sysctrl", "syscon";
+	reg = <0x116000 0x1000>;
+};
+
+sysctrl: sysctrl@1463000 {
+	compatible = "zte,zx296718-sysctrl", "syscon";
+	reg = <0x1463000 0x1000>;
+};
diff --git a/Documentation/devicetree/bindings/arm/zte.txt b/Documentation/devicetree/bindings/arm/zte.txt
index 83369785d29c..340612794a37 100644
--- a/Documentation/devicetree/bindings/arm/zte.txt
+++ b/Documentation/devicetree/bindings/arm/zte.txt
@@ -1,20 +1,10 @@
 ZTE platforms device tree bindings
----------------------------------------
 
+---------------------------------------
 -  ZX296702 board:
     Required root node properties:
       - compatible = "zte,zx296702-ad1", "zte,zx296702"
 
-System management required properties:
-      - compatible = "zte,sysctrl"
-
-Low power management required properties:
-      - compatible = "zte,zx296702-pcu"
-
-Bus matrix required properties:
-      - compatible = "zte,zx-bus-matrix"
-
-
 ---------------------------------------
 -  ZX296718 SoC:
     Required root node properties:
@@ -22,18 +12,3 @@ Bus matrix required properties:
 
 ZX296718 EVB board:
       - "zte,zx296718-evb"
-
-System management required properties:
-      - compatible = "zte,zx296718-aon-sysctrl"
-      - compatible = "zte,zx296718-sysctrl"
-
-Example:
-aon_sysctrl: aon-sysctrl@116000 {
-	compatible = "zte,zx296718-aon-sysctrl", "syscon";
-	reg = <0x116000 0x1000>;
-};
-
-sysctrl: sysctrl@1463000 {
-	compatible = "zte,zx296718-sysctrl", "syscon";
-	reg = <0x1463000 0x1000>;
-};
-- 
2.17.1

