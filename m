Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B05C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 17:11:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FEA420834
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 17:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FEA420834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Rbr44hsBzF3bg
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 03:11:00 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RbZ841SZzDrJl
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 02:58:56 +1000 (AEST)
Received: by mail-ot1-f66.google.com with SMTP id j9-v6so13363671otl.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 09:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=VtoR2oRqKzf2lI1MPPT0c7kPsIXdB0xyaajjOkNkhmQ=;
 b=T0kkwG5M5OO0Q6MwL7lkoRJO+b3jQIQD0sFPnVJm29wn1P6zWDazA0LRvbbkcEGys0
 NYWPe8imbHO37WoRa+hwp+hhEonoPTl6OEJTxNOzb5OJZCoWKTLSIu2YJA1qvU3ecHPj
 vAWX/5PoVA4ZlXqva4w2s+hggpSEvsVT3nKdvpmE4xxCEhp9v6ByGW3e87Q6OBpLv/sN
 wvJ/D8riUhFyx+8to4XCz+9JYZsJSpueMJ03D06zHjHhgDMUcBKsp6dSF+10B14T+V1y
 nF8RsHQlnKK0SiETUWqv/g8F01Iuf5HFr/oUFi1XLle9tvB4i5EVg5mHrFmbdobE/DOq
 kI6A==
X-Gm-Message-State: ABuFfohXFHI8pl9J0QKsakBNIoxYwjR7UHWeiczrFEHP+PTF492b2MXv
 erUqyD5Fmh311KYufQioVQ==
X-Google-Smtp-Source: ACcGV60FLBp7gNbQXKo7zli0JaN2xdGFsgJF1Ah87goMuPbUr7Ft0EtonBmVKS3FG+LPtrNehuPqVg==
X-Received: by 2002:a9d:2186:: with SMTP id s6-v6mr6588825otb.67.1538758734571; 
 Fri, 05 Oct 2018 09:58:54 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49]) by smtp.googlemail.com with ESMTPSA id
 u63-v6sm2904328ota.75.2018.10.05.09.58.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Oct 2018 09:58:54 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 03/36] dt-bindings: arm: atmel: Move various sys registers out
 of SoC binding doc
Date: Fri,  5 Oct 2018 11:58:15 -0500
Message-Id: <20181005165848.3474-4-robh@kernel.org>
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
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Kumar Gala <kumar.gala@linaro.org>, Grant Likely <glikely@secretlab.ca>,
 Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Olof Johansson <olof@lixom.net>,
 Frank Rowand <frowand.list@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In preparation to convert board-level bindings to json-schema, move
various misc SoC bindings out to their own file.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/atmel-at91.txt    | 170 -----------------
 .../devicetree/bindings/arm/atmel-sysregs.txt | 171 ++++++++++++++++++
 2 files changed, 171 insertions(+), 170 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/atmel-sysregs.txt

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documentation/devicetree/bindings/arm/atmel-at91.txt
index 31220b54d85d..4bf1b4da7659 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.txt
@@ -70,173 +70,3 @@ compatible: must be one of:
        - "atmel,samv71q19"
        - "atmel,samv71q20"
        - "atmel,samv71q21"
-
-Chipid required properties:
-- compatible: Should be "atmel,sama5d2-chipid"
-- reg : Should contain registers location and length
-
-PIT Timer required properties:
-- compatible: Should be "atmel,at91sam9260-pit"
-- reg: Should contain registers location and length
-- interrupts: Should contain interrupt for the PIT which is the IRQ line
-  shared across all System Controller members.
-
-System Timer (ST) required properties:
-- compatible: Should be "atmel,at91rm9200-st", "syscon", "simple-mfd"
-- reg: Should contain registers location and length
-- interrupts: Should contain interrupt for the ST which is the IRQ line
-  shared across all System Controller members.
-- clocks: phandle to input clock.
-Its subnodes can be:
-- watchdog: compatible should be "atmel,at91rm9200-wdt"
-
-RSTC Reset Controller required properties:
-- compatible: Should be "atmel,<chip>-rstc".
-  <chip> can be "at91sam9260" or "at91sam9g45" or "sama5d3"
-- reg: Should contain registers location and length
-- clocks: phandle to input clock.
-
-Example:
-
-	rstc@fffffd00 {
-		compatible = "atmel,at91sam9260-rstc";
-		reg = <0xfffffd00 0x10>;
-		clocks = <&clk32k>;
-	};
-
-RAMC SDRAM/DDR Controller required properties:
-- compatible: Should be "atmel,at91rm9200-sdramc", "syscon"
-			"atmel,at91sam9260-sdramc",
-			"atmel,at91sam9g45-ddramc",
-			"atmel,sama5d3-ddramc",
-- reg: Should contain registers location and length
-
-Examples:
-
-	ramc0: ramc@ffffe800 {
-		compatible = "atmel,at91sam9g45-ddramc";
-		reg = <0xffffe800 0x200>;
-	};
-
-SHDWC Shutdown Controller
-
-required properties:
-- compatible: Should be "atmel,<chip>-shdwc".
-  <chip> can be "at91sam9260", "at91sam9rl" or "at91sam9x5".
-- reg: Should contain registers location and length
-- clocks: phandle to input clock.
-
-optional properties:
-- atmel,wakeup-mode: String, operation mode of the wakeup mode.
-  Supported values are: "none", "high", "low", "any".
-- atmel,wakeup-counter: Counter on Wake-up 0 (between 0x0 and 0xf).
-
-optional at91sam9260 properties:
-- atmel,wakeup-rtt-timer: boolean to enable Real-time Timer Wake-up.
-
-optional at91sam9rl properties:
-- atmel,wakeup-rtc-timer: boolean to enable Real-time Clock Wake-up.
-- atmel,wakeup-rtt-timer: boolean to enable Real-time Timer Wake-up.
-
-optional at91sam9x5 properties:
-- atmel,wakeup-rtc-timer: boolean to enable Real-time Clock Wake-up.
-
-Example:
-
-	shdwc@fffffd10 {
-		compatible = "atmel,at91sam9260-shdwc";
-		reg = <0xfffffd10 0x10>;
-		clocks = <&clk32k>;
-	};
-
-SHDWC SAMA5D2-Compatible Shutdown Controller
-
-1) shdwc node
-
-required properties:
-- compatible: should be "atmel,sama5d2-shdwc".
-- reg: should contain registers location and length
-- clocks: phandle to input clock.
-- #address-cells: should be one. The cell is the wake-up input index.
-- #size-cells: should be zero.
-
-optional properties:
-
-- debounce-delay-us: minimum wake-up inputs debouncer period in
-  microseconds. It's usually a board-related property.
-- atmel,wakeup-rtc-timer: boolean to enable Real-Time Clock wake-up.
-
-The node contains child nodes for each wake-up input that the platform uses.
-
-2) input nodes
-
-Wake-up input nodes are usually described in the "board" part of the Device
-Tree. Note also that input 0 is linked to the wake-up pin and is frequently
-used.
-
-Required properties:
-- reg: should contain the wake-up input index [0 - 15].
-
-Optional properties:
-- atmel,wakeup-active-high: boolean, the corresponding wake-up input described
-  by the child, forces the wake-up of the core power supply on a high level.
-  The default is to be active low.
-
-Example:
-
-On the SoC side:
-	shdwc@f8048010 {
-		compatible = "atmel,sama5d2-shdwc";
-		reg = <0xf8048010 0x10>;
-		clocks = <&clk32k>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		atmel,wakeup-rtc-timer;
-	};
-
-On the board side:
-	shdwc@f8048010 {
-		debounce-delay-us = <976>;
-
-		input@0 {
-			reg = <0>;
-		};
-
-		input@1 {
-			reg = <1>;
-			atmel,wakeup-active-high;
-		};
-	};
-
-Special Function Registers (SFR)
-
-Special Function Registers (SFR) manage specific aspects of the integrated
-memory, bridge implementations, processor and other functionality not controlled
-elsewhere.
-
-required properties:
-- compatible: Should be "atmel,<chip>-sfr", "syscon" or
-	"atmel,<chip>-sfrbu", "syscon"
-  <chip> can be "sama5d3", "sama5d4" or "sama5d2".
-- reg: Should contain registers location and length
-
-	sfr@f0038000 {
-		compatible = "atmel,sama5d3-sfr", "syscon";
-		reg = <0xf0038000 0x60>;
-	};
-
-Security Module (SECUMOD)
-
-The Security Module macrocell provides all necessary secure functions to avoid
-voltage, temperature, frequency and mechanical attacks on the chip. It also
-embeds secure memories that can be scrambled
-
-required properties:
-- compatible: Should be "atmel,<chip>-secumod", "syscon".
-  <chip> can be "sama5d2".
-- reg: Should contain registers location and length
-
-	secumod@fc040000 {
-		compatible = "atmel,sama5d2-secumod", "syscon";
-		reg = <0xfc040000 0x100>;
-	};
diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
new file mode 100644
index 000000000000..4b96608ad692
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
@@ -0,0 +1,171 @@
+Atmel system registers
+
+Chipid required properties:
+- compatible: Should be "atmel,sama5d2-chipid"
+- reg : Should contain registers location and length
+
+PIT Timer required properties:
+- compatible: Should be "atmel,at91sam9260-pit"
+- reg: Should contain registers location and length
+- interrupts: Should contain interrupt for the PIT which is the IRQ line
+  shared across all System Controller members.
+
+System Timer (ST) required properties:
+- compatible: Should be "atmel,at91rm9200-st", "syscon", "simple-mfd"
+- reg: Should contain registers location and length
+- interrupts: Should contain interrupt for the ST which is the IRQ line
+  shared across all System Controller members.
+- clocks: phandle to input clock.
+Its subnodes can be:
+- watchdog: compatible should be "atmel,at91rm9200-wdt"
+
+RSTC Reset Controller required properties:
+- compatible: Should be "atmel,<chip>-rstc".
+  <chip> can be "at91sam9260" or "at91sam9g45" or "sama5d3"
+- reg: Should contain registers location and length
+- clocks: phandle to input clock.
+
+Example:
+
+	rstc@fffffd00 {
+		compatible = "atmel,at91sam9260-rstc";
+		reg = <0xfffffd00 0x10>;
+		clocks = <&clk32k>;
+	};
+
+RAMC SDRAM/DDR Controller required properties:
+- compatible: Should be "atmel,at91rm9200-sdramc", "syscon"
+			"atmel,at91sam9260-sdramc",
+			"atmel,at91sam9g45-ddramc",
+			"atmel,sama5d3-ddramc",
+- reg: Should contain registers location and length
+
+Examples:
+
+	ramc0: ramc@ffffe800 {
+		compatible = "atmel,at91sam9g45-ddramc";
+		reg = <0xffffe800 0x200>;
+	};
+
+SHDWC Shutdown Controller
+
+required properties:
+- compatible: Should be "atmel,<chip>-shdwc".
+  <chip> can be "at91sam9260", "at91sam9rl" or "at91sam9x5".
+- reg: Should contain registers location and length
+- clocks: phandle to input clock.
+
+optional properties:
+- atmel,wakeup-mode: String, operation mode of the wakeup mode.
+  Supported values are: "none", "high", "low", "any".
+- atmel,wakeup-counter: Counter on Wake-up 0 (between 0x0 and 0xf).
+
+optional at91sam9260 properties:
+- atmel,wakeup-rtt-timer: boolean to enable Real-time Timer Wake-up.
+
+optional at91sam9rl properties:
+- atmel,wakeup-rtc-timer: boolean to enable Real-time Clock Wake-up.
+- atmel,wakeup-rtt-timer: boolean to enable Real-time Timer Wake-up.
+
+optional at91sam9x5 properties:
+- atmel,wakeup-rtc-timer: boolean to enable Real-time Clock Wake-up.
+
+Example:
+
+	shdwc@fffffd10 {
+		compatible = "atmel,at91sam9260-shdwc";
+		reg = <0xfffffd10 0x10>;
+		clocks = <&clk32k>;
+	};
+
+SHDWC SAMA5D2-Compatible Shutdown Controller
+
+1) shdwc node
+
+required properties:
+- compatible: should be "atmel,sama5d2-shdwc".
+- reg: should contain registers location and length
+- clocks: phandle to input clock.
+- #address-cells: should be one. The cell is the wake-up input index.
+- #size-cells: should be zero.
+
+optional properties:
+
+- debounce-delay-us: minimum wake-up inputs debouncer period in
+  microseconds. It's usually a board-related property.
+- atmel,wakeup-rtc-timer: boolean to enable Real-Time Clock wake-up.
+
+The node contains child nodes for each wake-up input that the platform uses.
+
+2) input nodes
+
+Wake-up input nodes are usually described in the "board" part of the Device
+Tree. Note also that input 0 is linked to the wake-up pin and is frequently
+used.
+
+Required properties:
+- reg: should contain the wake-up input index [0 - 15].
+
+Optional properties:
+- atmel,wakeup-active-high: boolean, the corresponding wake-up input described
+  by the child, forces the wake-up of the core power supply on a high level.
+  The default is to be active low.
+
+Example:
+
+On the SoC side:
+	shdwc@f8048010 {
+		compatible = "atmel,sama5d2-shdwc";
+		reg = <0xf8048010 0x10>;
+		clocks = <&clk32k>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		atmel,wakeup-rtc-timer;
+	};
+
+On the board side:
+	shdwc@f8048010 {
+		debounce-delay-us = <976>;
+
+		input@0 {
+			reg = <0>;
+		};
+
+		input@1 {
+			reg = <1>;
+			atmel,wakeup-active-high;
+		};
+	};
+
+Special Function Registers (SFR)
+
+Special Function Registers (SFR) manage specific aspects of the integrated
+memory, bridge implementations, processor and other functionality not controlled
+elsewhere.
+
+required properties:
+- compatible: Should be "atmel,<chip>-sfr", "syscon" or
+	"atmel,<chip>-sfrbu", "syscon"
+  <chip> can be "sama5d3", "sama5d4" or "sama5d2".
+- reg: Should contain registers location and length
+
+	sfr@f0038000 {
+		compatible = "atmel,sama5d3-sfr", "syscon";
+		reg = <0xf0038000 0x60>;
+	};
+
+Security Module (SECUMOD)
+
+The Security Module macrocell provides all necessary secure functions to avoid
+voltage, temperature, frequency and mechanical attacks on the chip. It also
+embeds secure memories that can be scrambled
+
+required properties:
+- compatible: Should be "atmel,<chip>-secumod", "syscon".
+  <chip> can be "sama5d2".
+- reg: Should contain registers location and length
+
+	secumod@fc040000 {
+		compatible = "atmel,sama5d2-secumod", "syscon";
+		reg = <0xfc040000 0x100>;
+	};
-- 
2.17.1

