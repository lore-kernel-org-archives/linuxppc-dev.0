Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C2B606A31A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0U9DKcU0
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jF8Tx5k7Rz2yLY;
	Thu, 29 Oct 2026 01:13:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793196805;
	cv=none; b=UAIsciDqRJt/Cq/ZL7ngsRQRQN1q97Az4sYyABo8VHJAzGcVXRTVaTba4bKvi5s6FDsuSk6geUdIXngqJ+LzffBylaDULJ4EBo9wevpF3Hk7ifwmpxg8XoXKbmC2igWaNn1Hl8Y19Sn3Fbz8njA156k1biurrBUuqR7kDcold6oMLfXLGvi/dv1RrchZtCQ1Elsmnp1dTdxCIC0fiEXsMdTKsjHyDKiXLsmuNPfYbzXUNv/VzLKegmt76UATHJC+QFnR4teT1mz71xjcBu6Hxl1kUjnLCchJ6hoFoPiyLmeo3OkByZhvr85t5NEnjPIZ4X0XXbDyHbxL2RyhYcQLRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793196805; c=relaxed/relaxed;
	bh=1oInV8X/kpsTReR0GbICzmQIbB4dJNZpXCGXqUrcWEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hyUo3p3TlIY7NmmAATIgayxXJbG1tpV9lN17iwRxki154SVIf0MmlsEg0P5dCPQBpJP4Jadb3E8Nm119zdPOBA3VFzIiC5rh7wRH4izuhmB8sHqy49EKoXQREe6x94JKxK7x1QP42klVg6I4VGHrlEW8Pj/aVwiokhEFYYjkkfYYnXTI024D+O0vGX4wODBzG/sBEyxBOXe0r+5hkxPS2xRnVlv2urqWSug8dR79itOwf3QYaMGMsxHFuuBqO6XJuTtRjWgZ3n7+QdvidSyIr/JXAVObOJrJUYphzAh7MiiM9wZxL2ZiOSXEKnDnYzPN6Rb7M2VYmNgfLnXunLFIbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0U9DKcU0; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=lefteris.koutrakis@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0U9DKcU0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=lefteris.koutrakis@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jF8Tn6k0wz2y8p
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 01:13:17 +1100 (AEDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so8232445e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 07:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793196795; x=1793801595; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1oInV8X/kpsTReR0GbICzmQIbB4dJNZpXCGXqUrcWEM=;
        b=0U9DKcU09EEShCLv1ohm7apTn6UOWnrQYAZrJYXL9VSTwMK/hCCikG97m9QlfOQTzI
         rExeE1YB5ViCFU0V0F/ZDAzCE10fR1Qf0I8WQphKmGmDHbOCq1M44ZKS62sHWjATTHe7
         Jf2ghy+p29Ycdgl1EgGUG4Tndx/fATFBcWNuwKDrYesw52m8dIPOHJ7hn3eMLB0jpUP+
         0dPcn0Bxf5ElpGBPtMIsfqMV5zxcGM22RYoblX5/ZXUEHXGTmMP4VJ5LP4o5A7hiChEv
         vWXIP09VZzzbC2YOeCMyJJqt6uiSHklABQNAvG4yc+83hQOlU8yeVYTrFSSS+dZ4xKAI
         67Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793196795; x=1793801595;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1oInV8X/kpsTReR0GbICzmQIbB4dJNZpXCGXqUrcWEM=;
        b=hp0Tfazq9wc9k9p3YfJeACWYGEKPQKzT33W0AWApkqhzGi9qZMe5yPfxifPFwmdB5L
         0pU8MHyi7QdnXE0ekHAkm0xDjrAd4exq4eR9YqliG3otW36uUvKDJ8N3TWUYpT76Dw/0
         8+4K5xgfjJiqrMTQAVVAHvgl0c0jbiXuc7IimV6mXNVdCuPP+yEGzIgla7r975yVp1/c
         J9n8rrFXh9B5eaRzCaZ3Iz9cDaX0BkgdHAguk6SGAbo93RGPC4CdCJLfm2Qlu+hvTt41
         VmkEV/IjDyZQsBfLHVWSq6slAj3FTCtlaGJN8/Ugl7j5YqlDdyuaHCn54pRo2+Valdcc
         SDsw==
X-Gm-Message-State: AFq9FYIF33np+nAUlGvA0iW1k3l7vGIcYpfYa+DdhzbLi2kDOfISlQuq
	UiUzZRKCTYP9Mpd5yWGnzUrgR4pqN1kXe0eMwX81/pdsVyT5q3hzffblfQMAYPh0g38liQ==
X-Gm-Gg: AYBFou2ZmgHr0sLqs3C6+glndHt/lKfLyRKnXW/GxnHRbNQWOwd+TREf84aU+3xqxLD
	yZkhi65Vn4rrth0cyiZM8r+wPqHC3fECmeizy7ycGuR7j+MJCdl82kwvRvSKGQAbhqE6zPsoXu2
	eFlCYG4XX7in78Iy/GaB9SswQhSAbSfOJxpbEvbiNI4Lj8/7iSN2CIyYSQJm281vn35PQGKohtd
	L26Bv46wRIuBP2o19KR9SYQ+PeJ8cOjgsZ/d/noEjkoFR00T4Bu0yzVcpWfWpc+OO1JatPq6rI4
	ULMpT1z98hwomR7uFYjEB4RUEUz1IK0cRyKMotbQjfywlzeiEKNgTE7Ixz0cnQS7OEahs40rZO+
	AQbU/QyPESfFG/IiFn3SUu0P0rwa6h9xkLVNbTcHsiWCnaHoBiOC4TC7n0r0UM3Vn7ipXFnwxwk
	tN+rI4vUJSUI8yDSG+g3c6b9VG+s+Y5FrzkhxtUcxitYbeZFe4tmebtaAuC3P0tXvkuJf4PzSd2
	7wrHp1ynQ4K2aFJGwAOG3zt1Kzojl+DTPOFcKKkIcG3BmL5vKR4tFP4+QM6JePw7iW0qr7gJWHT
	rCi2xCGXS230HTKNhNKghFc5epoBbtOo6cwGLz08I/NZo7bg6HEdANn2VYivxUNYe+ZrxjDEhSp
	vUJ8nqfvE6Zow+iaQshOcawRFeKBrerhugl7WdpDWA9Q2dFOxZ8XTKUwfS/FaTLW56pYvDR8Eys
	hyICaPoIcwUhopj3BGgVom48y600BkT3NDqwOf
X-Received: by 2002:a05:600c:46cd:b0:4a1:ddaa:571e with SMTP id 5b1f17b1804b1-4a96695ec9cmr47593595e9.15.1793196794362;
        Wed, 28 Oct 2026 07:13:14 -0700 (PDT)
Received: from kali (adsl-101.109.242.200.tellas.gr. [109.242.200.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd3555sm28345768f8f.42.2026.10.28.07.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 07:13:13 -0700 (PDT)
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
Date: Wed, 28 Oct 2026 10:13:09 -0400
Message-ID: <20261028141309.134256-1-lefteris.koutrakis@gmail.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
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


