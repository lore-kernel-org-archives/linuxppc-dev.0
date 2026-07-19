Return-Path: <linuxppc-dev+bounces-24410-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C71C44512
	for <linuxppc-dev@archiver.kernel.org>; Sun, 19 Jul 2026 05:23:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h2sVt1zQ6z2yQJ;
	Sun, 19 Jul 2026 15:23:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784438598;
	cv=none; b=kOPTZAmhQyo02Vy0lzG0G8yZWeApHMAtlYrMvGTaKSzS3LXnGHyY7ADMj2gOpc7TBns/d25+6GiwBiTLnvSaikTHeVpXYFmxJLe7qhc/VuXczP8ymVru2qcgDIvFdZpO74XlS8Nmv0tFskkbhTcaDUxUjrD5gIUbOazrFht6qxOa2oGELci+1ugg1M3BLWRNSeN/JKg/nofr9iUjKGG8nCd8T5dVM564KlEp4LUWbrBCD1tmdj+wEDtiLApN0PcPF06et7RxL75nYPtp5qPrW4I00OFB4YXM0tSY/DG2+Wsh8AGX1vSp0iRjPwaP1rpfX96IFvdN2BnqT2PmyOPTGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784438598; c=relaxed/relaxed;
	bh=uRQCIegzFaWRZA4UwAIm9D6G7unV/p/CvWpguWA3kC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n6sfnRWrrWpQdsac7dbhzP/f4gdHWlY3UH494gxmQTuLlEHRpCGinD9U4HIctR8SXGMuiyAIBjiz1u/e2QJ/pHRs2oMtBiUdaGgJy9RbYsz7gv8ScuNZSlbvbbihca1g/d34/rPWaEsb4NadYsHK/VdoMFiUlBkUVBuF/J4HoK2lSRVKUuVNRvgPwL6xyMja4vmWQc6sK42eJJYV/OH2RO1fk5Rxjh79xXPnuIqhQGY8QW06y/Hye98cd3LssjbhrWvQGcWxZrgaESytW9d4x9RKq4YrIWfdHL+brMzpnx1QBpHEd/G6gCUVv0j5ajak7gkN+KV+dcugORDSs0bdiQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MG2G+Ifb; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=dmitry.torokhov@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MG2G+Ifb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=dmitry.torokhov@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h2sVs4WwPz2xyh
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jul 2026 15:23:17 +1000 (AEST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-c9fe3c9bd5fso1754406a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jul 2026 22:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784438596; x=1785043396; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uRQCIegzFaWRZA4UwAIm9D6G7unV/p/CvWpguWA3kC8=;
        b=MG2G+IfbSqw6JW+DafoGWfoIZ8TYaucBvTuk0uVwv0eQP14tSaHjV8vB9d+I+jqCmb
         eo4FAssbv6c8ghcMysaJdRtY80VtzPSWNj3RiinOrLN1AScQyzDxoR/qve8qvykFJnTe
         nE3H29RMjEr+lsGOixehd4hs2nUhAu325vr60hOapgIeKjsN7HgeZLhBVinBVGluahIC
         8cR7UEXGNUEIEaX1roAux4aS7oT7M/yemMcxXPn22W9uFPexgDlpFk93akKOMK30e8by
         NHrzZ0dMKUj7Rutr4dhrjXzFmiEl03pKIkOpym8ic22bW3gOdBua+L+fCP9eyn7/uPO/
         xW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784438596; x=1785043396;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uRQCIegzFaWRZA4UwAIm9D6G7unV/p/CvWpguWA3kC8=;
        b=gBUxbcdcZMpJSX/tTNDKWI0ippkPMcuOk5W6H6gSjW+sRJTFdWAIRtbv2b5hGaN6Hs
         iaiKUqR+nj0uCdJfvM73gpI9nN9/r/DsaiTi5d6GSqJIEW/KtahibBEiSx+hc+20i5CC
         vsMnE+4pftAiCzW3ifczjBAdgajd/8B9/uyNMAsybR/HLUcS8MTwMT+GUvfNvtTK6hbo
         hfV6dSL3cKdmITJVTlZoruikiC6/v9J7iduHIj56Ip9ZAK1GIw3mX6rXxOUqcy7Vi4qy
         OfknqOCyyMo8nm2jnVMp1BiBh/1TQ6pN3SH3N0uSO77kfhUFmBqEFu3E7cMZdgq8V7Y/
         kSZA==
X-Forwarded-Encrypted: i=1; AHgh+RroompFjKW9z8ioivzVh8UwZxs0WYUY+2Is46aexe81hLNC6wFGr1f+IeeAKF4hqkOCgDy/Pa0JWWEJsXk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx4xo6CKLr5VUG2TFpYHt75bRZnjj9f5NF6kZdkFDpIKvWYTtDK
	f9Z2lYWco20jy0Hnf06+5s73J/EO3iZycmmb+1xqRA6FZyj/HcmuUmvJ
X-Gm-Gg: AfdE7ckcF0kCPEfGTFbCLvr0MJ+TZLn5I2BhqnbSLoo3FCPsXoeqwc9QcIrhjin8H2e
	/Lkfs50a13xqzLLPTnPoLAUM3ApH+ftUU9GHYE63P/bFF1sTiu02iNzkJf1cz9w3cb5xRGPuPGL
	v1hhsNyjundjH0l6XwEEwO+V8K52V+k1ZF2P5EwV4Pk1q1zzltz/u3z9TVmeYeHou96pIi6s93z
	DQBR4dJq0jDKz6EuSveIieVup44tW7pBhkcqnp0C9N8YmRj1WVf0lbUTNPObhYzkRByxMNpzqZl
	Uhb1WvTjJ0kcMRDjcteGJf0BF4l0aomJas+SMpExgKjBw8ik66z2oMcSQsB2liSDndHLtvmflID
	DzapDUk/oHz3D5mdb1v4sQRYoqBg/kh9rONMImA/v2461j+RzM7V2iOMqCQ/CyVjvAf5+MgSOTi
	zMOXePKWK86aqClxkz4/CtRTkC5MFq/MTGvjVH6LeP4tJizpgQLcrWeN+1/Ebr1J+H2w==
X-Received: by 2002:a05:6a21:1519:b0:3c3:7195:fd47 with SMTP id adf61e73a8af0-3c38db2d82emr15103340637.24.1784438595677;
        Sat, 18 Jul 2026 22:23:15 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:431d:c6bc:133f:2959])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1bbab9sm25950461eec.15.2026.07.18.22.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 22:23:13 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 18 Jul 2026 22:22:54 -0700
Subject: [PATCH 2/3] powerpc/dts: pdm360ng: Convert ADS7845 touchscreen to
 DT bindings
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
Message-Id: <20260718-ads7846-pdm360ng-v1-2-f318f85cda57@gmail.com>
References: <20260718-ads7846-pdm360ng-v1-0-f318f85cda57@gmail.com>
In-Reply-To: <20260718-ads7846-pdm360ng-v1-0-f318f85cda57@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Anatolij Gustschin <agust@denx.de>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev-b242f

The PDM360NG board is equipped with an ADS7845 touchscreen controller.
Previously, pdm360ng.dts used "ti,ads7846" as a placeholder and relied
on platform data in pdm360ng.c to override the model to 7845.

Update the ts@0 touchscreen node in pdm360ng.dts to use the correct
"ti,ads7845" compatible string along with pendown-gpio and
interrupt-parent properties referencing gpio_pic.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/powerpc/boot/dts/pdm360ng.dts | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/dts/pdm360ng.dts b/arch/powerpc/boot/dts/pdm360ng.dts
index 67c3b9db75d7..69d8b6a0241c 100644
--- a/arch/powerpc/boot/dts/pdm360ng.dts
+++ b/arch/powerpc/boot/dts/pdm360ng.dts
@@ -176,11 +176,12 @@ psc@11900 {
 
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
+				pendown-gpio = <&gpio_pic 25 0>;
 			};
 		};
 

-- 
2.55.0.229.g6434b31f56-goog


