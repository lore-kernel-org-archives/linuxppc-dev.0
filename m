Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D5060A2602
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 11:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W8SAR8Sy
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTzCY6d5Bz2yjN;
	Wed, 18 Nov 2026 22:00:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25" arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794999625;
	cv=pass; b=NfVXQT6mSMgYxddNUxa2yV6C0p6ZmKAwJ6qqmPLKdM3PHVSN+Rqay8iAsjS0rub+WvflpRcz4UD5Uut1p3vgHsqBjDw7NMlgRlfl049B3fKMUUzldSFYiD8WhE4Nx+FsYd1b7kLf5w5CSdNGsqUTv0WP/Agn/q3uD7Evj+eDighk9qiz2mjc8QMzBn2/oYQdJ1k8CyTKbbwWH0aIXgv9gzAdXXhry/7pZlDNh+nRfsusruRUn4BiGr3BUdngb/S9NMr4fgu+zibBpquQg1ODH0b4ZO91hYMNnfBcnDUIKXMdGA/HlIR89MbcwZEK/k1XDpklyJBqiFhywwpLmN1S4A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794999625; c=relaxed/relaxed;
	bh=3GvLecrDY2H3kso6C66DvG+vyP5D+kTS+VYHd/DxRd4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VhpLR07O5kMxvU9y3g3g+WGrVb14p7exLb/wF5XCSUlWspIazP+wR3XU+rrCCqSRBa8GytbUN7d1K4rTHSmtGF6AW4m4BPngvjGezEj5930eWAh2mhWiIrhCb8z+oogAWNiSSK4OpwWtFKbtbXdth7F5aLB9X3fd9xEW11dXrq/rpbiQdu7AbOArJOuhrnYrDG6T+qy7kxIKPMy6elxIKCXTBpKMNSthZagdQbmNeMAma4MnQwwXapZHUK3RGpdSusfa4UnBb44/PCf0JxPq9mPO9ny44sk/hBR8aIjznZpIiB4V4Bs3cUWEBylrfPQuO3a5w1V4q0jjkZlx5UKmKA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W8SAR8Sy; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W8SAR8Sy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTzCV3Xghz2yLF
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 22:00:22 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0C76861DEA;
	Wed, 18 Nov 2026 11:00:20 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794999619;
	b=ZqxZvmBhA7bMLnVBFic4ZL9sHX9+wkxS4gJcq2FD6FjxZKHSO3vzVvuOtIctEeC3z+Ry
	 xc2VjhhjpYw+eeuY7V5OoEvIwR+KNdGkUnZ88KA7EmAUc1NySvC9FdVLdvL6kXhJNNoeN
	 c4Blfve2TAZNCQPBXCiRi449lk4xfUTuAqM06u+XJ0to8RYbB6R+42KaHocS5np0w+L8X
	 m9hc0nH9gzQz3DC/ZgDTMNGHc/CxlL9VhG06+w/ZXaskADDipnguNmwSOcRCk/lGrlwVt
	 vD6CoE6A5rgM9CPzIIm8Lu5N+ERMcNA7mjScJ2Cfj5sVT9jNovpYxH6/93Rqw6rcYhA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794999619;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=3GvLecrDY2H3kso6C66DvG+vyP5D+kTS+VYHd/DxRd4=;
	b=T44NG247JQJWe5zDb2RTqW9q8RLO0I/oRcgiIOppv03wVYm4Es1OmC6mQlqKo+S3FczW
	 xJILrAzYoeh0NIwvt1Zlb/WWSZzyDV50TEBTpxL6vLDCJ5BIkk9AfqPlVZtIBgkoOKtKJ
	 F+5QLFKRLIfe9XSP/W4KC6ieURB0/p8JNytIjc5Ug3EgS27lapz3xyqnPZKvfF6Npu7ec
	 a6CQZKHRGx0MkQvKWv3MtOx/j1mx+q3kOV4bl+C6H5UBgZXm/7q9cD9amtr8qtZZxhAiW
	 JwuVQl4+DieafMqtZ9y5f335Y9BhJjfBFyRV0UmyPYQKBRZtVUgxs7wZ8oDA7tZgZ6Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 915CC1F000CF;
	Wed, 18 Nov 2026 11:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794999619;
	bh=3GvLecrDY2H3kso6C66DvG+vyP5D+kTS+VYHd/DxRd4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=W8SAR8SyYDhWN5sT/JIKHrkq4BaKID84A3ltt9smrd0QNq0Q4/MKB0NopgdE50SUS
	 EjThg55B2t3eG35XHFzfeRi0h2ITNRD2OZCSgncDC+n/GXBUhEOLA2tC4MHpGY6noF
	 Bp46oRsv1QfNgg3QwCU2JdHzoaafNN42GMur7OPAsJ2+Fop5OG/uwkZDP81AO1ARqf
	 T0HRRs0MtMaqFIxmOy3RExVJEoGYuJmOQuJpgOAqjQZum0XAe+PddHxRb/gvxCNfmf
	 n/wLqe6R6jKbbttU3pSLvbNmky43jgyB1hM6fwYANKjSwGngOg8hTtADtSdElOLBXn
	 AtiBDAHM9hrUg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 32F614AD3A;
	Wed, 18 Nov 2026 11:00:17 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Date: Wed, 18 Nov 2026 12:00:20 +0100
Subject: [PATCH v8 6/6] arm64: dts: lx2160a: note that i2c6 and i2c7 share
 their pad mux
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
Message-Id: <20261118-for-upstream-lx2160a-rcw-pinmux-v1-v8-6-d01bc837593e@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794999615; l=1826;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=yeushjxUh8hTfyjoadt5CEZb8ixL/R3BgEaH0ncLzqA=;
 b=70ZXOVv+w6B5PBj90dlUKI9rCkjVWwkQzQm3AvdGn1g+/uSRKSEinlbaTuHI4YXZhytwwK5SC
 Yx3WUMO/04oBjnqH8Nc224oNcYJM+JmHmGqV+6BMOxO8B4JPXiKzrY/
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Vincent Jardin <vjardin@free.fr>

IIC7 and IIC8, the i2c6 and i2c7 nodes, exist only on the SDHC2_DAT[7:4]
pads, and one RCW field, SDHC2_DAT74_PMUX, muxes all four of them:
 - 0b010 gives both buses
 - 0b001 gives GPIO2[18:15]

Both nodes point at the same two pin states of that field. A board that
enables one of the two buses gets a working bus recovery from them, so
they stay in the SoC dtsi.

A board that enables both cannot use them: the pinctrl core gives the
field to the first controller and the second one fails to probe, and
the bus recovery of one would switch the pads of the other one to GPIO
too. Say so above each node.

Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://lore.kernel.org/all/avzGrorxOg2GmYOl@lxl00025.wbi.nxp.com/
Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 arch/arm64/boot/dts/freescale/fsl-lx216x.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx216x.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx216x.dtsi
index b0bb7bf944059..7bb593c01bd18 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx216x.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx216x.dtsi
@@ -1029,6 +1029,11 @@ i2c5: i2c@2050000 {
 			status = "disabled";
 		};
 
+		/*
+		 * i2c6 and i2c7 share the SDHC2_DAT74 pad mux: these pin
+		 * states, and so the bus recovery, work only while i2c7 is
+		 * disabled.
+		 */
 		i2c6: i2c@2060000 {
 			compatible = "fsl,vf610-i2c";
 			#address-cells = <1>;
@@ -1046,6 +1051,11 @@ i2c6: i2c@2060000 {
 			status = "disabled";
 		};
 
+		/*
+		 * i2c7 and i2c6 share the SDHC2_DAT74 pad mux: these pin
+		 * states, and so the bus recovery, work only while i2c6 is
+		 * disabled.
+		 */
 		i2c7: i2c@2070000 {
 			compatible = "fsl,vf610-i2c";
 			#address-cells = <1>;

-- 
2.43.0



