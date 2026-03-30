Return-Path: <linuxppc-dev+bounces-18989-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080C5FF493B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 04:17:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkdJ93YVfz2xly;
	Mon, 30 Mar 2026 15:17:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1229"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774843247;
	cv=none; b=cQxayPbFPt57Ap1uFoOmoLDubD6Q+qTxNUQj3zFx6HlqTgmw5Uk86676vkTQBferfvi1X8EMgjxP4kw3quS+3vrm8uqWi++Uu5iIq4rZnLXO9t4SoUnYQJWDSiZNF568bVoSU2jkVaYBizbjtDeVssAdmZQlM4z224Z01Yn3LcgSXQKDX1mllmyk7lM1isqag7AYSusSCUpzGcGDzc5vPgJImt1cFcZwzH6WQB9/kCCsMLBafqDTkjiqtJ4eFsmPqkNWP8gQpa2r06BmFZWKB6A0sOcwsDbUdI1+cpPfvn+TmfzTXKEqCvW6MT6Q3eFp7zxOhAQMLrPhz/WsvcoFOA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774843247; c=relaxed/relaxed;
	bh=2MiznXVnaOQN1Ty0L+R2YmSXm0gykn8v0J+C8W1yOKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KA6hAgUSYplKSuzzgG/7oy+66v3bG+JmRyTk3RYslsnOu6wA7LOz5Lg6dDyw4GsprlotcDcLIGxITirkL82n0QP0VhlpKHBhfxKE1iFiuxTI7gfnQDRVtNMB9zTIZ6WpQrRvTK/80lctDjoQ87taJKmQP8Ny5CCRIdA8xdZf4KY1hOe1tq+lUM/TZGSw+ztbELdggbwSh9TrQJqdiDH5mH3QMmH2pzExc2BLlbAgdAVdkJHYEMIuvTSVKURbBG0paDRaS8Ksy73UNahGBYW2bRADxMa/41WFq+1DVBCoX6z2T0d3wy/OhYPvsyNxTF/SXhJtnL81rPyteqDjuRgtcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mLlH6X5x; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1229; helo=mail-dl1-x1229.google.com; envelope-from=cassiogabrielcontato@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mLlH6X5x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1229; helo=mail-dl1-x1229.google.com; envelope-from=cassiogabrielcontato@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1229.google.com (mail-dl1-x1229.google.com [IPv6:2607:f8b0:4864:20::1229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkcwt20vxz2xlK
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 15:00:45 +1100 (AEDT)
Received: by mail-dl1-x1229.google.com with SMTP id a92af1059eb24-12a74039dc6so2992693c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Mar 2026 21:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774843243; x=1775448043; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2MiznXVnaOQN1Ty0L+R2YmSXm0gykn8v0J+C8W1yOKA=;
        b=mLlH6X5xcqjme+I8sceSmZwbH4H6rz0RMJKWN/dLcMk7kwholzcYLO5q2pA0KPmYtt
         b+ZcwjdO7f/jKC8l9Z1M2VwDD4+sExh6ov/jKw4izTO/Nefz254cGgD315RQfCucv14W
         RfXCt7hMxvLx2gfjfptswdtGe/UP7MHRtd0GX1JPGEvWI6Xa213aOAZaxDbZKpw7uJoU
         kNfaVkyRwkuU1uyVz34EgkS/rL0roVxibYi1jJzM1+ABNEjPY7ZP1k1ugnKMtU9NHC3M
         +2ud+CTMFs2ppCl3XbZ+0mD/OQwxqATEVg5gNG4gzVy7Vsdhu6QYY3ehRQFc60SP1wYg
         EJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774843243; x=1775448043;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MiznXVnaOQN1Ty0L+R2YmSXm0gykn8v0J+C8W1yOKA=;
        b=ptC2lN3IV5P/jeUpM3XiMvXX5vnOyUhQQ97hh/emk3o7xciKRMhQXRA06vhsEGrWOs
         MktzrDe8Yxsl6DWt1Efpk3bspIcMHu0Tkp/fq2jVuxJaTmjDW6d+Un8zZDYZ/jivtyMG
         ipA7jl/kVoLcol5EwvQDS1p/gubLJRpt3rW/Aa3JMclebPC8qfhD+RFMxyEXoAbLDYAh
         5HcaiY6Z5q6eNxz6Gg+H9PwvfFgqkwlecgxE7MDfsOwZtQauezi2ZdRP9nSsGNUUwgNH
         KoRZt4V/dONhZWBnIfyqxW7Fx9mWXgk4/RzzzxBmWauzdGFm0sX0ystEvW7/XUR/5Y0i
         VIUA==
X-Gm-Message-State: AOJu0Yxxx8yl6riFXczVKhQ/XB1/ylDGgvzx9fbKTMg6dCjxt4eQxS0E
	HoC+2EX2x8Pz1j8416rTmNKvfObfPQEigDgHc9hQaOu2lOkJx/ALwDLp
X-Gm-Gg: ATEYQzxFbepr3IMbpKqfRkSP20M/6VRI5MHzUhkaZZUk3bQfjooP0t4Iat0seV1oXoX
	GijRLysU5cKDPRvJEbrbANDshqD1moqM1Pjr+1P+IeEViHnzPzuv5lwUeyFEUyA6H5oC8r0Qnrc
	NFMtU/wyJRyDrntxi9yD0BbtqQNg/5XXfXBeLXBuLzyf5SvapzXah9QKn+9qN4HBZc8Iawsfx8B
	91+vcOILaN2S9w3GNugeny06YMOaC2F4fVDYWK+RGO3+S7DL3cVluKNHsYIfOMjB0tDM5/Ux4F+
	3WUNXtCNAgU9lwh03sliwwBe1hXQk1Vx82C8ihegkfzjFRzfWL9slPBg27xj9DHKRzvRz4OItv9
	c92BWQDghGmpzM0NftaQZD+T3FX27pAd5z94GXQmkumliy+gWsh9niee9oFvc76qbqedgzsrxHI
	47e6UMgDmJPpXoOZ0XK+wOs3H8MHy4vZUvUN79XcXT6gw5DpmhkNs9Ar0KRKvq1KB1uiDp62pyI
	f0IAcoYtrK8aCU=
X-Received: by 2002:a05:7022:6887:b0:12a:8ea4:24d with SMTP id a92af1059eb24-12ab28d13fcmr5818158c88.19.1774843242791;
        Sun, 29 Mar 2026 21:00:42 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-254.user3p.v-tal.net.br. [177.4.161.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab970da7fsm6715590c88.0.2026.03.29.21.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 21:00:42 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Mon, 30 Mar 2026 01:00:34 -0300
Subject: [PATCH] ALSA: aoa: i2sbus: fix OF node lifetime handling
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
Content-Transfer-Encoding: 8bit
Message-Id: <20260330-aoa-i2sbus-ofnode-lifetime-v1-1-51c309f4ff06@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMywrCMBBG4Vcps3agTr1QX0W6SJM/OqKJZFoRS
 t/dqHA23+YsZCgKo1OzUMFLTXOq2G4a8leXLmAN1SStHNpOenbZsYqNs3GOKQfwXSMmfYD3Rwm
 73qOrUR08C6K+f/Pz8LfN4w1++h5pXT/b61n9fgAAAA==
X-Change-ID: 20260329-aoa-i2sbus-ofnode-lifetime-572d49ce3ce3
To: Johannes Berg <johannes@sipsolutions.net>, 
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc: linuxppc-dev@lists.ozlabs.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3170;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=PlmjxGt4JGDRqDssZg/k5xlqGZcdiyv/+rwibqyvJPk=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJknv2aUvCrkz2m7q6S9zJlV0mjjbw39tPLC1LoTJw9F6
 7Lax3F3lLIwiHExyIopsqxOWmS5p+vB1fq4FR4wc1iZQIYwcHEKwERqjzAynF77b78RV7eAssbv
 3Xds3ddcPeUtXO93Nqqg4xfrq2WzyhkZLuyVq/7X+cN3hj5Tt3ixb1ioyod3Pg191cV6F04/2Gn
 GAwA=
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83

i2sbus_add_dev() keeps the matched "sound" child pointer after
for_each_child_of_node() has dropped the iterator reference. Take an
extra reference before saving that node and drop it after the
layout-id/device-id lookup is complete.

The function also stores np in dev->sound.ofdev.dev.of_node without
taking a reference for the embedded soundbus device. Since i2sbus
overrides the embedded platform device release callback, balance that
reference explicitly in the local error path and in i2sbus_release_dev().

Fixes: f3d9478b2ce4 ("[ALSA] snd-aoa: add snd-aoa")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 sound/aoa/soundbus/i2sbus/core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/aoa/soundbus/i2sbus/core.c b/sound/aoa/soundbus/i2sbus/core.c
index 22c956267f4e..833c44c0a950 100644
--- a/sound/aoa/soundbus/i2sbus/core.c
+++ b/sound/aoa/soundbus/i2sbus/core.c
@@ -84,6 +84,7 @@ static void i2sbus_release_dev(struct device *dev)
 	for (i = aoa_resource_i2smmio; i <= aoa_resource_rxdbdma; i++)
 		free_irq(i2sdev->interrupts[i], i2sdev);
 	i2sbus_control_remove_dev(i2sdev->control, i2sdev);
+	of_node_put(i2sdev->sound.ofdev.dev.of_node);
 	mutex_destroy(&i2sdev->lock);
 	kfree(i2sdev);
 }
@@ -147,7 +148,6 @@ static int i2sbus_get_and_fixup_rsrc(struct device_node *np, int index,
 }
 
 /* Returns 1 if added, 0 for otherwise; don't return a negative value! */
-/* FIXME: look at device node refcounting */
 static int i2sbus_add_dev(struct macio_dev *macio,
 			  struct i2sbus_control *control,
 			  struct device_node *np)
@@ -178,8 +178,9 @@ static int i2sbus_add_dev(struct macio_dev *macio,
 	i = 0;
 	for_each_child_of_node(np, child) {
 		if (of_node_name_eq(child, "sound")) {
+			of_node_put(sound);
 			i++;
-			sound = child;
+			sound = of_node_get(child);
 		}
 	}
 	if (i == 1) {
@@ -205,6 +206,7 @@ static int i2sbus_add_dev(struct macio_dev *macio,
 			}
 		}
 	}
+	of_node_put(sound);
 	/* for the time being, until we can handle non-layout-id
 	 * things in some fabric, refuse to attach if there is no
 	 * layout-id property or we haven't been forced to attach.
@@ -219,7 +221,7 @@ static int i2sbus_add_dev(struct macio_dev *macio,
 	mutex_init(&dev->lock);
 	spin_lock_init(&dev->low_lock);
 	dev->sound.ofdev.archdata.dma_mask = macio->ofdev.archdata.dma_mask;
-	dev->sound.ofdev.dev.of_node = np;
+	dev->sound.ofdev.dev.of_node = of_node_get(np);
 	dev->sound.ofdev.dev.dma_mask = &dev->sound.ofdev.archdata.dma_mask;
 	dev->sound.ofdev.dev.parent = &macio->ofdev.dev;
 	dev->sound.ofdev.dev.release = i2sbus_release_dev;
@@ -327,6 +329,7 @@ static int i2sbus_add_dev(struct macio_dev *macio,
 	for (i=0;i<3;i++)
 		release_and_free_resource(dev->allocated_resource[i]);
 	mutex_destroy(&dev->lock);
+	of_node_put(dev->sound.ofdev.dev.of_node);
 	kfree(dev);
 	return 0;
 }

---
base-commit: bea8d9e445caf009ccadc17c353cc82f07885dd6
change-id: 20260329-aoa-i2sbus-ofnode-lifetime-572d49ce3ce3

Best regards,
--  
Cássio Gabriel <cassiogabrielcontato@gmail.com>


