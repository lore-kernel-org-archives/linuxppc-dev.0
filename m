Return-Path: <linuxppc-dev+bounces-18076-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47274112585A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 17:36:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWHwg5tllz3cFG;
	Thu, 12 Mar 2026 04:36:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773250579;
	cv=none; b=nilJnCa55g75pgNS+IR/SSLCrhx3nqgahzBXyCw0UDUoRlOU/pkjQOLEwZrs1UsfGGNBMWfiOIAQTWOZSfft5sML0+BwODTdkH8qCOO68ioVXzcQMQ8nlrJ4w1PL29D7aPD917c0JKcgAoSZJBrEdkvhS2xuxeR8s8DEMw5L8JWFimpXTCdsDZcCuai7nwWJmL09i1OcdgxXAZuNyBmgbOcbZCSSCdgTVFKTmE3hQCH2Z/sAfal2WamZMzdFbNwqHpFtQxna6vbxB+RAXKlRzs03r65qzoByCnIhPCTH/M2zXwIZM+MgVMX//dwNYOYassZ4DZJAvwaXKAiDMPlFkw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773250579; c=relaxed/relaxed;
	bh=e+lM8FVlQ4OKd62qFk45ae4Mbbdacmxid6p6xoi1pTo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j8wocF+tG2tTxWPOCou9rrVvpDE3pjtybDGdh8c6krMsDKv6vgwD8mjbxBXrPqzAXowPjnRm0m1+oZHkLPWmGXTZhz/LNSn+MXxFO3T57+Ynl2qdENMDcau3Kjya5QxEF7Yjb9P02VOxhVgg8jevoaNT4vIgZR8G5Wg4BgrDKN5Z3agrTDOzZMAkfESsJSjXmknxSJ4A7Uj28ywj4pEkXUIJyUOxDIe6QVj7fvhBgN7jHxqICFnXCL8q92iAi3EmTyZ/V9o6al3ZqEuz/ysYg317Cw5ewT1bUbyeiKvqieK2pHUrXQqCgb+kKTRQj6HOZC+tHTXR4U8QRGWtY1Cs2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=r9nGHw3C; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+j.ne.posteo.net@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=r9nGHw3C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+j.ne.posteo.net@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWHwf55nBz3cCK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 04:36:18 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B20AD4457C;
	Wed, 11 Mar 2026 17:36:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 920BBC19421;
	Wed, 11 Mar 2026 17:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773250575;
	bh=xIP+bku3p7uRvClBiGIRSu+b/UukBTARuX0THvtBZGI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=r9nGHw3CVNLZW8IXKb8zX2WWPx79PPbhI9p3KH3CBzj/XmQOwyjI1CjGahnO0r1ek
	 AHCpPHooZaFI9Ryr6W8Jm6eWU/ys2+SSZi0zCN5KuUlz280ITevmQAunI6C4pSFHhb
	 tlGq2POgIkGvOWdVNjVE1NIKsI6m9bu867+Tt4zL1Ezk3UErLTN02tLbOVLMd+4yZi
	 gyIaS7HZnIwqmo6nW3bW0PY5Yy5mweK2dTbWqJkP9hqiEldX+VSZ0APQ3cqOTkXQR5
	 ZmMjmrjt6A9OponSAdRReOKtQYqRK2CI5sp2wtd4HioEgKwOEiqcHujmSFkS5aTbco
	 rJG9WDIncSgOg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C68112585B;
	Wed, 11 Mar 2026 17:36:15 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Wed, 11 Mar 2026 18:35:58 +0100
Subject: [PATCH 3/3] powerpc: wii: Fix LED name pattern
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260311-wii-schema-v1-3-1563ac4aefa8@posteo.net>
References: <20260311-wii-schema-v1-0-1563ac4aefa8@posteo.net>
In-Reply-To: <20260311-wii-schema-v1-0-1563ac4aefa8@posteo.net>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Link Mauve <linkmauve@linkmauve.fr>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773250574; l=871;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=dxb0z+bZ6O263uGIQqre6Tj1enaP+WCL8KxxI5d4cWs=;
 b=/DY0cdSzCp+gX0zwhnW/DRGuhSs6t4aMpw8W11d0LWq3iAuY1blw7ZZz1vd1oIlFVAj6gYZsm
 TZErN6bNY7iCXITcJLnMMEvkwmrAYDDM1p83HUi9jzS5WW9mpok8FV4
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

Adjust the name of the drive slot LED node to comply with the schema in
Documentation/devicetree/bindings/leds/leds-gpio.yaml.

  arch/powerpc/boot/dts/wii.dtb: gpio-leds: 'drive-slot' does not match
  any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
 arch/powerpc/boot/dts/wii.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/wii.dts b/arch/powerpc/boot/dts/wii.dts
index 57d428b1f78740..473d9feb9cdb83 100644
--- a/arch/powerpc/boot/dts/wii.dts
+++ b/arch/powerpc/boot/dts/wii.dts
@@ -246,7 +246,7 @@ gpio-leds {
 		compatible = "gpio-leds";
 
 		/* This is the blue LED in the disk drive slot */
-		drive-slot {
+		led-0 {
 			label = "wii:blue:drive_slot";
 			gpios = <&GPIO 5 GPIO_ACTIVE_HIGH>;
 			panic-indicator;

-- 
2.51.0



