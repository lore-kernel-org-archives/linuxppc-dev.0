Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F343606A324
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 18:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D7WJGkz7
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJxWg5ZQFz2yqF;
	Wed, 04 Nov 2026 05:13:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25" arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793729583;
	cv=pass; b=aRGfsVy8VlARBK9cycfAc8FXKTPMdMk+1wRKa5AfreVw+RNA1XCyfauDM3H8roa4j44q95sLE+Ek4v5lsc9qN27bCaf9KRc8WIEW+LjqbuOJzaPP6lGEzxCaXxOgODqm3BwxVpBDqhcN5cvFuwUrEW9o5+lHNm85gj6aPCmgUKxZxuktr2CwKA3rXCymtJVKwoa5CpgWXRXWTrFNuf3ger67foBGXZ+fQbWFcOp2b5IofWFSdIIFVIx7C1I+Q34HFhsMWSyl7hFQujFmm4YZqHlTkBdLwhCZikiJ6eH2r7NFy390slC+VJ4ra+atxcj1PQYpesPJcIJ1G39JZy9l7Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793729583; c=relaxed/relaxed;
	bh=gJSO7bESatwNvEVwEFLXH2A9xw/llnEfNdlYdEnJwmQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NZ4ZsRI7jYk+eWoxLi40x2otjwxM6iVHiJaoRaDEdaZZvguXk5xQ9apfOqY66lNccm+b1JnBsvGy7iIKr1q9bLLzMaNPWEZLC6lE9OzqZ6n+C3fiyQTG3c25JZX/PPgxO1qhGG+FEMfmwJatywFurIGVyyWjGOXqNoRx221JUzpOkievky6uguUGfcvN1zAPK+gIiQIb9GesxlA/vpXIqfbHTtPQzB5sJBKYDC1GVLqZCLeYOZDCVu8EIZNBcdhE3azICOEm9y0ZTXNBTnbyucOal+hcUDueO/YMF2frCbuKV7J8GWrQnpjNnmmsXJV8XxEV/flSKv0Ys8NXDX/YXg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D7WJGkz7; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D7WJGkz7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJxWb1kP9z2xrC
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 05:12:58 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id AC70F43FB0;
	Tue,  3 Nov 2026 18:12:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793729576;
	b=yJgsjkEg1S1iB/ELpJmVT1kCvNBdcZXb9dO1t4CdwrSn7u7IJbDCyslSTwpYkGAd0zBC
	 RqxriAV7fxaMOhxy3pRYXKJ7k+tA+JcwzrX4sgoVZc59mhLJ5xVdnTzPFoCZaxzBxI7JA
	 Uqk3wCy1yqJvd93J0vCTZyDubGiMkIX9NmmWVrJIEnkV0gk0L7+THoCcWWYNC/RxeguUF
	 QS0WiVd6Zedp9Q5bBAfnUQQsweagI/RgpAGpDJTL/8ObixPQrUG12W8hnl6Tmzl8gK/eV
	 7iUewwjZF+i3jRFo43pe2fU54+ZGES/vE9+f0IwPibmbBCB8efqNHd+n6flV1JKSXSg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793729576;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=gJSO7bESatwNvEVwEFLXH2A9xw/llnEfNdlYdEnJwmQ=;
	b=eP5lNPKJi80mVq11hqsQvPbcKri7opDUdVC2MdGCqimlIeBgNYs9PhMhNjRQpNFU+pFB
	 R9tWIMBNYN8BWsDtVekEj13R5asB74CPTcF8Cl6xHtOoW4nJ9NItZErA2YyNtNAdx7jZ4
	 lacy5iuRbt2qgk348LcrKtsJr71cCY4CuAjEKrvuVcw0bAth7oHE4loO6eHCAFgQxOhXX
	 GlJC/1u1qkBCDC8qijjiyRknaV436dK+JXbDP0vp30HMf99+JwgqqvQlCO0Vbn5klKU8E
	 bjDA/Z8g3QtJSHUg3yswiBrbAqDdU0zFvi98UJLULk2vG3nouee8BsfOxA47KL9q4sg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A1AAC1F000C1;
	Tue,  3 Nov 2026 18:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793729576;
	bh=gJSO7bESatwNvEVwEFLXH2A9xw/llnEfNdlYdEnJwmQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=D7WJGkz7g/l8+o6IxEoMFZACgsvAYKqj1xAK1Z+2BorNtagDn0MO36x07aoAQzmsm
	 +pc1IMz1/FFWTxbA0Wid2ur8YthYHkO1vtOdOwE75aax9NxRoZG2+juMmhcdPP+nYY
	 Py2GnJHBss+X8ypbyXEl4F9Jo4KwcXEbRvdtQLL5Lpk5bJREXXXwo5U6njzH9+SIGT
	 92zJ59xPUMo4Bipjp1v3ykr/Qj32KvyEafd2BFAdi0kt6ZrMuDAsgR/PCJQi2BSTJ+
	 as/4EAGXSdgn9M2dALLdj6BLZnFpHav8XnWrdwkc1B5o5rDLfkSHRufH7WcfuP/J6y
	 UhQ/UWBFi6z2A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 483FD46A81;
	Tue,  3 Nov 2026 18:12:54 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Date: Tue, 03 Nov 2026 19:12:13 +0100
Subject: [PATCH v2 5/5] arm64: dts: lx2160a: describe the pad muxes as the
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
Message-Id: <20261103-for-upstream-lx2160a-rcw-pinmux-v1-v2-5-3aad0860b984@free.fr>
References: <20261103-for-upstream-lx2160a-rcw-pinmux-v1-v2-0-3aad0860b984@free.fr>
In-Reply-To: <20261103-for-upstream-lx2160a-rcw-pinmux-v1-v2-0-3aad0860b984@free.fr>
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
 Vladimir Oltean <vladimir.oltean@nxp.com>, Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793729572; l=10746;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=NOOa3FebNGjF/sIGYc7u4fvY37gwclbuRKMsfu8H+k4=;
 b=bYsVNpTlD6CPACeUd8vg2wD02WiKvYRDkb102/jk3mOTCqWrbfXveDB1UB5psGSI70TTQD70+
 OYNTLQIsT55AT1zhXgtxlV5uR/OMv+4dEy8VXXOc5bGMwl53CP4zCTm
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
view: one group per RCW field, one function per encoding, driven by
fsl,lx2160a-rcw-pinmux through fsl-guts. Labels and node names stay,
so no consumer changes. The pinctrl-single node goes.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 arch/arm64/boot/dts/freescale/fsl-lx216x.dtsi | 373 ++++++++++++++------------
 1 file changed, 198 insertions(+), 175 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx216x.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx216x.dtsi
index 2085362ab0ea..23e662d235a4 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx216x.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx216x.dtsi
@@ -669,9 +669,205 @@ clockgen: clock-controller@1300000 {
 		};
 
 		dcfg: syscon@1e00000 {
-			compatible = "fsl,lx2160a-dcfg", "syscon";
-			reg = <0x0 0x1e00000 0x0 0x10000>;
+			compatible = "fsl,lx2160a-dcfg", "syscon", "simple-mfd";
+			reg = <0x0 0x1e00000 0x0 0x10000>,
+			      <0x7 0x00100000 0x0 0x10000>;
+			reg-names = "dcfg_ccsr", "dcfg_dcsr";
 			little-endian;
+
+			pinmux_i2crv: pinctrl {
+				compatible = "fsl,lx2160a-rcw-pinmux";
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
@@ -1531,179 +1727,6 @@ pcs18: ethernet-phy@0 {
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



