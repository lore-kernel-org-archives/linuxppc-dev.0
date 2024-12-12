Return-Path: <linuxppc-dev+bounces-4037-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DFBBE7717F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Dec 2024 10:06:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y87Rg0fbvz30VM;
	Thu, 12 Dec 2024 21:06:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733998014;
	cv=none; b=FrjPMbL70nPaXzE89MJLJ5qKsq+oLbx3zqvO4jyemg0LETeYXiU6fEl9p9G3p+Lh7XmG1z5CVWy6ToJrrao2ggHMFHSFXLsBR2xAOuOxpetRACcOnA2QVPolgGH4gYKSGOq/La47uGyoFylNcjolNqyFlNq0ESMjI5AUa81JPODEoW0ctRFNpfu4tkxMy+8+cjqFdLhQ5KkNBKm3slrnowSQXixslfOJW31+FhrXRfnDJgdMmGSaNb0OzbRjC0/xntjKg1OtLluT4TDMSdnvgdzTngDSlT6ShMgqA8hEHIrdS7GGqKXWmffkmrbYVSSwXyk+RseNbi8BcD+wY2JKlg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733998014; c=relaxed/relaxed;
	bh=15kpYJEGyM7Ba6x0+bg6oTodDawM+ZCB0XClI5EgXYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QzPsGeDNBSsnASbnr8PPyG/HtTouFsHPZePuXlFbOtb1zbtHdqCUI1QB990er8utv3ET7/UwMYhrdLAOVrdRWVJlzh1hhtqPjetuKwj2Z8Ul5CmRQIKJ3nNI5BQion7ZdFM53zl/HIOREFi/MHdjJqgdLme4ZaKa0RIT2ZIl2zd4h3SlPSvfG7+PlglicEtqu1Afxe6rxKkeWOclcGBUhvNMSh7/h9RoIg0tKIRvP8Jl0u4qPQDt4o+peEiJR+lBeyT+fVkx6d11Vx3lPLxF6oytgfvlxaj75pZe56FbyLa09Xdlbhww4ksSaCZH2drvMQJstklz/OZZp+AdmEa9nA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=tzimmermann@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=tzimmermann@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y87Rc6rtyz2yFP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Dec 2024 21:06:52 +1100 (AEDT)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 84DC61F6E6;
	Thu, 12 Dec 2024 10:06:48 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 412F313939;
	Thu, 12 Dec 2024 10:06:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oPy9Dri1WmeaGwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 12 Dec 2024 10:06:48 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	arnd@arndb.de,
	deller@gmx.de,
	simona@ffwll.ch,
	airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 2/3] drm/fbdev: Select FB_CORE dependency for fbdev on DMA and TTM
Date: Thu, 12 Dec 2024 11:04:44 +0100
Message-ID: <20241212100636.45875-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212100636.45875-1-tzimmermann@suse.de>
References: <20241212100636.45875-1-tzimmermann@suse.de>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 84DC61F6E6
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Select FB_CORE if GEM's DMA and TTM implementations support fbdev
emulation. Fixes linker errors about missing symbols from the fbdev
subsystem.

Also see [1] for a related SHMEM fix.

Fixes: dadd28d4142f ("drm/client: Add client-lib module")
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patchwork.freedesktop.org/series/141411/ # 1
---
 drivers/gpu/drm/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 9abb41da4e3a..55ce61a46984 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -293,6 +293,7 @@ config DRM_TTM_HELPER
 	tristate
 	depends on DRM
 	select DRM_TTM
+	select FB_CORE if DRM_FBDEV_EMULATION
 	select FB_SYSMEM_HELPERS_DEFERRED if DRM_FBDEV_EMULATION
 	help
 	  Helpers for ttm-based gem objects
@@ -300,6 +301,7 @@ config DRM_TTM_HELPER
 config DRM_GEM_DMA_HELPER
 	tristate
 	depends on DRM
+	select FB_CORE if DRM_FBDEV_EMULATION
 	select FB_DMAMEM_HELPERS_DEFERRED if DRM_FBDEV_EMULATION
 	help
 	  Choose this if you need the GEM DMA helper functions
-- 
2.47.1


