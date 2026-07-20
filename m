Return-Path: <linuxppc-dev+bounces-24440-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6606FC4451B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 05:37:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3Tmm0r3kz2yXj;
	Mon, 20 Jul 2026 15:37:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::633"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784525848;
	cv=none; b=Ty7qFuF21HfjvUNT8KelWDKX0GUCBPZ+JW1LLMB51cWcdAZp4UQfpypuIK4OlUy6lwHHYjss0DLI5Y5vQbC3BHgV2KT8Izu+y+YzedHBvUFmuZbI0PvcfOaZ4l5jeSPyrFVAh37oBTdVWgY2Cz/1jvSAcHs76V7Ce7ZAsrnpApvj8duRbnV89VAX0aLMImyaXZCIb/4FybZyxviPx8bODwUADKvs5Zmjmqsx/98xsnfk5hQSerKTSdr2oOy/iQTbOcj9olMLzVhKYqD9I+i+3M16ljRfq8UeMjdfT4uVfFfDfO3xUcP3D4LgwRXCv2kBB/lGl7sI+sSt7TEOSp9soA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784525848; c=relaxed/relaxed;
	bh=i2XnjXP0mGqBGKY9hDxzognSDdDCZFFQuON2AmUxnRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EyaEgaZx3hOGRM2oFgKUV0lA3pa+fwwJb2fHHFaJcuvJJxWHVVNPrOERfHqcwSRb0d6NFNNEwf+jpuRtifcUlGaSnttowwZeTqvhVjL2GdZh0xL8IQsJurBE5cD2ZI15b2jfnHd9iUR69Vk3gr4wRvEYgjp7cPQ3qSOzU64A2zNVgNi2VQtTo3TtCsmo7HUvaS3cQRAuZpR2oTBS8L1EelkchPyFaL57KUZrcGn5LtjCkQFtGbH3xOA3AchYMZf3dLJbby4+DjR3NY7cCtmEU5PyDaffMTquvSrnQDW1+dMFaX0WCgUezmM6b0j54to53K1O37SxKggN/DgoebVzlA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F5BWv4n/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=dmitry.torokhov@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F5BWv4n/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=dmitry.torokhov@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3Tml13cDz2ySN
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 15:37:27 +1000 (AEST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2cad4170e8eso131245505ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jul 2026 22:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784525845; x=1785130645; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i2XnjXP0mGqBGKY9hDxzognSDdDCZFFQuON2AmUxnRU=;
        b=F5BWv4n/R34gN/82nTmT36u4h4+X1xo466yj2sdDaoOpW9W+29x2xs8OfBPuhjQexv
         bE1Dj2r4s2SUsLvvEa6E1C2Fm5+GvJ7MGBDbAGrZVqc6p619SrLqEo5s47rNdBIN0S6V
         TXhQy7mvvE6bq9D1oPym5x7NeSTylOwQYnNr78deGP9XbzTnCya+LNVAXWwdF4G8dPe0
         zrQiUZBAo0K9dfZnxu1KFACeR60tkpf2QNkZTgegHIvO93sWF5YOtEFNkpz5Ikz+OJb0
         TtrC072BqGV8bWgc3V2oqOtRJzN9tRaUORAjaafzus944WlzTwRDXn5eR7ZwKfV21bX0
         zHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784525845; x=1785130645;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i2XnjXP0mGqBGKY9hDxzognSDdDCZFFQuON2AmUxnRU=;
        b=JrIVWLLxiF8TsjEkIIYbAji0S/FfMD84slHMpwhUNb7CYDUyf3lHK/fq/8mszKWXBr
         JpOwrcdc+tpCWngG5YT3uxXVbAU7POpuTAe+eovFaR/A82RC4q6YzhThRGDJVWxD/41h
         iPfKX3ouRpgJuDFeHcRj8A6b6cRnMjSFusnp/xFyw4PVJvfUnUnEHJPHBc4T1qpsS4L5
         v4UVSERiIKOYYjBEECmI/RDrP9CTt9VnWxDdb5celKXgRdJMsUptNrW0n7lvh47nS1XR
         AjLAndej//DOZD889QxgGWHR3yp7phSFIT/NYkLbqDNx4QfWjNoHL78eCa1oa5jFSHqA
         QiVA==
X-Forwarded-Encrypted: i=1; AHgh+RoDq9npXi9LOTYkI4qqShYP1u0/DY6DlyIpyZpU7EAx9JYX1WGnRN7R9CQGQT9QmfwwKCigjOtVjzixvP8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywie48butkbzQYHrS20If+ojaMSz20s4l8ANM/emKVbNeC29tV8
	SNNKuu+xFsFlHboqutCicYKgW5f6H8d0CyLbS3/HtqsSk+DBj2YtjtzP
X-Gm-Gg: AfdE7ckgxvStTUb0gXqNqhNgu1BrnXe80l3vmRlA5BNy7ZKuMf0+HQjM5BVmY9iQ+DH
	aYV6BCndb14gqByvddsiB6wwbS5EI8pmTbDUjpngW3EUTN8BUkL8ZR52Omj/oYBZhG3t6HErM7p
	fgI2wXwHRmiySRTswifBEqUJVzW2EUU3f0u31AtI0+sMPc2Q6WlfiGZxvBLjGjHz+IJBQh1pcKI
	t0qpHrl9EH7RnaoVlWbcHybTGvxxPVALs3K7txLcihRIhoaP0ykegy4KO9Kv39PRSQrqmsr0ahM
	cFa2uik1HxWjunXa8++243eBYjVkdsVtxmIYUDPzPZi8RZsLtw0Gz2CrS3hESDYmSkLf8aBPhOL
	YRihy1h0HPXD9ZnHJVxAbiEPqvZ3vSvs8Ngadt/NhBA2T3sMy7NiQQ2RhrwbUohTZYvHCRSseH5
	9iJlSPN1HmeB/G313hjyO2raEQLLHPl8KX141B4m+EX3TcA7MbBRSg5zHJNmdm+73S9A2ILZBBT
	2lK
X-Received: by 2002:a17:902:cec4:b0:2cc:6329:b7ba with SMTP id d9443c01a7336-2cf34857697mr130158805ad.16.1784525844860;
        Sun, 19 Jul 2026 22:37:24 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:345f:e51b:3d0c:4546])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a20cfe3sm34224663eec.30.2026.07.19.22.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 22:37:23 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sun, 19 Jul 2026 22:37:17 -0700
Subject: [PATCH v2 2/3] powerpc/dts: pdm360ng: Convert ADS7845 touchscreen
 to DT bindings
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
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-ads7846-pdm360ng-v2-2-1198bd108502@gmail.com>
References: <20260719-ads7846-pdm360ng-v2-0-1198bd108502@gmail.com>
In-Reply-To: <20260719-ads7846-pdm360ng-v2-0-1198bd108502@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev-b242f

The PDM360NG board is equipped with an ADS7845 touchscreen controller.
Previously, pdm360ng.dts used "ti,ads7846" as a placeholder and relied
on platform data in pdm360ng.c to override the model to 7845.

Update the ts@0 touchscreen node in pdm360ng.dts to use the correct
"ti,ads7845" compatible string along with pendown-gpio (using
GPIO_ACTIVE_LOW) and interrupt-parent properties referencing gpio_pic.

Note that changing the compatible string to "ti,ads7845" causes the
legacy platform data notifier in pdm360ng.c to skip injecting platform
data, allowing ads7846 to parse DT properties natively. Although
pdm360ng_penirq_init() in pdm360ng.c still runs on boot prior to removing
pdm360ng.c, its direct GPIO register writes are harmless because the
gpio-mpc8xxx driver resets and re-unmasks pin 25 on demand when the
ads7846 driver requests its interrupt.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/powerpc/boot/dts/pdm360ng.dts | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/dts/pdm360ng.dts b/arch/powerpc/boot/dts/pdm360ng.dts
index 67c3b9db75d7..05e93ca294ee 100644
--- a/arch/powerpc/boot/dts/pdm360ng.dts
+++ b/arch/powerpc/boot/dts/pdm360ng.dts
@@ -9,6 +9,7 @@
  * Copyright 2008 Freescale Semiconductor Inc.
  */
 
+#include <dt-bindings/gpio/gpio.h>
 #include "mpc5121.dtsi"
 
 / {
@@ -176,11 +177,12 @@ psc@11900 {
 
 			/* ADS7845 touch screen controller */
 			ts@0 {
-				compatible = "ti,ads7846";
+				compatible = "ti,ads7845";
 				reg = <0x0>;
 				spi-max-frequency = <3000000>;
-				/* pen irq is GPIO25 */
-				interrupts = <78 0x8>;
+				interrupt-parent = <&gpio_pic>;
+				interrupts = <25 0x8>;
+				pendown-gpio = <&gpio_pic 25 GPIO_ACTIVE_LOW>;
 			};
 		};
 

-- 
2.55.0.229.g6434b31f56-goog


