Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C31606A320
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 21:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mlw4DkzA
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVs3k0wQSz2yr7;
	Fri, 20 Nov 2026 08:26:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::112e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795123602;
	cv=none; b=iB9Fst6kxEYmKlkpVNrsTnce8Swj62BpbKSFTdh2ZO6BcLDqQSWU6HhUmmP2RlZ567KyND6gUAozRm5fUEk/lrRiWHK5ebdh4aqdZV9J6nBQZJQX7TIexwOojxQ4IuVkC1yjR8ZdEdoxPptv7mcf0xGL54M0/KuZHJ59khfhNo9nEZliIl+R0/PeGFbyi7Exag3ixOsawHUr5qjK4P5xo637z+wD3v5gjey5iI2gvC/Gs1Ox90C4j3uqXR0B+ERYD/PTB7mpC0Fmo7GxSY5V1staU3953N6RebxBdbneRSuXiVVYcIfx0OSfn2NafZ1i1J/b38JKvD3XEy59QqsOCw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795123602; c=relaxed/relaxed;
	bh=vY24YozXGGsZy0MbrhPHZ+OQZbKbtp3K5o/Zm2P/mac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PmGHn8mpbP3sMn99JdeEQogY9plCNClH2uvUXVQjn8vuwg7HK6fwS6qmtwfapyHVeEcXfQbARFNPO9DitcxpxgJDrXUcBlcwWgLQBnqWK/Nv46y/spDWNrlQoW3s+X9xrSpIf7h0b6Zys6kOnppQT0DB+taMzgsOv9PFdJtI5kDzQ9z6ErWI3ms/GBcVW8Y03whrzAKZ5ESnX5y8h1wO6lfCDT1IqSJQ22SyoBuTG19AuoMfY8MevsjuKC6mfMG+IK8zW48f5w0i8AslkP/J2MJj2rbMmWz9U2RXNq0pmDQbMS8vixRpYvWeIEDB95utGATUH68mYnr/K+SGuhDz4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mlw4DkzA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::112e; helo=mail-yw1-x112e.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mlw4DkzA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::112e; helo=mail-yw1-x112e.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVs3j2X1gz2xH7
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 08:26:41 +1100 (AEDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-8b4c2da74c0so1600037b3.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 13:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795123599; x=1795728399; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vY24YozXGGsZy0MbrhPHZ+OQZbKbtp3K5o/Zm2P/mac=;
        b=Mlw4DkzAyynuXUyNuhgteD1rysDLPHmw8PQO0roMSsflT1enM9tYzHVeVVkXiT6DpZ
         WM0ZahTGXRb3A6jJS+KPuxE2Oo1nFuXkA8adPWmdjLyFF6njxklgObJ4sHtfM40uo2rY
         rPIECTAtB7au5MHPXnhLcen/VwncH2cheoppGDm94JmErWbfr9eITBURZgihdxWWX9xG
         J7ccsfXbrcgWwMNK6Da1y8ePEC6d956xV1rmheTuugVM6vw2RWT+oRjoIFnKdvLiU7Oe
         BaU9u/deG729FlxZtXDeGldr4xvht3B6vdIYI9NW5VXAQdI7/jP+FiXdDlJGZGX5ym6Y
         s2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795123599; x=1795728399;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vY24YozXGGsZy0MbrhPHZ+OQZbKbtp3K5o/Zm2P/mac=;
        b=uWzcMG9z+tHg40oYEWS7ctHu3dOauzm/QUy89oHTkbQMN6kve4dBevNJym2VWkAOU6
         D+ZG2DnxOf1Mta5WgWdtq7V8AqpSo8jhBLji2Z0wg/A7LWwWHYXMc8kjmot19v4zwcYK
         eL0pGM0qDQzke8Wv7pZMEOCmxWx5wfgZEMmApN6V/g1EN60okC22PMakBrMsa0TkMGq4
         psAWEBufX6T/YmGSy5oDlylT/zNGi9teMhqNAKsw/pmTtM+lUagtK5MxeI8r/l2mbWUt
         Ptbxnd8HVIwm1M8b9rPdRu6Z2dCpnUjWXKF3tPiE6dzpvFbFH0+6OGyQTZ3Dt+PLDu1Z
         8tQg==
X-Gm-Message-State: APuU4Z8vqgCJ3URJXdoHpI7okBck2EXg8pbzbxQBft/Y57IIwNjbRgoi
	86e8tHzRQjUfReA8s8LAkhDNngCOusCCDZ4RL2GJ5ETY9sOy8iBio15o
X-Gm-Gg: AZFdTZcpD2BUQPyG9Nz/wc3gv3HQ7nWn/KFBfEmPf1X9CSBXTYJDiS9kATtyZPb8MaL
	8vRSG52/AJEc2zCPWCL68+YylaZWx848xX1bSH5VZm5jHgPROiWHz/OkPI4nmx0BABTiTcr7Bqf
	prxuIagms4MP/7No7TIp4RisOnwQZNvhgzAHolyYUnWOufmVgePyn2eg22ZqwcWboucAudAoRBU
	zfQdwAvuq6+wgbrS59nFDHCtjAw7iNnnrkdrSm4BtMzw6PlpgI+okAd6cmLzR8oAmwOvvNT7yFt
	bcUvnRPT0LrrbQh5EOISELaFK0/SCvqWx6WEqQiJQIJ402xE8zd5E0iacdYPlmRWkhsIHpkupxx
	MdWos2y3RwoZPFzdHGGyrpdo2pKACnzZxsGOqR4Wfr1GTP77mdrtZ9A1aJOj7XDzgH72mFTK7gx
	wVXVCtWaadlaGpHGIvvygZEIu+LnNbxSj+XrEa9MD5I9ouMBccCuOscRVHlUmgH8o/BGUjAvss3
	3oECEenKWs6kacu3pt2B0AnhbqCI9Qfu+piVxJHIaoFKkOx56cVcVsjJHzBEwuO/Z8lbzuBaegT
	kza3Z0myAPXjc8G1itCBu47VODJk4fL+gcS7hFsxTk1Y8jtaVEiXRUllTCc1PTo/IkI/PZr/wWr
	NFdCIjpSJBMtt5n3z16HVD7yZfqjaQSdj+BsvAb6+Pg==
X-Received: by 2002:a05:690c:316:b0:8b3:5f18:7f81 with SMTP id 00721157ae682-8b52050fc52mr3650177b3.65.1795123599062;
        Thu, 19 Nov 2026 13:26:39 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:66f3:d5d6:2d12:d460])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b52034f7absm5433547b3.41.2026.11.19.13.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 13:26:37 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 19 Nov 2026 16:26:33 -0500
Subject: [PATCH 2/2] drm/nouveau/dispnv04: Allow PMU sleep on iMac G4 with
 NV34M
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-nouveau-pmac-sleep-v1-2-360c08654a25@gmail.com>
References: <20261119-nouveau-pmac-sleep-v1-0-360c08654a25@gmail.com>
In-Reply-To: <20261119-nouveau-pmac-sleep-v1-0-360c08654a25@gmail.com>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Ben Skeggs <bskeggs@nvidia.com>
Cc: linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2178; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=jUk7WaGILTaMpFlfNkLk0zUgL4/Qx/PtclGtgMowS9g=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLL+Z3ZYpb/48E8ur2630aPo/M74qovXY81+e/7wfLG9Y
 eszTpmpHR9ZGMS4GGaKKbLErVdkmdW2Y6nPaelfMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 IZChYxQPkdNj0MgsLi5NLdJNKyhyyMsvSSzJzM8r1ssvSM0rSC/QS8tMK8nIyC8qTgUaoZeXWmL
 q6uhmZGhgYuloYeZk4Whq4uzsZOjk5ujo7OpkZGluYuBs6WjiamnOwMUpAHPN1XqGX0xMx6zelE
 0P35yvGG3dEMGy8orEjJUFomuu6JspK+/5I8HI0Lom0KPKNuDA5levn8l/2ax5PGOvlOPbc99Lz
 7/RErnizAYA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PowerMac6,1 and similar boards are flagged PMAC_MB_MAY_SLEEP. They
only offer PMU sleep (mem_sleep "deep") once a video driver calls
pmac_call_feature(PMAC_FTR_DEVICE_CAN_WAKE) to say it can bring the
display back after the GPU loses power. radeonfb and aty128fb do this,
nouveau does not, so with nouveau only s2idle is available.

nouveau resumes the NV34M (10de:0329) in the iMac G4 correctly: it runs
the VBIOS init tables and restores the mode. With the previous patch,
the backlight PWM is restored too. Make the call for that GPU.

Other GPUs are left out because they have not been tested.

When nouveau is built in it probes before via-pmu registers its
suspend ops, so "deep" is offered from boot. With nouveau as a module
it is not, because the valid states are computed only once, in
suspend_set_ops(). radeonfb as a module has the same limitation.

Tested on an iMac G4 (PowerMac6,1, 7448, NV34M) with nouveau built in:
one suspend to RAM, woken with the power button. The console came back
with the backlight on and no errors in dmesg.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 drivers/gpu/drm/nouveau/dispnv04/disp.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/dispnv04/disp.c b/drivers/gpu/drm/nouveau/dispnv04/disp.c
index 7d44d18e1b88..b4f522fbaf64 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/disp.c
@@ -35,6 +35,10 @@
 
 #include <nvif/if0004.h>
 
+#ifdef CONFIG_PPC_PMAC
+#include <asm/pmac_feature.h>
+#endif
+
 /* Apple GPUs whose panel backlight is a PWM in NV_PBUS_DEBUG_DUALHEAD_CTL. */
 bool
 nv04_display_has_apple_backlight(struct drm_device *dev)
@@ -330,5 +334,15 @@ nv04_display_create(struct drm_device *dev)
 
 	nouveau_overlay_init(dev);
 
+#ifdef CONFIG_PPC_PMAC
+	/*
+	 * PMAC_MB_MAY_SLEEP boards only offer PMU sleep once the video driver
+	 * says it can restore the display. Resume has only been tested on the
+	 * NV34M.
+	 */
+	if (to_pci_dev(dev->dev)->device == 0x0329)
+		pmac_call_feature(PMAC_FTR_DEVICE_CAN_WAKE, NULL, 0, 1);
+#endif
+
 	return 0;
 }

-- 
2.56.1


