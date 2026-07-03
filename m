Return-Path: <linuxppc-dev+bounces-23519-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E9EC43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 20:40:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gsQcn5L8Dz2ygn;
	Sat, 04 Jul 2026 06:40:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783086414;
	cv=none; b=Gngs9RCnOjtPm7/TiezpdL7/nYH9dw7kdHqMMZl9yoNNdcpOTxs1VQc0EqccHXDoUm95J2fQXXGXKmuvImiulzfVluk5XcovqFbP1mkYSYIHss07f8Z1aPru3KaJpdSiHn9nW3z0WWPN+Po/byXGHCnpFVCD6E82YKQ+F7CgVortzXZZE3GUy05BSVzX7ILlirVFYFxEPFLP/Bq/LNuRNr0+nnDrnk6SlKdH4TOzalpaDk5Kx8rdkYRhFCzHJtr2pyd/j+66ldYoJqkxpvYCS6Iomnkn7i6QfL1vO7rWzxIojE6gQ047al/Az71+3iHzvshQfnYL0BZAAZ24faL3bg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783086414; c=relaxed/relaxed;
	bh=Cr2wW8ttzYiYLdwnRKCH/wUeHL21X2WlKudfchK028Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nzMjtH6BQgyfmew8QWMCwjUi7cppk3zZ62ciDULt8c8SKxhaDLVgDlM2kZeyZT/syxKtIw8Qmyb2Kkcdo715lYtT/8Uwew+pLIpXZsZvRoMXN4xdd8KPnxaMZjbTVI20rkPatQ89mC+S4MNUJqsotxEnawOeB2H7mk7dFedIumgjcgBCRKWr7V3irqfZrQkIXOWW/mMLymVxGpJmsTS1QDrzHHyDeNMkYS/l8OB2a6m2ys0OTQTTgaxMlrcFKn8rLZjFKna9NNrwKmvc+RoR1fGRtQ8KVK5nlWvhIzSMsLvEmMbk0Ul07Z295pgH7ZPwH/bXxYZ2kPPiP3jp39m1PA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=pwiLMmfV; dkim-atps=neutral; spf=pass (client-ip=185.171.202.116; helo=smtpout-04.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=pwiLMmfV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.171.202.116; helo=smtpout-04.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsFRK3Y0lz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 23:46:51 +1000 (AEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 27794C49F5A;
	Fri,  3 Jul 2026 13:30:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5649660300;
	Fri,  3 Jul 2026 13:30:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0084D104C956C;
	Fri,  3 Jul 2026 15:30:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783085432; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Cr2wW8ttzYiYLdwnRKCH/wUeHL21X2WlKudfchK028Q=;
	b=pwiLMmfVos4md1Bu88HcdBUVf5qGWEPp+EXtHImzJltQj0BpoqwYKCmceE7FafQ0zTpGgU
	RuteKSOENKSQYPJvGalREy3Ya5fh/Zfver6GQbNcJbqJak6n8epwiHZi8hm5YkhBR07s5b
	tbZgqqI/nXJti7tjbDr9s+azrKIbiwnDKnfAfUEbbWFE2Py9kAPRJtU9EXxngySdHjpE7B
	dUAYG+sAD3D3KJf/CQzkFGicPTFyh1V7uqzu8TgMrvVyTyCXWC8vklej9JB9bJAbCNEbiA
	7UHpvQTvyaFJb2enJrH3hmNYBPapgKWU8kCcmQ7n4kY6RnCgyuVTw5U41rOHuw==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Fri, 03 Jul 2026 15:30:10 +0200
Subject: [PATCH 02/12] dt-bindings: soc: fsl: qe: Set #interrupt-cells to 2
 to support interrupt type encoding
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
Message-Id: <20260703-qe-pic-gpios-v1-2-6c3e706e27dc@bootlin.com>
References: <20260703-qe-pic-gpios-v1-0-6c3e706e27dc@bootlin.com>
In-Reply-To: <20260703-qe-pic-gpios-v1-0-6c3e706e27dc@bootlin.com>
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
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783085423; l=1260;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=mjxqYKQt7RhbTH9annDerlVLtJg9QeVJe4wiCLif0v8=;
 b=AozDGgL99UwYTEj6LEkXlQmiz0Gg/354Iorfp1Ozq7sd2NOOgNJG0V/EJkiVoY+kY2vSgZwWz
 QEjNjJuDVNRD3U3ovwqD8XZ3hbJjRW2RKXKdI2obGbokOJdO/DKYFCE
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

The QUICC Engine port interrupt controller can be configured to generate
an interrupt on either a high-to-low transition or any change in the
signal state on the related GPIOs.

Update the #interrupt-cells property to 2 so consumers can encode
interrupt level information.

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


