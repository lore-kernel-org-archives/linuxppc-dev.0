Return-Path: <linuxppc-dev+bounces-17589-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0BCBEDA692
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Mar 2026 15:51:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQKz02cZ6z3c8s;
	Wed, 04 Mar 2026 02:51:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772553068;
	cv=none; b=cXYbv6Vpd4TQC9yeAP2kecOKFqmH6P8mwQAqVT109eRfPpsoKc+rLQKQer3G5ZLNBkvEqxmqTAOt2JPMFzyCIWcx55Mr0vmuqM2XtWrnHOC0+5uR1o4QQKebefr9vy0pGZU9rP5CpbzRi9b8/l36MaIEIVnUtmZuBMv9oUk/iffBr4OunX3yUwrcHZXplgGpfcSXN3XaQ2eQy61S/Z1cWiUh4xD/yLUlPRE4nXxN//jAxrPQW+cNIjzrtnNLb7zuy1QOuCVV94CY7dcU5nsCzK4qJsPBbfG1JjVHeV8gZd8dSE9U9UkRCtU63U+W6QtDgd7rZeoCA7X2G8cPlKSiGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772553068; c=relaxed/relaxed;
	bh=HswkjtKly7wEVHnjeezB2BZ8aVwltyhyWIeuHzRO+wE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cRSLMZz8ndCevJ9zeRVwmIfhy2Pvn4MkFeuCw60n+15sugcts3YHFW6UdjPD0dOZ78dIiaLoRwpQg0dkRWzwr07qw+NFHo0MFKPW/zwYR5w9VP2h9Bgw/Axp5VWn5fowrLbK5CmvvCpI33IwIKgEl9uN+NSi9Dz5yymPYiM0MSi1IEXwVwnzixhSsbY2L/J1dZ6OynUua+bxbz/ZbcgQJ/YZedlzow9e6KYUOSq7uc8dQyQ283WUTqzQ6XHHjHnndoXp/X5nPl8nu6ewbrZiIlv/C12D2hOFKZISxF4JTKwAGpokSj96L4AEh6x0Df0dd0NMm7roNClzXjZfGyX0Yg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iea8njuu; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+j.ne.posteo.net@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iea8njuu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+j.ne.posteo.net@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQKyx3RqNz3bsC
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 02:51:05 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2DF1B60134;
	Tue,  3 Mar 2026 15:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79B1AC4AF0D;
	Tue,  3 Mar 2026 15:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772553062;
	bh=qYFS2rlOpk9olbd80sCn3U0gRL4PIsZ3YtXzt7AFweM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=iea8njuuRp42V0z6Amfa6xL9VcQEL1KnX4BdDVV9cWZ9vSbRkl9S4/TvdfaMqngy0
	 fbF0PTjstZgdjBbsAz+vJVDG+AEMV5owL5Yc5nIL/T0pwUMef3mfUTw4nf9D29oT40
	 fApvYS4TOLzcGt5Aou71fGZfle4RB3A8fMVWO9O1Z4lqquKIPhqDItvgbKZcb/0NXL
	 Usp/+hWsyGZhuKR7vc9B8+AzLIUVwLgqc11rRm8sxxBZgVlbGM2dvJEjnHcH9gNSPV
	 qpXo5T76MZrcnFlx2C/gMcvgYD01/1sc092hIKoUFxsimR3sbM/1wWvuskublzPYIg
	 2HHEs8P93uWRw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8DEEDA694;
	Tue,  3 Mar 2026 15:51:02 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Tue, 03 Mar 2026 16:50:53 +0100
Subject: [PATCH RESEND v2 3/5] powerpc: dts: mpc8315erdb: Rename LED nodes
 to comply with schema
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
Message-Id: <20260303-mpc83xx-cleanup-v2-3-187d3a13effa@posteo.net>
References: <20260303-mpc83xx-cleanup-v2-0-187d3a13effa@posteo.net>
In-Reply-To: <20260303-mpc83xx-cleanup-v2-0-187d3a13effa@posteo.net>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772553061; l=775;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=+puBlr+iszGhT8EEZ37X0Zo4jHGzrX+grKkdaghOCjU=;
 b=v00ZH6oGc73d74tAXfq3D1dQOjNn+Fgi26cIPLJ9hxzsTF6V2JeUrO3FPN2Yi1ik7vXIWCdU7
 Y8M3ZEWxWZyD0BFPyanIx+IdodBkLjeMKQ2O4wH0Na/Du2kZARXYTgh
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

The leds-gpio.yaml schema requires that GPIO LED nodes contain "led",
and preferably start with "led-"

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
 arch/powerpc/boot/dts/mpc8315erdb.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8315erdb.dts b/arch/powerpc/boot/dts/mpc8315erdb.dts
index 1957b6687b2987..f4938a7292b9c8 100644
--- a/arch/powerpc/boot/dts/mpc8315erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8315erdb.dts
@@ -478,12 +478,12 @@ pcie@0 {
 	leds {
 		compatible = "gpio-leds";
 
-		pwr {
+		led-pwr {
 			gpios = <&mcu_pio 0 0>;
 			default-state = "on";
 		};
 
-		hdd {
+		led-hdd {
 			gpios = <&mcu_pio 1 0>;
 			linux,default-trigger = "disk-activity";
 		};

-- 
2.51.0



