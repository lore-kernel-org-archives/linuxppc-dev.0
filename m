Return-Path: <linuxppc-dev+bounces-24442-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E695CC4451B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 05:37:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3Tmm4dxPz2ybK;
	Mon, 20 Jul 2026 15:37:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784525848;
	cv=none; b=WLFrFJIaqfB9uEtFmiplJVbvxOkj78QVMLLpiNfVghnc2pFnaSZr5/TogNwlcTsbqE28S2uGt0oRz1zpTRgFAWvGA47Pd/zPFnKUgBUB+dDYVBLUkFHd+i3pOjbB+l5WRkktNz5RwOCdWx4nzZeCX+FdGlTfBumu4lWbsL0tt8/J0h5gCGeGtroGrNGnCBbCGz4J2qRxw7+b6wczwSYQ7pVt/zEn1CoWXYToBVFD2uHMgjbceYu48MhHGnsJaK14a6VDiClEAgWLY4BafmXWBVU6rP8gVBXhDo9YYNoLUIEN4LuDz61w0ksXorYNZltR5yhMgxg4MGD6Fm5dSPk00g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784525848; c=relaxed/relaxed;
	bh=pBC9wGN5WcqQqnbJA19I3YxiEUTegSJ8uL/Ced5d0n8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CkpYPdgVGBPiiFEgWbMMtzXDCkuJHGAaU/hrhJbZV/1wbThImtn950p5xXAec2aERoMw5hbcwcHQHSSgVmecN0HKBVCAYScIhVFpG6W5XaMz7WfyFLPDmdWU/KsOWrWBQiBmAOQ85iQ7oZfvbMd5xqHcD74ChpKBMlJF+g8qm6J5MPYCHLs0dYcOesi3X5Utvhp1VjhrcmaHEChDjc5L9FwVsz5IYgwghVT9uGvNaICR4k5+aa0RMiEOUxoswdkxxJpk0ftDb1bJTPxITwpauZ8UYUqhs76fPaZRWiTT57l4I5HJxt1tLoLeC58EMeith9atlsEfUljrPhrGVinjrg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O+3lY4wF; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=dmitry.torokhov@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O+3lY4wF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=dmitry.torokhov@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3Tmk3ffYz2xm3
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 15:37:25 +1000 (AEST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2cce6a0c9c3so87325635ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jul 2026 22:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784525843; x=1785130643; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pBC9wGN5WcqQqnbJA19I3YxiEUTegSJ8uL/Ced5d0n8=;
        b=O+3lY4wFO5k0Qvzt989GXpvMBgQe7Kv32SEwEpCQwiIlX134p4GSyzeXoAL/P+d3Lb
         dnmyMYuHaxF+vXoDdK3/5kE6WHbywPzkqEuVNGw7nIXw+kcmlvOSo9Mw8oWl0lkp0RWM
         dNNhLbkfpRyOW/UM1s6Dv0MPPodayoBLMHIcz+ilu0Yo4+EClLu0IWBt10FSUdhR2rpu
         619RfrPFAJNsQKRDj9e2j+LCSvs063UmUA62qLvSGWnCe/O6/mimxrhFp1k/O7NbVkSN
         Szj3mKWehxgqqwXmOJm81NACWHsI3G3oTUg6JWhLZkszvSQ1CPLG4bbyb1ER8IH6t3Up
         3low==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784525843; x=1785130643;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pBC9wGN5WcqQqnbJA19I3YxiEUTegSJ8uL/Ced5d0n8=;
        b=a4CRerewm31imZh9Silp+zY9Q9iGfiRzSyAyTjNbt39eihZWcalrI5zHW9GCHhU1iX
         8a7drMPMWWS5RrFV9oKti6JcOeTdYxZVmL5IY5mmvhjP9nQ3ENRbxspkO6gzDjoOmF7P
         KaUrNEWaqayScuXb1Z93EzRgpb7SkvGrJTI8DGa6O64GJrtdZfBbIyVuxClcRr7cPao4
         SbRB0tdYDMCq4CjkfOCpfmydmkyZ60TtUPj+XYOu55RiqXbIHJsg76yEwtxIA8aQPZs6
         seHxaXinuTUH56FGYKudlZx/0kam6cPEQ5nFZsRlBlFDxD+lhY7fxiWQg5/sJQ4e4ptd
         pL1g==
X-Forwarded-Encrypted: i=1; AHgh+RrOKfSrYon7E/iwoGFvhd7KS/J+bKllsHhqEuH6WRjazlzinkVjJuHXVou9i30SjYZhFDBQp+ULe7v2dic=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yys2qaO/zFOrb7DxUQaeKJrKTJxgYnQt9E9W5us6vp27pAOquHx
	PoF7KZslJc5brFiUUbpZoo4P0LpWs+iHfexxSccAD6XBxocUKNvggKbh
X-Gm-Gg: AfdE7cm2l4mcMx3/YN3OHzUNBYz+/dI3VxALzL3EO5i9uFLQy8tqiOlND4zDl3UIA/h
	qo/APvG+VZm7zq2q09GFnBwolUULJq3cnXreDDiW3+IF5bOIF8fslQ5X6oSPB/Hkkwae81zNG7l
	+/n7OuUt6HJY+/PN6l1xJkEuVptd4pcczohUtWKae6IKnMGpImpc8j+HFNRn7PjBA7GkZxZO5B8
	VA2oV9oFxzkAGIFpmhoLnbIiNgcHSt7OxK6ixCO4PgSqmcz7nNHPBbFr4adD98KI9MZ7I+2NN/i
	9ppnqwOwRVTP8nfxbUinD9CHnqOSy/gDwwZVrT//exBsiDw4Sn3iKa2SO35J6dVzNJnkULS8SIo
	iOhv0UbXD1AtCZMrmXRwlEzcroetqLii2XhTAhtSN4dm1IkCCyYamZ8Cv3W4LWeTZzca7E9Vdhc
	zV5DWZ+Vg5Dv4QpV9hwQIKYq6NDINujOZqByNOx/9IbHdKxZCxTEbvMjZgtgcocHwcvlMIFNWyq
	eTT
X-Received: by 2002:a17:903:19c5:b0:2c0:db23:4c4 with SMTP id d9443c01a7336-2cf348f88abmr148382425ad.16.1784525843148;
        Sun, 19 Jul 2026 22:37:23 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:345f:e51b:3d0c:4546])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a20cfe3sm34224663eec.30.2026.07.19.22.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 22:37:21 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sun, 19 Jul 2026 22:37:16 -0700
Subject: [PATCH v2 1/3] powerpc/dts: mpc5121: Move GPIO controller
 properties to SoC dtsi
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
Message-Id: <20260719-ads7846-pdm360ng-v2-1-1198bd108502@gmail.com>
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


