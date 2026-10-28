Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E37606A31E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w5KTDDMF
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jF8Q46bjZz2y8p;
	Thu, 29 Oct 2026 01:10:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793196604;
	cv=none; b=O0yE+eburhFq86rncR1mD64imjK4S9yj+s/dccSBEz26FeVOnIiUIMQ8hSD388RHh3OpR7e4o/dA3MYA8Rm1kOebQ8HmxiLaHExxBeIyu15F6pXo9X9sqlpmiTC+V8i1ZOJzlE5CaFYIjuuI3NRO3Ty4XaLHlt6szO2HEW9ATO/s3LXr1IpGh00Db4DiXnyhb0swB1Fk/6cTaaaG3VQsNrZRBHdN9hBBcoosYrvJ3SAkS8as0RcVQuLsnj5g/bJHdaag7wzTtUY43s2bcK50dUnNGEbJFu3sMjnmlHTEwBeqRTzCQ5JGzLgYxvpAM0hXxeQKwbGlJuNeSizuO0HlIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793196604; c=relaxed/relaxed;
	bh=1oInV8X/kpsTReR0GbICzmQIbB4dJNZpXCGXqUrcWEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k/XaOEK+sW+4aL3GuwxMyb6UML1wAW0vsN22Fx+ln8quUICjGTd9l2iv0gCHhmz2SQ0Q4X91zPBx8zenth7deExrf7hYKcGx5BEsDl9E0E5+L3HkX0swHPEzyRhDgvfRNC2ICZgv174TT72FG+MgEqPD/BRhK/mke/WuFKguRcct1lFoxSqMJcjUygExkcNdk2kv0X4RDQcy+L9TzO46K8nM9wOY2Orr7q3nIy4KYXex2MqHDkQGqrJwMziM4QrMqV0mTsdMuj4vumHpqNVr2Bx7mjMIZXpVzl9bVwXBurKf32ShhEUAcZZlbRw/3JmOIW2aFnu8UFP+sfA9Ip6Gng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w5KTDDMF; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=lefteris.koutrakis@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w5KTDDMF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=lefteris.koutrakis@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jF8Q36DYQz2xlj
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 01:10:03 +1100 (AEDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4a549cd7fd2so9655715e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 07:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793196600; x=1793801400; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1oInV8X/kpsTReR0GbICzmQIbB4dJNZpXCGXqUrcWEM=;
        b=w5KTDDMFdbGCiKfwVHU+vO1FNmdjeqCkAih5khTIdL4ve/5WFlC0DioGMdYsBsIWKV
         FhjCclFW3bv353jze/g/yB9IlQo3qPh3+oi2HfVCUXL412fQlPg8ksi6qrQIv2s21D40
         qqtwxyg4ucJIMjL9JkStoXUiHbGYqcz0onzfVHP6V5YjOD2H6Dfmf/hG1Du857hKbxEm
         LurdiUo+XQJzWadnBIt2YtsJtepiBWwOlHSrusdLsCp+nesgUieHnROICCV0RGBzwQTI
         OJTacgDhI6Gql83BgTG7abnnrwFLVObCvLWvqSMXACPQK8t/ti/p71w0j5hKpwB4Auai
         DXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793196600; x=1793801400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1oInV8X/kpsTReR0GbICzmQIbB4dJNZpXCGXqUrcWEM=;
        b=uh980ijwTWIbX8YNIhIuJjQJ6+d2l4npo2ClQWX44RH4LpRAzDw9gdrMoEduhlpbvu
         pxH1RkfzOzjJTIubN++LXJ+92W9D8oQXqg+vaP5l528TE3z4BHq4NHIrJk1dNlfLODnu
         /pLTykiecqwNOKrFyhxMFuWN9Jgw33x24eEx0+3bIvfRE25bcZNRcC/0jeeXuOcP2QoG
         KS8SWVC4IvBQB9e5okAsvLfNHoW7QaUDh+CH+cp9QxsxL1ygitHVpd4lGC64noPDHpL4
         FsQy/I1sSgiiemrt6lL7XbCa5NXDpOKN9+V1dEw0s7fLeaJmq+cJTF6ecVgKftDtVQ0e
         VtuQ==
X-Gm-Message-State: AFq9FYLwt8ov6WlDmohlP474sOnD8y40vqQ6Ic8Us9a591zool+P02Qt
	d/YcCQc3pWQ3NW1VO7tPehiBaEcdUzdaf84SUICCJtIvBzl2LdHXg+leOurVzRBXpDAJJA==
X-Gm-Gg: AYBFou1gV06isPrmVxK8dInDDBrh7Wd6trmRNr9VAb6skD51/Ot7CybbQmZ0Gr8Bgk0
	Vu3fmhYdTTqSdet0LHGjSLsele20c4smYStNfEWKGkoYpSoRigGzDA1CU482Qh0Z/98vj7s14RS
	jpaTRHfWkeuQKmAk6+DxlVfJUgaUpmKSoe57arROIpgg7vk7lAivpuGuguTDYsv/q31TGScxWi3
	189MxaSyJNuqO7IYF6BGdwgQjeJlC78U1Y7jjn5vonR5JHuP9qs9OxGodHp8AxqnM0FWe2zYgE1
	QbkqOmJL2ox4yeXILm0tIbXoYqmgtXHj6XhkOV8GMmyucEuJGecAyD8dPsycTBUMOiIGNlbGGwn
	ZKvmqfh2M600Rp0llQgDSw0ULmbHr85KFcxFyRu4vPs65L8Yglbke+1HY7S9NcMIFeZJ55DI3C0
	BIapHMsGpissktD4cFhcnEmvCemvYT3x0jLu/bJDJcdH0nzjCBSldOKf870y5ePb32SEIiS5uqr
	/oIB9ju9mPi0nxPyecUMBdYxYwdNwa1KNZD661Jl28MYCIVN09fLjrSojT0VyskkR34g9oQyHvt
	Ys7LGNrd/DqmIQagGQeUpgPhFGXsXXmd17ZLTg9HEA4FHWCR2m544wNT23V0koOtjgmWR0lsenA
	jOnR8gboPW8I+MMeDB6VHlAISPWPnyucwSDf6HSe6IqEXcw67lTaEJ+APFHEM3IWwaF35b1zZdF
	wnM+NL0WD9AXJiYK3gE87J0uxiPSvf2uz5kXUX
X-Received: by 2002:a05:600c:27c1:b0:4a1:d291:d863 with SMTP id 5b1f17b1804b1-4a7c385745cmr111726335e9.4.1793196600041;
        Wed, 28 Oct 2026 07:10:00 -0700 (PDT)
Received: from kali (adsl-101.109.242.200.tellas.gr. [109.242.200.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdfb8esm28585676f8f.54.2026.10.28.07.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 07:09:57 -0700 (PDT)
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
Date: Wed, 28 Oct 2026 10:09:51 -0400
Message-ID: <20261028140951.132607-1-lefteris.koutrakis@gmail.com>
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


