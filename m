Return-Path: <SRS0=Y1I/=GS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9C1C433E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Jan 2021 07:52:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3150123118
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Jan 2021 07:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3150123118
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DHD0k1R7gzDsf8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Jan 2021 18:52:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::22a;
 helo=mail-lj1-x22a.google.com; envelope-from=paweldembicki@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=DP3BxUiO; dkim-atps=neutral
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DHCrs4nkSzDsc4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2021 18:45:15 +1100 (AEDT)
Received: by mail-lj1-x22a.google.com with SMTP id p13so9394528ljg.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2021 23:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=m3cu7YY/eNxyQb45/rsrpXDYAx8mxu2G4v5OxVWwgOY=;
 b=DP3BxUiOkbp6jEYZ4Pczn/iLq8dB7vCdU+wbx32ThuzfbcK9Sr2Zb5Mg0mPX6prLvm
 13sBk/pw4Wa+uHzXFzw7YXFfOD+cFwd6cN0lQlMKatejivttxoMnNK/wYacJW0JrnT8N
 u+6ZIyIiMGeUhhWSd5micAwjY2QkFMJYlpXMkFM9Tu6+R2eiTAIj83SaKcQ5JG7Ba+tX
 +qQyEezYMVy2hwblYBc9wRlwBuGh96vzZ7H+36uMYulKI7b5EF3Lx5imE1aYY23W0Zj6
 cGawi0HoCtKGJ6LZ8bzAspQo+SAJVKuW5B4SvHkUOehgoUhlt12HHqPD3/8zzX4/SE3S
 uDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=m3cu7YY/eNxyQb45/rsrpXDYAx8mxu2G4v5OxVWwgOY=;
 b=ac1lnI7QV3/sPM/jFc+0+aVQPaBD+j8vKmdpu/QT9A8qoVEA4H2wOgAC+lQbBT1Z8o
 xWCuF136w6UqLWOLVL7tXvcnx3p0mdBuaJWKElXpy5bka5wGb4SzEY3WsmeqYR/+MpoV
 to/4haAobnGfiY1ALmOdBDGb3zO+c75vzNPueOvseNEooTeVyuOeYdRAqpskbo7tx7J9
 ArUeKLXAfEscVOJCQIuIMNknN1i61LQlUERn3u0ODD3LRhKw9z46uxLwYmzgVZs0dPWW
 cMzauPUMjfFOlSuZ82tuLrXMGUD5OorycVuhRw4x1oCR/9Jnbv+Ragu+OyxG5XgOU3PU
 /21w==
X-Gm-Message-State: AOAM530js/Fbbekcavgkoft+uCRmE6MB9t1RV5uJcHcZsFf3xcw7X0Q4
 WP6l48sImgodqT34PX4FA2IClCPmRSZu7g==
X-Google-Smtp-Source: ABdhPJz09J5ZMuvwWmEAfRK3sELUcjg0OI6QIwBRHmJ9nDiNL5cnQegYPW63N7ectPkwZRxjHp/Zpg==
X-Received: by 2002:a2e:8602:: with SMTP id a2mr4556195lji.421.1610696308352; 
 Thu, 14 Jan 2021 23:38:28 -0800 (PST)
Received: from endpoint.lan ([185.188.71.122])
 by smtp.gmail.com with ESMTPSA id w9sm807559lfl.168.2021.01.14.23.38.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Jan 2021 23:38:27 -0800 (PST)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: dts: p2020rdb: add missing peripherials
Date: Fri, 15 Jan 2021 08:37:58 +0100
Message-Id: <20210115073800.1072204-1-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.25.1
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Pawel Dembicki <paweldembicki@gmail.com>,
 Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch adds dts entry for some peripherials:
- i2c: temperature sensor ADT7461
- i2c: eeprom m24256
- i2c: eeprom at24c01
- i2c: pmic zl2006
- i2c: gpio expander
- phy: reset pins for phy
- dsa: switch vsc7385

It was required to adjust rgmii settings for enet0 because switch with
dsa driver act different without 8081 sterring.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 arch/powerpc/boot/dts/fsl/p2020rdb.dts | 73 ++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/p2020rdb.dts b/arch/powerpc/boot/dts/fsl/p2020rdb.dts
index 3acd3890b397..1f2ddeca0375 100644
--- a/arch/powerpc/boot/dts/fsl/p2020rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/p2020rdb.dts
@@ -7,6 +7,9 @@
 
 /include/ "p2020si-pre.dtsi"
 
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
 / {
 	model = "fsl,P2020RDB";
 	compatible = "fsl,P2020RDB";
@@ -131,22 +134,84 @@ partition@1100000 {
 		L2switch@2,0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-			compatible = "vitesse-7385";
+			compatible = "vitesse,vsc7385";
 			reg = <0x2 0x0 0x20000>;
-		};
+			reset-gpios = <&gpio0 12 GPIO_ACTIVE_LOW>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
 
+				port@1 {
+					reg = <1>;
+					label = "e1-sw-p1";
+				};
+				port@2 {
+					reg = <2>;
+					label = "e1-sw-p2";
+				};
+				port@3 {
+					reg = <3>;
+					label = "e1-sw-p3";
+				};
+				port@4 {
+					reg = <4>;
+					label = "e1-sw-p4";
+				};
+				port@6 {
+					reg = <6>;
+					label = "cpu";
+					ethernet = <&enet0>;
+					phy-mode = "rgmii";
+					fixed-link {
+						speed = <1000>;
+						full-duplex;
+						pause;
+					};
+				};
+			};
+		};
 	};
 
 	soc: soc@ffe00000 {
 		ranges = <0x0 0x0 0xffe00000 0x100000>;
 
+		gpio0: gpio-controller@fc00 {
+		};
+
 		i2c@3000 {
+			temperature-sensor@4c {
+				compatible = "adi,adt7461";
+				reg = <0x4c>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c256";
+				reg = <0x50>;
+			};
 			rtc@68 {
 				compatible = "dallas,ds1339";
 				reg = <0x68>;
 			};
 		};
 
+		i2c@3100 {
+			pmic@11 {
+				compatible = "zl2006";
+				reg = <0x11>;
+			};
+
+			gpio@18 {
+				compatible = "nxp,pca9557";
+				reg = <0x18>;
+			};
+
+			eeprom@52 {
+				compatible = "atmel,24c01";
+				reg = <0x52>;
+			};
+		};
+
 		spi@7000 {
 			flash@0 {
 				#address-cells = <1>;
@@ -200,10 +265,12 @@ mdio@24520 {
 			phy0: ethernet-phy@0 {
 				interrupts = <3 1 0 0>;
 				reg = <0x0>;
+				reset-gpios = <&gpio0 14 GPIO_ACTIVE_LOW>;
 			};
 			phy1: ethernet-phy@1 {
 				interrupts = <3 1 0 0>;
 				reg = <0x1>;
+				reset-gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
 			};
 			tbi-phy@2 {
 				device_type = "tbi-phy";
@@ -233,7 +300,7 @@ ptp_clock@24e00 {
 
 		enet0: ethernet@24000 {
 			fixed-link = <1 1 1000 0 0>;
-			phy-connection-type = "rgmii-id";
+			phy-connection-type = "rgmii";
 		};
 
 		enet1: ethernet@25000 {
-- 
2.25.1

