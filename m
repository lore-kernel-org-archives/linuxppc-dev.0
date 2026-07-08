Return-Path: <linuxppc-dev+bounces-23798-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F598C44501
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 10:15:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwDWc6x5lz308Q;
	Wed, 08 Jul 2026 20:15:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783505756;
	cv=none; b=G9WSk3KRUciX6Dr2smXRCLbSZ1IG05ic9n/FcXqanKZDRtyB3iDGwdejL7uU6e3SzN9QuwJNwH4RJvRjIp/uYU2JY1GOCBTJCSFEy+9Jj7mZcH2nvHnXyKecckak0wDbP8lBETbNSCvf1IoTqkMicftv+KnVfOc2ASUcw87J2pvkMWGQ2UOTzKeI31QQS3XZUCfYFOxMjxEDx/5VvWiQOFs+OcVWbllZOsEhxs9hdO2GWq6MqHx+/V98dy/Ruk6OEJ8IsUR4AU/kG1GGa3S4pR7bPCJTR1kzjd6yYA0RWM2LF6ChRfWjvvixgovg/25Elg/B4ZYRwS6c1wjyeEmePw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783505756; c=relaxed/relaxed;
	bh=vK9K/mrLB76x5uzU5c0TcceENMmOeXyS0wuuRlEv6io=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lzexv2kYQIvx84/cMWRl+VNxfW0FVqOWX1yUp/kC3Ksk2/l2mVrmY6JKBGCXdxhEIgm8vUp4cpX8HpgSxVgnNeLVDu1dFb29uHotL3TsudnB9Ly5NkBzFTulRH+bdg2rJR10Lrhj7FvGO2mshNF0nm8o05m5o/uUkoou/jgqTUMYF39IRNnP3a0lUNb61K/AyoeVbx67Vbyty0u8XcwsszRkSWfG2ylFZHy2n4cLD8AOANrWD1VxrvGI3/V09ggSJgAzoLXCHLCKZmSI3QNnBaxct73i4Q7zv2EgZLHr50a4sC1NUUHD02OtsefX4BgX5uQ1S6yqzjmoql0bsth7dw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=SVXDAfn7; dkim-atps=neutral; spf=pass (client-ip=185.171.202.116; helo=smtpout-04.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=SVXDAfn7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.171.202.116; helo=smtpout-04.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwDWc13lYz2xll
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 20:15:55 +1000 (AEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 789ABC8F44A;
	Wed,  8 Jul 2026 10:16:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7B6B960337;
	Wed,  8 Jul 2026 10:15:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C983B11BC3442;
	Wed,  8 Jul 2026 12:15:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783505751; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vK9K/mrLB76x5uzU5c0TcceENMmOeXyS0wuuRlEv6io=;
	b=SVXDAfn7LdRk2SSamjgET8HABd/s1b80AQUUWICbOH38NBWiFzzKEFb2BWVMlzq7xvL+Vo
	UehsT6u0NEaPTvZmj72yc9b4DoR05MoKOi1JLyjoAFRJU9scLwM7Kxhgl/KhWcuXq44sXm
	6I7uirW+qH6aecJwiYX1xrTj63/PwyQGhKV+tzQTDyCiNdRTtuXgSf30fBJYWJzfjZ8BeF
	D5ur0Z7qost66nNRmWwWxwv6PbRM4ywA4XzSK1OhdVVeJSmR4t4Dr8c8cgNMI47awdJJtC
	Xu9lD5bjzAz4ZhbVl8Cr5vEs3F2n4u4OyDSy7+I6CuEk18Gl0x6GA+m7idgp5A==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Wed, 08 Jul 2026 12:15:15 +0200
Subject: [PATCH v2 02/10] dt-bindings: soc: fsl: qe: Set #interrupt-cells
 to 2 to support interrupt type encoding
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
Message-Id: <20260708-qe-pic-gpios-v2-2-1972044cfbd1@bootlin.com>
References: <20260708-qe-pic-gpios-v2-0-1972044cfbd1@bootlin.com>
In-Reply-To: <20260708-qe-pic-gpios-v2-0-1972044cfbd1@bootlin.com>
To: Qiang Zhao <qiang.zhao@nxp.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Paul Louvel <paul.louvel@bootlin.com>, 
 Herve Codina <herve.codina@bootlin.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783505738; l=1330;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=ZEM3vY/Rvni5vUWyO125mYZA67WdP+10qWiVEiSpxQ0=;
 b=oblis8PGfDPelQNzHShpnx1O5nbtJdaQ4wl6aqrmAbUO6DPeEoXYQulxvpdHTKaACO7exVse+
 3PvGSviY4A8BR0Iw1bv6Ad4rRllIJP4ofY/+VB2T2B6QM0aFQuoVbOi
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

The QUICC Engine port interrupt controller can be configured to generate
an interrupt on either a high-to-low transition or any change in the
signal state on the related GPIOs.

Update the #interrupt-cells property to 2 so consumers can encode
interrupt level information.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 .../devicetree/bindings/interrupt-controller/fsl,qe-ports-ic.yaml     | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,qe-ports-ic.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,qe-ports-ic.yaml
index 2b8e7b9c6d7a..2b7c6b4f0389 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,qe-ports-ic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,qe-ports-ic.yaml
@@ -23,7 +23,7 @@ properties:
     const: 0
 
   '#interrupt-cells':
-    const: 1
+    const: 2
 
   interrupts:
     maxItems: 1
@@ -45,7 +45,7 @@ examples:
       reg = <0xc00 0x18>;
       interrupt-controller;
       #address-cells = <0>;
-      #interrupt-cells = <1>;
+      #interrupt-cells = <2>;
       interrupts = <74 0x8>;
       interrupt-parent = <&ipic>;
     };

-- 
2.55.0


