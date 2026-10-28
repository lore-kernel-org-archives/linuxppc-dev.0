Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CC3606A31D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 14:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s8J3x7nU
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jF8bs2LSXz2y2Q;
	Thu, 29 Oct 2026 01:18:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793197113;
	cv=none; b=aB8HOwBwqLWm5k1ATE14pXBYDhrYojFveQGPxOasFWPymCN29bNZRSINUt7Kcb/GJ3RbOoBrcpnA8d8hMWMuTh+SMjBXhRTFEgKuLIafYYvSt8f+sHPhoy37o7Z9Etc8+u87ZetX0UrfrJ7ivfrFWIHFE4qV4xdq1LJhZMALdLL9WCve7NuRw48x5EHjwOINGnUmwc6fwockSypg7W2pT7WdN+zeMt784QUDZPkWkwc0n04danK9fmrAgzn2lZ8weRZrwKlBBNjAyjfR+KXd/BA8tf4onqlc5qAlAK/OVOO5OMdCz4Zd/Fa9k7WQAZV/GU1EbArXppHj8WftsCQicg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793197113; c=relaxed/relaxed;
	bh=1oInV8X/kpsTReR0GbICzmQIbB4dJNZpXCGXqUrcWEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZclgobSCi5vCQSLebsSfohTA2OSDwSIku5eqHbLqEfAqigLuJU9t38wi6EQ2c+5LyR8dYhsuF9zwsyJQ85PFekCzDLVYNDUxtjnG7ulVAQPpKyT459EfqkP7eLh3KQ2lUYs+yBEzgzDM7y6rKK+9Hwimy+Eu3sPMKSqtOwABVAW9Hk+sXoq2HPuFKSxDE7NWWTb/Q6goIw58D0NQZwb6/Bl9Yh6Abgp0D/632bWSmHP5bHiQixRxN2OOmDtATWDofLHAC3CTvT013GjjDSS37HWm7fx6zvSiO/3o3edEhwefFK0uWWF8lO3qMdEWQQrnGIm8RsSCcRrx3qWlwidhCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s8J3x7nU; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com; envelope-from=lefteris.koutrakis@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s8J3x7nU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com; envelope-from=lefteris.koutrakis@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jF8bq62GGz2xlZ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 01:18:31 +1100 (AEDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-48c5358fc28so852670f8f.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 07:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793197108; x=1793801908; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1oInV8X/kpsTReR0GbICzmQIbB4dJNZpXCGXqUrcWEM=;
        b=s8J3x7nUOznAU+znpLVHCb22DOqo7btg03DgMXxGR8pSaokTp3YyldMWQXGxLkAqqt
         LOYzR7LF++jxWsFsaSUvgJfkY5LENW8l3eGyKTVZagkLsNiGWlLb3x6SkIY/P9V9CKos
         OPdLyz77O1bsWBAn06yt2MBSjqQihcydIDRfLPwsMPyr5pZPzfldN7cnGwjghH8cZCgY
         NOpqMQd0jW63iZBLt0Bozf3yNFIXDkpmVUX1XzzJ0U1Jf8NmM6025DSwrxLMPiRWQUj1
         Oc8sM7krleFMWxmIuK2MwWgBR+oVG/FAUnnuKQfTJieju/2AoNoX1yj4LJGI+iIkxBjx
         2/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793197108; x=1793801908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1oInV8X/kpsTReR0GbICzmQIbB4dJNZpXCGXqUrcWEM=;
        b=v1nd1HfaME75B6fq5VKNrzNYn17Jbxz47fP/tbDoflGPg08DVS5cUGzRObYH3i6L/c
         IbNNQuLT7LeYvltEGU3IXSA77Q1MjGn31GvfLDw83ibAxTUxCsXFOG50lFnin6lie1zC
         dXH5DTpRzGFwh1g/xAZpqzQVbO8NUFHwYgVXBXFSKER07GRkcZFfJBHs71TE7F/I3Hr5
         L9GuN98vMWngi5p8c4sKIKDjYWGL+ZXvGZV/NzRDTiD5S4IiEgSO2poTNf0D+z2TDVUK
         XgV5QYU/L/dZmRHn5ejk3TaqKCi8VwG1yHLdBY7SXVBLcwgCNrfr3wIH1SB+n9P0Bs3X
         Ds0g==
X-Gm-Message-State: AFq9FYLBLsaM5B4oPAGM349wPqYTOtyMl1fF5rvBHABlczkNmhxJPXJc
	+pt/uAnfpcSx0+4F3Bt1IMYXdE8bZJNjK3IM8R/658WufeBcisP9OFQKDrGA5F8X+rawQg==
X-Gm-Gg: AYBFou0jFpGKoGAdOU3YyPgTGGD9uKIDfNPr4od9R2Fp+ZAgDXuoZYn+y8Ip6I5iqv3
	Yr1TQlGNH/Y/5JsAoCuD16TJNYStBv7I3S8eX8SwaZ2BSDlDE7kMrqvkX7q/inoyjypbzp/C/tg
	6UUCmpaFFBG49ki++K5vepZU+Te3kCqT1MlCt2vi4P46oqOjYYr+x57A1oK+nyaCmnDuiUf+pz9
	4wTEs2409SOdOo8AzK/cG7O+KKGgImw0eDF+wkKHikGQ4B7capuoZh0LYT/tZ6nYEn4RkDPIdpK
	jwvKPMlscaJt4h1kJLRDluXDq7vbFRhCTUdJNNSTRc0vp0ZrAEqW5Rfxv2zOABXbXdXOK/swcKi
	XYr0NB/XzMlWs54m0FPGZ4gxfojdt7Uvf+in1h7Lddb/tDD8b36+nW/eCLbyv8ipe5F8cNPY0Qv
	gTbFlpxXJ3/SZNVkShlo9DLxCpeHCBBmocr9IDtgAwtwqt0zUoo4tYrXVwMzmY989n9VBw7C3L/
	yiivpV/yWgPzjKo9CMfIqL8KV4BMPYBjgVfx6hZ+xPFVBwd8RHI6/RB+4XoswkVsM4MyM+6GBxB
	jBcFh9SSMk19NymmMC7lZGpp5SRVB37yB3P6/r826nfnFgJoYBdkLBa9Bk9/8khr80r4oblHemL
	G2ss6KuHxOjD315Q775VnRwYLdWqWI6ApNRrKbGFoU+J6imdgHnsfqTpd9j7I6aS2w7rJ3NlBDR
	X0FYwkFMma2NyCz59fg5JLA+w7Pntfwt+ZZwH7
X-Received: by 2002:a5d:5611:0:b0:48e:f10:ceb8 with SMTP id ffacd0b85a97d-48e5d5909d7mr4371586f8f.11.1793197107788;
        Wed, 28 Oct 2026 07:18:27 -0700 (PDT)
Received: from kali (adsl-101.109.242.200.tellas.gr. [109.242.200.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb90dsm27122688f8f.22.2026.10.28.07.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 07:18:27 -0700 (PDT)
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
Date: Wed, 28 Oct 2026 10:18:22 -0400
Message-ID: <20261028141822.136982-1-lefteris.koutrakis@gmail.com>
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


