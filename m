Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE328606A324
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 21:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OwjsUx2T
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVs3g3sfxz2yTH;
	Fri, 20 Nov 2026 08:26:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::b134"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795123599;
	cv=none; b=nX7feWcFrkl51i1lvepQQzRmqUCvkhktn80wHiC8ojGzlC9emjEzalGDhfeL9iCmkEwecD1BNxQl3C3kaBMtY2sLmKFEB52dmxM1XydWfvFavfezf2GH0tf87yAMlAHe3RchT2Jsd70AHU4VGfhiX7u6/NC5xpnI03JLwhWRIP4R9pLvsyfT1RvSQ0skSLYRvgQLl2hv2CxGAV+qNCU5LXZJr9/KLTvcUTF91fqubJus0FZgZj6u5BoP0WbkPUOfA25sWu/n+278W+r32iC/O4R4pjhl0jwv3p9X3zV9cS+s9No1KKYCt2Avk1Vp+lUDcXDxwnaAr6o0TdujFqH4ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795123599; c=relaxed/relaxed;
	bh=u/T6aa6iCWFrqHcoyuakH1O4XrX3XcHQl1IIpLYEGug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aMU4NjzxqtEYcZ53WhVA7ADjTjDk5/RuyxIzubZqQi+IwjNEQuxqlOewvbVkv8oDiaJ3ulrPeMhVTCfkfhQSQ/Z2jSjbEP5kYDg/mCppggdLOUpkaLOFVBZ/La8EcYi/OR7aa7y+vScCWF9Qt3FLmgZlrZAyQjUPnwQ9pddqVzGNj3muR9wgQ9BlFPzzqbUHntNoKjepHectd1w+l+bYeen4O4chBKPKfZkkZScKZVho8CJtHZHJhZw86NcZ50qKsiHu6MxzfcEXiP1OLZ8EpKJFE8wNIiMSByJnEQnDMDpgT9b/LUglyVTD68cAibISU5SsY2tMkXzyR8v6ynhHBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OwjsUx2T; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b134; helo=mail-yx1-xb134.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OwjsUx2T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b134; helo=mail-yx1-xb134.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com [IPv6:2607:f8b0:4864:20::b134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVs3f5nb9z2xH7
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 08:26:38 +1100 (AEDT)
Received: by mail-yx1-xb134.google.com with SMTP id 956f58d0204a3-67990a45e02so350401d50.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 13:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795123596; x=1795728396; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u/T6aa6iCWFrqHcoyuakH1O4XrX3XcHQl1IIpLYEGug=;
        b=OwjsUx2TauU5RPjGiScar7qCRPmVnAWyn77pgmOx/gQsrFBf1OmX03MxHSDZjBSQB1
         y40u1NFets5Qc5EAHUjhHBFRwdH8uDyvl8cKD1Y6DrgLukkVH1Ioq4IRDpKWvRK2t7dz
         +1VLledaRwazeu4pOHfTGfcwpXoz9dM2SaWUUP8IKnHJKn3udnalTdmXtGpwJ7Gj3xZ4
         UHfjViaNAFOqxZSldlz+bxVGnYim+9+GTWDZWvJfZd5c1IfcyyAfcx+RCCcNykcNviOm
         rCCIaONnoQXjcTLgaRaoRUHr5S6Ckj32wgFTmRG/UWZlpNdrhPY4vgyM1U7Jiiz67X+K
         uS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795123596; x=1795728396;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u/T6aa6iCWFrqHcoyuakH1O4XrX3XcHQl1IIpLYEGug=;
        b=rSnz0sZBmda0hZ7+TwHnQ5C+W0EsCsoz8DU98M5v7jdiXe/JNZHUfKGmBUK/HoLUhy
         S4Oedk0rJMga5caaC2X+lUzy5xM8yGi+IWZZQ4ippMrwZEfZdVAt/YAkwVOCBW+DoiPS
         AZtwZgqWr+qw2VGIB2A4TDvqngVFFPaNhXwUutxJeCJDLj/DdTPbm6Vn+0rIFz95ShDB
         PF+7K1599dC+UAKQrJz257P8Tna4iyJFguNmQ3UVD/LmCcYZH7UfhqaqOerW12s0LSKI
         3YUbIzZ0hf34fAOIUbn05eMgmNyeinh0S8r3ljKgsaDUTBX9TrIsjXfbUHxOOqiRBUuJ
         gdoQ==
X-Gm-Message-State: APuU4Z9X6q8nT0SMn3hxpjWl28g+szcnu5yAMdJY6N7FMfsHlIDmEJ2E
	A2ycLZ8Tjf2lS1SeN4EZZ3xy5q5bGEgYSd0jMTXo+ybciNXhckjmq7GP
X-Gm-Gg: AZFdTZc48sUT4J2/uGT7+hYi4XIvoOPJVMRkQFDmKBa3C18cDd2XkZ/FigLA8slhJrg
	r4myFnVeN1pPBr5vmEwGUAx2eEz9zs1ldjIRMnK8YA/V4xfFKv4QwmZbHQ+Qr1fhkEnzAPMXeHO
	3m4KlKVn4mlVzVDswhSOLUBk7Z1G4oc72sB6QzZY6MPifXXHle8ce38TXacWyakLkEm8J7LVUSx
	m0D4IZpcdmElqqJJH5u0TWnqsJB9Q86ACj6qIZu0TzGY845T9/ePj5XrIprP2NIaMsQbiXTIadP
	LkAkOABTyIo2ai2qnNJ95idS5xFFGKe3M7D1Alf9ihy0Um/x8ctkU0O9DYp9RRBsjrD/VXlo0V5
	PTG+u+EJ+xPRsvEwK+ZMSRhmjMs829i5vbZ45UgrN+Dh6vBukBWIA2trpmhUAYsmI1hYJXIeCVg
	GpTBYI9/IvOoTdOtem3WpfuWXXDA/MWKD4cKJsd5Jl8AJf3KkUmN8kcx7OtdzAvTrMjJkH6B30V
	+iMfAgcnXewr51qFguWjX4DBDFg/JefjyCgOBez/v5B8z40hhbNePlSyf7H8LkxHMwKD8i9N10Q
	K2RAlrrJNlW9JmJlXd+SRL8VWPknRtF/CMJBqkE2P++6gmaPAvVzPWxE3RrTMM3QH6Tj5wNvk6/
	cAKSHB27Tfwe2fWz/G2zLFB9S/OqwUqEbMoE2SILbKbAAap3+uDvvgIZDFmf9m3k=
X-Received: by 2002:a05:690e:1094:10b0:67d:bdd4:e44 with SMTP id 956f58d0204a3-67df44b0b15mr275383d50.98.1795123596293;
        Thu, 19 Nov 2026 13:26:36 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:66f3:d5d6:2d12:d460])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67df338e8fesm658337d50.16.2026.11.19.13.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 13:26:35 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 19 Nov 2026 16:26:32 -0500
Subject: [PATCH 1/2] drm/nouveau/dispnv04: Restore Apple backlight PWM on
 resume
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
Message-Id: <20261119-nouveau-pmac-sleep-v1-1-360c08654a25@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4744; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=uadQHS718gQ/DHTMJAZSo4vKONsVxecudR5BmvozqCU=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLL+Z3asXt6nLdEw84Wu9+Lqyb4fdrte3rwmRutwtxvns
 sAXfFMXdHxkYRDjYpgppsgSt16RZVbbjqU+p6V/wcxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkCGjlE8RE6PQSOzuLg0tUg3raDIIS+/JLEkMz+vWC+/IDWvIL1ALy0zrSQjI7+oOBVohF5eaom
 pq6ObkaGBiaWjhZmThaOpibOzk6GTm6Ojs6uTkaW5iYGzpaOJq6U5AxenAMw1+xYzMnQ3J7f+3s
 5yVrVA4PK7EOX4NXbX09fYRkWnZLN8u65cuI2R4a/M+jMr05lOJaZVOrmsLHhjG96WOOlwXu5y2
 5nWdne1GAA=
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On the Apple GPUs handled by nv04_dfp_update_backlight(), the panel
backlight PWM lives in NV_PBUS_DEBUG_DUALHEAD_CTL. Open Firmware sets
it up and nouveau only toggles bit 31.

nouveau runs the VBIOS init tables on every resume, whether or not the
GPU lost power, and on the iMac G4 (PowerMac6,1, NV34M 10de:0329) they
write 0x7fff to that register. It reads 0x83e60535 at boot and
0x80007fff after waking from PMU sleep: backlight enabled at zero
brightness, so the panel stays dark although the display is otherwise
working.

Save the register when suspending and restore it on resume.

Fixes: 6ee738610f41 ("drm/nouveau: Add DRM driver for NVIDIA GPUs")
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 drivers/gpu/drm/nouveau/dispnv04/dfp.c  |  6 +-----
 drivers/gpu/drm/nouveau/dispnv04/disp.c | 27 +++++++++++++++++++++++++++
 drivers/gpu/drm/nouveau/dispnv04/disp.h |  2 ++
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv04/dfp.c b/drivers/gpu/drm/nouveau/dispnv04/dfp.c
index 00eb2aacbe93..33b5a3398460 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/dfp.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/dfp.c
@@ -485,16 +485,13 @@ static void nv04_dfp_commit(struct drm_encoder *encoder)
 
 static void nv04_dfp_update_backlight(struct drm_encoder *encoder, int mode)
 {
-#ifdef __powerpc__
 	struct drm_device *dev = encoder->dev;
 	struct nvif_object *device = &nouveau_drm(dev)->client.device.object;
-	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
 	/* BIOS scripts usually take care of the backlight, thanks
 	 * Apple for your consistency.
 	 */
-	if (pdev->device == 0x0174 || pdev->device == 0x0179 ||
-	    pdev->device == 0x0189 || pdev->device == 0x0329) {
+	if (nv04_display_has_apple_backlight(dev)) {
 		if (mode == DRM_MODE_DPMS_ON) {
 			nvif_mask(device, NV_PBUS_DEBUG_DUALHEAD_CTL, 1 << 31, 1 << 31);
 			nvif_mask(device, NV_PCRTC_GPIO_EXT, 3, 1);
@@ -503,7 +500,6 @@ static void nv04_dfp_update_backlight(struct drm_encoder *encoder, int mode)
 			nvif_mask(device, NV_PCRTC_GPIO_EXT, 3, 0);
 		}
 	}
-#endif
 }
 
 static inline bool is_powersaving_dpms(int mode)
diff --git a/drivers/gpu/drm/nouveau/dispnv04/disp.c b/drivers/gpu/drm/nouveau/dispnv04/disp.c
index f71199a39bc4..7d44d18e1b88 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/disp.c
@@ -35,6 +35,20 @@
 
 #include <nvif/if0004.h>
 
+/* Apple GPUs whose panel backlight is a PWM in NV_PBUS_DEBUG_DUALHEAD_CTL. */
+bool
+nv04_display_has_apple_backlight(struct drm_device *dev)
+{
+#ifdef __powerpc__
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
+
+	return pdev->device == 0x0174 || pdev->device == 0x0179 ||
+	       pdev->device == 0x0189 || pdev->device == 0x0329;
+#else
+	return false;
+#endif
+}
+
 struct nouveau_connector *
 nv04_encoder_get_connector(struct nouveau_encoder *encoder)
 {
@@ -74,6 +88,15 @@ nv04_display_fini(struct drm_device *dev, bool runtime, bool suspend)
 	if (!suspend)
 		return;
 
+	/*
+	 * The VBIOS init tables, which run on resume, reset the backlight
+	 * PWM that Open Firmware programmed. Save it to restore on resume.
+	 */
+	if (nv04_display_has_apple_backlight(dev))
+		disp->saved_backlight_pwm =
+			nvif_rd32(&drm->client.device.object,
+				  NV_PBUS_DEBUG_DUALHEAD_CTL);
+
 	/* Un-pin FB and cursors so they'll be evicted to system memory. */
 	list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
 		struct drm_framebuffer *fb = crtc->primary->fb;
@@ -126,6 +149,10 @@ nv04_display_init(struct drm_device *dev, bool resume, bool runtime)
 	if (!resume)
 		return 0;
 
+	if (nv04_display_has_apple_backlight(dev))
+		nvif_wr32(&drm->client.device.object, NV_PBUS_DEBUG_DUALHEAD_CTL,
+			  disp->saved_backlight_pwm);
+
 	/* Re-pin FB/cursors. */
 	list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
 		struct drm_framebuffer *fb = crtc->primary->fb;
diff --git a/drivers/gpu/drm/nouveau/dispnv04/disp.h b/drivers/gpu/drm/nouveau/dispnv04/disp.h
index 85ec0f534392..2f84287a3521 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/disp.h
+++ b/drivers/gpu/drm/nouveau/dispnv04/disp.h
@@ -88,6 +88,7 @@ struct nv04_display {
 	struct nouveau_bo *image[2];
 	struct nvif_event flip;
 	struct nouveau_drm *drm;
+	u32 saved_backlight_pwm;
 };
 
 static inline struct nv04_display *
@@ -98,6 +99,7 @@ nv04_display(struct drm_device *dev)
 
 /* nv04_display.c */
 int nv04_display_create(struct drm_device *);
+bool nv04_display_has_apple_backlight(struct drm_device *dev);
 struct nouveau_connector *
 nv04_encoder_get_connector(struct nouveau_encoder *nv_encoder);
 

-- 
2.56.1


