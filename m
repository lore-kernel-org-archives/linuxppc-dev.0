Return-Path: <SRS0=xrHL=SE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F06C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 06:47:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB28320833
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 06:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvtU31Ws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB28320833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44YKWf0P3mzDqL5
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 17:47:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=vilhelm.gray@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="TvtU31Ws"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44YK9g49MpzDqLP
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Apr 2019 17:31:35 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id 10so5834875pfo.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Apr 2019 23:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ADfhP5zjUuDjSW2hB90EQKoYLSBhq+Id1FV/2cN0vlY=;
 b=TvtU31Wsh2zQ/3Nh5ZDWzgedo0YgcJM73Oap3izPnwHvdW/8iC4VOTHiyrJwtlIwwX
 cMxP8ilL+xbsKv7pDHkGWg4cO7AAicDftKinlUH5/9JCqWjTS55bbtf8f03zI54TBDSL
 QNSjdqkYARq+a+aC7YNeuLTgd7GXX6xg8isXClJo+9TAJcQuXBX+5RT37jzSuTiAX5dm
 4V3GZL+OtPanqMb9DARiEEgt0CBNGKy2xZQgsB5k/5s4EdBovly0TOmDHLCXPbVGK1UF
 2olKuS0Zf+IGrhYm29qKTFogkg4dD7QP7Fy7lcpKCSjkzklnwK+YLYO8dC5Ugf+eDEjL
 Magw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ADfhP5zjUuDjSW2hB90EQKoYLSBhq+Id1FV/2cN0vlY=;
 b=ZD/g2gXQ668GY8PKKzP2zIVcY58GIdpShVJCZ/WdpeHAd03K9rzxhiKJT26nonepxo
 drsWI9s8NjYF1YS3JQEv+bvQAWDVrfOQEpMolLi41XkLv9oli8aXPYTjxTcqzNpyU8pR
 bT5WrAFykJJ4+mp3ev2pS40ZPcbpOZCRLvlU2T6DQKwTstW3p1E9D1B55TweqV1wjRxa
 E1Q+KUYbWMpxTbw1Wf2cQwxTkrSPILXrwFbZ6XaFhi9Gzun993V1J8jg0pBqpuKdne64
 xqIetYUVDMD18vsildr3KZJhBsAnM3hx5M3WXEqiWkKBw2NeMyXX8eFyK4nomkAe22Gl
 bKQw==
X-Gm-Message-State: APjAAAUazZNAzXY28rqonR8IC/XokYcTt9Yj8kLCYxvGRqIsHV2oRYck
 zZKZ7Dch5SYHp5WVQyqaDFg=
X-Google-Smtp-Source: APXvYqzbMDztJcOdNTyqzRYMbCs9hmjnd9YghZAZYSsUUdk+HZF7IfKegX2wxDi3hfqMSXoW+n9tRw==
X-Received: by 2002:a62:ac02:: with SMTP id v2mr26546282pfe.163.1554186692246; 
 Mon, 01 Apr 2019 23:31:32 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:4ce0:c70:4af9:86e2:2])
 by smtp.gmail.com with ESMTPSA id a17sm19327289pfj.123.2019.04.01.23.31.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Apr 2019 23:31:31 -0700 (PDT)
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH v10 08/18] dt-bindings: counter: Document stm32 quadrature
 encoder
Date: Tue,  2 Apr 2019 15:30:43 +0900
Message-Id: <fb7d2eb37a1bb0eb2a0e0b0ff89f25f965f293c9.1554184734.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1554184734.git.vilhelm.gray@gmail.com>
References: <cover.1554184734.git.vilhelm.gray@gmail.com>
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
Cc: mark.rutland@arm.com, benjamin.gaignard@st.com, linux-pwm@vger.kernel.org,
 linux-iio@vger.kernel.org, patrick.havelange@essensium.com,
 thierry.reding@gmail.com, pmeerw@pmeerw.net, Rob Herring <robh@kernel.org>,
 lars@metafoo.de, daniel.lezcano@linaro.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 david@lechnology.com, William Breathitt Gray <vilhelm.gray@gmail.com>,
 robh+dt@kernel.org, tglx@linutronix.de, fabrice.gasnier@st.com,
 esben@haabendal.dk, shawnguo@kernel.org, linux-kernel@vger.kernel.org,
 leoyang.li@nxp.com, knaack.h@gmx.de, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, jic23@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Benjamin Gaignard <benjamin.gaignard@st.com>

Add bindings for STM32 Timer quadrature encoder.
It is a sub-node of STM32 Timer which implement the
quadratic encoder part of the hardware.

Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 .../bindings/counter/stm32-timer-cnt.txt      | 31 +++++++++++++++++++
 .../devicetree/bindings/mfd/stm32-timers.txt  |  7 +++++
 2 files changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt

diff --git a/Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt b/Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
new file mode 100644
index 000000000000..c52fcdd4bf6c
--- /dev/null
+++ b/Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
@@ -0,0 +1,31 @@
+STMicroelectronics STM32 Timer quadrature encoder
+
+STM32 Timer provides quadrature encoder to detect
+angular position and direction of rotary elements,
+from IN1 and IN2 input signals.
+
+Must be a sub-node of an STM32 Timer device tree node.
+See ../mfd/stm32-timers.txt for details about the parent node.
+
+Required properties:
+- compatible:		Must be "st,stm32-timer-counter".
+- pinctrl-names: 	Set to "default".
+- pinctrl-0: 		List of phandles pointing to pin configuration nodes,
+			to set CH1/CH2 pins in mode of operation for STM32
+			Timer input on external pin.
+
+Example:
+	timers@40010000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "st,stm32-timers";
+		reg = <0x40010000 0x400>;
+		clocks = <&rcc 0 160>;
+		clock-names = "int";
+
+		counter {
+			compatible = "st,stm32-timer-counter";
+			pinctrl-names = "default";
+			pinctrl-0 = <&tim1_in_pins>;
+		};
+	};
diff --git a/Documentation/devicetree/bindings/mfd/stm32-timers.txt b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
index 0e900b52e895..15c3b87f51d9 100644
--- a/Documentation/devicetree/bindings/mfd/stm32-timers.txt
+++ b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
@@ -28,6 +28,7 @@ Optional parameters:
 Optional subnodes:
 - pwm:			See ../pwm/pwm-stm32.txt
 - timer:		See ../iio/timer/stm32-timer-trigger.txt
+- counter:		See ../counter/stm32-timer-cnt.txt
 
 Example:
 	timers@40010000 {
@@ -48,6 +49,12 @@ Example:
 			compatible = "st,stm32-timer-trigger";
 			reg = <0>;
 		};
+
+		counter {
+			compatible = "st,stm32-timer-counter";
+			pinctrl-names = "default";
+			pinctrl-0 = <&tim1_in_pins>;
+		};
 	};
 
 Example with all dmas:
-- 
2.21.0

