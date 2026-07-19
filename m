Return-Path: <linuxppc-dev+bounces-24409-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE203C44520
	for <linuxppc-dev@archiver.kernel.org>; Sun, 19 Jul 2026 05:23:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h2sVq2ztbz2yVZ;
	Sun, 19 Jul 2026 15:23:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784438595;
	cv=none; b=D5FfnBqPDP1QxLyYanxPgtlnH2WglhRhKs03gTh6ZJG1UVHnIrotYXZPz0R1CyHTyYlkxrtfYBAjfRIH61MwPcnNkmTofmEau99gE3/xukAA0rPjKZUiT5/dgeyzHetx711cHid2mcniS6N1jZHVyKRbGAmWmeIw+ABzT/hNIoyy+otfb14ymcuZH6kRaedM7TU2F59350QaI6xv5dYzPfx2UJeCqRvSu4sf7VTkKVanHwNtiwFWdi1aJgZHtGPKYZjcZno3ebucswQIVsGWCV5ZFYRi43uT9WfWsNIuDn7nYvS/tonR29Ti6rK+KxU3tyKBc34MZxGrOG5OgXOzpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784438595; c=relaxed/relaxed;
	bh=pBC9wGN5WcqQqnbJA19I3YxiEUTegSJ8uL/Ced5d0n8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qk5nSe9860Nk+tDu40zHO8FvobgTJ1ZUzM/az/l0eb7gd/CFjwp35IRzSeaS/l5Oo9EcrdNXFFo2AEhXhxEmCKFc4PHF0uZvLdfoRT/3tQ7bZxSMWO3HhrIJDysIZYN9Ec1PMhGG0o/1aJNc+Y0oD3Lgn7ds3zLAJ8AbQ62wpGlFggPT551HC74m/7k0hE5uSW9/4Ysl1akKtdV8AHf+JKsP24I9dP/Mlf5wwm9w3u+nsQ/zKRrivYAaoOGdcxtTzA1RIlppIQiEB9jSGyEUMuyJQ+C/ZqllulSICBbJXr+rOCoaePTveJjAXvPK7thqSdUvJR95mwoHsqDyji3rXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=enJ/3ijs; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=dmitry.torokhov@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=enJ/3ijs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=dmitry.torokhov@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h2sVp4LGMz2yQJ
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jul 2026 15:23:14 +1000 (AEST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2cace91f112so91726065ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jul 2026 22:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784438592; x=1785043392; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pBC9wGN5WcqQqnbJA19I3YxiEUTegSJ8uL/Ced5d0n8=;
        b=enJ/3ijsGr17nxBB1BWTeQ3rBXXcBzwxPCEX5wKbgi0wf1JUMrh8OVoFhRkdwhcd4t
         K8SpArQ6rJo9kF5mABh32vvVggiTbPuTMOwVc9MNHFe+Luj+D42yRqfV3FpTm7fNh/hj
         bgLKg6p34aiYBdNE86hE3DwSabucAhNta07sd7NmYzckaapdBStcyhTcq2GX0WSU0iwJ
         8/7wnxF1YLB2YDBCulnerFlPl8n2ruZ8gmkv7nauBiWnsg4giJltXkbMfrPFQ1B5jURv
         F4s0qNPz93WcnA0jY2EJ4hqivoenowse4vF61KIjY0P+PCJwqwYiHWMYJ/TQMX+Hpk3p
         bF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784438592; x=1785043392;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pBC9wGN5WcqQqnbJA19I3YxiEUTegSJ8uL/Ced5d0n8=;
        b=FkB+7aVQ9FKCMCcnmtVqbfmTaEkoujRJdGVHMqpCx/8a096lJB3GHqNrqihc00yXjM
         12yB4tIGVZelLBuGHFDXwrmMj6UmOufp+ZwH3mpdxa6YfrH6I20IrzIeQCeZ2PCmv0Qj
         VwHE7ZmmDtUMwd4ZR9MqWtaUBS/T+jmUZ8jh5/G4365u3HbdpVGDj/cYe9RepkcHLGWa
         Ri4VYHeyn25IVoLB71KYUeG91AEDxswjtD++XHT4J5BonQ65jx1TOBwJZcJYLmWE3LP/
         bMQez7z1Q7H805fI6jaL9/XtqT5lmCrL08HYGQdBBBePxPMktT3W0GcQByZeIitvnCPH
         RCRA==
X-Forwarded-Encrypted: i=1; AHgh+RpNBdZc9kGjyP91bghNIySyRwB1llMxbxGFuKYKw05iAt9wKY3LUgfQi2o7IESKSERS1wzui1aafvWHxx8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywt21ZjAbuYvXUOcGG6yJdJp104rCxs8/0HHw99gsA1MksOL2nA
	UwlDVksYKIVBEwwlCRWS3QJAObLQ45+GHgDgufspbDZprEy9wxATAHsF
X-Gm-Gg: AfdE7cl15lvx2pNdXBRw3u6JQqcfWFDJCJ8nzdWT877Hy1Y8CWIg3PDrYR9g6k+rsKS
	XbSFn0BnXXFhtr+wunmy6HxTaWCr2cchB9n6MTa+3PTKR1PKIjbCAUM/P3smVhTvBr8XuWym/q2
	k4COMeK+WLSuRf8EOpwILCBzHF/mDIq7kKxx+cS2p1m+d3O7u6XWGNxCRKBBlRf9mH3gPTuigIs
	n5rlxAyjttlotzAoA+CZIM41qmRAOOoLMNYq9bHT3C8mdfZGaiHT72/t4MaAkfB+JJoGNu9O5YD
	sivrAsKVMl5aL478QGukHkXZbe+6Fqu0v05K61bIUg9vJ6oSj0vC1MVcufC+ns0S3g93vBGNSy3
	bYStoch8I2OMXHHAWV9dZ04ETAmUe0Pa2mEjtPHZtYjgbGGouaFMVPDZO7SZ9ggjUP3EZU2VbfK
	6C+W6CrgFtw3fP/+aREaSlHjaLhzBmT+ebemVhdMV97o5Na04SIdOcBJoRQyi0zbjMfA==
X-Received: by 2002:a05:6a21:828c:b0:3c3:7e9c:e292 with SMTP id adf61e73a8af0-3c3ad7ac45dmr9339204637.25.1784438592174;
        Sat, 18 Jul 2026 22:23:12 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:431d:c6bc:133f:2959])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1bbab9sm25950461eec.15.2026.07.18.22.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 22:23:09 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 18 Jul 2026 22:22:53 -0700
Subject: [PATCH 1/3] powerpc/dts: mpc5121: Move GPIO controller properties
 to SoC dtsi
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
Message-Id: <20260718-ads7846-pdm360ng-v1-1-f318f85cda57@gmail.com>
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

Define gpio@1100 with label gpio_pic as a GPIO controller and
interrupt controller directly in mpc5121.dtsi so all MPC5121 boards
inherit the correct controller capabilities.

Remove the redundant local controller property declaration block from
ac14xx.dts.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/powerpc/boot/dts/ac14xx.dts   | 13 -------------
 arch/powerpc/boot/dts/mpc5121.dtsi |  6 +++++-
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/boot/dts/ac14xx.dts b/arch/powerpc/boot/dts/ac14xx.dts
index 5d8877e1f4ad..05fcf08df1ca 100644
--- a/arch/powerpc/boot/dts/ac14xx.dts
+++ b/arch/powerpc/boot/dts/ac14xx.dts
@@ -148,19 +148,6 @@ clock@f00 {
 			compatible = "fsl,mpc5121rev2-clock", "fsl,mpc5121-clock";
 		};
 
-		/*
-		 * GPIO PIC:
-		 * interrupts cell = <pin nr, sense>
-		 * sense == 8: Level, low assertion
-		 * sense == 2: Edge, high-to-low change
-		 */
-		gpio_pic: gpio@1100 {
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-
 		sdhc@1500 {
 			cd-gpios = <&gpio_pic 23 0>;	/* card detect */
 			wp-gpios = <&gpio_pic 24 0>;	/* write protect */
diff --git a/arch/powerpc/boot/dts/mpc5121.dtsi b/arch/powerpc/boot/dts/mpc5121.dtsi
index a278fb7b9e71..9c5dacb94b92 100644
--- a/arch/powerpc/boot/dts/mpc5121.dtsi
+++ b/arch/powerpc/boot/dts/mpc5121.dtsi
@@ -146,10 +146,14 @@ pmc@1000 {
 			interrupts = <83 0x8>;
 		};
 
-		gpio@1100 {
+		gpio_pic: gpio@1100 {
 			compatible = "fsl,mpc5121-gpio";
 			reg = <0x1100 0x100>;
 			interrupts = <78 0x8>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 		};
 
 		can@1300 {

-- 
2.55.0.229.g6434b31f56-goog


