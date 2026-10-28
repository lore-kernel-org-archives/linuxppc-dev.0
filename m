Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AC8606A31D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 14:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AoDSs4yS
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jF8KZ1c1gz2y2Q;
	Thu, 29 Oct 2026 01:06:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793196370;
	cv=none; b=JPfkb7dvIonsUQNtmCUGmt8uE9P6PTu+m33aR3+g0Br4FJI5ME2LQaONsZY2V9JRmlvYQJpERc4p1fSNNV876fxLkmxwoXaCPp0YLYmJOlms5eDPAdmakMM2sCzydYEiQDBC37fONStXFuRVm4P1/LUvbeoa6kcrGBJt/HC60r06schQHgvbYKOx/Z43HrvuWI7Ilq72hRwmsT5lPXeOd7y0bEI0VUVXrdkIvCInIc1aPL4GijsecYBNLVIAt+tt/ZiOrYOpjAgnKxT9iaq8zSGfUb8/OQVX2EalwY47pHniqpGMgnaXU2fm/9jRreNuRVARvL/2VF6Lh+A0k92PRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793196370; c=relaxed/relaxed;
	bh=1oInV8X/kpsTReR0GbICzmQIbB4dJNZpXCGXqUrcWEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GrMwT9rR/BgAIvVYqXWJChCbVM/YZC54DaXwchyVaqxsFh6sNecP6vPyBHEKc+kR23AriKvatI/W/gFeWhZ5r/SX/UvHEOmWLxO8SvdgDa/uXIPyi+K8wnj4Mqv0CmSY8G80z1FpngXAtNQZ+yqwNI2zZW/FOEVhE3L4uJgdfAFhtTIkN7ApBJgnXeKCibygy4vGUUXzJ4qvxZ15VkWM40RlyyL28w8Uhk8qywu6n4zoszo0RPeYGWTVs0SPQXRgT4pCNgHQAXSVl5yUrrsl5+JkbYmlp8wf1+PODZ9nUNO3jlfomBmH0WSWL6YDWZxLCTz4hJiwzrGLzuPFtdEP3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AoDSs4yS; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com; envelope-from=lefteris.koutrakis@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AoDSs4yS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com; envelope-from=lefteris.koutrakis@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jF8KX3wTJz2xlj
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 01:06:07 +1100 (AEDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4a5036bbac7so6626655e9.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 07:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793196363; x=1793801163; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1oInV8X/kpsTReR0GbICzmQIbB4dJNZpXCGXqUrcWEM=;
        b=AoDSs4ySWuJpgchdJyw+vAqF3GcvPeHMzTaJ5i20j5qxGAz69NXfSx+TmPwYhkyJgv
         3mmNP/6PzgXU7AF2hwFjCKxOjfH/rz/4QNJ3nvy8NP+NfjnPOPVy2EG6grSgkYipQ089
         GGn+ZxzT0d2kxxi8Rw4A3E7lSmKbz57oGappGgbrowXcywkeeKJHxV7VVDZVrDb2Lxu6
         HUPpW6xX4ySwz5v0qugVjNqYRLuPGsgEbfeP87aFInoYw2xx90jAeJGjZfE4ajtRYE2F
         PaT45Plk68vmuzfIpW7OWAKy17p6Cfe7DDTwyZnXIRZPJi1QMJw2WVYbGM1qoQMJ0gzx
         yEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793196363; x=1793801163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1oInV8X/kpsTReR0GbICzmQIbB4dJNZpXCGXqUrcWEM=;
        b=vbZh0LOqVr3SkIvhsA4fE9Ji2TEgkb9gSVnLFne/7HHFFHv63ktWqO+NmH5xPlJUgW
         0un4egWCVPZ5zFB6ic5C9t3OxXgO5BfM5Axbx+zNns6vXG/cQSy4b0Xaus+S+Xkx6hrh
         PI6vgfstfErleMI1qerrk4ChPJO+TYvtBNT6NoRxToeo0//+huJHtffJmRYOECYeRsRg
         nZ/5S3uay0uT3YkDGAnC8rsqVfpo+5CIEiYxhTxN2qsXt98giCzR4NQ4jOMr3BuAbFQB
         EB43C5Ikxfbys4SeIAjY5+5GiCsL/B3zoTGmmvqreiA2+S0Q/YorKu9+PlkJbOiJLRfj
         e4tw==
X-Gm-Message-State: AFq9FYIplvtOc/q16tX7RjrzUVB+wScJiwsuO7FG/We+wqOdYG0nW6SH
	TiJd3SvzksDhjQq0gZATNT+f2c5FadjqTKrrSXZ9RjHk5bBDYD6Hy5r2HW/UFxTYOR7cNQ==
X-Gm-Gg: AYBFou28zDjJHVJpkChxtjs39guAkvkeM9yFBoOAeDSw/Oq2SRyauHWVVUsiuncQtev
	0T+ZpN1fP3a2LEx37i79Cy/5yYqwCnhKYfqEhGWRA7NH1422lidlq95VBg5rIrK2Un7B8k3Cm34
	giUtZE9r3mAvomV26nSbPZRYqiEZXPi0uaTQJmiZYKZhYjxRmZ0wV5vOjFgTsBhXp50LHFc9S0E
	uUb287XcfFBNhl6qh/H6nhOCRlj2s+lSaDPDxUrRXmXVlILz8mfwATEqW65WLVVXwKbEHNv0ehT
	b8UXTseogYifsqTh93GPam18Z34PIs/qQ23lkvC6oeyHvCsAoqiWBZzPEdKQcrFhrOMjMZAexZ8
	3tgh3bf85+EGvMsITsHDEG6xs2TcB2Fyl9Pz+l+AW6FbRJvZd9fwDgFQm0U60bLz0BLfvdwR1qE
	hyeOo7/XeXsC32ZCjpvPEG6eY63xRR0DcRNvyrS9T5K2DygYKz68RMpDXsPnuPC9y6QezIsw9pk
	4tRlfyYOBXzrYRM6fZD8ULu7PNMGh+jh3px2yyMz9UJTgg3ub9I4P6EahUqEZf9cRa5UOWXZQwc
	5FQxQI2lKdeWJ2GxMiQl8BfjxkTZKms+CT7WviybrcJDrIv8rlyNfi/1tQZZBobRjbLk6GNhm4H
	gRqa2wf/jwmc3vAdT+dDiksIG67yUvqP7EtI/Ry0yHzdsHCIcBa81MlWvwpS3ah2spya3vdQ8aW
	/1tWsGouWrKkdsVrI=
X-Received: by 2002:a05:600c:5308:b0:4a2:1364:252b with SMTP id 5b1f17b1804b1-4a96855295fmr50429605e9.35.1793196362728;
        Wed, 28 Oct 2026 07:06:02 -0700 (PDT)
Received: from kali (adsl-101.109.242.200.tellas.gr. [109.242.200.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a977edc08fsm45906435e9.4.2026.10.28.07.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 07:06:02 -0700 (PDT)
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
Date: Wed, 28 Oct 2026 10:05:56 -0400
Message-ID: <20261028140556.130612-1-lefteris.koutrakis@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028110951.101614-1-lefteris.koutrakis@gmail.com>
References: <20261028110951.101614-1-lefteris.koutrakis@gmail.com>
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


