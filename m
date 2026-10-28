Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12B0606A331
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 13:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SCXtLiTr
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jF7J339ZDz2y8p;
	Thu, 29 Oct 2026 00:19:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::436"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793185808;
	cv=none; b=fl9Qc46UwHVCI16jppOdrMr3QqmYjs/eVx70aPRHot4MundQph4+AX5CLkeN72eSOAO8MZmBGC43HqwIBbfpXue/nd6fy2VORBMsQgnhEeHkZeThwT90rTEWGlviOzXVW1IqkcuQDUX7mYJHlC9HqC30NWe0ArsuW60Yhaj4EJbfLDNFml42M4bLy2ifZMlJCAe+u1m9bB4YPjFtpIV/wjciBMMurI2vl6lvhQCNqXmnWufDZC7dcKZr2H+LGBo/Lds9EzswVXF/yovLjW7W4bkQzRmvKigbpunN6/hJ3dB9OlflR/4t+bUjosy/YRr0BoV8bqyzSXD91JceLjk2zA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793185808; c=relaxed/relaxed;
	bh=1oInV8X/kpsTReR0GbICzmQIbB4dJNZpXCGXqUrcWEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RFrv0nGTMMiqyBoVn9wDY4sNYzXeqxcF1ZGnhZqrVvE0QN43aU3PYz2YE5tMn5IG36B733CGkpWQXhDS/PcEQwY43lu1ifBkW7NGwL33LvY1ad73KU0oJIFbw8ZZRKezIEXouvax5vAW+7x30tZx6TnuYkzRxw4E1dPIukVtFNsMDtF+We0odvnlm7+no+7OpnIVtN+7wWiNFmU0f65VlBaezj37cRV07P737Yu5M5yJL21rHxPET44LmFyUcHu+m0H78HkUrq20sl11B4Xr+VdoNu7ffawg3DCcNUn44+2Cad9sDOwKdHjFGyboy+C07U32NuRmFqE/u0gz7nyUfw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SCXtLiTr; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com; envelope-from=lefteris.koutrakis@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SCXtLiTr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com; envelope-from=lefteris.koutrakis@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jF4QQ3qb6z2xQs
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 22:10:05 +1100 (AEDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-48e4831c028so692731f8f.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 04:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793185801; x=1793790601; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1oInV8X/kpsTReR0GbICzmQIbB4dJNZpXCGXqUrcWEM=;
        b=SCXtLiTrDRj9B+VUPbxkEg/nkT3G+qtd4pqKRBsbFPkPbo9Iw8lXNpH/RduVGZAuAq
         BiYzDBWnScaE3mM0E7YD9NAg3BwtsdZ0/L2z75cp66nlzqnC3Uvb3kIQwYe0oUl1ttTH
         Hadz1EJbJcNBccFR1cAo1X/ttbtCZGQA0gOPq1HKFNWXlIhsYHHSLy60mc3yVYgiFCrP
         T2DezzGCFkn68IQUzjzRjr1QBoAVxacoJU1d8Mc/4PWt6HJHXaSAoTr7Ahnk77gcUYeJ
         q5j0YSaqUex008lk6A068FOskxg/GzGq4mZ012hZGSnexNOnCQlKUAxcL4kpM6c4DqtM
         jl8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793185801; x=1793790601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1oInV8X/kpsTReR0GbICzmQIbB4dJNZpXCGXqUrcWEM=;
        b=rhE/GeCLhEL4Vm5VhHa50EPUB2X0R0eN0YvRM/BtZS5pypZ3DrLcm8m7r/O+CvcmL8
         UIUnakmK4l3CoWX53xlaopZBNyY7BPvBy8Udf11as/vaZ3h8gnrJtOpRAX/DcCUAxYW6
         Dzp5ZpwFjXCKNixCdvpbI9DHXy1v+UcW9p0S5gMwlFGUXOLO1om+hCOxtHfetTkd9yPO
         ODov5HOVzBbSt/I9r4eWMqDixhjer/CgBQfG+2fP9VV6kRTgLdc9NyfAYxAVdPZ9Hm+B
         i0DtzRKmYluiF2SB9tFeRDUTnJ9nua66e3POkS+5acrG0hGpNqfKuviu3h1GRn6DBMKF
         Pj5Q==
X-Gm-Message-State: AFq9FYLBhWFDx1RMBPUGOA/KtBX3XBiGEXByz5pQBDppgeEh+w5qLULy
	V5/l5+0y0wSqfLR7+wwsu45U98ySOrFZ1Q5R5TBAdkXM0VRKFDY41BzzG3J/flVYxMpSTQ==
X-Gm-Gg: AYBFou2rWIUR1XTrFvWGQWeluoYS+eF4am2gVctehp9OUPiE6UjPHkB6R0SR+U2FHvV
	07535CS90/Art4qOO+EHRMCGdEeKkZTojE5GV+LYwMFXZQc7GTI0z0/5L0yjHKNSpsl4WOD1mzj
	lQID3BHjGd1dtHp6zL3/WJXw5W9vlMHVVvHkHUecHx8UGsmQAR4eRl7bmO2TlbvGi5gtk2I7jep
	Shm9loCXVL9mNsgip0KRk/E/MWWi272i3r5MVJarF1sy+A8UrUwRE/JOV0nlyZ0xddWUn9suHyV
	JEcIatXpHGxGvJKRKYfSM5xLqewrqyD92xzAm6+qCIOEtF+ZXb2RLcOLnajYIZRUOprFZVfXQJy
	FM56LtKIT5t7Z+CilI2Stoc7w0Q3FuMaJ93mLI7h4Pj87FXmSuJ0OMheBvVadUiDt5rLxGCuZhe
	fbWAIlperRrPjxYWzqC0uKy+zZrD/Z4+t65m6W53v3qhstYKPNGVSs7UGKuq0KOWnmcOVqQLEl7
	edW9canqKu/ZWLh6i8r/dGFmKio2FLLZ0gEHEeSwPncpt+zeTvKlHT1x5wOambpzAMKdLf9P3rM
	o+0tlYJZsYZw4gfVjDtR+m1pwmLtSvyuzbUeONYPnEP8Ri1UchFlG6fYlohCvD+Hjq9EXiv4twO
	SDtRZQv5CXWDveTUnB9dvp5TeXLdkLzcpREuc9hxIq5uc+h1VwOfzIoGz5kfAi3dX3ZdpGf1Gre
	TB6XWRWsnlyrCzE74=
X-Received: by 2002:adf:e009:0:20b0:48e:5550:c64c with SMTP id ffacd0b85a97d-48e5d44e556mr3706276f8f.14.1793185800762;
        Wed, 28 Oct 2026 04:10:00 -0700 (PDT)
Received: from kali (adsl-101.109.242.200.tellas.gr. [109.242.200.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3eb8f387sm27760519f8f.4.2026.10.28.04.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 04:10:00 -0700 (PDT)
From: Lefteris Koutrakis <lefteris.koutrakis@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	maddy@linux.ibm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	sashiko-bot@kernel.org,
	Lefteris Koutrakis <lefteris.koutrakis@gmail.com>
Subject: [PATCH v2] powerpc/dts: Add Device Tree for WatchGuard Firebox T30
Date: Wed, 28 Oct 2026 07:09:51 -0400
Message-ID: <20261028110951.101614-1-lefteris.koutrakis@gmail.com>
X-Mailer: git-send-email 2.53.0
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

---
 arch/powerpc/boot/dts/fsl/Makefile        |  1 +
 arch/powerpc/boot/dts/fsl/firebox-t30.dts | 23 ++++-------------------
 2 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/Makefile b/arch/powerpc/boot/dts/fsl/Makefile
index ebbf301e1..0a5c8b596 100644
--- a/arch/powerpc/boot/dts/fsl/Makefile
+++ b/arch/powerpc/boot/dts/fsl/Makefile
@@ -45,3 +45,4 @@ dtb-$(CONFIG_GEF_SBC310) += gef_sbc310.dtb
 dtb-$(CONFIG_GEF_SBC610) += gef_sbc610.dtb
 dtb-$(CONFIG_GEF_PPC9A) += gef_ppc9a.dtb
 dtb-$(CONFIG_MVME7100) += mvme7100.dtb
+dtb-$(CONFIG_MPC85xx_RDB) += firebox-t30.dtb
diff --git a/arch/powerpc/boot/dts/fsl/firebox-t30.dts b/arch/powerpc/boot/dts/fsl/firebox-t30.dts
index 546e98938..6e9ec7f90 100644
--- a/arch/powerpc/boot/dts/fsl/firebox-t30.dts
+++ b/arch/powerpc/boot/dts/fsl/firebox-t30.dts
@@ -4,30 +4,18 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/leds/common.h>
 
-/include/ "fsl/p1020si-pre.dtsi"
+/include/ "p1020si-pre.dtsi"
 
 / {
 	model = "Watchguard Firebox T30";
-	compatible = "watchguard,firebox-t30";
-
-	chosen {
-		bootargs-override = "console=ttyS0,115200 rw root=/dev/mmcblk0p2 rootfstype=squashfs rootwait";
-	};
-
-	aliases {
-		label-mac-device = &enet0;
-		led-boot = &led0;
-		led-failsafe = &led1;
-		led-running = &led0;
-		led-upgrade = &led1;
-	};
+	compatible = "watchguard,firebox-t30", "fsl,P1020RDB";
 
 	memory {
 		device_type = "memory";
 	};
 
 	cpus {
-		/delete-property/ PowerPC,P1020@1;
+		/delete-node/ PowerPC,P1020@1;
 	};
 
 	lbc: localbus@ffe05000 {
@@ -158,9 +146,6 @@ sdhc@2e000 {
 			reg = <0x2e000 0x1000>;
 			interrupts = <0x48 0x2 0x0 0x0>;
 			interrupt-parent = <&mpic>;
-			fsl,sdhci-dma-broken;
-			fsl,sdhci-ahb2mag-irq-bypass;
-			fsl,sdhci-adjust-timeout;
 			clock-frequency = <0>;
 		};
 
@@ -410,4 +395,4 @@ ath10k: wifi@0,0 {
 	};
 };
 
-/include/ "fsl/p1020si-post.dtsi"
+/include/ "p1020si-post.dtsi"
-- 
2.53.0


