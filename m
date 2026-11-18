Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D457606A32A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 11:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h167uyux
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTzCh0jGFz2yVL;
	Wed, 18 Nov 2026 22:00:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25" arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794999631;
	cv=pass; b=VVwWFfQpCccbN+xor6mLEXQgeamwTogGCUGapLPgJ7t/9I+BykbFCArQmCyoGTn9ExuXZ6JIyTif2XfTugbHVcHhl2pUBUQdOdIbXoVZ0OUFjfJGiqdGa8OAZE/hY1zZArakjWWn0JPbrSwggDLeoRJHv6JGK6B7aBH44GwmwNtf+NeDxSISBxMgDxDLu9E1GVI6x5qqsA7h9SYsXIBM6kR6HWE6nTqB/7eDepvIkFmvT5w3CGB1Ws8CZ9mRwBpl0XkjWNcuuNVlXuYLIiYUex65mX/YpukJg7Sq64nJk0fS7hGpJW8o2TLtBgutGLQXaGg+daYidsFcJ6sGiOh8Cg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794999631; c=relaxed/relaxed;
	bh=vEoi4P7BQr8rHpfacdOlQuPPdzVB1aHJRvkDt1Kpjuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y88by0jszswGvqtOFV1WC6zOMNrhD2t6veigmZk9pilLYJF2BJBVR2XX8S6UEk5eLouYmgQDsADIdk8zghaosdFjIylxVO8BCSLQMBHAT+gjNc4COgIidtSin1fD/raJUbi8EjYnN7MwywOh+VdUp0EJ1IxyuyukzhYns8b32zOBrSLYzqGpcw7eMa8HdvE1KLHuMV+b/RJYkeAMcHaOSmLDbAlSEaVXUszgOfgN9pQxDvf9asjCICHg1sUPkSBhrlFE9zHBiXvSX2wja2EmKakU2H0R0D+WFkRR5/F0F1z1GC+yh6IYh1B8k6yhDRGe4qsI4UusL+J/v+OZE/rI3Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h167uyux; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h167uyux;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTzCX3Ckqz2ygW
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 22:00:23 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AC32D620FE;
	Wed, 18 Nov 2026 11:00:21 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794999621;
	b=2+QsxIAsrFXXzAKmCkX0bOv3cJsyy44/iKvmYK6Gmm6pnEbcTFoQqjCGIksiFvDmipGo
	 39K6d4hmNtJaa+d6JHHwEjcv4YiXcmadRASOqymHctle466YZx/JNHJ7m0RfbsOtHD8tY
	 S3Y1Zsz3RtnCOlggB5hInjJ5OkLItttuYt1AZxpwXe8ReeJfuFksZUztnlewUtCdyEIBn
	 wVQN4r+Tna960DE90pyLx846hC/y8hrTtE9k12SOTlQwwyMzWP5dna9JjcIiOna+HpsEd
	 J2y4s3sNyJrTGguUC93o/mIJEVuFJ+oXJCzK7xJBATvLmAqCYrzLIumVQoDQUI6Zo3A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794999621;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vEoi4P7BQr8rHpfacdOlQuPPdzVB1aHJRvkDt1Kpjuc=;
	b=QcUGGEOf3uatUHPkeTh5D4w4m/4kujpY7Fm6OA59qYa1p5haKe6h6o71bbgVPDiZQuRb
	 qa6lfM03bPTDSUiPlp1Y+ivi4n/y1B+ZFS/7zjg2kfOG2PzD+et7OOfVt92a2Cl9Lpgvd
	 /IW9H2mzl9TiEIqjktfqy2HTZyD8qumWUsrIR9hqOPUx0Jvix7SDefCO5tv+kgz+fAtr4
	 lWk+K2Rs+Lh6/Pg6u0eyo+B9VQZHyWAZkELiCnu5js+QU60czE1FJ7DLvtB6MHYSkvohz
	 udeg8qQP1Vsl7kpgV/+xCsLinOahVumnUhN1ghv+m0A8EqLaaBRR2ceOw6tTsZZo7cQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8DD9F1F000CE;
	Wed, 18 Nov 2026 11:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794999621;
	bh=vEoi4P7BQr8rHpfacdOlQuPPdzVB1aHJRvkDt1Kpjuc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=h167uyuxGBHw2dhL6UZckpyOy8yLt80U2IaeqOv2eZ3pJbWN4FHQ+DX8xS52SYtg9
	 /NlJoJBwjI76/bm2HJHrJmMtSQuuUKxdHEcF/UGUeIkArMVmt0pwGQ2yHwRr8Zv+bh
	 pcLXqjYsPHgPC6v/nAXXAcpRgR63WJ9XrdxAvI8FSafQwN/VMtHOTsZ6DJNPXLp5a/
	 xGsXTP2KM8YghyGTLZD0qX+yaixCUBTy5AbBwbXHSyTDMxFDtUjujo1XGaamtwhC9S
	 Dg8EzG2EPhFt0gHoKjuOEwsco6Szkd4EZAyAngrkeajEUimjk6malT6G09A6k0QB4r
	 Jq6gVxInkOR6A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1A05E4AD36;
	Wed, 18 Nov 2026 11:00:17 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Date: Wed, 18 Nov 2026 12:00:19 +0100
Subject: [PATCH v8 5/6] arm64: dts: lx2160a: describe the pad muxes as the
 DCFG RCW override
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
Message-Id: <20261118-for-upstream-lx2160a-rcw-pinmux-v1-v8-5-d01bc837593e@free.fr>
References: <20261118-for-upstream-lx2160a-rcw-pinmux-v1-v8-0-d01bc837593e@free.fr>
In-Reply-To: <20261118-for-upstream-lx2160a-rcw-pinmux-v1-v8-0-d01bc837593e@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794999615; l=11060;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=Zq2ZELCjBC2i/jGfOicU5lCYjF3qK07tZfqYcnwzjkc=;
 b=MoX+KjH+bwxkY2/c5qppeaBm5H5a0NnGFoIv1MfCIoGy+Y/JzM7Gj9VCUwXJ3R8rkN7XxrHeN
 LR47L/Q3d4aCli2iGAJdXk2VipsIP4ILUFigdeSahLYPYHOvJ85+Xdt
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

The pad muxes are fields of the RCW: read-only in RCWSR12..14, changed
at runtime through the override registers in the DCSR view of DCFG,
which read 0 until written.

pinctrl-single on those registers, since commit 8a1365c7bbc1
("arm64: dts: lx2160a: add pinmux and i2c gpio to support bus recovery"),
clears every other field of the word with its first pin state:
a board whose RCW programs a non-zero pad mux loses those pads at the
first I2C probe.

Describe the pad mux as a child of the dcfg node, which gains its DCSR
view and, as on the LS1028A, the addressing of its children:
the child is at its RCWSR12 to RCWSR14 and RCWSR27 windows, one group
per RCW field, one function per encoding, driven by
fsl,lx2160a-rcw-pinmux using fsl-guts. Labels and pin node names stay,
so no consumer changes.
The pinctrl-single node goes.

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 arch/arm64/boot/dts/freescale/fsl-lx216x.dtsi | 377 ++++++++++++++------------
 1 file changed, 202 insertions(+), 175 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx216x.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx216x.dtsi
index 2085362ab0eac..b0bb7bf944059 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx216x.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx216x.dtsi
@@ -669,9 +669,209 @@ clockgen: clock-controller@1300000 {
 		};
 
 		dcfg: syscon@1e00000 {
-			compatible = "fsl,lx2160a-dcfg", "syscon";
-			reg = <0x0 0x1e00000 0x0 0x10000>;
+			compatible = "fsl,lx2160a-dcfg", "syscon", "simple-mfd";
+			reg = <0x0 0x1e00000 0x0 0x10000>,
+			      <0x7 0x00100000 0x0 0x10000>;
+			reg-names = "dcfg_ccsr", "dcfg_dcsr";
+			ranges = <0x0 0x0 0x1e00000 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
 			little-endian;
+
+			pinmux_i2crv: pinctrl@12c {
+				compatible = "fsl,lx2160a-rcw-pinmux";
+				reg = <0x12c 0xc>, <0x168 0x4>;
+
+				i2c1_pins: iic2-i2c-pins {
+					function = "i2c";
+					groups = "iic2";
+				};
+
+				gpio0_31_30_pins: iic2-gpio-pins {
+					function = "gpio";
+					groups = "iic2";
+				};
+
+				ftm0_ch10_pins: iic2-ftm-pins {
+					function = "flextimer";
+					groups = "iic2";
+				};
+
+				esdhc0_cd_wp_pins: iic2-sdhc-pins {
+					function = "sdhc";
+					groups = "iic2";
+				};
+
+				i2c2_pins: iic3-i2c-pins {
+					function = "i2c";
+					groups = "iic3";
+				};
+
+				gpio0_29_28_pins: iic3-gpio-pins {
+					function = "gpio";
+					groups = "iic3";
+				};
+
+				can0_pins: iic3-can-pins {
+					function = "can";
+					groups = "iic3";
+				};
+
+				event65_pins: iic3-event-pins {
+					function = "evt";
+					groups = "iic3";
+				};
+
+				i2c3_pins: iic4-i2c-pins {
+					function = "i2c";
+					groups = "iic4";
+				};
+
+				gpio0_27_26_pins: iic4-gpio-pins {
+					function = "gpio";
+					groups = "iic4";
+				};
+
+				can1_pins: iic4-can-pins {
+					function = "can";
+					groups = "iic4";
+				};
+
+				event87_pins: iic4-event-pins {
+					function = "evt";
+					groups = "iic4";
+				};
+
+				i2c4_pins: iic5-i2c-pins {
+					function = "i2c";
+					groups = "iic5";
+				};
+
+				gpio0_25_24_pins: iic5-gpio-pins {
+					function = "gpio";
+					groups = "iic5";
+				};
+
+				esdhc0_clksync_pins: iic5-sdhc-clk-pins {
+					function = "sdhc-clk";
+					groups = "iic5";
+				};
+
+				dspi2_miso_mosi_pins: iic5-spi3-pins {
+					function = "spi";
+					groups = "iic5";
+				};
+
+				i2c5_pins: iic6-i2c-pins {
+					function = "i2c";
+					groups = "iic6";
+				};
+
+				gpio0_23_22_pins: iic6-gpio-pins {
+					function = "gpio";
+					groups = "iic6";
+				};
+
+				esdhc1_clksync_pins: iic6-sdhc-clk-pins {
+					function = "sdhc-clk";
+					groups = "iic6";
+				};
+
+				fspi_data74_pins: xspi1-data74-pins {
+					function = "flexspi";
+					groups = "xspi1-data74";
+				};
+
+				gpio1_31_28_pins: xspi1-data74-gpio-pins {
+					function = "gpio";
+					groups = "xspi1-data74";
+				};
+
+				fspi_data30_pins: xspi1-data30-pins {
+					function = "flexspi";
+					groups = "xspi1-data30";
+				};
+
+				gpio1_27_24_pins: xspi1-data30-gpio-pins {
+					function = "gpio";
+					groups = "xspi1-data30";
+				};
+
+				fspi_dqs_sck_cs10_pins: xspi1-base-pins {
+					function = "flexspi";
+					groups = "xspi1-base";
+				};
+
+				gpio1_23_20_pins: xspi1-base-gpio-pins {
+					function = "gpio";
+					groups = "xspi1-base";
+				};
+
+				esdhc0_cmd_data30_clk_vsel_pins: sdhc1-base-sdhc-vsel-pins {
+					function = "sdhc";
+					groups = "sdhc1-base";
+				};
+
+				gpio0_21_15_pins: sdhc1-base-gpio-pins {
+					function = "gpio";
+					groups = "sdhc1-base";
+				};
+
+				dspi0_pins: sdhc1-base-spi1-pins {
+					function = "spi";
+					groups = "sdhc1-base";
+				};
+
+				esdhc0_cmd_data30_clk_dspi2_cs0_pins: sdhc1-base-sdhc-spi3-pins {
+					function = "sdhc-spi";
+					groups = "sdhc1-base";
+				};
+
+				esdhc0_cmd_data30_clk_data4_pins: sdhc1-base-sdhc-data4-pins {
+					function = "sdhc-data4";
+					groups = "sdhc1-base";
+				};
+
+				esdhc0_dir_pins: sdhc1-dir-pins {
+					function = "sdhc";
+					groups = "sdhc1-dir";
+				};
+
+				gpio0_14_12_pins: sdhc1-dir-gpio-pins {
+					function = "gpio";
+					groups = "sdhc1-dir";
+				};
+
+				dspi2_cs31_pins: sdhc1-dir-spi3-pins {
+					function = "spi";
+					groups = "sdhc1-dir";
+				};
+
+				esdhc0_data75_pins: sdhc1-dir-sdhc-pins {
+					function = "sdhc-data";
+					groups = "sdhc1-dir";
+				};
+
+				gpio1_18_15_pins: iic8-iic7-gpio-pins {
+					function = "gpio";
+					groups = "sdhc2-data74";
+				};
+
+				i2c6_i2c7_pins: iic8-iic7-i2c-pins {
+					function = "i2c";
+					groups = "sdhc2-data74";
+				};
+
+				i2c0_pins: iic1-i2c-pins {
+					function = "i2c";
+					groups = "iic1";
+				};
+
+				gpio0_3_2_pins: iic1-gpio-pins {
+					function = "gpio";
+					groups = "iic1";
+				};
+			};
 		};
 
 		sfp: efuse@1e80000 {
@@ -1531,179 +1731,6 @@ pcs18: ethernet-phy@0 {
 			};
 		};
 
-		pinmux_i2crv: pinmux@70010012c {
-			compatible = "pinctrl-single";
-			reg = <0x00000007 0x0010012c 0x0 0xc>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			#pinctrl-cells = <2>;
-			pinctrl-single,bit-per-mux;
-			pinctrl-single,register-width = <32>;
-			pinctrl-single,function-mask = <0x7>;
-
-			/* RCWSR12 */
-			i2c1_pins: iic2-i2c-pins {
-				pinctrl-single,bits = <0x0 0x0 0x7>;
-			};
-
-			gpio0_31_30_pins: iic2-gpio-pins {
-				pinctrl-single,bits = <0x0 0x1 0x7>;
-			};
-
-			ftm0_ch10_pins: iic2-ftm-pins {
-				pinctrl-single,bits = <0x0 0x2 0x7>;
-			};
-
-			esdhc0_cd_wp_pins: iic2-sdhc-pins {
-				pinctrl-single,bits = <0x0 0x6 0x7>;
-			};
-
-			i2c2_pins: iic3-i2c-pins {
-				pinctrl-single,bits = <0x0 0x0 (0x7 << 3)>;
-			};
-
-			gpio0_29_28_pins: iic3-gpio-pins {
-				pinctrl-single,bits = <0x0 (0x1 << 3) (0x7 << 3)>;
-			};
-
-			can0_pins: iic3-can-pins {
-				pinctrl-single,bits = <0x0 (0x2 << 3) (0x7 << 3)>;
-			};
-
-			event65_pins: iic3-event-pins {
-				pinctrl-single,bits = <0x0 (0x6 << 3) (0x7 << 3)>;
-			};
-
-			i2c3_pins: iic4-i2c-pins {
-				pinctrl-single,bits = <0x0 0x0 (0x7 << 6)>;
-			};
-
-			gpio0_27_26_pins: iic4-gpio-pins {
-				pinctrl-single,bits = <0x0 (0x1 << 6) (0x7 << 6)>;
-			};
-
-			can1_pins: iic4-can-pins {
-				pinctrl-single,bits = <0x0 (0x2 << 6) (0x7 << 6)>;
-			};
-
-			event87_pins: iic4-event-pins {
-				pinctrl-single,bits = <0x0 (0x6 << 6) (0x7 << 6)>;
-			};
-
-			i2c4_pins: iic5-i2c-pins {
-				pinctrl-single,bits = <0x0 0x0 (0x7 << 9)>;
-			};
-
-			gpio0_25_24_pins: iic5-gpio-pins {
-				pinctrl-single,bits = <0x0 (0x1 << 9) (0x7 << 9)>;
-			};
-
-			esdhc0_clksync_pins: iic5-sdhc-clk-pins {
-				pinctrl-single,bits = <0x0 (0x2 << 9) (0x7 << 9)>;
-			};
-
-			dspi2_miso_mosi_pins: iic5-spi3-pins {
-				pinctrl-single,bits = <0x0 (0x3 << 9) (0x7 << 9)>;
-			};
-
-			i2c5_pins: iic6-i2c-pins {
-				pinctrl-single,bits = <0x0 0x0 (0x7 << 12)>;
-			};
-
-			gpio0_23_22_pins: iic6-gpio-pins {
-				pinctrl-single,bits = <0x0 (0x1 << 12) (0x7 << 12)>;
-			};
-
-			esdhc1_clksync_pins: iic6-sdhc-clk-pins {
-				pinctrl-single,bits = <0x0 (0x2 << 12) (0x7 << 12)>;
-			};
-
-			fspi_data74_pins: xspi1-data74-pins {
-				pinctrl-single,bits = <0x0 0x0 (0x7 << 15)>;
-			};
-
-			gpio1_31_28_pins: xspi1-data74-gpio-pins {
-				pinctrl-single,bits = <0x0 (0x1 << 15) (0x7 << 15)>;
-			};
-
-			fspi_data30_pins: xspi1-data30-pins {
-				pinctrl-single,bits = <0x0 0x0 (0x7 << 18)>;
-			};
-
-			gpio1_27_24_pins: xspi1-data30-gpio-pins {
-				pinctrl-single,bits = <0x0 (0x1 << 18) (0x7 << 18)>;
-			};
-
-			fspi_dqs_sck_cs10_pins: xspi1-base-pins {
-				pinctrl-single,bits = <0x0 0x0 (0x7 << 21)>;
-			};
-
-			gpio1_23_20_pins: xspi1-base-gpio-pins {
-				pinctrl-single,bits = <0x0 (0x1 << 21) (0x7 << 21)>;
-			};
-
-			esdhc0_cmd_data30_clk_vsel_pins: sdhc1-base-sdhc-vsel-pins {
-				pinctrl-single,bits = <0x0 0x0 (0x7 << 24)>;
-			};
-
-			gpio0_21_15_pins: sdhc1-base-gpio-pins {
-				pinctrl-single,bits = <0x0 (0x1 << 24) (0x7 << 24)>;
-			};
-
-			dspi0_pins: sdhc1-base-spi1-pins {
-				pinctrl-single,bits = <0x0 (0x2 << 24) (0x7 << 24)>;
-			};
-
-			esdhc0_cmd_data30_clk_dspi2_cs0_pins: sdhc1-base-sdhc-spi3-pins {
-				pinctrl-single,bits = <0x0 (0x3 << 24) (0x7 << 24)>;
-			};
-
-			esdhc0_cmd_data30_clk_data4_pins: sdhc1-base-sdhc-data4-pins {
-				pinctrl-single,bits = <0x0 (0x4 << 24) (0x7 << 24)>;
-			};
-
-			esdhc0_dir_pins: sdhc1-dir-pins {
-				pinctrl-single,bits = <0x0 0x0 (0x7 << 27)>;
-			};
-
-			gpio0_14_12_pins: sdhc1-dir-gpio-pins {
-				pinctrl-single,bits = <0x0 (0x1 << 27) (0x7 << 27)>;
-			};
-
-			dspi2_cs31_pins: sdhc1-dir-spi3-pins {
-				pinctrl-single,bits = <0x0 (0x3 << 27) (0x7 << 27)>;
-			};
-
-			esdhc0_data75_pins: sdhc1-dir-sdhc-pins {
-				pinctrl-single,bits = <0x0 (0x4 << 27) (0x7 << 27)>;
-			};
-
-			/* RCWSR13 */
-			gpio1_18_15_pins: iic8-iic7-gpio-pins {
-				pinctrl-single,bits = <0x4 0x1 0x7>;
-			};
-
-			i2c6_i2c7_pins: iic8-iic7-i2c-pins {
-				pinctrl-single,bits = <0x4 0x2 0x7>;
-			};
-
-			/* RCWSR14 */
-			/*
-			 * IIC1_PMUX is a single bit at RCWSR14[10], but bit-per-mux
-			 * uses the mask for the field to clear before applying the
-			 * value.
-			 * So bits 11 and 12, which are reserved, are written as 0
-			 * on every mux switch, it is harmless.
-			 */
-			i2c0_pins: iic1-i2c-pins {
-				pinctrl-single,bits = <0x8 0x0 (0x7 << 10)>;
-			};
-
-			gpio0_3_2_pins: iic1-gpio-pins {
-				pinctrl-single,bits = <0x8 (0x1 << 10) (0x7 << 10)>;
-			};
-		};
-
 		fsl_mc: fsl-mc@80c000000 {
 			compatible = "fsl,qoriq-mc";
 			reg = <0x00000008 0x0c000000 0 0x40>,

-- 
2.43.0



