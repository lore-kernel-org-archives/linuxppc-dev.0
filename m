Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778C5606A33B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m6uCb0yB
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTSR46Rb8z2yDm;
	Wed, 18 Nov 2026 01:53:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25" arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794927216;
	cv=pass; b=BOkRx8/PbKcpOfkBC/Jnj7Zsp5/ob7vZwgnVbTwxU1borThz1ABk2+yzD1MU6ZfJT+XZYapscLeSpOza1LahO0uMC+J/LtXOqmZmNO2V2Lgjnuxr9otHvkthOkX7I8rBeZ3f4M67jJ2UtHpXKEG16Cy2pkadZ2b95zS0WlBr8QIsfkkwWkEIqtrS8/t30oAJadvp5F/DTmtyIWM/xM4gHQZkfFWT4HEYpOTV6jy6+hpY7GY+GUOtbziattv5ffXJlnSq2bqMfgvXl+jZzFGJ+azF8yVX732vm5ywHaDZVsTxu0T2I/QfveVkw8r9ZuVKPzs4GTcz9JLFZU5VXpSktg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794927216; c=relaxed/relaxed;
	bh=gFO8Kw09irBAzwaU+Z0QN/GSQFVkwOz5owROC49F2Xg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O7GyXqhJYjpyM6TckJXnOu/mv3J/OEhFbp1nWFPyS/fQnKVqV5zT2+odWurTBLGjzSanexXG59XXli4XasJT01nGssXmw5NMj4WnyW2T4XsSLoqx8Z9X+9tQQvSG3KL9h2spIE6AcOAOVGTGHkjpgIsNZukCbdYN2Ogd1C7gNA2q6lmbccfo8E35rqhBSjxeBGTgnX2wF8+lVVgHzylyb1ZqpDCq322re58gR42kTGbqSbG1LtEgprMuQAl6W4BqGKfXX7Eb44BHfny9z43oOitx97BAeR6u4CUe9eQMVyF4cTyZqUQweV9xXyLRQKH9taSQwCHd88uda0nE95lcgw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m6uCb0yB; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m6uCb0yB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTSR00kqkz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 01:53:31 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BD91462782;
	Tue, 17 Nov 2026 14:53:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794927209;
	b=BYVRQM1FwF7uN2EboTg70bxlFsDjOIzOyV3I73YPYxZHfuHvaj9GZ+17HR7eXLI7AKbp
	 fze5t9dwWX9cf3HNpTlDfynkGOrDyVBj1bm/T8XN3kqyo5CFzXHdpihCQb/XqmIIO6XoU
	 J7q2ghOyQv3POyHh71yCzMAOQgLOPN4VyZ1YP6JUZz/EivIafB+YbAon7aPUH0enOCDxb
	 cWB9EWj7gi0faDAwwoTkUkflFLxI75J1bN2O8U5DCnHTCOxGFz2BwSK4FsmT+qpEDuMZw
	 DB6Vzm33IDsxiaWg/iJeEt9iZimM3DAzeafro7a4zp/dpIUHaoS3ca48gHB/nsnA/aQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794927209;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=gFO8Kw09irBAzwaU+Z0QN/GSQFVkwOz5owROC49F2Xg=;
	b=j2ZVxyteVIh6Y8sFivIDFRcoZec9n74V8BSHzaeLf+I85FazkGKqymy+H0UNoFKs5JOo
	 1iViBR1dgDFht8KBXOUUwwafMLOVVqfu3fY2XiYYuVoD4LcA0c+u4LxqXehtqM2dUDyA5
	 3od60iUJ6EwDNL2JLiZoIdDLfT9dKMBRnNgMa0gXmDJUZbSSTISVaU+3roardkPZfC9gq
	 oTrGAz7XoD9fMVfVbZxWNlvw0yr31rWTPTtqswe887xvuFIaO5whsZdMezDX5N6t28go1
	 mvkKVyPnvNGBsTE7urCa9fN/GcyyF3rp5nw1M5KKZbF8oRDwXQe/1be13WPliiKNZ4w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 57FCF1F000D1;
	Tue, 17 Nov 2026 14:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794927209;
	bh=gFO8Kw09irBAzwaU+Z0QN/GSQFVkwOz5owROC49F2Xg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=m6uCb0yBGi/GHA0sXWk7GVcoHegkk7zowqUJpF1Hqd/t/34FjjP775za+o80TKkKl
	 sYJF7afMzDw++TWVAZW13HE+ewSzOfzcoXlRIX7AWFUkvDv1qW61q7pG9TsLsIGSwk
	 WCMJLxSN4DczUebTZQZgCRClFD0a232Fhb26ZYT+tUfJWYoUJlhuUUHZwfEh+ikyEt
	 L/pMrKOQOam8B46Ho7T8FJUUe9eD20QG8Uao22gR1ak0+MUwsM76DQhwqptUynDkQv
	 7Ckx9fXqfUIkiYQgpsDaFXbIxHT6EMzxRDgQKlcAU65AJr0bWZeezCFxRNjF3D68IJ
	 uVcbysHRfv1qg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 13F7C4A9D8;
	Tue, 17 Nov 2026 14:53:27 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Date: Tue, 17 Nov 2026 15:53:16 +0100
Subject: [PATCH v7 6/6] arm64: dts: lx2160a: drop the I2C bus recovery of
 i2c6 and i2c7
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-6-5d7201970629@free.fr>
References: <20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-0-5d7201970629@free.fr>
In-Reply-To: <20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-0-5d7201970629@free.fr>
To: Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
 Frank Li <Frank.Li@nxp.com>, Jacky Bai <ping.bai@nxp.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 NXP S32 Linux Team <s32@nxp.com>, Linus Walleij <linusw@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Ioana Ciornei <ioana.ciornei@nxp.com>, Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794927205; l=2654;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=vH8MdQeBHmXHEmIM/7mJDStPvh7UoIZQhzsf1k+YUgg=;
 b=TY4Y5UULvkw7v8OwtygAKyOg/A4iU1UMM9UwpKRr5LQhc+5ET88yOGXEiq+5PZDVQi4JNHkvR
 j0Jj60HPKW/A5cOCrZdukT5PEDicOfvX1AKwIC3880akwWgqHx0leme
X-Developer-Key: i=vjardin@free.fr; a=ed25519;
 pk=hppgLeFpGpKOi7LNwGEZ4jOYofJCoGd4Jf1ltAabiLw=
X-Endpoint-Received: by B4 Relay for vjardin@free.fr/20260525 with
 auth_id=871
X-Original-From: Vincent Jardin <vjardin@free.fr>
Reply-To: vjardin@free.fr
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Vincent Jardin <vjardin@free.fr>

IIC7 and IIC8, the i2c6 and i2c7 nodes, exist only on the SDHC2_DAT[7:4]
pads, and one RCW field, SDHC2_DAT74_PMUX, muxes all four of them:
 - 0b010 gives both buses
 - 0b001 gives GPIO2[18:15]

The bus recovery of one controller therefore switches the pads of the
other one to GPIO too, and breaks a transfer of that bus, or its
target role.
No lock shared by the two drivers can avoid that.

The description cannot work either: both nodes point at the same two
states of the same pad-mux group, so the controller that probes second
fails with "pin ... already requested".
No board enables either bus, which is why it did not show.

Drop the pinctrl and the recovery GPIOs of both nodes, and the two states
nothing else uses. A board that uses one of the buses can add its own.

Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://lore.kernel.org/all/avtsY-7-I7_pdyD0@lxl00025.wbi.nxp.com/
Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 arch/arm64/boot/dts/freescale/fsl-lx216x.dtsi | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx216x.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx216x.dtsi
index b0bb7bf944059..64903e935131b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx216x.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx216x.dtsi
@@ -852,16 +852,6 @@ esdhc0_data75_pins: sdhc1-dir-sdhc-pins {
 					groups = "sdhc1-dir";
 				};
 
-				gpio1_18_15_pins: iic8-iic7-gpio-pins {
-					function = "gpio";
-					groups = "sdhc2-data74";
-				};
-
-				i2c6_i2c7_pins: iic8-iic7-i2c-pins {
-					function = "i2c";
-					groups = "sdhc2-data74";
-				};
-
 				i2c0_pins: iic1-i2c-pins {
 					function = "i2c";
 					groups = "iic1";
@@ -1038,11 +1028,6 @@ i2c6: i2c@2060000 {
 			clock-names = "ipg";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(16)>;
-			pinctrl-names = "default", "gpio";
-			pinctrl-0 = <&i2c6_i2c7_pins>;
-			pinctrl-1 = <&gpio1_18_15_pins>;
-			scl-gpios = <&gpio1 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-			sda-gpios = <&gpio1 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 			status = "disabled";
 		};
 
@@ -1055,11 +1040,6 @@ i2c7: i2c@2070000 {
 			clock-names = "ipg";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(16)>;
-			pinctrl-names = "default", "gpio";
-			pinctrl-0 = <&i2c6_i2c7_pins>;
-			pinctrl-1 = <&gpio1_18_15_pins>;
-			scl-gpios = <&gpio1 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-			sda-gpios = <&gpio1 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 			status = "disabled";
 		};
 

-- 
2.43.0



